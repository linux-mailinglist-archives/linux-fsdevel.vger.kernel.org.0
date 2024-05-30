Return-Path: <linux-fsdevel+bounces-20511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A5F8D494E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 12:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7394A1C21F1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2A176AC6;
	Thu, 30 May 2024 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MptEa35t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC41761AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063865; cv=none; b=uE19xSgBcfYFn2Tv4ZG9+Q9P+9p2OSLr/1EA+DMVzAsVlG3VFyq9nQ3nwCwGV2OaPnRTiPKgmY+4DbXn+cj/mrUW9cM+pRI+/0FV4T3FDIqUPH1j9vr6Jw+DxuJLQ2bhjdR4sDbwDL3aG1iEBJIc+huMtQzb78KImO8Torptp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063865; c=relaxed/simple;
	bh=on/JwLTxrLuV3vO1p1ll7J4Xl/lUI9BhrYuQk7Z0lfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ZaDjOOBB9xTjms9jW4NhA1SMuoro3RWjVCykMuD8Xh0pJA4NYx9RJTTs+7p9Izoj5WXZoimajQ0UZuYJXfBRz71jGP7rRRVN49eMqIZhxBfZP06AbksxzjgB/DIMUPfvApddONB53PPq+wqSeBorwktmRJtdRv2KvRiwOHtHTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MptEa35t; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240530101101epoutp02933750d6752fba0f39d44d18410378f5~UPHwigCj82705827058epoutp02e
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 10:11:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240530101101epoutp02933750d6752fba0f39d44d18410378f5~UPHwigCj82705827058epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717063861;
	bh=rCniubpfhRi+g2l6XyRehFQ5clmSAHkrG4fc8RUMS8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MptEa35tnH//kE2ZSyDiuh8SPwEHLdPETxNEMAdjM2dqCBESdkfpL+mM7zOewK7g7
	 MOfSkmDkoGlQKzsQZ5LTksCaPGkLaqU0f/4wEgmwl8UPc2oxfyactQr9magBWqCrhc
	 mER/kOnpzWys3ZiEjsIZ11yxLnPMg50p31LmOwC4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240530101101epcas5p1c534977e2860b97c465e67c8e0c9abd7~UPHv7LDHX0596505965epcas5p1b;
	Thu, 30 May 2024 10:11:01 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Vqhpq18dGz4x9Pp; Thu, 30 May
	2024 10:10:59 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.11.08853.2B058566; Thu, 30 May 2024 19:10:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240530072334epcas5p2294aaf32c6fd842746a3720b79e4ae0f~UM1jSPnWa0360603606epcas5p2d;
	Thu, 30 May 2024 07:23:34 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240530072334epsmtrp10c020316720cd13ac5ee23b5f7e3fa95~UM1jQ6LhM2941029410epsmtrp14;
	Thu, 30 May 2024 07:23:34 +0000 (GMT)
X-AuditID: b6c32a44-fc3fa70000002295-f2-665850b2a045
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.C0.07412.67928566; Thu, 30 May 2024 16:23:34 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240530072330epsmtip275d026b89192731ddd356c1f20d4b985~UM1fnzfni2409724097epsmtip27;
	Thu, 30 May 2024 07:23:30 +0000 (GMT)
