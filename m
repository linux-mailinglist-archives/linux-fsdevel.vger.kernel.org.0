Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4A25C278
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgICO0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgICOX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:23:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27AC061258;
        Thu,  3 Sep 2020 07:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rSb0BL01Ey1fqtHAuOSKbe3w6r8nDxlokUvLOIV+cDE=; b=KT+oozOcmlzKunmiiHT+7RSbLJ
        gavWA9RkFz1P2aj1gpddXMWCOPrlOgFZgn4hA6S1M4p8FygVV8uLc6oVLVdIdzudykwHVoOkF2Wzp
        y4CN6+hoansmAFrPY6AcwRlPW2AYCFAG2hVuPOCHgYk9sMriwkwFnPJiKXXa/+f29JxRVYESVJilJ
        yro5pzGVFiYakxduDdi7cG5eLmyL8MSiW3yaSWrBYgWmOz0MpQKOhV3qjfYYYQRIUYzeTH/kA9Ou6
        ke5i0/VMjflVHFxMBa1jtGpOoAqFVtzP5nH9zYLeue3nJYnASu8pHhLeNb2npgfemID2x+DEVJ+Pe
        P43farcQ==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDq8U-0004aE-Co; Thu, 03 Sep 2020 14:22:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/14] proc: cleanup the compat vs no compat file ops
Date:   Thu,  3 Sep 2020 16:22:30 +0200
Message-Id: <20200903142242.925828-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
References: <20200903142242.925828-1-hch@lst.de>
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
2.28.0

