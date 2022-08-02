Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533D158829C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 21:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiHBThD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 15:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiHBTgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:36:53 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449252FF4
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 12:36:50 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272I2V5Z024385
        for <linux-fsdevel@vger.kernel.org>; Tue, 2 Aug 2022 12:36:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=45JgfRe+CWjDGcU8AbT5bsVYYCjWdG2sJd3W42Hx644=;
 b=VRWp8lVZKF+xmCybnduOKK3I9fcMqM+QdV/5dx/xs2nyNiXNWhNpiLRQYuPPBob4+oy7
 S5DM6erD8pyYVDiOrkeG3wR7x9h2iPVdwcYWKxgFoWAlQ5fxTeL2lSs136ApQuheOgdv
 hnXQmTL2EU2V/ZEBm9e/kSwUvPT4DVkrOYQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn2cxwgyy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Aug 2022 12:36:49 -0700
Received: from twshared7556.02.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 12:36:47 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id D80E86E59EFB; Tue,  2 Aug 2022 12:36:37 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <Kernel-team@fb.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/7] file: add ops to dma map bvec
Date:   Tue, 2 Aug 2022 12:36:28 -0700
Message-ID: <20220802193633.289796-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220802193633.289796-1-kbusch@fb.com>
References: <20220802193633.289796-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Zf06TdDXz2B1fzTvFLELRiYHSfowfBSX
X-Proofpoint-GUID: Zf06TdDXz2B1fzTvFLELRiYHSfowfBSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The same buffer may be used for many subsequent IO's. Instead of setting
up the mapping per-IO, provide an interface that can allow a buffer to
be premapped just once and referenced again later, and implement for the
block device file.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c       | 20 ++++++++++++++++++++
 fs/file.c          | 15 +++++++++++++++
 include/linux/fs.h | 20 ++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 29066ac5a2fa..db2d1e848f4b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -670,6 +670,22 @@ static long blkdev_fallocate(struct file *file, int =
mode, loff_t start,
 	return error;
 }
=20
+#ifdef CONFIG_HAS_DMA
+void *blkdev_dma_map(struct file *filp, struct bio_vec *bvec, int nr_vec=
s)
+{
+	struct block_device *bdev =3D filp->private_data;
+
+	return block_dma_map(bdev, bvec, nr_vecs);
+}
+
+void blkdev_dma_unmap(struct file *filp, void *dma_tag)
+{
+	struct block_device *bdev =3D filp->private_data;
+
+	return block_dma_unmap(bdev, dma_tag);
+}
+#endif
+
 const struct file_operations def_blk_fops =3D {
 	.open		=3D blkdev_open,
 	.release	=3D blkdev_close,
@@ -686,6 +702,10 @@ const struct file_operations def_blk_fops =3D {
 	.splice_read	=3D generic_file_splice_read,
 	.splice_write	=3D iter_file_splice_write,
 	.fallocate	=3D blkdev_fallocate,
+#ifdef CONFIG_HAS_DMA
+	.dma_map	=3D blkdev_dma_map,
+	.dma_unmap	=3D blkdev_dma_unmap,
+#endif
 };
=20
 static __init int blkdev_init(void)
diff --git a/fs/file.c b/fs/file.c
index 3bcc1ecc314a..767bf9d3205e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1307,3 +1307,18 @@ int iterate_fd(struct files_struct *files, unsigne=
d n,
 	return res;
 }
 EXPORT_SYMBOL(iterate_fd);
+
+#ifdef CONFIG_HAS_DMA
+void *file_dma_map(struct file *file, struct bio_vec *bvec, int nr_vecs)
+{
+	if (file->f_op->dma_map)
+		return file->f_op->dma_map(file, bvec, nr_vecs);
+	return ERR_PTR(-EINVAL);
+}
+
+void file_dma_unmap(struct file *file, void *dma_tag)
+{
+	if (file->f_op->dma_unmap)
+		return file->f_op->dma_unmap(file, dma_tag);
+}
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c0d99b5a166b..befd8ea5821a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1964,6 +1964,10 @@ struct dir_context {
 struct iov_iter;
 struct io_uring_cmd;
=20
+#ifdef CONFIG_HAS_DMA
+struct bio_vec;
+#endif
+
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -2006,6 +2010,10 @@ struct file_operations {
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags)=
;
+#ifdef CONFIG_HAS_DMA
+	void *(*dma_map)(struct file *, struct bio_vec *, int);
+	void (*dma_unmap)(struct file *, void *);
+#endif
 } __randomize_layout;
=20
 struct inode_operations {
@@ -3467,4 +3475,16 @@ extern int vfs_fadvise(struct file *file, loff_t o=
ffset, loff_t len,
 extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
=20
+#ifdef CONFIG_HAS_DMA
+void *file_dma_map(struct file *file, struct bio_vec *bvec, int nr_vecs)=
;
+void file_dma_unmap(struct file *file, void *dma_tag);
+#else
+static inline void *file_dma_map(struct file *file, struct bio_vec *bvec=
,
+				 int nr_vecs)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+static inline void file_dma_unmap(struct file *file, void *dma_tag) {}
+#endif
+
 #endif /* _LINUX_FS_H */
--=20
2.30.2

