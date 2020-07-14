Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B388421F6D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGNQM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 12:12:26 -0400
Received: from mail5.windriver.com ([192.103.53.11]:52440 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgGNQM0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:12:26 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 06EGBTsF000671
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 14 Jul 2020 09:12:16 -0700
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Jul 2020
 09:12:05 -0700
From:   <yanfei.xu@windriver.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] userfaultfd: avoid the duplicated release for userfaultfd_ctx
Date:   Wed, 15 Jul 2020 00:12:03 +0800
Message-ID: <20200714161203.31879-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

when get_unused_fd_flags gets failure, userfaultfd_ctx_cachep will
be freed by userfaultfd_fops's release function which is the
userfaultfd_release. So we could return directly after fput().

userfaultfd_release()->userfaultfd_ctx_put(ctx)

Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3a4d6ac5a81a..e98317c15530 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2049,7 +2049,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		fput(file);
-		goto out;
+		return fd;
 	}
 
 	ctx->owner = file_inode(file);
-- 
2.18.2

