Return-Path: <linux-fsdevel+bounces-36753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3079E8E5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3044E28121A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 09:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7842101AD;
	Mon,  9 Dec 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="gbSjPI0H";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="k2Wny47X";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="byDpR2Cl";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="N2XRBPWQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718B1BC4E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735247; cv=none; b=dzWRCkqGMogN68sIsDGpWV4qWN75OW1vWuSARVLCmsQzPLvcES/s75XxM1l5MLZN5RgGbgUjqBYi6c+yejFejbgFPOxdknD8rF6nAXhIHUbu+6NYlRdPUw2rKcv4lwDPaqIRk8hpsnfahS1fO1fb6d+En7JtepTMPPWwfSFDoc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735247; c=relaxed/simple;
	bh=lir+wOHWV1HJB0u42FlDB30DCKyvJNBjVH6XbJ5flQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJtabjyGS9TnFxPTvSiSWcoo6/X3cxLMgJSbFfvXemOFhbuILsCCfn2JNBH/kMDMQlHbDUA8D+sOq7j0Aqc+0OFp9aHIdLCsVFWaP87eIh0Ztqjpj7QCAIT/i+7MmYKWx8oprcHR/zh6hDHc4YLbYHtoCiN/2+maQAaZfphcINg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=gbSjPI0H; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=k2Wny47X; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=byDpR2Cl; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=N2XRBPWQ; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:ac35:d9bc:6ccc:da57])
	by mail.tnxip.de (Postfix) with ESMTPS id 94F5B208D4;
	Mon,  9 Dec 2024 10:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1733735238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=et2H0IshScIls6+bd21WMvI2ml1kQKTn7SsCIZWOTUw=;
	b=gbSjPI0HYabhLeThw0NXHNfbiX0i6AEbwkhE0JhzVoz0lBLlzKnRNUtEYFFoQPHjprE5UJ
	dRDjRt5CdhMGjpQg1GtRL477gdSYAy8u96iPcu7xRa6HchPJfSvs1OXn+YHKL4LNxal+BK
	90dd/vX2NztLLSSetKqijr0Fz3hfdsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1733735239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=et2H0IshScIls6+bd21WMvI2ml1kQKTn7SsCIZWOTUw=;
	b=k2Wny47XLeCWufsjzeTPM0zpAJtOSig9rDEnpnU+MJsk+BUxBZGNO9HwFTkWs+py+pAEZm
	da9G3WGmoYoffNDA==
Received: from [192.168.1.99] (_gateway [192.168.1.10])
	by gw.tnxip.de (Postfix) with ESMTPSA id 4DE2F68032934;
	Mon, 09 Dec 2024 10:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1733735238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=et2H0IshScIls6+bd21WMvI2ml1kQKTn7SsCIZWOTUw=;
	b=byDpR2ClpWSgvz3A3BmgaYpvZEqc96K95Q9Rry5VZ1zZLJSsAPd9qbMpuMj39nNrQ1vvt9
	jc7f67nvffbcBGLmYInlYs8dujFBdlMfo4iWOWZmX2ppgjLGJgz29zaMcPynv8EgXTB1Xe
	Iafm44HjcRYX4AMaISCYFWADf2tyig4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1733735238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=et2H0IshScIls6+bd21WMvI2ml1kQKTn7SsCIZWOTUw=;
	b=N2XRBPWQGnLBTq65R5yAkbHXOuS8Pa2mN3NZImrgvNAmnNmtvAz/MXpwv2Gicyn+8uU7Bl
	bnRUmz8euTbsnICg==
Message-ID: <77b6c012-8779-4bf8-a034-11b9ee93d1fb@tnxip.de>
Date: Mon, 9 Dec 2024 10:07:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: silent data corruption in fuse in rc1
To: Bernd Schubert <bernd@bsbernd.com>, Jingbo Xu
 <jefflexu@linux.alibaba.com>, Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miklos Szeredi <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 Bernd Schubert <bschubert@ddn.com>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <0d5ac910-97c1-44a8-aee7-56500a710b9e@linux.alibaba.com>
 <804c06e3-4318-4b78-b108-12e0843c2855@tnxip.de>
 <0c7205c3-f2f2-4400-8b1c-3adda48fdeab@bsbernd.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <0c7205c3-f2f2-4400-8b1c-3adda48fdeab@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/12/2024 09:06, Bernd Schubert wrote:
> Hi Malte,
>
> On 12/9/24 07:42, Malte Schröder wrote:
>> On 09/12/2024 02:57, Jingbo Xu wrote:
>>> Hi, Malte
>>>
>>> On 12/9/24 6:32 AM, Malte Schröder wrote:
>>>> On 08/12/2024 21:02, Malte Schröder wrote:
>>>>> On 08/12/2024 02:23, Matthew Wilcox wrote:
>>>>>> On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
>>>>>>> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
>>>>>>> me.     
>>>>>> That's a merge commit ... does the problem reproduce if you run
>>>>>> d1dfb5f52ffc?  And if it does, can you bisect the problem any further
>>>>>> back?  I'd recommend also testing v6.12-rc1; if that's good, bisect
>>>>>> between those two.
>>>>>>
>>>>>> If the problem doesn't show up with d1dfb5f52ffc? then we have a dilly
>>>>>> of an interaction to debug ;-(
>>>>> I spent half a day compiling kernels, but bisect was non-conclusive.
>>>>> There are some steps where the failure mode changes slightly, so this is
>>>>> hard. It ended up at 445d9f05fa149556422f7fdd52dacf487cc8e7be which is
>>>>> the nfsd-6.13 merge ...
>>>>>
>>>>> d1dfb5f52ffc also shows the issue. I will try to narrow down from there.
>>>>>
>>>>> /Malte
>>>>>
>>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
>>>> with 3b97c3652d91 as the culprit.
>>> Would you mind checking if [1] fixes the issue?  It is a fix for
>>> 3b97c3652d91, though the initial report shows 3b97c3652d91 will cause
>>> null-ptr-deref.
>>>
>>>
>>> [1]
>>> https://lore.kernel.org/all/20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com/
>> It does not fix the issue, still behaves the same.
>>
> could you give instructions how to get the issue? Maybe we can script it and I let 
> it run in a loop on one my systems?
>
>
> Thanks,
> Bernd

Sure. To reproduce I set up a VM running Arch and bcachefs as rootfs
(Works out of the box on current Arch). Build -rc kernel using
pacman-pkg build target. Try to install FreeCAD, "flatpak install
flathub org.freecad.FreeCAD". Usually it fails to download some
dependencies. It's a pretty wonky test, but I didn't find a more
specific way to reproduce this.

/Malte


