Return-Path: <linux-fsdevel+bounces-8147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A818304D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 12:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD681F24E35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF8A1DFE9;
	Wed, 17 Jan 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FjhHRk4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F351DFCF
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492705; cv=none; b=e5de8yQwrFEAIqjHavY0kvkNSZkM5VgLpMZbqjEMZkqGT4ahA+BywqHL/pA/eHdZR6lHG37LpkQ1vpYhsSGIDUY1NA7zJRyMH2VkVkucvh1NOKnaX2UFVTbzAHnsZAnCXQe4uVbiDL8bWRnOHzw0lZd5HlXrBsiqwkJblN509Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492705; c=relaxed/simple;
	bh=SdB2TP1URh+2f5CnTPCtsm4BKecp5Qah44NrUZikOFc=;
	h=Received:DKIM-Filter:DKIM-Signature:Received:Received:Received:
	 Received:X-AuditID:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy:X-Brightmail-Tracker:X-Brightmail-Tracker:
	 X-CMS-MailID:X-Msg-Generator:X-RootMTR:X-EPHeader:CMS-TYPE:
	 X-CMS-RootMailID:References; b=ARjbRsa5ovyap6aiZQqmdUC1FmyAfIOezsyw+vqqlD5bGEoybJUjR/qlVUWplO1Jt8AnGK34BABRMHXA9BH8v0011HLx6lGdcV45i9R423V8QQRDcVJW7Wu8okKEhVSkkUKyPlo6oMFkG7T0w4q8bsF7aNjFKPOuDpbO6R6E/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FjhHRk4p; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240117115815euoutp02c0193277b30bdd6724a7fe44480b4d4a~rIJIKy98s2172721727euoutp02E
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 11:58:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240117115815euoutp02c0193277b30bdd6724a7fe44480b4d4a~rIJIKy98s2172721727euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705492695;
	bh=SdB2TP1URh+2f5CnTPCtsm4BKecp5Qah44NrUZikOFc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FjhHRk4pVr1fiHdOiqsCeldOAHepgntE3+Cnd/uegzFM7/EC3A2n+lhe5HnfxvkVs
	 +DtK20XM3Ul8AvWXKCbHSlVqUqVBhXPltEIht9ESr/4UEu+J4Amp5LtImImDNkM34m
	 C5FkBwHhP6sqeKVb8X9zhfAl0ISI5DiNKeTFs1Jo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240117115814eucas1p1c232c3b814b2f470041924f3bb0420fd~rIJHaaPx41464314643eucas1p1I;
	Wed, 17 Jan 2024 11:58:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 61.9E.09552.6D0C7A56; Wed, 17
	Jan 2024 11:58:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240117115814eucas1p28abc60e7ee127f6c587bea07b17a19b1~rIJG_Wgv10373303733eucas1p2O;
	Wed, 17 Jan 2024 11:58:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240117115814eusmtrp11160c27c9b724ad22f73bc9c3a572296~rIJG9uAIB0851908519eusmtrp1H;
	Wed, 17 Jan 2024 11:58:14 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-7c-65a7c0d6794d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.74.09146.6D0C7A56; Wed, 17
	Jan 2024 11:58:14 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240117115813eusmtip2e394ff78bd8b3afa633aac65201743dc~rIJGvRZuJ0477204772eusmtip2X;
	Wed, 17 Jan 2024 11:58:13 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 17 Jan 2024 11:58:13 +0000
