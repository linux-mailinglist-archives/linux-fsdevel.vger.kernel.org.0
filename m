Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569161C52BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 12:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgEEKNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 06:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728672AbgEEKNS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 06:13:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ED2C061A0F;
        Tue,  5 May 2020 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BF0GXDFF3qwWO18GQH0xrC+A/HHBITe3cDdcV9qUSf0=; b=jfrd54OfO4eIHUORLgDrmiU3Xt
        VHM8gf/0hxX5BJIEF2FS8mNupTpwZFPkYoa6Bk5ekrm0w7RZwl/NkJdv/3X+UK3EVLqkFQkl1C94z
        /sp0eiDwHV+fmDJd7716beKLevAt5J32TGf1VKH+lgsIvntOl4yzlhmSNfRkDy7rYwGlJIADMwsau
        oR66OvOQgXJbFDApmEsW9mFiIfapqD0g8wGrbbsrGhRd0OyjbObHBvk3EoxNe7OGjvD9Hr6R5K0Ye
        1xfazIV0QZ1LT3TwxSR8OGGaEZeQzTabrnn/MsaBMM3AHAeeTAmvnDhNru7JD0Baq/HkcnbTVugAU
        5V6GmxAg==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVuZX-0006uH-8e; Tue, 05 May 2020 10:13:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] powerpc/spufs: simplify spufs core dumping
Date:   Tue,  5 May 2020 12:12:52 +0200
Message-Id: <20200505101256.3121270-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505101256.3121270-1-hch@lst.de>
References: <20200505101256.3121270-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the coredump ->read method with a ->dump method that must call
dump_emit itself.  That way we avoid a buffer allocation an messing with
set_fs() to call into code that is intended to deal with user buffers.
For the ->get case we can now use a small on-stack buffer and avoid
memory allocations as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jeremy Kerr <jk@ozlabs.org>
---
 arch/powerpc/platforms/cell/spufs/coredump.c |  87 +++-----
 arch/powerpc/platforms/cell/spufs/file.c     | 203 ++++++++-----------
 arch/powerpc/platforms/cell/spufs/spufs.h    |   3 +-
 3 files changed, 117 insertions(+), 176 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 8b3296b62f651..3b75e8f60609c 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -21,22 +21,6 @@
 
 #include "spufs.h"
 
