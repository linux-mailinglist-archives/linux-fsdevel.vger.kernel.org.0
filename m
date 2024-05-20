Return-Path: <linux-fsdevel+bounces-19792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB68C9C7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502C91F210F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F07580D;
	Mon, 20 May 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HDoz4gJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66074E3F
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205525; cv=none; b=PECO1YJWnRoSXjL/iDSLPRcB8oCCVsZK/xeY7bSD6R/9Y2z0ulm+hlQ8H3A4uj1DveNfon1zrShLH7OOfvs8Hv+eixfyur+PXciH5hGU856skEEGbMnQkMM7HBXsfgiGFtvF4RanVE5Auuh2dfhZDJJYRcSp0q8bO6nmwU5Ip94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205525; c=relaxed/simple;
	bh=j3MX9uE/to6vHmgEXOSBH9WWWHt04pmktDS08ErKkqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=fkkx2ML/kM3peyfIbi3RlSiGJNhUUty309fwP/FmV47zHuNeBjSh/cNOc+4myEZMwFQRiwqZKZ4qzU5IwRc6Wjxop7ienVdAsA3/Ja9cqJR3P5Nqpex6/kyfDDJ64lWlYBQuhzmV3BpuSM65scIQkkcvn3nxb46nTdUvM1F7M+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HDoz4gJw; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240520114522epoutp03892f6e4638a879162a264bf615ac2037~RL9RphOSp1758617586epoutp03h
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240520114522epoutp03892f6e4638a879162a264bf615ac2037~RL9RphOSp1758617586epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205522;
	bh=k3ZzCJqgdNN/MTkGUl0/6z5ZTfmIadxi7gg3Kolrnkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDoz4gJws/cBVq8ODqtGB+kpjj9iMTiZhBNzcNn5uOZ+M1WXy85aCppjWBbQDTV3R
	 W53Fe9K8UszdxqG2p5t4d10QhDuH2qWfVf7XbngwZI5qlNUmKJgMwx7Ve1zrv1gXJ8
	 gFz/KrepcbBLAqTgMkV+1IkQ4KlfmYmoTwqsfvBw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240520114521epcas5p2e48ea1278eee17e99710573981dce0eb~RL9RCh5a93085730857epcas5p21;
	Mon, 20 May 2024 11:45:21 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VjbNJ2y4Tz4x9Pw; Mon, 20 May
	2024 11:45:20 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.3D.09666.0D73B466; Mon, 20 May 2024 20:45:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240520103004epcas5p4a18f3f6ba0f218d57b0ab4bb84c6ff18~RK7iKHGbB1831418314epcas5p4t;
	Mon, 20 May 2024 10:30:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240520103004epsmtrp1decb440a9d79f03d4fd2c7882c043635~RK7iJLyfK2107921079epsmtrp1C;
	Mon, 20 May 2024 10:30:04 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-0a-664b37d00754
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.78.08924.C262B466; Mon, 20 May 2024 19:30:04 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520103000epsmtip2f410f05b749878c57352c028ac2515be~RK7ee83R-2248422484epsmtip27;
	Mon, 20 May 2024 10:30:00 +0000 (GMT)
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
Subject: [PATCH v20 09/12] dm: Add support for copy offload
Date: Mon, 20 May 2024 15:50:22 +0530
Message-Id: <20240520102033.9361-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe1BUdRTH+927e1mYFi8LxQ8kwutAPAJ3E9Yf8hCL6hI9aGpsNBvagcsj
	2MfsQ0v/kFVW5C0SYasEkQjsEpsLuDykdhZ1DQUCXByZwJogAqYkNHvwatmF+u9zvr/zPefM
	+c3h4LwVwpeTLVEycokolyLcWJf7QkLCv9uVnMG3NZLI0H8dR8dPr+BIP1FOoPm+RYA+Wfgb
	R1PmAoCWBoZw1H59EqC6+hoWumvuwtCV+jMYatZfw9C56hMYurb2K4HOWMYAmrZpMdQ7HoY+
	P3mBha70fstCo93nCVR7cdoFNVpXMVRxyoahzik1QJeXanHUOn+fhW6Mb0VDK1Z2gh89ejuZ
	7q+HdJd2woUemrzEokcHVLRRV0jQbReO0b+0fQronrt5BP1FWSWbLj3xG0F3ae6x6d+nx1n0
	/a9tBF3WrgP0rbqrLimeB3JisxhROiMPYCRp0vRsSWYclfxW6gupUUK+IFwQjXZRARKRmImj
	El9NCX8pO9e+ISrgkChXZZdSRAoFtSM+Vi5VKZmALKlCGUcxsvRcWaQsQiESK1SSzAgJo9wt
	4POfi7Invp+T9b3JgslafD4smjlL5IFBryLgyoFkJPzm7CRWBNw4PLIHQE1DAXAGiwBaH7aw
	17N45CMAbff4m44iUzHLmdQL4NypbsIZaDA4Ot9ir8XhEGQYvLnGWde9SD0Oi9sqHA6cbMOh
	us+MrZfyJGNgY0GTyzqzyED4z4NaRzsuuRvWVH+JO9s9DfVfmR3satfNHQuO+SCpd4XLD2dZ
	zqRE2FDa6OJkTzhnbd9gXzhbfnKDD8Pmj5sIpzkfQO0dLXA+7IGa/nJ8fWycDIGG7h1O+SlY
	1d/qGBQn3WHp0hTm1Lmw87NN3g5bDHWEk33g2J/qDaah7Xgb7lxLKYCWBRN2Gvhr/29RB4AO
	+DAyhTiTUUTJBBLm8H//liYVG4HjDkKTOsHEDwsRFoBxgAVADk55cY3tSRk8brrooyOMXJoq
	V+UyCguIsm+wAvd9Ik1qPySJMlUQGc2PFAqFkdE7hQLKmzuvqUnnkZkiJZPDMDJGvunDOK6+
	eVhHziFpye2RhqLpB52VqyOFxuDAxAK9lPOu+sAbkxc91gRPHozdHphfGhAUL37Ns+Qx94L9
	V88Fyl9u8riVkBK8NHRMcr5ha4IkzLSnlTXg5r+vNzh2xHsbNyhPJwsTWh839mz5QEWNQZ3k
	9RdXfNTjw8+E/Nzh/07ywdW0mKFLRzUF7PIMwT4wbHWVepu8qqCaKSne+dPe6ecX3fvcawVH
	t43tF+e9YghuNmZUP0JjTaq/orp959OCBusNicva2diyH99kU6l/+HncmBk3sZPXhldW3zuy
	7J+/Jc7LL6m6a7CqkMAGpJhauSqa4719M97sUY7daRmc0XWMGmKeDZ2spFiKLJEgFJcrRP8C
	7o32NJAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0xSYRjG+c45HA4YdkK3jsXWYF01SddlX1ktV21fc+uy5rTWlqRHuwAx
	ULO2SrMsSc3sYlmkmdNAuwheILMxvHQzKQlNy3Iu0uYs7DKTZhe0/vvteZ73ff54KFxkImZQ
	e1TJrEYlV0hJAVHXJJ0VunBuVGJYjkUM7zxpxeGx/HEcVvaeIeFQ0xcAL3rGcPjedhLAn88c
	OKxpfQtgSamegN02KwbvlxZg0FDZgsErhZkYbPk9TMICeyeAblcRBht7QuD1rDIC3m98TEDn
	vaskLC5382DFw18YPHvKhUHL+wwA634W4/D20GcCPuqZCR3jD7lrxMj5Mgo9KWWQtaiXhxxv
	qwnkfJaCTMZsEpnLjqJB82WAGrrTSXQj7xwX5WZ+IpH1xDsuGnH3EOjzAxeJ8mqMALWVNPM2
	B2wXrExgFXtSWc2i1XGC3W/q7Zi6KihNN3CJTAftgTrApxh6CaOrP03ogIAS0Q2AcbjzeJNG
	EFM+3oxPcgBj+DXAmwxlYkzFiyFSByiKpEOYp78pnx5I1+PMSOZpzHeA0y0487wK+jiAjmAq
	Tt6ceErQcxjv12Kuj4X0CkZfeOtfwSym8q5tgvl/dVutB/hYRC9ners8ZD7wLwEcIwhi1Vpl
	klIbrg5XsQdkWrlSm6JKksXvV5rAxKzBCyyg3uiR2QFGATtgKFwaKDTVbEgUCRPkBw+xmv07
	NSkKVmsHMylCOl04fTA3QUQnyZPZfSyrZjX/XYziz0jH8BD9q1pLR2Qv/0dauSRVFepvLi9c
	uCUlTLH2RsGhpVaJX3RJarcjXTmmaUWHw3OPRls/btjWNM3/msP7wS08ggbmfT/sp29T7x0O
	W7BRlLV9IO77wa5VCtvZK/P4GdFe7dIGu8FrHqmEzsFTkbGzY72r+4xTN6WdcfKMzYteRCgk
	ncP9MaY2xZocR+j6rbJ4Y36EuT1qyrn2iqeN4g+Jb/ra8j3i+ETxGPVNnD3auTfmoysrdZ3h
	h+yVX0t/8LTargLOeZdkyxT2rjVuccdOTkxdZHZuFWdQX3vMmIzdeT3/nqVz9HiGY7RYQgv6
	cqovcJfRBGdH9c0lPbv6DR1SQrtbHh6Ma7TyP0LTr7VFAwAA
