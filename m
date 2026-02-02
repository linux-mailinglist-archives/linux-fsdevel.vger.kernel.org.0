Return-Path: <linux-fsdevel+bounces-76070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGvzD+7igGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:46:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 912AACFBD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7B443064E8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 17:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5413803FF;
	Mon,  2 Feb 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Sx5Ofipm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB237D136
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054096; cv=none; b=Crn1LBhlYqpPYVoy0O+644DPFHhG1QUhbVAaCjl0PIiOEYPskD3fpxH+3cEH3XTQsg0/yJOZTZ6a1NJSaMpmvTkqoAHVJSKa0bM/fRvGgwpmbHBl0y9lVBn+TqPEKA/kj1AarNy7xzk779/LWP6WwYgBgO7idifimrYYzcYbK+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054096; c=relaxed/simple;
	bh=NvSchrP/3iqVAPZQcFrmz3WZ5MlQLRFV2NZ/1rw7880=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBUscuQKW34Wrabq0mza6nHm824D1QcnztTGQk+3rDyPZHOTCNiPywZhnu9N4NUjYd4v/mT7iZ8318+7uS73YZDmkMB6837iQjDbCE1eutbGpS++97ypDu0Ma3Jx2jU/gKbqR1OeSIH8qeiiTCjfaj5WM2ZFDH8QcJg7t/HI8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Sx5Ofipm; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-894774491deso60376206d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770054094; x=1770658894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6OBDEWLEmHCzYPUVrTciErMQbNpqUwuoibpvHtq101E=;
        b=Sx5OfipmZy6VSguN3UfYogDNou/OpbG+PH0pl1nyOXT/V88T3HqakBgwdFYC+dChwy
         KrfUKFMnK+VPp7SscQaJqHz4Y1qi1pb+EvNbv1A1I5UJQHVApan8h2NlPs3kwrOopt7r
         y4Lw6oGg2jS1pmfG6ekVvTRmo1L8kOib4WH3udiGLUpqz4qCYg1VIrNNkZTKubhK3gpn
         Gqb3MfSjSna1InoYN45/s0i9wis222PsHOK/zHXWJ/1KC87XnaGFrbkvmpO9/P7YEWQp
         YWEWbmhF3jHygOmg1Fc0fuEVSOIRe+4Brv/7e6Hn1ooqZ8FZV4enITWnxGAtd7lEOO37
         04dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770054094; x=1770658894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OBDEWLEmHCzYPUVrTciErMQbNpqUwuoibpvHtq101E=;
        b=M5ZA3If7VE89xE/23AXzSpz3aHyqSp50ahY8pFGnquK60wp+yqrgGK1+HG3KRRjffZ
         v83vDJrLwHU9WvWS0shFwOd7UNel+Cg02ZewJYe1wxIOfSL/8a/uYh4qhETuQGiKVQiC
         oOOM1hq8e7qQPw/qLpf42tf2yEbs5RQga/PWy1cxpe4I/ti1pcOh7KnT5X1Kgm5gdX9g
         5FtEWgbCMz29ewh3N4FYOO9K8bzF9fJkwouWD/VicXXYpCryPqwvjL1Vv1WlcwsbT/t2
         kjB7BYlt61X3dKN1ZMpnGKKQjhejJ/5Cpy2NYusZrvcsBXBZoeDWxiGUL7VOVw+mb7ES
         EHFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3/H32peERmO78BWx80FY6mzBlgewwopt1ozCfPwuXMgEvm69e3KsJ9XVreW2Uor6cLF1qXmtRhQZcEJom@vger.kernel.org
X-Gm-Message-State: AOJu0YydnYDSLx9xONbILMrRs1w4iqw6ElZD71KKTg0E5KNDWy2Uu+jj
	c1mKw2gyIvq+oNZPGmrTtOCYwVq1g3a6Mh+wVi1FZhsyqdRkchTJMLutQ7i3VKrNpHs=
