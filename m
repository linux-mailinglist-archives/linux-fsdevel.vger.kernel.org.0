Return-Path: <linux-fsdevel+bounces-73437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 295D4D195BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFB9B301EC6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CE627E045;
	Tue, 13 Jan 2026 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SPc2JJKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17F280309
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313789; cv=none; b=hoRE5I2p5YFyoTrtNGs882NNtM7EWY8QIltm1xqnUPup/WHWrfRdFo4w7iC/rMY7IF6296gj5lR4/lPKQ7NuPIkSiyo47AwZSwmtz5+mDQtC+8mH0FjxVQJA2CHOcfe+ZkiP/vSEbnCxdFO7DnJZg9i/40Q9dr3TR3i7x7jZk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313789; c=relaxed/simple;
	bh=L8RKTSgZzn96TggX+YEpwMvvmrSwzzrKlYFGRXKLwfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbyzXcNMl2YcVI4Xsvcimey6H2G8XhcjfEhKT1tZlFnXLf1DhWrUWgYadiED78R8QgcDTmemyYXxUXNMpDMANfhP1CWTiUcGjlogPWMu9fO6maRkWoDXFKZHR6SalZgQhbJJbXnxCyK0idb6LaaAHhbt+Nd1Mu7VfFrgwpL26FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SPc2JJKa; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ba0d6c68a8so882592885a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768313787; x=1768918587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EA4FEA3d8sqza+07mct2btPiz1RY5DfLWXNlCi+Rawg=;
        b=SPc2JJKaFMa5z9jtGsClwMIJjee1JQTyEBNqKdkrc3uH9J+E/PabY7k7e4RsFS+nNe
         ygwe9iDzAihYKkBJvwP51qg3ZweUgRj4gW4bHr9bwmQ3xyiId1T0jj94vqPhnFu7fzYo
         E/FNpnJ2/4VUfRoAmUNf0huLGzScIFipAcrl7sT0TvRn4ISpK6/5heQn89bZ3dEYVpT4
         0m9JuZdvZf6ofqNhendiguV8rzdZSVy5RCIRDGP8+GaqRrinzSPIXT1QuKQcoxkPSBFV
         apbkp+Si0LNTWKy5r8+rtrdqWDvwTESHlC2wXBzYDSfNQm00tP9VlQMIy+5+uWW2F8oe
         5mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768313787; x=1768918587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EA4FEA3d8sqza+07mct2btPiz1RY5DfLWXNlCi+Rawg=;
        b=DjtzHL3J3P4zg8JT2Zj0Ymhb/K+aLcuGAb9ZYMWkK+jRmQUto4OoyNkBSmxuED/blt
         bbdnEV4L72S8/iFUNENSxDGIv/E0GKuMNpQq+4CLEDDO28vldsRLm+o6zORQYN9NcPGb
         U0+18vFAh82+7IElDwaH33r4uxlUh/0dOD8CKRnTv6FYmUYoQ50W9kjRiGl5rFPrQ+QX
         PCQ1QNGoX2rFKuZUDpD4JQMtRWpNwmnZOmIo0esjgKoDkQ0zrFP8K16VCEs4M6C4loAR
         TpYmn3uGAtyjJZ2t3qJv73ISza7HV+N16UCu+WKNz/hMsp9J3bxwIST+SWCnQmWdQWhW
         k1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQiPrJL8xEA+HOCTRBOHIjNbINPN0+EGIh+uQvtL/EGiPC/X0EugliH6IO+GdMU715Oywvl85N6iYO/l/c@vger.kernel.org
X-Gm-Message-State: AOJu0YySyeYuCDyDZfyxWoFgBFs4Q5EAegt2tuaoyWjquzcKIru/McFF
	3x4I6UODRiTNGYSKUVQZmotAVOD7daD60q1Eg7fZ+6D3vNnd4lEMsxYAITpnrv+7PpY=
X-Gm-Gg: AY/fxX4SDh/ZmXN5I6AooZ53PiNS+9JcFq8jC4v9chJafluwacer4pn5PvVN+OSAxgQ
	BiQC3IJ6UGW2gEVlpvxzQ6DxG8kNjT4C6jsXwgkODEKF09GL/04Q+VbHWpkeW7JMe9UNx8UvMW9
	2SxpGZYg8WcMAsFG5iGeqS5UyAPMgRjfpW0lMDhMBHN3j7a3B1WVJ4e8tp+B00oLD45KuDSGLxt
	CK/q/NwcXhr2P8z/GxghxRyixC2GObmIeMTNGljDUbwOYRYDK64LrKegUb1kxV3s5XpighRHN9Z
	W9ZFZd2niYGgB/iNFbVIN8FE0rrFNew2W4GBaDxljeM1ySfiXgP2gNofS7WsSm4mr4czF78vGlr
	ELV6eMeNFVnbjc6JPsmWka9RXz/MJJfzR/VFJpCaY9CSJN52V7pbMUIR3wRJ8D20vZ2AAMv2aIi
	pTpW+NH/OjjCf4m3E1NUMuDXh90wH58ml10PGAfAAajurZWszfV9MxBFXFwIhOY5rg3UVKwg==
