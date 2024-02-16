Return-Path: <linux-fsdevel+bounces-11804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50550857347
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 02:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CF1B249A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9C1FBF7;
	Fri, 16 Feb 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU+pg5dz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F6C8F3;
	Fri, 16 Feb 2024 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046091; cv=none; b=OI/CcrZHLuAb5inrLwSl3SOBBWWQkPfsQZLn5kJWjd5PFoujfy28xUymSYqu1HLt7Q/a4C4vp/kjbuq0Ol7v+GA5CdS5FRg6VNqYCe0r115Dd/b6zjd2yEeAsWA6sZmOycauNKev1HisW7EfdCVbWdRkAKYcSbW2atiHOppoN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046091; c=relaxed/simple;
	bh=0IDaMqxP1WyWFDW5gv3rNdlal7L1KrrbX0rXqzFhPF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAEjiv85piTzYBGyGIDsUQbo/5GY5rYhLXx11ccMMfWJzIsE8vOgvpqKobRZmUsPqen93iNIWIEFI4mHYxJX47qlBSCeQEmABnbAov7SZu4Q4M7pYyzVa7CBYZpL688+6tH+coDqdbrmp398E1CERE8pJ73PnvENY4pgYLDwnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mU+pg5dz; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7872bc61fd2so86563285a.0;
        Thu, 15 Feb 2024 17:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708046088; x=1708650888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAwVF1tQAgkiQs6VC4XwdL3cIIETDwNdapFNON843rI=;
        b=mU+pg5dz5Ib8YeRfiOW1jzmyB2xKd3eaWTnH/Ij6ummF2xeSQZCO6koWWlztGwwrXc
         MesKntQdkqAb4c3QZqLC2hn2X3zNsyLuoGm+JuOK68J7JQVeQ8SyLnpGJK0SfOevnr32
         MjXfn7e9GVyfkP5+Y43JxHy4r8l/zfe55svyKlCwKZKPlAEyTCGts8ZdjB2C9Vpk1vB9
         qnHQE8iOTg056ei5mpw8Y7XDI4Vwj/lEe8IsyYkcjFXZckQqSmqPsVhuTQ5S4yVJihMY
         BYGRL8W8bVII/OThLkZ1Ea/Zl3TgabPoAOzO3Tr/sL0OwXnCnZIqbAWX/jNJCB0DlyUU
         nygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708046088; x=1708650888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAwVF1tQAgkiQs6VC4XwdL3cIIETDwNdapFNON843rI=;
        b=UtWUI3sSiVi1ZC3C5NRpkPGUxI2O1D198NHxYcSirHgsVLtlEJKRkhU+eTOVojGoET
         HV8E2M4vLLC/zBfTUJvzfS3HJ/jpGXgWLzrL0OXPXOYO6VbSwdWcBg1u3jZh+TdTWpqh
         8zO2BYEI1n5qbrqQ2xlPANhT/zP8JchjaVnGskMJFnG1xbUuuaLqC4cfchCwbN7bOtua
         WrQcyqIwBwDqhxA57LQf1fQqi6/bxD9q3/LX3oXWdtEdOQwUD2FsEnuiHXbBYViFhd7i
         H8DDTKbCovj8WP1fp5SVbs40BTu68g4Al7NcIkhSe5whppov3eZU8J7dAwbW4xXIocLS
         TqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfy+b3BqeiSktmiaHMdmVgWmHbEXKR8mlu6QJR27uTfBxcud5nNS3ORzZkXrsJufA4i13WdZvDkXPRZkrI3r1wcBdwfagpgpUY0cIpvQNWjBZeLVckPgWK7N5t9U2122yw2zbCwS6rumd/GBey1iiG2KirW6E5FbjzxRDs9tpB0vP+3rKMVx4=
X-Gm-Message-State: AOJu0YxUyVYhQRZV1nmLpySzKWvw8lf+9RJOQk3++rETUQQLWBDCsxHU
	9v/u1HrlVWgU4kRqAT2OpnQHwJ6pPrCPt6F57fTXOTAsFCHJ6WN4
X-Google-Smtp-Source: AGHT+IFTIPFX/aldqDQnn8FSCTGBtF7yMrYQ3jPPSPF9wbOoD4o9sTw5ozAoIT+lnanhrjUS36X0vA==
X-Received: by 2002:a05:620a:14ad:b0:785:86e7:ed9c with SMTP id x13-20020a05620a14ad00b0078586e7ed9cmr3694198qkj.2.1708046087868;
        Thu, 15 Feb 2024 17:14:47 -0800 (PST)
Received: from [10.56.180.189] (184-057-057-014.res.spectrum.com. [184.57.57.14])
        by smtp.gmail.com with ESMTPSA id bs38-20020a05620a472600b00787288b22desm1083459qkb.79.2024.02.15.17.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 17:14:47 -0800 (PST)
Message-ID: <10c3b162-265b-442b-80e9-8563c0168a8b@gmail.com>
Date: Thu, 15 Feb 2024 20:14:46 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
 <20240117143528.idmyeadhf4yzs5ck@quack3>
 <ZafpsO3XakIekWXx@casper.infradead.org>
 <3107a023-3173-4b3d-9623-71812b1e7eb6@gmail.com>
 <20240215135709.4zmfb7qlerztbq6b@quack3>
 <da1e04bf-7dcc-46c8-af30-d1f92941740d@gmail.com>
 <Zc6biamtwBxICqWO@dread.disaster.area>
