Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C233C8586
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 15:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhGNNuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 09:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhGNNuy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:50:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 998F1613BE;
        Wed, 14 Jul 2021 13:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626270483;
        bh=vp5bXzXlnCDxY/OLVr7ZLCC70W2Er4KbPTvly6fC8eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1F9m75Veld9IhxIiskErUdfRJx/tHSn/Xt2Gpjb6B2M07z0iJidmT1LER/cn8e+c
         Dic6lVsKzoRoP6VMOR0mfWFnQrHNock6EaTNeGAci7H0wmYSlJbL2qDpOvqOGfEwv1
         3xZC9vLB7F1nDbscEEW4OdBrZu7IJRa53Vi2O7gTWxLIGCcH0hG6KOmDOHcwscgE2H
         NUv9AZPDZNuXv+RmLGyXgr6VoW2MxfITbckI2l2AFLHcT9Y39TO7/OJ415+xEm3QMc
         AETndup64IIsghIqKetcRUO0XC5pRVxmd7vKq79gxR/btu47PRenXOTJ/DK4zPIbsh
         AuEhD2fMcfgoQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com,
        stable@kernel.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: [PATCH 1/2] cgroup: verify that source is a string
Date:   Wed, 14 Jul 2021 15:47:49 +0200
Message-Id: <20210714134750.1223146-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <https://lore.kernel.org/lkml/20210714091446.vt4ieretnkjzi7qg@wittgenstein>
References: <https://lore.kernel.org/lkml/20210714091446.vt4ieretnkjzi7qg@wittgenstein>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566; h=from:subject; bh=12+DNVCz6V74ceolxYGLmdvTW/UekPMGixUDyW+L3PU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8e814IFz5c40mu3nerx+Jrnu6Q7Zqr1vx1tX63F5Wtnl+ XDs6O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCt43hv8f5AiOm/GnLlOOUC+fevm jh0D+VMffl3BtbSs5sywxpl2Rk+LqoTuf91hkTniQZuB07rqvwrOYXa0Ufwwom6TKX174TWQA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The following sequence can be used to trigger a UAF:

int fscontext_fd = fsopen("cgroup");
int fd_null = open("/dev/null, O_RDONLY);
int fsconfig(fscontext_fd, FSCONFIG_SET_FD, "source", fd_null);
close_range(3, ~0U, 0);

The cgroup v1 specific fs parser expects a string for the "source"
parameter. However, it is perfectly legitimate to e.g. specify a file
descriptor for the "source" parameter. The fs parser doesn't know what a
filesystem allows there. So it's a bug to assume that "source" is always
of type fs_value_is_string when it can reasonably also be
fs_value_is_file.

This assumption in the cgroup code causes a UAF because struct
fs_parameter uses a union for the actual value. Access to that union
is guarded by the param->type member. Since the cgroup paramter parser
didn't check param->type but unconditionally moved param->string into
fc->source a close on the fscontext_fd would trigger a UAF during
put_fs_context() which frees fc->source thereby freeing the file stashed
in param->file causing a UAF during a close of the fd_null.

Fix this by verifying that param->type is actually a string and report
an error if not.

In follow up patches I'll add a new generic helper that can be used here
and by other filesystems instead of this error-prone copy-pasta fix. But
fixing it in here first makes backporting a it to stable a lot easier.

Reported-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: <stable@kernel.org>
Cc: syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/cgroup/cgroup-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index ee93b6e89587..527917c0b30b 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -912,6 +912,8 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	opt = fs_parse(fc, cgroup1_fs_parameters, param, &result);
 	if (opt == -ENOPARAM) {
 		if (strcmp(param->key, "source") == 0) {
+			if (param->type != fs_value_is_string)
+				return invalf(fc, "Non-string source");
 			if (fc->source)
 				return invalf(fc, "Multiple sources not supported");
 			fc->source = param->string;

base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.30.2

