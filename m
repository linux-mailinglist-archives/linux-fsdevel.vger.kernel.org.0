Return-Path: <linux-fsdevel+bounces-62731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80A7B9F75C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6358338621C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B142264CA;
	Thu, 25 Sep 2025 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="CRz+5vlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0022424C
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805953; cv=none; b=mQmcKZDh+RuR8L5DBDtIFYcOxJDhb8aVy93svYOuqoAGDuwBvSYfqdZnVxIaqEtDEgeWvX/7qupwqNaGmyM4QIJKJvTdBCD0JBdTKU9VNsuD1CnyaUAaphwgntknhO2p4gphwI66l8hmFf5z60tpxmkeWCNO9SC6B6+yH+CY8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805953; c=relaxed/simple;
	bh=9AXpZB1bwcU/tOfhENucqnGAndFUojEuOkjiz/Zv4RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ogYry3VhC1DjqjEvUoX2hHhSL3OeG9XWf/S3RgcIXvbNU7Te0FATpQ5rbdWsW6PhLMFA/RDnTnittWfNKcCTjNsih1Sm7HiOM8SqUYu7DheSlWacd4NKSr92taM88PGNzAmaHSN5FxEqBkhxkkA/HoC9TF+YAXZd1eEdRaLPBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=CRz+5vlS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so1277635f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1758805948; x=1759410748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfJVwYFcsQ06QJkEnurciWiF3KgCM9rgqn4VVbABEtQ=;
        b=CRz+5vlS551m+/ibrrRNCR05aMB/XHm006u7vorJTWL8KnZICEOAUANVKfnYA17O6n
         CNSPshs989BTySJxhVJjDQVgMGaKDdMiH3CECJdyi/M1fe2VRT3raSjIKb/Hlvwh7G6v
         JeK6qKCSPjuD07vK1RwG2F5a4t5BpVDGoO8/gxEqKiTZfKvqJWXcWT9pTCarqVnQsLHE
         5ucPrcXT5w4T3QmqA0pfGPahpuB/tMMPUBNHICg7bBcyx9MvrPir/Z3ASpVDEUZRuat+
         Emr0AO0ruL/nGstrHje868zLQxrrGECkqEwR4Q0rk20LDfrLBaIEK7TCh5xcMBb3bFRm
         o72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805948; x=1759410748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfJVwYFcsQ06QJkEnurciWiF3KgCM9rgqn4VVbABEtQ=;
        b=UkkUUolKpnWheYx2stchJqLu/+YQNt/gui4r6CcAKBpFR8zXO42Gl6+/LMKARE4ak8
         8meCPkOqvIlpYtE3Us8LJWHmeSkodBzb0m3U7lasVGC60tVIDAAmEy1TzmUQDzN6jtsy
         roS8YGtrrwu8AQu+YT1Dp6/w3qUiC6TdjyugX0WqfTWdxUbFM4/RkQC37ARUFf/zkfEg
         BHTRFEzd9CBSuLE34F6SfcclCs0t2dLOGXNSELAx7VYvDl8ps1OSCLUKEE9m2LnwyvMP
         WzJt4Y3YSky4JaVaoLcxqMvjqnmWeqAWeQ3sle9HmJ3ez6iXiakMshklE3nKHUPQ1WVB
         Jvow==
X-Forwarded-Encrypted: i=1; AJvYcCU+Ch0euNzDVYK2wSFH8bqrAsQytzJIJEkLjuAQocRTJsDdO/WQmsNmxgOjvdEpcKicR4B06AaezXA9sL+h@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuRHipXCAP+Zzas+t4OBKvcAQAefd1T8x0FAxwu0YOb2asih/
	n2x+xshYxgH5FcQeRB1w3SS7y9c726JhMO8drn3Hci4aBH/8PaScvG+SYO1wpO1pEUY=
