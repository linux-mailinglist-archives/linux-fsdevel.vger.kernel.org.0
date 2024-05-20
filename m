Return-Path: <linux-fsdevel+bounces-19787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45628C9C64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B824B21B7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1353815;
	Mon, 20 May 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bN89vSds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38876BB5E
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205500; cv=none; b=S5xi99ceMlPJy0eA5tn3+FObcRqYtX7yO7BS6SHn0K2FCF0fmVGLruZ7G9JHej5dNlCOTWlOgvTdyJGCbN0w/TZKosyZeNWtpqcoC1zSP/Sm5RKHqPdKf5sFFgyezK5oooNtu01jiNvu0V5Og+T3WATdoshQ9Vzi0I6OPHx7VN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205500; c=relaxed/simple;
	bh=dDlxmNUmdyaVy+5Tx3fIDMiF0+e6QmCyIAL4BMRQDco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=ibhc1FcoWJzJhDanW8to/SaOi8gZ9/8nTNVTZAYRkcYuMMO6QYzA6oo0rTkp1jmdLMOds/Mj6IOhpAWyHC3HV/JjoQOkFgPbOYYacHZdrN7mWxoZgMG08qil1QGPWsuqCLGCYVBn9ypOGSvpxYC+OI9j8akxLBhBBGcefNdhoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bN89vSds; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240520114457epoutp02810059cea995cb9f82d8d5178cf2a12c~RL86Q4ZxQ1030810308epoutp02S
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:44:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240520114457epoutp02810059cea995cb9f82d8d5178cf2a12c~RL86Q4ZxQ1030810308epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205497;
	bh=KzugG4K2NaDtQ5yBa1aGRu+hsulTFMGc6SCKJgEm9mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bN89vSdsi736X9E0FW+BxlXh0yG33o0Kjnj/pAP9JDHXfKkv9QM46WuSqDQ+KVqle
	 nwJdtIDIo5M0uF9+rHEZyq96uZTDOsvQiwYw2tZ997GLlewkqjaFEkvjC31fghFD60
	 YIyeVi7CxswNpBzHM7PQr8b6rJOLB8IFrrxnIVJA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240520114456epcas5p212c90913d64d86a15d7b279f82a18c9c~RL85TzU9v3085730857epcas5p20;
	Mon, 20 May 2024 11:44:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VjbMp1ljMz4x9Py; Mon, 20 May
	2024 11:44:54 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.0D.09666.5B73B466; Mon, 20 May 2024 20:44:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240520102906epcas5p15b5a0b3c8edd0bf3073030a792a328bb~RK6rliQlI1728917289epcas5p1S;
	Mon, 20 May 2024 10:29:05 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240520102905epsmtrp169417753e2cc00699cbe79d756354e11~RK6rkZBPI2026720267epsmtrp1N;
	Mon, 20 May 2024 10:29:05 +0000 (GMT)
X-AuditID: b6c32a49-cefff700000025c2-cd-664b37b55210
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.ED.09238.1F52B466; Mon, 20 May 2024 19:29:05 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102901epsmtip201169637c5bcedb66ae04a739ad6f033~RK6nifmXN2248422484epsmtip2r;
	Mon, 20 May 2024 10:29:01 +0000 (GMT)
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
	Shetty <nj.shetty@samsung.com>, Vincent Fu <vincent.fu@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 04/12] block: add emulation for copy
