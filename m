Return-Path: <linux-fsdevel+bounces-44469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB44A69770
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 19:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A717AFC72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036EB1E5B60;
	Wed, 19 Mar 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Mt8saeKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69A19006F
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407599; cv=none; b=IIqjvlk/+oAPUmEGvJjgmmJCSB8qol7tkP+vGpc70vchjS18O2w2j3oVJro5uauCv3VtZc44gFEjau4hnt1WGC/ZquBfmiBVxPjkyTrKsNGGidtXm8grXbAThZulMmdmoE6sa4HR9ogNV8dEVWygf5bjw2Jv8webhYlMt4h91dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407599; c=relaxed/simple;
	bh=G6iHZgQIholcAW90us3ob4KynXMLkF5xSbRKYF29/C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=A+MsgbDZkT23WNmMUi7jtSjr6+dxWKQUcD+OQPmTuKMPi5Zt4A8RgfPuXQ6rf7L33QllhCN0WnBMjk4GLYc5Amud5kBazHxP0B8cljEdjsgPvDh6jDYGsTGJTTezx9WfQozDLdSGI6QpBn+5JJtOedlKhrToVHzT9Ev6bRghE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Mt8saeKe; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250319180634epoutp0121121891944cada730c40e0bb0d46ed5~uRnmjc-Y72112921129epoutp01B
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 18:06:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250319180634epoutp0121121891944cada730c40e0bb0d46ed5~uRnmjc-Y72112921129epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742407594;
	bh=r+OZ0dZjRdagPeJioXzbnIj1AKfJy9OpWi/BR3HcRpc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Mt8saeKeErG5R1xYmueL6B2f16sgH+Q2vcAjLX/Rllbf+0RbnX+QuV9YPwy3JBzq4
	 1+haMKLx7WCIlnLOvVlwyEt1w/MQ9b7n8/soLReOZ67Ww+XXHddpfUKeJbuy0GwwOa
	 JJDNCXh0qBA09dPuPsag8tMuKCoU2Ngd77ZKvFOg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250319180633epcas5p37fdb720f28677dc579821d1b4f820966~uRnmEC2MM1969719697epcas5p32;
	Wed, 19 Mar 2025 18:06:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4ZHxVH4ZWnz4x9Pv; Wed, 19 Mar
	2025 18:06:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.5D.19956.7A70BD76; Thu, 20 Mar 2025 03:06:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250319180631epcas5p47dbbc86eb8982b6cb230ab33dfd43aa0~uRnj33X9u1744817448epcas5p4N;
	Wed, 19 Mar 2025 18:06:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250319180631epsmtrp176ea9c1c70e9a2b5756a793717c5e402~uRnj3F3l21334513345epsmtrp1G;
	Wed, 19 Mar 2025 18:06:31 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-d5-67db07a78a2b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.EC.18729.6A70BD76; Thu, 20 Mar 2025 03:06:31 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250319180629epsmtip27f2b0f464fbd09d8727b5ef0ca773742~uRniVqTrs2457824578epsmtip25;
	Wed, 19 Mar 2025 18:06:29 +0000 (GMT)
