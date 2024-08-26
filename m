Return-Path: <linux-fsdevel+bounces-27203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB2295F7A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38069B222FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275A5198E71;
	Mon, 26 Aug 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ney4vvAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9918D64D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692461; cv=none; b=iCL4JLBa4ezgNpTsfk128sFwdgTZVLTq26Tk90/8edgpJfUnBkc4B8RUl/WZiKjw6na5CXdGIRCM+I/4pPVqrFVndG37V+xSc3FzDDsV416UEGWVHBpWUM5SdYXfNqGFSSkD6Bk8g3PWTwg4LRpCOk0UPwnByMDww0Xh3kbCXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692461; c=relaxed/simple;
	bh=vlNkw3AENHtkH375pk1CuSNNuSUaFix2ofNNRkWPJkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=vA/sBvemId/zZIMrUvrMmTGZSGzdKwAlmyFkuBXfjrAyGTdCUI8ZYR8Ahi60IxlkQSb31TBY43udk8HUORGCgW5A20stLdMwMyjDzEu3nwPZFyYv1Rk9jFpT3QlaVWnyod3RzsZvrJpjd1jm9br/RQ/3vIMh3iEtpDxqKNzdAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ney4vvAr; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240826171417epoutp01e1b0d7ea55b5ea2d112746149ac7cf87~vVqcDb4EY0190901909epoutp01k
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240826171417epoutp01e1b0d7ea55b5ea2d112746149ac7cf87~vVqcDb4EY0190901909epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724692457;
	bh=n7zhETWk1+f1X9Po3Riik9xlyIuyCM60BVQS3x/oaSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ney4vvArH7DzdwakCU1vjnI0o18elhCr95kI0PpEZz0DNBXRRpbN4tDpxEonv0VHc
	 lZfeq5O4pBduUsEfG4Vij7hwVLa9a2n8MZHGfZN/XlnpwtdSREwlOi3rrtypJoXw6c
	 IPqUU0tRx2xlIWljXVZL6Zqi1vSnXW5kLhK9EuUo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240826171416epcas5p387c52a2f89722239f0e46e82d9da5f2c~vVqbY5mM20591005910epcas5p3g;
	Mon, 26 Aug 2024 17:14:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Wsy2b24qNz4x9Pr; Mon, 26 Aug
	2024 17:14:15 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.A0.09640.7E7BCC66; Tue, 27 Aug 2024 02:14:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5~vVqYcHYhY2945329453epcas5p3n;
	Mon, 26 Aug 2024 17:14:13 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240826171413epsmtrp11fd9c5290d075794afe2600dcc86895a~vVqYbPfbL0078300783epsmtrp1B;
	Mon, 26 Aug 2024 17:14:13 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-9a-66ccb7e77fe6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	6C.51.19367.5E7BCC66; Tue, 27 Aug 2024 02:14:13 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240826171409epsmtip20e565ee1cbc1d1a5846d9a8ded949674~vVqU042770841308413epsmtip2M;
	Mon, 26 Aug 2024 17:14:09 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org, jlayton@kernel.org,
	chuck.lever@oracle.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v4 1/5] fs, block: refactor enum rw_hint