Date: Mon, 20 May 2024 15:50:17 +0530
Message-Id: <20240520102033.9361-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTa1BUZRie75zl7C7N1hmw/CAxZrUpcVhYYpcPAm3KaQ4ukxSjSVF4Yg+X
	AZZlzy5KTggSCihyUWlYRIFdQMARheUm1yBAIaQRWQTjki5ORMitLIeAWBbr3/M+7/s+zzfP
	Ny8Pt1kl7HkRCjWjUtBRQsKaU9e5y8m5zkMW6mo04qiqtxtHJ7NWcFQ5lkmgmc5FgHLnn+PI
	1H4aoOX+ARwZuscBKiwu4KCR9kYMNRfnYKi8sgtD+d8lY6hrbZZAOR1GgKaGtBhqGd2Nik7p
	Oai55Q4HDd66RKArpVNcVNaziqHs1CEMNZiSAKpbvoKj6zNzHHR79HX0+EwqQAMrPVbvOVCD
	92VUbzGkGrVjXGpg/CaHGuzXUNUVaQRVoz9B/VqTB6imkUSC0p07b0VlJD8lqMaUCStqYWqU
	Q821DhHUOUMFoH4s/IHrb/tZpHc4Q8sZlSOjCImRRyjCfISygOAPgiVSV7Gz2BN5CB0VdDTj
	I9zn5+/8YUTUekxCxzg6SrNO+dMsK3TZ462K0agZx/AYVu0jZJTyKKW7UsTS0axGESZSMGov
	saurm2R98Ehk+MjaU66y7f1jpnIjlggeSdIBjwdJd1jb4pEO+DwbsgnABzo3C14EsPqRKh1Y
	r+NnAObrfsHMDfN8fcmfmKXRAuDShB5YihQMZj38h2tWJcjdsG+NZ+a3kJU4PFOTzTEXOPkA
	hyU3nmxI2ZIIdszc5Zoxh3wT5jX1cczLAtIT1ppEFrc3YOWNdtyM+aQXbK+d3zCDZA0fDrYa
	uZahfXDlScXm82zhbz2GTd4eTmee2sRHYfmFq4Rl+VsAtcNaYGnshSm9mbjZGCd3wapbLhba
	AV7svb6hiZMvw4xl06a+ADZcfoF3wGtVhYQF20HjX0mEJVIKZl/73BJKBoDTv18lssB27f8O
	hQBUADtGyUaHMaxEKVYwR//7s5CY6GqwcQhOvg1gbHJe1AEwHugAkIcLtwiqDb6hNgI5Hf81
	o4oJVmmiGLYDSNbzy8btXw2JWb8khTpY7O7p6i6VSt0935GKhVsFMykFchsyjFYzkQyjZFQv
	9jAe3z4RI6V763fqfzYkjOZLzrddiMOUP/3R9LZtwr1tewIDRZdU0ysB45/IpoNc5lr4XiV5
	/ICBDC8Hh7bjEbGdXQUTD+OdEtUviXxzXIqGMr5vmlxYTom1HtavNuvEs4ElxwSta1MBduN3
	RAdH/Ny6D+XKmZBXRlWX61NPpHseOIt9k/spW1fAStLKLvbNBx901nCXSotiQ5srg2Sl7yZ/
	dWhYP1v4d8OzgcOvpd1L3H7XLv7+W/Uf2ZTUV9BJQXELO76Yxrr03atU4ultj4t2Fm/V1g32
	2cj6/W8mHQn1T+g9PvdxB82pLZu0p9y+HNAZorwHTx7YvxStM5gO6wP1i7dpP/v9z4UcNpwW
	O+Eqlv4XIAOT35EEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTYRjG+845nh2F5WmTPHZRWdnNnC2KPqPMQvSEIgVRdiFbelylTttm
	WRKay9RJakrpzJhNuzjLdFszL5lMl6Wphak5mEE5DEydhdmFaTrpv4f39zzv88JLoJx6bAVx
	VixjJGJhPA93wQxtPC+/KZ+w2C05k1vg085XKMwosKOw2pKPw7G27wDetv1G4UhrFoB/u3tR
	qH81DGC5+i4Gh1obENisLkRgVbUJgXeK5Qg0zY3jsNA4AKC1vxSBL8y+8N71Sgw2v3iDwb7G
	MhyqHlhZ8GHHLAJvZvcj8PnIVQANf1UorBmbxOBr80r4JTcbwF57h1PQarrvQxjdqabohlIL
	i+4drsPovu5kWqvJwWldZRr9VacEdNNQOk5X5BU50TfkEzjdkPnJiZ6ymjF6sqUfp/P0GkC/
	LW9nHeAec9kVw8SfvcBI/ANPuZwZmptgJb3clzJSNYCkg8/bFcCZoMhtVP39aUQBXAgO2QQo
	U98PsAg8qAf2dnRRc6mq2VHWokmOUJ8fTcwDgsBJX6prjliYu5H1KDUlz3VsQslvKNU984G1
	kOaSkDKO9Tg0RvpQyqYubCHMJgOoZyP8xQIvqrq21VHmTO6kWp/ZHEdw5i2WQRteAJaWgyUa
	4MEkSRNECdGCJIGYuciXChOkyWIRPzoxQQscv9204TkYVs3yjQAhgBFQBMpzY2v1+2M57Bjh
	pcuMJDFKkhzPSI1gJYHx3NmCkjsxHFIklDFxDJPESP5ThHBekY6I/Jf5ufF+iCLOKVIEj82D
	T9ALJ9qe/JEpS9DmK3KD5+8Dobe7Zq/8Gvw4A6a577P7f2X15DWfCNDVueamDmTLjv8s1uxy
	PvnOpI9TedQdjlOvMm5rV4dLOu2l+uOna26Vb3RrKQu3r/UvCjDnrw/2xL4dsZqITK2Bq9AJ
	2gonePXLx1VLfN3zD8q4NQfZhzuepnZc21FVu9lHNnqE0CpSNtqie89vPvrOe2uAa8ia5aGa
	KLNYlujXYtGLigfylcesnl45JXt7ggMjdjbakoPWGOAhDNmd1phyPuv7eOOnHTPL1iuu+nEg
	Oo1Gev/RWU7tyYjih9QaRpWlWesiK3iY9IxQsAmVSIX/ACP3pNxKAwAA
