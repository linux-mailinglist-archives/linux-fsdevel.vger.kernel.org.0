Return-Path: <linux-fsdevel+bounces-27773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2EB963C9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 09:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1D4B228BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9005A16D9BA;
	Thu, 29 Aug 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JxEVMcCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F581537D8
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915959; cv=none; b=N9Ev4BfXymAXMKMP8OYdxCmvmUFl1APtVcsMBdL4nrsMXL87TlRCwXNO76yrVouPRWsf4GFQTaSyrUihA1A6434EVdHBhsNn707gbl9zCt+C3f9oqd1c2dpoB+5zzyGnkf/9VCuNkz38zp2ta70axvywAu1OeK24k3j5bznSnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915959; c=relaxed/simple;
	bh=TISxj6nsuiWrdhbb47Ec6ZP2r5NbItH83bfghYORogE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsQYILtVONbyV8/z6e6Q8tshxGjeXt6wJioSFqi9ksRD6ipELo1RPBJV7gTIxbX92Gw5VfR1tATiu2z3582IaveeMDWQvXx7XYgfnaHhAFFk2bWBycG+LM1UpooO3XXRmwk6cOELTbSVZn8SpoEfXF0GUUsoXhH5COMZNf8u6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JxEVMcCN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42ab880b73eso2984865e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 00:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724915955; x=1725520755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZZ5Dfz1N7noCUMuVJV0Kdu8cyfE+FvZY+c2JPzrzUQ=;
        b=JxEVMcCNMVnAsfgSK8HAvKnOH1CQBceoxZehw7bB7oXPtVjQoui8R/tEuMyLdbRhEY
         BDiL39AeCL+8LLMjU9hFG0F/m2Gn1UZUQGc1flmkw1TWy1Rc676YFfZu76phiGcupGfN
         CUxX4VKfza71DKDeRBnmclH3YWjGAwnztlBCWBVcmWdMa3atoBfSxKN6w/6kDGSNZB2B
         6G2mxB0uk7rXQUJFVm6jEWycLi5jznTLAT8BjiCbpkyq39NE2pUNyfNZ9y9QMV4Wb6kG
         xGCeuyq1sDQHyojVadNI2kGTUfYHmA5VO4qR7rw4w+9TRKqPxGhw++dA5EHq4KE9JJVp
         Z30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915955; x=1725520755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZZ5Dfz1N7noCUMuVJV0Kdu8cyfE+FvZY+c2JPzrzUQ=;
        b=Y3P2MW1Lllbr4CeaRJ2zxpv+VeZyc9U4PppqhhHvGNVq6bqUbOzWoVg0GjJlRbbmC4
         2Ul2cgpwfg7kkpymc0bU6GZBj5i0MPbN/ukI5uD5RMo9JX0Q6LlJydUym9ptF+yShqUb
         2Nu1fhbkygc2RZ+1teNP4SdNIFJlT2ismP/41zsBzrS/Q89Ut2IKC9R7HD7CegOJZe2X
         HCeqGQuRTQZ/fXABeUPZGZodPuPSvgD5Q+yN14f4NhO2fOsYkLVZpiYQcBbB+S/kI/XX
         hFPiGAQQBwBS5PvGd84H0g4SXvaUZ9h7ek+Dly+FRPRup0ZkQigVmTXpIUKpn3NL5T9m
         JZ2A==
X-Forwarded-Encrypted: i=1; AJvYcCXkMNegulmP/gi1gtQyofodVFiPg2Hcqy+asn0uQlGIPauZwq9a2GPT296i5jTJEpFseYSkoND0Yh4eQupv@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfQVnfUEYKU8xqZjJfP0jEEUINEMIHYGr8jC+XK77kE70KwPL
	CasGhpsSNFltAok6n/Sp8tuufH/6IDBgIDtpLFY+QjxrP0knn1KE74v4mhy3tbI=
X-Google-Smtp-Source: AGHT+IGWX48blvuHIVWdw3Bdns41uj8z9ckLX+g7N99SFM42wMeFHQFkVqKqWrh8ih/Ez3xgeQ7kyg==
X-Received: by 2002:adf:b312:0:b0:371:82bc:7d93 with SMTP id ffacd0b85a97d-3749b526ec0mr1284850f8f.12.1724915955164;
        Thu, 29 Aug 2024 00:19:15 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba83sm665280f8f.54.2024.08.29.00.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:19:14 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:19:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <ZtAg8Slmclt8jm4a@tiehlicka>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>

On Wed 28-08-24 18:58:43, Kent Overstreet wrote:
> On Wed, Aug 28, 2024 at 09:26:44PM GMT, Michal Hocko wrote:
> > On Wed 28-08-24 15:11:19, Kent Overstreet wrote:
> > > On Wed, Aug 28, 2024 at 07:48:43PM GMT, Matthew Wilcox wrote:
> > > > On Wed, Aug 28, 2024 at 10:06:36AM -0400, Kent Overstreet wrote:
> > > > > vmalloc doesn't correctly respect gfp flags - gfp flags aren't used for
> > > > > pte allocation, so doing vmalloc/kvmalloc allocations with reclaim
> > > > > unsafe locks is a potential deadlock.
> > > > 
> > > > Kent, the approach you've taken with this was NACKed.  You merged it
> > > > anyway (!).  Now you're spreading this crap further, presumably in an effort
> > > > to make it harder to remove.
> > > 
> > > Excuse me? This is fixing a real issue which has been known for years.
> > 
> > If you mean a lack of GFP_NOWAIT support in vmalloc then this is not a
> > bug but a lack of feature. vmalloc has never promissed to support this
> > allocation mode and a scoped gfp flag will not magically make it work
> > because there is a sleeping lock involved in an allocation path in some
> > cases.
> > 
> > If you really need this feature to be added then you should clearly
> > describe your usecase and listen to people who are familiar with the
> > vmalloc internals rather than heavily pushing your direction which
> > doesn't work anyway.
> 
> Michal, I'm plenty familiar with the vmalloc internals. Given that you
> didn't even seem to be aware of how it doesn't respect gfp flags, you
> seem to be the person who hasn't been up to speed in this discussion.

GFP_NOWAIT is explicitly documented as unsupported
(__vmalloc_node_range_noprof). vmalloc internals are using
vmap_purge_lock and blocking notifiers (vmap_notify_list) in rare cases
so PF_MEMALLOC_NORECLAIM is not really sufficient to provide NOWAIT
semantic (this is really not just about page tables allocations). There
might be other places that require blocking - I do not claim to be an
expert on the vmalloc allocator.

Just my 2 cents do whatever you want with this information. 

It seems that this discussion is not going to be really productive so I
will leave you here.

If you reconsider and realize that a productive discussion realy
requires also listening and respect then get back and we can try again.

Good luck!
-- 
Michal Hocko
SUSE Labs

