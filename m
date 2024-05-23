Return-Path: <linux-fsdevel+bounces-20085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B45708CDFDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 05:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86A11C222FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 03:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724063A1B0;
	Fri, 24 May 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oO8pl/Rp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111F38F98
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521943; cv=none; b=knhjqqUNVeDtM/567oECFKXk9tHfqZiJXWSF2BaeqVCA+decKGESUY3PPJO0yzZD7aVssW4ga1FceW0Eh5AWkvBfKCcaVwXckq1kIwc7MNGr8qcKxr+ZbD2ajiU9VMApmfL1wsj3arX4InHJnhubOZLUQelPNfDd6SEkvV2RbJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521943; c=relaxed/simple;
	bh=Rs8KfzPFWT1KO+9dMU8ukzxtSitXVwFhV5/HmJwGcis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=hc+pvvZuAx8T+zTSWEFwXcRg58ZHJa7Rw2haSjv/G0aQAWOhNrmKZnkZdVvPW+/2SkCxtRwvFZKpplfq/2ouhqVOPgcPbBFl63dxfyLEvUBRGxSt0cracXLAP/MEMHoSP82srlf6lurMc/Xc5LipayHLC6rA8HWk5c0hX1CCx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oO8pl/Rp; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240524033859epoutp0460ee606c85b08ae75b2b3866604da04a~ST5wP60HT2913429134epoutp04e
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 03:38:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240524033859epoutp0460ee606c85b08ae75b2b3866604da04a~ST5wP60HT2913429134epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716521939;
	bh=kEUNE5DDBugp0ptyOjlNvhJs+4yUfxAjHQz7sOYY5ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oO8pl/RpKAB+7hnb8+/HuUwu4GfoNyg9mfIlRSee1S4yn6MftXaxZVI9095j+T5Z7
	 QYkRsH0CwLC2tlealGyxh9oldqrKWLLlRR/kOzKUC2lMEYqkIaJT3LWUrLvUfQlh9r
	 q5nzNSzwGv/rvY9089VVkDawhsd5EJ79MaECwTLQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240524033859epcas5p3ab5fb4a491caf8ca91d3b7f32528fa36~ST5vooHaQ0531105311epcas5p3S;
	Fri, 24 May 2024 03:38:59 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VlrPF0SpVz4x9Pq; Fri, 24 May
	2024 03:38:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.94.19431.0DB00566; Fri, 24 May 2024 12:38:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240523114201epcas5p35636ecdb5665cc3d792c120f43e67d96~SG2NGF_tW0305503055epcas5p30;
	Thu, 23 May 2024 11:42:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240523114201epsmtrp18a825758bc171b7a412521bf53c949f7~SG2NE_PA90370403704epsmtrp1T;
	Thu, 23 May 2024 11:42:01 +0000 (GMT)
X-AuditID: b6c32a50-ccbff70000004be7-5d-66500bd0a7cf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.F1.08924.98B2F466; Thu, 23 May 2024 20:42:01 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240523114157epsmtip2db1c50506ea74d1d9e6f9373973e76e2~SG2JoFU973178131781epsmtip2B;
	Thu, 23 May 2024 11:41:57 +0000 (GMT)
