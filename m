Return-Path: <linux-fsdevel+bounces-68935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0140C68E01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 456A1347FCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E37338592;
	Tue, 18 Nov 2025 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="u5ET/t0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A181C5D6A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462219; cv=none; b=hN583hkK7U7s9yEnJzAIFItf4bkYlxokJVa7HWteobglON4b0jiNAxvh7dlbUs1LoQZyKxOFZo2Q49HvfJfHzcd3WVwv2sE2ZdMu5G6k90lxBhzBFdKQyKXDMNaPry0i463ID4D91RpAbntIkYSNdxsW2TfH7de22gCP2CCRNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462219; c=relaxed/simple;
	bh=n9vlPUa0RZdNDYkpD1WuwTh/G9Vi0s80rppCl0dir8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQlDZ5hoq6kjxZMA8HUlxoMj0fxKLII1lR40xCPINlagzmWoeM1WNBm7K4bavaZNPdorGE5jGg1sIzbVEx1aR1iljvh74n9JsV9hNWdWKT3THmtWSGI2WvHQ35BwOT5tlrgS8MxrLoI1J7HNwiuxjE6FbWrx+ETG9W5og+N2yQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=u5ET/t0z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so23947675e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 02:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1763462215; x=1764067015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QW3YrzLI1OSdQK0hkzbyW5ur3dKrb2BxfDVA3CM9uI=;
        b=u5ET/t0zmcZkIje6lURTeWI9QJRvjHSu5BeJ+B9nVVwsEGFVZQ/GG3ryKQtl/MX8CZ
         RwSfpz+8GBM5KUXlYV/WQ2ISL+J+CgB8c7JK2RFGJFlT5nCs8P98Uf6RKlMDB2yyFIgk
         tlOa9aQSFItAwO7cPC4mMNrlMP+Jpo6gCnTl2LgRPibf+1oJ4kdOEhmH35uoSi7SeTty
         LGQ92KKiuKICivueun0soCB5FYdQLjwKMa8Qp8V8Fj5HOZ9xC8krzaF58sqKE+eMB+56
         mEs1CQyiFJOIfODB9LOnmojrAPCevYOWeZ+uN5642ECjoEV1M9fSepZhBdCNqhZZ3Nke
         K0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763462215; x=1764067015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QW3YrzLI1OSdQK0hkzbyW5ur3dKrb2BxfDVA3CM9uI=;
        b=EAXYfJPv9Z4ghSJExwLrY9qQAvexLI5UbQVX+/HRbbt4r8an5HjTfMKozCrW+DmGvW
         8UVv9aRyx+xiqhF4fTBxudIKtZbAzF0ifOrzjzE/GwXmoRkzCiNdvXKjMeMmJxstRCjp
         otC96nydqQDqjN+XBkjW2Bb7bmrlIkddsrxfT4Er/b2uFMx87qia8+r7sAL2YDAV5J+2
         n5rPS3ObND3ggE6MAss2LpdbVBJbq5WPmc0Sc29qa6HNy4G71M2W3k4tAV8htYS/D3au
         tMZG4ME/sX7AOguaRxjUKzkwPzJUzC7ToQwMwTT4rC7/QgGlwudpb1nOMcEWZ3cebdTX
         1EBw==
X-Forwarded-Encrypted: i=1; AJvYcCVEGLcYTiE/E/iN2u08ofbdm6LjWmvYfunqepX77QLWh9ey18z8GfvX40o12Djn3b/9UCeoQyuSxXjBpe//@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/aYGiiZD1ywE2ko08jht/fT2LBOvgiHh2SPXDZ4c10UYqPLQ
	nLmfmTQkQQ1ibZ44matrJltRHfT8KTdKMSzjhOoW46/Xgg4HU8e+HYmUoOTLrCSeEpQ=
X-Gm-Gg: ASbGncsVeKLG1RfsVEZYscouNpPKE3szPdo6kVLnbEhnSZ5urAeS1i/34Xke4MdGd0n
	KjpkD9+z5Bj0rqTpHmfmDvdswBw0VGYh6/UISVU5YuBahgTSWZcj8xOBmjWWs3rfmvI0ivYCvz9
	RPmTZmJNT453kqqF7yG1HYmYDL9P+Hb6QG64Z0E8CLX1rJX9Hpyhy4A26xCKGk8nKaOlbRRUWw/
	Oh1Z6U7XEmzx8dxoDQORTUTjYv6hoMp1vR9jFPNQw1XEb9NAxkoh0YcAegi9OEopwJGMEPrt7Aw
	5x8ZWwpxQ8/RSX16o+KsplKY6jZR/RvFKCauWoc+2NUI6Fd7qBGTi2VodVcQWnzzotnQAEnScjs
	V+lZow6bU4VBn5mWqYi1jkcXLIpBO6DXM9Hn2gbZxG3fN8qXBkgHt0jl2MZAkeeyk0cms3PTeaX
	AEsMd0Odss
X-Google-Smtp-Source: AGHT+IHcPSG42oTSue/l29JNxRqWkMjwCuc7Im45XklO36HK61beZa9KMPscvjf0ZVFq7e39VGxhYw==
X-Received: by 2002:a05:600c:350d:b0:475:dd59:d8d8 with SMTP id 5b1f17b1804b1-4778fe4f716mr149402675e9.8.1763462214605;
        Tue, 18 Nov 2025 02:36:54 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::4:7772])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779527235esm219825575e9.8.2025.11.18.02.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:36:53 -0800 (PST)