Date: Thu, 30 May 2024 07:16:30 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike
	Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Keith
	Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240530071630.ufzrgji6z6abliqx@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeUxUVxTGc9978+ZhM/oEtBe0QoaaAAaYkaUXy1IjkpfCHzTEtDE2MIXH
	UmBmOjNUtLFsghVBFsHWQQQpkZ1RQMLiUALIMmKpRVZBqWVQNkEwtEqADjxo/O93vvvdfOfc
	k0vhxnV8cypcqmIVUkmkkNxB1LXZWNvV+H0VIlpPwJBG14GjhIxVHJWPpZNopm0RoKsLb3E0
	0XIBoJWHvTiq7XgK0PhvnqigMI9Awy0NGLpXmIWh0vL7GMr9ORFD99fnSJTVOgCQvl+NIe3I
	IXQzuYhA97TdBOprvE6i/Ft6PiruXMNQ5k/9GKqfiAeoamaeQF0j+1Dvaifvs/1M32MfRlcI
	mQb1GJ/pfXqHYPoeRjPVZRdJpqYolnlZcw0wTcNxJPPr5Ss8Ji3xFck0JD3jMa/1IwQz39xP
	MpdrywDTU9DO9zM5GeEWxkqCWYUlKw2SBYdLQ92FPv4BxwKcXURiO7Er+kRoKZVEse5CL18/
	O+/wSMMDCS2/l0RGGyQ/iVIpdPBwU8iiVaxlmEypchey8uBIuZPcXimJUkZLQ+2lrOqIWCQ6
	7GwwBkaEvXvWwpcnucWMa5uIODAlSgFGFKSdYN7wKpECdlDGdBOAl0ZzAFcsAphwU4dzxTKA
	L2/pse0ri2N6kjvQAtiWemnLtQRgzS+XwYaLoA/CttFug4uiSPoQfLBObcimtDVcHi/ezMPp
	DhKWFmds+k3oQDiny+RtsIA+Bru0/TjHu2H3tQlig43oT+FfT+d5XBeTRnA21ZpjL1idt0hy
	bAKnO2v5HJvDqfTkLT4NS7NLNruG9HkA1YNqwB14wiRd+mYYTodBtWYO5/SPYI6uCuP0nTBt
	ZWJrfAGsv7HNVrBCU7AVbAYH/onfHBjSDHxSYcE9ShoO69cGsQxwQP3ePOr34jg+Ai8uJPA4
	toCJd3MNOmXgfbB4jeLQBmoaHQoAWQbMWLkyKpQNcpaLpezp/zceJIuqBpsfyNarHgzlr9m3
	AowCrQBSuNBU0JN1IsRYECw5c5ZVyAIU0ZGsshU4G3aViZvvCZIZfqBUFSB2chU5ubi4OLk6
	uoiFHwpmkvKCjelQiYqNYFk5q9i+h1FG5nFYwcdfx5qSU8rnvBKPup5Q36OmlO52CrH0YshE
	3XzXITV3NqOqtjrxoKtP55F/d/N83/5h1a4+fsfHcy9PW31j+uwukw+6ugQnR99crwh5sfyt
	rGUw+tV87lD47+tXHrt6L114Uhnqb1PyzdyXxXzNghXb3PXI7GjV/gGvSq/zg47LLR7VP+Tv
	CbR+N+lo0fjEPIh+YPtn5siuju9+lDVOZhxvP6fJmMZLWvZmTzeLBl/Gf55deSZnNSZzvbX0
	eZ9+vbTAbygII17LPaPOpRfdXrKVKUdjvjhFdJsOzSaLy5u1qrETM5NTO/Pn1Me9BRq32KUD
	f6842iwfO9yUfkqvs7L0f/NISCjDJGJbXKGU/Aem9kfwyQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZdlhJXrdMMyLNYPciMYv1p44xWzRN+Mts
	sfpuP5vF68OfGC2mffjJbPHkQDujxe+z55ktthy7x2jxYL+9xYJFc1ksbh7YyWSxZ9EkJouV
	q48yWcye3sxkcfT/WzaLSYeuMVo8vTqLyWLvLW2LhW1LWCz27D3JYnF51xw2i/nLnrJbLD/+
	j8liYsdVJosdTxoZLda9fs9iceKWtMX5v8dZHWQ8Ll/x9ji1SMJj56y77B7n721k8bh8ttRj
	06pONo/NS+o9Xmyeyeix+2YDm8fivsmsHr3N79g8drbeZ/X4+PQWi8f7fVfZPPq2rGL0OLPg
	CHuAcBSXTUpqTmZZapG+XQJXxrXFK9kLpllW3Px9h7mBcbpeFyMnh4SAicSnu0/Zuhi5OIQE
	djNKLLz5kQkiISmx7O8RZghbWGLlv+fsEEUfGSWmfJ8ElmARUJU4fOckUDcHB5uAtsTp/xwg
	YREBDYlvD5azgNQzC5xhk5jx8AQrSEJYIEHi7amJYDavgLPEib1XmSGG9jJL3Dz/iRkiIShx
	cuYTFhCbWcBMYt7mh8wgC5gFpCWW/+OACMtLNG+dDVbOKWAt8fDee9YJjIKzkHTPQtI9C6F7
	FpLuBYwsqxglUwuKc9Nzkw0LDPNSy/WKE3OLS/PS9ZLzczcxghOKlsYOxnvz/+kdYmTiYDzE
	KMHBrCTCe2ZSaJoQb0piZVVqUX58UWlOavEhRmkOFiVxXsMZs1OEBNITS1KzU1MLUotgskwc
	nFINTCsSbv0Xr01mK5O0rxYPOv2i033Fslc9zcLKrBIbEvmMn61yaTVdcz/jCv8OUf03lccc
	m3xudHFymkTLPJrUYmYyz3oFR8i38x4rJb98EQy0L1WLE2ytV1DNeH0n4ERd/vPkL1xm3S+2
	Ne7K1ambuD9pYXEli6Bv5r/EPSbLLzndaGCXcTCf5fRw1vyGzk+WRS+D7hz7trDo2B/hfUJz
	4+VyxDQV5P8KdHkfuO948/PzUJej1/dwTZ5TM23xgX4J0dsP3s/92aZ1e8GbuVu9T35/F6LE
	NVMj6rveLtazQcut2R8/bFh0fOlc1r9ngmfWJT7O3hX1y8x054eA2gCpdqNupqw+8c2/mGeI
	V6z2V2Ipzkg01GIuKk4EAPP8g6SXAwAA
