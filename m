Return-Path: <linux-fsdevel+bounces-19786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F38C9C5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D18E1F23B89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C066BB2F;
	Mon, 20 May 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bb8/hktb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E196D6A00C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205493; cv=none; b=BlGG47+skWJtTJsDAeOFBukrj62vnPbreJ46VBIcLnsrj35XktHnBmRgBSLB9ayx4hp43T1k4iTaJcTQ+njjbmfUIWCgT1/BSjldSZX+sc65C80TiecCuxXyxrSvfi8j+QipD+GuMD5uNTz9X/fOEhJ4+0U/xq5Dq90SeQHV1Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205493; c=relaxed/simple;
	bh=Rie2jTnrYiolLjNDyBVH3DLqZyqJ10GciO4Xq0mERrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=d53KSx4rZAYwgNkjrK9P2xvVRpttf4mlzGIvYhIYsnsN/zH/HR0EYy84y8m1MYfNi22criSHgpJPpOp5W3h3l0JJMS9ow178PbM5Mpvt9R3spsQx071kK13brIKOn84yP1EWslNZi/bL7BRilfImGQXBWl0Aki0Urp5ptg63v44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Bb8/hktb; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240520114448epoutp0462667f5d70669109a0217b760726fa54~RL8x62_Bx2508025080epoutp048
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:44:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240520114448epoutp0462667f5d70669109a0217b760726fa54~RL8x62_Bx2508025080epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205488;
	bh=eUSQE9j14Vy0JyXIjPMM6UBiUlBOzDa6HuAmKoMKPTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bb8/hktb261THpw8MLGi7N2jNmVryNqYHBr19cFEqUskiy9j08PRAhvc8P7u/L+w8
	 iKs6OqyULqAqQCFRwcVBllh8F/7o9AboXlScWyNo7yqDhLRe7Tz+2/5HUPMFCt7zg1
	 hq15yqUlf39tfRZoQr5bmY2pTdIBBwP6WdOkchco=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240520114447epcas5p2125bb61b9966a69fc16f04429520654e~RL8xSeJwP2455024550epcas5p2h;
	Mon, 20 May 2024 11:44:47 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VjbMd5QQ1z4x9Py; Mon, 20 May
	2024 11:44:45 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	10.C9.09665.DA73B466; Mon, 20 May 2024 20:44:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240520102853epcas5p42d635d6712b8876ea22a45d730cb1378~RK6gNvh6Z1363313633epcas5p4m;
	Mon, 20 May 2024 10:28:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240520102853epsmtrp2cd54f4a807d23e90c255b4f734b418f1~RK6gLXkS02133221332epsmtrp2E;
	Mon, 20 May 2024 10:28:53 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-d1-664b37ad2147
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	51.68.08924.5E52B466; Mon, 20 May 2024 19:28:53 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102849epsmtip2a94a8a0cb33c589bd82bf0075fa82437~RK6cdEmpV2182421824epsmtip2G;
	Mon, 20 May 2024 10:28:49 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 03/12] block: add copy offload support