Date: Tue, 18 Nov 2025 04:36:47 -0600
From: Gregory Price <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, kees@kernel.org, muchun.song@linux.dev,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	rientjes@google.com, jackmanb@google.com, cl@gentwo.org,
	harry.yoo@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com, rrichter@amd.com,
	ming.li@zohomail.com, usamaarif642@gmail.com, brauner@kernel.org,
	oleg@redhat.com, namcao@linutronix.de, escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC LPC2026 PATCH v2 00/11] Specific Purpose Memory NUMA Nodes
Message-ID: <aRxMP_wDRxJIhIiB@gourry-fedora-PF4VCD3F>
References: <20251112192936.2574429-1-gourry@gourry.net>
 <aktv2ivkrvtrox6nvcpxsnq6sagxnmj4yymelgkst6pazzpogo@aexnxfcklg75>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aktv2ivkrvtrox6nvcpxsnq6sagxnmj4yymelgkst6pazzpogo@aexnxfcklg75>

On Tue, Nov 18, 2025 at 06:02:02PM +1100, Alistair Popple wrote:
> On 2025-11-13 at 06:29 +1100, Gregory Price <gourry@gourry.net> wrote...
> > - Why? (In short: shunting to DAX is a failed pattern for users)
> > - Other designs I considered (mempolicy, cpusets, zone_device)
> 
> I'm interested in the contrast with zone_device, and in particular why
> device_coherent memory doesn't end up being a good fit for this.
>

I did consider zone_device briefly, but if you want sparse allocation
you end up essentially re-implementing some form of buddy allocator.

That seemed less then ideal, to say the least.

Additionally, pgmap use precludes these pages from using LRU/Reclaim,
and some devices may very well be compatible with such patterns.

(I think compression will be, but it still needs work)

> > - Why mempolicy.c and cpusets as-is are insufficient
> > - SPM types seeking this form of interface (Accelerator, Compression)
> 
> I'm sure you can guess my interest is in GPUs which also have memory some people
> consider should only be used for specific purposes :-) Currently our coherent
> GPUs online this as a normal NUMA noode, for which we have also generally
> found mempolicy, cpusets, etc. inadequate as well, so it will be interesting to
> hear what short comings you have been running into (I'm less familiar with the
> Compression cases you talk about here though).
> 

The TL;DR:

cpusets as-designed doesn't really allow the concept of "Nothing can
access XYZ node except specific things" because this would involve
removing a node from the root cpusets.mems - and that can't be loosened.

mempolicy is more of a suggestion and can be completely overridden. It
is entirely ignored by things like demotion/reclaim/etc.

I plan to discuss a bit of the specifics at LPC, but a lot of this stems
from the zone-iteration logic in page_alloc.c and the rather... ermm...
"complex" nature of how mempolicy and cpusets interacts with each other.

I may add some additional notes on this thread prior to LPC given that
time may be too short to get into the nasty bits in the session.

> > - Platform extensions that would be nice to see (SPM-only Bits)
> > 
> > Open Questions
> > - Single SPM nodemask, or multiple based on features?
> > - Apply SPM/SysRAM bit on-boot only or at-hotplug?
> > - Allocate extra "possible" NUMA nodes for flexbility?
> 
> I guess this might make hotplug easier? Particularly in cases where FW hasn't
> created the nodes.
>

In cases where you need to reach back to the device for some signal, you
likely need to have the driver for that device manage the alloc/free
patterns - so this may (or may not) generalize to 1-device-per-node.

In the scenario where you want some flexibility in managing regions,
this may require multiple nodes for device.  Maybe one device provides
multiple types of memory - you want those on separate nodes.

This doesn't seem like something you need to solve right away, just
something for folks to consider.

> > - Should SPM Nodes be zone-restricted? (MOVABLE only?)
> 
> For device based memory I think so - otherwise you can never gurantee devices
> can be removed or drivers (if required to access the memory) can be unbound as
> you can't migrate things off the memory.
> 

Zones in this scenario are bit of a square-peg/round-hole.  Forcing
everything in ZONE_MOVABLE means you can't do page pinning or things
like 1GB gigantic pages.  But the device driver should be capable of
managing hotplug anyway, so what's the point of ZONE_MOVABLE? :shrug:

> > The ZSwap example demonstrates this with the `mt_spm_nodemask`.  This
> > hack treats all spm nodes as-if they are compressed memory nodes, and
> > we bypass the software compression logic in zswap in favor of simply
> > copying memory directly to the allocated page.  In a real design
> 
> So in your example (I get it's a hack) is the main advantage that you can use
> all the same memory allocation policies (eg. cgroups) when needing to allocate
> the pages? Given this is ZSwap I guess these pages would never be mapped
> directly into user-space but would anything in the design prevent that? 

This is, in-fact, the long term intent. As long as the device can manage
inline decompression with reasonable latencies, there's no reason you
shouldn't be able to leave the pages mapped Read-Only in user-space.

The driver would be responsible for migrating on write-fault, similar to
a NUMA Hint Fault on the existing transparent page placement system.

> For example could a driver say allocate SPM memory and then explicitly
> migrate an existing page to it?

You might even extend migrate_pages with a new flag that simply drops
the write-able flag from the page table mapping and abstract that entire
complexity out of the driver :]

~Gregory