X-CMS-MailID: 20240520102906epcas5p15b5a0b3c8edd0bf3073030a792a328bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102906epcas5p15b5a0b3c8edd0bf3073030a792a328bb
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102906epcas5p15b5a0b3c8edd0bf3073030a792a328bb@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

For the devices which does not support copy, copy emulation is added.
It is required for in-kernel users like fabrics, where file descriptor is
not available and hence they can't use copy_file_range.
Copy-emulation is implemented by reading from source into memory and
writing to the corresponding destination.
At present in kernel user of emulation is fabrics.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-lib.c        | 223 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   4 +
 2 files changed, 227 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e83461abb581..e0dd17f42c8e 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -26,6 +26,20 @@ struct blkdev_copy_offload_io {
 	loff_t offset;
 };
 
+/* Keeps track of single outstanding copy emulation IO */
+struct blkdev_copy_emulation_io {
+	struct blkdev_copy_io *cio;
+	struct work_struct emulation_work;
+	void *buf;
+	ssize_t buf_len;
+	loff_t pos_in;
+	loff_t pos_out;
+	ssize_t len;
+	struct block_device *bdev_in;
+	struct block_device *bdev_out;
+	gfp_t gfp;
+};
+
 static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
@@ -307,6 +321,215 @@ ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
 }
 EXPORT_SYMBOL_GPL(blkdev_copy_offload);
 
