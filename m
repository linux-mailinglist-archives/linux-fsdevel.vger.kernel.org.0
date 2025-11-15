Return-Path: <linux-fsdevel+bounces-68558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A2CC5FEE5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 03:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99E43BEF91
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 02:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932FF218845;
	Sat, 15 Nov 2025 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdaBEFB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A013A244
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 02:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175075; cv=none; b=rSs1liWY0SB1RYWcCRGy4T+ObGsqMjj+22KXGyscfJX2FhjZ23EHgmPA242/qfk2uQOYWimHYh1BQyfL0WsE9pue6lDv93L+VfvqueMiIJ6hik/c5PcHLI6SUvM5+auQvwiae0f1GaMjp5VDkN9I7YlCxxCZf9JnhvaHT4GBb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175075; c=relaxed/simple;
	bh=j1dXyTEKSm2UQNkPf89h934G4UFOEu3XCzQlLvqkkVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOuHCliwqowDdAfjX9KRAzzWe7XQm+lWHFL1cVIOOTI7oPdkRoLjr4b+HsLS+3YfUOJhuoqdVuQWS1ABAtZLyqyEkbepnyrU6DhTQiPfcSrzBEC4cB3jbbm48i2vo+6imY7hVjuFsHXDXPfqVS4E2Nc2raZ8ASILlBsN66NQTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdaBEFB1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64369269721so697977a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 18:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763175072; x=1763779872; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Au18H467azZy+IfrgSEjSDC4r/H00yPg/dxvvmoSDI8=;
        b=GdaBEFB1nRtuoWPiVrWjLqblXIMqEqakv3Z9X3szZ0Qblt6RVqzPiF7OoWWjth+Jkv
         Y2eznD6aLGfCML/HN5cs5nfKcEjvLB8v7NEm8wV86PBya4vltaMFfXjHFuInkzMl1kUp
         QJ+J4P5aX5AofD/KAIiS+4DT2Ly49+117nB9FBtPuH6Kng9hgrx29RvPh5NS9aeB/1ou
         szjEefLiIJrHLQj1ZQw4zRatp4fCidDQ2Sw/VzE2reIByiFdkqO8XOJjSV6cJ++RWINN
         ++/w6uZePwi4V+ISCbRg1dhVYphA4YvX5QQhlrJVRbV1Fkob09QC2crhRZ/EVIWiaEkf
         wCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763175072; x=1763779872;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Au18H467azZy+IfrgSEjSDC4r/H00yPg/dxvvmoSDI8=;
        b=c7iHbakAw+559JKpZE9+ONTtiluA0hP5F75a9UatxfkdxjiG2TijzVs0/ln3iDOqCH
         rIbkOUS2E6tqCjvym4VEhw4NAIK7HFg4pKS0mVV9w50gTX5VJvL7MUo/hDYyBvVlevjG
         g5gl2XmnGyCGU2Z8mWQz3VDnSZS5tJlF/vhbBCAszbrYhWso9f7daxHnlcdqq3nPaidp
         kOl5SMaBP6FDs/ElNzszhU0hLjeszUY76Px7LjPTcUg924pY9xKyfCnEpoQuFWhzDEVq
         bv0aFN7v9VlzfuT99aKXDjAheBihM+wMFR+yZDbw3/+lJw4ty8lXkNJV1O2C43IfYEBI
         SOoA==
X-Forwarded-Encrypted: i=1; AJvYcCW4ixVqmLYtN7XqifdKLYd7tAjmdnof5/QTvEmNOSJMMdKj98fxm0AiLR5lUBEXSLoXpD41evWlf9cCzgZp@vger.kernel.org
X-Gm-Message-State: AOJu0YzluYtbRoAMyoX7+ZKTlGIMqE+0Vyg8pUBPMeJlnLI/tqUmcn3z
	uIZNvh0Ys6hqY9pyi5CH66+YurR+ylrdgb1FFu2AgSdUatr472VKIkYj
