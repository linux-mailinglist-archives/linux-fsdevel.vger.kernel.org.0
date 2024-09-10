Return-Path: <linux-fsdevel+bounces-29027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE19A973B0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 17:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29111C2411C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9533F19993F;
	Tue, 10 Sep 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MR1lVlYz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298B199926
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981051; cv=none; b=jZIhYo9L1Mpcvdfzv0u8gj7zOqlePu9eMh+n89KOWBuu/k3yeK9Uc8AoddQ2r/uNjbBt94i8/pAxzUF762IKvmLguYdfrwyPKxWlDWkokwHMTbtl/w18i/NXAE5lpbavw+8F/qbhX7Qnc9YIRM54jegnKWoLBTUsEsstK/M4nIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981051; c=relaxed/simple;
	bh=EOmyo3LNS2sTILpDdwkz/wbfnmkFCFhWqsu2zsG1LCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TgAXV++8iOVPqXlSE50ppOPjM6x7c6X/RICwTnbpYUENswYTMvH42v1gD8OU3G7z1N4QhDvVbIXhSTcTMhgw90y2AJYWWCh7HeJZkvrvpiM7Ujw6rZYYpMYaZFL5uHJFJKOlUh5OWsyto+K0xv4zPL1wtVkdfAytvQU/JI5StQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MR1lVlYz; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240910151047epoutp046dfe93b558130e2d1c8bc0b60283c314~z6p4z0cuN1896018960epoutp04c
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 15:10:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240910151047epoutp046dfe93b558130e2d1c8bc0b60283c314~z6p4z0cuN1896018960epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725981047;
	bh=/IM9kt/2eCM14q1kv/IUC0Orm6DmaZVmcMJa34MEri8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MR1lVlYzSD30VBZtqx069poLYGBIZLK5q2LoQsmR4/5PjZgQq5XjNcsW6dFHKHZsh
	 st2K8WomT9u1XxFawNn/w49JQH56GF2fCTbM1dgbPW5G2GWLSmrhyXxbqxC0cKix9i
	 BILLPEeIseL5wjRSStmAhyp87tallMsNMrxZ6FtM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240910151046epcas5p2a26321e41189a2f101cae5ce738de816~z6p4O1QG30258802588epcas5p2V;
	Tue, 10 Sep 2024 15:10:46 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4X36b90Hwwz4x9Pp; Tue, 10 Sep
	2024 15:10:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E8.6F.19863.47160E66; Wed, 11 Sep 2024 00:10:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51~z6p1zgmQ13222332223epcas5p3C;
	Tue, 10 Sep 2024 15:10:44 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240910151044epsmtrp12aae38aee9b01960e33fb0a7289f047d~z6p1ylVlM1255512555epsmtrp1i;
	Tue, 10 Sep 2024 15:10:44 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-3d-66e0617422f1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	06.F3.19367.47160E66; Wed, 11 Sep 2024 00:10:44 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240910151040epsmtip21920684c4863f20fece9a37c05cd1b85~z6pyAtglJ1772517725epsmtip2M;
	Tue, 10 Sep 2024 15:10:39 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v5 1/5] fs, block: refactor enum rw_hint