Message-ID: <435cf6be-98e7-4b8b-ae42-e074091de991@samsung.com>
Date: Wed, 19 Mar 2025 23:36:28 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: "hch@infradead.org" <hch@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <Z9kpyh_8RH5irL96@infradead.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmhu5y9tvpBn9uy1qcnrCIyeJv1z0m
	iz8PDS323tK2uPR4BbvFnr0nWSzmL3vKbrHv9V5mi9aen+wWa9Z9ZHfg8ti8Qstj85J6j8k3
	ljN6NJ05yuyxfstVFo8JmzeyenzeJOfRfqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON45
	3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hAJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmt
	UmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xtSbfxkLtvNWrG69z9zA+I2ri5GTQ0LA
	RGLuy6UsXYxcHEICuxklVvw+yASSEBL4xCix9akpROIbo8Tn59dZYTqmrtoO1bGXUaLtxQUm
	COctUEfDZbAqXgE7iZ27zoLZLAKqEk+WLGKGiAtKnJz5hAXEFhWQl7h/awY7iC0sYCPRvesQ
	WxcjB4eIgLbE4sd1IDOZBT4wS7Q92wx2ErOAuMStJ/OZQGrYBDQlLkwuBQlzCuhKbHl+kBGi
	RF5i+9s5zCC9EgI7OCQm3twBdbWLxK+P19ggbGGJV8e3sEPYUhIv+9ug7GyJB48esEDYNRI7
	NvdB9dpLNPy5wQqylxlo7/pd+hC7+CR6fz8BO0dCgFeio00IolpR4t6kp1Cd4hIPZyyBsj0k
	9k94ywgJqjMsEpvfnWSbwKgwCylUZiH5chaSd2YhbF7AyLKKUTK1oDg3PbXYtMA4L7UcHt/J
	+bmbGMHJV8t7B+OjBx/0DjEycTAeYpTgYFYS4XV/cj1diDclsbIqtSg/vqg0J7X4EKMpMHom
	MkuJJucD039eSbyhiaWBiZmZmYmlsZmhkjhv886WdCGB9MSS1OzU1ILUIpg+Jg5OqQYmg+2L
	6pxbDzC/3Sd5Nn6N7EX+a2alxpud3Mp/SdpZ5V59Ne2ql+APiZ93vyc1LrNwj57NyxTwbOvN
	2L1NdSvyP8uZviw6u5BXMeLE9/31Ux5e/fj6zWTLLRpsG1dM+iDovtp6aVjzypCUKzXybKdt
	/+fq1vyWDPooIi5woN/kkUy97enOaxqcKoail740cPn6HXg3cf/85xUzz4Q3fXBivi/H+ePd
	Nu6/CTEvDs9pNNNlnPM36aTMg3mbAzZ8zAmb+H/rLpdGXtFvdpYZm36Ef2bkn85/7/W+A7u5
	PaV8fB7JHZnDfPvIqvymxozsc7Z2UiXzrkZnPVdsCDEUl2dP5/NJtW/+yGl1+GjGxJ6JSizF
	GYmGWsxFxYkATfiznkcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvO5y9tvpBs3HmCxOT1jEZPG36x6T
	xZ+HhhZ7b2lbXHq8gt1iz96TLBbzlz1lt9j3ei+zRWvPT3aLNes+sjtweWxeoeWxeUm9x+Qb
	yxk9ms4cZfZYv+Uqi8eEzRtZPT5vkvNoP9DNFMARxWWTkpqTWZZapG+XwJUx9eZfxoLtvBWr
	W+8zNzB+4+pi5OSQEDCRmLpqO0sXIxeHkMBuRolDv68xQSTEJZqv/WCHsIUlVv57zg5R9JpR
	4uDabSwgCV4BO4mdu86ygtgsAqoST5YsYoaIC0qcnPkErEZUQF7i/q0ZYIOEBWwkuncdYuti
	5OAQEdCWWPy4DmQms8AHZomlW18wQyw4wyKxvG8aG0gDM9AVt57MZwJpYBPQlLgwuRQkzCmg
	K7Hl+UFGiBIzia6tXVC2vMT2t3OYJzAKzUJyxiwkk2YhaZmFpGUBI8sqRsnUguLc9NxiwwLD
	vNRyveLE3OLSvHS95PzcTYzgWNPS3MG4fdUHvUOMTByMhxglOJiVRHjdn1xPF+JNSaysSi3K
	jy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cC0rt3H9EagrTpb1ofsx3cf
	3eiYsTL+ZPXiFyH8Uiny8avzXn/czVTxfYdEi4H/6o/zP3yZvH3qn1/BJ05xpb1ZN1/rYbK9
	cYiB7SONJXXHNtWvvv/s6DvOmp/N3auOKXtv99zatyXs5LaG7afyPs0qz7hbdSE4bcaS+oK2
	yP0HfvOY6fEoLl4z/5qD/vGbjE/frLVavubv8ljT7reGG5z/dJr//jVHcxVP6Czx5uoph47z
	7/lodHbCLLmO3wskt60KSdznwrpRdKqv+t6n75sNaxtlwy6xNTsZnGHKWSzRqq9icTno5fo3
	ee4PRVuMn67z+WY6ufSRh7rPq0ui+7YduLi81ovflbn/ubaph504hxJLcUaioRZzUXEiAOXN
	lTYkAwAA
X-CMS-MailID: 20250319180631epcas5p47dbbc86eb8982b6cb230ab33dfd43aa0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250318080742epcas5p31b31b3024d6f7d9d150c8a7c2db4dffd
References: <20250130091545.66573-1-joshi.k@samsung.com>
	<20250130142857.GB401886@mit.edu>
	<97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
	<b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
	<Z6B2oq_aAaeL9rBE@infradead.org>
	<bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
	<eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
	<cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
	<Z6GivxxFWFZhN7jD@infradead.org>
	<edde46e9-403b-4ddf-bd73-abe95446590c@samsung.com>
	<CGME20250318080742epcas5p31b31b3024d6f7d9d150c8a7c2db4dffd@epcas5p3.samsung.com>
	<Z9kpyh_8RH5irL96@infradead.org>

On 3/18/2025 1:37 PM, hch@infradead.org wrote:
> On Tue, Mar 18, 2025 at 12:36:44PM +0530, Kanchan Joshi wrote:
>> Right, I'm not saying that protection is getting better. Just that any
>> offload is about trusting someone else with the job. We have other
>> instances like atomic-writes, copy, write-zeroes, write-same etc.
> 
> So wahst is the use case for it? 

I tried to describe that in the cover letter of the PoC:
https://lore.kernel.org/linux-btrfs/20250129140207.22718-1-joshi.k@samsung.com/


  What is the "thread" model you are
> trying to protect against (where thread here is borrowed from the
> security world and implies data corruption caught by checksums).

Seems you meant threat model. That was not on my mind for this series, 
but sure, we don't boost integrity with offload.

>>
>>> IFF using PRACT is an acceptable level of protection just running
>>> NODATASUM and disabling PI generation/verification in the block
>>> layer using the current sysfs attributes (or an in-kernel interface
>>> for that) to force the driver to set PRACT will do exactly the same
>>> thing.
>>
>> I had considered but that can't work because:
>>
>> - the sysfs attributes operate at block-device level for all read or all
>> write operations. That's not flexible for policies such "do something
>> for some writes/reads but not for others" which can translate to "do
>> checksum offload for FS data, but keep things as is for FS meta" or
>> other combinations.
> 
> Well, we can easily do the using a per-I/O flag

Right, a per-I/O flag (named REQ_INTEGRITY_OFFLOAD) is what I did in the 
patch:
https://lore.kernel.org/linux-btrfs/20250129140207.22718-2-joshi.k@samsung.com/

