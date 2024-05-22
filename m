Return-Path: <linux-fsdevel+bounces-19986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B268D8CBC92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 10:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D508E1C217DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 08:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7997B7E761;
	Wed, 22 May 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t0SIqXIe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174567E11E
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364911; cv=none; b=pqtRfqFkW2Sf7iTfT60EW8fFWWPWweLGzKktIzGBqMI0+r/W35UJBeUFJG5YCXoZ7Kmrc+LkoXHfAROzgc2VUauBmSUCaYSStpH+X810yCBA1gUsd1mmcVlPiC8Dez0HStaqx1Wh9DZq07PcaRmkp6soX2sDy+1YuujLpwoXCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364911; c=relaxed/simple;
	bh=3IU/Y5S5PbEM8sZoU16hx3r94ogEHRDSVQlKe9+7bN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=d5PR+eZZx4RNReiUqpNfiHy1p+FVDdBe/18/CefgszVaUA4IaNc/UZHcnCgRkXPz+m7vYESX49JP68klSFbJtWSs1yJ6OdhOiiGsO+pU6NYVk2KaUk68Ydv3Gw7cMrSNsmPBX4gcM+tN5U3Qj4a8m9WC/8tG8h4vamWtCsJ0/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=t0SIqXIe; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240522080142epoutp0495c361efd138a8256491fae90a10a412~RwMkAlQl60390203902epoutp04W
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 08:01:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240522080142epoutp0495c361efd138a8256491fae90a10a412~RwMkAlQl60390203902epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716364902;
	bh=627E9H6r3w+Yw4w0h70HH2hr5j+VfvV9NWE3+rPSikA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t0SIqXIeAFMAMBIHtT9GgGfIo0nlEaXJEoLablJbu6Nq8eS3Eg2imD/IxF53PLYGu
	 dY1bILQk6nurtGP9Wreazhc4n5vLq6MGaHsrDsthqu+cRBsT1HVh1OY46gbLTm6Imm
	 5q+IhbOtZwmFo1Er9+24orKl8kJcrpMhHsrefvFI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240522080141epcas5p465ef2f70fec9f61ce57611b3f188fc54~RwMjcp4ql1649116491epcas5p4E;
	Wed, 22 May 2024 08:01:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VkkKJ4nNqz4x9Q7; Wed, 22 May
	2024 08:01:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D9.0F.09688.466AD466; Wed, 22 May 2024 17:01:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240522071705epcas5p23ab74d2c71948bc9e5a9b23a65146eeb~RvlnKjcwd2177421774epcas5p2s;
	Wed, 22 May 2024 07:17:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240522071705epsmtrp2f47c73456f842bfd16c1f3953e503f90~RvlnJUYKI0221202212epsmtrp2e;
	Wed, 22 May 2024 07:17:05 +0000 (GMT)
X-AuditID: b6c32a4a-837fa700000025d8-01-664da664e987
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.D5.08390.1FB9D466; Wed, 22 May 2024 16:17:05 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240522071701epsmtip1ac16f31e1dcf01f686c2edd63bf915aa~RvljiHMFw3023730237epsmtip1r;
	Wed, 22 May 2024 07:17:01 +0000 (GMT)
