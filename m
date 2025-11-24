Return-Path: <linux-fsdevel+bounces-69695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 012BCC815D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 16:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B75BB34A3CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12169314D14;
	Mon, 24 Nov 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cc29oQnE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD0314D12
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763998111; cv=none; b=kMGRvsf0LaUz0XiuEvmNXifUu6LT17somvQ5fzVOHLxn+CKHN943LgHB0WyKT1TGzM8r1UaZfQdc4B/b8dbcXiSvcXsli09dlSAczKWcgcTVgouc3/uzfDXLn+seAEQ7oTo+NUyyRc3+n+PF8YTZiWrwSqso5MHv2EWm2dnAJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763998111; c=relaxed/simple;
	bh=e7umUecNMkT5NIFhgt8CWZQ7TyVGwODRnftqlFBtnJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnJn/bGK6Gp8lT/9YQ1DIuml1h+bi2f3PAY+jZI+xllVE4ETjVd8A5mEIbcK10q9tVi2jrYklcMGdgCgzMxeuqaUdUXPyEp9Lizr5uOYNwK/GXyGHLdKrfNT/vGab7Gw8xIPJrY7pMwjQildFbDY6AWxhzCenGHtcf1CZFSopag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cc29oQnE; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6430834244aso1715106d50.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 07:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1763998108; x=1764602908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmvwb/YqLsu0y+cxhnZ07KM1iGl9RhSbLvXeq5B7c8s=;
        b=cc29oQnEhRT6CbYNfkpLXsssu8DlJUZNo/wghRIYnvRxFwEO/evTZtymBpqaVUl5SK
         ma1KeTPXm8tbbtzQBiMThDA6F889ulQhDqcnWx5mm7fTUu46xWlgg7lr6Iv3hZagFzSe
         CUzh1yn2c+u+VG8M9W5hvNANPXU7Pc3d9s7wep/sMfxA7M38VeXLCq53lM3Goz8o3+JD
         pY8C11pKhw0FFLx30udvepqepVVJ3E70I+pJzlLdraeb8vOWSGERYA8tRPZvbtSB+1H6
         JPFPWBA+QldxFlrDr+h4V6lhGqb5KFL+rSyyT+BPcU7R4UXXn/QGHnpf6QAYPAbdB3Dm
         /NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763998108; x=1764602908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmvwb/YqLsu0y+cxhnZ07KM1iGl9RhSbLvXeq5B7c8s=;
        b=Vc1O4Ho0dIz54M2m/uOWWHTWwOjlN++OT8jAakwW+//A5LTGLUeSBxTl8PIV15DkeZ
         1hfRR5cVwaUcrwTy9xqpx5VOsGyCY/PKKr3KXz2WItotsp0sVJLRovPsNMqg4NnuDl4E
         2eaQOs6A15VPyB8RGG7fYzYPA85djGXgj2hN/kAGG/wexJO1Q98jWPr+e+yVy2wIFRim
         KlKYeULYJRzZ9EJp85eRd/jm4DOcwjQx0WIWFYKRTPGNMVe9rY9EA5YNiB/a9kOpLH/4
         w863OZwp0qWUxYrnXdZf6YKZrl26AiUF3FnQNkfXLenYksUW5XE3aVe8pq2OTX7WOve4
         eq6A==
X-Forwarded-Encrypted: i=1; AJvYcCUn6biFBu7cnzSlOidhxiuTAiw6AtZh0N9HEHUJP1jvhZmKfo7GdM6GNyTFVTe1h7N4zTEcyfafW0aLJ5RV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuq7jfZ8rJDFSx0EQeHM06+/thxMk1ebwHM0pkxshICQfAXI2w
	u8ZxX5xks9nyJlwoaY8RAaLi0sTyVPsKDwHFYZceew/Nj1CLZOjDPPCnoLuXqNPyuko=
X-Gm-Gg: ASbGncvE+uuoXsNoTAa/xacomMeoUr635bJ7/+2ypDd1/yj6PsHPtfvl//HMFp3eTkd
	f8XKN6+ZKQzDs4b/izWGqRG+7V5W7yWMxGB8G420OAVizhBH2NI4J8O8ZiwJlSI7+t+WFLlWQw2
	r4GoBKuw2vaPNkYnUW9l1fYHAGN/GxPLAb7RkyHAI8GM28vLOZqddY68Zsr8heowdCQy5nWqZDk
	dthA/LxGOFkvGnoQk8K4/Ve4Bmih5nReTQbnY7dlCFOg++4PO9zU7KEiS5SU058FoleMm40SbA1
	pq7aPBU8fvgQPJnP66wNmZxlrsc77k2trP5/LiNo2CoZLQlXrrPbJKkuwJAAk1ArpTIiEhh8kz+
	q5rg/oIlHWzDlsvQ3X0sLNFc+tNrgE93JRfoXB7JorVz6AkydA8FDy/GushxcL4xFyPTMzPIOzN
	Iy0ic+LAQ=
X-Google-Smtp-Source: AGHT+IF2wNBmZkbTfngTULZjgnH8cbmz94buOftiW7SxjvwrErr131yc1azbjD5qkix9lvoC5B3wPQ==
X-Received: by 2002:a05:690e:158d:20b0:641:f5bc:68d0 with SMTP id 956f58d0204a3-64302ad80f8mr6454834d50.77.1763998108057;
        Mon, 24 Nov 2025 07:28:28 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:62f9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-642f718bbbesm5022280d50.21.2025.11.24.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:28:27 -0800 (PST)
