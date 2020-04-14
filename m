Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58F41A73FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 09:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406212AbgDNHCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 03:02:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgDNHCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=M5406jaK+bnV3+r5y6smgvAwTuAJNfgWrpEoKc2FMtE=; b=lnobmZErFPQjemXWVfuj+8d0Lz
        QDgTJnTZzTYtmGKt7aebusPt5mowrAGRRmliTllsHexAjuPdZIuN5d9uyGy/LYiZiuj12bNZS/+bz
        EZGF2/5SwG4Mdrd9MEAeCefF2Q2Jitm7qz42hYlyiTjI89T5tGOU9I0OYgZYu4b7xz02W5vQ7Jnlq
        8qCnbJ7Om828F1bXwVt4rphFhlVizWTzSLfbP+S7Iuv9bRzbOJE3h8JAOZdF1A+WUUXnUBPCjFs/a
        GDshM2H7yqQY34qbUmtCpa/twKd1FLbOZbtJ1ks2ZZSqijZPEagw8ZoWJGU/zdq1MjrhIzpt1KOpu
        /JYDLxZw==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOFZs-0005Y0-2U; Tue, 14 Apr 2020 07:01:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] powerpc/spufs: simplify spufs core dumping
Date:   Tue, 14 Apr 2020 09:01:35 +0200
Message-Id: <20200414070142.288696-2-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414070142.288696-1-hch@lst.de>
References: <20200414070142.288696-1-hch@lst.de>
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
 arch/powerpc/platforms/cell/spufs/coredump.c |  87 ++----
 arch/powerpc/platforms/cell/spufs/file.c     | 273 ++++++++++---------
 arch/powerpc/platforms/cell/spufs/spufs.h    |   3 +-
 3 files changed, 170 insertions(+), 193 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 8b3296b62f65..3b75e8f60609 100644
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
index c0f950a3f4e1..0f8c3d692af0 100644
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
@@ -967,28 +972,26 @@ spufs_signal1_release(struct inode *inode, struct file *file)
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
@@ -1000,7 +1003,7 @@ static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
-	ret = __spufs_signal1_read(ctx, buf, len, pos);
+	ret = __spufs_signal1_read(ctx, buf, len);
 	spu_release_saved(ctx);
 
 	return ret;
