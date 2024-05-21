Return-Path: <linux-fsdevel+bounces-19884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD28CAF02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 15:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE841C21B69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900C979DDB;
	Tue, 21 May 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ETuRVkyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC378C7F
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296895; cv=none; b=kWOWoKt/xj4ZiJiFaPmcjTwXHVoC8sVu0jBLIb5xjdtSjv5Ww+Fw6W0AM3hjbc5VLtjmds9GJxyzj45HL9rCK0rHE2/qi6nl9NVQnNrR9nuohqp535ZdNleO0h39BOhWnbx9F0/GmBXTwv2h9VVwIQNTpNxo1iULYOAgG/2hP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296895; c=relaxed/simple;
	bh=9zPFf0Squvi1mogXdW3GaYX5jzlFVa4hNNRrNLBWF0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=SAGXseUl2hmhMNgomX+PG8rs7Nx1AGdODORK4HIxAQZ21pSYAF9tdlZUhgGIIEuItmcDzTmNMFB/QpILXD6alxg6rIa07AmTyIq/MMwl3/q/yzVFTXqgOk088CNafHwYagITh+WZTyW/2Zk6BLBvh3NqVWuRaxNH9ug2mIK+PXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ETuRVkyS; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240521130809epoutp02b1aaf2867b6d61c60cb0e3492301d24a~Rgu1_d4Yz1155511555epoutp02V
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 13:08:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240521130809epoutp02b1aaf2867b6d61c60cb0e3492301d24a~Rgu1_d4Yz1155511555epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716296889;
	bh=68M8UQdBQ84meqytW018nu4+AHUsAxOzbElXzqhsHvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ETuRVkySJlalDf75vQvztLjWmhXg9wimNdvuJKwVGRm6eXZHU46lN/F7Ts83lcBxQ
	 Xhij3mw3Aa3mdM+oukSyrGDGbxwoBbI7VhmxX6MJL/NbN+CYwNenlnkvfIXzySiDtE
	 VKYeyWxX/sXDu48YL25++zDo58X7TenbnIiuidio=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240521130808epcas5p339c7e9e25274e9e8056c6fae9f3fb3b6~Rgu1Tc04o1587915879epcas5p3m;
	Tue, 21 May 2024 13:08:08 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VkF9M0B8dz4x9Pp; Tue, 21 May
	2024 13:08:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D0.32.08600.6BC9C466; Tue, 21 May 2024 22:08:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240521112458epcas5p2bb85b9c58a58dc4eaecf66adc74872bd~RfUweDbmn2405124051epcas5p27;
	Tue, 21 May 2024 11:24:58 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521112458epsmtrp1d2bcb3f0c350e3b251bfb770bdcdeb76~RfUwdFIUi3228932289epsmtrp1-;
	Tue, 21 May 2024 11:24:58 +0000 (GMT)
X-AuditID: b6c32a44-921fa70000002198-d1-664c9cb627b4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E7.3E.19234.A848C466; Tue, 21 May 2024 20:24:58 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240521112454epsmtip22650eeb9186dbced84f491fa532014b1~RfUsmvBOT0276702767epsmtip2G;
	Tue, 21 May 2024 11:24:54 +0000 (GMT)
