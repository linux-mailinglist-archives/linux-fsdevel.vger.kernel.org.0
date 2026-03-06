Return-Path: <linux-fsdevel+bounces-79667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDJ4DRhAq2mdbgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:59:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900D8227AB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705BC3074126
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 20:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B183481670;
	Fri,  6 Mar 2026 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AIZ2lOpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8C480346
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830714; cv=none; b=ZWDZfXgmMfwutSeIfqjRarCw24ZyIARqsrt3RN5dmRXLIYDYIv08Ohax/XZUcswe36XZ6dFp3cU+rjvyeEn8wxu4QEHZgOEHlFgqqdyw6qQcGKncIUU+JYZJTY+XH27c/Z0y2/RbKW05jeM/zqk5NhLzk4faWP4AcCferrGdioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830714; c=relaxed/simple;
	bh=TGDFmSbOj5yHzVE1Lv/hxdXVeXrNKi2LthImHD5XGhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO8Orvwzg3HYf9fj0+u3PzCbETXfDT92f0OszwLO77ap9YQ1mBLaAxPDBEa/2Cn1nyYO2TA2b8QC+LktKUy8KObxBBJQ4lAZooEc/5cAwvWr6Qd0yHHYhU52SXr6t+LsPKC2pkue4iNjVLL9cG8MC/SzeQiL+OARLo8GI5u0bfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AIZ2lOpl; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4645dde00a7so9910298b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 12:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772830712; x=1773435512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNZo5NfTBFF4m06mr7OPW9uWWiG3NXNEdjw76uLifcY=;
        b=AIZ2lOplIhDx7lhCS3+HE8shA1ITX3BxSLa5VtjLvU08+QmyvkteZqa29R72TR4ug6
         U2KIdSOsF9Po9lmLvyNsBVfwLASQgV0+dYBeSytIu6LDbYcjidBajLME9pf/mtwlALSG
         +jYfw0z71pzt2wpLmFrfswViGr9PYkChm23CAWmVZHVFIQk1sL98eaStKPPlmrOlGf5T
         wwxu1vU4pt1R6TuxZOni1eeFTmmJhztNjyRE1gE32HFQGPBShb/ZwbapA6n5cdtNFTC9
         UeNw93y7KrxUD6kI9mjUFuc/VzbEoOUvOPliW2I9RjLw4kQG7h/2cLnCxIno0u092xUm
         SNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772830712; x=1773435512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNZo5NfTBFF4m06mr7OPW9uWWiG3NXNEdjw76uLifcY=;
        b=nOLJ7GGI8YTNOUBB7mCPf3k56a69o7KXFVX659AToPgTaAPLrqFL9TdUD2feH27Imy
         yPxPKViQmmmbATmgMsxre6vuJVRSa8415BxyXuMgSfOiiQID45kFcuF0RcXKJnybch5V
         +Bubue99LKr9GHQNZ4NNbjFCXOoDdSOmUwReiuSOu0Xa+T/6R2n4QqrorH1sE9i78MKr
         EJhWeX1VhHw8y280eX+CipG68iKclCaDurX6GV+VZLBgf2s4/+FtpvR423RAA3ru2IJb
         zMTouQfU0D9QqBpWKqlHV37INVWbMlt7XPgqErWjox+B9Oi7/6L6uwPas8X9JIYzLg6Z
         kitQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+v3xScXip8y8tjgvntoM6Puapf15eI1pmyWePjUVRNiYUUE0wFfMLg+RlAtKkq7utxuEgBXdkXsWKtYXT@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEeBvSKuKxw6iJMBcvR0/1KyYWtPmV4BoL7fbbf73SUHeVFoR
	II1zrH/dOTskvtCuyQuHxg6DZeMKockrUzvQy5JYGwrFDtMsvNJnIWxZnJJhKpXSE2I=