+static void *blkdev_copy_alloc_buf(ssize_t req_size, ssize_t *alloc_size,
+				   gfp_t gfp)
+{
+	int min_size = PAGE_SIZE;
+	char *buf;
+
+	while (req_size >= min_size) {
+		buf = kvmalloc(req_size, gfp);
+		if (buf) {
+			*alloc_size = req_size;
+			return buf;
+		}
+		req_size >>= 1;
+	}
+
+	return NULL;
+}
+
+static struct bio *bio_map_buf(void *data, unsigned int len, gfp_t gfp)
+{
+	unsigned long kaddr = (unsigned long)data;
+	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long start = kaddr >> PAGE_SHIFT;
+	const int nr_pages = end - start;
+	bool is_vmalloc = is_vmalloc_addr(data);
+	struct page *page;
+	int offset, i;
+	struct bio *bio;
+
+	bio = bio_kmalloc(nr_pages, gfp);
+	if (!bio)
+		return ERR_PTR(-ENOMEM);
+	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, 0);
+
+	if (is_vmalloc) {
+		flush_kernel_vmap_range(data, len);
+		bio->bi_private = data;
+	}
+
+	offset = offset_in_page(kaddr);
+	for (i = 0; i < nr_pages; i++) {
+		unsigned int bytes = PAGE_SIZE - offset;
+
+		if (len <= 0)
+			break;
+
+		if (bytes > len)
+			bytes = len;
+
+		if (!is_vmalloc)
+			page = virt_to_page(data);
+		else
+			page = vmalloc_to_page(data);
+		if (bio_add_page(bio, page, bytes, offset) < bytes) {
+			/* we don't support partial mappings */
+			bio_uninit(bio);
+			kfree(bio);
+			return ERR_PTR(-EINVAL);
+		}
+
+		data += bytes;
+		len -= bytes;
+		offset = 0;
+	}
+
+	return bio;
+}
+
+static void blkdev_copy_emulation_work(struct work_struct *work)
+{
+	struct blkdev_copy_emulation_io *emulation_io = container_of(work,
+			struct blkdev_copy_emulation_io, emulation_work);
+	struct blkdev_copy_io *cio = emulation_io->cio;
+	struct bio *read_bio, *write_bio;
+	loff_t pos_in = emulation_io->pos_in, pos_out = emulation_io->pos_out;
+	ssize_t rem, chunk;
+	int ret = 0;
+
+	for (rem = emulation_io->len; rem > 0; rem -= chunk) {
+		chunk = min_t(int, emulation_io->buf_len, rem);
+
+		read_bio = bio_map_buf(emulation_io->buf,
+				       emulation_io->buf_len,
+				       emulation_io->gfp);
+		if (IS_ERR(read_bio)) {
+			ret = PTR_ERR(read_bio);
+			break;
+		}
+		read_bio->bi_opf = REQ_OP_READ | REQ_SYNC;
+		bio_set_dev(read_bio, emulation_io->bdev_in);
+		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+		read_bio->bi_iter.bi_size = chunk;
+		ret = submit_bio_wait(read_bio);
+		kfree(read_bio);
+		if (ret)
+			break;
+
+		write_bio = bio_map_buf(emulation_io->buf,
+					emulation_io->buf_len,
+					emulation_io->gfp);
+		if (IS_ERR(write_bio)) {
+			ret = PTR_ERR(write_bio);
+			break;
+		}
+		write_bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
+		bio_set_dev(write_bio, emulation_io->bdev_out);
+		write_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
+		write_bio->bi_iter.bi_size = chunk;
+		ret = submit_bio_wait(write_bio);
+		kfree(write_bio);
+		if (ret)
+			break;
+
+		pos_in += chunk;
+		pos_out += chunk;
+	}
+	cio->status = ret;
+	kvfree(emulation_io->buf);
+	kfree(emulation_io);
+	blkdev_copy_endio(cio);
+}
+
+static inline ssize_t queue_max_hw_bytes(struct request_queue *q)
+{
+	return min_t(ssize_t, queue_max_hw_sectors(q) << SECTOR_SHIFT,
+		     queue_max_segments(q) << PAGE_SHIFT);
+}
+/*
+ * @bdev_in:	source block device
+ * @pos_in:	source offset
+ * @bdev_out:	destination block device
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
+ *	If native copy offload feature is absent, caller can use this function
+ *	to perform copy.
+ *	We store information required to perform the copy along with temporary
+ *	buffer allocation. We async punt copy emulation to a worker. And worker
+ *	performs copy in 2 steps.
+ *	1. Read data from source to temporary buffer
+ *	2. Write data to destination from temporary buffer
+ */
+ssize_t blkdev_copy_emulation(struct block_device *bdev_in, loff_t pos_in,
+			      struct block_device *bdev_out, loff_t pos_out,
+			      size_t len, void (*endio)(void *, int, ssize_t),
+			      void *private, gfp_t gfp)
+{
+	struct request_queue *in = bdev_get_queue(bdev_in);
+	struct request_queue *out = bdev_get_queue(bdev_out);
+	struct blkdev_copy_emulation_io *emulation_io;
+	struct blkdev_copy_io *cio;
+	ssize_t ret;
+	size_t max_hw_bytes = min(queue_max_hw_bytes(in),
+				  queue_max_hw_bytes(out));
+
+	ret = blkdev_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len);
+	if (ret)
+		return ret;
+
+	cio = kzalloc(sizeof(*cio), gfp);
+	if (!cio)
+		return -ENOMEM;
+
+	cio->waiter = current;
+	cio->copied = len;
+	cio->endio = endio;
+	cio->private = private;
+
+	emulation_io = kzalloc(sizeof(*emulation_io), gfp);
+	if (!emulation_io)
+		goto err_free_cio;
+	emulation_io->cio = cio;
+	INIT_WORK(&emulation_io->emulation_work, blkdev_copy_emulation_work);
+	emulation_io->pos_in = pos_in;
+	emulation_io->pos_out = pos_out;
+	emulation_io->len = len;
+	emulation_io->bdev_in = bdev_in;
+	emulation_io->bdev_out = bdev_out;
+	emulation_io->gfp = gfp;
+
+	emulation_io->buf = blkdev_copy_alloc_buf(min(max_hw_bytes, len),
+						  &emulation_io->buf_len, gfp);
+	if (!emulation_io->buf)
+		goto err_free_emulation_io;
+
+	schedule_work(&emulation_io->emulation_work);
+
+	if (cio->endio)
+		return -EIOCBQUEUED;
+
+	return blkdev_copy_wait_for_completion_io(cio);
+
+err_free_emulation_io:
+	kfree(emulation_io);
+err_free_cio:
+	kfree(cio);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_emulation);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3b88dcd5c433..8b1edb46880a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1083,6 +1083,10 @@ ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
 			    loff_t pos_out, size_t len,
 			    void (*endio)(void *, int, ssize_t),
 			    void *private, gfp_t gfp_mask);
+ssize_t blkdev_copy_emulation(struct block_device *bdev_in, loff_t pos_in,
+			      struct block_device *bdev_out, loff_t pos_out,
+			      size_t len, void (*endio)(void *, int, ssize_t),
+			      void *private, gfp_t gfp);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.17.1