Date: Thu, 23 May 2024 11:34:54 +0000
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
Message-ID: <20240523113454.6mwg6xnrkscu6yps@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <97966085-d7a4-4238-a413-4cdac77af8bd@acm.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd+69vRQEcwfqDrANVtzC23YUdkBwCyLezC3pZuYSCasNvUAD
	tF1bpjPZeIkKCyAoFKqM93gKExCBAZIiVqqMbTyGKNoZWCaMhxAVwmsthcX/Pr/H95zfIz82
	blth4cCWSFWMQiqK5ZBWREuPm6vXbzsEkdyiov2oQX8bR8kX1nBUO55FoumeBYDy5pdxNNF9
	DqCV/gEcNd9+BFBxaSGB7ne3YaijNAdD1bW9GLqsTsFQ78YMiXK0IwBNDmsw1DnmgUrOlhOo
	o7OPQIPtV0hU9NOkBarUrWMo+/wwhlonkgCqn54j0J0xRzSwpmN95EgPDh2h9aWQbtOMW9AD
	j64R9GB/PN1Yk0bSTeUJ9D9NBYD+5X4iSZdlXmTRGSmzJN2W+phFP5scI+i5rmGSzmyuAfS9
	4lsWArvjMYHRjEjMKJwZaYRMLJFGBXGOHBUeFPr6cXlePH/0AcdZKopjgjghnwi8QiWxxuFw
	nL8RxcYbXQKRUsnZdyBQIYtXMc7RMqUqiMPIxbFyvtxbKYpTxkujvKWMKoDH5b7va0w8EROt
	Tu6ykK/sPLVa8xgkgkbrdGDJhhQfXlPPYia2pToAnBv1SQdWRl4AMOP875jZeAGgdkZrsa2o
	6snGzYFOAKsbG4HZWATQ8EM/mQ7YbIJ6Fy5XuZqQpDzg3Q22SbuLcoUvDJWEKR2nSkj4cHQJ
	NwXsqBNwRp/NMrENdRCOdDZt8euwr2CCML1jSe2HZdXeJi2kfrWELUlXcXNBIbBvKGeL7eCU
	rnmrUAf4NOvsFp+E1ZeqSLP4DICaPzXAHPgQpuqzNsU4FQ3VN/O3HnoL5urrMbN/J8xYmcDM
	fhvY+uM2u8C6hmLSzPZw5GXSZu+QouGDOifzTGYBbFheABfA25pX+tG88p2ZA2DafDJLY5Tj
	lCOsXGeb0Q02tO8rBqwa4MDIlXFRTISvnOclZU7+v+QIWVwj2LwXd0ErqP15zVsLMDbQAsjG
	Obtswqo/jbS1EYu+Pc0oZEJFfCyj1AJf436ycYfdETLjwUlVQh7fn8v38/Pj+/v48Thv2Eyn
	FoptqSiRiolhGDmj2NZhbEuHREz2fRDKbedH5gsKNAkp34lOCz/7ePCer1NFl6WLRjwa0bRj
	MF+x5+q6k7D7HUOq5Oszt8J1oZkuVVdiDO56Z4MTdmjBsuHO5Sd3XS+Fo7a8orFOn4oWu4Ki
	ynMX1Q8VebqARY77tPdyvpXulL5ZObNiO+5oWLoZyG05+vde3bpV2vVpz9U3j/H7+Sp1tt3M
	X32LY7rVYN0xNydB+wPn1/zL53enpQ3vfc5Kee+Ll/btxGpOcLjcvr421POrtLV/b7g9nRrv
	qCsNOxydI2nJ9Esecv9jqkQaLDy84S8J8XxSkm+dB6xuJITtIaybrHI9Pa4Tnzv2HniWuzT5
	/MvC41ENsjIOoYwW8dxxhVL0H2e3GjK4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGc2em02kFHAHlQnFJY92IRQKYqyIQl2QSo7gkJi4JVjsgkVZs
	pYhBpSqLFbFg3KoIgrIUNygqiwgCIqsEsC5EERSUCKWAxo20aG2Mvn0n3/+f83Io3PkD4UFF
	yPezCrkkUkjyiXu1wpkLT3iFhC0qL+Sg2031ODqqteCo8M1pEg3WjgF0buQHjvqqkwAab23D
	UUl9N0BZ2RkEelVdhqEH2ekYKih8jKFL549h6PGEiUTpNc8B6jfqMFTZ5YWuJl4j0IPKRgJ1
	ll8mUWZuPxflPbFiKC3ZiKHSPjVAtwbNBGroEqA2yxNOsIDpfLaGacqGTJnuDZdp6y4imM7W
	aKZYf4JkDNeOMAOGi4CpeBVPMjmpZzjMqWPDJFOW8JbDjPZ3EYz5oZFkUkv0gGnJquOud9nK
	D5CykREqVuEduIO/e8CcQkTddDiQZjlPxgMrTwN4FKT9YH5tGq4BfMqZrgDw4btOzC7cYa6l
	DrezCyywfuTaQ6MAZuYk/B4oiqBF8Ef+PBuStBdsnqBscVd6Hvzak0fY4jh9nYTtVeNcm3Ch
	d0BTUxrHxo70Svi80sCx7xwGsOpjK2EXU2Djxb4/jNOL4RVDL247gNMCmGelbMijl8GcArEW
	0Lr/Crr/Crp/hSyA64E7G6WUhcuUPlE+cjZGrJTIlNHycPGuvbJi8OcVFswvBff1I+IagFGg
	BkAKF7o6bitYG+bsKJXEHmQVe0MV0ZGssgYIKELo5ug2cErqTIdL9rN7WDaKVfy1GMXziMdE
	usmbzJ/N06wHeoMSUjwfreYHjQnmxqkPeXYH61SXQuLOjlqWjs8IMZY/UwXO8u3xvxL/s1L0
	tLhEXWbJzwlZKOo++/JGwGL3oobcI++1a9GAdO6t9AumVDg81OipaR/+HpshS2px0/g2zY7e
	5RehHfJ7EbpFl97b8dUhmO6Yrj/tyavQnPQKXGJQjVmSt08KytxZNxLzKUtlvrNH1OhW2kD5
	D81ZJ94n6Q1OXNXitHlFs+Fo4UvlhtL13skz1C3H61MmFGpj82sn74qSqqldsaYhf2Oih5T4
	/EW7MeDwi6TB7zuXhi3PiKuWR2TkZb53zd9w2XTX6Hsm8qrT9ZhvciQklLslPgtwhVLyCyPH
	J1t5AwAA