Date: Mon, 20 May 2024 15:50:16 +0530
Message-Id: <20240520102033.9361-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHPfdebgtJ4QZcPDB0WIQJDKRS8GBAzER2kbkxYFmyZGOVXguj
	tE1b5sAtvGQis7wmspXnkGzjZZVWR8tDUh51KJIJSCCDIcJ0Q4FBgmPAWEtx++/z+57v75Hf
	yY+NO66RLuwkiZKRSwRiLmlH3Oz22u/bfCjqtP9qpSfS9PfhKLtoA0eNE4UkmuteAujy4iqO
	ZrrOA7Q2MIgjXd8kQDW1lQQa69JjqL22BEP1jb0YKi/LwVDv5jMSlRgfADQ7osZQx7gP+vaL
	OgK1d/xEoCFDBYmqv5tloe9N/2CoOG8EQ60zWQDdXKvG0dW5BQLdHn8ZDW6YbI660kPDUXR/
	LaT16gkWPTh5naCHBlLploYLJK2ty6CfaL8BdNtYJklfKfjKhlblzJO0PvdXG/rP2XGCXugc
	IekCXQOg79b0sKKd3k8OSWQEQkbuxkgSpMIkiSiUGxUbfyw+MMif58sLRoe4bhJBChPKDX8z
	2jciSWzeENftE4E41SxFCxQK7oEjIXJpqpJxS5QqlKFcRiYUy/gyP4UgRZEqEflJGOVhnr//
	wUCz8aPkxL56LUu2EvbpZF8OKxM8C8gHbDak+LDMZJ8P7NiOVBuAs+0mPB/YmoMlALPHX7Py
	CoClF2UWtvjV5RukNaEDwIdP+raDXAxevtIJLFVJygfe2WRb9J1UIw6/1BYTlgCntDjM6u7C
	LKWcqMPw7+VmloUJygPOVxRsMYcKhpUlOtza7hXYeK1ri23N/q4bi8BSCFIaW/hcpyespnC4
	+rRrm53gHyYdy8oucHm+g7TyGVh/6QfSmnwOQPWoGlgfwmBufyFuGRunvKDGcMAq74al/Ve3
	BsUpe6ham8GsOge2Vr1gd9ikqdmu7wwfPM/aZhqqfx4A1rWoAFxeL7UpAnvU/7eoAaABODMy
	RYqIUQTKAiTMmf9+LUGa0gK2rsA7qhVMTy36GQHGBkYA2Th3J6dFF3nakSMUpKUzcmm8PFXM
	KIwg0LzBYtzlpQSp+YwkyngeP9ifHxQUxA8OCOJxd3HmciuFjpRIoGSSGUbGyF/kYWxbl0xs
	utNwazSupNHgMX1f6JDfGfnGjc3hW/rXVy8+feRxnI8u5MbF2KUZCx+fLXStMLjsTf+Q9/ny
	DjeQkeR8W2jDWqEXfnOb3zfDU+Q05sneKri+Y6mqdn5on1dnlEaqG26/f4KtCPrAxsQvX78X
	erK0+S/xu62xsaJfRq+FcvcaT/nzy1q7I72PLO15x/Nx9sc1rktl7zXF+Cy6O0Zcyus5Gc7f
	bLE7tcoxzWXFOfzo/aj3WNH5ez0e6WFjdUdVv7u/rRcxCUbPCNPutP3rGSHrd+395D0P7bnO
	U8Rnu74+odp00LU1vWrojzMc1N4RsqrFWk3KWtXElMpxprD57LmlGF5CEZdQJAp43rhcIfgX
	cQNgCY4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSvO5TVe80g+4DGhbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9FiwaK5LBY3D+xkstizaBKTxcrVR5ks
	Zk9vZrI4+v8tm8WkQ9cYLZ5encVksfeWtsXCtiUsFnv2nmSxuLxrDpvF/GVP2S2WH//HZDGx
	4yqTxY4njYwW237PZ7ZY9/o9i8WJW9IW5/8eZ3WQ8bh8xdvj1CIJj52z7rJ7nL+3kcXj8tlS
	j02rOtk8Ni+p93ixeSajx+6bDWwei/sms3r0Nr9j89jZep/V4+PTWywe7/ddZfPo27KK0ePM
	giPsAcJRXDYpqTmZZalF+nYJXBnHVm5mL/hmX3HvWDN7A+Nb4y5GTg4JAROJWbP/snUxcnEI
	CexmlNi0ZhorREJSYtnfI8wQtrDEyn/P2SGKmpkk7m64wNjFyMHBJqAtcfo/B0hcRGA7s8TH
	5m4mkAZmgaPMEhfWWIDYwgJWEr8+r2UHsVkEVCXezekDs3kFLCXmTtoCtUBeYvWGA2A2J1D9
	ga0fGEFsIaCau9c/sE1g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4WrU0
	dzBuX/VB7xAjEwfjIUYJDmYlEd5NWzzThHhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJI
	TyxJzU5NLUgtgskycXBKNTAZ+Is9mJUb80trr1Xig3VrM+O1u+JWWP63/yi1L13uwm/3Dsvr
	vsWdohv7+3rqwx4USR1e2//U426uwYfnK81fcXepb7PuVVkwfXm+2YMGvSMSa1xsgg/8TFhx
	vfTsUtulb902rfba+kdtMqvMWRPuW3pcHVe+xP5I2SE47T27f6DDAp6ER8X3JnMu/HH0Yvhd
	68wz7TNqO63q6i/4uX2Z7Ho2ZP2HjEA29Rmve6+y6iR9li7cukrOXZKXa4/WRn6mriU35j9M
	vbSo/uo62ag56sdkgxmtfkkZyzp7NIRsWzrbUbPKkiUl7crNZH8+mwtXe9/Zaa+W+1TDd1e3
	8n599MzetY86ooqWaAk1xymxFGckGmoxFxUnAgCpfyHoRQMAAA==
