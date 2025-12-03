Return-Path: <linux-fsdevel+bounces-70539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A528C9DCB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 06:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF80D3A6CC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 05:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95932773D8;
	Wed,  3 Dec 2025 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oEYx3T1m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8EC280018
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 05:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764739539; cv=none; b=Z/0ucrAV9gkn61e0vEXEhg5XRB3EmPa8PKDnCdhiDGPIj+CxCX2qq9bLehhMNZD48A7l8kkSBvDxXUcMusK7sqtGM1UuXuZQqb/MTv+EeIbHzYUBkICH6T+PB4o515yj0kkNXjpJZ05gYt5I7hwH6MzIfNP0WJKKqC/8iO6HhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764739539; c=relaxed/simple;
	bh=gMokQjiGrbq73yboSU7DsWLyJxjEVtxLOnIljku9jO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0jVEik0ZoVuXGKkBrSK+IoVC9ynSHScOz9PGfMyUwtQzWF0WquBvWpd4vZ+eD8xcBL1hOMnqtgoT+KOhgdRWnM5SR3i1MVIQL32BXlj4o9t0xJ9iZgyPTPtHI2Js4j2LqQKFjEmzIGo9gm7j8PZR1KfTZ9rQLui398s9tBDdf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oEYx3T1m; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b29ff9d18cso569942385a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 21:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1764739536; x=1765344336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQd4Pt3H9b8tI3sXslpzNlT4s0PF8/OKfUrI48cqcy0=;
        b=oEYx3T1mdwPnSa05xEAFwmYUxGKmj0qDTF0tbfnfEAyfDrZ4N+bGGPhUnnXbDJ6RAp
         7pilPrVGJzTwVICfca6MP1blvQCSU6NhBs7/vn/vQH5pFrP3QDUONkOkFA8YDenxFeV0
         or+HxUYHhD7pY+0gry3AI2ee9qmPOYlJF1KQO4NYUnJ+w6rYoJZLDyKe2ZFNRygaVFrS
         Uucnha0J/wqNN573xNJVWDw7zcSQWnt08u1AuDR3dVJN5YkUe1QhgdcOZL5TOci8DWC4
         dof0qjWEvYbgtJap/SDSVmCYB5j1SNANH8OUkuxZGXnm1XT8Up819c7JVKgbwcSWvzhb
         Ujjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764739536; x=1765344336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQd4Pt3H9b8tI3sXslpzNlT4s0PF8/OKfUrI48cqcy0=;
        b=ZkdagaIX5O1Y4viNIi3aQdKBkCnTSJzRs5ZCyXEcjrklXKMtdufwQPKnN7kg5rS/iF
         FnD89F1SCP3l/Ry5DgmTs4QswhmQ70pTyn5we10carWToRG4/g4ASuD+espTq88NrxjM
         +sQ3jvWzOGVS3oD6LJgKiQjEz6bvI+uW63YNkU5MnBzIPEzjBD7PJyA+EL0S9lINlZEP
         pGTpSUeDh9SYIWk+6RZYpjROS3Rv5yB5qXExsbme//Ah1ce2atm3RNSV1bM2PMCCWiVa
         Hmuz3+EhXZcdI21PqbDyU89KU7qGySg1d/UQE3D7YsdtsPwXDJ8XhXPMxDY3OxKbRoy4
         +I8g==
X-Forwarded-Encrypted: i=1; AJvYcCXyF5PVOlBJ+a5233mjd10LLdxf1HqIWJmNnOorCPY/0o81aw4tqvpYa4JUCT/p4RY77goziKZfSp0QnfEy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5yXxB7oGkhaL7LRKvszbGuyGNRNPi/2RiLWSRsXUo6cguQcn1
	MdvSMiZ4GOlwJGY6rUZXic1Z/XuLSR87TgPhlfvx0UDoRPHqq++EpAKIyQvp9d33v0o=
