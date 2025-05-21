Return-Path: <linux-fsdevel+bounces-49577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FF4ABF2CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 13:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5968E1DC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C89B262FE6;
	Wed, 21 May 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="jdJR2QQt";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="wjQiK50R";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="FO6qPxwV";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="ZTq4eakI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5C9262D0B;
	Wed, 21 May 2025 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826861; cv=none; b=EOp/F81QzqYxzNp2r0dEj/COwGPmjzcWT8cAw2JJcYnK6uVOh70jTTfRtzdbH8IoriwV8uhw8PJLibFoRWHWXEUS0ksD7f0e3RwOnvW7379NuF9mfHmZzNVLebRmcezLB+balS3EjxMxZ7xdxJLQPxOtINCDRoInfQ9JtK7hWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826861; c=relaxed/simple;
	bh=NdAfIA8c5UffTeN+xyr/5NUbUFTzVArJotrHPChfM1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NW8S6b/oE7iTeNS8G5h3R/ZmJFDZXqYbWSS/BaKlYDYBQ0yD34vIWjJCvmR4Mwdouw/uwkCfX3WZT5y0zbYNWj/wd28N3AKhC00r5vUpBEnNBTq+X/Vpv1aLstHk+zXWPHsY0jumw/s1VxyIehfcpQYduGBmiDPeLeBo9BjCkr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=jdJR2QQt; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=wjQiK50R; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=FO6qPxwV; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=ZTq4eakI; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:29b1:de58:a155:7218])
	by mail.tnxip.de (Postfix) with ESMTPS id 81985208AD;
	Wed, 21 May 2025 13:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1747826846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VIJGDlxwIbmjibYidSo8M167MOJT1qbhzOyEC04Qio=;
	b=jdJR2QQt7qD8GbRip+NUDsjbfpCO3Rx6in9DJmh6BCVyM48miukPsGpLyPbgCneRAlIY2t
	vaOENVWYMzMkBptMuC6yQb62XD7BsqnJvu6LIMiOs2UBdS4kMCiDvECR4a22b6FNjUqkJZ
	4e7xOV7DsHll8HTxx598jlxEeLHhzsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1747826846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VIJGDlxwIbmjibYidSo8M167MOJT1qbhzOyEC04Qio=;
	b=wjQiK50RpxcLvZ2YIqvim4IIUEW27z2k4chbgXgvGOFLomT1yjiyOhVXTIwPRy03Q70/F7
	9WkO4RiKH5nVJEAA==
Received: from [IPV6:2a04:4540:8c0e:9000:63db:438f:d7a8:d9e6] (unknown [IPv6:2a04:4540:8c0e:9000:63db:438f:d7a8:d9e6])
	by gw.tnxip.de (Postfix) with ESMTPSA id CA12430000000000030AE;
	Wed, 21 May 2025 13:26:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1747826845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VIJGDlxwIbmjibYidSo8M167MOJT1qbhzOyEC04Qio=;
	b=FO6qPxwVWopYZ2OIDEOeDV7fcrDQBn5+ZvlZqI9zxD0NEpFe8pzZAdy7oy6CtZXi7wsngi
	UBQDicDFnpURoUs93I5R2xXEG2tb7zgNlVLafHwfl+Pl5pGMFALm1ArXj+0v7xchGpRuRl
	AVz81WxgDIUvWAvpnaoP6hLd+hOL0I0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1747826845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VIJGDlxwIbmjibYidSo8M167MOJT1qbhzOyEC04Qio=;
	b=ZTq4eakI2zqr9H9DVatLQzVOZWPa9A8qnHr06KwyoLh/4jv1jGEb0aW7XTX0+Bhlh8htsM
	SX0i1dy4vSIdgdCQ==
