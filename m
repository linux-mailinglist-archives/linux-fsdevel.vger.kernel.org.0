Return-Path: <linux-fsdevel+bounces-19975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D438CBA94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD714B21942
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79E87A15B;
	Wed, 22 May 2024 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NQ9ufKHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E778C6F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716354116; cv=none; b=I7uifHkb6zDfFdB4k25A5EZm2gdF8YXuwZFFd8JZZ5aI7+nsxeVQ5pK50fqmZcf0hWp6GjbYMTkwL9s5PiZynI5HSKIhmf9rVzDpFsHavIqlchmBs6CO7XsABwoBJhN71tEOJqc+h6mn8sOjZFX3KoKqsn2JBV55KpB41SabOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716354116; c=relaxed/simple;
	bh=sFI2ZEGRuh1B85fabE/2MCSzPgp5AnTkxvWBO0Tshqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=jmsXpE3gwMmTCnTu7AV4zZ45sYlmqp2rgnqcGoMeA7GH8y8lfMA8DdTkZPTq5D5MqsHZfZUXtgHZiLt2f8rLoqYmJBOZZ15lcIstHxLn9IqPD45qMCZqXMxlHgAFDjHM3KiStbQ3r6veG6/PiazgLXMTiHHjxWfmkZdCBQpuRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NQ9ufKHy; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240522050146epoutp041639bccfea4eff63ad72ae0034db3f9d~RtvdTkNEq1457714577epoutp04L
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 05:01:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240522050146epoutp041639bccfea4eff63ad72ae0034db3f9d~RtvdTkNEq1457714577epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716354106;
	bh=aZbLP2jeobu/Z0T/7aETZOrlyCg9AXMVKdQE4iZAanU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQ9ufKHyxoXkemMoK1bmpe0T+WMSrXafVrdls3a7Uhp920pZrElsYMBAVDAEZrSiB
	 kqXHpiYFoOKLdSaP/izV+u2IMtLI0yg0NBsI6pbZ1rawBxERRPkYE+PVjCF6UIS5+d
	 ZToq+A/4l97ICu09Xg4F/tiERI1bIrgpIfOPt57U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240522050145epcas5p2a7806416f10863817295221bf526966a~Rtvct5NkB1273012730epcas5p2k;
	Wed, 22 May 2024 05:01:45 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VkfKh06mQz4x9Pt; Wed, 22 May
	2024 05:01:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7F.ED.19431.73C7D466; Wed, 22 May 2024 14:01:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240521143212epcas5p3ca522698f1f5e84f41add0e9cfdd0647~Rh4OXVRmw0444904449epcas5p38;
	Tue, 21 May 2024 14:32:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521143212epsmtrp1d40b8c5766d2686ff144fa1370aa26ed~Rh4OV6iaj1059910599epsmtrp1E;
	Tue, 21 May 2024 14:32:12 +0000 (GMT)
X-AuditID: b6c32a50-f57ff70000004be7-17-664d7c377c99
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.D8.08390.C60BC466; Tue, 21 May 2024 23:32:12 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240521143207epsmtip28e76ab14ae5d62e89c76cc7f79eda924~Rh4KWs-kW1282412824epsmtip2X;
	Tue, 21 May 2024 14:32:07 +0000 (GMT)
