Return-Path: <linux-fsdevel+bounces-19974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831EF8CBA8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33A31F237C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330E78B50;
	Wed, 22 May 2024 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AR+hHqEp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB7770E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716354113; cv=none; b=nAWudsOpzGCz+H7x5xBGdlZU9JdCI0U6a83X5fh2FbdEk7UnH8dDj192Go6HA+LHPORiteNiau89HVxZ83gZhx5cNo2y686SiCKW0huENRT3bJT489TPPXalogy73VdB9iEP+UkVDB9GJtviFrretrSQLulaUco5uHQREIKfOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716354113; c=relaxed/simple;
	bh=HjjXK4Ysy43NZpV6lBg7GkSeQjmcVpx5NN3iCIDBiqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=V5/vNlhkTQCzw4TjQPUkF97dj3jXwi/eXbXXN+o46UChfetWpdW7thpL7FGUJQrQcyuDZXM4zfWdCooFpQoItmSUC6nOrKOotNXRbdRTtcu/hlMmIyxVy6CkJH3WVrExuhD3a//eI7Hke0UfNxZojYYdIWaJcro4QiMQb2kuWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AR+hHqEp; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240522050149epoutp01b59a30fe045bd8b9b50065bb60502eee~RtvgX8ehm0499104991epoutp01V
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 05:01:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240522050149epoutp01b59a30fe045bd8b9b50065bb60502eee~RtvgX8ehm0499104991epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716354109;
	bh=DggeZcWTQxSD6dy9JS1tgI9vw4vv8WBFabiQLbd4X8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AR+hHqEpov/nBuP80vyORvGBz0mr83cYCPy0QTdskgXSTjCcVvIvTTJGgsdgFRti/
	 RZYsfljHY/wQ9Z2pwUaAshyumWJyYcL4Py9cK7ySpAyT/6oAnh9VG1UbiQyL+zdRJ5
	 fT8hQSyUoi2/E1moad545iBL4z+KJgKjgrr0UP34=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240522050148epcas5p3c4a3f28cef0bd5e02de6f9b5e5c52139~RtvforWHq2695726957epcas5p3H;
	Wed, 22 May 2024 05:01:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VkfKl2J5gz4x9QG; Wed, 22 May
	2024 05:01:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.5C.09666.B3C7D466; Wed, 22 May 2024 14:01:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240521145331epcas5p11c17fe41c5bb4274709ce276701689ac~RiK1asoc70409004090epcas5p12;
	Tue, 21 May 2024 14:53:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521145331epsmtrp1f5ee5b14f8e07608a568c60474209726~RiK1ZjIdJ2167221672epsmtrp1h;
	Tue, 21 May 2024 14:53:31 +0000 (GMT)
X-AuditID: b6c32a49-cefff700000025c2-83-664d7c3bf736
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.0C.08924.A65BC466; Tue, 21 May 2024 23:53:30 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240521145327epsmtip25a3d61ceeed38d9846fc2b04a66595fd~RiKxv7Bmk2563925639epsmtip2t;
	Tue, 21 May 2024 14:53:27 +0000 (GMT)
Date: Tue, 21 May 2024 20:16:29 +0530
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
	nitheshshetty@gmail.com, gost.dev@samsung.com, Vincent Fu
	<vincent.fu@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 12/12] null_blk: add support for copy offload