Date: Tue, 10 Sep 2024 20:31:56 +0530
Message-Id: <20240910150200.6589-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910150200.6589-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzOubfcFreSawV7LIvWxmWAAVp5eCAgLDPzLoo2OhKzzLGmvVDW
	0nZ9zI0QKFNRHhOs1kdhjDmUUHwA1YkKwVSww83BRBiSWZEVeQ036CICc6yl1fnf9/v9vu98
	+X7nHBbOcRM8VrZKT2tVEqWAWMb4/mZ4eKReMpQpPNYrRA0Pygk0eXMGoON/zeFo8cEohu7f
	uIqh+oZODFWe2Ich10ULjprKWej339xMNHfWykSdi1MEMtn7AWobXI/unt6CWtu6GOibsyNM
	VPprC4HqHP9i6MLknwzU/dwRgLotVczUlVTvva1Ut7OJQR033Sao3jsGqtlaTFC22gLqeo0b
	o67fNxLU9Mgggzp8yQqon2o6mJS7eTXV7JrCxOwPFElyWiKjtXxaJVXLslVZyYKtuzLeyYiL
	F4oiRQloo4CvkuTQyYLN28SR72YrPZkF/M8kSoOnJZbodILoTUlatUFP8+VqnT5ZQGtkSk2s
	JkonydEZVFlRKlqfKBIKN8R5iB8r5LXDPYTm1lufd1qf4EZwjl8CAlmQjIUDEz/gJWAZi0O2
	AvjlYmWAr5gB8OFYDfGy6LtgY7yQVNt+9g+uAthlf+yXuAH8buYAVgJYLIIMhz1HDd5+MFmN
	wVs9ncBb4KQJg9ND5wnvUStIBG/3OzEvZpBvQtu4c6nPJjdCc3WT324NPHV3lunFgR7+aN05
	zMdZDrtOuZY4uIez73LlUgpIHgyE87NPgU+8GT4rqyJ8eAWccFxi+jAPjpcX+bECDg0P+c3y
	YIvtcIAPp0DjPwMB3jS4J83Fa9E+ryD41YJrKSQk2fBQEcfHXgudphG/kgsfnaz1Ywr+cszh
	31YpgB3zpYwKsMbySgTLKxEs/7vVANwKeLRGl5NFS+M0okgVvffl3UrVOc1g6fVHiFtAQ+Pz
	KDvAWMAOIAsXBLPLNzkzOWyZ5ItcWqvO0BqUtM4O4jxLPoLzQqRqz/dR6TNEsQnC2Pj4+NiE
	mHiRgMuePPC1jENmSfS0gqY1tPaFDmMF8oxYVlJMcmhwxOPCFG7f3GuFO/A2s3r+jZBdPfnv
	nwxqtfGi37szMFFo5g4/ETtLdlRVpu80dnPMy18P5n5bX2DQ7F61M/dvTFF4BSgOstc5yLDt
	4sFPn2nTmFXF6O1mywndU5W7ce0Evy2tdXvBnghLUTdM0Zovh5KNCfLT/VKVlZ9CdMw3aEft
	HR/G5BdXVGoTU8PmZgT704lcsYtbvLf+2nBiWV1j29hDWXbpqvZ1NTc2tK8/FPpJ6Ef68wlp
	DLV5gR087kj/MXOxwnh0Nv1M0MT+K3l7Yvoss/mjruLVK03yMuWjBXhPemZ3zMh09EjY1JaU
	kOh01h+p25Lb88YUAoZOLhFF4Fqd5D+2Jnc3hgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7bCSvG5J4oM0g81nWSxW3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvF0f9v2Swm
	HbrGaLH3lrbFpUXuFnv2nmSxmL/sKbtF9/UdbBbLj/9jslj3+j2Lxfm/x1ktzs+aw+4g5nH5
	irfH+XsbWTymTTrF5nH5bKnHplWdbB6bl9R77F7wmclj980GNo+PT2+xePRtWcXocWbBEXaP
	z5vkPDY9ecsUwBvFZZOSmpNZllqkb5fAlbHk0QW2gmPqFUdXvWNuYFyj0MXIySEhYCIxb/M5
	ti5GLg4hge2MElevP2aCSIhLNF/7wQ5hC0us/PecHaLoI6NER/cuoA4ODjYBTYkLk0tBakQE
	1jFJrJjmA1LDLDCHSWJ553ZmkISwgIXEqWv3wIayCKhKbH55jw3E5hUwl5g6byMLxAJ5iZmX
	voMt4wSqf758DVi9EFDNh/4FrBD1ghInZz4Bq2cGqm/eOpt5AqPALCSpWUhSCxiZVjGKphYU
	56bnJhcY6hUn5haX5qXrJefnbmIER6pW0A7GZev/6h1iZOJgPMQowcGsJMLbb3cvTYg3JbGy
	KrUoP76oNCe1+BCjNAeLkjivck5nipBAemJJanZqakFqEUyWiYNTqoEpWH3BLjfu3fVNtzP5
	LfcZvZ1sf/ZxD7Pukgv+7AyrZplfkWuV29gVJLP06sYkvzcSh/4f6vmzbmUOr7VZmouS3h2F
	0CaRhu5NrKUzrjMfVw314J7oMVnueo6E+gs/yVLfqUmHLpqF/Xz3yYZdQeSYbtmVtGVLXhQu
	lPhhpZc+bUPz5f/c89/Z6V+SiTcJWca+viP5Ye+ZaXohv9PcdsXfMP7ZWcjgYCOxaF2kwOcz
	/5wt4sXkix5ynXBPCb8uGzBvjeHKsGsMstcU5rzy3BjYq77w66q1IoWS6wN/xxysfPXD97nx
	T9HvOh55PULfTj7VOp/CG/tio1xa0Jzm9CsbhLJ4Du6VWr7hgNmXjgdKLMUZiYZazEXFiQBZ
	huDzQwMAAA==
