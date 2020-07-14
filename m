Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468D721FC97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbgGNTK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbgGNTJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0192C08C5C1;
        Tue, 14 Jul 2020 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v80cwIdw2gpIGoLfAhFjpXEbYC4jpuHZXpAdR4stAmc=; b=slwd/M9QfzrWG77rAqvb8TyV3n
        CB2JrCY67c7VnkfB8LLdZoAPtfNGpdFrrL+007AT7fEuTTYHnc4aI4ya6BakkMvhy6gvXHcKR0SKw
        KpQZL1kWEnPJyO13YFYL8nRTQS/nrZzZgUiZHgWAt0BLyHTwuyRK60r8ffNdIP+6eqzEmgz937llh
        jpAi8yfBeFOcdmvZu/dLZ7JX7MFDIIyfvyikwSs1CFmqWYEeYK9ALkYwk3w+bLv8PcDP/8hYKiqxi
        jcBrhDHn/YBjoA2stPr+SDFh2QywQKI7mT4/yPgSuVCJfiTdG8PWPa8nxPXsFDqjaQCdJdCDo3g+/
        fb7+qjOQ==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIc-0005s3-17; Tue, 14 Jul 2020 19:09:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/23] initrd: switch initrd loading to struct file based APIs
Date:   Tue, 14 Jul 2020 21:04:16 +0200
Message-Id: <20200714190427.4332-13-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no good reason to mess with file descriptors from in-kernel
code, switch the initrd loading to struct file based read and writes
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c          |  2 +-
 include/linux/syscalls.h |  1 -
 init/do_mounts_rd.c      | 82 ++++++++++++++++++++--------------------
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 4fb797822567a6..5db58b8c78d0dd 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -301,7 +301,7 @@ loff_t vfs_llseek(struct file *file, loff_t offset, int whence)
 }
 EXPORT_SYMBOL(vfs_llseek);
 
-off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence)
+static off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence)
 {
 	off_t retval;
 	struct fd f = fdget_pos(fd);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b951a87da9877c..10843a6adb770d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1246,7 +1246,6 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 		    unsigned int count);
 int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
-off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
 int ksys_unshare(unsigned long unshare_flags);
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 27b1bccf6f12a8..7b64390c075043 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -31,7 +31,8 @@ static int __init ramdisk_start_setup(char *str)
 }
 __setup("ramdisk_start=", ramdisk_start_setup);
 
-static int __init crd_load(int in_fd, int out_fd, decompress_fn deco);
+static int __init crd_load(struct file *in_file, struct file *out_file,
+		decompress_fn deco);
 
 /*
  * This routine tries to find a RAM disk image to load, and returns the
@@ -53,7 +54,8 @@ static int __init crd_load(int in_fd, int out_fd, decompress_fn deco);
  *	lz4
  */
 static int __init
-identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
+identify_ramdisk_image(struct file *file, int start_block,
+		decompress_fn *decompressor)
 {
 	const int size = 512;
 	struct minix_super_block *minixsb;
@@ -64,6 +66,7 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	unsigned char *buf;
 	const char *compress_name;
 	unsigned long n;
+	loff_t pos;
 
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
@@ -78,8 +81,8 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	/*
 	 * Read block 0 to test for compressed kernel
 	 */
-	ksys_lseek(fd, start_block * BLOCK_SIZE, 0);
-	ksys_read(fd, buf, size);
+	pos = start_block * BLOCK_SIZE;
+	kernel_read(file, buf, size, &pos);
 
 	*decompressor = decompress_method(buf, size, &compress_name);
 	if (compress_name) {
@@ -124,8 +127,8 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	/*
 	 * Read 512 bytes further to check if cramfs is padded
 	 */
-	ksys_lseek(fd, start_block * BLOCK_SIZE + 0x200, 0);
-	ksys_read(fd, buf, size);
+	pos = start_block * BLOCK_SIZE + 0x200;
+	kernel_read(file, buf, size, &pos);
 
 	if (cramfsb->magic == CRAMFS_MAGIC) {
 		printk(KERN_NOTICE
@@ -138,8 +141,8 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	/*
 	 * Read block 1 to test for minix and ext2 superblock
 	 */
-	ksys_lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
-	ksys_read(fd, buf, size);
+	pos = (start_block + 1) * BLOCK_SIZE;
+	kernel_read(file, buf, size, &pos);
 
 	/* Try minix */
 	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
@@ -166,15 +169,23 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	       start_block);
 
 done:
-	ksys_lseek(fd, start_block * BLOCK_SIZE, 0);
 	kfree(buf);
 	return nblocks;
 }
 
+static unsigned long nr_blocks(struct file *file)
+{
+	struct inode *inode = file->f_mapping->host;
+
+	if (!S_ISBLK(inode->i_mode))
+		return 0;
+	return i_size_read(inode) >> 10;
+}
+
 int __init rd_load_image(char *from)
 {
 	int res = 0;
-	int in_fd, out_fd;
+	struct file *in_file, *out_file;
 	unsigned long rd_blocks, devblocks;
 	int nblocks, i;
 	char *buf = NULL;
@@ -184,20 +195,20 @@ int __init rd_load_image(char *from)
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 #endif
 
-	out_fd = ksys_open("/dev/ram", O_RDWR, 0);
-	if (out_fd < 0)
+	out_file = filp_open("/dev/ram", O_RDWR, 0);
+	if (IS_ERR(out_file))
 		goto out;
 
-	in_fd = ksys_open(from, O_RDONLY, 0);
-	if (in_fd < 0)
+	in_file = filp_open(from, O_RDONLY, 0);
+	if (IS_ERR(in_file))
 		goto noclose_input;
 
-	nblocks = identify_ramdisk_image(in_fd, rd_image_start, &decompressor);
+	nblocks = identify_ramdisk_image(in_file, rd_image_start, &decompressor);
 	if (nblocks < 0)
 		goto done;
 
 	if (nblocks == 0) {
-		if (crd_load(in_fd, out_fd, decompressor) == 0)
+		if (crd_load(in_file, out_file, decompressor) == 0)
 			goto successful_load;
 		goto done;
 	}
@@ -206,11 +217,7 @@ int __init rd_load_image(char *from)
 	 * NOTE NOTE: nblocks is not actually blocks but
 	 * the number of kibibytes of data to load into a ramdisk.
 	 */
-	if (ksys_ioctl(out_fd, BLKGETSIZE, (unsigned long)&rd_blocks) < 0)
-		rd_blocks = 0;
-	else
-		rd_blocks >>= 1;
-
+	rd_blocks = nr_blocks(out_file);
 	if (nblocks > rd_blocks) {
 		printk("RAMDISK: image too big! (%dKiB/%ldKiB)\n",
 		       nblocks, rd_blocks);
@@ -220,13 +227,10 @@ int __init rd_load_image(char *from)
 	/*
 	 * OK, time to copy in the data
 	 */
-	if (ksys_ioctl(in_fd, BLKGETSIZE, (unsigned long)&devblocks) < 0)
-		devblocks = 0;
-	else
-		devblocks >>= 1;
-
 	if (strcmp(from, "/initrd.image") == 0)
 		devblocks = nblocks;
+	else
+		devblocks = nr_blocks(in_file);
 
 	if (devblocks == 0) {
 		printk(KERN_ERR "RAMDISK: could not determine device size\n");
@@ -245,14 +249,11 @@ int __init rd_load_image(char *from)
 		if (i && (i % devblocks == 0)) {
 			pr_cont("done disk #1.\n");
 			rotate = 0;
-			if (ksys_close(in_fd)) {
-				printk("Error closing the disk.\n");
-				goto noclose_input;
-			}
+			fput(in_file);
 			break;
 		}
-		ksys_read(in_fd, buf, BLOCK_SIZE);
-		ksys_write(out_fd, buf, BLOCK_SIZE);
+		kernel_read(in_file, buf, BLOCK_SIZE, &in_file->f_pos);
+		kernel_write(out_file, buf, BLOCK_SIZE, &out_file->f_pos);
 #if !defined(CONFIG_S390)
 		if (!(i % 16)) {
 			pr_cont("%c\b", rotator[rotate & 0x3]);
@@ -265,9 +266,9 @@ int __init rd_load_image(char *from)
 successful_load:
 	res = 1;
 done:
-	ksys_close(in_fd);
+	fput(in_file);
 noclose_input:
-	ksys_close(out_fd);
+	fput(out_file);
 out:
 	kfree(buf);
 	ksys_unlink("/dev/ram");
@@ -283,11 +284,11 @@ int __init rd_load_disk(int n)
 
 static int exit_code;
 static int decompress_error;
-static int crd_infd, crd_outfd;
+static struct file *crd_infile, *crd_outfile;
 
 static long __init compr_fill(void *buf, unsigned long len)
 {
-	long r = ksys_read(crd_infd, buf, len);
+	long r = kernel_read(crd_infile, buf, len, &crd_infile->f_pos);
 	if (r < 0)
 		printk(KERN_ERR "RAMDISK: error while reading compressed data");
 	else if (r == 0)
@@ -297,7 +298,7 @@ static long __init compr_fill(void *buf, unsigned long len)
 
 static long __init compr_flush(void *window, unsigned long outcnt)
 {
-	long written = ksys_write(crd_outfd, window, outcnt);
+	long written = kernel_write(crd_outfile, window, outcnt, &crd_outfile->f_pos);
 	if (written != outcnt) {
 		if (decompress_error == 0)
 			printk(KERN_ERR
@@ -316,11 +317,12 @@ static void __init error(char *x)
 	decompress_error = 1;
 }
 
-static int __init crd_load(int in_fd, int out_fd, decompress_fn deco)
+static int __init crd_load(struct file *in_file, struct file *out_file,
+		decompress_fn deco)
 {
 	int result;
-	crd_infd = in_fd;
-	crd_outfd = out_fd;
+	crd_infile = in_file;
+	crd_outfile = out_file;
 
 	if (!deco) {
 		pr_emerg("Invalid ramdisk decompression routine.  "
-- 
2.27.0

