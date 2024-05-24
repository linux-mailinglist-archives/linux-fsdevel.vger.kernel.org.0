Return-Path: <linux-fsdevel+bounces-20102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA568CE148
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 09:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265B62827A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 07:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20A612881C;
	Fri, 24 May 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GqL9tjnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3A127B73
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534217; cv=none; b=bdBwsasq0wQCil8iM75v2G7I+4CAwHrHU34MUzvmDP6nICM5PqEjIdPPkw6dq/ZISEK7AceBi7B8tzHfoJ/30XIhzpzeU18FLBz9AUVdFosx6vhJKXJjDMhWPlBrLpzJid75heRysJJa+t5MoaFHaTrjVDwjZOHp7gqjgE69nIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534217; c=relaxed/simple;
	bh=F2JL3Tk4mSGuw62JqOU9hci9zTtERlsnAZex134S9BI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=UBk3418zkvsjFrCVpbFsCCqj8YaxPaiyFyx+4AwZemjm4kZ8ZtZmx4c9q7BXF3rrHEL8Qz+Gwas1gZ3T0VPApnTegcX5RG2TSjVP/9h7RuMdyDBv+rC9tQMNXFT+sd9Y4lm1YZSuDKBw4+AN/gT4OGWr7LIzbmYwGuNQbOnUo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GqL9tjnZ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240524070331epoutp03ae79acbb2ca85b0d2193503007a74be4~SWsVI-60r0181101811epoutp03H
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 07:03:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240524070331epoutp03ae79acbb2ca85b0d2193503007a74be4~SWsVI-60r0181101811epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716534211;
	bh=fcrs1hfVkjlHVW7bOXNOC8znpYsTD2JmXRZJGVnZaTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GqL9tjnZZt8X6EigF1/D5trSRVqa3CmecAJbL891GseVyUaF5ibFdJ6syZS7PAjWU
	 EMQbagZf+nBm810/AshsWNVSYa4JK3qP+RV2Qdc7UKloK5ak50urZ1nqY2pkPP4P/i
	 /1nMD2xnS7YlMQmDNGP+DUD4UDSHLAc1Svfk5Wa4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240524070330epcas5p193140b9e9c3ca20ce1044b5e97e16cc7~SWsUYtv1G2043720437epcas5p18;
	Fri, 24 May 2024 07:03:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VlwxD29VZz4x9Q6; Fri, 24 May
	2024 07:03:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	43.35.09665.0CB30566; Fri, 24 May 2024 16:03:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240524070201epcas5p3a398a82835799d0956448c3590544c0a~SWrBgm2e33040130401epcas5p3j;
	Fri, 24 May 2024 07:02:01 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240524070201epsmtrp27d72daa4f932ba34758cd2fa2e31a2ba~SWrBfF5Gm1951119511epsmtrp2S;
	Fri, 24 May 2024 07:02:01 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-6d-66503bc0b68a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.14.19234.96B30566; Fri, 24 May 2024 16:02:01 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240524070157epsmtip26fdc4027c3bba14725ebb809cd21c241~SWq93B5fC0925409254epsmtip2m;
	Fri, 24 May 2024 07:01:57 +0000 (GMT)