X-Gm-Gg: ATEYQzy06o13/mnEIZKr5EkXZy2Z4mrZQ6AR79FjPvInnAn9AWJPwVqKGBPYy19GDLk
	fiNMX5qRMlW3RCusYzbg2Fx9p9wuNp1pnoP2NyAIXk1itY5PAMavOkyLMV3zQZgTZ/Qc68VJSaI
	6s32MFV56yayTcaBw8P7B27GY7bp5qzCjsahs/HKfZs1ytgmAeQ1wi8zUj+GhsGt+m3AZGJdyHA
	83N9ddc/MWB2ctaweqWn5l+Ay7zefXOvS/znnP2bpsGvz+1LH8L0t1LyY/wz2qSJ3lwwINMztNz
	81r1C6t9NiKWaua5gHawRd1CV2iQ69M8+6E8x7GrOijMt1kcVqWXCc18V6OtAwmWljqquGyxGws
	HlC7nYhHKOFD77wz5/SO3V0NhAtwdc6rHeDxTyhpj+MxVXB3r6UUA2VNSFPFXwP4yeNyi99AOY7
	h146zJZA==
X-Received: by 2002:a05:6808:1b29:b0:463:a42c:503a with SMTP id 5614622812f47-466dd0f8eeemr1809910b6e.14.1772830711654;
        Fri, 06 Mar 2026 12:58:31 -0800 (PST)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm1318842b6e.13.2026.03.06.12.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:58:30 -0800 (PST)
Date: Fri, 6 Mar 2026 14:58:27 -0600
From: Chris Arges <carges@cloudflare.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <aas_88rB4HX2C93R@20HS2G4>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
 <aarVMrFptdXhHsX1@thinkstation>
 <aasAo8qRCV9XSuax@casper.infradead.org>
 <aas06mfCrJuzZd0-@20HS2G4>
 <aas3E9P0BP03O8ma@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aas3E9P0BP03O8ma@thinkstation>
X-Rspamd-Queue-Id: 900D8227AB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-79667-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-06 20:21:59, Kiryl Shutsemau wrote:
> On Fri, Mar 06, 2026 at 02:11:22PM -0600, Chris Arges wrote:
> > On 2026-03-06 16:28:19, Matthew Wilcox wrote:
> > > On Fri, Mar 06, 2026 at 02:13:26PM +0000, Kiryl Shutsemau wrote:
> > > > On Thu, Mar 05, 2026 at 07:24:38PM +0000, Matthew Wilcox wrote:
> > > > > folio_split() needs to be sure that it's the only one holding a reference
> > > > > to the folio.  To that end, it calculates the expected refcount of the
> > > > > folio, and freezes it (sets the refcount to 0 if the refcount is the
> > > > > expected value).  Once filemap_get_entry() has incremented the refcount,
> > > > > freezing will fail.
> > > > > 
> > > > > But of course, we can race.  filemap_get_entry() can load a folio first,
> > > > > the entire folio_split can happen, then it calls folio_try_get() and
> > > > > succeeds, but it no longer covers the index we were looking for.  That's
> > > > > what the xas_reload() is trying to prevent -- if the index is for a
> > > > > folio which has changed, then the xas_reload() should come back with a
> > > > > different folio and we goto repeat.
> > > > > 
> > > > > So how did we get through this with a reference to the wrong folio?
> > > > 
> > > > What would xas_reload() return if we raced with split and index pointed
> > > > to a tail page before the split?
> > > > 
> > > > Wouldn't it return the folio that was a head and check will pass?
> > > 
> > > It's not supposed to return the head in this case.  But, check the code:
> > > 
> > >         if (!node)
> > >                 return xa_head(xas->xa);
> > >         if (IS_ENABLED(CONFIG_XARRAY_MULTI)) {
> > >                 offset = (xas->xa_index >> node->shift) & XA_CHUNK_MASK;
> > >                 entry = xa_entry(xas->xa, node, offset);
> > >                 if (!xa_is_sibling(entry))
> > >                         return entry;
> > >                 offset = xa_to_sibling(entry);
> > >         }
> > >         return xa_entry(xas->xa, node, offset);
> > > 
> > > (obviously CONFIG_XARRAY_MULTI is enabled)
> > >
> > Yes we have this CONFIG enabled.
> > 
> > Also FWIW, happy to run some additional experiments or more debugging. We _can_
> > reproduce this, as a machine hits this about every day on a sample of ~128
> > machines. We also do get crashdumps so we can poke around there as needed.
> > 
> > I was going to deploy this patch onto a subset of machines, but reading through
> > this thread I'm a bit concerned if a retry doesn't actually fix the problem,
> > then we will just loop on this condition and hang.
> 
> I would be useful to know if the condition is persistent or if retry
> "fixes" the problem.

Fair enough. I suppose it's either crashing or locking up. Will deploy early
next week and see what happens.
--chris

