Return-Path: <linux-fsdevel+bounces-19885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F339E8CAF07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 15:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62422B210A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61227C6C9;
	Tue, 21 May 2024 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="doeRCQVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43779945
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296898; cv=none; b=fvwhgCaEWpmEo5kBVvr9MySg8Y+z+OXXIrX6f65Hj8inmqySyG+xZVhNtyJWfJXF4RBMV1fngOgio8y8N5zxsUxI5R5uN4lo9F3XX2hFQWi0EhOmTV5YOdbO42UVzmN/e7nQeexSusV4LOy7mKJWmmFXnjSQbk/5784E9wm2GVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296898; c=relaxed/simple;
	bh=w4IzJBQom6e/eg+5ubWFpWqhEhfye03AL1iiFU9y0lM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=fCDXVIlARkI97U7MTkHfONFBlv30AFDMcSPt+HX14KSi4OhScjkMkuiwstcFMARjnvSfqFk+DhUOCn0IxwRblU+ywXRmlpmtdcc/ORZyQdqU4BHGrQX5PpXrDZvGi4INcXTif4az5wv5AckPSb7yJVfLIfL0g1Z7ZNAMc+Ln6Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=doeRCQVb; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240521130814epoutp04e93c789b077133271e325753ff58682b~Rgu6NK22L2499724997epoutp04W
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 13:08:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240521130814epoutp04e93c789b077133271e325753ff58682b~Rgu6NK22L2499724997epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716296894;
	bh=CUX2VqrjfI/EEDqyZU4uVkkHPh5azdlSMuCxpIfmh70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=doeRCQVbnOIa2lzDpkAPTeARfiVfov5TkfHQYT5U8PQlcv79cBywDooEV3FKi7dUr
	 CKyrhdn7KnfZsgCKbGhDkxkMJaIy1ezXABEkOLqxIC/+HsnCCkY0CFK0fDmvzsFfC/
	 cL1kkhZt5GrA5PQhw484fri4pwPCf03SGCHiBcgA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240521130813epcas5p4f33cd571cfdf2daa8ee1663f270202e2~Rgu5nUAr31546115461epcas5p4o;
	Tue, 21 May 2024 13:08:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VkF9R4XwQz4x9Pv; Tue, 21 May
	2024 13:08:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	94.0C.09666.BBC9C466; Tue, 21 May 2024 22:08:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240521113644epcas5p49bfa818b6040f17bad23f24e303ad269~RffB5Asan0500905009epcas5p4Q;
	Tue, 21 May 2024 11:36:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240521113644epsmtrp264154696bb143f8efc50b183487f8be0~RffB3y50X0882408824epsmtrp20;
	Tue, 21 May 2024 11:36:44 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-46-664c9cbb21d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	66.AF.08390.C478C466; Tue, 21 May 2024 20:36:44 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240521113640epsmtip2581da03f3a550f38dd151415706754e9~Rfe_OwQgG1086110861epsmtip2B;
	Tue, 21 May 2024 11:36:40 +0000 (GMT)
Date: Tue, 21 May 2024 16:59:42 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, Vincent Fu
	<vincent.fu@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 04/12] block: add emulation for copy