X-CMS-MailID: 20240523114201epcas5p35636ecdb5665cc3d792c120f43e67d96
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_20cab_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102842epcas5p4949334c2587a15b8adab2c913daa622f
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
	<20240520102033.9361-3-nj.shetty@samsung.com>
	<97966085-d7a4-4238-a413-4cdac77af8bd@acm.org>

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_20cab_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 22/05/24 11:05AM, Bart Van Assche wrote:
>On 5/20/24 03:20, Nitesh Shetty wrote:
>>We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
>>Since copy is a composite operation involving src and dst sectors/lba,
>>each needs to be represented by a separate bio to make it compatible
>>with device mapper.
>>We expect caller to take a plug and send bio with destination information,
>>followed by bio with source information.
>>Once the dst bio arrives we form a request and wait for source
>>bio. Upon arrival of source bio we merge these two bio's and send
>>corresponding request down to device driver.
>>Merging non copy offload bio is avoided by checking for copy specific
>>opcodes in merge function.
>
>Plugs are per task. Can the following happen?
We rely on per-context plugging to avoid this.
>* Task A calls blk_start_plug()
>* Task B calls blk_start_plug()
>* Task A submits a REQ_OP_COPY_DST bio and a REQ_OP_COPY_SRC bio.
Lets say this forms request A and stored in plug A
>* Task B submits a REQ_OP_COPY_DST bio and a REQ_OP_COPY_SRC bio.
Lets say this forms request B and stored in plug B
>* Task A calls blk_finish_plug()
>* Task B calls blk_finish_plug()
>* The REQ_OP_COPY_DST bio from task A and the REQ_OP_COPY_SRC bio from
>  task B are combined into a single request.
Here task A picks plug A and hence request A
>* The REQ_OP_COPY_DST bio from task B and the REQ_OP_COPY_SRC bio from
>  task A are combined into a single request.
same as above, request B

So we expect this case not to happen.

Thank you,
Nitesh Shetty

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_20cab_
Content-Type: text/plain; charset="utf-8"


------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_20cab_--