X-CMS-MailID: 20240530072334epcas5p2294aaf32c6fd842746a3720b79e4ae0f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_40f67_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102842epcas5p4949334c2587a15b8adab2c913daa622f
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
	<20240520102033.9361-3-nj.shetty@samsung.com>
	<eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
	<20240529061736.rubnzwkkavgsgmie@nj.shetty@samsung.com>
	<9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
	<a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_40f67_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 29/05/24 03:41PM, Bart Van Assche wrote:
>On 5/29/24 12:48 AM, Damien Le Moal wrote:
>>On 5/29/24 15:17, Nitesh Shetty wrote:
>>>On 24/05/24 01:33PM, Bart Van Assche wrote:
>>>>On 5/20/24 03:20, Nitesh Shetty wrote:
>>>>>We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
>>>>>Since copy is a composite operation involving src and dst sectors/lba,
>>>>>each needs to be represented by a separate bio to make it compatible
>>>>>with device mapper.
>>>>>We expect caller to take a plug and send bio with destination information,
>>>>>followed by bio with source information.
>>>>>Once the dst bio arrives we form a request and wait for source
>>>>>bio. Upon arrival of source bio we merge these two bio's and send
>>>>>corresponding request down to device driver.
>>>>>Merging non copy offload bio is avoided by checking for copy specific
>>>>>opcodes in merge function.
>>>>
>>>>In this patch I don't see any changes for blk_attempt_bio_merge(). Does
>>>>this mean that combining REQ_OP_COPY_DST and REQ_OP_COPY_SRC will never
>>>>happen if the QUEUE_FLAG_NOMERGES request queue flag has been set?
>>>>
>>>Yes, in this case copy won't work, as both src and dst bio reach driver
>>>as part of separate requests.
>>>We will add this as part of documentation.
>>
>>So that means that 2 major SAS HBAs which set this flag (megaraid and mpt3sas)
>>will not get support for copy offload ? Not ideal, by far.
>
>QUEUE_FLAG_NOMERGES can also be set through sysfs (see also
>queue_nomerges_store()). This is one of the reasons why using the merge
>infrastructure for combining REQ_OP_COPY_DST and REQ_OP_COPY_SRC is
>unacceptable.
>

Bart, Damien, Hannes,
Thanks for your review.
We tried a slightly modified approach which simplifies this patch and
also avoids merge path.
Also with this, we should be able to solve the QUEUE_FLAG_MERGES issue.
Previously we also tried payload/token based approach,
which avoids merge path and tries to combine bios in driver.
But we received feedback that it wasn't the right approach [1].
Do below changes look any better or do you guys have anything else in mind ?

[1] https://lore.kernel.org/linux-block/ZIKphgDavKVPREnw@infradead.org/


diff --git a/block/blk-core.c b/block/blk-core.c
index 82c3ae22d76d..7158bac8cc57 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -122,6 +122,8 @@ static const char *const blk_op_name[] = {
  	REQ_OP_NAME(ZONE_FINISH),
  	REQ_OP_NAME(ZONE_APPEND),
  	REQ_OP_NAME(WRITE_ZEROES),
+	REQ_OP_NAME(COPY_SRC),
+	REQ_OP_NAME(COPY_DST),
  	REQ_OP_NAME(DRV_IN),
  	REQ_OP_NAME(DRV_OUT),
  };
@@ -839,6 +841,11 @@ void submit_bio_noacct(struct bio *bio)
  		 * requests.
  		 */
  		fallthrough;
+	case REQ_OP_COPY_SRC:
+	case REQ_OP_COPY_DST:
+		if (!q->limits.max_copy_sectors)
+			goto not_supported;
+		break;
  	default:
  		goto not_supported;
  	}
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8534c35e0497..a651e7c114d0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -154,6 +154,20 @@ static struct bio *bio_split_write_zeroes(struct bio *bio,
  	return bio_split(bio, lim->max_write_zeroes_sectors, GFP_NOIO, bs);
  }
  