Date: Tue, 21 May 2024 16:47:56 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240521111756.w4xckwbecfyjtez7@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <086804a4-daa4-48a3-a7db-1d38385df0c1@acm.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA01TezBcZxTvd++6u2Q2vZaMDymyeRNiPTafCO0M07kSndGmMtNMM5sde1nF
	7s4+SkRbETRMEY80zWa9tkSCUrJVr5RSBE1NZkuRoDU2LUYkJogI6a4lk/9+53fO73y/75w5
	LJxTy3RgRUuUtFwijOUSVoyGzoP73Rs0oZGeaU+9UG1fN45SLq/hqGosh0CznQsAfftkBUdT
	7V8DtHpvAEe67nGASrSFDDTS3oShVm0ehm5VdWHo+tWLGOp6NUegvI4hgAyDagzdGXVDpell
	DNR6p5eB9M0aAhXfMDBRRc86hnIvDWKoceoCQDWz8wx0d9QRDaz1WLznSOn/PEH1aSHVpB5j
	UgPjdQxKf09F1VdmENTtsq+o/25fA1TLSDJBfZ+db0FlXXxMUE1pExbUU8Mog5r/ZZCgsnWV
	gPq95DdmmM3pmGNiWiii5S60JEIqipZEBXBPnBQECXz5njx3nh86wnWRCOPoAG5waJj7+9Gx
	xuFwXT4XxqqMVJhQoeAeDjwml6qUtItYqlAGcGmZKFbmI/NQCOMUKkmUh4RWHuV5enr5GgvP
	xogb0rWY7IVtwlJzLpYMdNaZwJIFSR84cv8HPBOwWByyBUDtvkxgZYQLANbq9eB10J9TwdwS
	PLs0yTAnmgAcXL5JmINHAD6sS96oYpB7YftLjYWpLUG6wf5XLBNtSx6AS39XbIhxspSAD4ef
	46aEDXkWzvXlbtSzST7MNahMNJu0hr3XphgmbEn6w67Gn4AJ7yB3wu/KF3FTH0iOW8LyuVXM
	pIVkMKwYcjUbtYEzPbpN0w5wOid9E8fDWwVmz5BMBVD9lxqYE+/CtL6cDT84KYbLdSWbgnfg
	lb4azMxvh1mrU5iZZ8PGoi28G1bXlhBmbA+Hli8QZj8UfFDtbJ7PYwDTim7gl4Gz+o2/qd94
	zoyPwownKRZqoxwnHWHFOssMD8La5sMlwKIS2NMyRVwUHeEr40no+NfrjpDG1YONy3ENbgTD
	xeseHQBjgQ4AWTjXll2vC4nksEXCc4m0XCqQq2JpRQfwNa4qF3fYESE1np5EKeD5+Hn68Pl8
	Hz9vPo9rx55NKxRxyCihko6haRkt39JhLEuHZIzfvFqlSSp0qVyDqdVlnCqmR37U6b2tgfuP
	g+lsg2/3yc/KLBuV4SvlTG+Ok/dKzJ7yL/91cPfek/dHz+6iTu1L6uf56qQZ5WrWoYKF/n/a
	4lKqEiWfVEhSd82keHzoE6wN+TEkoqAlQbUsU3zTGx1PT1x1WqHFtpM1utKMR0vDxasfV2k8
	u88ovzhklxb9YNyvXLr4UV3g9HDm5M0sgRNbwFfqE069uPLMP9+yfx+9bSTcOYgnKr3+/NOA
	SEmQ1+DOzhr13U4rx8Vx+wNvjYlweGpb5PnQ44lM2bm2wdld1vftDL/KGIY8/xwP/7dnRUma
	I7LzArh9wi2cZLatcz44w2UoxEKeKy5XCP8HvMe4lsIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7bCSvG5Xi0+aQe99PYv1p44xWzRN+Mts
	sfpuP5vF68OfGC2mffjJbPHkQDujxe+z55ktthy7x2ixYNFcFoubB3YyWexZNInJYuXqo0wW
	s6c3M1kc/f+WzWLSoWuMFk+vzmKy2HtL22Jh2xIWiz17T7JYXN41h81i/rKn7BbLj/9jspjY
	cZXJYseTRkaLda/fs1icuCVtcf7vcVYHaY/LV7w9Ti2S8Ng56y67x/l7G1k8Lp8t9di0qpPN
	Y/OSeo8Xm2cyeuy+2cDmsbhvMqtHb/M7No+drfdZPT4+vcXi8X7fVTaPvi2rGD3OLDjCHiAc
	xWWTkpqTWZZapG+XwJXxseE7a8EaoYoF83ayNDA28HcxcnJICJhIfOl4xNLFyMUhJLCdUaLx
	ehsTREJSYtnfI8wQtrDEyn/P2SGKnjBK3F7RC1bEIqAqceDPHNYuRg4ONgFtidP/OUDCIgIa
	Et8eLAcbyiywlE3i4v7f7CAJYYEEibenJoLV8wqYSUx8Wgox8x2jxIy929hAangFBCVOznzC
	AmIzA9XM2/yQGaSeWUBaYvk/sPmcAtYSR3dsZQSxRQVkJGYs/co8gVFwFpLuWUi6ZyF0L2Bk
	XsUomlpQnJuem1xgqFecmFtcmpeul5yfu4kRnCa0gnYwLlv/V+8QIxMH4yFGCQ5mJRHeTVs8
	04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqY4o5ummdb
	u4zl7uk9GxfpLt/u4eenaWH692rU6sXfVOfMV9/PMevXmWXLD/NKVaZ3estc1qyIVDrzZfWG
	qVP8DoWvUnCfdkfkyJwDJ/NOi2dt39r8U+E0X/L1478Xcpnk1R05H67zaDmT9oKl3DXfLWe0
	WBrYvTq4U+W4SnD1t0Xbl7rIfTwswL69fWH16oeuj6avbOo7q5hevHr3wfQ3kf+yMjl3sD+8
	pf9YKv/sO/XukDUu8+flTy9zMw/+Yt+ler5R0Ku7e973iKl63a+OlC68Ot98WZDyxX195u83
	Ol0XObgi1ov5zvmsn89c3Y8WGHYx7CvdqL1YXFJvUfuCtQ+lN8dOvhes067T+pSn6oQSS3FG
	oqEWc1FxIgCBWrltggMAAA==