Date: Wed, 22 May 2024 12:40:03 +0530
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
Subject: Re: [PATCH v20 09/12] dm: Add support for copy offload
Message-ID: <20240522071003.fd5oijr3jycvtws4@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0f29bcc1-e708-47cc-a562-0d1e69be6b03@suse.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02TezBcdxTH53fv7nVpdG52mfxCTXQ7ndZ7N2H7k9I0IXoTIjKJVtJM2XI9
	Brvb3UUlpvGoeDQPpC2uYAnRoCSIsVlCKUKopqxiQpsp0ampoINREbWWtv995nzP+8whcZ7W
	yIKMkKoYhVQSJSBMOI0dNrYOITePhQpLqq1QbW8XjpKz1nBUNX6VQDMdCwB9PbeCo8m2NIBW
	+wdw1NA1AZC6tJCDRts0GGouzcHQrapODBXkpmCoc/1PAuW0DwM0pWMx1DJmh0oulnFQc0sP
	Bw3eu06g4ptTRqii+wWGstN1GGqaTAKoZuYZBz0Ys0QDa93cdy3pwSFvurcU0hp23IgemLjD
	oQf7Y+i6ygyCri+7QP9enw9o7WgiQd+4co1LX06ZJWhN6i9cen5qjEM/u68j6CsNlYDuU39v
	5Mc/E+kWzkhCGIU1Iw2WhURIw9wF3icDPQJdxEKRg8gVvSWwlkqiGXeBp4+fg1dE1MZyBNax
	kqiYDZOfRKkUOL3jppDFqBjrcJlS5S5g5CFRcme5o1ISrYyRhjlKGdV+kVC412XDMSgyfCG/
	w0j+yPxT7cwlIhGs78wExiSknGF1YzLIBCYkj9ICeLcvj9ALPGoBwL47XgZhCcDn3z4itiNy
	8hqMDEILgEvaJ1sRTwGs00TrmUO9DkufjnAyAUkSlB18uE7qzWaUAM6ntW/G4lQFAZ+vj3P1
	Ap86ANfGMzA9m1JiOJfRhht4J+zJn+To2Zh6G86UD2zazalXYF75Im5oaNYYtnb7GtgT3mbz
	MQPz4R/d+kb1bAH/mm3ZGiAO3vryG0LfBKQ+B5D9mQUG4QBM7b2K65vGqXCYXkwazFbwq96a
	zZw49TK8vDq5ld8UNhVt82uwula9lX83HF5O2mIa6pLrccOy+jF4Y7IRywJ72P/Nxv5Xjt0s
	sR9mzCVzDbwHptwtwA0ulrDiBWlAG1h7z0kNiEqwm5Ero8MYpYt8r5SJ+/f0wbLoOrD5RbZH
	m8CTX+cc2wFGgnYASVxgZlrXcCSUZxoiiT/HKGSBipgoRtkOXDbOlo1bmAfLNt5QqgoUObsK
	ncVisbPrPrFIsMt0JrUwhEeFSVRMJMPIGcV2HEYaWyRi/PoIIt+mXHz4xHuf+MQfOrUy/5v/
	BBHX5zvL455Mm55d2MXuOy8bLc9lOpLGpjWikUxzt7lrAeyHJbycQ+EL8Lq2SH1uVVsw9VmZ
	5uDHKznc7vaAs4utQX4qYevy/cdvetgfD8z+QmyhflA1PTQ/zV7gt1rVgmo4Kv6o+HznQqnH
	4nRRgu4s70hn+kWn3J/EnNO6Uc13Ow5XnhlZPh3QYf/S36WzniY/XIoqd3lfapZ5EAUN6xK6
	4ptjC5fIdO9F01NsT/IH9Vle8dHHwx4zqZWvwhbW0cdfzQQlpJQcAzW1J5ylHvOhmPcb/B2x
	Pz5UFtv5CkX2rGVBIXXUP+X2kICjDJeIbHGFUvIPNBNwJs4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZdlhJTvfjbN80g73ntSzWnzrGbNE04S+z
	xeq7/WwWrw9/YrSY9uEns8WTA+2MFr/Pnme22HLsHqPFgkVzWSxuHtjJZLFn0SQmi5WrjzJZ
	zJ7ezGRx9P9bNotJh64xWjy9OovJYu8tbYuFbUtYLPbsPclicXnXHDaL+cueslssP/6PyWJi
	x1Umix1PGhkt1r1+z2Jx4pa0xfm/x1kdpD0uX/H2OLVIwmPnrLvsHufvbWTxuHy21GPTqk42
	j81L6j1ebJ7J6LH7ZgObx+K+yawevc3v2Dx2tt5n9fj49BaLx/t9V9k8+rasYvQ4s+AIe4Bw
	FJdNSmpOZllqkb5dAldG48v7zAWPhCo2b+plbWBcy9/FyMkhIWAiMWnGFvYuRi4OIYHdjBK9
	l/6yQSQkJZb9PcIMYQtLrPz3HKroCaPEuZ/PwIpYBFQlFj27wdLFyMHBJqAtcfo/B0hYREBJ
	4mP7IbB6ZoHVbBK7Di1mBEkIC9hL/L3byQRi8wqYSXzoPMAMMfQsk0Tf+99sEAlBiZMzn7CA
	2MxARfM2P2QGWcAsIC2x/B8HRFheonnrbLDjOAWsJV4vPQ9miwrISMxY+pV5AqPQLCSTZiGZ
	NAth0iwkkxYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAhOMFpaOxj3rPqgd4iR
	iYPxEKMEB7OSCO+mLZ5pQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgt
	gskycXBKNTCtbZxb5v6y/0Ow30pN5TR9Pu+qide+PdUPEfeRMo+779X6cOGtSmb753E/hD/9
	3/j/2qRXjit7QiTvzbj9yNE33t/nUky5stWJR65CcUukdjybznZPT6muZ7X4hZ3zFcz4WRVm
	Sp09X3znzrcZC2e/cPrO//i8iKe+QYnSjwMt02Kijzrb2v02DxGef9n+4Nyjjesf6+1RSlj1
	aX61vwfDU8Y3O2Z9L2dlFTmzaXGJ3Kepjcqu82fe2JRhs+Dw5gPz926N2+bFVfq1f03BQ/EF
	RW98+i8fZON7uTN524ZlfpeUX6i5Orovl/+xeILizOI5j141uP5TiTh1Tqtd6jpr7MFDke+i
	tjZcfyAS6yN7Q4mlOCPRUIu5qDgRABcP8X2fAwAA
