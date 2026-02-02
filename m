Return-Path: <linux-fsdevel+bounces-76077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCUbAOPmgGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:03:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDEECFE41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FF543009384
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A8F36213F;
	Mon,  2 Feb 2026 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Aj1JpC+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCF43612CD
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055335; cv=none; b=Oazl27YOYBcFuUXgd64E1oOS2CXkt9IVGmVziKmTzk1ALg2O64Z6VdsVWbYKldI2obSP0iVQHJERlyTX53zL6mS54eUys0EkkT4Pdi1w+FPBcr2YsXEsrbc2MAouXG0LepjcM87nBFrsqjGcYsT7o8btT2cmDZa/YR75Xf4LX/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055335; c=relaxed/simple;
	bh=MbAgTX+hDTfHzpvyoNvAv/VH86Gp5D8IWac2rvKmaY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXTtgzx8czA7WHDyqrlx0GM0LaA52nJojQSVLRyDhI47mT/99CIIkp8jWmGimiaNZ5T1xAwkFTajxAhtHi3xFi1CYmZA28oJL45eZXzLIWA0qP3z6W5X13zHxkreZmcr8+wl909bdmrgINNlb/9urLwyfO6RDwuBO1WlAAbjl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Aj1JpC+x; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5029aa94f28so42984531cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 10:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770055333; x=1770660133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMO26NJqLzUacsptvD643N0i+a1yKYqxDegqXwZutbI=;
        b=Aj1JpC+xrABNzYNRpCdkZPyfq4fpyHofQgTKnTflpXvwKssxlbTrRAytGzhuPWUdNK
         CfRYx9eV/CaKWasmMIYZOb3PbKKbRph2X5q9IzvXiW3Zp4VcIzjHLGh5BGVQq11KaLfK
         HIfPvH1wqREF7DiOxjT+o1zGx22ZdlKX59n2D/PmifZQ5eB6tz2BfWcSischrqsnggfy
         1F79UPbPyw6n/UOrq3Aqn8haN46JgwftdoHEVRWplbueekIRggnWnH6OMK1GDMW35go/
         vTvErql0wX5l2Qey8bJa5VH/Q24DExcroGeIQO0uC294obNNfFCH8LyGWZIWtX+AXCgn
         9mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055333; x=1770660133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMO26NJqLzUacsptvD643N0i+a1yKYqxDegqXwZutbI=;
        b=G0+ZXaIUXAIbiKw51GRIpuszNBXNxaTA92sJ1fNj9iW8HWeIawz3X8BX/4EEjl1YvQ
         0/uZvdhSH7ua0h9jEqZvV2BfOlnSU37J3DUpjkwTa6yNbWwArR348+RxGZCg+gmT/nqa
         3ZS2AaDTZ5rF3hIMkDaSBOKGVyu7TcvQJqjgb/M3FvbM0pgjndoXa/dRp9ju3zfqOUCH
         9zworVhydeA3mn+gXrStofEXL/HrzYB+nk14m9k9LvJZWKz0LXal697MfM3TkpKGqhqc
         GJCWv0mWDXTTxAEUqt0eKemewDl/oLMeAK9EtAiEdUGJ/21PSEU38YL96huwubSTdqAY
         /h4g==
X-Forwarded-Encrypted: i=1; AJvYcCWVF1XAfVs17KkokLD0en4XC9/H/o6YtN68qBWbNHeq3e4fwlfazoTEQrjEF5T6tAy4ihd4na6ee6ffuIII@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/U14lWic37LlCz0tPv3HB5pnI73XMXtLO/qSAiRoCJ8mhnhN
	VX58x7h9OImJn1rPJh0gtTRzyBye/5setiC2i9OCP4rjvI25t1inxqABxtfXWpe2c/w=