Message-ID: <20240521144629.reyeiktaj72p4lzd@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2433bc0d-3867-475d-b472-0f6725f9a296@acm.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02TezBcdxTH87t39+5uZrQ3SPIjDL2NTDAe67H9ESLTpJ1r0hptI39kpmTL
	DYrd7a6tVM3UI5tKNERCGltibSIahAbjEdF6Ey1qkCLxaC0iW4/QaExCuvbSyX+f8/j+zvmd
	M4ePm9bwLPmRklhGLhFHU8R2TnWLvb3TgYQPT7n2rPNQeVc7jpIvruGoZDSDQPqWJYCuLK7i
	SNf4LUAvuntxVNU+BpBGm8dBw411GLqnvYShWyVtGPrh+xQMtb2aI9Cl5gcATQ2qMdQw4ogK
	zt7goHsN9zmo/24ugfJvTvFQUcc6hjJTBzFUq0sCqEy/wEGdI3vQZFoqQL1rHdxDVnT/wFG6
	SwvpOvUoj+4du8Oh+7uVdEXxOYKuvPEN/bgyB9D1w4kEfT39Mpe+kDJP0HWqcS79dGqEQy/8
	PEjQ6VXFgP5N08oLNDsR5RPBiMMYuS0jCZWGRUrCfamjn4QcDvEUuQqdhF7oHcpWIo5hfKkj
	HwQ6vR8ZbZgQZfulOFppcAWKFQrK5aCPXKqMZWwjpIpYX4qRhUXLPGTOCnGMQikJd5Ywsd5C
	V1c3T0PiyaiI7+p/J2QZVqefP1ThiWBu13kg4EPSAy48OcPbYFOyHsCnk8rzYLuBlwz8j5Zg
	jRUAdXXD2Jai8U4fhw00AFjTOs5ljWkAK5bGjVkc0g7mV6waAnw+QTrCX1/xN9zm5H64MlFk
	FONkJwFLywaM+WbkezCjrcjYhwkpgqUFyTjLO+D9HB1ngwXkAfh0KM3IO0kreLXwGb7xECSn
	BbD1+TLBtncEaq695LJsBp90VPFYtoSzGWc3OQ7eyvqRYMVnAFT/oQZswA+qujKMlXEyAj5q
	yt4UWMPsrjKM9b8BL7zQbc7CBNZe2+K3YWm5ZrMJC/jg36RNpuHf7VOAnfACgMvT+y4CG/Vr
	n1O/Vo5lb3huMZmrNgwPJ/fAonU+i/aw/K6LBnCLgQUjU8SEMwpPmVDCxP2/8VBpTAUwXpCD
	fy0YnVh0bgYYHzQDyMcpc5OKKv9TpiZh4q/iGbk0RK6MZhTNwNOwrEzccmeo1HCCktgQoYeX
	q4dIJPLwchcJqd0melVemCkZLo5lohhGxsi3dBhfYJmI1VTP27Wc+Px2qHd3yYDkahBhU/3n
	5N6xXURm/VvyYwnbYh75Dlur1qbkpLtfQI/Z6Tnnr+2z9o8P3BS9OV/8su96UHZ+y6fBEZqo
	vtyEKyG/3PY/2XSsdDGo/tAqpsvRxrUif1VUXby3H/7X44DC/OVcvf27+R+Dtrzg3TbUxPBM
	T2rVT0RWaYGOu3I5z06/wmsXWbu5PqPd0vS0qkZQoO3/Ir1zrWifT9fB2ZIkZfvQ8ZbPArT2
	jcJthfLBj4Txicji4UzJQLamKdjPdsohxWpZYB451Hu4EceT1o+vSEVRniszC23ps+4zBOEi
	617TMxgliBzc60h1cCrrw3dQHEWEWOiAyxXi/wA4I4EYygQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7bCSvG7WVp80g+nzbCzWnzrGbNE04S+z
	xeq7/WwWrw9/YrSY9uEns8WTA+2MFr/Pnme22HLsHqPFgkVzWSxuHtjJZLFn0SQmi5WrjzJZ
	zJ7ezGRx9P9bNotJh64xWjy9OovJYu8tbYuFbUtYLPbsPclicXnXHDaL+cueslssP/6PyWJi
	x1Umix1PGhkt1r1+z2Jx4pa0xePuDkaL83+PszrIeFy+4u1xapGEx85Zd9k9zt/byOJx+Wyp
	x6ZVnWwem5fUe7zYPJPRY/fNBjaPxX2TWT16m9+xeexsvc/q8fHpLRaP9/uusnn0bVnF6HFm
	wRH2AOEoLpuU1JzMstQifbsEroxLD56zFxyUrFh+dAl7A+NOkS5GTg4JAROJAxsvsnQxcnEI
	CexmlJh86icTREJSYtnfI8wQtrDEyn/P2SGKnjBK/O67BVbEIqAqMX/TT9YuRg4ONgFtidP/
	OUDCIgIaEt8eLAcbyixwhk3i3Np/jCAJYQFXif6jy9lBbF4BM4k1C5uYIYa+Z5Q4+/QzM0RC
	UOLkzCcsIDYzUNG8zQ+ZQRYwC0hLLP8HtoBTwFri441usBJRARmJGUu/Mk9gFJyFpHsWku5Z
	CN0LGJlXMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEpw4tzR2M21d90DvEyMTBeIhR
	goNZSYR30xbPNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTByc
	Ug1Moetsf90sOmubUuETbS73c+E5zq/5G4+kt0eXiZxJWN9wZHfLR+bs1cujmxdsNZjA45Q8
	cXZ9mkKol3vakdvTdRYb6NeHHhV4wlKTnvumRmKdbrBl+UznO7JVnnyLCs4LmG3S/LdZY3m1
	e6HArruv139zjFPJD3gw7XXlnO29Nn+WaUiwVigGmXjsNZZ1WH5zwZ1Ioc8dcz5V8bD56D6V
	ufEovl4/+5v1+X9xJ7g7nihbOlU+b1fYEM4p9lFw0p9Fv3mC9AtYgtwPiDm6F2Qstp+pN+Fp
	lrvHxJOCn4NzJ3074Giz6EqT5oO/RsuZRHnWscyay2HA8eRo+rajATfCL020j/pnw+Wmvdu8
	kkWJpTgj0VCLuag4EQAWEm7zjAMAAA==