Date: Tue, 21 May 2024 19:55:09 +0530
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
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <20240521142509.o7fu7gpxcvsrviav@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d47b55ac-b986-4bb0-84f4-e193479444e3@acm.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH87v3cikF3LUM9xO2iDVGNgTaAeXHayMB3DWbyrJk6lyCDVwo
	Qh9py3DTMWACAtkY4zEp8qpsWFhAHmGAQBhvOpEgj/EYBXksIo4BOpgiRUqL+t8n3/P7nnN+
	5+SwcE6VuR0rUqJk5BJhNJdkE/Udhx2dPT9/J5zX0OeGqrTdOEq8sYWjiqkMEi11rAGUu/In
	jubbUgDa7B/AUV23DqBidQGBxtsaMdSsvokhTUUXhvJvXcVQ1/YTEt1sHwVoYUSFoZYJJ1SS
	XEqg5pY+Ag01fU2iojsL5qisR4+hzC9HMNQwnwBQ5dJTAvVO2KOBrR4zf3t6aPgkrVVDulE1
	ZU4P6KoJeqg/hq4pTyXp2tIr9C+1eYD+fjyepL+5nmVGX7u6TNKNSdNm9OrCBEE/bR0h6et1
	5YD+objTPNjmXJSviBGGMXIHRhIqDYuURPhxT54JCQjxEPD4znwv5Ml1kAjFjB838FSw81uR
	0TvD4TpcEEbH7EjBQoWC63rMVy6NUTIOIqlC6cdlZGHRMneZi0IoVsRIIlwkjNKbz+Md9dh5
	+HGU6Ln+gGz40KfFraHxYAOmAQsWpNxhbmcHkQbYLA7VDODK6N+kIcCh1gDcqHczBtYBrJ7U
	mO85HiTpTY4WALNn+4DR8RjAwTs+Biao1+Gj39KxNMBikZQTfLDNMsj7KUe4PlO268WpEhI+
	GnuOGwI2lBCWjbfs5rGmBFBT9DNm5BdhX948YWALygdW39WYGdiWOgi/uv0MNySC1IQFnJm7
	hRm7C4SaqU7SyDbw1546U9d2cDEj2cSxUJP9LWk0fwGg6qEKGAPHYZI2Azd0jVMieG/KlPMQ
	zNFW7jJOvQCvbc6bdGvYULjHr8G7VcWmui/D0Y0EE9Mwf6EDM05rGcDU2T7zG+AV1f8+p/qv
	nGq3hDdMXUk0M8r2sEzPMuJhWNXkWgzMyoEdI1OII5hQDxnfWcLE/rvuUKm4BuxezpHgBlDx
	3ZZLO8BYoB1AFs7db11T93Y4xzpMePESI5eGyGOiGUU78NhZViZuZxsq3Tk9iTKE7+7FcxcI
	BO5ebgI+94D1UlJBGIeKECqZKIaRMfI9H8aysIvH2EdzeMleec+eLM4xjZ5+unjL7dRSrVKn
	6z3bMN0Esz+Dc/cnHCbVPpotW/aEV+FAuvT9jX39PsG971Xdy0l4yTli5xC2ty8HXrDs/6Bb
	PL+QP86oxW63M4mNgDdFUbld6fgiMwbHskv9rWSDf3DiZ1OCCwev9QqTlLyAxHVq9LxN1qve
	4X+deEwHOfq/u2HL5p0Z/KjeXitS/151+eGHdZ8kO5Xc38ya8S0pqBxZtjgRq0rRa4OurBGn
	5UnsxJ+UhZPH91nFr57TWQZdLKqwiRv+Me5UZmMert86ZrU6rbrUcL7Su6/xjYOttVkyQVuc
	q96n3NI1cDLcUyeeIc6e5hIKkZB/BJcrhP8AT+V+8MIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7bCSvG7OBp80g5XXOCzWnzrGbNE04S+z
	xeq7/WwWrw9/YrSY9uEns8WTA+2MFr/Pnme22HLsHqPFgkVzWSxuHtjJZLFn0SQmi5WrjzJZ
	zJ7ezGRx9P9bNotJh64xWjy9OovJYu8tbYuFbUtYLPbsPclicXnXHDaL+cueslssP/6PyWJi
	x1Umix1PGhkt1r1+z2Jx4pa0xfm/x1kdpD0uX/H2OLVIwmPnrLvsHufvbWTxuHy21GPTqk42
	j81L6j1ebJ7J6LH7ZgObx+K+yawevc3v2Dx2tt5n9fj49BaLx/t9V9k8+rasYvQ4s+AIe4Bw
	FJdNSmpOZllqkb5dAlfGw+tGBW3SFQ33hBsYD4t1MXJySAiYSJxu/cfSxcjFISSwm1FiccNt
	FoiEpMSyv0eYIWxhiZX/nrNDFD1hlJj5fiMrSIJFQFXizptupi5GDg42AW2J0/85QMIiAhoS
	3x4sBxvKLLCUTeLi/t/sIAlhgUSJ5Tf3MoLYvAJmEivnP2SCGPqOUWLvzCNQCUGJkzOfgF3B
	DFQ0b/NDZpAFzALSEsv/gS3gFLCW2LhmJdgNogIyEjOWfmWewCg4C0n3LCTdsxC6FzAyr2KU
	TC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECE4WWlo7GPes+qB3iJGJg/EQowQHs5II76Yt
	nmlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MJlbr5su
	u3b3drOWZydueIS+/DmxVt54V7OjadysjwU+8ZqbJ1c19nI/nObnO121K3fDzgW8+mUWXMu+
	Ms19+OgJQ5x/dGyw15f49VaNez3DfjW2mT611axPT3ZPcVly4tnmtWvkK5+aqzNnfg3nM5t6
	gFH72RYnsS4Or2Osesc/r1t8b4pqc6Fja/pNppg07a+OdQ3pf5t2b9hpv7GV2dRosZV6bVrj
	nj8+iufP7/VLmavUoPDCaebe6hat6K9G+2Z/ueKhPaVJ5lvw3Zepx1ayP9rO83L3sbrzxm5e
	XKr/PtR8Mo/YxLrs5oaTt5rjm3+0B52Ji5l0pXOrqMiFmv+xUyo7TMt/ai7h33bmphJLcUai
	oRZzUXEiALgvX++FAwAA