X-CMS-MailID: 20240522071705epcas5p23ab74d2c71948bc9e5a9b23a65146eeb
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_19f97_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520103004epcas5p4a18f3f6ba0f218d57b0ab4bb84c6ff18
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520103004epcas5p4a18f3f6ba0f218d57b0ab4bb84c6ff18@epcas5p4.samsung.com>
	<20240520102033.9361-10-nj.shetty@samsung.com>
	<41228a01-9d0c-415d-9fef-a3d2600b1dfa@suse.de>
	<20240521140850.m6ppy2sxv457gxgs@green245>
	<0f29bcc1-e708-47cc-a562-0d1e69be6b03@suse.de>

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_19f97_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 22/05/24 08:22AM, Hannes Reinecke wrote:
>On 5/21/24 16:08, Nitesh Shetty wrote:
>>On 21/05/24 09:11AM, Hannes Reinecke wrote:
>>>On 5/20/24 12:20, Nitesh Shetty wrote:
>>>>Before enabling copy for dm target, check if underlying devices and
>>>>dm target support copy. Avoid split happening inside dm target.
>>>>Fail early if the request needs split, currently splitting copy
>>>>request is not supported.
>>>>
>>>>Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>---
>>>>@@ -397,6 +397,9 @@ struct dm_target {
>>>>      * bio_set_dev(). NOTE: ideally a target should _not_ need this.
>>>>      */
>>>>     bool needs_bio_set_dev:1;
>>>>+
>>>>+    /* copy offload is supported */
>>>>+    bool copy_offload_supported:1;
>>>> };
>>>> void *dm_per_bio_data(struct bio *bio, size_t data_size);
>>>
>>>Errm. Not sure this will work. DM tables might be arbitrarily, 
>>>requiring us to _split_ the copy offload request according to the 
>>>underlying component devices. But we explicitly disallowed a split 
>>>in one of the earlier patches.
>>>Or am I wrong?
>>>
>>Yes you are right w.r.to split, we disallow split.
>>But this flag indicates whether we support copy offload in dm-target or
>>not. At present we support copy offload only in dm-linear.
>>For other dm-target, eventhough underlaying device supports copy
>>offload, dm-target based on it wont support copy offload.
>>If the present series get merged, we can test and integrate more
>>targets.
>>
>But dm-linear can be concatenated, too; you can easily use dm-linear
>to tie several devices together.
>Which again would require a copy-offload range to be split.
>Hmm?
>
Sorry, I dont understand the concern here. I see 3 possibilites here.

1. Both src and dst IO lies in same underlying device. This will succeed.
2. src and dst lie in different devices. This will fail.
	a. src or dst needs to be split, if one or both of them
	spans across the underlying block device boundary. In this case we
	fail the IO in dm layer(refer patch 9).
	b. src and dst doesn't split in dm,
	but they wont be merged in request later as they belong to
	different block device.
	Hence the request reaches the driver with single bio and will fail
	in driver(refer patch 7)

Does this address your concern, or do you have something else in mind ?

Thank you,
Nitesh Shetty

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_19f97_
Content-Type: text/plain; charset="utf-8"


------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_19f97_--