Message-ID: <25234476-2011-4ade-affe-687d45dcbc3c@tnxip.de>
Date: Wed, 21 May 2025 13:26:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: John Stoffel <john@stoffel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <26668.52908.574606.416955@quad.stoffel.home>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <26668.52908.574606.416955@quad.stoffel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/05/2025 20:49, John Stoffel wrote:
>>>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
>> On Tue, May 20, 2025 at 04:03:27PM +0200, Amir Goldstein wrote:
>>> On Tue, May 20, 2025 at 2:43 PM Kent Overstreet
>>> <kent.overstreet@linux.dev> wrote:
>>>> On Tue, May 20, 2025 at 02:40:07PM +0200, Amir Goldstein wrote:
>>>>> On Tue, May 20, 2025 at 2:25 PM Kent Overstreet
>>>>> <kent.overstreet@linux.dev> wrote:
>>>>>> On Tue, May 20, 2025 at 10:05:14AM +0200, Amir Goldstein wrote:
>>>>>>> On Tue, May 20, 2025 at 7:16 AM Kent Overstreet
>>>>>>> <kent.overstreet@linux.dev> wrote:
>>>>>>>> This series allows overlayfs and casefolding to safely be used on the
>>>>>>>> same filesystem by providing exclusion to ensure that overlayfs never
>>>>>>>> has to deal with casefolded directories.
>>>>>>>>
>>>>>>>> Currently, overlayfs can't be used _at all_ if a filesystem even
>>>>>>>> supports casefolding, which is really nasty for users.
>>>>>>>>
>>>>>>>> Components:
>>>>>>>>
>>>>>>>> - filesystem has to track, for each directory, "does any _descendent_
>>>>>>>>   have casefolding enabled"
>>>>>>>>
>>>>>>>> - new inode flag to pass this to VFS layer
>>>>>>>>
>>>>>>>> - new dcache methods for providing refs for overlayfs, and filesystem
>>>>>>>>   methods for safely clearing this flag
>>>>>>>>
>>>>>>>> - new superblock flag for indicating to overlayfs & dcache "filesystem
>>>>>>>>   supports casefolding, it's safe to use provided new dcache methods are
>>>>>>>>   used"
>>>>>>>>
>>>>>>> I don't think that this is really needed.
>>>>>>>
>>>>>>> Too bad you did not ask before going through the trouble of this implementation.
>>>>>>>
>>>>>>> I think it is enough for overlayfs to know the THIS directory has no
>>>>>>> casefolding.
>>>>>> overlayfs works on trees, not directories...
>>>>> I know how overlayfs works...
>>>>>
>>>>> I've explained why I don't think that sanitizing the entire tree is needed
>>>>> for creating overlayfs over a filesystem that may enable casefolding
>>>>> on some of its directories.
>>>> So, you want to move error checking from mount time, where we _just_
>>>> did a massive API rework so that we can return errors in a way that
>>>> users will actually see them - to open/lookup, where all we have are a
>>>> small fixed set of error codes?
>>> That's one way of putting it.
>>>
>>> Please explain the use case.
>>>
>>> When is overlayfs created over a subtree that is only partially case folded?
>>> Is that really so common that a mount time error justifies all the vfs
>>> infrastructure involved?
>> Amir, you've got two widely used filesystem features that conflict and
>> can't be used on the same filesystem.
> Wait, what?  How many people use casefolding, on a per-directory
> basis?  It's stupid.  Unix/Linux has used case-sensitive filesystems
> for years.  Yes, linux supports other OSes which did do casefolding,
> but yikes... per-directory support is just insane.  It should be
> per-filesystem only at BEST.  
>
>> That's _broken_.
> So?  what about my cross mounting of VMS filesystems with "foo.txt;3"
> version control so I can go back to previous versions?  Why can't I do
> that from my Linux systems that's mounting that VMS image?   
>
> Just because it's done doesn't mean it's not dumb.  
>
>> Users hate partitioning just for separate /boot and /home, having to
>> partition for different applications is horrible. And since overlay
>> fs is used under the hood by docker, and casefolding is used under
>> the hood for running Windows applications, this isn't something
>> people can predict in advance.
> Sure I can, I don't run windows applications to screw casefolding.
> :-)
>
> And I personally LIKE having a seperate /boot and /home, because it
> gives isolation.  The world is not just single user laptops with
> everything all on one disk or spread across a couple of disks using
> LVM or RAID or all of the above.  
>
> I also don't see any updates for the XFS tests, or any other
> filesystem tests, that actually checks and confirms this decidedly
> obtuse and dumb to implement idea.  
>
>
> John
>
Hi there,

would you partition different subdirs of your /home? So there is
.local/share/containers where users put their container-stuff (at least
podman does). Then there is .wine where case-folding-craziness lives.
And then there is the mess that is Steam, which does all kinds of
containery case-foldy stuff. As much as I would like to keep these
things apart, it is not feasible. Not for me as a "power user", and
certainly far out of reach for average Joe user.

Just my 2 ct, greets

/Malte