@@ -1104,28 +1107,26 @@ spufs_signal2_release(struct inode *inode, struct file *file)
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
@@ -1137,7 +1138,7 @@ static ssize_t spufs_signal2_read(struct file *file, char __user *buf,
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
-	ret = __spufs_signal2_read(ctx, buf, len, pos);
+	ret = __spufs_signal2_read(ctx, buf, len);
 	spu_release_saved(ctx);
 
 	return ret;
@@ -1961,18 +1962,13 @@ static const struct file_operations spufs_caps_fops = {
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
@@ -1988,7 +1984,12 @@ static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 	spin_lock(&ctx->csa.register_lock);
-	ret = __spufs_mbox_info_read(ctx, buf, len, pos);
+	/* EOF if there's no entry in the mbox */
+	if (ctx->csa.prob.mb_stat_R & 0x0000ff) {
+		ret = simple_read_from_buffer(buf, len, pos,
+				&ctx->csa.prob.pu_mb_R,
+				sizeof(ctx->csa.prob.pu_mb_R));
+	}
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
@@ -2001,18 +2002,13 @@ static const struct file_operations spufs_mbox_info_fops = {
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
@@ -2028,7 +2024,12 @@ static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 	spin_lock(&ctx->csa.register_lock);
-	ret = __spufs_ibox_info_read(ctx, buf, len, pos);
+	/* EOF if there's no entry in the ibox */
+	if (ctx->csa.prob.mb_stat_R & 0xff0000) {
+		ret = simple_read_from_buffer(buf, len, pos,
+				&ctx->csa.priv2.puint_mb_R,
+				sizeof(ctx->csa.priv2.puint_mb_R));
+	}
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
@@ -2041,21 +2042,16 @@ static const struct file_operations spufs_ibox_info_fops = {
 	.llseek  = generic_file_llseek,
 };
 
-static ssize_t __spufs_wbox_info_read(struct spu_context *ctx,
-			char __user *buf, size_t len, loff_t *pos)
+static size_t spufs_wbox_info_cnt(struct spu_context *ctx)
 {
-	int i, cnt;
-	u32 data[4];
-	u32 wbox_stat;
-
-	wbox_stat = ctx->csa.prob.mb_stat_R;
-	cnt = 4 - ((wbox_stat & 0x00ff00) >> 8);
-	for (i = 0; i < cnt; i++) {
-		data[i] = ctx->csa.spu_mailbox_data[i];
-	}
+	return (4 - ((ctx->csa.prob.mb_stat_R & 0x00ff00) >> 8)) * sizeof(u32);
+}
 
-	return simple_read_from_buffer(buf, len, pos, &data,
-				cnt * sizeof(u32));
+static ssize_t spufs_wbox_info_dump(struct spu_context *ctx,
+		struct coredump_params *cprm)
+{
+	return spufs_dump_emit(cprm, &ctx->csa.spu_mailbox_data,
+			spufs_wbox_info_cnt(ctx));
 }
 
 static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
@@ -2071,7 +2067,8 @@ static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 	spin_lock(&ctx->csa.register_lock);
-	ret = __spufs_wbox_info_read(ctx, buf, len, pos);
+	ret = simple_read_from_buffer(buf, len, pos, &ctx->csa.spu_mailbox_data,
+				      spufs_wbox_info_cnt(ctx));
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
@@ -2084,36 +2081,42 @@ static const struct file_operations spufs_wbox_info_fops = {
 	.llseek  = generic_file_llseek,
 };
 
-static ssize_t __spufs_dma_info_read(struct spu_context *ctx,
-			char __user *buf, size_t len, loff_t *pos)
+static void __spufs_dma_info_read(struct spu_context *ctx,
+		struct spu_dma_info *info)
 {
-	struct spu_dma_info info;
-	struct mfc_cq_sr *qp, *spuqp;
 	int i;
 
-	info.dma_info_type = ctx->csa.priv2.spu_tag_status_query_RW;
-	info.dma_info_mask = ctx->csa.lscsa->tag_mask.slot[0];
-	info.dma_info_status = ctx->csa.spu_chnldata_RW[24];
-	info.dma_info_stall_and_notify = ctx->csa.spu_chnldata_RW[25];
-	info.dma_info_atomic_command_status = ctx->csa.spu_chnldata_RW[27];
+	info->dma_info_type = ctx->csa.priv2.spu_tag_status_query_RW;
+	info->dma_info_mask = ctx->csa.lscsa->tag_mask.slot[0];
+	info->dma_info_status = ctx->csa.spu_chnldata_RW[24];
+	info->dma_info_stall_and_notify = ctx->csa.spu_chnldata_RW[25];
+	info->dma_info_atomic_command_status = ctx->csa.spu_chnldata_RW[27];
+
 	for (i = 0; i < 16; i++) {
-		qp = &info.dma_info_command_data[i];
-		spuqp = &ctx->csa.priv2.spuq[i];
+		struct mfc_cq_sr *qp = &info->dma_info_command_data[i];
+		struct mfc_cq_sr *spuqp = &ctx->csa.priv2.spuq[i];
 
 		qp->mfc_cq_data0_RW = spuqp->mfc_cq_data0_RW;
 		qp->mfc_cq_data1_RW = spuqp->mfc_cq_data1_RW;
 		qp->mfc_cq_data2_RW = spuqp->mfc_cq_data2_RW;
 		qp->mfc_cq_data3_RW = spuqp->mfc_cq_data3_RW;
 	}
+}
+
+static ssize_t spufs_dma_info_dump(struct spu_context *ctx,
+		struct coredump_params *cprm)
+{
+	struct spu_dma_info info;
 
-	return simple_read_from_buffer(buf, len, pos, &info,
-				sizeof info);
+	__spufs_dma_info_read(ctx, &info);
+	return spufs_dump_emit(cprm, &info, sizeof(info));
 }
 
 static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
 			      size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
+	struct spu_dma_info info;
 	int ret;
 
 	if (!access_ok(buf, len))
@@ -2123,7 +2126,8 @@ static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 	spin_lock(&ctx->csa.register_lock);
-	ret = __spufs_dma_info_read(ctx, buf, len, pos);
+	__spufs_dma_info_read(ctx, &info);
+	ret = simple_read_from_buffer(buf, len, pos, &info, sizeof(info));
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
@@ -2136,48 +2140,53 @@ static const struct file_operations spufs_dma_info_fops = {
 	.llseek = no_llseek,
 };
 
-static ssize_t __spufs_proxydma_info_read(struct spu_context *ctx,
-			char __user *buf, size_t len, loff_t *pos)
+static void __spufs_proxydma_info_read(struct spu_context *ctx,
+	struct spu_proxydma_info *info)
 {
-	struct spu_proxydma_info info;
-	struct mfc_cq_sr *qp, *puqp;
-	int ret = sizeof info;
 	int i;
 
-	if (len < ret)
-		return -EINVAL;
-
-	if (!access_ok(buf, len))
-		return -EFAULT;
+	info->proxydma_info_type = ctx->csa.prob.dma_querytype_RW;
+	info->proxydma_info_mask = ctx->csa.prob.dma_querymask_RW;
+	info->proxydma_info_status = ctx->csa.prob.dma_tagstatus_R;
 
-	info.proxydma_info_type = ctx->csa.prob.dma_querytype_RW;
-	info.proxydma_info_mask = ctx->csa.prob.dma_querymask_RW;
-	info.proxydma_info_status = ctx->csa.prob.dma_tagstatus_R;
 	for (i = 0; i < 8; i++) {
-		qp = &info.proxydma_info_command_data[i];
-		puqp = &ctx->csa.priv2.puq[i];
+		struct mfc_cq_sr *qp = &info->proxydma_info_command_data[i];
+		struct mfc_cq_sr *puqp = &ctx->csa.priv2.puq[i];
 
 		qp->mfc_cq_data0_RW = puqp->mfc_cq_data0_RW;
 		qp->mfc_cq_data1_RW = puqp->mfc_cq_data1_RW;
 		qp->mfc_cq_data2_RW = puqp->mfc_cq_data2_RW;
 		qp->mfc_cq_data3_RW = puqp->mfc_cq_data3_RW;
 	}
+}
+
+static ssize_t spufs_proxydma_info_dump(struct spu_context *ctx,
+		struct coredump_params *cprm)
+{
+	struct spu_proxydma_info info;
 
-	return simple_read_from_buffer(buf, len, pos, &info,
-				sizeof info);
+	__spufs_proxydma_info_read(ctx, &info);
+	return spufs_dump_emit(cprm, &info, sizeof(info));
 }
 
 static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
 				   size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
+	struct spu_proxydma_info info;
 	int ret;
 
+	if (len < sizeof(info))
+		return -EINVAL;
+	if (!access_ok(buf, len))
+		return -EFAULT;
+
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
 	spin_lock(&ctx->csa.register_lock);
-	ret = __spufs_proxydma_info_read(ctx, buf, len, pos);
+	__spufs_proxydma_info_read(ctx, &info);
+	ret = simple_read_from_buffer(buf, len, pos, &info, sizeof(info));
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
@@ -2625,23 +2634,23 @@ const struct spufs_tree_descr spufs_dir_debug_contents[] = {
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
index 413c89afe112..1ba4d884febf 100644
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
2.25.1