Message-ID: <20240521112942.f23aael3qehi4gww@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cf6929e1-0dea-4216-bbc5-c00d963372f7@suse.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA01TezBcZxT33bvuLtOVazE+guimnUTEYxO2n9SjUya9Bo2ZzLQNTXWH6zHW
	7nbXIzE19ah6ZKzH5mUjraiWoMQjSjyarghWlVRIV0oy8RhliEeSFrWptWTy3+/8vt/vnPOd
	M4eFc5qZ1qwYUTwtFQmEXMKY0dzl4ODUVhIY6VqwZIvq1HdxlF6wiaPq8XwCzXetAHRxaQ1H
	U7ezANoYGMRR090JgErLrjKQ5nYrhtrLijB0vbobQ1cuZWCo++UCgYpUowBNjygx1DHmiK59
	U85A7R19DDR8q4RA3/04zUQVPVoMFWaPYKhlKg2g2vmnDNQ7thdNnssGaHCzx/A9G2r4fgCl
	LoNUq3KcSQ1O1DOo4YEEqqEqh6Aay7+iZhuLAdWmSSWo7+UKQyovY5GgWjMfGVLL02MM6mnn
	CEHJm6oA9VvpHWawWUisZzQtiKCl9rQoXBwRI4ry4gacDPMNc+e78px4Hugdrr1IEEd7cf0C
	g52Oxwi3JsS1TxQIE7aoYIFMxnXx9pSKE+Jp+2ixLN6LS0sihBI3ibNMECdLEEU5i+j4YzxX
	1yPuW8LPY6OfKRS4ZIU8s/ZMwUgFV0xygRELkm7wz5liIhcYszhkG4DrqfWYPlgB8OHQBtCp
	OOQLAFtnXznU5y7uiDoAfNQ4sBPMAPjTrAbTqRjk2zC3P5uZC1gsgnSE/S9ZOtqc5MLlLBVT
	p8fJ3wmoqWjarmBGekJtxZNtzCb5UK44z9RjU9hXPMXQ5TEi34XDqx/qaAvSBl7+4TmuywPJ
	CSNYsdBJ6Lvzg/eqd7EZnOtpYuqxNVxd7Njhk+D185WE3vw1gMoHSqB/8IGZ6nxch3EyGs6u
	lOJ63hZeUNdiet4E5m1MYXqeDVu+3cX7YU1d6U4BKzj6TxqhaxqSFCysCdUPaBHA2aJsZgHY
	p3ztb8rXyunxMZizlG6o3LLj5F5YoWXpoQOsu+VSCgyrgBUtkcVF0TJ3CU9EJ71aeLg4rgFs
	H9Ah/xYw/njJWQUwFlAByMK55uyGJv9IDjtCcDaZlorDpAlCWqYC7lu7KsStLcLFWxcoig/j
	uXm4uvH5fDePo3we15I9n3k1gkNGCeLpWJqW0NJdH8Yysk7FYo7u37zz5OSnv9jUlsRqQrRx
	gkitKvig7VJe/yXtvsS1DxbfsGIP7UkKlf83Y/AgJsgxXzqigZV2g6PPB1bvvdnnNff3xycs
	T7mY/So+m2LCyfGWj5oW35BXlR/2+cLloLzd0umvwMqaM1KxhVGEMcuA/yWOi5M37dZH/MW8
	zy505uKJ5ZM32el7hKcOzI5HfTLeHNrX2UPdNAsJTgujsxcyFadfaPqvLXdYdJ1Qd8OaoAPF
	FaNqXpbv4Q1nk8eqI3O8P9LzMjhFgpSw6p/HeydTmEGJ7cLkaFdT7Ud19x8OuXfHWq//62Pg
	m1Ps5w3fUklu9HofL7ftqw+wu/y++emBIi5DFi3gHcKlMsH/dMWR5MkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCSvK5Pu0+awYxf6hbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9FiwaK5LBY3D+xkstizaBKTxcrVR5ks
	Zk9vZrI4+v8tm8WkQ9cYLZ5encVksfeWtsXCtiUsFnv2nmSxuLxrDpvF/GVP2S2WH//HZDGx
	4yqTxY4njYwW616/Z7E4cUva4nF3B6PF+b/HWR1kPC5f8fY4tUjCY+esu+we5+9tZPG4fLbU
	Y9OqTjaPzUvqPV5snsnosftmA5vH4r7JrB69ze/YPHa23mf1+Pj0FovH+31X2Tz6tqxi9Diz
	4Ah7gHAUl01Kak5mWWqRvl0CV8aUxq/sBUv4Kg5tKG9gfM7dxcjJISFgInGqexpTFyMXh5DA
	bkaJVVc/sEAkJCWW/T3CDGELS6z895wdougJo8T0V2vYQRIsAqoSXac7gGwODjYBbYnT/zlA
	wiICShIf2w+B1TMLXGKTWL5wN9ggYQEbiX/LHzGC2LwCZhJ9k6dADX3HKNF8ZjsrREJQ4uTM
	J2BXMAMVzdv8kBlkAbOAtMTyfxwgJqeAtcTlz34gFaICMhIzln5lnsAoOAtJ8ywkzbMQmhcw
	Mq9ilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAhOG1paOxj3rPqgd4iRiYPxEKMEB7OS
	CO+mLZ5pQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTCV
	+51k8X2sq169+fjktuiPcRIfOu96K9Qejnr0yG+ZI9/N1MgDEtcXXXApTZmxs+7TV36RzyGz
	Q0L+BE+I/NIzaa6Au3GGSNTich6Lg1Pedl5dJTx9p8yLXD33niC5Dz+Tsy1DytvK9bpsdr/f
	0KClNanQNMt6f47bn9kb9TyFJogU+M0q+DCl8cH5w20vWVMjUzTXr616qFPZ3+8YZF6p+NKW
	v2HeZv5lxVOYGZSdfWsfB1Uanjy29ULul2fzIysFE0x4mNbN2lbTXfLBefHz2Yf1A4Qfzw7c
	1bR8aVWJTVv20/Ul8mkLb8S9mPmHjXP6J042xrozYXv/X8zSjHtX4PxEdpml8lwt39+H05VY
	ijMSDbWYi4oTAVGa+qWKAwAA
X-CMS-MailID: 20240521113644epcas5p49bfa818b6040f17bad23f24e303ad269
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_159f3_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102906epcas5p15b5a0b3c8edd0bf3073030a792a328bb
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102906epcas5p15b5a0b3c8edd0bf3073030a792a328bb@epcas5p1.samsung.com>
	<20240520102033.9361-5-nj.shetty@samsung.com>
	<cf6929e1-0dea-4216-bbc5-c00d963372f7@suse.de>

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_159f3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 21/05/24 09:06AM, Hannes Reinecke wrote:
>On 5/20/24 12:20, Nitesh Shetty wrote:
>>For the devices which does not support copy, copy emulation is added.
>>It is required for in-kernel users like fabrics, where file descriptor is
>>not available and hence they can't use copy_file_range.
>>Copy-emulation is implemented by reading from source into memory and
>>writing to the corresponding destination.
>>At present in kernel user of emulation is fabrics.
>>
>>Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
>>Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>>---
>>  block/blk-lib.c        | 223 +++++++++++++++++++++++++++++++++++++++++
>>  include/linux/blkdev.h |   4 +
>>  2 files changed, 227 insertions(+)
>>
>Again, I'm not sure if we need this.
>After all, copy offload _is_optional, so we need to be prepared to 
>handle systems where it's not supported. In the end, the caller might
>decide to do something else entirely; having an in-kernel emulation 
>would defeat that.
>And with adding an emulation to nullblk we already have an emulation
>target to try if people will want to start experimenting.
>So I'd rather not have this but rather let the caller deal with the
>fact that copy offload is optional.
>
Unlike previous iteration, blkdev_copy_offload doesn't fallback to emulation
incase offload fails.
This is one more option caller/user can leverage, if for some reason
device copy offload is not supported/optimal.
It is upto to the caller to decide, if it wants to use copy emulation.
Moreover we found this is very useful for fabrics scenario, where this saves
the network bandwidth, by sending offload over the network rather than
read+write(when target doesn't support offload).

Thank you
Nitesh Shetty

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_159f3_
Content-Type: text/plain; charset="utf-8"


------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_159f3_--

