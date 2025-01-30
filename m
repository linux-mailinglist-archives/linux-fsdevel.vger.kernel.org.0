Return-Path: <linux-fsdevel+bounces-40456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D7EA23764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05E23A3B4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438061F0E56;
	Thu, 30 Jan 2025 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqWGFPC4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8EA12C499
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738277577; cv=none; b=gizgyP6GIpVUnTpg33laMWQD8RBWsK8RHJyGD9boBjIItKhkh0i1loIaGANcM1sPEy9+x/lqBxrN0iwL70kDSHpvTps8SDr973/lPEjCfngI0/dDyln11fD+1bhLy7H3ebcE+kZ6xicaevR/d/bB2CRHSRWyr92ESaOBsVSqKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738277577; c=relaxed/simple;
	bh=1yisZBtWjKP9v9e5Bd8RWFEK0AgWSoN/cMey7e54iE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGrBfVjfWjkbD4DmHdjxP0AEMVLwu85UTQ4lq1NwF3TuVuEvIZ8TtjP/PnktXPh7OlbkhK/0K03erE34jOgMlsn7gH2lK/RBrVrnIrpyT/3CLO9qDkJc9mqRsqvVkDJKDicDNDaEbsVrwjJifiMbpXdoZmA4Rusl1p6uZBkpOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZqWGFPC4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738277573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cPju+Vi36bIOQIPZrlaGapWnQOgOv44qx/dBhgk8Btk=;
	b=ZqWGFPC4j3ei6lDh0h4kKfEtPJzBLbuouRU1TpQGC06OYAaaqV/ZWbfKWVdQjfZ16iJet/
	TL1LkYIkwOO2rCk18fITLgUN1KjC3lpUE1S0139bk/n/RrHUIGpCqeQYswiJCmG9cKJur7
	/7e/jctNv02Qkw+i3rngUSYPS+7saHs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-UESUhSlhMiKC53558a2Jzg-1; Thu, 30 Jan 2025 17:52:52 -0500
X-MC-Unique: UESUhSlhMiKC53558a2Jzg-1
X-Mimecast-MFC-AGG-ID: UESUhSlhMiKC53558a2Jzg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso7027135e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 14:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738277571; x=1738882371;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cPju+Vi36bIOQIPZrlaGapWnQOgOv44qx/dBhgk8Btk=;
        b=V+b+9khGBBkmGLwv689A3YrdTcSzBidChYqmzUJnPHeEXo27sCRv8g8DoMYpu8+oMd
         LwZG4BF1pqodgnhPtVwqbb0kXD/GZwr0Vx4vK7TpuY3c52cE/kyfM7YNkm7S6AN/hvD4
         8PxNB3LB4KyGcdFqlhviht+cC6bUBuYp4eEBP2rU946txCC5URidAH5nDAxcZpnOxdAK
         95DcE5MeZ1yK09bHMwDkFT2xkBMfdQ4qD9I6NSdHexhff49lGxNK/WVE2cXwksZo65nQ
         4EQROgix20Pi2mkRsbNTpoiZWe4Q3SGWCTN8ldnkX+OSB0CYg3d0I44p6D6q/fldOIHh
         tN0A==
X-Forwarded-Encrypted: i=1; AJvYcCVLimKDh3g6iWuzctiT7CzLuHvTUSfpxVT0IOMhXjHNs7LHVb7zpJHBmzW38I8Bhhf9CQpwjS/cueCb8ijQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8lpVyJCmil+k5PgpeETQyl6ysJYcSIOo1QJJctnBv55wGArFq
	hvYsnqr/unpXsi7HgKMVF4ZjnT7twoCzQuDPKaDWcUhhzm5LJ4oizqxIY2pAD7LEku7okWrLYk6
	t4rBUsv2q34t6XsvkieRnVQrcwQLZdt1QN8ZaHkMB8EB8vhg0Mmnbtz5Scxgk2QUDrNfEVjrKwr
	+H
X-Gm-Gg: ASbGncvx6LAHwSKeTjsTWRC6NpMByuiJ4x26gvJf4ZV/XH2obqT+fGzMmCtFAx9+PeQ
	Q4YjRQ7XaBusSLCXc8+65Y1AJjQGwc4002peaFiM4Q2CS2ZM+GugZaHf1kCjEPmywE8dFGnCIxy
	NAIk7s0LSsyAmvs+L3n44UQAUhhOHs8r8wGb/NS9YwnVKmaatCpJ4fE+u1rHooR3VM/xgtijBNR
	fslBsbXESf7vqS6WkMCGVPtpztcDlpnXlR4ySIitp6kNQ4L+sDI1o1gW30xhyKgN6JIkovO8Pp1
	LcBFaSyDy77TIb18JCgoDrYrqOpzhDUiqI27iEw8qLOCX09fONh6gK53m6kfVuCC4kWgTc8pNfa
	JtqcHEQ1dmFSxv5Ol8j2vMcM6dm+7hMo5