From: Adrian Vovk <adrianvovk@gmail.com>
In-Reply-To: <Zc6biamtwBxICqWO@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 18:17, Dave Chinner wrote:
> On Thu, Feb 15, 2024 at 02:46:52PM -0500, Adrian Vovk wrote:
>> On 2/15/24 08:57, Jan Kara wrote:
>>> On Mon 29-01-24 19:13:17, Adrian Vovk wrote:
>>>> Hello! I'm the "GNOME people" who Christian is referring to
>>> Got back to thinking about this after a while...
>>>
>>>> On 1/17/24 09:52, Matthew Wilcox wrote:
>>>>> I feel like we're in an XY trap [1].  What Christian actually wants is
>>>>> to not be able to access the contents of a file while the device it's
>>>>> on is suspended, and we've gone from there to "must drop the page cache".
>>>> What we really want is for the plaintext contents of the files to be gone
>>>> from memory while the dm-crypt device backing them is suspended.
>>>>
>>>> Ultimately my goal is to limit the chance that an attacker with access to a
>>>> user's suspended laptop will be able to access the user's encrypted data. I
>>>> need to achieve this without forcing the user to completely log out/power
>>>> off/etc their system; it must be invisible to the user. The key word here is
>>>> limit; if we can remove _most_ files from memory _most_ of the time Ithink
>>>> luksSuspend would be a lot more useful against cold boot than it is today.
>>> Well, but if your attack vector are cold-boot attacks, then how does
>>> freeing pages from the page cache help you? I mean sure the page allocator
>>> will start tracking those pages with potentially sensitive content as free
>>> but unless you also zero all of them, this doesn't help anything against
>>> cold-boot attacks? The sensitive memory content is still there...
>>>
>>> So you would also have to enable something like zero-on-page-free and
>>> generally the cost of this is going to be pretty big?
>> Yes you are right. Just marking pages as free isn't enough.
>>
>> I'm sure it's reasonable enough to zero out the pages that are getting
>> free'd at our request. But the difficulty here is to try and clear pages
>> that were freed previously for other reasons, unless we're zeroing out all
>> pages on free. So I suppose that leaves me with a couple questions:
>>
>> - As far as I know, the kernel only naturally frees pages from the page
>> cache when they're about to be given to some program for imminent use.
> Memory pressure does cause cache reclaim. Not just page cache, but
> also slab caches and anything else various subsystems can clean up
> to free memory..
>
>> But
>> then in the case the page isn't only free'd, but also zero'd out before it's
>> handed over to the program (because giving a program access to a page filled
>> with potentially sensitive data is a bad idea!). Is this correct?
> Memory exposed to userspace is zeroed before userspace can access
> it.  Kernel memory is not zeroed unless the caller specifically asks
> for it to be zeroed.
>
>> - Are there other situations (aside from drop_caches) where the kernel frees
>> pages from the page cache? Especially without having to zero them anyway? In
> truncate(), fallocate(), direct IO, fadvise(), madvise(), etc. IOWs,
> there are lots of runtime vectors that cause page cache to be freed.
>
>> other words, what situations would turning on some zero-pages-on-free
>> setting actually hurt performance?
> Lots.  page contents are typically cold when the page is freed so
> the zeroing is typically memory latency and bandwidth bound. And
> doing it on free means there isn't any sort of "cache priming"
> performance benefits that we get with zeroing at allocation because
> the page contents are not going to be immediately accessed by the
> kernel or userspace.
>
>> - Does dismounting a filesystem completely zero out the removed fs's pages
>> from the page cache?
> No. It just frees them. No explicit zeroing.
I see. So even dismounting a filesystem and removing the device 
completely doesn't fully protect from a cold-boot attack. Good to know.
>
>> - I remember hearing somewhere of some Linux support for zeroing out all
>> pages in memory if they're free'd from the page cache. However, I spent a
>> while trying to find this (how to turn it on, benchmarks) and I couldn't
>> find it. Do you know if such a thing exists, and if so how to turn it on?
>> I'm curious of the actual performance impact of it.
> You can test it for yourself: the init_on_free kernel command line
> option controls whether the kernel zeroes on free.
>
> Typical distro configuration is:
>
> $ sudo dmesg |grep auto-init
> [    0.018882] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> $
>
> So this kernel zeroes all stack memory, page and heap memory on
> allocation, and does nothing on free...

I see. Thank you for all the information.

So ~5% performance penalty isn't trivial, especially to protect against 
something rare/unlikely like a cold-boot attack, but it would be quite 
nice if we could have some semblance of effort put into making sure the 
data is actually out of memory if we claim that we've done our best to 
harden the system against this scenario. Again, I'm all for best-effort 
solutions here; doing 90% is better than doing 0%...

I've got an alternative idea. How feasible would a second API be that 
just goes through free regions of memory and zeroes them out? This would 
be something we call immediately after we tell the kernel to drop 
everything it can relating to a given filesystem. So the flow would be 
something like follows:

1, user puts systemd-homed into this "locked" mode, homed wipes the 
dm-crypt key out of memory and suspends the block device (this already 
exists)
2. homed asks the kernel to drop whatever caches it can relating to that 
filesystem (the topic of this email thread)
3. homed asks the kernel to zero out all unallocated memory to make sure 
that the data is really gone (the second call I'm proposing now).

Sure this operation can take a while, but for our use-cases it's 
probably fine. We would do this only in response to a direct user action 
(and we can show a nice little progress spinner on screen), or right 
before suspend. A couple of extra seconds of work while entering suspend 
isn't going to be noticed by the user. If the hardware supports 
something faster/better to mitigate cold-boot attacks, like memory 
encryption / SEV, then we'd prefer to use that instead of course, but 
for unsupported hardware I think just zeroing out all the memory that 
has been marked free should do the trick just fine.

By the way, something like cryptsetup might want to use this second API 
too to ensure data is purged from memory after it closes a LUKS volume, 
for instance. So for example if you have an encrypted USB stick you use 
on your computer, the data really gets wiped after you unplug it.

> -Dave.