X-CMS-MailID: 20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51@epcas5p3.samsung.com>

Rename enum rw_hint to rw_lifetime_hint.
Change i_write_hint (in inode), bi_write_hint(in bio), and write_hint
(in request) to use u8 data-type rather than this enum.

This is in preparation to introduce a new write hint type.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/buffer.c               | 4 ++--
 fs/f2fs/f2fs.h            | 5 +++--
 fs/f2fs/segment.c         | 5 +++--
 include/linux/blk-mq.h    | 2 +-
 include/linux/blk_types.h | 2 +-
 include/linux/fs.h        | 2 +-
 include/linux/rw_hint.h   | 4 ++--
 7 files changed, 13 insertions(+), 11 deletions(-)

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
index ac19c61f0c3e..9b843b57dba1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3756,8 +3756,9 @@ int f2fs_build_segment_manager(struct f2fs_sb_info *sbi);
 void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init f2fs_create_segment_manager_caches(void);
 void f2fs_destroy_segment_manager_caches(void);
-int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint);
-enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi,
+			enum rw_lifetime_hint hint);
+enum rw_lifetime_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 			enum page_type type, enum temp_type temp);
 unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 			unsigned int segno);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78c3198a6308..6802e82f9ffd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3381,7 +3381,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	return err;
 }
 
-int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint)
+int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi,
+			enum rw_lifetime_hint hint)
 {
 	if (F2FS_OPTION(sbi).active_logs == 2)
 		return CURSEG_HOT_DATA;
@@ -3425,7 +3426,7 @@ int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint)
  * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
  * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
  */
-enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+enum rw_lifetime_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
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
index 309ca72f2dfb..b9942f5f13d3 100644
--- a/include/linux/rw_hint.h
+++ b/include/linux/rw_hint.h
@@ -7,7 +7,7 @@
 #include <uapi/linux/fcntl.h>
 
 /* Block storage write lifetime hint values. */
-enum rw_hint {
+enum rw_lifetime_hint {
 	WRITE_LIFE_NOT_SET	= RWH_WRITE_LIFE_NOT_SET,
 	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
 	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
@@ -18,7 +18,7 @@ enum rw_hint {
 
 /* Sparse ignores __packed annotations on enums, hence the #ifndef below. */
 #ifndef __CHECKER__
-static_assert(sizeof(enum rw_hint) == 1);
+static_assert(sizeof(enum rw_lifetime_hint) == 1);
 #endif
 
 #endif /* _LINUX_RW_HINT_H */
-- 
2.25.1