X-CMS-MailID: 20240521145331epcas5p11c17fe41c5bb4274709ce276701689ac
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_161f6_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520103039epcas5p4373f7234162a32222ac225b976ae30ce
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520103039epcas5p4373f7234162a32222ac225b976ae30ce@epcas5p4.samsung.com>
	<20240520102033.9361-13-nj.shetty@samsung.com>
	<2433bc0d-3867-475d-b472-0f6725f9a296@acm.org>

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_161f6_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 20/05/24 04:42PM, Bart Van Assche wrote:
>On 5/20/24 03:20, Nitesh Shetty wrote:
>>+	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
>>+		return status;
>
>Why is this check necessary?
>
>>+	/*
>>+	 * First bio contains information about destination and last bio
>>+	 * contains information about source.
>>+	 */
>
>Please check this at runtime (WARN_ON_ONCE()?).
>
>>+	__rq_for_each_bio(bio, req) {
>>+		if (seg == blk_rq_nr_phys_segments(req)) {
>>+			sector_in = bio->bi_iter.bi_sector;
>>+			if (rem != bio->bi_iter.bi_size)
>>+				return status;
>>+		} else {
>>+			sector_out = bio->bi_iter.bi_sector;
>>+			rem = bio->bi_iter.bi_size;
>>+		}
>>+		seg++;
>>+	}
>
>_rq_for_each_bio() iterates over the bios in a request. Does a copy
>offload request always have two bios - one copy destination bio and
>one copy source bio? If so, is 'seg' a bio counter? Why is that bio
>counter compared with the number of physical segments in the request?
>
Yes, your observation is right. We are treating first bio as dst and
second as src. If not for that comparision, we might need to store the
index in a temporary variable and parse based on index value.

>>+	trace_nullb_copy_op(req, sector_out << SECTOR_SHIFT,
>>+			    sector_in << SECTOR_SHIFT, rem);
>>+
>>+	spin_lock_irq(&nullb->lock);
>>+	while (rem > 0) {
>>+		chunk = min_t(size_t, nullb->dev->blocksize, rem);
>>+		offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
>>+		offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
>>+
>>+		if (null_cache_active(nullb) && !is_fua)
>>+			null_make_cache_space(nullb, PAGE_SIZE);
>>+
>>+		t_page_in = null_lookup_page(nullb, sector_in, false,
>>+					     !null_cache_active(nullb));
>>+		if (!t_page_in)
>>+			goto err;
>>+		t_page_out = null_insert_page(nullb, sector_out,
>>+					      !null_cache_active(nullb) ||
>>+					      is_fua);
>>+		if (!t_page_out)
>>+			goto err;
>>+
>>+		in = kmap_local_page(t_page_in->page);
>>+		out = kmap_local_page(t_page_out->page);
>>+
>>+		memcpy(out + offset_out, in + offset_in, chunk);
>>+		kunmap_local(out);
>>+		kunmap_local(in);
>>+		__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
>>+
>>+		if (is_fua)
>>+			null_free_sector(nullb, sector_out, true);
>>+
>>+		rem -= chunk;
>>+		sector_in += chunk >> SECTOR_SHIFT;
>>+		sector_out += chunk >> SECTOR_SHIFT;
>>+	}
>>+
>>+	status = 0;
>>+err:
>>+	spin_unlock_irq(&nullb->lock);
>
>In the worst case, how long does this loop disable interrupts?
>
We havn't measured this. But this should be similar to read and write in
present infra, as we followed similar approach.

>>+TRACE_EVENT(nullb_copy_op,
>>+		TP_PROTO(struct request *req,
>>+			 sector_t dst, sector_t src, size_t len),
>>+		TP_ARGS(req, dst, src, len),
>>+		TP_STRUCT__entry(
>>+				 __array(char, disk, DISK_NAME_LEN)
>>+				 __field(enum req_op, op)
>>+				 __field(sector_t, dst)
>>+				 __field(sector_t, src)
>>+				 __field(size_t, len)
>>+		),
>
>Isn't __string() preferred over __array() since the former occupies less space
>in the trace buffer?
>
Again we followed the present existing implementation, to have a simpler
series to review.

Thank you,
Nitesh Shetty

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_161f6_
Content-Type: text/plain; charset="utf-8"


------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_161f6_--

