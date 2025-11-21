Return-Path: <linux-fsdevel+bounces-69463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643A1C7BB7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 22:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470A83A72D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 21:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62B02F532D;
	Fri, 21 Nov 2025 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bVeAkH0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CC276049
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763759270; cv=none; b=oR/kl+PpWCMd6zgJ20VPCHFIsMW8l+PwBHTvMI5lE+kY3InWLX7oooaaF3DsJS7yVsbX8iux5mOrgaZG2OJE03/eFtkxlrQdsZJp/oK0u3MZ/DK4HiRWLzSOUxt8JXahg3Y3pOMth32EHUkwW0ufo1bEl77I0Ymf85IFPfoigcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763759270; c=relaxed/simple;
	bh=shSHymcVpVsJRS3DnGEq5zOC8PBxp/thlGXIe4I1Liw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSIkwuK+N/2zRt0FL0p0Fu/JTHsabCnbOdfwFJe0ws5XNL2+cE5S1lGZSR1ZylEaMa31GE3VV9GRln2cbRBgJMQc2PN1mGbG/PbePlbcbcjgDqjumyQK38yt3PMY1c4W0xqO4zu9UMUd6vs2rIJ+8cBk+DkKpVPh/Kb373qGD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bVeAkH0S; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee257e56aaso22882111cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 13:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1763759267; x=1764364067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Svi+I8ywJ8k5uxtzxqjpEGX4Qh9Fr5IeUT/6ziPIoB4=;
        b=bVeAkH0Shdp0h8OjS5YQFosmUq1UbuAiSCtBpKGJd649mntc47dWELhSOTZQnaOAjK
         BCY4D7BXJ5i1hsC1fClTm4PszJCglfGik5ovY+CoJ8ktPXIJO8jpUKKTbvCX2WfqGRw3
         bA2H1a0CPlPAyhgwrhn0KSEAyGZt4e+MOmXefgJHOtptodjnXiUQIK0cE/uB+C1MmOj6
         9Vv3N5ZkdIweoiAfWLXH0DDPqvoA94Oroxiiu7cs3E8G3STcoHTtPwib7Gxi2uB6ShCe
         TN0qnP/keU7Y8ly8iP6f6U+hdeJ5CXT5nLs7pWeGnp4edtdM0Sym9I141bXeWTR7F0Zq
         CZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763759267; x=1764364067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Svi+I8ywJ8k5uxtzxqjpEGX4Qh9Fr5IeUT/6ziPIoB4=;
        b=EC52YXCNtQV6IYETZdtFItBBYeLQyJ8/rDjIuy8lR3QC3UirEnWKRN+/GF+R/NeuGC
         2Bg7tkkiiMOfJY45x7g+kM5qvY1Ni9fRtYUaddVmI+M9/phKMyEF1WIjAb2e13il1mUx
         K+FetR28LaY8SoMmG8MslTa2a9TqZ45Y/QP2jNPMIuUTofJc+7HWMzT8aUG9td0ZUFy+
         hmRZt19mtLVdcA/dWFYUAtX4+D0OFWk5kPFGiBRsAxueJkRjJZTvEMGFTKXT+3FM734T
         yODQl5Auk8C55ZGd5L6hUtCYKpiz6d8vHotg91bmn2V1wJMfaqfpTsxWLrv9U8ArlN2h
         BWTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQMwBEgb8GzsXagupQbdFGriz/4v+KNjjodUDbtKx8TAslPslEzFJpurQkzrz0A2VF1JZ25g7oFmPembH1@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMTzK/MiAPE3w9nN3TsXrawxmx5SgAq/YrgUET1mSgqe042bQ
	hV402YEwfzBNxq8AlZHSWHq7A6TR+bStRIkTNHCIR+T2siOLXJ6/kA7pCC54ofVf0i8=
X-Gm-Gg: ASbGncte3CqCX6ZD22eTrjLOlAj5uKBRdWLONMd11wdlzK0H8yyJMyY1uzPy4k+tjhx
	CNjuYuGz68CZxJY4+1xpY3+3zZ7ekSnZR3UevkOuryKLGWGh9w5j9kA15jzlu5F+L86yYxINx3Y
	D/8Ao8JY0B/eI9uYGdkuqJnplSy86OS6nkW7OZKS7Gjhqbux7llRqYKd6XD94OmDeS3gJSreNO6
	7NThViPUoSvKmWlGZvSRfB3fzWfcytGE92MSguE50nmUC3oa1KrBw8FSkvFHOXyr2E3fkA6Ypq6
	r3wSyiKXMunoUA3pg3enli4CVFlBB0HPksz2/cq9XEHwQ5EIxAKPybErUBK0pG+/mJqWTQuUYI+
	XZ9np2KJvJO5U7uoaWzs7adfWQEUOz3Q1qvXfr6nPzMxTCFQYZ52DTA1/oS3Zi+4oW1HEZbhcyW
	Mdy72u6ljhv1IkxquaGHtqBx00XCD6KT2ZJiJ9/ROSszdYea8fwilQxr+9If98LZcm87w5Vg==
X-Google-Smtp-Source: AGHT+IHB54I5/pxWYI0YylL4DbWXryCZhFk7bd7fb71QpMMtzOgbCdkOeFKpCqsEbmreSLGZDE/f8Q==
X-Received: by 2002:a05:622a:c6:b0:4eb:a457:394 with SMTP id d75a77b69052e-4ee587d2ef1mr64635291cf.12.1763759267374;
        Fri, 21 Nov 2025 13:07:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e65e3bsm42420991cf.17.2025.11.21.13.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 13:07:46 -0800 (PST)
Date: Fri, 21 Nov 2025 16:07:35 -0500
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
Message-ID: <aSDUl7kU73LJR78g@gourry-fedora-PF4VCD3F>
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
> 
> I'm interested in the contrast with zone_device, and in particular why
> device_coherent memory doesn't end up being a good fit for this.
> 
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

after some thought, talks, and doc readings it seems like the
zone_device setups don't allow the CPU to map the devmem into page
tables, and instead depends on migrate_device logic (unless the docs are
out of sync with the code these days).  That's at least what's described
in hmm and migrate_device.  

Assuming this is out of date and ZONE_DEVICE memory is mappable into
page tables, assuming you want sparse allocation, ZONE_DEVICE seems to
suggest you at least have to re-implement the buddy logic (which isn't
that tall of an ask).

But I could imagine an (overly simplistic) pattern with SPM Nodes:

fd = open("/dev/gpu_mem", ...)
buf = mmap(fd, ...)
buf[0] 
   1) driver takes the fault
   2) driver calls alloc_page(..., gpu_node, GFP_SPM_NODE)
   3) driver manages any special page table masks
      Like marking pages RO/RW to manage ownership.
   4) driver sends the gpu the (mapping_id, pfn, index) information
      so that gpu can map the region in its page tables.
   5) since the memory is cache coherent, gpu and cpu are free to
      operate directly on the pages without any additional magic
      (except typical concurrency controls).

Driver doesn't have to do much in the way of allocationg management.

This is probably less compelling since you don't want general purposes
services like reclaim, migration, compaction, tiering - etc.  

The value is clearly that you get to manage GPU memory like any other
memory, but without worry that other parts of the system will touch it.

I'm much more focused on the "I have memory that is otherwise general
purpose, and wants services like reclaim and compaction, but I want
strong controls over how things can land there in the first place".

~Gregory


