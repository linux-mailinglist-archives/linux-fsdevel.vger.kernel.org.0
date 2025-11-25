Return-Path: <linux-fsdevel+bounces-69798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C46DCC85A2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 16:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1723351487
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BCD3271E7;
	Tue, 25 Nov 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="V9vxHUqW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A423218ADD
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083130; cv=none; b=O/n3c5/MnvQYgnBI44Hqjf5xkX+Jym0+YL2g5HmISk+sKMtILkxlowtAzK4J0uJj96jAww1aRk/GNuVvwnqDq5PvdxOMmp2sY5pbIwsVE7gRGYj/MvJQnKYbsAZHHyV25e8oH3QSiZEI2s7G17aAoZGYATg8vPLR1JmxnrjXI5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083130; c=relaxed/simple;
	bh=pjzHMxpUkO8Li3i8jQNI3TpiuWXXjBQIOqEQEY3Q07Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8jfmly41OrEANQsg9e57u7igR6tip4Jddj4XtWIi3GcUhTh5lqKEqQAf/TjIO5qo1LrWO1CIybXO0z5PAAzu6WSBaXHuotLyH/3EIVAJ69m8UdlVtPsj+DAa2z4+czIbVfTDqSrzS+6id6xDxG8qtDd/g8NU+/nIupySoNAB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=V9vxHUqW; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b0f54370ecso562664085a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 07:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1764083127; x=1764687927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ardSa1fh2pHETKiwXzwSN9Th9brxN1pF2dM3Ndqaang=;
        b=V9vxHUqWq85oWTzLG3IVlyTwxaUMmUd4TeFWrgX2RRt2sreWUaDiqybsI3MOFLyBQi
         YLLwk8zYXpFBJM49t+hfL1UUAHEjCQ72vkipD65+mDsOw9KRFJwcbGAX1wMk1TwNJspB
         AgCTHadnYF+CNwVtCRacRPRorqrdz6Q1B7K9vgZDR1wnq/OMM+jyYgx/81nnLx7Vba1N
         yQAQc1Vgig9FY2Xafy2fxVjmcJCw0HBmcwahdCfWMOkWwqweWBoc25WmTNCLwwMJts40
         Y196lEpmAOkrHYj6PWe5+vo61yqlkkxCWtZ0PHLRnqU3bTAQnvJxNLOpI/4wggpDdQz7
         NC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083127; x=1764687927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ardSa1fh2pHETKiwXzwSN9Th9brxN1pF2dM3Ndqaang=;
        b=NN0hD2naQr3vnsJ45zVzgxGP3Xv19mLwtIG9uTA6UMlgfSCYNPKNd+effCRpcoxWMH
         CvCVln4mt1KoS0mDyN+oi6WG9HECc7fS0nJMNqizUx0g3Tf1UF5MoVbzEyGkB6i/RLaG
         UZ5a2/FsCOwzOBrFTAinSUVBvncAzPcZdENwJmyYGCFveZfcqRcJtiFflFVJVKzvc1Et
         S5E4laoTU2OYeygQ6N3JyQAiIniLA1EU9dp3GxbC3bx7hDfDJy0gZzlNldTXddZm6DFA
         YAUyuTSyMgaX/t7c0/zgwT5nF3UZ+Erh1YjJv0f4saZe1n2eJA94xMC8NjSGWWlQ/dED
         iZ4w==
X-Forwarded-Encrypted: i=1; AJvYcCX2qV7cpNVclGH5QY+ftppHNYB2zExLN1et9mlQXK1MXu5dDq908Zfzci5GWLFpaf2y+rlx3EzLYcfR5cqC@vger.kernel.org
X-Gm-Message-State: AOJu0YxGKszOGE3YQewITzRXRSzt8LXT93fnQ0NFPNRNdUNJKXg2Kt29
	JCAo9wf1EJXU6870pGCpkyR9uCkSR1PILNFH9jbUJ4QF+emRJ5OHub76qc+EX6kDbjI=
