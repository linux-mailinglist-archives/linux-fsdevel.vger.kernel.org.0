Return-Path: <linux-fsdevel+bounces-6779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674A781C5C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A881F259AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2302207A;
	Fri, 22 Dec 2023 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TSOhTFeF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67718647
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231222073242epoutp0155002e9509554ea665fa19fee468a536~jFv2zVVAY0228402284epoutp01X
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231222073242epoutp0155002e9509554ea665fa19fee468a536~jFv2zVVAY0228402284epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230363;
	bh=pMi2KJ6tLswDpsWtY8Cv4RkPJ8GSgmmvRnoKG+rEJEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSOhTFeFlnbAmcgPAmTSIxpXkzJbWyYVOR/BbHGhrYVoDYjcpgFDMErK79OtWaF1r
	 S/e08ibmE3EDAv/rf/gvr1l0UkSE9DKQC63yTSmD+Wyq9+lCRaWOZkJa/9t9bGeQ9t
	 b4aJUrpKB885cTMXUedwABL2WXe8JTSjrOoXzdxE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231222073242epcas5p2e4a4a09ff56f17c4452a1166e77b29c0~jFv2NhXCV1857018570epcas5p2Q;
	Fri, 22 Dec 2023 07:32:42 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SxJt10fm4z4x9Pp; Fri, 22 Dec
	2023 07:32:41 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F2.57.10009.89B35856; Fri, 22 Dec 2023 16:32:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231222062217epcas5p1263b3a88c9e94933ab44be1df86ccfbe~jEyXpfPu-1003410034epcas5p1v;
	Fri, 22 Dec 2023 06:22:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231222062217epsmtrp18acad7daa76e95f3898780e78c18a5a2~jEyXoMX6s1657416574epsmtrp1e;
	Fri, 22 Dec 2023 06:22:17 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-50-65853b988906
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.EE.18939.91B25856; Fri, 22 Dec 2023 15:22:17 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062214epsmtip2890709eff5394d61ae1d575ca7ebbd62~jEyUbT6GN0344503445epsmtip2_;
	Fri, 22 Dec 2023 06:22:13 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v19 09/12] dm: Add support for copy offload
