Return-Path: <linux-fsdevel+bounces-31859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1167199C397
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 10:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AFA282802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E2714F126;
	Mon, 14 Oct 2024 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iinet.net.au header.i=@iinet.net.au header.b="G9RFdKKJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omr000.pc5.atmailcloud.com (omr000.pc5.atmailcloud.com [103.150.252.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBE1474A5;
	Mon, 14 Oct 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.150.252.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895243; cv=none; b=FTius6LNppU/O1f6EfzNX/RLxzrZbLz6J8rb8sAVLtdia1F/JATJ02y6xH+OBypL5btppo79L10HrMwEuimXhXpAC/yz8We5xHpZlsp/BKkjiSmdUZGnQkwAHMvFinrS6GmBy8POWf9LiPdZ+6YNTS6ERernHrzC09OoLoGnvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895243; c=relaxed/simple;
	bh=mjvTs/Rg1BxKP6CQdxfVJpnbZeiHlJIKmkqRkZJ2euc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BVC2DCt1TrSLz0mpnlUHz390dZtYfXxBuFVqvivjvyjo6S1CzgOir1FI3hgmDNwYWdJpYs0MLsIFsX3tvhStdvU7RZFlQEnUEfU9mwO0Jh2ZK+aCDd7dBDXlRkBEGltniCtvp/qR1gdrad5dBnDqcq73F4zuVQa5BSnv+wky0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iinet.net.au; spf=pass smtp.mailfrom=iinet.net.au; dkim=pass (2048-bit key) header.d=iinet.net.au header.i=@iinet.net.au header.b=G9RFdKKJ; arc=none smtp.client-ip=103.150.252.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iinet.net.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iinet.net.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iinet.net.au; s=202309; h=Content-Type:From:To:Subject:MIME-Version:Date:
	Message-ID; bh=7kzM5FpMbnXs7iTj1M/pCDaWsEiikl3NuYf4Y5aJL1c=; b=G9RFdKKJBut41n
	DI0v3wYsLbgsCfLFqnKhfyy77k3s2cDuVMr96V24CecinDP1gydk08FbGeyG524IR3zo9CMhpbD7V
	1jUX+KMW01QZXO+5K0pGzcTP3Xnu5gUvNqczH5l7vDJuUgaTeFvPpsNzIzZK+4jkjytl52f6a2bHO
	csi4XdZZakk2xcpO59aZy8WtDGTpUCSkK46myvRHS67VMqpXMP/usSuMt1BtdFn2u8N09tukp28qf
	Tqlol4EPEZnrZZAlemSwlJmFa1tA2hBLviIyBy2Z0hsBae83H7VS1FjmpS5F8Q8qcYyDAXCvRm8zm
	r2vx+m1iWweT/6iw0aZg==;
Received: from CMR-TMC.i-0e96db1614e72c689
	 by OMR.i-0dfa7ead5d297886b with esmtps
	(envelope-from <burn.alting@iinet.net.au>)
	id 1t0Gd4-000000001Yu-2Q2o;
	Mon, 14 Oct 2024 08:40:38 +0000
Received: from [121.45.199.178] (helo=[192.168.2.220])
	 by CMR-TMC.i-0e96db1614e72c689 with esmtpsa
	(envelope-from <burn.alting@iinet.net.au>)
	id 1t0Gd4-000000004Lp-11ny;
	Mon, 14 Oct 2024 08:40:38 +0000
Message-ID: <0e4e7a6d-09e0-480d-baa9-a2e7522a088a@iinet.net.au>
Date: Mon, 14 Oct 2024 19:40:37 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: audit@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org> <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org> <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org> <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org> <20241011.uu1Bieghaiwu@digikod.net>
 <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
Content-Language: en-US
From: Burn Alting <burn.alting@iinet.net.au>
In-Reply-To: <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Atmail-Id: burn.alting@iinet.net.au
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=JqH3rt4C c=1 sm=1 tr=0 ts=670cd906 a=ad8utJckiWseeaTPZMijYg==:117 a=ad8utJckiWseeaTPZMijYg==:17 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=x7bEGLp0ZPQA:10 a=q7kHw0SAeLOdz_FGtMwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Cm-Envelope: MS4xfEbwnGFsAduAAbxbbDekDJQvVXVN1BYHo7Jibe90oIHgx/m/xssYzHZkVoG0wp8kegKOzYQOSXZouYTYJBlqJHfl7Q+A7/H/lgwpEUlKCepe1EVRi0Rs jfOwUUcBIC0Deny30eF0GCZrgP/7Ob4GgNjwC/9glHlWQVjOuZiLfI0zZgntb/eDzsiWwo5tL4e99Q==
X-atmailcloud-route: unknown



On 13/10/24 21:17, Jeff Layton wrote:
> On Fri, 2024-10-11 at 17:30 +0200, Mickaël Salaün wrote:
>> On Fri, Oct 11, 2024 at 07:39:33AM -0700, Christoph Hellwig wrote:
>>> On Fri, Oct 11, 2024 at 03:52:42PM +0200, Mickaël Salaün wrote:
>>>>>> Yes, but how do you call getattr() without a path?
>>>>>
>>>>> You don't because inode numbers are irrelevant without the path.
>>>>
>>>> They are for kernel messages and audit logs.  Please take a look at the
>>>> use cases with the other patches.
>>>
>>> It still is useless.  E.g. btrfs has duplicate inode numbers due to
>>> subvolumes.
>>
>> At least it reflects what users see.
>>
>>>
>>> If you want a better pretty but not useful value just work on making
>>> i_ino 64-bits wide, which is long overdue.
>>
>> That would require too much work for me, and this would be a pain to
>> backport to all stable kernels.
>>
> 
> Would it though? Adding this new inode operation seems sub-optimal.
> 
> Inode numbers are static information. Once an inode number is set on an
> inode it basically never changes.  This patchset will turn all of those
> direct inode->i_ino fetches into a pointer chase for the new inode
> operation, which will then almost always just result in a direct fetch.
> 
> A better solution here would be to make inode->i_ino a u64, and just
> fix up all of the places that touch it to expect that. Then, just
> ensure that all of the filesystems set it properly when instantiating
> new inodes. Even on 32-bit arch, you likely wouldn't need a seqcount
> loop or anything to fetch this since the chance of a torn read there is
> basically zero.
> 
> If there are places where we need to convert i_ino down to 32-bits,
> then we can just use some scheme like nfs_fattr_to_ino_t(), or just
> cast i_ino to a u32.
> 
> Yes, it'd be a larger patchset, but that seems like it would be a
> better solution.
As someone who lives in the analytical user space of Linux audit,  I 
take it that for large (say >200TB) file systems, the inode value 
reported in audit PATH records is no longer forensically defensible and 
it's use as a correlation item is of questionable value now?