Date: Mon, 24 Nov 2025 08:28:23 -0700
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
Message-ID: <aSR5l_fuONlCws8i@gourry-fedora-PF4VCD3F>
References: <20251112192936.2574429-1-gourry@gourry.net>
 <aktv2ivkrvtrox6nvcpxsnq6sagxnmj4yymelgkst6pazzpogo@aexnxfcklg75>
 <aSDUl7kU73LJR78g@gourry-fedora-PF4VCD3F>
 <c5enwlaui37lm4uxlsjbuhesy6hfwwqbxzzs77zn7kmsceojv3@f6tquznpmizu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5enwlaui37lm4uxlsjbuhesy6hfwwqbxzzs77zn7kmsceojv3@f6tquznpmizu>

On Mon, Nov 24, 2025 at 10:09:37AM +1100, Alistair Popple wrote:
> On 2025-11-22 at 08:07 +1100, Gregory Price <gourry@gourry.net> wrote...
> > On Tue, Nov 18, 2025 at 06:02:02PM +1100, Alistair Popple wrote:
> > > 
> 
> There are multiple types here (DEVICE_PRIVATE and DEVICE_COHERENT). The former
> is mostly irrelevant for this discussion but I'm including the descriptions here
> for completeness.
> 

I appreciate you taking the time here.  I'll maybe try to look at
updating the docs as this evolves.

> > But I could imagine an (overly simplistic) pattern with SPM Nodes:
> > 
> > fd = open("/dev/gpu_mem", ...)
> > buf = mmap(fd, ...)
> > buf[0] 
> >    1) driver takes the fault
> >    2) driver calls alloc_page(..., gpu_node, GFP_SPM_NODE)
> >    3) driver manages any special page table masks
> >       Like marking pages RO/RW to manage ownership.
> 
> Of course as an aside this needs to match the CPU PTEs logic (this what
> hmm_range_fault() is primarily used for).
>

This is actually the most interesting part of series for me.  I'm using
a compressed memory device as a stand-in for a memory type that requires
special page table entries (RO) to avoid compression ratios tanking
(resulting, eventually, in a MCE as there's no way to slow things down).

You can somewhat "Get there from here" through device coherent
ZONE_DEVICE, but you still don't have access to basic services like
compaction and reclaim - which you absolutely do want for such a memory
type (for the same reasons we groom zswap and zram).

I wonder if we can even re-use the hmm interfaces for SPM nodes to make
managing special page table policies easier as well.  That seems
promising.

I said this during LSFMM: Without isolation, "memory policy" is really
just a suggestion.  What we're describing here is all predicated on
isolation work, and all of a sudden much clearer examples of managing
memory on NUMA boundaries starts to make a little more sense.

> >    4) driver sends the gpu the (mapping_id, pfn, index) information
> >       so that gpu can map the region in its page tables.
> 
> On coherent systems this often just uses HW address translation services
> (ATS), although I think the specific implementation of how page-tables are
> mirrored/shared is orthogonal to this.
>

Yeah this part is completely foreign to me, I just presume there's some
way to tell the GPU how to recontruct the virtually contiguous setup.

That mechanism would be entirely reusable here (I assume).

> This is roughly how things work with DEVICE_PRIVATE/COHERENT memory today,
> except in the case of DEVICE_PRIVATE in step (5) above. In that case the page is
> mapped as a non-present special swap entry that triggers a driver callback due
> to the lack of cache coherence.
> 

Btw, just an aside, Lorenzo is moving to rename these entries to
softleaf (software-leaf) entries. I think you'll find it welcome.
https://lore.kernel.org/linux-mm/c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com/

> > Driver doesn't have to do much in the way of allocationg management.
> > 
> > This is probably less compelling since you don't want general purposes
> > services like reclaim, migration, compaction, tiering - etc.  
> 
> On at least some of our systems I'm told we do want this, hence my interest
> here. Currently we have systems not using DEVICE_COHERENT and instead just
> onlining everything as normal system managed memory in order to get reclaim
> and tiering. Of course then people complain that it's managed as normal system
> memory and non-GPU related things (ie. page-cache) end up in what's viewed as
> special purpose memory.
> 

Ok, so now this gets interesting then.  I don't understand how this
makes sense (not saying it doesn't, I simply don't understand).

I would presume that under no circumstance do you want device memory to
just suddenly disappear without some coordination from the driver.

Whether it's compaction or reclaim, you have some thread that's going to
migrate a virtual mapping from HPA(A) to HPA(B) and HPA(B) may or may not
even map to the same memory device.

That thread may not even be called in the context of a thread which
accesses GPU memory (although, I think we could enforce that on top
of SPM nodes, but devil is in the details).

Maybe that "all magically works" because of the ATS described above?

I suppose this assumes you have some kind of unified memory view between
host and device memory?  Are there docs here you can point me at that
might explain this wizardry?  (Sincerely, this is fascinating)

> > The value is clearly that you get to manage GPU memory like any other
> > memory, but without worry that other parts of the system will touch it.
> > 
> > I'm much more focused on the "I have memory that is otherwise general
> > purpose, and wants services like reclaim and compaction, but I want
> > strong controls over how things can land there in the first place".
> 
> So maybe there is some overlap here - what I have is memoy that we want managed
> much like normal memory but with strong controls over what it can be used for
> (ie. just for tasks utilising the processing element on the accelerator).
> 

I think it might be great if we could discuss this a bit more in-depth,
as i've already been considering very mild refactors to reclaim to
enable a driver to engage it with an SPM node as the only shrink target.

This all becomes much more complicated due to per-memcg LRUs and such.

All that said, I'm focused on the isolation / allocation pieces first.
If that can't be agreed upon, the rest isn't worth exploring.

I do have a mild extension to mempolicy that allows mbind() to hit an
SPM node as an example as well.  I'll discuss this in the response to
David's thread, as he had some related questions about the GFP flag.

~Gregory