X-Gm-Gg: ASbGncsBHF5KFBPkiIs4yhyVjaNzLx7S1874Ud1IV4Zcq2ieiZJ7i3zsNz7T2sHlsdL
	gscVZw4Iv/KtJuX97qWRB5XPvsOLyXqsWrbStrPWesshjbHaG2T4fN+5jcL7otaYbx2t5fDpua7
	IcFsvhG8j5xidlzbXQCUxNWsKLHN8l0L3nfWSTucACCNmMANHPukNb5yb1x2maM0W0t+wp2LDoD
	yo0Coh2fzue0E8xJUKuunSCGL3EEMnQUiyDEj5qQ3n8TWUpaVWT/Fc33kffuySkCYZtOTDCwUOU
	o702mrLE2pj4rhNO/Pq6D8jGNC1cTzLHSkbrQsBDGs8RitI++F+sIChlVoYZiIiiD3KDT0k+hiu
	v12aKWvIKDkPE6H+RzEtNiEU6G/eY0/16EeVEoRj7fKhLfeWLrQ==
X-Google-Smtp-Source: AGHT+IGfEDsgYy1Y3V7mn/9vw12xwbotyOf9S0qvgxiLF/dTs1GE6jSNXI03j1w/2hgZi5tVGzAx+Q==
X-Received: by 2002:a05:6000:290e:b0:3fc:cbfc:fbee with SMTP id ffacd0b85a97d-40f65bbb807mr2115268f8f.19.1758805948078;
        Thu, 25 Sep 2025 06:12:28 -0700 (PDT)
Received: from daria.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bef4b4sm32929635e9.20.2025.09.25.06.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:12:27 -0700 (PDT)
From: nschichan@freebox.fr
To: nschichan@freebox.fr
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	ecurtin@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	rob@landley.net,
	safinaskar@gmail.com,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org
Subject: [PATCH-RFC] init: simplify initrd code (was Re: [PATCH RESEND 00/62] initrd: remove classic initrd support).
Date: Thu, 25 Sep 2025 15:10:56 +0200
Message-Id: <20250925131055.3933381-1-nschichan@freebox.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
References: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Schichan <nschichan@freebox.fr>

- drop prompt_ramdisk and ramdisk_start kernel parameters
- drop compression support
- drop image autodetection, the whole /initrd.image content is now
  copied into /dev/ram0
- remove rd_load_disk() which doesn't seem to be used anywhere.

There is now no more limitation on the type of initrd filesystem that
can be loaded since the code trying to guess the initrd filesystem
size is gone (the whole /initrd.image file is used).

A few global variables in do_mounts_rd.c are now put as local
variables in rd_load_image() since they do not need to be visible
outside this function.
---

Hello,

Hopefully my email config is now better and reaches gmail users
correctly.

The patch below could probably split in a few patches, but I think
this simplify the code greatly without removing the functionality we
depend on (and this allows now to use EROFS initrd images).

Coupled with keeping the function populate_initrd_image() in
init/initramfs.c, this will keep what we need from the initrd code.

This removes support of loading bzip/gz/xz/... compressed images as
well, not sure if many user depend on this feature anymore.

No signoff because I'm only seeking comments about those changes right
now.

 init/do_mounts.h    |   2 -
 init/do_mounts_rd.c | 243 +-------------------------------------------
 2 files changed, 4 insertions(+), 241 deletions(-)

diff --git a/init/do_mounts.h b/init/do_mounts.h
index 6069ea3eb80d..c0028ee3cff6 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -24,12 +24,10 @@ static inline __init int create_dev(char *name, dev_t dev)
 
 #ifdef CONFIG_BLK_DEV_RAM
 
-int __init rd_load_disk(int n);
 int __init rd_load_image(char *from);
 
 #else
 
-static inline int rd_load_disk(int n) { return 0; }
 static inline int rd_load_image(char *from) { return 0; }
 
 #endif
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..5a69ff43f5ee 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -14,173 +14,9 @@
 
 #include <linux/decompress/generic.h>
 
