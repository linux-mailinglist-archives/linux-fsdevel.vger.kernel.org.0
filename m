Return-Path: <linux-fsdevel+bounces-10343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365BF84A114
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 18:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AA728237F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 17:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE8E45946;
	Mon,  5 Feb 2024 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGR5gMnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF044C6D;
	Mon,  5 Feb 2024 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154799; cv=none; b=YeWglU116y4drLEu+84nDjohOYNk/8As2X2V/b+1byq8GFZl3dvZRpBjHNVF9qbo7bhH/fIf4Oz1LBxz/93W6U/KvuPKevEJ3MiYWuSq9VfEjv3fa9tUB8wT0cthyXMawIZgSOpVzS3HWtm4w77ZWMrFqi879pCPoSVQ29QBGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154799; c=relaxed/simple;
	bh=7WG3KIulL+1m9nbDyQYKbXy91fsvZwdcrD6JAk5b0TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sB9kGAHcSumj3R6XnIP5UkRHK5/Mzvc5hcRdMcpxNgSlu1JrhNa+gt8qvAFMDlZGpS8ugR+CPxmDD72RPr3UVbAYbn/4hN0p4CiEKglRr2gJDusJDjYteaW0XbJdN6/b/OXUifkmzXpuw+hswd1PWRHhdkrGNEY4/3dhqLPptgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGR5gMnw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e13cfc0b2fso2588421a34.2;
        Mon, 05 Feb 2024 09:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707154796; x=1707759596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIZmrVeKJRsRvZTpUXLQ0YB2Q+u+HKTagSK/hpmNrug=;
        b=GGR5gMnw7f9ZnskkoXufJEsyLkt89bKd9uAVXKZkyPli/B1cBuK5yNtKFuNTww5XY5
         AC2C+WC8//o3VI6IyT5YV5qJ73ch2EPoMSOt5YUusJdrnfzNTVrG5TyKCVC5xnQgZfgP
         o8AgvbrKPhOn7i+R/L7naEvXiCLshsofnq5xYbPRpeBC45WWGi820ndL8DTxEYQ/wSL3
         1joJE0JAGbspW1eA3frUTfucV6LUD8lNOuNiiZGE0zIEASJTGy9QZeszBE6fFzzVGRs2
         oGkVvGtnn4AgqkAE3OURGXjQNgYtrhQ7hvS5L814nCde8luNgP5+kaU5VXz0vikN9ClD
         KItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707154796; x=1707759596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIZmrVeKJRsRvZTpUXLQ0YB2Q+u+HKTagSK/hpmNrug=;
        b=NDyjTKXKpLxZr+3va5ByfQYlXMyrVSnv122kj65sQgcmUPd5Pam6nxw/a/gbd+pE5d
         1ASIa8x7OFaIp8KOShLoXOMVoORjkBZYc/6mIwoxVujN61Tz7V2tXzxVow8PKyztFHsJ
         /2a1kRLSlUhnGOgADrpScLr/asyi3XgChkGKwisZgBlbZE8PT7QmbaMEIL7rVn4Km/Ee
         Y42NxcS/jHWneJwBeGq1HqhwklDjV2x6/N+Z7V7raBNMXlWk6YdIzyOOcOolOsKajY8p
         BBNEm5gvgAnS9/3oUv4vLHqC4hCp/NYuhvOvbDRFkT+zAXLpfccj7OQMair4d92VNIPz
         n+7w==
X-Gm-Message-State: AOJu0YxUNn1mv5Bg/AmD8iBbYQ7TzERIMAewZPGzsZ2IMLjKBRQugI79
	RQa5OFEHO//E/iinfdn5toe4yUmpZ2SDF4m28Ml3foKmViYQWtRQ
X-Google-Smtp-Source: AGHT+IG+amI0yG7Eodpu/pBiuimcljdmmO7j+CrPTZuS877t4XaW79vk+AzKTBGUT/eusQ66eEH6tg==
X-Received: by 2002:a05:6830:ed4:b0:6e1:11b7:9a39 with SMTP id dq20-20020a0568300ed400b006e111b79a39mr342912otb.23.1707154796342;
        Mon, 05 Feb 2024 09:39:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUn7pPZboH59rVCObb4ny5txAGKN68y6BfXZcXgzbXvWml4u0RzEAhiXkQj2xwOGVp9GP/HgofAz0DT1TgRhOlrWjghVuAWayuk2ZWEUjEQ+bCtwV4aNCT3I4bxfT5FlmnItYCJWAj4Fx8Mz1kwx+3xWKqZ8JN8wyI64+40eLF8alOghiRsyHMoYz8LHNhZSqFtlXqKRh9tPIgyxyyfJLOPH4AzWUsuCzZLuYCsAGg7cuMfqpZTj0rUKp1Nv9jBVl2o09posbqGOkTFG0BKYOoEp7tVMDYwnxPQudLg7Qsrrbysjgu9YOaqznQ5KeYXPBGzEBB+ga/+QvUIEt8=