Date: Fri, 24 May 2024 06:54:49 +0000
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
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240524065449.ydfracefq77urii4@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f54c770c-9a14-44d3-9949-37c4a08777e7@suse.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH97u3vS1EyLXg/FmiwzKzVMKjUNgPBcYmIdegjOwRM9wGd/QK
	SGlry0uSKRQZoCIFEUMRQYbykIECIyCgrPKQqquGhwFE3psTeQiLZkFhrQXjf5/zPeeb8/ud
	k8PFeVc4fG6ULJZRymipgLBkNd4WCp3adwcfcv2rcgOq1XfhSK15g6OrI9kEmrm9CFD+wn84
	mmpPB2j5vgFHDV1PACopLWKhwfZmDLWW5mKo8monhgrPp2Koc3WWQLm6AYCm+7UYahtyRJd+
	KWOh1rYeFuq9cYFAxVemOai8ewVDORn9GGqaSgGoZmaehe4M2SHDm262nx3V2xdI6Ush1awd
	4VCGJ9dZVO/9OKquKpOg6suOU0/rCwDVMphMUL+eOcumslLnCKo5bZRNvZgeYlHzN/sJ6kxD
	FaDulXRwgm1Cor0jGVrCKO0ZWbhcEiWL8BEEfh26J9TD01XkJPJCnwrsZXQM4yPw3xfsFBAl
	NQ5HYB9PS+OMUjCtUglcfL2V8rhYxj5Sror1ETAKiVQhVjir6BhVnCzCWcbE7hK5urp5GAvD
	oiNPZTcSiqWNiU2neclgwPoksOBCUgyzz/WzTwJLLo9sAfBpURFhDhYBPG2YZL0LJrIvYuuW
	S6vFmDnRDODD4fE1/xKAdeNDwFTFInfA/L6zRjuXS5CO8O4q1yTbkgL4Il3HMdXjZDkBX6+O
	sE0JGzIMzupz3rIVuQcuFtzkmHkj7CmYYpnYgtwNX3cM4iYzJP+0gPc6KzjmJ/lD7cuutefZ
	wGfdDWs6Hy7NtRFmToCVeRWE2XwCQO0jLTAnPoNp+mzcxDgZCccznuNmfSs8p6/BzLo1zFqe
	WmtgBZsurrMDrK4tWWuwBQ68SiFMP4YkBYerPzJPZQ7AxjsaTAO2ad/7kPa9dmbeBTMX1Gyt
	0Y6TdrB8hWtGIay94VIC2FVgC6NQxUQwKg+Fu4xJeLflcHlMHXh7MDsDm8DE2IKzDmBcoAOQ
	iwtsrQ5W7j/Es5LQR5MYpTxUGSdlVDrgYVxQDs7fFC43XpwsNlQk9nIVe3p6ir3cPUWCzVYz
	aUUSHhlBxzLRDKNglOs+jGvBT8YO9vsdzg0ytAZ8KFsaqcMffuk7KdKceukU4mi937JxyeDw
	+NXzI0sq4e8h+em3Wr9tlz7wn8u5npJE8KU1YTwgTOXrkv7OczhOb6hUu0xW3JJEz//Raqt+
	sCeRxIJTBgK1GX0XMqPVLQe+yNn6cdpPY9cCyo7urfNiUmd+Ezf6eyc8/mqH/bP87SEBMZfz
	/o3//oPZyw5jpT88ovJP7EWhhcMzGb4en0xOB23PCDpg4zH18+fx85K+CfpuvU/Q4ZaF6k3F
	x+QdWVN9bpoaZ99j2470i1cCu5KD/imUlwj97N2+0Y8lFvwY3rhZGdpjqcaCNXmC72rTLbuW
	z48S5LUkd9A8KmCpImnRTlypov8HtDMqBbkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUxTWRiGOfdcbi9V9Fq2A3UZ6xZlqHZCyFGMkmgmJ1FiXWaMEpVGLrUj
	UGwtihpBiQI1OkhRhyrKZrHgEgou7FoBBSXNTAGljogB4oLC4MTEra0pxOi/J+/zvt+vj4Wi
	fjqEVSXt5jVJigQJI6Rv3JXMCFNFyuMXXT4lxtfaWyE+nOOEuOLpnwweuvsO4NP/fYR44HYm
	wJ87bBBXt/YCXFhcQOOe2zUUri/OpbC5ooXCZ89kULjF/ZbBudZugAe7jBRucITioqOlNK5v
	aKOxvfYcgy+YBgW47J6Lwiezuih8a+AQwFeHRmh83yHGNuc97ygxsXeuIu3FiNQYnwqIrbeS
	JvYOHbGUZzOkqjSNvKzKB6SuJ50hJScM3uR4xjBDao488yajgw6ajDR2MeREdTkgDwubBXK/
	zcKlcXyCKoXXLFwWK9zxvP9/Kvni5L3mjGMgHRRP1AMfFnHhqMh9gdIDISvibgKUZ6tkxkUw
	Mjmb4Tj7IbPrhWC8NApQ15k6yiNobg463Wmg9YBlGS4UPXCzntifk6DRTOtYH3IVDKq1lgCP
	8ONi0dv2k94e9uVWoHf5jQIPi7hhgJoy8Hg+BbXlD9AehlwEOl/1HHruQ06Mylxj9324SPSl
	uQfmAM74w8L4w8L4fVEIYDkI4JO1icrE7ckyqVaRqNUlKaXb1YkWMPYHC9bdAqZrTqkVUCyw
	AsRCib9vjDk6XuQbp0jdx2vU2zS6BF5rBWKWlgT5zkrIjhNxSsVufifPJ/Oab5ZifULSqWAe
	TvUP/2NGgfD99NcGNTJPCI+rXViwZfmNpE2m89X2ol8OdM9c9rLaK2vpb+KYL4P/9jmalmyU
	VjwJ2Leh744+8mBglt7vYVPdSNimna4J8o8H3N0tlr8i4q/EtslyyNyo8Murjz6bZ3ZC+YM9
	G6JWWGbTaatjU4Tq6JDfg9fCF+v3/zRla9ixv1+nqHNRb6rpVWpgzeNHWfOvXwk6lFOy0r72
	UkraK0NMr2SNrd9ryCJzX4/p3lUipbb8k2dV1S4Wq0vrJ+taQ6O9+JDswMrhaR1ElRe0X9pA
	lmf+PEn/qw41KvvqlR3kzQel7smlTsPiN4fL5LJPAeoInw8OZb7rvoTW7lDIFkCNVvEVtAjO
	T3YDAAA=
X-CMS-MailID: 20240524070201epcas5p3a398a82835799d0956448c3590544c0a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_250cc_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102842epcas5p4949334c2587a15b8adab2c913daa622f
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
	<20240520102033.9361-3-nj.shetty@samsung.com>
	<f54c770c-9a14-44d3-9949-37c4a08777e7@suse.de>

------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_250cc_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 21/05/24 09:01AM, Hannes Reinecke wrote:
>On 5/20/24 12:20, Nitesh Shetty wrote:
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
>>
>>Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>>---
>>  block/blk-core.c          |  7 +++++++
>>  block/blk-merge.c         | 41 +++++++++++++++++++++++++++++++++++++++
>>  block/blk.h               | 16 +++++++++++++++
>>  block/elevator.h          |  1 +
>>  include/linux/bio.h       |  6 +-----
>>  include/linux/blk_types.h | 10 ++++++++++
>>  6 files changed, 76 insertions(+), 5 deletions(-)
>>
>I am a bit unsure about leveraging 'merge' here. As Bart pointed out, 
>this is arguably as mis-use of the 'merge' functionality as we don't
>actually merge bios, but rather use the information from these bios to
>form the actual request.
>Wouldn't it be better to use bio_chain here, and send out the eventual
>request from the end_io function of the bio chain?
>
With above bio chain approach, I see a difficulty while dealing with
stacked/partitioned devices, as they might get remapped.
Or am I missing something here ?

Bart, Hannes,
Regarding merge, does it looks any better, if we use single request
operation such as REQ_OP_COPY and use op_flags(REQ_COPY_DST/REQ_COPY_SRC)
to identify dst and src bios ?


Regards,
Nitesh Shetty

------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_250cc_
Content-Type: text/plain; charset="utf-8"


------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_250cc_--

