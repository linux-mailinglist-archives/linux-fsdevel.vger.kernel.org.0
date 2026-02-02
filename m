Return-Path: <linux-fsdevel+bounces-76094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDSFFGsZgWm0EAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 22:38:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B60D1B0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 22:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B0F304DE99
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A42EC0A6;
	Mon,  2 Feb 2026 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Mzx9Hd/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E872EDD41
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068231; cv=none; b=IVUyGoDT5p5qwqU6fQktvpzsm3wd0k+hlwXz/A/s11Nc8NTJcrBJoNSYSqzIaJ8hZyDfdXhfahLhU9OVbUe5qg6npYwBPrhf0/vG8sxuf1icKV2GdPGPkKaxAkGU3of3JKONJdyd8KqWy/yCvC/Tn/r2guVHtJL/dL67ZooAJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068231; c=relaxed/simple;
	bh=kWEypPVGwJEMybutYPQAIuFoGDfenpYyYtSso4g6JH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INzTPW3BsD/iia7p2ZhNntHLfxVVC2d0quxm2kVWK9D+fuVI1UIwh5OaqM9jTQEua0WNu8smjllTy+PXJElJlo8IyHcqSTC7eepUuskHCZLdZj+6QQcFXkoZz4sJWuaJXwq+fc/oJxdYA3Jhto3IDJhq2GbSllLc3gJQg9WpJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Mzx9Hd/R; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c6af798a83so568885785a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 13:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770068228; x=1770673028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8laAOVGcrjt3grREBpdlanB8iPI5gP36V5MB+/CpDTw=;
        b=Mzx9Hd/Rzt+M+pJq9wOJRdRLoK7Svg7rFWFXH2nBvx1PV9vaNObCnNYbF5O2Kk4OLb
         VjdBr7JKdmQzzE7uEqmt9JLCMpvCohdG2P1YFr2uBfPFwoKU3TPlMPjzgW62pD/yEXh8
         wPAvQ2YR6/lVWr2aZXP7mV+0JIu88qFTCOcSoPvqmFz83INXqVooueaHMy00oCZlmgys
         XC+QiXVYxKLHy3bY7XOqqu0tjlENqGPiyXu+s2SLdl5vuVqJTvO5OQcwCEGokRqsm6S9
         B6n3U3wEoh96z1SiUNTjG044xBGkEWryo/9BUQepQmGkdG9rpXMy4P/C638jFPArwfiw
         poKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068228; x=1770673028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8laAOVGcrjt3grREBpdlanB8iPI5gP36V5MB+/CpDTw=;
        b=DN1SIQ4pgWlaU1b1AQg0Ofi1E3V+QeaViJvv6SwQdwBaQHVNHOdlMK6OzIpv1Ip8d5
         hTMITTQ1piEUibkbVtw/I0J5CA844Dpl9ctoNNmCwYb418MBSImCGKj/DJ65uvdhGNZ3
         MuEl3ICM+42ZsjcWvmzFn4gxfq45QlZrPAB5pat/uJwzExX7iSdw8NwIrtBuWLU9grrF
         S1PlKPD0q1GQ8/HTaYM2xnitJ2pbqnZDux87zXMKE9aWjhw4+c7sh0y9SYtbh14uOZ9m
         dwD7AbWMedmBtpBP+45NB6Upa4brTdSYDXadQDpgLht9cPE0X2eFz2fulkr1JkQZ4yDU
         e9XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiWRnGL3KNCB8n5a0NSgBNlCR6aWnKHxGNdklZGT4+D0hMMTfXaRkISogdeFvP1BMKEQghrXofkU12rf1P@vger.kernel.org
X-Gm-Message-State: AOJu0YyFo3hB7Dc1+NmTjHSDU2sG84aIcGUadEVFdgTP0H1aY40X5/wn
	t7EWHdGDhzJyIHkZzO7yCl04JyeABnsCBa69KBA4XTJJgXrWx3744kMHgGoLDNo4ZNI=
X-Gm-Gg: AZuq6aLhHbuGaMsji/SDDSgbpnb9FHPAESOGgJEQ10GCm0agLhGCJ71gGfdUpio2EJA
	31HXPsC29hzhLpHZI4BOr4V0pbIuF0lu073h1UwMbLWcC8Ss4gBqZ9nQYYsNkNe8fB8ZldvuXkq
	b9r35YGR2mr5I+tdVdqW0/74Meq0cbhUf7TytKUh3cuxxnDVW6pJCPxSpTnE7dY3fkNiJ6qa6RR
	tpkiCpR+/gEjUPPT3mFvy4vZPotGVY11syU2LzFs2nlgmPRAlJtRQI346VYEcutAcORSnVJxA67
	rNWVoVgsd0p1idh46MnMCRGXJMFoVvX4zt7oXM4hxmwlsBNLQyivTXCEhUoSjqFKfKm9hD+LHxt
	esX+8bEvExtttC0sQYoDzPFSAIG9ywc/UgHAsXwdUXtL1yMr8100P0dsHR4AJL+17R7R2fYhI7p
	iOD4wVYNs6XnaOlnP5uBz09+oC2MnUCNZg1piu2u7TN3nzzsZjaTb9C9WKxlu3FSqyG5GOPA==
X-Received: by 2002:a05:620a:46a6:b0:8c6:e22b:25f7 with SMTP id af79cd13be357-8c9eb1fc204mr1562950785a.18.1770068228565;
        Mon, 02 Feb 2026 13:37:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d61c6fsm1317392985a.47.2026.02.02.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:37:08 -0800 (PST)
Date: Mon, 2 Feb 2026 16:37:05 -0500
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
Message-ID: <aYEZAUJMLWvaug50@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-3-gourry@gourry.net>
 <20260202172524.00000c6d@huawei.com>
 <aYDmor_ruasxaZ-7@gourry-fedora-PF4VCD3F>
 <20260202184609.00004a02@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202184609.00004a02@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76094-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0B60D1B0D
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 06:46:09PM +0000, Jonathan Cameron wrote:
> > 
> > I can add a cleanup-patch prior to use the enum, but i don't think this
> > actually enables the compiler to do anything new at the moment?
> 
> Good point. More coffee needed (or sleep)
> 
> It lets sparse do some checking, but sadly only for wrong enum assignment.
> (Gcc has -Wenum-conversion as well which I think is effectively the same)
> I.e. you can't assign a value from a different enum without casting.
> 
> It can't do anything if people just pass in an out of range int.
> 

Which, after looking a bit... mm/memory_hotplug.c does this quite a bit
internally - except it uses a uint8_t

Example:

static int try_offline_memory_block(struct memory_block *mem, void *arg)
{
        uint8_t online_type = MMOP_ONLINE_KERNEL;
        uint8_t **online_types = arg;
	... snip ...
}

int offline_and_remove_memory(u64 start, u64 size)
{
        uint8_t *online_types, *tmp;
	... snip ...
        online_types = kmalloc_array(mb_count, sizeof(*online_types),
                                     GFP_KERNEL);
}

So that's fun.

I'm not sure it's worth the churn here, but happy to do it if there are
strong opinions.

---

David do you have thoughts here?

~Gregory