Date: Mon, 26 Aug 2024 22:36:02 +0530
Message-Id: <20240826170606.255718-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826170606.255718-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJsWRmVeSWpSXmKPExsWy7bCmhu7z7WfSDDr+s1qsvtvPZvH68CdG
	i2kffjJb/L/7nMni5oGdTBYrVx9lspg9vZnJ4sn6WcwWG/s5LB7f+cxu8XPZKnaLo//fsllM
	OnSN0WLvLW2LS4vcLfbsPcliMX/ZU3aL7us72CyWH//HZLHu9XsWi/Oz5rA7iHpcvuLtcf7e
	RhaPaZNOsXlcPlvqsWlVJ5vH5iX1HrsXfGby2H2zgc3j49NbLB59W1YxepxZcITd4/MmuQCe
	qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKBPlRTK
	EnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZ
	Gdf/djEXvFOvWHhzLXsD4xWFLkZODgkBE4n99xaxdTFycQgJ7GaU6D/wlx3C+cQosanlMoKz
	8vwjRpiW7/ePs0AkdjJKTFjdxAKSEBL4zCjxZ6FGFyMHB5uApsSFyaUgNSICzUwSG9f+AtvB
	LDCJSeLjg7VsIA3CAhYSLXs2gTWzCKhKNG+bzgTSzCtgKXH2lw3EMnmJmZe+s4PYnAJWEv8/
	vAezeQUEJU7OfALWygxU07x1NjPIfAmBLxwSCw5cZ4VodpH4f/4AE4QtLPHq+BZ2CFtK4mV/
	G5SdLfHg0QMWCLtGYsfmPqhee4mGPzdYQe5hBnpm/S59iF18Er2/n4CdKSHAK9HRJgRRrShx
	b9JTqE5xiYczlkDZHhKXfy2HhlUvo0TzlWWMExjlZyF5YRaSF2YhbFvAyLyKUTK1oDg3PbXY
	tMAwL7UcHrHJ+bmbGMEJXstzB+PdBx/0DjEycTAeYpTgYFYS4ZW7fDJNiDclsbIqtSg/vqg0
	J7X4EKMpMIgnMkuJJucDc0xeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9
	TBycUg1MLlvVZbtcrJlWhG2+ovWvUrW2l3f+5Fuy0W8+vUjtePC44OzEJ2XrfCyVOLeonU8U
	iPLaIm1Q0rr5x/32AB/pSq9FpdKcJb4yAlx7p506Zem7QWHFzJ9tMf/tVuWesK9/rf41L65B
	pX81/4XpeeWZMXWdKv3/SuMWy6npv9x4jX2p0Laromdcm6q9OyeFHTH9emQS85KVWRo7j5cv
	O5PifPfhWTOnWe0Hdkf8/iq9c3VPSeu0hyW7pkV2V2tu+Gnb8+VF15zpljo+PUc8P+UkW9V7
	3lA2NA+4XTO3ONNW3sLq/f7kT7mvtrquzdh/4rbror0ZbW/Mo1Zk3Fy83A8Yzh37PpdH7G82
	eH6zbpESS3FGoqEWc1FxIgA23QnseQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvO7T7WfSDN58UbVYfbefzeL14U+M
	FtM+/GS2+H/3OZPFzQM7mSxWrj7KZDF7ejOTxZP1s5gtNvZzWDy+85nd4ueyVewWR/+/ZbOY
	dOgao8XeW9oWlxa5W+zZe5LFYv6yp+wW3dd3sFksP/6PyWLd6/csFudnzWF3EPW4fMXb4/y9
	jSwe0yadYvO4fLbUY9OqTjaPzUvqPXYv+MzksftmA5vHx6e3WDz6tqxi9Diz4Ai7x+dNcgE8
	UVw2Kak5mWWpRfp2CVwZ1/92MRe8U69YeHMtewPjFYUuRk4OCQETie/3j7OA2EIC2xkl1t3U
	hoiLSzRf+8EOYQtLrPz3HMjmAqr5yCixqO0EWxcjBwebgKbEhcmlIHERgclMEk0Pt7CAOMwC
	c5gklnduZwbpFhawkGjZswlsA4uAqkTztulMIM28ApYSZ3/ZQCyQl5h56TvYMk4BK4n/H96z
	QxxkKbHyzHIwm1dAUOLkzCdgY5iB6pu3zmaewCgwC0lqFpLUAkamVYyiqQXFuem5yQWGesWJ
	ucWleel6yfm5mxjBMakVtINx2fq/eocYmTgYDzFKcDArifDKXT6ZJsSbklhZlVqUH19UmpNa
	fIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cBkmPY2Mi/R9G8gR1Bh95Ms904Nlp6o
	9NMb/yuedz2UvvJAxdXJtgHKaUUayWb+6/KdL+8pelEcOzfz11+BIns//ZniNVbrF7C4cApu
	Zp68p+N6bYzc5+1rnjQw9V93XRqx05DP09LBgodzZqBE5O/Hdo6Bmj33sh8ebVTvanPqnTUx
	WYE14+lKq9O7qnc8Dz+oJMf+1+C+ndH5EK47M6xyOD2+9yYZrbwm/qfoSuqV1Cffv2w6uinV
	Jv1J+T6mmOi3HMLTttsLtH10yC95LXLRv+7j3y8/v6mnvLOt0VnGJ7rqTso56VWFK2I/MPR+
	zZ4hkL7ioZ/CpIiKBywKC8Kl+F4oMwX+tvSeaXs4V4mlOCPRUIu5qDgRAE0F3PY4AwAA
