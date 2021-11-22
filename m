Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B26458C19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 11:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbhKVKQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 05:16:17 -0500
Received: from foss.arm.com ([217.140.110.172]:39460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhKVKQQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:16:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 508451042;
        Mon, 22 Nov 2021 02:13:10 -0800 (PST)
Received: from a077416.arm.com (unknown [10.163.54.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B7303F73B;
        Mon, 22 Nov 2021 02:13:07 -0800 (PST)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2] fs/ioctl: Remove unnecessary __user annotation
Date:   Mon, 22 Nov 2021 15:42:56 +0530
Message-Id: <20211122101256.7875-1-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__user annotations are used by the checker (e.g sparse) to mark user
pointers. However here __user is applied to a struct directly, without
a pointer being directly involved.

Although the presence of __user does not cause sparse to emit a warning,
__user should be removed for consistency with other uses of offsetof().

Note: No functional changes intended.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
Re-posting v2 with minor commit log changes for v5.16-rc1.

 fs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 504e69578112..1ed097e94af2 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -430,7 +430,7 @@ static int ioctl_file_dedupe_range(struct file *file,
 		goto out;
 	}
 
-	size = offsetof(struct file_dedupe_range __user, info[count]);
+	size = offsetof(struct file_dedupe_range, info[count]);
 	if (size > PAGE_SIZE) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.17.1