Date: Wed, 17 Jan 2024 12:58:12 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
CC: <lsf-pc@lists.linux-foundation.org>, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
	<linux-scsi@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <slava@dubeiko.com>, Kanchan Joshi
	<joshi.k@samsung.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Message-ID: <20240117115812.e46ihed2qt67wdue@ArmHalley.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87rXDixPNdi3RtFi2oefzBZ7b2lb
	7Nl7ksVi/rKn7Bbd13ewWex7vZfZ4tPlhUBiy2wmBw6Py1e8PR49OcjqcXD9GxaPzUvqPSbf
	WM7o8XmTXABbFJdNSmpOZllqkb5dAlfG7KapjAVbNSqmb5vI2MD4QKGLkZNDQsBEYkXnXaYu
	Ri4OIYEVjBIH2lYzQjhfGCXm9pxgg3A+M0rMen+DpYuRA6xl93s3iPhyRonZs7YiFL1+8w3K
	2cIo8fzLEiaQJSwCqhKbNrcyg9hsAvYSl5bdArNFBLQkZu+bAracWeAUk8S/5U/YQVYIC+RI
	tE/xBqnhFbCV6Po1nxnCFpQ4OfMJC4jNLGAl0fmhiRWknFlAWmL5Pw6IsLxE89bZzCBhTqBV
	c4/UQbypJPH4xVtGCLtW4tSWW2BbJQSaOSWmdy1ghUi4SLz7/IEZwhaWeHV8CzuELSNxenIP
	C4SdLXHxTDdUTYnE4vfHmCGBYi3RdyYHIuwocejOTkaIMJ/EjbeCEJfxSUzaNh2qmleio01o
	AqPKLCRvzULy1iyEt2YheWsBI8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwGR0+t/x
	rzsYV7z6qHeIkYmD8RCjBAezkgivv8GyVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC
	6YklqdmpqQWpRTBZJg5OqQYmrtVZx+71GNl/ir7Q4y/pKnWpNUu1SPWMRpZhdvFVndCaf26m
	Txwzgl4/EgndzJG4aumx5mnTvk3akpG1WTfbc8f5nKuT5JUtoybPaVmd0WWd5/vXNylp2mZ7
	1S/rotLqNm6dtijhEjdPaZKKra71lIz+0E8c4Tv33mtIPW/+QTPTcYu05ct60wWJbT7WP7NK
	bxxIMoh4sf712c81gid2tS1afSnr2NGS30Y9vMc18/mcg2/qfL+wrJnt7f519rP2N+zYFSsX
	GNW+9tsxnRCd1S8Uk/Y28v3VipS1M/lUds/i+M110c+4L/PLcrFOYQor7Fv0vV1EJVpvYsqX
	kmzbdTF7RTZyLK5/LJdttk6JpTgj0VCLuag4EQCISNjTtQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7rXDixPNZjwg8Vi2oefzBZ7b2lb
	7Nl7ksVi/rKn7Bbd13ewWex7vZfZ4tPlhUBiy2wmBw6Py1e8PR49OcjqcXD9GxaPzUvqPSbf
	WM7o8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
	kb5dgl7G7KapjAVbNSqmb5vI2MD4QKGLkYNDQsBEYvd7ty5GLg4hgaWMEif2H2PtYuQEistI
	bPxyFcoWlvhzrYsNougjo0Rn1x9GCGcLo8SdRUfBqlgEVCU2bW5lBrHZBOwlLi27BWaLCGhJ
	zN43hQmkgVngFJPEv+VP2EFWCwvkSLRP8Qap4RWwlej6NZ8ZYuhvRolZW38zQyQEJU7OfMIC
	YjMLWEjMnH+eEaSXWUBaYvk/DoiwvETz1tnMIGFOoL1zj9RBHK0k8fjFW0YIu1bi899njBMY
	RWYhGToLydBZCENnIRm6gJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmC8bjv2c/MOxnmv
	PuodYmTiYDzEKMHBrCTC62+wLFWINyWxsiq1KD++qDQntfgQoykwhCYyS4km5wMTRl5JvKGZ
	gamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA9N6nZBpjWH5CYG3ops/zkuT
	VNVuyT+zMfy36IqNjVvLeM/qqL+suaEevOFllpjndU7Nmr+CzYdVeTeEqR17YnH65+w/zkWb
	2Dyv5T63ChKLiffU3Lgxdc7KvRO+87p3vsjxORLn9zuE87Wf9dneo2GrZ+6r6P/9WLkkQ+5X
	hMPT5evnxDe1Z3bPaZ23Qzf9b/F5qykPuCzZHryUuMQ7871iruaSMlnhkIT1B2VDnVsOOWTM
	qtk+f2KG+evWjDcPH90/w7i8/aUUQ6n4g5Sl2zmeZq/Nv7ZVLm/ulsU27iUlj2Ll7ofN2Vla
	13T//KzInvcS3afSkv7Utz34O6cg//BlnWd9uqul5EIDZhokBSmxFGckGmoxFxUnAgAFbueN
	YAMAAA==
X-CMS-MailID: 20240117115814eucas1p28abc60e7ee127f6c587bea07b17a19b1
X-Msg-Generator: CA
X-RootMTR: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
	<20240115084631.152835-1-slava@dubeyko.com>
	<20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
	<86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>