X-Gm-Gg: ASbGncvWCfezD4YLcQSkgSX/hNc2bWSA7OMd0vfP05xYsCiKuXPMepIjFawyLY7sxxp
	xDntCauZbz+lIv0v0zuhhvCQxP7c4rxV7IafY/+9WvB3jXuncPOgUezUmHDRvCJoWnJleyGkxhC
	WSang9mY/2tdwhxERGsN4GitdWLX9zlOU3uEbswHgbhufvwBWIRIZckjJgvRu5/sfYfayNOPQpq
	BIO7KoniLxtmrH71AWk9r6vl33gPd8eG4oXV9gjf1N6R+SfVp3Tkc6Fa/YEOO3j/3kTiKeGpDHM
	G3M2Ap8gfDf1hYpybvimVRReMV0EE7OOL4w99YhehPiBSA/tK47RAmnImTYlZr0jOgLikWxBi1k
	pjMfwPlzEcDfKLDuvMYiJx58vcv8/NarZ48vihpDR5y+yJKQEx26YN3ZtXvdlhmCJDg4P838y0g
	/PxcJDfEfVNbyUpNUXNnS0uQJNjiPd4QH7LIX5ID12fkPSOKbxeGPRtWEs7RNtImQeFZiApQ==
X-Google-Smtp-Source: AGHT+IEFL/RZ3x9jACD+3qnEV8d73oOLgzxVvrrp/q6V+1ebLXwAT8RkswYTT3oWsjpBiQE2LKDSqw==
X-Received: by 2002:ac8:7c55:0:b0:4ee:1e63:a4e0 with SMTP id d75a77b69052e-4efbdb25399mr46248441cf.74.1764083126842;
        Tue, 25 Nov 2025 07:05:26 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295f2f6dsm1195203285a.54.2025.11.25.07.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:05:25 -0800 (PST)
Date: Tue, 25 Nov 2025 10:05:21 -0500
From: Gregory Price <gourry@gourry.net>
To: Kiryl Shutsemau <kirill@shutemov.name>
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
	ying.huang@linux.alibaba.com, apopple@nvidia.com, mingo@redhat.com,
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
Message-ID: <aSXFseE5FMx-YzqX@gourry-fedora-PF4VCD3F>
References: <20251112192936.2574429-1-gourry@gourry.net>
 <h7vt26ek4wzrls6twsveinxz7aarwqtkhydbgvihsm7xzsjiuz@yk2dltuf2eoh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h7vt26ek4wzrls6twsveinxz7aarwqtkhydbgvihsm7xzsjiuz@yk2dltuf2eoh>

On Tue, Nov 25, 2025 at 02:09:39PM +0000, Kiryl Shutsemau wrote:
> On Wed, Nov 12, 2025 at 02:29:16PM -0500, Gregory Price wrote:
> > With this set, we aim to enable allocation of "special purpose memory"
> > with the page allocator (mm/page_alloc.c) without exposing the same
> > memory as "System RAM".  Unless a non-userland component, and does so
> > with the GFP_SPM_NODE flag, memory on these nodes cannot be allocated.
> 
> How special is "special purpose memory"? If the only difference is a
> latency/bandwidth discrepancy compared to "System RAM", I don't believe
> it deserves this designation.
> 

That is not the only discrepancy, but it can certainly be one of them.

I do think, at a certain latency/bandwidth level, memory becomes
"Specific Purpose" - because the performance implications become so
dramatic that you cannot allow just anything to land there.

In my head, I've been thinking about this list

1) Plain old memory (<100ns)
2) Kinda slower, but basically still memory (100-300ns)
3) Slow Memory (>300ns, up to 2-3us loaded latencies)
4) Types 1-3, but with a special feature (Such as compression)
5) Coherent Accelerator Memory (various interconnects now exist)
6) Non-coherent Shared Memory and PMEM (FAMFS, Optane, etc)

Originally I was considering [3,4], but with Alistar's comments I am
also thinking about [5] since apparently some accelerators already
toss their memory into the page allocator for management.


Re: Slow memory --

   Think >500-700ns cache line fetches, or 1-2us loaded.

   It's still "Basically just memory", but the scenarios in which
   you can use it transparently shrink significantly.  If you can
   control what and how things can land there with good policy,
   this can still be a boon compared to hitting I/O.

   But you still want things like reclaim and compaction to run
   on this memory, and you still want buddy-allocation of this memory.