X-CMS-MailID: 20240521112458epcas5p2bb85b9c58a58dc4eaecf66adc74872bd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_15778_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102842epcas5p4949334c2587a15b8adab2c913daa622f
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
	<20240520102033.9361-3-nj.shetty@samsung.com>
	<086804a4-daa4-48a3-a7db-1d38385df0c1@acm.org>

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_15778_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 20/05/24 04:00PM, Bart Van Assche wrote:
>On 5/20/24 03:20, Nitesh Shetty wrote:
>>Upon arrival of source bio we merge these two bio's and send
>>corresponding request down to device driver.
>
>bios with different operation types must not be merged.
>
Copy is a composite operation which has two operation read and
write combined, so we chose two operation types which reflects that.

>>+static enum bio_merge_status bio_attempt_copy_offload_merge(struct request *req,
>>+							    struct bio *bio)
>>+{
>>+	if (req->__data_len != bio->bi_iter.bi_size)
>>+		return BIO_MERGE_FAILED;
>>+
>>+	req->biotail->bi_next = bio;
>>+	req->biotail = bio;
>>+	req->nr_phys_segments++;
>>+	req->__data_len += bio->bi_iter.bi_size;
>>+
>>+	return BIO_MERGE_OK;
>>+}
>
>This function appends a bio to a request. Hence, the name of this function is
>wrong.
>
We followed the naming convention from discard(bio_attempt_discard_merge)
which does similar thing.
But we are open to renaming, if overall community also feels the same.

>>@@ -1085,6 +1124,8 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
>>  		break;
>>  	case ELEVATOR_DISCARD_MERGE:
>>  		return bio_attempt_discard_merge(q, rq, bio);
>>+	case ELEVATOR_COPY_OFFLOAD_MERGE:
>>+		return bio_attempt_copy_offload_merge(rq, bio);
>>  	default:
>>  		return BIO_MERGE_NONE;
>>  	}
>
>Is any code added in this patch series that causes an I/O scheduler to return
>ELEVATOR_COPY_OFFLOAD_MERGE?
>
yes, blk_try_merge returns ELEVATOR_COPY_OFFLOAD_MERGE.

>>+static inline bool blk_copy_offload_mergable(struct request *req,
>>+					     struct bio *bio)
>>+{
>>+	return (req_op(req) == REQ_OP_COPY_DST &&
>>+		bio_op(bio) == REQ_OP_COPY_SRC);
>>+}
>
>bios with different operation types must not be merged. Please rename this function.
>
As described above we need two different opcodes.
As far as function renaming, we followed discard's naming. But open to
any suggestion.

>>+static inline bool op_is_copy(blk_opf_t op)
>>+{
>>+	return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
>>+		(op & REQ_OP_MASK) == REQ_OP_COPY_DST);
>>+}
>
>The above function is not used in this patch. Please introduce new functions in the
>patch in which these are used for the first time.
>
Acked

Thank You
Nitesh Shetty

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_15778_
Content-Type: text/plain; charset="utf-8"


------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_15778_--