-static ssize_t do_coredump_read(int num, struct spu_context *ctx, void *buffer,
-				size_t size, loff_t *off)
-{
-	u64 data;
-	int ret;
-
-	if (spufs_coredump_read[num].read)
-		return spufs_coredump_read[num].read(ctx, buffer, size, off);
-
-	data = spufs_coredump_read[num].get(ctx);
-	ret = snprintf(buffer, size, "0x%.16llx", data);
-	if (ret >= size)
-		return size;
-	return ++ret; /* count trailing NULL */
-}
-
 static int spufs_ctx_note_size(struct spu_context *ctx, int dfd)
 {
 	int i, sz, total = 0;
@@ -118,58 +102,43 @@ int spufs_coredump_extra_notes_size(void)
 static int spufs_arch_write_note(struct spu_context *ctx, int i,
 				  struct coredump_params *cprm, int dfd)
 {
-	loff_t pos = 0;
-	int sz, rc, total = 0;
-	const int bufsz = PAGE_SIZE;
-	char *name;
-	char fullname[80], *buf;
+	size_t sz = spufs_coredump_read[i].size;
+	char fullname[80];
 	struct elf_note en;
-	size_t skip;
-
-	buf = (void *)get_zeroed_page(GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	size_t ret;
 
-	name = spufs_coredump_read[i].name;
-	sz = spufs_coredump_read[i].size;
-
-	sprintf(fullname, "SPU/%d/%s", dfd, name);
+	sprintf(fullname, "SPU/%d/%s", dfd, spufs_coredump_read[i].name);
 	en.n_namesz = strlen(fullname) + 1;
 	en.n_descsz = sz;
 	en.n_type = NT_SPU;
 
 	if (!dump_emit(cprm, &en, sizeof(en)))
-		goto Eio;
-
+		return -EIO;
 	if (!dump_emit(cprm, fullname, en.n_namesz))
-		goto Eio;
-
+		return -EIO;
 	if (!dump_align(cprm, 4))
-		goto Eio;
-
-	do {
-		rc = do_coredump_read(i, ctx, buf, bufsz, &pos);
-		if (rc > 0) {
-			if (!dump_emit(cprm, buf, rc))
-				goto Eio;
-			total += rc;
-		}
-	} while (rc == bufsz && total < sz);
-
-	if (rc < 0)
-		goto out;
-
-	skip = roundup(cprm->pos - total + sz, 4) - cprm->pos;
-	if (!dump_skip(cprm, skip))
-		goto Eio;
-
-	rc = 0;
-out:
-	free_page((unsigned long)buf);
-	return rc;
-Eio:
-	free_page((unsigned long)buf);
-	return -EIO;
+		return -EIO;
+
+	if (spufs_coredump_read[i].dump) {
+		ret = spufs_coredump_read[i].dump(ctx, cprm);
+		if (ret < 0)
+			return ret;
+	} else {
+		char buf[32];
+
+		ret = snprintf(buf, sizeof(buf), "0x%.16llx",
+			       spufs_coredump_read[i].get(ctx));
+		if (ret >= sizeof(buf))
+			return sizeof(buf);
+
+		/* count trailing the NULL: */
+		if (!dump_emit(cprm, buf, ret + 1))
+			return -EIO;
+	}
+
+	if (!dump_skip(cprm, roundup(cprm->pos - ret + sz, 4) - cprm->pos))
+		return -EIO;
+	return 0;
 }
 
 int spufs_coredump_extra_notes_write(struct coredump_params *cprm)
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index bd30b5e0c4c37..e44427c245850 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -9,6 +9,7 @@
 
 #undef DEBUG
 
+#include <linux/coredump.h>
 #include <linux/fs.h>
 #include <linux/ioctl.h>
 #include <linux/export.h>
@@ -129,6 +130,14 @@ static ssize_t spufs_attr_write(struct file *file, const char __user *buf,
 	return ret;
 }
 
+static ssize_t spufs_dump_emit(struct coredump_params *cprm, void *buf,
+		size_t size)
+{
+	if (!dump_emit(cprm, buf, size))
+		return -EIO;
+	return size;
+}
+
 #define DEFINE_SPUFS_SIMPLE_ATTRIBUTE(__fops, __get, __set, __fmt)	\
 static int __fops ## _open(struct inode *inode, struct file *file)	\
 {									\
@@ -172,12 +181,9 @@ spufs_mem_release(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-__spufs_mem_read(struct spu_context *ctx, char __user *buffer,
-			size_t size, loff_t *pos)
+spufs_mem_dump(struct spu_context *ctx, struct coredump_params *cprm)
 {
-	char *local_store = ctx->ops->get_ls(ctx);
-	return simple_read_from_buffer(buffer, size, pos, local_store,
-					LS_SIZE);
+	return spufs_dump_emit(cprm, ctx->ops->get_ls(ctx), LS_SIZE);
 }
 
 static ssize_t
@@ -190,7 +196,8 @@ spufs_mem_read(struct file *file, char __user *buffer,
 	ret = spu_acquire(ctx);
 	if (ret)
 		return ret;
-	ret = __spufs_mem_read(ctx, buffer, size, pos);
+	ret = simple_read_from_buffer(buffer, size, pos, ctx->ops->get_ls(ctx),
+				      LS_SIZE);
 	spu_release(ctx);
 
 	return ret;
@@ -459,12 +466,10 @@ spufs_regs_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-__spufs_regs_read(struct spu_context *ctx, char __user *buffer,
-			size_t size, loff_t *pos)
+spufs_regs_dump(struct spu_context *ctx, struct coredump_params *cprm)
 {
-	struct spu_lscsa *lscsa = ctx->csa.lscsa;
-	return simple_read_from_buffer(buffer, size, pos,
-				      lscsa->gprs, sizeof lscsa->gprs);
+	return spufs_dump_emit(cprm, ctx->csa.lscsa->gprs,
+			       sizeof(ctx->csa.lscsa->gprs));
 }
 
 static ssize_t
@@ -482,7 +487,8 @@ spufs_regs_read(struct file *file, char __user *buffer,
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
-	ret = __spufs_regs_read(ctx, buffer, size, pos);
+	ret = simple_read_from_buffer(buffer, size, pos, ctx->csa.lscsa->gprs,
+				      sizeof(ctx->csa.lscsa->gprs));
 	spu_release_saved(ctx);
 	return ret;
 }
@@ -517,12 +523,10 @@ static const struct file_operations spufs_regs_fops = {
 };
 
 static ssize_t
-__spufs_fpcr_read(struct spu_context *ctx, char __user * buffer,
-			size_t size, loff_t * pos)
+spufs_fpcr_dump(struct spu_context *ctx, struct coredump_params *cprm)
 {
-	struct spu_lscsa *lscsa = ctx->csa.lscsa;
-	return simple_read_from_buffer(buffer, size, pos,
-				      &lscsa->fpcr, sizeof(lscsa->fpcr));
+	return spufs_dump_emit(cprm, &ctx->csa.lscsa->fpcr,
+			       sizeof(ctx->csa.lscsa->fpcr));
 }
 
 static ssize_t
@@ -535,7 +539,8 @@ spufs_fpcr_read(struct file *file, char __user * buffer,
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
-	ret = __spufs_fpcr_read(ctx, buffer, size, pos);
+	ret = simple_read_from_buffer(buffer, size, pos, &ctx->csa.lscsa->fpcr,
+				      sizeof(ctx->csa.lscsa->fpcr));
 	spu_release_saved(ctx);
 	return ret;
 }
@@ -953,28 +958,26 @@ spufs_signal1_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t __spufs_signal1_read(struct spu_context *ctx, char __user *buf,
-			size_t len, loff_t *pos)
+static ssize_t spufs_signal1_dump(struct spu_context *ctx,
+		struct coredump_params *cprm)
 {
-	int ret = 0;
-	u32 data;
+	if (!ctx->csa.spu_chnlcnt_RW[3])
+		return 0;
+	return spufs_dump_emit(cprm, &ctx->csa.spu_chnldata_RW[3],
+			       sizeof(ctx->csa.spu_chnldata_RW[3]));
+}
 
-	if (len < 4)
+static ssize_t __spufs_signal1_read(struct spu_context *ctx, char __user *buf,
+			size_t len)
+{
+	if (len < sizeof(ctx->csa.spu_chnldata_RW[3]))
 		return -EINVAL;
-
-	if (ctx->csa.spu_chnlcnt_RW[3]) {
-		data = ctx->csa.spu_chnldata_RW[3];
-		ret = 4;
-	}
-
-	if (!ret)
-		goto out;
-
-	if (copy_to_user(buf, &data, 4))
+	if (!ctx->csa.spu_chnlcnt_RW[3])
+		return 0;
+	if (copy_to_user(buf, &ctx->csa.spu_chnldata_RW[3],
+			 sizeof(ctx->csa.spu_chnldata_RW[3])))
 		return -EFAULT;
-
-out:
-	return ret;
+	return sizeof(ctx->csa.spu_chnldata_RW[3]);
 }
 
 static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
@@ -986,7 +989,7 @@ static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
-	ret = __spufs_signal1_read(ctx, buf, len, pos);
+	ret = __spufs_signal1_read(ctx, buf, len);
 	spu_release_saved(ctx);
 
 	return ret;
@@ -1090,28 +1093,26 @@ spufs_signal2_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t __spufs_signal2_read(struct spu_context *ctx, char __user *buf,
-			size_t len, loff_t *pos)
+static ssize_t spufs_signal2_dump(struct spu_context *ctx,
+		struct coredump_params *cprm)
 {
-	int ret = 0;
-	u32 data;
+	if (!ctx->csa.spu_chnlcnt_RW[4])
+		return 0;
+	return spufs_dump_emit(cprm, &ctx->csa.spu_chnldata_RW[4],
+			       sizeof(ctx->csa.spu_chnldata_RW[4]));
+}
 
-	if (len < 4)
+static ssize_t __spufs_signal2_read(struct spu_context *ctx, char __user *buf,
+			size_t len)
+{
+	if (len < sizeof(ctx->csa.spu_chnldata_RW[4]))
 		return -EINVAL;
-
-	if (ctx->csa.spu_chnlcnt_RW[4]) {
-		data =  ctx->csa.spu_chnldata_RW[4];
-		ret = 4;
-	}
-
-	if (!ret)
-		goto out;
-
-	if (copy_to_user(buf, &data, 4))
+	if (!ctx->csa.spu_chnlcnt_RW[4])
+		return 0;
+	if (copy_to_user(buf, &ctx->csa.spu_chnldata_RW[4],
+			 sizeof(ctx->csa.spu_chnldata_RW[4])))
 		return -EFAULT;
-
-out:
-	return ret;
+	return sizeof(ctx->csa.spu_chnldata_RW[4]);
 }
 
 static ssize_t spufs_signal2_read(struct file *file, char __user *buf,
@@ -1123,7 +1124,7 @@ static ssize_t spufs_signal2_read(struct file *file, char __user *buf,
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
-	ret = __spufs_signal2_read(ctx, buf, len, pos);
+	ret = __spufs_signal2_read(ctx, buf, len);
 	spu_release_saved(ctx);
 
 	return ret;
@@ -1947,18 +1948,13 @@ static const struct file_operations spufs_caps_fops = {
 	.release	= single_release,
 };
 
-static ssize_t __spufs_mbox_info_read(struct spu_context *ctx,
-			char __user *buf, size_t len, loff_t *pos)
+static ssize_t spufs_mbox_info_dump(struct spu_context *ctx,
+		struct coredump_params *cprm)
 {
-	u32 data;
-
-	/* EOF if there's no entry in the mbox */
 	if (!(ctx->csa.prob.mb_stat_R & 0x0000ff))
 		return 0;
-
-	data = ctx->csa.prob.pu_mb_R;
-
-	return simple_read_from_buffer(buf, len, pos, &data, sizeof data);
+	return spufs_dump_emit(cprm, &ctx->csa.prob.pu_mb_R,
+			       sizeof(ctx->csa.prob.pu_mb_R));
 }
 
 static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
@@ -1990,18 +1986,13 @@ static const struct file_operations spufs_mbox_info_fops = {
 	.llseek  = generic_file_llseek,
 };
 
-static ssize_t __spufs_ibox_info_read(struct spu_context *ctx,
-				char __user *buf, size_t len, loff_t *pos)
+static ssize_t spufs_ibox_info_dump(struct spu_context *ctx,
+		struct coredump_params *cprm)
 {
-	u32 data;
-
-	/* EOF if there's no entry in the ibox */
 	if (!(ctx->csa.prob.mb_stat_R & 0xff0000))
 		return 0;
-
-	data = ctx->csa.priv2.puint_mb_R;
-
-	return simple_read_from_buffer(buf, len, pos, &data, sizeof data);
+	return spufs_dump_emit(cprm, &ctx->csa.priv2.puint_mb_R,
+			       sizeof(ctx->csa.priv2.puint_mb_R));
 }
 
 static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
@@ -2038,21 +2029,11 @@ static size_t spufs_wbox_info_cnt(struct spu_context *ctx)
 	return (4 - ((ctx->csa.prob.mb_stat_R & 0x00ff00) >> 8)) * sizeof(u32);
 }
 
-static ssize_t __spufs_wbox_info_read(struct spu_context *ctx,
-			char __user *buf, size_t len, loff_t *pos)
+static ssize_t spufs_wbox_info_dump(struct spu_context *ctx,
+		struct coredump_params *cprm)
 {
-	int i, cnt;
-	u32 data[4];
-	u32 wbox_stat;
-
-	wbox_stat = ctx->csa.prob.mb_stat_R;
-	cnt = spufs_wbox_info_cnt(ctx);
-	for (i = 0; i < cnt; i++) {
-		data[i] = ctx->csa.spu_mailbox_data[i];
-	}
-
-	return simple_read_from_buffer(buf, len, pos, &data,
-				cnt * sizeof(u32));
+	return spufs_dump_emit(cprm, &ctx->csa.spu_mailbox_data,
+			spufs_wbox_info_cnt(ctx));
 }
 
 static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
@@ -2102,15 +2083,13 @@ static void spufs_get_dma_info(struct spu_context *ctx,
 	}
 }
 
-static ssize_t __spufs_dma_info_read(struct spu_context *ctx,
-			char __user *buf, size_t len, loff_t *pos)
+static ssize_t spufs_dma_info_dump(struct spu_context *ctx,
+		struct coredump_params *cprm)
 {
 	struct spu_dma_info info;
 
 	spufs_get_dma_info(ctx, &info);
-
-	return simple_read_from_buffer(buf, len, pos, &info,
-				sizeof info);
+	return spufs_dump_emit(cprm, &info, sizeof(info));
 }
 
 static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
@@ -2158,22 +2137,13 @@ static void spufs_get_proxydma_info(struct spu_context *ctx,
 	}
 }
 
-static ssize_t __spufs_proxydma_info_read(struct spu_context *ctx,
-			char __user *buf, size_t len, loff_t *pos)
+static ssize_t spufs_proxydma_info_dump(struct spu_context *ctx,
+		struct coredump_params *cprm)
 {
 	struct spu_proxydma_info info;
-	int ret = sizeof info;
-
-	if (len < ret)
-		return -EINVAL;
-
-	if (!access_ok(buf, len))
-		return -EFAULT;
 
 	spufs_get_proxydma_info(ctx, &info);
-
-	return simple_read_from_buffer(buf, len, pos, &info,
-				sizeof info);
+	return spufs_dump_emit(cprm, &info, sizeof(info));
 }
 
 static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
@@ -2183,6 +2153,9 @@ static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
 	struct spu_proxydma_info info;
 	int ret;
 
+	if (len < sizeof(info))
+		return -EINVAL;
+
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
@@ -2636,23 +2609,23 @@ const struct spufs_tree_descr spufs_dir_debug_contents[] = {
 };
 
 const struct spufs_coredump_reader spufs_coredump_read[] = {
-	{ "regs", __spufs_regs_read, NULL, sizeof(struct spu_reg128[128])},
-	{ "fpcr", __spufs_fpcr_read, NULL, sizeof(struct spu_reg128) },
+	{ "regs", spufs_regs_dump, NULL, sizeof(struct spu_reg128[128])},
+	{ "fpcr", spufs_fpcr_dump, NULL, sizeof(struct spu_reg128) },
 	{ "lslr", NULL, spufs_lslr_get, 19 },
 	{ "decr", NULL, spufs_decr_get, 19 },
 	{ "decr_status", NULL, spufs_decr_status_get, 19 },
-	{ "mem", __spufs_mem_read, NULL, LS_SIZE, },
-	{ "signal1", __spufs_signal1_read, NULL, sizeof(u32) },
+	{ "mem", spufs_mem_dump, NULL, LS_SIZE, },
+	{ "signal1", spufs_signal1_dump, NULL, sizeof(u32) },
 	{ "signal1_type", NULL, spufs_signal1_type_get, 19 },
-	{ "signal2", __spufs_signal2_read, NULL, sizeof(u32) },
+	{ "signal2", spufs_signal2_dump, NULL, sizeof(u32) },
 	{ "signal2_type", NULL, spufs_signal2_type_get, 19 },
 	{ "event_mask", NULL, spufs_event_mask_get, 19 },
 	{ "event_status", NULL, spufs_event_status_get, 19 },
-	{ "mbox_info", __spufs_mbox_info_read, NULL, sizeof(u32) },
-	{ "ibox_info", __spufs_ibox_info_read, NULL, sizeof(u32) },
-	{ "wbox_info", __spufs_wbox_info_read, NULL, 4 * sizeof(u32)},
-	{ "dma_info", __spufs_dma_info_read, NULL, sizeof(struct spu_dma_info)},
-	{ "proxydma_info", __spufs_proxydma_info_read,
+	{ "mbox_info", spufs_mbox_info_dump, NULL, sizeof(u32) },
+	{ "ibox_info", spufs_ibox_info_dump, NULL, sizeof(u32) },
+	{ "wbox_info", spufs_wbox_info_dump, NULL, 4 * sizeof(u32)},
+	{ "dma_info", spufs_dma_info_dump, NULL, sizeof(struct spu_dma_info)},
+	{ "proxydma_info", spufs_proxydma_info_dump,
 			   NULL, sizeof(struct spu_proxydma_info)},
 	{ "object-id", NULL, spufs_object_id_get, 19 },
 	{ "npc", NULL, spufs_npc_get, 19 },
diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index 413c89afe1126..1ba4d884febfa 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -337,8 +337,7 @@ void spufs_dma_callback(struct spu *spu, int type);
 extern struct spu_coredump_calls spufs_coredump_calls;
 struct spufs_coredump_reader {
 	char *name;
-	ssize_t (*read)(struct spu_context *ctx,
-			char __user *buffer, size_t size, loff_t *pos);
+	ssize_t (*dump)(struct spu_context *ctx, struct coredump_params *cprm);
 	u64 (*get)(struct spu_context *ctx);
 	size_t size;
 };
-- 
2.26.2