X-Gm-Gg: ASbGncvwlq7xP5MFqJQ1G5PsmPpcfUVC2MixzIyckaSoSgey0IlWDyVwTanMW4RS/Rf
	4Dod2DZn4FsN693zVcgW2Rxj/IzpOoTb57yz/dekqq3GfeQIH6p5gWKNQcnIu29ATEOODy+MonB
	lEqz6IcsbNhR/vZY++jeuoosfTkNuRf39qAcDPvpbxaja51wGslpE06Cfcbxy15rqUrTu0SOld4
	yTGeYiXceXWxMWJRfHgo9TIKEKLwMimCZ/Po4EG/MfuY5ymAhaTLPIlbSRsHXartY0uL7seGUzD
	fHr8UZjeNT7w3CN0HkmjpP3KfXZQ99MS6jxswc+uTj6BlNPNxifFNBlvXZ8LesCHcVGDUf/b6Pn
	1Oka8jRLQ9BoIN3istuj5hY7p8MZ0DMqIpUCWq78dfxhEGQaUuvTeAxoeTCQr6/zKQZw5tB3yLc
	XPkUZVB7HZ+GHRGzGgri/LjeJQ
X-Google-Smtp-Source: AGHT+IFijYhBosLb31iiGAABudJFyw60Nhzb666Nl93sjFEpO/WA4uHbEpnOI80frPELz2vzKBG3QA==
X-Received: by 2002:a17:906:478c:b0:b72:dee9:88df with SMTP id a640c23a62f3a-b736793de88mr514948166b.46.1763175071623;
        Fri, 14 Nov 2025 18:51:11 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdac50csm506960666b.61.2025.11.14.18.51.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Nov 2025 18:51:11 -0800 (PST)
Date: Sat, 15 Nov 2025 02:51:09 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, willy@infradead.org,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
Message-ID: <20251115025109.yerb7gbty4h7h63s@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
 <20251114150310.eua55tcgxl4mgdnp@master>
 <64b43302-e8cc-4259-9fa1-e27721c0d193@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b43302-e8cc-4259-9fa1-e27721c0d193@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Nov 14, 2025 at 08:36:20PM +0100, David Hildenbrand (Red Hat) wrote:
>On 14.11.25 16:03, Wei Yang wrote:
>> On Fri, Nov 14, 2025 at 09:49:34AM +0100, David Hildenbrand (Red Hat) wrote:
>> > On 14.11.25 08:57, Wei Yang wrote:
>> > > The primary goal of the folio_split_supported() function is to validate
>> > > whether a folio is suitable for splitting and to bail out early if it is
>> > > not.
>> > > 
>> > > Currently, some order-related checks are scattered throughout the
>> > > calling code rather than being centralized in folio_split_supported().
>> > > 
>> > > This commit moves all remaining order-related validation logic into
>> > > folio_split_supported(). This consolidation ensures that the function
>> > > serves its intended purpose as a single point of failure and improves
>> > > the clarity and maintainability of the surrounding code.
>> > 
>> > Combining the EINVAL handling sounds reasonable.
>> > 
>> 
>> You mean:
>> 
>> This commit combines the EINVAL handling logic into folio_split_supported().
>> This consolidation ... ?
>
>It was not a suggestion to change, it was rather only a comment from my side
>:)
>
>[...]
>
>> > 
>> > The mapping_max_folio_order() check is new now. What is the default value of that? Is it always initialized properly?
>> > 
>> 
>> Not sure "is new now" means what?
>> 
>> Original check use mapping_large_folio_support() which calls
>> mapping_max_folio_order(). It looks not new to me.
>
>Right, but we did not actually care about the exact value.
>
>IOW, we didn't check for order <= mapping_max_folio_order() before.
>
>SO I'm just curious if that is universally fine.
>

Thanks, I got your point.

I am not 100% for sure. While if we trust it returns 0 if folio doesn't
support large folio, I am afraid we can trust it returns correct value it
supports. Or that would be the issue to related file system.

To be honest, I am lack of the capability to investigate all file system to
make sure this value is properly setup.

>-- 
>Cheers
>
>David

-- 
Wei Yang
Help you, Help me

