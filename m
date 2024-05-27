Return-Path: <linux-fsdevel+bounces-20213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814E08CFC2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 10:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139271F22F70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 08:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C6E6E613;
	Mon, 27 May 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cSH1gUIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181356477
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799831; cv=none; b=W3kI2gcj6phs+VxctYjTefM2BFJV01C+apstmeImr3M6Mmlk4vbFht/BX1P85Sg7KJc2FR/sLSLCu1CsKgQAAD9aLWEShd53/r+3fwMKxHpSH9h347D6+z0v1iEFQ0VpDWqveT7P+10A+vUEVXCUxr2d5vbrfMbBFkgn0rfJE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799831; c=relaxed/simple;
	bh=kkwyr4IrDzpXNlvF8g00GlFvbD3vU5anIx51KLEOqyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=kqbTsx/2TssU663lgkKMZpvmMC66gSCJ5lnMQ3tAr9hz0GIIXJ3bMcwCZ6EMR4ACrQiq1PimM8Fs9qsEg5u7N8LMUBXaNktQR0MiEVSCArPqJkmwtHJljcJgf2+1eYcJ3XODEl9eXxJsvBRwrwSJuIsys6pwbK1KKnDqqzmozNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cSH1gUIu; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240527085027epoutp02302afcf7ec5786bf2f4ec3406b3114f9~TTFj2i54l1769717697epoutp02L
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 08:50:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240527085027epoutp02302afcf7ec5786bf2f4ec3406b3114f9~TTFj2i54l1769717697epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716799827;
	bh=kkwyr4IrDzpXNlvF8g00GlFvbD3vU5anIx51KLEOqyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cSH1gUIuODgkOcBTIQQjHFRwQhKG9wwEypdPHh8CnWuvAc7Daaw7g0HCNPh8/5ida
	 wwu4Olya0peTzFKSUT9tLuhk0/OhMMjzOXnfOF7OLDM6QEqUStbaEissdfpPa5jTMU
	 N/PNaOHsDhBG2es8LUWGv43c4ka4Z7Adi6S9aybg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240527085027epcas5p1c930e43efe558b7366a7fa01c04b5cfd~TTFjCU0uv1145211452epcas5p1A;
	Mon, 27 May 2024 08:50:27 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Vnq9F1WhJz4x9Pv; Mon, 27 May
	2024 08:50:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.CE.10047.15944566; Mon, 27 May 2024 17:50:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240527083409epcas5p4a7d41dc2c9cef5726453220cc4576b32~TS3VE1MuG0669406694epcas5p4s;
	Mon, 27 May 2024 08:34:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240527083409epsmtrp2c28fe35245fd00e2811e16303ecb707c~TS3VDQQ8M1374713747epsmtrp2d;
	Mon, 27 May 2024 08:34:09 +0000 (GMT)
X-AuditID: b6c32a49-1d5fa7000000273f-e7-665449515ce8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	83.F8.07412.18544566; Mon, 27 May 2024 17:34:09 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240527083406epsmtip21b840c61991aa6232a9a44af8e15b2ba~TS3Rh_Zq50588805888epsmtip2S;
	Mon, 27 May 2024 08:34:06 +0000 (GMT)