On 16.01.2024 11:39, Viacheslav Dubeyko wrote:
>
>
>> On Jan 15, 2024, at 8:54 PM, Javier González <javier.gonz@samsung.com> wrote:
>>
>> On 15.01.2024 11:46, Viacheslav Dubeyko wrote:
>>> Hi Javier,
>>>
>>> Samsung introduced Flexible Data Placement (FDP) technology
>>> pretty recently. As far as I know, currently, this technology
>>> is available for user-space solutions only. I assume it will be
>>> good to have discussion how kernel-space file systems could
>>> work with SSDs that support FDP technology by employing
>>> FDP benefits.
>>
>> Slava,
>>
>> Thanks for bringing this up.
>>
>> First, this is not a Samsung technology. Several vendors are building
>> FDP and several customers are already deploying first product.
>>
>> We enabled FDP thtough I/O Passthru to avoid unnecesary noise in the
>> block layer until we had a clear idea on use-cases. We have been
>> following and reviewing Bart's write hint series and it covers all the
>> block layer and interface needed to support FDP. Currently, we have
>> patches with small changes to wire the NVMe driver. We plan to submit
>> them after Bart's patches are applied. Now it is a good time since we
>> have LSF and there are also 2 customers using FDP on block and file.
>>
>>>
>>> How soon FDP API will be available for kernel-space file systems?
>>
>> The work is done. We will submit as Bart's patches are applied.
>>
>> Kanchan is doing this work.
>>
>>> How kernel-space file systems can adopt FDP technology?
>>
>> It is based on write hints. There is no FS-specific placement decisions.
>> All the responsibility is in the application.
>>
>> Kanchan: Can you comment a bit more on this?
>>
>>> How FDP technology can improve efficiency and reliability of
>>> kernel-space file system?
>>
>> This is an open problem. Our experience is that making data placement
>> decisions on the FS is tricky (beyond the obvious data / medatadata). If
>> someone has a good use-case for this, I think it is worth exploring.
>> F2FS is a good candidate, but I am not sure FDP is of interest for
>> mobile - here ZUFS seems to be the current dominant technology.
>>
>
>If I understand the FDP technology correctly, I can see the benefits for
>file systems. :)
>
>For example, SSDFS is based on segment concept and it has multiple
>types of segments (superblock, mapping table, segment bitmap, b-tree
>nodes, user data). So, at first, I can use hints to place different segment
>types into different reclaim units.

Yes. This is what I meant with data / metadata. We have looked also into
using 1 RUH for metadata and rest make available to applications. We
decided to go with a simple solution to start with and complete as we
see users.

For SSDFS it makes sense.

>The first point is clear, I can place different
>type of data/metadata (with different “hotness”) into different reclaim units.
>Second point could be not so clear. SSDFS provides the way to define
>the size of erase block. If it’s ZNS SSD, then mkfs tool uses the size of zone
>that storage device exposes to mkfs tool. However, for the case of conventional
>SSD, the size of erase block is defined by user. Technically speaking, this size
>could be smaller or bigger that the real erase block inside of SSD. Also, FTL could
>use a tricky mapping scheme that could combine LBAs in the way making
>FS activity inefficient even by using erase block or segment concept. I can see
>how FDP can help here. First of all, reclaim unit makes guarantee that erase
>blocks or segments on file system side will match to erase blocks (reclaim units)
>on SSD side. Also, I can use various sizes of logical erase blocks but the logical
>erase blocks of the same segment type will be placed into the same reclaim unit.
>It could guarantee the decreasing the write amplification and predictable reclaiming on
>SSD side. The flexibility to use various logical erase block sizes provides
>the better efficiency of file system because various workloads could require
>different logical erase block sizes.

Sounds good. I see you sent a proposal on SSDFS specificaly. It makes
sense to cover this specific uses there.
>
>Technically speaking, any file system can place different types of metadata in
>different reclaim units. However, user data is slightly more tricky case. Potentially,
>file system logic can track “hotness” or frequency of updates of some user data
>and try to direct the different types of user data in different reclaim units.
>But, from another point of view, we have folders in file system namespace.
>If application can place different types of data in different folders, then, technically
>speaking, file system logic can place the content of different folders into different
>reclaim units. But application needs to follow some “discipline” to store different
>types of user data (different “hotness”, for example) in different folders.

Exactly. This is why I think it makes sense to look at specific FSs as
there are real deployments that we can use to argue for changes that
cover a large percentage of use-cases.