Re: Compression

  This is a class of memory device which presents "usable memory"
  but which carries stipulations around its use.

  The compressed case is the example I use in this set.  There is an
  inline compression mechanism on the device.  If the compression ratio
  drops to low, writes can get dropped resulting in memory poison.

  We could solve this kind of problem only allowing allocation via
  demotion and hack off the Write-bit in the PTE. This provides the
  interposition needed to fend-off compression ratio issues.

  But... it's basically still "just memory" - you can even leave it
  mapped in the CPU page tables and allow userland to read unimpeded.

  In fact, we even want things like compaction and reclaim to run here.
  This cannot be done *unless* this memory is in the page allocator,
  and basically necessitates reimplementing all the core services the
  kernel provides.

Re: Accelerators

  Alistair has described accelerators onlining their memory as NUMA
  nodes being an existing pattern (apparently not in-tree as far as I
  can see, though).

  General consensus is "don't do this" - and it should be obvious
  why.  Memory pressure can cause non-workload memory to spill to
  these NUMA nodes as fallback allocation targets.

  But if we had a strong isolation mechanism, this could be supported.
  I'm not convinced this kind of memory actually needs core services
  like reclaim, so I will wait to see those arguments/data before I
  conclude whether the idea is sound.


>
> I am not in favor of the new GFP flag approach. To me, this indicates
> that our infrastructure surrounding nodemasks is lacking. I believe we
> would benefit more by improving it rather than simply adding a GFP flag
> on top.
> 

The core of this series is not the GFP flag, it is the splitting of
(cpuset.mems_allowed) into (cpuset.mems_allowed, cpuset.sysram_nodes)

That is the nodemask infrastructure improvement.  The GFP flag is one
mechanism of loosening the validation logic from limiting allocations
from (sysram_nodes) to including all nodes present in (mems_allowed).

> While I am not an expert in NUMA, it appears that the approach with
> default and opt-in NUMA nodes could be generally useful. Like,
> introduce a system-wide default NUMA nodemask that is a subset of all
> possible nodes.

This patch set does that (cpuset.sysram_nodes and mt_sysram_nodemask)

> This way, users can request the "special" nodes by using
> a wider mask than the default.
> 

I describe in the response to David that this is possible, but creates
extreme tripping hazards for a large swath of existing software.

snippet
'''
Simple answer:  We can choose how hard this guardrail is to break.

This initial attempt makes it "Hard":
   You cannot "accidentally" allocate SPM, the call must be explicit.

Removing the GFP would work, and make it "Easier" to access SPM memory.

This would allow a trivial 

   mbind(range, SPM_NODE_ID)

Which is great, but is also an incredible tripping hazard:

   numactl --interleave --all

and in kernel land:

   __alloc_pages_noprof(..., nodes[N_MEMORY])

These will now instantly be subject to SPM node memory.
'''

There are many places that use these patterns already.

But at the end of the day, it is preference: we can choose to do that.

> cpusets should allow to set both default and possible masks in a
> hierarchical manner where a child's default/possible mask cannot be
> wider than the parent's possible mask and default is not wider that
> own possible.
> 

This patch set implements exactly what you describe:
   sysram_nodes = default
   mems_allowed = possible

> > Userspace-driven allocations are restricted by the sysram_nodes mask,
> > nothing in userspace can explicitly request memory from SPM nodes.
> > 
> > Instead, the intent is to create new components which understand memory
> > features and register those nodes with those components. This abstracts
> > the hardware complexity away from userland while also not requiring new
> > memory innovations to carry entirely new allocators.
> 
> I don't see how it is a positive. It seems to be negative side-effect of
> GFP being a leaky abstraction.
> 

It's a matter of applying an isolation mechanism and then punching an
explicit hole in it.  As it is right now, GFP is "leaky" in that there
are, basically, no walls.  Reclaim even ignored cpuset controls until
recently, and the page_alloc code even says to ignore cpuset when 
in an interrupt context.

The core of the proposal here is to provide a strong isolation mechanism
and then allow punching explicit holes in it.  The GFP flag is one
pattern, I'm open to others.

~Gregory