X-CMS-MailID: 20240520102853epcas5p42d635d6712b8876ea22a45d730cb1378
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102853epcas5p42d635d6712b8876ea22a45d730cb1378
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102853epcas5p42d635d6712b8876ea22a45d730cb1378@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Introduce blkdev_copy_offload to perform copy offload.
Issue REQ_OP_COPY_DST with destination info along with taking a plug.
This flows till request layer and waits for src bio to arrive.
Issue REQ_OP_COPY_SRC with source info and this bio reaches request
layer and merges with dst request.
For any reason, if a request comes to the driver with only one of src/dst
bio, we fail the copy offload.

Larger copy will be divided, based on max_copy_sectors limit.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-lib.c        | 204 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   4 +
 2 files changed, 208 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 442da9dad042..e83461abb581 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -10,6 +10,22 @@
 
 #include "blk.h"
 
+/* Keeps track of all outstanding copy IO */
+struct blkdev_copy_io {
+	atomic_t refcount;
+	ssize_t copied;
+	int status;
+	struct task_struct *waiter;
+	void (*endio)(void *private, int status, ssize_t copied);
+	void *private;
+};
+
+/* Keeps track of single outstanding copy offload IO */
+struct blkdev_copy_offload_io {
+	struct blkdev_copy_io *cio;
+	loff_t offset;
+};
+
 static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