X-Gm-Gg: ASbGnctvzDk11x79wHna/Z1Br7uHqkS4/L6p4zd21jdN1FmvmeOuDsnK4rSMguRwQBY
	Mhx1YzNFgT3iG+IgO1/54thtiVD0QahPVIZLFcxWEKUaGqrICusNnj4OK1NW3nIwDCUIBpjNj37
	K4aBI6GRcQTp2Nerj3AhuobUq/qcsLJY+B/60bFgtpunevNkIaJCzF5TS7ra2ZfGuJqNtSn1mf4
	Xu7abIhqMRIbYqjF9feHH2IB0yQNys7w3ccGB7AVE+80NvkzSUUl8RoxYw+ouVhAW6w8UxAoIgy
	JoruvQY6vP/lUSNwPE2fB8R7JKdI57sFAOZqAsMSFRdqdCC3B0UHYVqQgZMBfFob3K3v5WB1XLI
	4l5iIZ53f2YxQf61VH6UPZLofo95X7gP4SWCer5W9BITjXpzFiaBAyqNT7SjqFzN0ZUwecgQs0Y
	2ej9oiF/oNskAeCyydVvQS0Tsh9WzMvJHKqNBSUnwm2Km69VNHCsIdSVZdj+NDNoVkFoPAknshR
	l4j4oqL
X-Google-Smtp-Source: AGHT+IEtBXE0acM3lcuYUfkevwa5ntm2r18hgzk7j9m68t378myjOMm9OzJsbsysg70BSpP5Mhf/2A==
X-Received: by 2002:a05:620a:4629:b0:8b2:dccd:7315 with SMTP id af79cd13be357-8b5e7453f0amr159953685a.88.1764739536329;
        Tue, 02 Dec 2025 21:25:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b65bbsm1227681985a.33.2025.12.02.21.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 21:25:35 -0800 (PST)
Date: Wed, 3 Dec 2025 00:25:33 -0500
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
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
Message-ID: <aS_JzWHHn8hBHSCe@gourry-fedora-PF4VCD3F>
References: <20251112192936.2574429-1-gourry@gourry.net>
 <48078454-f441-4699-9c50-db93783f00fd@nvidia.com>
 <aSa6Wik2lZiULBsg@gourry-fedora-PF4VCD3F>
 <36edd166-7e11-4d43-9839-42467d4399d1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36edd166-7e11-4d43-9839-42467d4399d1@nvidia.com>

On Wed, Dec 03, 2025 at 03:36:33PM +1100, Balbir Singh wrote:
> >    - I discussed in my note to David that this is probably the right
> >      way to go about doing it. I think N_MEMORY can still be set, if
> >      a new global-default-node policy is created.
> > 
> 
> I still think N_MEMORY as a flag should mean something different from
> N_SPM_NODE_MEMORY because their characteristics are different
> 
... snip ...  (I agree, see later)

> >    - Instead, I can see either per-component policies (reclaim->nodes)
> >      or a global policy that covers all of those components (similar to
> >      my sysram_nodes).  Drivers would then be responsible to register
> >      their hotplugged memory nodes with those components accordingly.
> > 
> 
> To me node zonelists provide the right abstraction of where to allocate from
> and how to fallback as needed. I'll read your patches to figure out how your
> approach is different. I wanted the isolation at allocation time
>
... snip ... (I agree, see later)

> 
> Yes, we should look at the pros and cons. To be honest, I'd wouldn't be 
> opposed to having kswapd and reclaim look different for these nodes, it
> would also mean that we'd need pagecache hooks if we want page cache on
> these nodes. Everything else, including move_pages() should just work.
> 

Basically my series does (roughly) the same as yours, but adds the
cpusets controls and a GFP flag.  The MHP extention should ultimately
be converted to N_SPM_NODE_MEMORY (or whatever we decide to name it).

After some more time to think, I think we want all of it.

- N_SPM_NODE_MEMORY (or whatever we call it) handles filtering out
  SPM at allocation time by default and protects all current users
  of N_MEMORY from exposure to SPM.

- cpusets controls allow userland isolation control and a default sysram
  mask (I think cpusets.sysram_nodes doesn't even need to be exposed via
  sysfs to be honest).  cpusets fix is needed due to task->mems_allowed
  being used as a default nodemask on systems using cgroups/cpusets.

- GFP_SP_NODE protects against someone doing something like:
      get_page_from_freelist(..., node_states[N_POSSIBLE])
      or
      numactl --interleave --all ./my_program

  While providing a way to punch an explicit hole in the isolation
  (GFP_SP_NODE means "Use N_SPM_NODE_MEMORY instead of N_MEMORY")

  This could be argued against so long as we restrict mempolicy.c
  to N_MEMORY nodes (to avoid `--interleave --all` issues), but this
  limitation may not be preferable.

  My concern is for breaking existing userland software that happens
  to run on a system with SPM - but you can probably imagine many more
  bad scenarios.

~Gregory

