Return-Path: <linux-fsdevel+bounces-4975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02D7806C38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797172818F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309D73032A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KqByg77n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC60CD71
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:12:36 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231206101234epoutp01fb8bca70630fe44e1f7746cab5321c09~eNm3fBQDQ0454604546epoutp01b
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:12:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231206101234epoutp01fb8bca70630fe44e1f7746cab5321c09~eNm3fBQDQ0454604546epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857554;
	bh=vUmnCkDPVKAomoDbL/LzqNJSOMEo+hX7Rt95xB1wr2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqByg77ns7Ftfh/iSyw1FE0X9KoX53pCfRlXGZizpC8WuakukSG3cCRs71EhTTcv4
	 SWM5XNQf+5hnr/Lf412nWG1WPFyqucYycg4t2oJARPTql2f8oS1CxsiIBnwC4SMK46
	 pvmHRQgZkxpurBGtzmew/ThtntxrYhtLy85homjU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231206101234epcas5p3d2021e6e34c58b154e7090c86f997ba8~eNm20kUqr0791407914epcas5p37;
	Wed,  6 Dec 2023 10:12:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SlY9r0DV3z4x9Pw; Wed,  6 Dec
	2023 10:12:32 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.22.09672.F0940756; Wed,  6 Dec 2023 19:12:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231206101231epcas5p1756d9f527df621f3a0eebb37ca257f06~eNm0Wee4t1084010840epcas5p1B;
	Wed,  6 Dec 2023 10:12:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231206101231epsmtrp241901a3d3967ff948874ef6197994654~eNm0UoYOX1007210072epsmtrp2W;
	Wed,  6 Dec 2023 10:12:31 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-7c-6570490f4a3d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E2.62.08817.F0940756; Wed,  6 Dec 2023 19:12:31 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101227epsmtip2deeb866484ba7d4dc0142cdd65304b11~eNmwjZbBJ0221302213epsmtip2H;
	Wed,  6 Dec 2023 10:12:27 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
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
Subject: [PATCH v18 09/12] dm: Add support for copy offload
Date: Wed,  6 Dec 2023 15:32:41 +0530
Message-Id: <20231206100253.13100-10-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbVBUVRju3Hv37i4TuC0yHMmU7tSoyNfGQmdBigrzpuUw9Kf8sy67dxaG
	ZXfdj0SdpkXiQxCWDzU+Q4ii2IwPNwKElKUgmACV4dNkCHcHFWQRrFDEaZeL5b/nec/znud5
	3zOHhwufkH68JLWB0allKor0IFq6d+0M2vSelgm9VhWOGvp7cHT/r1UCWW6aSTTXvQSQ/UoW
	QOdrKgk0caUNQ99ZfsVQkW0UIMdIGYY6J3ej6sxaAnV09hFouL2CRFXfOLgod6yVRHW9TzA0
	XuAAqDB7BEOt9jSAWlarcPTDnJNAv02+iIbWejkxkG4ru8mlh6aaCHp4wEg3158i6Yu1n9G3
	L5YC+tKEiaS/yi/m0HnpCyR93zFJ0M6fR0g631oP6OXmbXSz/R4W53UoeU8iI1MwOn9GLdco
	ktTKaOrAh9J3pOERoaIgkQS9TvmrZSlMNBX7flzQu0kq1xIo/09kKqOrFCfT66mQN/boNEYD
	45+o0RuiKUarUGnF2mC9LEVvVCuD1YwhUhQa+lq4S3g4OdE5/xDTLm9JnR+14iaQ75MD+Dwo
	EMPefjsnB3jwhIJLAHZkP9ggSwAuZjwlfwNosn6N5QDeestcD4+tdwJ4tbqRZMkygNduD+Nu
	ESnYBa8WG90WmwXf47CtSeTW4IIJDA5cbsHcB96CKNiyWslxY0LwKlw41wTc2FMggYXtWRw2
	33ZYev0frhvzXfXi2Rqc1bwA+0rthBvjLk36j+W42wAKqvhwotvkSsR1kVi4upW9xhve7bVy
	WewHlxc6SRbL4fXSQYzFBniro2sDvwkz+s3ro+CuURraQ1gnL5i3at9YgyfMzhSy6pfhVJFj
	I7Av/LOklsNKaLjwmGCXcxrAP9JzOQVge9kz+cueyV/2v9l5gNeDLYxWn6Jk9OHaMDVz9L9X
	lWtSmsH6Rwg40ApmpheDbQDjARuAPJza7Kka0jBCT4Xs2HFGp5HqjCpGbwPhrgUX4n4+co3r
	J6kNUpFYEiqOiIgQS8IiRJSv51xGpUIoUMoMTDLDaBnd0z6Mx/czYXv5SueoPKZqd8XknG8x
	CDz4S+anrV++1FC3zZFw79uwG6VYtU/0prQjR3Pp46rCBMlBXJNv3hnIv2U9C617VwTc+Le5
	UadOWsxa7zOKux/sON0DlF5eX4yM5ZdXZK08H9l0OXLpcOOgcX487Mi5qLaf7iTPlsys9c9X
	WgYyD0nX1FOD6TMJZo059ff2xzMnHkxbStaQx2id7Tme30mhKquwe1/MfOxbxwJvcMWSHWOz
	H0u7Mpu7puXxn1vM07opm3O8vMB3mVpcyl15tL/kbElevamve98Fvrboo6hiWrz/kVoZ0hgQ
	5Qx7mHIirYYima1IbrlQYdaeyb3zSkNqPKIIfaJMFIDr9LJ/AeggkU+RBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0xSYRjHe885HA8QdcSar7Wy2LrpsKvtray1anX6UGvVp2pLyjNjAdJB
	LOuDt2VmQyW2mnZBzSxx1SR1qIGKF7IySlKTZbdJuFGQVpZZluja+vZ7/pc9z/ZQuLiVmEPJ
	Vcksp5IpJKSAqG2RREpn7lSzKxr1QnTvUTuOhr6NEaiyP59EvpZhgAaazgFUXHqNQH1NdRiq
	qGzD0EV7D0Ce7iIMWd3RqCS7jEAPrB0EctVfJZGx3BOCLvRaSHTLMY6hlwUegPQ53RiyDGQA
	VDtmxNFdX4BAD91zkfO3g7cZMnVF/SGM83UVwbg6tYzZdJ5k7pelMYP3CwHT0JdOMjfyDDxG
	l+UnmSGPm2ACtm6Syas2AeaLeT5jHviE7ZlxQBCXwCrkKSy3fFO84Fjg4yim/hJx6mNPNZ4O
	8mbnAoqC9Broa6dyAZ8S0w0AZlq3BxnS4TCr50fIFIfBinHvBAsmMkMA9tozecEuSS+Dzwza
	oD6LtuBw9E4WFhxw2oPBodEREGyH0Rtg7dg1XpAJehH0X6qa1EX0OqivP8eb2hAJC7u+T27j
	T+gGbyk+dRGCtozLxFQ+FHYUDkwyPpHPqrmCFwC66D+r6D+rGGAmEMGqNcpEpWalepWKPRmj
	kSk1WlVizNEkpRlMPjoqygIemD7H2AFGATuAFC6ZJVI4k1ixKEGWeprlkg5zWgWrsYO5FCEJ
	F434dAliOlGWzB5nWTXL/XMxij8nHSOvFh+o0R0nzygGvV2jPrnladPhtCWvUt0bv15ujSMN
	T1vbe2Olzx5n+xr59q35Dv88x9LmbTs74/OF5TXijH1SscfY6Ne3ddpyjQv7xh/CkmS2NbfZ
	0SUQvvDvlun5wrvPG+Qny8Qtu+pzAiLZB2bHiiOu6Q3DF35JU9tt7vC1qbgrvsD3HvxIifbe
	iAzdaDx7ernuyfWfnW+qB4XP0/xf6+sMr0YWXNztPGSOi91L7DsSWP0ue8HtKuuJg6aIxV4n
	V+Dd8vImXVbxpNcWKpjmkGe4Dv18uyaOU81e/65Ul6OVWlP2f1BZTf2/hzPFeV2xO9TN46uV
	3M3Emj8jEkJzTLYyCuc0sr8K69AIVwMAAA==
X-CMS-MailID: 20231206101231epcas5p1756d9f527df621f3a0eebb37ca257f06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101231epcas5p1756d9f527df621f3a0eebb37ca257f06
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101231epcas5p1756d9f527df621f3a0eebb37ca257f06@epcas5p1.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

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
index 8dcabf84d866..c209348a0064 100644
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


