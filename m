Return-Path: <linux-fsdevel+bounces-29280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A326C97797D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 09:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA4F1F2659E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 07:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577841BC084;
	Fri, 13 Sep 2024 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oaUy9sBV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF21BB6B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212182; cv=none; b=mgcR0UHwDVMjjuh+/HQaIeIQeX+YSEPIkigCcG+FgfmZB90ajjP4VkUOHhFbWL+vgww5LGfkHxW4HevIq6v6zY7jqwC01yScVAnPzYegvRigD2j1Nk7/LhrWkZKXLye5r1B12Hy2ZsrZlt4Jprhp+7nmeVmFoXZxWVLK7kQe4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212182; c=relaxed/simple;
	bh=8HUGCCO38bSkRqAnXr3ntjDxYfQUEAlm/OzRrGCLns0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Uqbz1YqX+Iujx0xFUD9E+hOz3mMjOT1DdusYe2sfDKXe2N/i3CpzKdX/SfYvBD8go3xq2fPsNuBFn5dU7GLKY6vhqkh1s09HlV4gu/psgdCYvRGd374RksnUka8KwsS8c20tAHliBC71LnO7Ate0nkaiEy94AEr03vIf50jN6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oaUy9sBV; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240913072258epoutp01c08bfd156e8b4971ec6d6315ddc50ca1~0vNStp8cO0713807138epoutp01V
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 07:22:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240913072258epoutp01c08bfd156e8b4971ec6d6315ddc50ca1~0vNStp8cO0713807138epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726212178;
	bh=DfqqqIPcXuC33v4cLL0ODxpxiUkP1Rjz2JlXnKLXgh8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=oaUy9sBVP9dFId5l+KtVJaraEGn+CBmsqZSLSKhaCVPPx5yvvQX4XJSw7hVNzvwDC
	 QgfRJ3PeRCHyi04mV0JpO9sUjDd5vXQg1ZuD1R28FC/hozRbnb2GHfRswdL84+Q2pC
	 dZqepg0ezTPCzCQO6/6U6HD7356SIMccjvdIdBAY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240913072258epcas5p397659184e19ff6cb4130a0130e08b500~0vNSDHDvv1522615226epcas5p3i;
	Fri, 13 Sep 2024 07:22:58 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4X4m401fQQz4x9Pt; Fri, 13 Sep
	2024 07:22:56 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.2C.09640.F48E3E66; Fri, 13 Sep 2024 16:22:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240913072255epcas5p4ffa874219e563fd562003ce2c7ff0d3b~0vNPmRHie1203712037epcas5p4L;
	Fri, 13 Sep 2024 07:22:55 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240913072255epsmtrp23d9b77e732158615fd765343f8ffae55~0vNPlSX6H2729727297epsmtrp2B;
	Fri, 13 Sep 2024 07:22:55 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-ac-66e3e84f6c4b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A5.F5.19367.F48E3E66; Fri, 13 Sep 2024 16:22:55 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240913072252epsmtip2556522eb0be364036be534a4f076b144~0vNMvbd2G1221912219epsmtip2y;
	Fri, 13 Sep 2024 07:22:52 +0000 (GMT)