+static struct bio *bio_split_copy(struct bio *bio,
+				  const struct queue_limits *lim,
+				  unsigned int *nsegs)
+{
+	*nsegs = 1;
+	if (bio_sectors(bio) <= lim->max_copy_sectors)
+		return NULL;
+	/*
+	 * We don't support splitting for a copy bio. End it with EIO if
+	 * splitting is required and return an error pointer.
+	 */
+	return ERR_PTR(-EIO);
+}
+
  /*
   * Return the maximum number of sectors from the start of a bio that may be
   * submitted as a single request to a block device. If enough sectors remain,
@@ -362,6 +376,12 @@ struct bio *__bio_split_to_limits(struct bio *bio,
  	case REQ_OP_WRITE_ZEROES:
  		split = bio_split_write_zeroes(bio, lim, nr_segs, bs);
  		break;
+	case REQ_OP_COPY_SRC:
+	case REQ_OP_COPY_DST:
+		split = bio_split_copy(bio, lim, nr_segs);
+		if (IS_ERR(split))
+			return NULL;
+		break;
  	default:
  		split = bio_split_rw(bio, lim, nr_segs, bs,
  				get_max_io_size(bio, lim) << SECTOR_SHIFT);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3b4df8e5ac9e..6d4ffbdade28 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2833,6 +2833,63 @@ static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
  		blk_mq_commit_rqs(hctx, queued, false);
  }
  
+/*
+ * Copy offload sends a pair of bio with REQ_OP_COPY_DST and REQ_OP_COPY_SRC
+ * operation by taking a plug.
+ * Initially DST bio is sent which forms a request and
+ * waits for SRC bio to arrive. Once SRC bio arrives
+ * we combine it and send request down to driver.
+ */
+static inline bool blk_copy_offload_combine_ok(struct request *req,
+					      struct bio *bio)
+{
+	return (req_op(req) == REQ_OP_COPY_DST &&
+		bio_op(bio) == REQ_OP_COPY_SRC);
+}
+
+static int blk_copy_offload_combine(struct request *req, struct bio *bio)
+{
+	if (!blk_copy_offload_combine_ok(req, bio))
+		return 1;
+
+	if (req->__data_len != bio->bi_iter.bi_size)
+		return 1;
+
+	req->biotail->bi_next = bio;
+	req->biotail = bio;
+	req->nr_phys_segments++;
+	req->__data_len += bio->bi_iter.bi_size;
+
+	return 0;
+}
+
+static inline bool blk_copy_offload_attempt_combine(struct request_queue *q,
+					     struct bio *bio)
+{
+	struct blk_plug *plug = current->plug;
+	struct request *rq;
+
+	if (!plug || rq_list_empty(plug->mq_list))
+		return false;
+
+	rq_list_for_each(&plug->mq_list, rq) {
+		if (rq->q == q) {
+			if (!blk_copy_offload_combine(rq, bio))
+				return true;
+			break;
+		}
+
+		/*
+		 * Only keep iterating plug list for combines if we have multiple
+		 * queues
+		 */
+		if (!plug->multiple_queues)
+			break;
+	}
+	return false;
+}
+
  static bool blk_mq_attempt_bio_merge(struct request_queue *q,
  				     struct bio *bio, unsigned int nr_segs)
  {
@@ -2977,6 +3034,9 @@ void blk_mq_submit_bio(struct bio *bio)
  	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
  		goto queue_exit;
  
+	if (blk_copy_offload_attempt_combine(q, bio))
+		goto queue_exit;
+
  	if (blk_queue_is_zoned(q) && blk_zone_plug_bio(bio, nr_segs))
  		goto queue_exit;
  
diff --git a/block/blk.h b/block/blk.h
index 189bc25beb50..112c6736f44c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -323,6 +323,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
  	case REQ_OP_DISCARD:
  	case REQ_OP_SECURE_ERASE:
  	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_COPY_SRC:
+	case REQ_OP_COPY_DST:
  		return true; /* non-trivial splitting decisions */
  	default:
  		break;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 781c4500491b..22a08425d13e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -342,6 +342,10 @@ enum req_op {
  	/* reset all the zone present on the device */
  	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
  
+	/* copy offload source and destination operations */
+	REQ_OP_COPY_SRC		= (__force blk_opf_t)18,
+	REQ_OP_COPY_DST		= (__force blk_opf_t)19,
+
  	/* Driver private requests */
  	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
  	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
--·
2.34.1


------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_40f67_
Content-Type: text/plain; charset="utf-8"


------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_40f67_--