X-Google-Smtp-Source: AGHT+IENvQu0lA+w8r7eNtBm9WUJ3/lNNLy7qp1W9GClRyOkBrOA+5+QqmRhEmTzN0zeeABQ2fhjWQ==
X-Received: by 2002:a05:622a:1823:b0:4e8:9704:7c83 with SMTP id d75a77b69052e-4ffb47d759bmr323881271cf.14.1768313786490;
        Tue, 13 Jan 2026 06:16:26 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d39230sm147458241cf.6.2026.01.13.06.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:16:21 -0800 (PST)
Date: Tue, 13 Jan 2026 09:15:43 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: Balbir Singh <balbirs@nvidia.com>, Yury Norov <ynorov@nvidia.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
Message-ID: <aWZTjzW54LMedKMH@gourry-fedora-PF4VCD3F>
References: <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
 <aWUs8Fx2CG07F81e@yury>
 <696566a1e228d_2071810076@dwillia2-mobl4.notmuch>
 <e635e534-5aa6-485a-bd5c-7a0bc69f14f2@nvidia.com>
 <696571507b075_20718100d4@dwillia2-mobl4.notmuch>
 <966ce77a-c055-4ab8-9c40-d02de7b67895@nvidia.com>
 <aWWGZVsY84D7YNu1@gourry-fedora-PF4VCD3F>
 <69659d418650a_207181009a@dwillia2-mobl4.notmuch>
 <aWWuU8xphCP_g6KI@gourry-fedora-PF4VCD3F>
 <6965b80a887d5_875d100b5@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6965b80a887d5_875d100b5@dwillia2-mobl4.notmuch>

On Mon, Jan 12, 2026 at 07:12:10PM -0800, dan.j.williams@intel.com wrote:
> Gregory Price wrote:
> > On Mon, Jan 12, 2026 at 05:17:53PM -0800, dan.j.williams@intel.com wrote:
> > > 
> > > I think what Balbir is saying is that the _PUBLIC is implied and can be
> > > omitted. It is true that N_MEMORY[_PUBLIC] already indicates multi-zone
> > > support. So N_MEMORY_PRIVATE makes sense to me as something that it is
> > > distinct from N_{HIGH,NORMAL}_MEMORY which are subsets of N_MEMORY.
> > > Distinct to prompt "go read the documentation to figure out why this
> > > thing looks not like the others".
> > 
> > Ah, ack.  Will update for v4 once i give some thought to the compression
> > stuff and the cgroups notes.
> > 
> > I would love if the ZONE_DEVICE folks could also chime in on whether the
> > callback structures for pgmap and hmm might be re-usable here, but might
> > take a few more versions to get the attention of everyone.
> 
> page->pgmap clobbers page->lru, i.e. they share the same union, so you
> could not directly use the current ZONE_DEVICE scheme. That is because
> current ZONE_DEVICE scheme needs to support ZONE_DEVICE mixed with
> ZONE_NORMAL + ZONE_MOVABLE in the same node.
> 
> However, with N_MEMORY_PRIVATE effectively enabling a "node per device"
> construct, you could move 'struct dev_pagemap' to node scope. I.e.
> rather than annotate each page with which device it belongs teach
> pgmap->ops callers to consider that the dev_pagemap instance may come
> from the node instead.

Hmmmmmmm... this is interesting.

should be able to do that cleanly with page_pgmap() and/or folio_pgmap()
and update direct accessors.

probably we'd want mildly different patterns for N_PRIVATE that does
something like

if (is_private_page(page)) {
	... send to private router ...
}

bool is_private_page(page) {
	pgdat = NODE_DATA(page_to_nid(page));
	return pgdat && pgdat->pgmap;

	/* or this, but seems less efficient */
	return node_state(page_to_nid, N_PRIVATE);
}

Then we can add all the callbacks to pgmap instead of dumping them in
node.c.  Shouldn't affect any existing users, since this doesn't
intersect with ZONE_DEVICE.

Technically you COULD have ZONE_DEVICE in N_PRIVATE, but that would be
per-page pgmap, and probably you'd have to have the private router
handle the is_device_page() pattern like everyone else does.

(Seems pointless though, feels like N_PRIVATE replaces ZONE_DEVICE for
 some use cases)

~Gregory

