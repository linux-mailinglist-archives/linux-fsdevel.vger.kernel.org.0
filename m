Return-Path: <linux-fsdevel+bounces-11751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD1856E00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 20:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7921F219AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 19:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538813A897;
	Thu, 15 Feb 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7qJ/RpN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F313699A;
	Thu, 15 Feb 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026417; cv=none; b=PtTGBN8pNdhjlFewM3dk8cJ22B48m+8jogmRUDC6JDKzUmSBv3NrPhQHODfhW1AU3Jgfj/Lap3P2LaWDnUZtYvc0cuIiNc5it3/vyDLEkxFBL0i41B+lKOUp+UpjQ9OMEDk4M0JcnJnwc/PLUvHyOkW6/lzL+MBQR/haz609AH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026417; c=relaxed/simple;
	bh=SvNJx9ibctbQXoy8zzAv4TWr8cJ8eTvpaV2PlD9kGZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXYx6mLADD7uXbO+cRU2phyU7cjktrnRng0EfLCpHy0VTmEpff/WZos01zIOln8D9KUM7+HFPlZLqvBE0ttq5JyhjrewnSV4Jo9FePXWNkOczWzkwv7Ae0Yz0eKZV7sEmm5NECxVHAgrM9b2nzRMEH3YddnharMTTyHcZFnbUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7qJ/RpN; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68873473ce6so7464436d6.0;
        Thu, 15 Feb 2024 11:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708026415; x=1708631215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0a9EFonqMBn2eHbLHRvN6s4nh6pQCa5EAdO92aYTphs=;
        b=S7qJ/RpNM0gy/KaCy3biAl6HWtM4rqsdcPnB/YH9ruIPIVcYUXUrmLhleYjk3QkJoV
         v9/s7T+LnuvmwZbsmFXf+7K7yO2uvnSZ4eYcA5XTxVdqbzK9ewTKIPVQdg85EkpcqVzl
         aknkR6wPxin6kyR+vc/8stG93q0rYTEayUV5ydy0nS/SltBHUuwXnDwBOYdZXhiUhm7O
         EGHyTnoIYo9ZRqB8lvrNJOboBWIhbuqZJgkRKqMmOheMbax7NlvJMWqpXFMo4hqMk47F
         yJTY0LjfV2i1cwgoWkr2jZVSZyV042djwAzEDIWEz2oLMpVYg29//0TkebfBGSKj36ar
         ZLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026415; x=1708631215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0a9EFonqMBn2eHbLHRvN6s4nh6pQCa5EAdO92aYTphs=;
        b=Up/D3sB2rgK7FKKWo13QtrdusJKRXjrHQx8qvuETFCcykMXlm9MK0n9u4CiHzMnPVF
         9kdPAr7+5nUWNkbUWF+0qyz8aLpzfhxEesEktCj5voAQ3u5qhcLsYgHJBhkpPc6zzfEX
         PwG65k32jvUJv/41fjjIHZe60/yZWluTidSRZajvVjj646Am0JgjK65gkvzguJ9Vv/BI
         Td7b5L+cD+jhoIMW29A1AiZn9bFLOyBUwrsrebefxLLt9XpuB8SHaIl5rZx3l783JmX4
         tgTaEOfX3ZBgX8u3/X9rKaInpfrXuPc+WmgfsCw6HF8C1F5mpivL0cK4Do2J2XbULNmA
         ov5A==
X-Forwarded-Encrypted: i=1; AJvYcCWw/GIEoW9E6ZvIh+Btku6EMFefuIclZgk9wOslmteXC+CzqPr37wZ7K4M5IrmZzuyIo1yJLHXQVgQm60/TShMSAyBpb6zdPjl4hom0nqNEMa9u5GKVtcstbcUOyDuQ1RNgkVWsvu/vftMGwIH2xsm3vkipZ092NyPR2Mn1mwo+ZtMcnxfTdGA=
X-Gm-Message-State: AOJu0Yz0xDN3SprO38la5PNsdNAthoYl9JRNfC2MaLiXSCJgHj8BS113
	gjTBUJHNrC41jseBPC2ICqbkUSthykt+sflPKNxg3XtiSQdnMyehIuDt3VVNWHD6Rw==
