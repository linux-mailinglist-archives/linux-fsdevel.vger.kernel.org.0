Return-Path: <linux-fsdevel+bounces-27817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D136F9644B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114501C249B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB231AC429;
	Thu, 29 Aug 2024 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gvCWoDi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212B1A76D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934853; cv=none; b=JRTPUUlN6lH2FE/FLUjO297mAJhQOqYAExXeFS5Y6kuP+7O8xSAn/k+MY+6l1Bf6lKNpUNKf6SwxqetibOaj2URLJRvDk+7mF9R/LgtjGBrA3+UgVPUoXp/z2pOUvMgb8BPvuujnZiCK1yww5nMBt7Vh85QIoHDowMav6Ge8eGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934853; c=relaxed/simple;
	bh=q2fjH+xqpJJgikvVYldH+MUiIa8nCfGUAkjhB4cVhFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG0UN4fBhCr6Nr2iVrfGffLQ6L0xWL8uxGMqoPGhTrFu5r5VXwamC40GtBFUgfeTYYu/1OX55OwefMZ8JPswPh8RK6y6KyHDW/uxpLqMVGkUz75MTvobcDpORzGGsoxlIhcFgUEhssrRWS/mRs4+XRbdlYtg73NM9LkpWVGC4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gvCWoDi2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37182eee02dso364969f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724934849; x=1725539649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0omIxXdZ2Z1z0cHN/bNiykvs++kigV/Ublbt82Yn504=;
        b=gvCWoDi25Mvaoy2N6Gc/1/b5rXP7LbRjKV2vtasdp7IDIHB8PjH6q7U1KQsmObwzKh
         s9uNe8S99HsagtVNxkvtr9GAwYJkhjC6L4B+t1TmbOxzPSEwmERCmsbivfaraJKUxyaZ
         GW9vK2g0LjXPHqD8Z4sCHwS1H94K/4nZn5WTFHKl2boKrdA6Zi58ioB2YER5bittg+zG
         baYs1J44rUsw2//ORnWeBk+FR08tDkcGigxusP5GiyitK4EP7L6ID3hygat1CoCIhkjz
         T89uCvtTnN/fwDfN98kYac3zAIfNsbUvex8n9J1sgoabdQ7+lv0B5O4RetXpNy5hscVt
         qXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934849; x=1725539649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0omIxXdZ2Z1z0cHN/bNiykvs++kigV/Ublbt82Yn504=;
        b=uM8k6dbmJxD/4N/HB1MXmZxxLXpAs19bPCGZtH/sjq+Y0LYF94OV6faVE8zfgQbaKg
         s3oT3EYznFq/D7an+PuzoqgsLe9btH/eate1oB+r4lx9t/YrIZOMU5yIGiQoeF8l/Z8l
         QypU2E6a5aKcVnNmHZRTLPFHDEsArrFZoJAz+XvFQL1OJZwLzEI3BHL+lyH0+FEHFZ6G
         /WVSFsIWqPJ3V5j2Wa87ASZnF56SAIbTgcHzNCZT0xicAOWRLMzZ9CHpdqe3N06giWaE
         s5SyF5afp61BlU+0gwz8F+3YYs4zmOc/BfSD0h2v22R69Zm99LnaSiyBw2UZsL4QN9mu
         I0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXVyMw8qDekAt2o8pImZ4Vhqi7Ye1JBK6WlUo6rc7rpmy2BqhaEbcAuSg3KA77cA76ymbYeK7D+saasLkkj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9x50LPTsn4A5uSvsnaro5t0p5Y6wx23SxQdNuwXiyERGpaZf
	hEUtoPuGaC7ljvTcCqBNmcFo42rhC7mnbnoE/rJblLBnpzjTfRk7v9Bftn462YM=
X-Google-Smtp-Source: AGHT+IHgfsIGgJ6Yfaz6Z5p0OF76oo2Tcpl57sbIiw84kU1rMt9PHEtlVdPlKeTiXsqZV5kEsxLlmw==
X-Received: by 2002:adf:fd0a:0:b0:371:6fcf:5256 with SMTP id ffacd0b85a97d-3749c1de10fmr1399945f8f.18.1724934849494;
        Thu, 29 Aug 2024 05:34:09 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0a0asm16231425e9.13.2024.08.29.05.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:34:09 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:34:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <ZtBqwOiBThqxzckc@tiehlicka>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>

On Thu 29-08-24 07:55:08, Kent Overstreet wrote:
> On Thu, Aug 29, 2024 at 01:08:53PM GMT, Michal Hocko wrote:
> > On Wed 28-08-24 18:58:43, Kent Overstreet wrote:
> > > On Wed, Aug 28, 2024 at 09:26:44PM GMT, Michal Hocko wrote:
> > > > On Wed 28-08-24 15:11:19, Kent Overstreet wrote:
> > [...]
> > > > > It was decided _years_ ago that PF_MEMALLOC flags were how this was
> > > > > going to be addressed.
> > > > 
> > > > Nope! It has been decided that _some_ gfp flags are acceptable to be used
> > > > by scoped APIs. Most notably NOFS and NOIO are compatible with reclaim
> > > > modifiers and other flags so these are indeed safe to be used that way.
> > > 
> > > Decided by who?
> > 
> > Decides semantic of respective GFP flags and their compatibility with
> > others that could be nested in the scope.
> 
> Well, that's a bit of commentary, at least.
> 
> The question is which of those could properly apply to a section, not a
> callsite, and a PF_MEMALLOC_NOWAIT (similar to but not exactly the same
> as PF_MEMALLOC_NORECLAIM) would be at the top of that list since we
> already have a clear concept of sections where we're not allowed to
> sleep.

Unfortunately a lack of __GFP_DIRECT_RECLAIM means both no reclaim and
no sleeping allowed for historical reasons. GFP_NOWAIT is both used from
atomic contexts and as an optimistic allocation attempt with a heavier
fallback allocation strategy. If you want NORECLAIM semantic then this
would need to be represented by different means than __GFP_DIRECT_RECLAIM
alone.

> And that tells us how to resolve GFP_NOFAIL with other conflicting
> PF_MEMALLOC flags: GFP_NOFAIL loses.
> 
> It is a _bug_ if GFP_NOFAIL is accidentally used in a non sleepable
> context, and properly labelling those sections to the allocator would
> allow us to turn undefined behaviour into an error - _that_ would be
> turning kmalloc() into a safe interface.

If your definition of safe includes an oops or worse silent failure
then yes. Not really safe interface in my book though. E.g. (just
randomly looking at GFP_NOFAIL users) btree_paths_realloc doesn't check
the return value and if it happened to be called from such a scope it
would have blown up. That code is safe without the scope though. There
are many other callsites which do not have failure paths.
-- 
Michal Hocko
SUSE Labs