-static struct file *in_file, *out_file;
-static loff_t in_pos, out_pos;
-
-static int __init prompt_ramdisk(char *str)
-{
-	pr_warn("ignoring the deprecated prompt_ramdisk= option\n");
-	return 1;
-}
-__setup("prompt_ramdisk=", prompt_ramdisk);
-
-int __initdata rd_image_start;		/* starting block # of image */
-
-static int __init ramdisk_start_setup(char *str)
-{
-	rd_image_start = simple_strtol(str,NULL,0);
-	return 1;
-}
-__setup("ramdisk_start=", ramdisk_start_setup);
-
-static int __init crd_load(decompress_fn deco);
-
-/*
- * This routine tries to find a RAM disk image to load, and returns the
- * number of blocks to read for a non-compressed image, 0 if the image
- * is a compressed image, and -1 if an image with the right magic
- * numbers could not be found.
- *
- * We currently check for the following magic numbers:
- *	minix
- *	ext2
- *	romfs
- *	cramfs
- *	squashfs
- *	gzip
- *	bzip2
- *	lzma
- *	xz
- *	lzo
- *	lz4
- */
-static int __init
-identify_ramdisk_image(struct file *file, loff_t pos,
-		decompress_fn *decompressor)
-{
-	const int size = 512;
-	struct minix_super_block *minixsb;
-	struct romfs_super_block *romfsb;
-	struct cramfs_super *cramfsb;
-	struct squashfs_super_block *squashfsb;
-	int nblocks = -1;
-	unsigned char *buf;
-	const char *compress_name;
-	unsigned long n;
-	int start_block = rd_image_start;
-
-	buf = kmalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	minixsb = (struct minix_super_block *) buf;
-	romfsb = (struct romfs_super_block *) buf;
-	cramfsb = (struct cramfs_super *) buf;
-	squashfsb = (struct squashfs_super_block *) buf;
-	memset(buf, 0xe5, size);
-
-	/*
-	 * Read block 0 to test for compressed kernel
-	 */
-	pos = start_block * BLOCK_SIZE;
-	kernel_read(file, buf, size, &pos);
-
-	*decompressor = decompress_method(buf, size, &compress_name);
-	if (compress_name) {
-		printk(KERN_NOTICE "RAMDISK: %s image found at block %d\n",
-		       compress_name, start_block);
-		if (!*decompressor)
-			printk(KERN_EMERG
-			       "RAMDISK: %s decompressor not configured!\n",
-			       compress_name);
-		nblocks = 0;
-		goto done;
-	}
-
-	/* romfs is at block zero too */
-	if (romfsb->word0 == ROMSB_WORD0 &&
-	    romfsb->word1 == ROMSB_WORD1) {
-		printk(KERN_NOTICE
-		       "RAMDISK: romfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (ntohl(romfsb->size)+BLOCK_SIZE-1)>>BLOCK_SIZE_BITS;
-		goto done;
-	}
-
-	if (cramfsb->magic == CRAMFS_MAGIC) {
-		printk(KERN_NOTICE
-		       "RAMDISK: cramfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (cramfsb->size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS;
-		goto done;
-	}
-
-	/* squashfs is at block zero too */
-	if (le32_to_cpu(squashfsb->s_magic) == SQUASHFS_MAGIC) {
-		printk(KERN_NOTICE
-		       "RAMDISK: squashfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (le64_to_cpu(squashfsb->bytes_used) + BLOCK_SIZE - 1)
-			 >> BLOCK_SIZE_BITS;
-		goto done;
-	}
-
-	/*
-	 * Read 512 bytes further to check if cramfs is padded
-	 */
-	pos = start_block * BLOCK_SIZE + 0x200;
-	kernel_read(file, buf, size, &pos);
-
-	if (cramfsb->magic == CRAMFS_MAGIC) {
-		printk(KERN_NOTICE
-		       "RAMDISK: cramfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (cramfsb->size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS;
-		goto done;
-	}
-
-	/*
-	 * Read block 1 to test for minix and ext2 superblock
-	 */
-	pos = (start_block + 1) * BLOCK_SIZE;
-	kernel_read(file, buf, size, &pos);
-
-	/* Try minix */
-	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
-	    minixsb->s_magic == MINIX_SUPER_MAGIC2) {
-		printk(KERN_NOTICE
-		       "RAMDISK: Minix filesystem found at block %d\n",
-		       start_block);
-		nblocks = minixsb->s_nzones << minixsb->s_log_zone_size;
-		goto done;
-	}
-
-	/* Try ext2 */
-	n = ext2_image_size(buf);
-	if (n) {
-		printk(KERN_NOTICE
-		       "RAMDISK: ext2 filesystem found at block %d\n",
-		       start_block);
-		nblocks = n;
-		goto done;
-	}
-
-	printk(KERN_NOTICE
-	       "RAMDISK: Couldn't find valid RAM disk image starting at %d.\n",
-	       start_block);
-
-done:
-	kfree(buf);
-	return nblocks;
-}
-
 static unsigned long nr_blocks(struct file *file)
 {
-	struct inode *inode = file->f_mapping->host;
-
-	if (!S_ISBLK(inode->i_mode))
-		return 0;
-	return i_size_read(inode) >> 10;
+	return i_size_read(file->f_mapping->host) >> 10;
 }
 
 int __init rd_load_image(char *from)
@@ -190,10 +26,11 @@ int __init rd_load_image(char *from)
 	int nblocks, i;
 	char *buf = NULL;
 	unsigned short rotate = 0;
-	decompress_fn decompressor = NULL;
 #if !defined(CONFIG_S390)
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 #endif
+	struct file *in_file, *out_file;
+	loff_t in_pos = 0, out_pos = 0;
 
 	out_file = filp_open("/dev/ram", O_RDWR, 0);
 	if (IS_ERR(out_file))
@@ -203,17 +40,6 @@ int __init rd_load_image(char *from)
 	if (IS_ERR(in_file))
 		goto noclose_input;
 
-	in_pos = rd_image_start * BLOCK_SIZE;
-	nblocks = identify_ramdisk_image(in_file, in_pos, &decompressor);
-	if (nblocks < 0)
-		goto done;
-
-	if (nblocks == 0) {
-		if (crd_load(decompressor) == 0)
-			goto successful_load;
-		goto done;
-	}
-
 	/*
 	 * NOTE NOTE: nblocks is not actually blocks but
 	 * the number of kibibytes of data to load into a ramdisk.
@@ -228,10 +54,7 @@ int __init rd_load_image(char *from)
 	/*
 	 * OK, time to copy in the data
 	 */
-	if (strcmp(from, "/initrd.image") == 0)
-		devblocks = nblocks;
-	else
-		devblocks = nr_blocks(in_file);
+	nblocks = devblocks = nr_blocks(in_file);
 
 	if (devblocks == 0) {
 		printk(KERN_ERR "RAMDISK: could not determine device size\n");
@@ -264,7 +87,6 @@ int __init rd_load_image(char *from)
 	}
 	pr_cont("done.\n");
 
-successful_load:
 	res = 1;
 done:
 	fput(in_file);
@@ -275,60 +97,3 @@ int __init rd_load_image(char *from)
 	init_unlink("/dev/ram");
 	return res;
 }
-
-int __init rd_load_disk(int n)
-{
-	create_dev("/dev/root", ROOT_DEV);
-	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, n));
-	return rd_load_image("/dev/root");
-}
-
-static int exit_code;
-static int decompress_error;
-
-static long __init compr_fill(void *buf, unsigned long len)
-{
-	long r = kernel_read(in_file, buf, len, &in_pos);
-	if (r < 0)
-		printk(KERN_ERR "RAMDISK: error while reading compressed data");
-	else if (r == 0)
-		printk(KERN_ERR "RAMDISK: EOF while reading compressed data");
-	return r;
-}
-
-static long __init compr_flush(void *window, unsigned long outcnt)
-{
-	long written = kernel_write(out_file, window, outcnt, &out_pos);
-	if (written != outcnt) {
-		if (decompress_error == 0)
-			printk(KERN_ERR
-			       "RAMDISK: incomplete write (%ld != %ld)\n",
-			       written, outcnt);
-		decompress_error = 1;
-		return -1;
-	}
-	return outcnt;
-}
-
-static void __init error(char *x)
-{
-	printk(KERN_ERR "%s\n", x);
-	exit_code = 1;
-	decompress_error = 1;
-}
-
-static int __init crd_load(decompress_fn deco)
-{
-	int result;
-
-	if (!deco) {
-		pr_emerg("Invalid ramdisk decompression routine.  "
-			 "Select appropriate config option.\n");
-		panic("Could not decompress initial ramdisk image.");
-	}
-
-	result = deco(NULL, 0, compr_fill, compr_flush, NULL, NULL, error);
-	if (decompress_error)
-		result = 1;
-	return result;
-}
-- 
2.34.1