X-Received: by 2002:a05:600c:4f43:b0:434:a94f:f8a9 with SMTP id 5b1f17b1804b1-438dc41db32mr64037925e9.28.1738277571158;
        Thu, 30 Jan 2025 14:52:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXwjIRyrJ+eMn6tBBQw/cilVnxn83VpQ9dfHol39m1PKOyQpNUBmQKow20I72eeNMGfN/NVQ==
X-Received: by 2002:a05:600c:4f43:b0:434:a94f:f8a9 with SMTP id 5b1f17b1804b1-438dc41db32mr64037785e9.28.1738277570793;
        Thu, 30 Jan 2025 14:52:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c713:3b00:16ce:8f1c:dd50:90fb? (p200300cbc7133b0016ce8f1cdd5090fb.dip0.t-ipconnect.de. [2003:cb:c713:3b00:16ce:8f1c:dd50:90fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244eb0dsm37125965e9.27.2025.01.30.14.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 14:52:49 -0800 (PST)
Message-ID: <da8a25d6-6930-468d-a079-e986dec86bbe@redhat.com>
Date: Thu, 30 Jan 2025 23:52:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Migrating the un-migratable
To: Matthew Wilcox <willy@infradead.org>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Jeff Layton <jlayton@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Joanne Koong
 <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
References: <882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com>
 <Z5vzuii9-zS-WsCH@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z5vzuii9-zS-WsCH@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.01.25 22:48, Matthew Wilcox wrote:
> On Wed, Jan 29, 2025 at 05:10:03PM +0100, David Hildenbrand wrote:
>> As one example, in context of FUSE we recently discovered that folios that
>> are under writeback cannot be migrated, and user space in control of when
>> writeback will end. Something similar can happen ->readahead() where user
>> space is in charge of supplying page content. Networking filesystems in
>> general seem to be prone to this as well.
> 
> You're not wrong.  The question is whether we're willing to put the
> asterisk on "In the presence of a misbehaving server (network or fuse),
> our usual guarantees do not apply".  I'm not sure it's a soluble
> problem, though.  Normally writeback (or, as you observed, readahead)
> completes just fine and we don't need to use non-movable pages for them.

Yes, we discussed a lot of that, and where it could be handled, and 
where it simply cannot be handled. I also don't believe that we can -- 
or even should try to -- be perfect.

There are certainly cases that simply cannot be handled, or only very 
very painfully. Always falling back to allocating from use non-movable 
memory "simply because it could happen" (e.g., someone could trip over 
the network cable) is stupid.

I think it's all a matter of seeing how far we can get with reasonable 
effort, and which cases are really problematic -- e.g., untrusted fuse 
-- and how they could be better handled.

The discussion so far already revealed a bunch of interesting 
approaches, but also limitations (e.g., fuse with splice).

> 
> But if someone trips over the network cable, anything in flight becomes
> unmovable until someone plugs it back in.  We've given the DMA address
> of the memory to a network adapter, and that's generally a non-revokable
> step (maybe the iommu could save us, but at what cost?)

Right, and as we discussed as part of the FUSE discussion.

It will be very interesting to hear into which problems others (e.g., 
Frank) ran into and how they could be mitigated/solved.

> 
>> As another example, failing to split large folios can prevent migration if
>> memory is fragmented. XFS (IOMAP in general) refuses to split folios that
>> are dirty [3]. Splitting of folios and page migration have a lot in common.
> 
> Welll ... yes and no.  iomap refuses to split a dirty folio because it
> has a per-folio data structure which tells us which blocks in the folio
> are dirty.  If we split the folio, we have to allocate an extra data
> structure for each new folio that we create.  It's not impossible, but
> it's a big ask for slab.  It'll be a lot better once Zi Yan's patch is
> in to only split folios as needed rather than all the way.
> 
> That problem doesn't arise for migration.  filemap_release_folio() is
> only called by fallback_migrate_folio(), which is only called if the
> filesystem doesn't provide a ->migrate_folio callback.  All iomap
> users should use filemap_migrate_folio() which just has to move the
> data structure from the old folio to the new.

Right, that's why I said: "if memory is fragmented".

Try migrating a 512 MiB folio (arm64 64k ..) when you cannot split 
(dirty) and memory is all fragmented such that you cannot easily grab a 
free 512 MiB one. Of course, that's an extreme example, but it can also 
easily happen on systems with smaller folios ...

... and then, we now have folios that cannot be split below a certain 
min order ... (well, we kind-of had that in an extreme form with hugetlb 
that cannot be slit at all)

-- 
Cheers,

David / dhildenb