X-CMS-MailID: 20240521143212epcas5p3ca522698f1f5e84f41add0e9cfdd0647
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_16190_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102830epcas5p27274901f3d0c2738c515709890b1dec4
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com>
	<20240520102033.9361-2-nj.shetty@samsung.com>
	<d47b55ac-b986-4bb0-84f4-e193479444e3@acm.org>

------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_16190_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 20/05/24 03:42PM, Bart Van Assche wrote:
>On 5/20/24 03:20, Nitesh Shetty wrote:
>>+static ssize_t queue_copy_max_show(struct request_queue *q, char *page)
>>+{
>>+	return sprintf(page, "%llu\n", (unsigned long long)
>>+		       q->limits.max_copy_sectors << SECTOR_SHIFT);
>>+}
>>+
>>+static ssize_t queue_copy_max_store(struct request_queue *q, const char *page,
>>+				    size_t count)
>>+{
>>+	unsigned long max_copy_bytes;
>>+	struct queue_limits lim;
>>+	ssize_t ret;
>>+	int err;
>>+
>>+	ret = queue_var_store(&max_copy_bytes, page, count);
>>+	if (ret < 0)
>>+		return ret;
>>+
>>+	if (max_copy_bytes & (queue_logical_block_size(q) - 1))
>>+		return -EINVAL;
>
>Wouldn't it be more user-friendly if this check would be left out? Does any code
>depend on max_copy_bytes being a multiple of the logical block size?
>
In block layer, we use max_copy_bytes to split larger copy into
device supported copy size.
Simple copy spec requires length to be logical block size aligned.
Hence this check.

>>+	blk_mq_freeze_queue(q);
>>+	lim = queue_limits_start_update(q);
>>+	lim.max_user_copy_sectors = max_copy_bytes >> SECTOR_SHIFT;
>>+	err = queue_limits_commit_update(q, &lim);
>>+	blk_mq_unfreeze_queue(q);
>>+
>>+	if (err)
>>+		return err;
>>+	return count;
>>+}
>
>queue_copy_max_show() shows max_copy_sectors while queue_copy_max_store()
>modifies max_user_copy_sectors. Is that perhaps a bug?
>
This follows discard implementaion[1].
max_copy_sectors gets updated in queue_limits_commits_update.

[1] https://lore.kernel.org/linux-block/20240213073425.1621680-7-hch@lst.de/

>>diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>index aefdda9f4ec7..109d9f905c3c 100644
>>--- a/include/linux/blkdev.h
>>+++ b/include/linux/blkdev.h
>>@@ -309,6 +309,10 @@ struct queue_limits {
>>  	unsigned int		discard_alignment;
>>  	unsigned int		zone_write_granularity;
>>+	unsigned int		max_copy_hw_sectors;
>>+	unsigned int		max_copy_sectors;
>>+	unsigned int		max_user_copy_sectors;
>
>Two new limits are documented in Documentation/ABI/stable/sysfs-block while three
>new parameters are added in struct queue_limits. Why three new limits instead of
>two? Please add a comment above the new parameters that explains the role of the
>new parameters.
>
Similar to discard, only 2 limits are exposed to user.

>>+/* maximum copy offload length, this is set to 128MB based on current testing */
>>+#define BLK_COPY_MAX_BYTES		(1 << 27)
>
>"current testing" sounds vague. Why is this limit required? Why to cap what the
>driver reports instead of using the value reported by the driver without modifying it?
>
Here we are expecting BLK_COPY_MAX_BYTES >= driver supported limit.

We do support copy length larger than device supported limit.
In block later(blkdev_copy_offload), we split larger copy into device
supported limit and send down.
We added this check to make sure userspace doesn't consume all the
kernel resources[2].
We can remove/expand this arbitary limit moving forward.

[2] https://lore.kernel.org/linux-block/YRu1WFImFulfpk7s@kroah.com/

>Additionally, since this constant is only used in source code that occurs in the
>block/ directory, please move the definition of this constant into a source or header
>file in the block/ directory.
>
We are using this in null block driver as well, so we need to keep it
here.

Thank You,
Nitesh Shetty

------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_16190_
Content-Type: text/plain; charset="utf-8"


------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_16190_--

