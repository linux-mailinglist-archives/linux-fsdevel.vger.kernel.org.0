Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B605ED06F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 00:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiI0WvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 18:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiI0WvW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:51:22 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653A8B514A;
        Tue, 27 Sep 2022 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ghXeoezRz4d8R4AvBSjdpIP7PjIfIhpYflaJIHywJ8o=; b=C4Z0mmyqMNXlvu3wK+WIcxHLO9
        DlBYoy088vRR8/tLmAtXVFs0o4oyM0yieULnqVB51LquKPGpFDhuTgnMqCaYrLIQvUDSoOS5x4Tze
        9Bzd2aNMjz0snfvmD84Zx+t3I4c+9IFOB9dM88DRsVX0GeEaMp44afLc5/F+ywD+M1RYs3TTQUZoE
        aGAkWt1sv/GT7m4alV6psywJ7oqhIFtNAam7rHDeJOMxrNppBV8Qmx4ihk6kjrZ5XjLnzhXlC2HWf
        LIenSFeuipaQBoSt9AcFpiTJ/1V3lZRUbNdBB/sIQ0hoTHMyv1zJykb82JoSeAVP5WRdonBSeu/LQ
        MlMbvzNg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1odJQ5-004TzN-0y;
        Tue, 27 Sep 2022 22:51:17 +0000
Date:   Tue, 27 Sep 2022 23:51:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH][CFT] [coredump] don't use __kernel_write() on
 kmap_local_page()
Message-ID: <YzN+ZYLjK6HI1P1C@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[I'm going to send a pull request tomorrow if nobody yells;
please review and test - it seems to work fine here, but extra
eyes and extra testing would be very welcome]

passing kmap_local_page() result to __kernel_write() is unsafe -
random ->write_iter() might (and 9p one does) get unhappy when
passed ITER_KVEC with pointer that came from kmap_local_page().
    
Fix by providing a variant of __kernel_write() that takes an iov_iter
from caller (__kernel_write() becomes a trivial wrapper) and adding
dump_emit_page() that parallels dump_emit(), except that instead of
__kernel_write() it uses __kernel_write_iter() with ITER_BVEC source.
  
Fixes: 3159ed57792b "fs/coredump: use kmap_local_page()"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/coredump.c b/fs/coredump.c
index 9f4aae202109..09dbc981ad5c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -832,6 +832,38 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	}
 }
 
+static int dump_emit_page(struct coredump_params *cprm, struct page *page)
+{
+	struct bio_vec bvec = {
+		.bv_page	= page,
+		.bv_offset	= 0,
+		.bv_len		= PAGE_SIZE,
+	};
+	struct iov_iter iter;
+	struct file *file = cprm->file;
+	loff_t pos = file->f_pos;
+	ssize_t n;
+
+	if (cprm->to_skip) {
+		if (!__dump_skip(cprm, cprm->to_skip))
+			return 0;
+		cprm->to_skip = 0;
+	}
+	if (cprm->written + PAGE_SIZE > cprm->limit)
+		return 0;
+	if (dump_interrupted())
+		return 0;
+	iov_iter_bvec(&iter, WRITE, &bvec, 1, PAGE_SIZE);
+	n = __kernel_write_iter(cprm->file, &iter, &pos);
+	if (n != PAGE_SIZE)
+		return 0;
+	file->f_pos = pos;
+	cprm->written += PAGE_SIZE;
+	cprm->pos += PAGE_SIZE;
+
+	return 1;
+}
+
 int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 {
 	if (cprm->to_skip) {
@@ -863,7 +895,6 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 
 	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
 		struct page *page;
-		int stop;
 
 		/*
 		 * To avoid having to allocate page tables for virtual address
@@ -874,12 +905,7 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		 */
 		page = get_dump_page(addr);
 		if (page) {
-			void *kaddr = kmap_local_page(page);
-
-			stop = !dump_emit(cprm, kaddr, PAGE_SIZE);
-			kunmap_local(kaddr);
-			put_page(page);
-			if (stop)
+			if (!dump_emit_page(cprm, page))
 				return 0;
 		} else {
 			dump_skip(cprm, PAGE_SIZE);
diff --git a/fs/internal.h b/fs/internal.h
index 87e96b9024ce..3e206d3e317c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -16,6 +16,7 @@ struct shrink_control;
 struct fs_context;
 struct user_namespace;
 struct pipe_inode_info;
+struct iov_iter;
 
 /*
  * block/bdev.c
@@ -221,3 +222,5 @@ ssize_t do_getxattr(struct user_namespace *mnt_userns,
 int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
 int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx);
+
+ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
diff --git a/fs/read_write.c b/fs/read_write.c
index 1a261dcf1778..328ce8cf9a85 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -496,14 +496,9 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 }
 
 /* caller is responsible for file_start_write/file_end_write */
-ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
+ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos)
 {
-	struct kvec iov = {
-		.iov_base	= (void *)buf,
-		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
-	};
 	struct kiocb kiocb;
-	struct iov_iter iter;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_WRITE)))
@@ -519,8 +514,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
-	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
-	ret = file->f_op->write_iter(&kiocb, &iter);
+	ret = file->f_op->write_iter(&kiocb, from);
 	if (ret > 0) {
 		if (pos)
 			*pos = kiocb.ki_pos;
@@ -530,6 +524,18 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	inc_syscw(current);
 	return ret;
 }
+
+/* caller is responsible for file_start_write/file_end_write */
+ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
+{
+	struct kvec iov = {
+		.iov_base	= (void *)buf,
+		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
+	};
+	struct iov_iter iter;
+	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
+	return __kernel_write_iter(file, &iter, pos);
+}
 /*
  * This "EXPORT_SYMBOL_GPL()" is more of a "EXPORT_SYMBOL_DONTUSE()",
  * but autofs is one of the few internal kernel users that actually
