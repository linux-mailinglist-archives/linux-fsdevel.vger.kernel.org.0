Return-Path: <linux-fsdevel+bounces-9473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4528284175F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 01:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D966CB22F0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 00:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B93A1EB37;
	Tue, 30 Jan 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGd7BBnP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05C33D68;
	Tue, 30 Jan 2024 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573602; cv=none; b=t76giQfeESYxQlsNDqkqGhzV/jGSd1DxKcLXnZOYJDVkzLmAvSsC08A2ORPYPpKsKqoa7Xou2eC2C+ZeGqP9BfpA0qPSEKVT9Y3XqNeNl7JxaU0MDgncrtUfSHQVNYwzN8UnurXmY0krB2SrJs9qLYWUbAuNfDuO/TCpqGfLpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573602; c=relaxed/simple;
	bh=/v4k9c7z0s5BJeRduspOMCH/i8kwYiHyfA6vcz9EGVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pndIBV0KCN3RP5NpDPx1BBf9SX1o5W13FpOndvQZBUB3xkQdzBUEDcF7fhSjtltcCdfW7Otf5WZgGKifA+NEjaQnUm83tSQ5fAy0q2M7k47crAysOdfEuz7PDfYbewpGBePvFjnxO1JrlZtkNrr0nDfjZYHmvgt6WO5o94yPiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGd7BBnP; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68c4673eff5so14836616d6.1;
        Mon, 29 Jan 2024 16:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706573600; x=1707178400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cTjgRUa/OuT1Zow9lfJR4BHRyRrTMnOxetbaBI0D7k=;
        b=gGd7BBnP1ovzMLeIFOVjWahSnrScTQ3qZ/FPzE+dlc3NiQDrhgYOL0xGmkWS1h7YZP
         uzRRvO7+7IgtDHp6vAtOusgdPY453ulPmNCML1s0vYp3imx2y/M0+KGUCbTUyrRIMOwX
         2i71rYiBVwInmWySueJTUhRRSs75udSh9/uR98+ukgWHeKO5LFu+bKkA71tSYTBuokd1
         GrMpUE6VSiOCEk+Wxfa32dtSYEvQs9LqIBuNv8Lcwf6tDzKiRH7SJfHEv2aTlYybsT5k
         ezG/+8HK0KFlpuctDff1FvVdtbKUS8kItZ4CM/RvIZ+RdOwRibryoyM+pXhU9WFeUcMP
         LL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706573600; x=1707178400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cTjgRUa/OuT1Zow9lfJR4BHRyRrTMnOxetbaBI0D7k=;
        b=ddaU31QVA38ojGBBMlGxlj/O9Z1ts4wfzoxK3F4T05F333CJjXLeGkdpvMQQNylpKk
         5GXl6TlZB+np3NHsRqVVewGKeQBcXb9qGKLiJex3TGo2E71AmAZSklasNCuEvz5w95Fe
         lRRrfyX9jpeEx5mVyIR4E5ac8a79M0HSLdntvqjYuSLN7n4sXPbeDeClZFEI7/USQ/dd
         gzLDTXt7l/2MtlUdo005teC9BZr2W3TZRYkPlAw5HsvZh+Z64d8Zcve3l3od8SNe4P4p
         9n18uA8gP47bOgV9UL9BZtnQDmnIwGrGH3+Ah7bn7rH5aigR6SwEAPKr0ISl8eJheSIR
         nBcg==
X-Gm-Message-State: AOJu0YwjM01aH4KmSbEZ3aB8GjGMt9NBMIrTeOJOo9CJukSZWoURK+8I
	JoPm2ZF4MWIhhcHUAEvbIbrh56LoZndzdN7oBYJINCmEvAQEtql6oHpRYiPreTTTIQ==
X-Google-Smtp-Source: AGHT+IHH6hHDKm4nySIae5BxK+drQrnCA8T5/9zdN7Htn1zRhndn0EHzWb/IXqtzANbIwtv738w6VQ==
X-Received: by 2002:a05:6214:2a8b:b0:68c:5e87:7032 with SMTP id jr11-20020a0562142a8b00b0068c5e877032mr387571qvb.40.1706573599739;
        Mon, 29 Jan 2024 16:13:19 -0800 (PST)
Received: from [10.56.180.189] (184-057-057-014.res.spectrum.com. [184.57.57.14])
        by smtp.gmail.com with ESMTPSA id pf1-20020a056214498100b0067f53e25d1esm3931087qvb.14.2024.01.29.16.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 16:13:19 -0800 (PST)
Message-ID: <3107a023-3173-4b3d-9623-71812b1e7eb6@gmail.com>
Date: Mon, 29 Jan 2024 19:13:17 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
 <20240117143528.idmyeadhf4yzs5ck@quack3>
 <ZafpsO3XakIekWXx@casper.infradead.org>
From: Adrian Vovk <adrianvovk@gmail.com>
In-Reply-To: <ZafpsO3XakIekWXx@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello! I'm the "GNOME people" who Christian is referring to

On 1/17/24 09:52, Matthew Wilcox wrote:
> I feel like we're in an XY trap [1].  What Christian actually wants is
> to not be able to access the contents of a file while the device it's
> on is suspended, and we've gone from there to "must drop the page cache".

What we really want is for the plaintext contents of the files to be 
gone from memory while the dm-crypt device backing them is suspended.

Ultimately my goal is to limit the chance that an attacker with access 
to a user's suspended laptop will be able to access the user's encrypted 
data. I need to achieve this without forcing the user to completely log 
out/power off/etc their system; it must be invisible to the user. The 
key word here is limit; if we can remove _most_ files from memory _most_ 
of the time Ithink luksSuspend would be a lot more useful against cold 
boot than it is today.

I understand that perfectly wiping all the files out of memory without 
completely unmounting the filesystem isn't feasible, and that's probably 
OK for our use-case. As long as most files can be removed from memory 
most of the time, anyway...

> We have numerous ways to intercept file reads and make them either
> block or fail.  The obvious one to me is security_file_permission()
> called from rw_verify_area().  Can we do everything we need with an LSM?
>
> [1] https://meta.stackexchange.com/questions/66377/what-is-the-xy-problem

As Christian mentioned: the LSM may be a good addition, but it would 
have to be in addition to wiping the data out of the page cache, not 
instead of. An LSM will not help against a cold boot attack

Adrian