Message-ID: <ea71bdfd-f0f8-eb61-255d-68ea1e4421f1@samsung.com>
Date: Fri, 13 Sep 2024 12:52:51 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/5] fs, block: refactor enum rw_hint
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <fe2ae1b7-7c77-49e1-ace0-50e937f2c32c@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVDTdRzH+z1s+2HN+4US36hwruQEj4fVGF+SBzu9/JloXFJeHrF+sB8D
	B9tuD0KIMdJKtCaRqSyeMo5iEJxAAQLx7FrSAeKIB5koD1EICrs6EaI2RsR/r8/7Ps+f+xCY
	q47jQSTKNYxKTifx2RvwH9q9vX0jp8biA3K+wmDZyDk2nG6fR+CFBwsY/GfkNxQOttSjsLSs
	E4VfXjyJwvFKAwavnCPg2C0bBy6UGDkwp60fgU1DO+CNy3thY5MZh4UlExx49tc6NvzGtIzC
	iun7OOz+28SC3YY8zi43qu/mfqrbegWnLuT8zKb6ftFSVcYsNlVdnEE1FNlQqmFQx6bmJoZw
	Sl9jRKiuog4OZavypKrGZ9BI7hFZSAJDSxgVj5HHKSSJcmkof/8h8W5xoChA4CsIhkF8npxO
	ZkL5eyIifV9NTLKPy+cdo5O0dimSVqv5/mEhKoVWw/ASFGpNKJ9RSpKUQqWfmk5Wa+VSPzmj
	eVkQEPBioN3xXVlCZcEirizFUnXGDlyHmNEzCEEAUgha5u24gXAlGxDwSWc122nMI+CL+UZ0
	zfiu+PxaxP0BX6dej4DMPiPmNGYQMPZ9GecM4kJwyTDw541MzME4uQ30Wkswp/4kMOeO4w52
	I2PBI0se4uBNZAiob51d0THSHQyNF64U20xSYOjeQUd+jPwdAxcHpzgOnU16g57PtQ53F3In
	eLh8m+UM3QJqZ/JW+gHk1y7g0nDratN7wMlbfg4fQG4Cf5hqOE72ALbZJraTZWD07iju5HRQ
	V61nOTkc6JYGWI40mL1s5VV/Z6mN4NPF8dXsXHD6I1en91ZgzZlYjXQHdy4VrzIFes+bVnfb
	jILZ3stINsIzrFuKYd3whnXTGP6vXITgRuRpRqlOljLqQKVAzqSsXTtOkVyFrLyCz746ZGT0
	gV8bghJIGwIIjL+Zm8O+G+/KldDvpTEqhVilTWLUbUig/TqfYR5ucQr7L8k1YoEwOEAoEomE
	wS+JBHx37vSH+RJXUkprGBnDKBnVf3Eo4eKhQ2P+ahTNtaiieqLSk2NMjx8J/EkzkGcJr42e
	DI+OuxZVKpo1gyVz9PLDbT+Gpd5pfS1GX3P9xOnXT2x8x52FTQ4svLW9YK4gKP9Q5shxH4sy
	W6acTXuEHx47WpGyNyLCs7OVc6D55vNzp2K7dr6puP1GBjx7veDUrqv++/KtvWJLrde30vDh
	HeVia7rs404N1V/G2pKhbxnKLjfPpxUe3D53tC3og9yWw1621P7h56b0tJek+AW58Nn0V2zN
	FFHaEysKeltkgegTErfGXE6dbBBuja1KbMfwAc9yWbYp8dgzMzz92IGsx64pJqqZrnvyRSJ+
	8n3tU1lWaYfFerxiSZbCx9UJtMAHU6npfwE7LGK5kwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01ReUxScRzv997zvSdFvlDzl11GtZWVndpvZa7VqjdpdqyV3ZE8tIXKIJvd
	NmsVtTTaTJ+tzJIGNim1zJQO1JmU2SUViXZg2Ki0zM0OqYC1+d9nn+/n2r40LrIRofS2lB2c
	KkWqEJMC4kaNePSUZR3v5dNedwagYnsWiVw13wDK6fqBoz92J4Ze3a3EkL64DkP5ZzIx5DDy
	OLqWRaP3Ld0U+qEzUEhrtgJksk1CTwuXoGpTA4HO69opdPzFTRJdrndjqMTVSaCmvno/1MSf
	peYHs8+eS9im1msEm6O1kOyzxjS21HCMZMsuHWCrCroxtupVBsl+bbcR7MlyA2AfFtRSbHfp
	KLbU8RlbLlwniJZxim07OdXUmC2CJOO5X4RSj6dnGGqJDNCAaQBNQ2YW7Hw5RQMEtIipAFBv
	+Qk0wP8fHwIzrb2UDwdCvdtJ+UQuAE2NdZjnIGRiYM/Tg7gHE8x4+KRVh/v4IbAhz0F4cDCz
	FVa3HfTqA5loWHnvi5fH/xXYHOe9I4IYFto+xXnyceYjDvPcPO4ru4PB4o4jXhHJTISPT6d5
	vP7MXNjrbvPz5URBzXUN8OHRsOLzWTwbiPh+M/h+dXw/C9/PUgAIAwjmlOrkxOQE5fQItTRZ
	nZaSGJGQmlwKvO8PX3kT6Ix9EWaA0cAMII2Lg4Ra8p1cJJRJd+3mVKmbVWkKTm0Gw2lCHCIc
	qzgmEzGJ0h3cdo5Tcqr/V4z2D83AYnUj67c2tw6VPs9ds31pdqBrTmaXVrVl6aGeqLC4ztlF
	k39Zot4E7S0olI0Y5GweLGk9vLOyh4isuK341DdgdebCB4fipFeenCsJNxN8e85DAT/o7SIR
	sbYhZEKoY5+1pSz+5b3uo+4LRfnxF76Pepve1NGclDsxzCga4S+xXx7YFuk3Yea46LvfVjgW
	SuJjQIA29mdVpWv4kLLC8nVjalZoTTNUq5vl9quLx8nFa7J/0wtkWKzphIWs+WA9RdmH7XnU
	ksAOlSt0DHu4x5q3iS4zVos2dK0qcpbfH7AxVXnS2Z5+cU/S/sR5kYso6/qS3kt7iyR+YyKC
	0LtbdnljiW2jmFAnSaeH4yq19C9zlmoQbQMAAA==
X-CMS-MailID: 20240913072255epcas5p4ffa874219e563fd562003ce2c7ff0d3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51@epcas5p3.samsung.com>
	<20240910150200.6589-2-joshi.k@samsung.com> <20240912125347.GA28068@lst.de>
	<0baddb91-b292-db90-8110-37fa5a19af01@samsung.com>
	<fe2ae1b7-7c77-49e1-ace0-50e937f2c32c@acm.org>

On 9/13/2024 2:00 AM, Bart Van Assche wrote:
> On 9/12/24 8:50 AM, Kanchan Joshi wrote:
>> Wherever hint is being used in generic way, u8 data type is being used.
> 
> Has it been considered to introduce a new union and to use that as the
> type of 'hint' instead of 'u8'?
> 

Is it same as your other question in patch 3?. I commented there.
If not, can you expand on what you prefer (maybe with a code fragment).

