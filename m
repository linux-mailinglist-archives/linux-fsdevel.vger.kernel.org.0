Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA957217576
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgGGRsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgGGRsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33535C061755;
        Tue,  7 Jul 2020 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NA8lGOC4BC4BRu8ev38I4oygB9glKOvDb9c92iDVn1E=; b=lCeLmb3suH99pmI4X62B5drqwA
        skczlsEs84laHHAjzSZxxIU1lj5lkgaZnsQufQV5oNCs7YmlGFZSbWS/9NXYYCc7i+Y1TdwMyKHxd
        DAJ4gI9vYovb+nxyuo1L5n8DNSlkJdQCYuimkIe3Tukah4QcodtAywbWWrd7rp1wOezvaWKDeMVSB
        fSGQoGUvGk0kPFIusTE0bHnu7+v7xSkfEHzTVOL7FKcE/vHTSTI9ogb1z9f4uq7BIsq/aNDV4PrSg
        dVxeQEI4W4gKTGUzZQ2HPklSAIeK8I3UfZBX5qkkpX7Dr8LUGXei+nIEdfVH5L+JTnfwQIg1tXViv
        9NIbfKwA==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhk-0003LU-0Y; Tue, 07 Jul 2020 17:48:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/23] proc: cleanup the compat vs no compat file ops
Date:   Tue,  7 Jul 2020 19:47:55 +0200
Message-Id: <20200707174801.4162712-18-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of providing a special no-compat version provide a special
compat version for operations with ->compat_ioctl.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/inode.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 016b1302cbabc0..93dd2045737504 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -572,9 +572,6 @@ static const struct file_operations proc_reg_file_ops = {
 	.write		= proc_reg_write,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= proc_reg_compat_ioctl,
-#endif
 	.mmap		= proc_reg_mmap,
 	.get_unmapped_area = proc_reg_get_unmapped_area,
 	.open		= proc_reg_open,
@@ -582,12 +579,13 @@ static const struct file_operations proc_reg_file_ops = {
 };
 
 #ifdef CONFIG_COMPAT
-static const struct file_operations proc_reg_file_ops_no_compat = {
+static const struct file_operations proc_reg_file_ops_compat = {
 	.llseek		= proc_reg_llseek,
 	.read		= proc_reg_read,
 	.write		= proc_reg_write,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
+	.compat_ioctl	= proc_reg_compat_ioctl,
 	.mmap		= proc_reg_mmap,
 	.get_unmapped_area = proc_reg_get_unmapped_area,
 	.open		= proc_reg_open,
@@ -646,8 +644,8 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 		inode->i_op = de->proc_iops;
 		inode->i_fop = &proc_reg_file_ops;
 #ifdef CONFIG_COMPAT
-		if (!de->proc_ops->proc_compat_ioctl)
-			inode->i_fop = &proc_reg_file_ops_no_compat;
+		if (de->proc_ops->proc_compat_ioctl)
+			inode->i_fop = &proc_reg_file_ops_compat;
 #endif
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = de->proc_iops;
-- 
2.26.2