X-Google-Smtp-Source: AGHT+IFUlCyEzpVqAiRhaKG/YKslsjBvW/1ZGIwwpMuMpyt9VGtgXczGDx9ymu2IxKEw8fJvFKJiLQ==
X-Received: by 2002:ad4:5c8f:0:b0:686:a185:dc11 with SMTP id o15-20020ad45c8f000000b00686a185dc11mr3520139qvh.55.1708026414655;
        Thu, 15 Feb 2024 11:46:54 -0800 (PST)
Received: from [10.56.180.189] (184-057-057-014.res.spectrum.com. [184.57.57.14])
        by smtp.gmail.com with ESMTPSA id og11-20020a056214428b00b0068f2b1d9415sm413691qvb.23.2024.02.15.11.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:46:54 -0800 (PST)
Message-ID: <da1e04bf-7dcc-46c8-af30-d1f92941740d@gmail.com>
Date: Thu, 15 Feb 2024 14:46:52 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
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
Content-Language: en-US
From: Adrian Vovk <adrianvovk@gmail.com>
In-Reply-To: <20240215135709.4zmfb7qlerztbq6b@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 08:57, Jan Kara wrote:
> On Mon 29-01-24 19:13:17, Adrian Vovk wrote:
>> Hello! I'm the "GNOME people" who Christian is referring to
> Got back to thinking about this after a while...
>
>> On 1/17/24 09:52, Matthew Wilcox wrote:
>>> I feel like we're in an XY trap [1].  What Christian actually wants is
>>> to not be able to access the contents of a file while the device it's
>>> on is suspended, and we've gone from there to "must drop the page cache".
>> What we really want is for the plaintext contents of the files to be gone
>> from memory while the dm-crypt device backing them is suspended.
>>
>> Ultimately my goal is to limit the chance that an attacker with access to a
>> user's suspended laptop will be able to access the user's encrypted data. I
>> need to achieve this without forcing the user to completely log out/power
>> off/etc their system; it must be invisible to the user. The key word here is
>> limit; if we can remove _most_ files from memory _most_ of the time Ithink
>> luksSuspend would be a lot more useful against cold boot than it is today.
> Well, but if your attack vector are cold-boot attacks, then how does
> freeing pages from the page cache help you? I mean sure the page allocator
> will start tracking those pages with potentially sensitive content as free
> but unless you also zero all of them, this doesn't help anything against
> cold-boot attacks? The sensitive memory content is still there...
>
> So you would also have to enable something like zero-on-page-free and
> generally the cost of this is going to be pretty big?

Yes you are right. Just marking pages as free isn't enough.

I'm sure it's reasonable enough to zero out the pages that are getting 
free'd at our request. But the difficulty here is to try and clear pages 
that were freed previously for other reasons, unless we're zeroing out 
all pages on free. So I suppose that leaves me with a couple questions:

- As far as I know, the kernel only naturally frees pages from the page 
cache when they're about to be given to some program for imminent use. 
But then in the case the page isn't only free'd, but also zero'd out 
before it's handed over to the program (because giving a program access 
to a page filled with potentially sensitive data is a bad idea!). Is 
this correct?

- Are there other situations (aside from drop_caches) where the kernel 
frees pages from the page cache? Especially without having to zero them 
anyway? In other words, what situations would turning on some 
zero-pages-on-free setting actually hurt performance?

- Does dismounting a filesystem completely zero out the removed fs's 
pages from the page cache?

- I remember hearing somewhere of some Linux support for zeroing out all 
pages in memory if they're free'd from the page cache. However, I spent 
a while trying to find this (how to turn it on, benchmarks) and I 
couldn't find it. Do you know if such a thing exists, and if so how to 
turn it on? I'm curious of the actual performance impact of it.

>> I understand that perfectly wiping all the files out of memory without
>> completely unmounting the filesystem isn't feasible, and that's probably OK
>> for our use-case. As long as most files can be removed from memory most of
>> the time, anyway...
> OK, understood. I guess in that case something like BLKFLSBUF ioctl on
> steroids (to also evict filesystem caches, not only the block device) could
> be useful for you.
>
> 								Honza

Best,

Adrian