X-Gm-Gg: AZuq6aKNw+GKjFQ/xf5fNI3wv901J8DuvnqvVyodssxsLz0GcYyow2p4A7AMuhW1RiZ
	OHcwlh324r8Wlj6Im+Pjdq/OFjm/OeEjo8O5YLfTW1FsOQpGUsvGTZA9v4MpjJZEANq06TIDEDv
	KQlBq0LKngFnEGoH5mGW0paPIWLsA8n4BK5JWDcv6uWk7vwhw4Z//1tZ4yvZ/1jJTGl5+CuFsQk
	9BEu0riaqnNG1iT2n9oahrw57IHRvFMNV/l7cG201YHmOHAktzY2ial1qLf4BkWVLr3d8Ntap5P
	NFcBNZqhC2Gsz9rmOyq3KIS/UTQEafvoxdPp8x90T8EyQk97/9pgsp0xbSgquXtjTQvmjoQnVoG
	E3Ld+B746lAqsvt9R6fVGpD37z62rIksbbHojBoHECigor6BX/X3OUyfqxOPQ7wOr4u+9BrOkMc
	WpBUCQyErBcB4ZGx7BJeat4HfPQETnmv2oMRo/aLORzcZdZtcwE5n+cocXvJ/YjS8r4LebEQ==
X-Received: by 2002:ac8:5a54:0:b0:501:45d7:10cd with SMTP id d75a77b69052e-506092c7f24mr3163751cf.20.1770055332821;
        Mon, 02 Feb 2026 10:02:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c5430sm119862196d6.22.2026.02.02.10.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:02:12 -0800 (PST)
Date: Mon, 2 Feb 2026 13:02:10 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	terry.bowman@amd.com, john@jagalactic.com,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/9] mm/memory_hotplug: add __add_memory_driver_managed()
 with online_type arg
Message-ID: <aYDmor_ruasxaZ-7@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-3-gourry@gourry.net>
 <20260202172524.00000c6d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202172524.00000c6d@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76077-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:email,gourry.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FDEECFE41
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:25:24PM +0000, Jonathan Cameron wrote:
> On Thu, 29 Jan 2026 16:04:35 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > Enable dax kmem driver to select how to online the memory rather than
> > implicitly depending on the system default.  This will allow users of
> > dax to plumb through a preferred auto-online policy for their region.
> > 
> > Refactor and new interface:
> > Add __add_memory_driver_managed() which accepts an explicit online_type
> > and export mhp_get_default_online_type() so callers can pass it when
> > they want the default behavior.
> 
> Hi Gregory,
> 
> I think maybe I'd have left the export for the first user outside of
> memory_hotplug.c. Not particularly important however.
> 
> Maybe talk about why a caller of __add_memory_driver_managed() might want
> the default?  Feels like that's for the people who don't...
>

Less about why they want the default, more about maintaining backward
compatibility.

In the cxl driver, Ben pointed out something that made me realize we can
change `region/bind()` to actually use the new `sysram/bind` path by
just adding a one line `sysram_regionN->online_type = default()`

I can add this detail to the changelog.

> 
> Other comments are mostly about using a named enum. I'm not sure
> if there is some existing reason why that doesn't work?  -Errno pushed through
> this variable or anything like that?
> 

I can add a cleanup-patch prior to use the enum, but i don't think this
actually enables the compiler to do anything new at the moment?

An enum just resolves to an int, and setting `enum thing val = -1` when
the enum definition doesn't include -1 doesn't actually fire any errors
(at least IIRC - maybe i'm just wrong). Same with

   function(enum) -> function(-1) wouldn't fire a compilation error

It might actually be worth adding `MMOP_NOT_CONFIGURED = -1` so that the
cxl-sysram driver can set this explicitly rather than just setting -1
as an implicit version of this - but then why would memory_hotplug.c
ever want to expose a NOT_CONFIGURED option lol.

So, yeah, the enum looks nicer, but not sure how much it buys us beyond
that.

> It's a little odd to add nice kernel-doc formatted documentation
> when the non __ variant has free form docs.  Maybe tidy that up first
> if we want to go kernel-doc in this file?  (I'm in favor, but no idea
> on general feelings...)
>

ack.  Can add some more cleanups early in the series.

> > +	if (online_type < 0 || online_type > MMOP_ONLINE_MOVABLE)
> 
> This is where using an enum would help compiler know what is going on
> and maybe warn if anyone writes something that isn't defined.
>

I think you still have to sanity check this, but maybe the code looks
cleaner, so will do. 

~Gregory