Date: Fri, 22 Dec 2023 11:43:03 +0530
Message-Id: <20231222061313.12260-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH97v39lLYqpcC2w+cWjs1gIO2ULofCnMZZN69EEfiHy5ZqXAH
	hNI2LRXZS96yMh6iGKkgDAhMIHSFjhWYE3GjgjLisCBsuqEF5xpF2BgLBFhL0fnf93zOOb/z
	+OWwcW6xmx87RZHOqBUyOZ/0IDovBwQEndmTzwi770Ugw2A/jmbnlwjUcquURPbLcwDZeo8D
	VFtXTaDx3i4MnW/5EUPlfaMATVn1GLowsQt9WdBAoO8uDBBopLuKRDWNU26oaMxMoibLCoZu
	lk0BdKLQiiGzLRugzqUaHLXZZwh0ZWITGl62sF6DdJf+lhs9fNtI0CNDWrq9+XOS7mg4Rv/R
	UQnonvEskq4vOcmii3MfkvTs1ARBz3xvJekSUzOg/2rfQrfbHmCxGw6lRiQzskRGzWMUCcrE
	FEVSJP/tOGmUNEwiFAWJwtErfJ5ClsZE8qPfiQ16I0XuWAKfd0Qm1zpQrEyj4QtejVArtekM
	L1mpSY/kM6pEuUqsCtbI0jRaRVKwgknfLRIKQ8IcgfGpySs5s7jqB9+j1l9+JbPAtLcOuLMh
	JYaGLD1LBzzYXKoHwOzJ6XVjDsCy3OPYE2PpRjmuA+y1lGWrzMW7ALQ/+pd0PsWl8jFYMXPU
	GUNSu+DVVbYTe1OtOOwyipzxODWOwaGLnZjT4UXtgYaFMZZTE9QOmD1XssY5Dp4zcHG9lgCW
	/ubpxO4OfG+xnuUK8YQDlTbCqXFqK8z95izufB9SNe6wtWWcdI0WDTsWJ3CX9oJ/WkxuLu0H
	75cWrOsMeP7UV6QrOQ9A/ZgeuBx7Yf5g6VoTOBUADd0CF94MKwbbMFfhDbB4yYa5OAeazz3W
	L8FWQ+16D75wdCF7XdOwYd5CuhZXAqBlcRQrAzz9UwPpnxpI/3/pWoA3A19GpUlLYjRhqhAF
	k/HkkxOUae1g7S4C3zKDyd8fBfcBjA36AGTjfG+O8uU8hstJlGV+xKiVUrVWzmj6QJhj4Sdw
	P58EpeOwFOlSkThcKJZIJOLwUImI/wLHnl+dyKWSZOlMKsOoGPXjPIzt7peFbX8u7tNBakwY
	y/Ng6jd+sol3Laz5Cl0V3LNU5xFo7xDsjPtHUhlxzbh/Y0JT3PVvRZ8VRllj7h/LMv3tP3Lw
	tHb54PNBX/t75Xjtbtb1yumic36te7dltt6RluzrRx+sVJ/qN84uTFd0LqJLobfTDuvuvFno
	c+aQ3RMrMp30RdtG+WX53pUtKY0/t0uNipDcxuuvv3iDGxVKzw9+rDt7NXofIJL3dheaV4YE
	w5n765VugqY+n5ln3l89QJtZytXhdx/m3g3Y6R9/aTKaU/dT/Om8957tPVJgsxbrqox11TGH
	F6q4MUlf3MwQb2EOTG//sM1jwrD17o7iBssD3uam8i7GZOITmmSZKBBXa2T/AagvnICgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSvK6kdmuqwYqNMhbrTx1jtvj49TeL
	xeq7/WwWrw9/YrR4cqCd0WLBorksFjcP7GSyWLn6KJPFpEPXGC2eXp3FZLH3lrbFwrYlLBZ7
	9p5ksbi8aw6bxfxlT9ktuq/vYLNYfvwfk8WNCU8ZLSZ2XGWy2PGkkdFi2+/5zBbrXr9nsThx
	S9ri/N/jrA4SHjtn3WX3OH9vI4vH5bOlHptWdbJ5bF5S7/Fi80xGj903G9g8FvdNZvXobX7H
	5vHx6S0Wj/f7rrJ59G1ZxejxeZOcx6Ynb5kC+KK4bFJSczLLUov07RK4Mv41fWQuOCJZcfX2
	HbYGxmciXYwcHBICJhJ/ryZ2MXJxCAlsZ5T4ve0dWxcjJ1BcUmLZ3yPMELawxMp/z9lBbCGB
	ZiaJjadCQXrZBLQlTv/nAOkVEdjBLPFzbTMTiMMs8JRJ4uPPb4wgDcIC1hLrv19nBbFZBFQl
	Gj/1MYHYvEDxppP7mSGO0Jfovy8IEuYECj//tZgVYpeVxMnnm9kgygUlTs58wgJiMwvISzRv
	nc08gVFgFpLULCSpBYxMqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGC41graAfjsvV/9Q4x
	MnEwHmKU4GBWEuHN12lJFeJNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBa
	BJNl4uCUamDyvDzpJpvQCxYttUijjrW6LRwrEqYus7r+hGmukf9yg8oS4/dswt2sh5++k5Gt
	f8gqzXVnsfWZLa0ye1S1lb5UhxVLhm123qo+9fKS7i3838V+HU4U1Fdv+sv/TO+qfrDRjib9
	lv8qaiZfBBY6P8mdaLg55m/QrOXf29Mcsp6rP7XgXDoxMJCtoCj8h687H/ueGT1ycg1+XZ8Z
	G1ZfX6ZRUv9IeXvS/v/u4n7X5/JOe6Rkn/ay70nlc6cpi1YKb1YT7zoq4qhg27ihZM1im6Ye
	/9h0hknPxVRlZsxs9RHg9t8en/5T108sLoKhXUSiYuGm+NsPlSe1XZovwjyx63H2Fh4h5fuJ
	6s9Yl7x4pcRSnJFoqMVcVJwIAKujTP5SAwAA
X-CMS-MailID: 20231222062217epcas5p1263b3a88c9e94933ab44be1df86ccfbe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062217epcas5p1263b3a88c9e94933ab44be1df86ccfbe
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062217epcas5p1263b3a88c9e94933ab44be1df86ccfbe@epcas5p1.samsung.com>

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
index 198d38b53322..a3e1695d111f 100644
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
@@ -1981,6 +2013,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		q->limits.discard_misaligned = 0;
 	}
 
+	if (!dm_table_supports_copy(t)) {
+		q->limits.max_copy_sectors = 0;
+		q->limits.max_copy_hw_sectors = 0;
+	}
+
 	if (!dm_table_supports_secure_erase(t))
 		q->limits.max_secure_erase_sectors = 0;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 23c32cd1f1d8..c98bb3908bd4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1721,6 +1721,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
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
index 772ab4d74d94..d840ed38516c 100644
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
2.35.1.500.gb896f729e2