X-CMS-MailID: 20240520103004epcas5p4a18f3f6ba0f218d57b0ab4bb84c6ff18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520103004epcas5p4a18f3f6ba0f218d57b0ab4bb84c6ff18
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520103004epcas5p4a18f3f6ba0f218d57b0ab4bb84c6ff18@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Before enabling copy for dm target, check if underlying devices and
dm target support copy. Avoid split happening inside dm target.
Fail early if the request needs split, currently splitting copy
request is not supported.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-table.c         | 37 +++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  7 +++++++
 include/linux/device-mapper.h |  3 +++
 3 files changed, 47 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index cc66a27c363a..d58c67ecd794 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1899,6 +1899,38 @@ static bool dm_table_supports_nowait(struct dm_table *t)
 	return true;
 }
 
+static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
+				   sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return !q->limits.max_copy_sectors;
+}
+
+static bool dm_table_supports_copy(struct dm_table *t)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	for (i = 0; i < t->num_targets; i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->copy_offload_supported)
+			return false;
+
+		/*
+		 * target provides copy support (as implied by setting
+		 * 'copy_offload_supported')
+		 * and it relies on _all_ data devices having copy support.
+		 */
+		if (!ti->type->iterate_devices ||
+		    ti->type->iterate_devices(ti, device_not_copy_capable, NULL))
+			return false;
+	}
+
+	return true;
+}
+
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
@@ -1975,6 +2007,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		limits->discard_misaligned = 0;
 	}
 
+	if (!dm_table_supports_copy(t)) {
+		limits->max_copy_sectors = 0;
+		limits->max_copy_hw_sectors = 0;
+	}
+
 	if (!dm_table_supports_write_zeroes(t))
 		limits->max_write_zeroes_sectors = 0;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 597dd7a25823..070b41b83a97 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1717,6 +1717,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	if (unlikely(ci->is_abnormal_io))
 		return __process_abnormal_io(ci, ti);
 
+	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
+	    max_io_len(ti, ci->sector) < ci->sector_count)) {
+		DMERR("Error, IO size(%u) > max target size(%llu)\n",
+		      ci->sector_count, max_io_len(ti, ci->sector));
+		return BLK_STS_IOERR;
+	}
+
 	/*
 	 * Only support bio polling for normal IO, and the target io is
 	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 82b2195efaca..6868941bc7d9 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -397,6 +397,9 @@ struct dm_target {
 	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
 	 */
 	bool needs_bio_set_dev:1;
+
+	/* copy offload is supported */
+	bool copy_offload_supported:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.17.1