Received: from ?IPV6:2600:6c56:7d00:582f::64e? (2600-6c56-7d00-582f-0000-0000-0000-064e.inf6.spectrum.com. [2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id b12-20020a056830104c00b006e11d75f20dsm54239otp.9.2024.02.05.09.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 09:39:55 -0800 (PST)
Message-ID: <f6fa8310-9aa7-4b1e-9d7d-c9ca67d7dc38@gmail.com>
Date: Mon, 5 Feb 2024 11:39:52 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
 linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
 adrianvovk@gmail.com
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <ZabtYQqakvxJVYjM@dread.disaster.area>
 <20240117-yuppie-unflexibel-dbbb281cb948@brauner>
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20240117-yuppie-unflexibel-dbbb281cb948@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/24 07:19, Christian Brauner wrote:

> And drop_caches is a big hammer simply because there are workloads where
> that isn't feasible. Even on a modern boring laption system one may have
> lots of services. On a large scale system one may have thousands of
> services and they may all uses separate images (And the border between
> isolated services and containers is fuzzy at best.). And here invoking
> drop_caches penalizes every service.
> 
> One may want to drop the contents of _some_ services but not all of
> them. Especially during suspend where one cares about dropping the page
> cache of the home directory that gets suspended - encrypted or
> unencrypted.
> 
> Ignoring the security aspect itself. Just the fact that one froze the
> block device and the owning filesystem one may want to go and drop the
> page cache as well without impacting every other filesystem on the
> system. Which may be thousands. One doesn't want to penalize them all.

I'm not following the problem with dropping all the caches, at least for
the suspend use case rather than quick user switching. Suspend takes all
the services on the machine offline for hundreds of milliseconds
minimum.  If they don't hit the ground running... so what?

drop_caches=3 gets the metadata too, I think, which should protect the
directory structure.

>>
>> FWIW, focussing on purging the page cache omits the fact that
>> having access to the directory structure is a problem - one can
>> still retrieve other user information that is stored in metadata
>> (e.g. xattrs) that isn't part of the page cache. Even the directory
>> structure that is cached in dentries could reveal secrets someone
>> wants to keep hidden (e.g code names for operations/products).
> 
> Yes, of course but that's fine. The most sensitive data and the biggest
> chunks of data will be the contents of files. We don't necessarily need
> to cater to the paranoid with this.
> 

If actual security is not required, maybe look into whatever Android is
doing? As far as I know it has similar use pattern and threat model
(wifi passwords, session cookies, and credit card numbers matter;
exposing high-entropy metadata that probably uniquely identifies files
to anyone who has seen the same data elsewhere is fine).

But then, perhaps what Android does is nothing, relying on locked
bootloaders and device-specific kernels to make booting into a generic
memory dumper sufficiently difficult.

>>
>> So if we want luksSuspend to actually protect user information when
>> it runs, then it effectively needs to bring the filesystem right
>> back to it's "just mounted" state where the only thing in memory is
>> the root directory dentry and inode and nothing else.
> 
> Yes, which we know isn't feasible.
> 
>>
>> And, of course, this is largely impossible to do because anything
>> with an open file on the filesystem will prevent this robust cache
>> purge from occurring....
>>
>> Which brings us back to "best effort" only, and at this point we
>> already have drop-caches....
>>
>> Mind you, I do wonder if drop caches is fast enough for this sort of
>> use case. It is single threaded, and if the filesystem/system has
>> millions of cached inodes it can take minutes to run. Unmount has
>> the same problem - purging large dentry/inode caches takes a *lot*
>> of CPU time and these operations are single threaded.
>>
>> So it may not be practical in the luks context to purge caches e.g.
>> suspending a laptop shouldn't take minutes. However laptops are
>> getting to the hundreds of GB of RAM these days and so they can
>> cache millions of inodes, so cache purge runtime is definitely a
>> consideration here.
> 
> I'm really trying to look for a practical api that doesn't require users
> to drop the caches for every mounted image on the system.
> 
> FYI, I've tried to get some users to reply here so they could speak to
> the fact that they don't expect this to be an optimal solution but none
> of them know how to reply to lore mboxes so I can just relay
> information.
> 

User replying here :-)

One possible alternative would be to use suspend-to-encrypted-swap
instead of suspend-to-RAM. It feels like it was left to rot as memory
sizes kept growing and disk speeds didn't, but that trend has reversed.
NVMe SSDs can write several GB/s if fed properly. And hasn't there been
a recent push for authenticated hibernation images?

That would also protect the application memory, which could be quite
sensitive I think because of session cookies, oauth tokens, and the
like. I assume that a sophisticated adversary with access to a memory
image of my logged-in PC would be able to read my email and impersonate
me for at least a week.