@@ -103,6 +119,194 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+static inline ssize_t blkdev_copy_sanity_check(struct block_device *bdev_in,
+					       loff_t pos_in,
+					       struct block_device *bdev_out,
+					       loff_t pos_out, size_t len)
+{
+	unsigned int align = max(bdev_logical_block_size(bdev_out),
+				 bdev_logical_block_size(bdev_in)) - 1;
+
+	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
+	    len >= BLK_COPY_MAX_BYTES)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline void blkdev_copy_endio(struct blkdev_copy_io *cio)
+{
+	if (cio->endio) {
+		cio->endio(cio->private, cio->status, cio->copied);
+		kfree(cio);
+	} else {
+		struct task_struct *waiter = cio->waiter;
+
+		WRITE_ONCE(cio->waiter, NULL);
+		blk_wake_io_task(waiter);
+	}
+}
+
+/*
+ * This must only be called once all bios have been issued so that the refcount
+ * can only decrease. This just waits for all bios to complete.
+ * Returns the length of bytes copied or error
+ */
+static ssize_t blkdev_copy_wait_for_completion_io(struct blkdev_copy_io *cio)
+{
+	ssize_t ret;
+
+	for (;;) {
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!READ_ONCE(cio->waiter))
+			break;
+		blk_io_schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	ret = cio->copied;
+	kfree(cio);
+
+	return ret;
+}
+
+static void blkdev_copy_offload_src_endio(struct bio *bio)
+{
+	struct blkdev_copy_offload_io *offload_io = bio->bi_private;
+	struct blkdev_copy_io *cio = offload_io->cio;
+
+	if (bio->bi_status) {
+		cio->copied = min_t(ssize_t, offload_io->offset, cio->copied);
+		if (!cio->status)
+			cio->status = blk_status_to_errno(bio->bi_status);
+	}
+	bio_put(bio);
+	kfree(offload_io);
+
+	if (atomic_dec_and_test(&cio->refcount))
+		blkdev_copy_endio(cio);
+}
+
+/*
+ * @bdev:	block device
+ * @pos_in:	source offset
+ * @pos_out:	destination offset
+ * @len:	length in bytes to be copied
+ * @endio:	endio function to be called on completion of copy operation,
+ *		for synchronous operation this should be NULL
+ * @private:	endio function will be called with this private data,
+ *		for synchronous operation this should be NULL
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ *
+ * For synchronous operation returns the length of bytes copied or error
+ * For asynchronous operation returns -EIOCBQUEUED or error
+ *
+ * Description:
+ *	Copy source offset to destination offset within block device, using
+ *	device's native copy offload feature.
+ *	We perform copy operation using 2 bio's.
+ *	1. We take a plug and send a REQ_OP_COPY_DST bio along with destination
+ *	sector and length. Once this bio reaches request layer, we form a
+ *	request and wait for dst bio to arrive.
+ *	2. We issue REQ_OP_COPY_SRC bio along with source sector, length.
+ *	Once this bio reaches request layer and find a request with previously
+ *	sent destination info we merge the source bio and return.
+ *	3. Release the plug and request is sent to driver
+ *	This design works only for drivers with request queue.
+ */
+ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
+			    loff_t pos_out, size_t len,
+			    void (*endio)(void *, int, ssize_t),
+			    void *private, gfp_t gfp)
+{
+	struct blkdev_copy_io *cio;
+	struct blkdev_copy_offload_io *offload_io;
+	struct bio *src_bio, *dst_bio;
+	size_t rem, chunk;
+	size_t max_copy_bytes = bdev_max_copy_sectors(bdev) << SECTOR_SHIFT;
+	ssize_t ret;
+	struct blk_plug plug;
+
+	if (!max_copy_bytes)
+		return -EOPNOTSUPP;
+
+	ret = blkdev_copy_sanity_check(bdev, pos_in, bdev, pos_out, len);
+	if (ret)
+		return ret;
+
+	cio = kzalloc(sizeof(*cio), gfp);
+	if (!cio)
+		return -ENOMEM;
+	atomic_set(&cio->refcount, 1);
+	cio->waiter = current;
+	cio->endio = endio;
+	cio->private = private;
+
+	/*
+	 * If there is a error, copied will be set to least successfully
+	 * completed copied length
+	 */
+	cio->copied = len;
+	for (rem = len; rem > 0; rem -= chunk) {
+		chunk = min(rem, max_copy_bytes);
+
+		offload_io = kzalloc(sizeof(*offload_io), gfp);
+		if (!offload_io)
+			goto err_free_cio;
+		offload_io->cio = cio;
+		/*
+		 * For partial completion, we use offload_io->offset to truncate
+		 * successful copy length
+		 */
+		offload_io->offset = len - rem;
+
+		dst_bio = bio_alloc(bdev, 0, REQ_OP_COPY_DST, gfp);
+		if (!dst_bio)
+			goto err_free_offload_io;
+		dst_bio->bi_iter.bi_size = chunk;
+		dst_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
+
+		blk_start_plug(&plug);
+		src_bio = blk_next_bio(dst_bio, bdev, 0, REQ_OP_COPY_SRC, gfp);
+		if (!src_bio)
+			goto err_free_dst_bio;
+		src_bio->bi_iter.bi_size = chunk;
+		src_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+		src_bio->bi_end_io = blkdev_copy_offload_src_endio;
+		src_bio->bi_private = offload_io;
+
+		atomic_inc(&cio->refcount);
+		submit_bio(src_bio);
+		blk_finish_plug(&plug);
+		pos_in += chunk;
+		pos_out += chunk;
+	}
+
+	if (atomic_dec_and_test(&cio->refcount))
+		blkdev_copy_endio(cio);
+	if (endio)
+		return -EIOCBQUEUED;
+
+	return blkdev_copy_wait_for_completion_io(cio);
+
+err_free_dst_bio:
+	bio_put(dst_bio);
+err_free_offload_io:
+	kfree(offload_io);
+err_free_cio:
+	cio->copied = min_t(ssize_t, cio->copied, (len - rem));
+	cio->status = -ENOMEM;
+	if (rem == len) {
+		ret = cio->status;
+		kfree(cio);
+		return ret;
+	}
+	if (cio->endio)
+		return cio->status;
+
+	return blkdev_copy_wait_for_completion_io(cio);
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_offload);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 109d9f905c3c..3b88dcd5c433 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1079,6 +1079,10 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
+ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
+			    loff_t pos_out, size_t len,
+			    void (*endio)(void *, int, ssize_t),
+			    void *private, gfp_t gfp_mask);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.17.1