Date: Mon, 27 May 2024 08:27:06 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>, Jonathan
	Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240527082706.chnfnkpm2k4wtcvk@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <144e9e03-d16d-4158-a9eb-177a53b67c6c@acm.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH/d3b3hZc8Qos/iiZYImbhfAoK+XHSzZx2zVuCzK3GWbEC1we
	ofTWFsYky0QUBJy8xDlqRYaM90CFON4QnrOOMcKQAQMkAWJEENRpFMG1XFj873O+53xzzu+c
	/IS4ZYlALIxWxTEaFa2UEOa8m51SR+cD+w5GuHU9J1CNoQdHydkrOKoczyLQXOcjgH5YfI6j
	6fYzAC339eOormcCoMKiyzw00t6AoeaiXAyVV3Zj6NLFUxjqfjVPoNyOOwDNDOkw1DLqhH5K
	Leah5pZbPDTYqCfQlZIZASrtXcVQTtoQhuqnTwJUPfeQh34btUX9K73892ypwb/2U4YiSDXo
	xgVU/8R1HjXYF0/dqEgnqNriE9S92nxANY0kEdTVzPN86typBYJqSJnkU0szozzqYesQQWXW
	VQDq98IuQaBVcIxvFEOHMxp7RhXGhkerIv0k+z8LCQjxULjJnGVeyFNir6JjGT/J3o8DnT+M
	VhqXI7H/mlbGG6VAWquVuO721bDxcYx9FKuN85Mw6nClWq520dKx2nhVpIuKifOWubm5exgL
	j8ZEFVTqBepa4pvTOX/gSaCLnwGEQkjKYcm/kRnAXGhJNgFYk/czzgWPABwwbARPARxuu2oM
	zNYcbb+UrCdaACwe6CC44DGA+szqtSoeuRO2PUgWmHoQpBO8/Upokq3JXfDp3VKeqR4nawlY
	/OufwJSwIo/CeUMO38QiMgBmLGfyON4Kb+VPr7EZ6QPLa28CkxmSnWawr7Ocx420F6avlhEc
	W8H7vXUCjsXw8ULLup4Ay/PKCM58GkDdsA5wCX+YYshamxono2DRy7R181vwgqEa43QLeG55
	GuN0Eawv2GAHWFVTuN7ABt55dpLgtkrBsSo7bitTGOzPbAfZYLvutQfpXmvHsTdMX0zm64x2
	nLSFpatCDqWwptG1EPArgA2j1sZGMloPtUzFJPx/5TA29gZY+zCO++rB+N1Flw6ACUEHgEJc
	Yi2yLjgQYSkKp48nMho2RBOvZLQdwMN4oBxc/GYYa/xxqrgQmdzLTa5QKORe7ypkkm2iuZTL
	4ZZkJB3HxDCMmtFs+DChmTgJQ3v8zzh8V2D/cjjfYkvrtnb82hcDAe7XWKs519T2xNSEE/x/
	Di2y7Hz5EZrVW9j3NLOfBAVZ1Eu/qrLzPry5iW5VXHoSGryHbU2vOjvz5epth4H57Al/tmj1
	7cAXf/vKr4839B7b8cyrWlq/aeRwy9gOn0hdTHWCSPDO5H3rzbNu20NdJ/vZOnHaj7ZblTZJ
	RRZnQ32c9LPx305dlHv1T9B2H6A8caf0ypapg5s8j2cEPYnW9r0x1B09+6lrFrYa7OVcqfrI
	8XtP0Qso7n4wGvD5zg6HLAY/oifTlYpjS7sPrYzk67PNlzQu5wVwzF1aluTuEJJ44R4TIc3d
	9f5C42iWhKeNomWOuEZL/wenGPvJuQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe885nh0Xk5Mae2tIMbKk8LIwe8myKLIDBWVXKsSOetRom7K5
	LpK6blZWcxaYTis10aZleUG2zFxmN2uM8jYVV5Jauqzsii1nTYv69uf5/S9fHgr3fEPMpvbK
	kzmFnJWKST5Rd188x//I2q1xQfanwehmy0McHdWO46iiN4tE9vufAMr5OIajftNJgBxmC45q
	H9oAKiy+RKAukxFDd4rPY0hf8QBD+RePYejBxAiJzjd1ADTQrsNQQ/ciVJRRQqA7DU8I1Hq7
	gERXSgd4qOyRE0PZp9oxZOg/AlCl/QOBHneLkGX8kdsqEdPatp5pKYaMUdfLYyy2KoJpNauY
	6vLTJFNTks68rckDTH2XmmSuai64MeeOvScZ44mXbszoQDfBfLjbTjKa2nLAPCts5m3y2sVf
	HstJ9+7nFIFhe/gJgwYzkTSAH+wyydRAi2cCdwrSwbDxRulvzac86XoAb9mbeVNgFiwdb/5j
	8oJ65xvelGkUQOul46QLELQvbHx39DegKJJeBJ9OUK6zN+0Hv70qI1x+nDaS8Po382SpF70H
	jrRku7m0gF4DMx0aYqq0D4PHqx1/wAz4JK+fcGmcDoGXa/pw1wBOi2CZc3LAnQ6F+po6oAW0
	7r+E7r+E7l+iEODlYBaXpJTFy2IkSRI5dyBAycqUKnl8QEyirBpM/sJCPwOwXXEGNAGMAk0A
	UrjYW+B9OSLOUxDLHkrhFIlRCpWUUzYBEUWIhQJJbn6sJx3PJnP7OC6JU/ylGOU+W40Nb1CF
	JggPjy4VX9ucs5hLU6ft3JoaIlWGW1VjfesEHvd8tp87/B3b9zOzQtPTkB6T3bklVWSNKBKF
	3f5K5ws3RkrMlp0RtpDo6yHzc2KFWWyfb3r2sgyt4EvJRMfVCJMEhPWuA5WV2tWGwGm+moqg
	2okhj+WdW5blvlTkCdsS76akBZ/teJZrfd+m0p6dVzA8PZVvVDfnzLy5sWh9dPHohddWldJn
	rKOnwGIVj78YEj+vHzGF1zfOc9ilWX7uw/0LHP6d4VXO0Gu2Gyu3KRx6QUaddxk74hj0WfUj
	Rs5L81hSXbCCXfH5hGN/W74+MlMyeDpq7o4ZaHfn0jMJcwxiQpnAShbiCiX7C++NMv96AwAA
X-CMS-MailID: 20240527083409epcas5p4a7d41dc2c9cef5726453220cc4576b32
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_2f6c7_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102842epcas5p4949334c2587a15b8adab2c913daa622f
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
	<20240520102033.9361-3-nj.shetty@samsung.com>
	<f54c770c-9a14-44d3-9949-37c4a08777e7@suse.de>
	<66503bc7.630a0220.56c85.8b9dSMTPIN_ADDED_BROKEN@mx.google.com>
	<144e9e03-d16d-4158-a9eb-177a53b67c6c@acm.org>

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_2f6c7_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 24/05/24 06:52AM, Bart Van Assche wrote:
>On 5/23/24 23:54, Nitesh Shetty wrote:
>>Regarding merge, does it looks any better, if we use single request
>>operation such as REQ_OP_COPY and use op_flags(REQ_COPY_DST/REQ_COPY_SRC)
>>to identify dst and src bios ?
>
>I prefer to keep the current approach (REQ_COPY_DST/REQ_COPY_SRC) and to
>use a more appropriate verb than "merge", e.g. "combine".
>
Thanks for the suggesion, will do this in next version.

--Nitesh Shetty

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_2f6c7_
Content-Type: text/plain; charset="utf-8"


------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_2f6c7_--