X-CMS-MailID: 20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5
References: <20240826170606.255718-1-joshi.k@samsung.com>
	<CGME20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5@epcas5p3.samsung.com>

Rename enum rw_hint to rw_life_hint.
Change i_write_hint (in inode), bi_write_hint (in bio) and write_hint
(in request) to use u8 data-type rather than this enum.

This is in preparation to introduce a new write hint type.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/buffer.c               | 4 ++--
 fs/f2fs/f2fs.h            | 4 ++--
 fs/f2fs/segment.c         | 4 ++--
 include/linux/blk-mq.h    | 2 +-
 include/linux/blk_types.h | 2 +-
 include/linux/fs.h        | 2 +-
 include/linux/rw_hint.h   | 9 ++-------
 7 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e55ad471c530..0c6bc9b7d4ad 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -55,7 +55,7 @@
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-			  enum rw_hint hint, struct writeback_control *wbc);
+			  u8 hint, struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
@@ -2778,7 +2778,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
 }
 
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-			  enum rw_hint write_hint,
+			  u8 write_hint,
 			  struct writeback_control *wbc)
 {
 	const enum req_op op = opf & REQ_OP_MASK;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ac19c61f0c3e..b3022dc94a1f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3756,8 +3756,8 @@ int f2fs_build_segment_manager(struct f2fs_sb_info *sbi);
 void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init f2fs_create_segment_manager_caches(void);
 void f2fs_destroy_segment_manager_caches(void);
-int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint);
-enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_life_hint hint);
+enum rw_life_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 			enum page_type type, enum temp_type temp);
 unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 			unsigned int segno);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78c3198a6308..794050f4cdbf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3381,7 +3381,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	return err;
 }
 
-int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint)
+int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_life_hint hint)
 {
 	if (F2FS_OPTION(sbi).active_logs == 2)
 		return CURSEG_HOT_DATA;
@@ -3425,7 +3425,7 @@ int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint)
  * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
  * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
  */
-enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+enum rw_life_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 				enum page_type type, enum temp_type temp)
 {
 	switch (type) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8d304b1d16b1..1e5ce84ccf0a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -159,7 +159,7 @@ struct request {
 	struct blk_crypto_keyslot *crypt_keyslot;
 #endif
 
-	enum rw_hint write_hint;
+	u8 write_hint;
 	unsigned short ioprio;
 
 	enum mq_rq_state state;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 36ed96133217..446c847bb3b3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -216,7 +216,7 @@ struct bio {
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
-	enum rw_hint		bi_write_hint;
+	u8			bi_write_hint;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fb0426f349fc..f9a7a2a80661 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -674,7 +674,7 @@ struct inode {
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
 	u8			i_blkbits;
-	enum rw_hint		i_write_hint;
+	u8			i_write_hint;
 	blkcnt_t		i_blocks;
 
 #ifdef __NEED_I_SIZE_ORDERED
diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
index 309ca72f2dfb..e17fd9fa65d4 100644
--- a/include/linux/rw_hint.h
+++ b/include/linux/rw_hint.h
@@ -7,18 +7,13 @@
 #include <uapi/linux/fcntl.h>
 
 /* Block storage write lifetime hint values. */
-enum rw_hint {
+enum rw_life_hint {
 	WRITE_LIFE_NOT_SET	= RWH_WRITE_LIFE_NOT_SET,
 	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
 	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
 	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
 	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
-} __packed;
-
-/* Sparse ignores __packed annotations on enums, hence the #ifndef below. */
-#ifndef __CHECKER__
-static_assert(sizeof(enum rw_hint) == 1);
-#endif
+};
 
 #endif /* _LINUX_RW_HINT_H */
-- 
2.25.1