X-Gm-Gg: AZuq6aIyVeY8tplc2h2sv78n73qg5h2hq4aqkM4bnlg5xnInmxKgmf9rP0OK9ALRzdJ
	u9cN+hVV2pMsF8NXvO4Gp/cDnlD85zNMn1yvk8qFS/0SgHRjaXLylAmTjty2Wl0JzsOMBMXhtdO
	i4hF+Vr6x294ekDTfRRuZPetnXDbk62HHB6+5sgPbDWh1Z5g8UWJ36cgnTJQeM1CT4LBRS54RIr
	nCaq/LX2FCwkmIECR7XMyhMLW8pv98VHYVtlCkHOIjrtz7u02zzFvkz4NqNxY8ixdeWmsJNUtNS
	+8hUVGhsk3RLMi6jS97cmYcFNE//mgE9Efzf75ydDu+IKbi+6WhFOeCbR54slwpyCkAoO8Tyty4
	+MeGcMkZf7C5Z1nBt7kCbLL8/uxSmCdGeqrhqN8aKsb9SLnDJjQGpbu1DBzx4a1K+B0aYjxzsZE
	IiV23gfbOOuBd8mb4rDGzInDSozofD1PVG70enqfapdTLR+RBfRMIl5Mvi7yAWR0nvl0s8ldTkD
	w2tP5DX
X-Received: by 2002:a05:6214:20ae:b0:894:7fa3:7a32 with SMTP id 6a1803df08f44-894ea0f90c0mr191291886d6.68.1770054094267;
        Mon, 02 Feb 2026 09:41:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7c789sm1274632885a.7.2026.02.02.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:41:33 -0800 (PST)
Date: Mon, 2 Feb 2026 12:41:31 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, willy@infradead.org,
	jack@suse.cz, terry.bowman@amd.com, john@jagalactic.com
Subject: Re: [PATCH 8/9] cxl/core: Add dax_kmem_region and sysram_region
 drivers
Message-ID: <aYDhyxjzKtbqFWdM@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-9-gourry@gourry.net>
 <c1d7d137-b7c2-4713-8ca4-33b6bc2bea2b@amd.com>
 <aX0s4i5OqFhHkEUp@gourry-fedora-PF4VCD3F>
 <9652a424-6eb1-462f-8cbd-181af880f98b@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9652a424-6eb1-462f-8cbd-181af880f98b@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76070-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:dkim]
X-Rspamd-Queue-Id: 912AACFBD0
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:02:37AM -0600, Cheatham, Benjamin wrote:
> > 
> > For auto-regions:
> >    region_probe() eats it and you get the default behavior.
> > 
> > For non-auto regions:
> >    create_x_region generates an un-configured region and fails to probe
> >    until the user commits it and probes it.
> 
> I think this was the source of my misunderstanding. I was trying to understand how it
> works for auto regions when it's never meant to apply to them.
> 
> Sorry if this is a stupid question, but what stops auto regions from binding to the
> sysram/dax region drivers? They all bind to region devices, so I assume there's something
> keeping them from binding before the core region driver gets a chance.
> 

Auto regions explicitly use the dax_kmem path (all existing code,
unchanged)- which auto-plugs into dax/hotplug.

I do get what you're saying that everything binds on a region type,
I will look a little closer at this and see if there's something more
reasonable we can do.

I think i can update `region/bind` to use the sysram driver with
   online_type=mhp_default_online_type

so you'd end up with effective the auto-region logic:

cxlcli create-region -m ram ... existing argument set
------
    echo region0 > create_ram_region
    /* program decoders */
    echo region0 > region/bind
    /* 
     * region_bind():
     *    1) alloc sysram_region object
     *    2) sysram_regionN->online_type=mhp_default_online_type()
     *    3) add device to bus
     *    4) device auto-probes all the way down to dax
     *    5) dax auto-onlines with system default setting
     */
------

and Non-auto-region logic (approximation)

cxlcli creation-region -m ram --type sysram --online-type=movable
-----
   echo region0 > create_ram_region
   /* program decoders */
   echo region0 > sysram/bind
   echo online_movable > sysram_region0/online_type
   echo sysram_region0 > dax_kmem/bind
-----


I want to retain the dax_kmem driver because there may be multiple users
other than sysram.   For example, a compressed memory region wants to
utilize dax_kmem, but has its own complex policy (via N_MEMORY_PRIVATE)
so it doesn't want to abstract through sysram_region, but it does want
to abstract through dax_kmem.

weeeee "software defined memory" weeeee

~Gregory

