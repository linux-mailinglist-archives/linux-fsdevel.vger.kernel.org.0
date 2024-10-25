Return-Path: <linux-fsdevel+bounces-32853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6421B9AFA61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 08:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251EF2831C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 06:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AD81B219F;
	Fri, 25 Oct 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Slco1IxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58C18DF8F
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839273; cv=none; b=VpyFGSfvIvC+X9Jj320QQ59Ck4sVUxZYNCjW/s33k6z9lmMXwdwWA9ssmKP/DY6eQ9jhOeC3lLh46eU8BVUvaQI1ksDqxvnqIP/clqj2P+3zKiTRxN6gL8y3oc4Jb0jiNphkwlgl7PpTbc2VyGgEsgpv2FWiPSumT2pogVPQctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839273; c=relaxed/simple;
	bh=2sNuaIFpi5/LIb4y4x5T90AeGEoChidoE7bhBed8uPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/mnd7oNmqDH0cqvJNXERqgaWUTM1qmIAFhD9U/TIUpnBemJ+bL12WjBAOm5rpTkUg0ZidauFymOslcYeNnLVrsOA7RvUQ0j8Mcyg1tLRwAYlXZn880AnitLdiuk6cEW+40vexjAZOagb5r0Lmbm19iKHkrpSo9MUPlltQXQ624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Slco1IxK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so1177671f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729839267; x=1730444067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36JhFiVJEgXCmXb24IP1IdfysT56osH0yrGc0nJL9zg=;
        b=Slco1IxKsOxYxIDSUeuRAF6Mo1N2apvdrqBYnl0J4EYFNIl5kNimDq+iMOB27on0uX
         zAAuLqMaCSVTlQ/+fM1N0Xb3DpdBRKhwwloJ+3IzSWzzztcuMl1WHbmpiVFp7FKfsNlB
         twXCV4V9zv5xQqIRdj2VJ3+27fASDaN+MU0dnshNuq2QRMvZGkogNLXaTMJRXlNfT4Em
         0sYYbOA/A8F9wgq+tZqiHWXQDEr9aAW6ClZSQqvYxDAlyHtc/JRLr0RQMzU1TXfUy4mE
         tNKyQmsMSr3MuR6+hm4jI4s+y1RNcSQjQsJN8T0KvcG1ZJ01Hqt3fI/RF5AuhS6Th8iI
         EfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729839267; x=1730444067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36JhFiVJEgXCmXb24IP1IdfysT56osH0yrGc0nJL9zg=;
        b=KHOOTGsPwjOH2qGliKyt1ZosIkQYBBK8t8p5ijLIfSYvaQZFnMTaT3bpR9G9OZyrz9
         5m3kOIyL1odM6pOpLYPPCQRn6dcqtcbChrSPvKnN6OLr9nj8C/83tKOR96fVzn506HN5
         HmJQqe2oaU5xg+XQkoWWyvG9xX02Dwjxm32tKsHcGh8hdN4uH9cBSMmJTMDMoCxnfpuN
         xkNqxVXKbmanw6KaM7leAOEiNtSuwPXHEiqqXKR/BCd/j8nzIWPF+dCac50WuJPcHEew
         WgKSLBsP0qzbNnf5lG0NxjsfAcjEKvTH9SSsY3VcuDDtTB9cDzLlu+IwSvNsGWPxk4oL
         Mlcw==
X-Forwarded-Encrypted: i=1; AJvYcCWkIf6/UcugghIgydKvWGLIt5e1LxwiONpQIWoUQp3XhXcXe8kqVVgP9hbgithVUS2zH1GsNFMFs/lsgKyg@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ21qaCyK4LILv3z4DN/Ba2WoO2uhZl47wIe90lOk+bGbaHU+Q
	VGhgWs0KaymTkx2OosR4e58AJKadS1ddDc/pmjg+G5e4VIFaP0VjrADk03VBiwA=
X-Google-Smtp-Source: AGHT+IGMMmQMryfKEZph9NzIticOCIBK+v+n5kkY2vmcHa7n5CN8sNh3ZIArtkjp3u3TtuJ4yuizww==
X-Received: by 2002:a5d:5590:0:b0:37c:d2f3:b3b0 with SMTP id ffacd0b85a97d-37efcf0d877mr5764357f8f.23.1729839267500;
        Thu, 24 Oct 2024 23:54:27 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b928cesm743877f8f.102.2024.10.24.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:54:27 -0700 (PDT)
Date: Fri, 25 Oct 2024 08:54:26 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 1/6] memcg-v1: fully deprecate move_charge_at_immigrate
Message-ID: <ZxtAoo49HRces0fN@tiehlicka>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-2-shakeel.butt@linux.dev>

On Thu 24-10-24 18:22:58, Shakeel Butt wrote:
> Proceed with the complete deprecation of memcg v1's charge moving
> feature. The deprecation warning has been in the kernel for almost two
> years and has been ported to all stable kernel since. Now is the time to
> fully deprecate this feature.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
> 
> Changes since RFC:
> - Writing 0 to memory.move_charge_at_immigrate is allowed.
> 
>  .../admin-guide/cgroup-v1/memory.rst          | 82 +------------------
>  mm/memcontrol-v1.c                            | 14 +---
>  2 files changed, 5 insertions(+), 91 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 270501db9f4e..286d16fc22eb 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -90,9 +90,7 @@ Brief summary of control files.
>                                       used.
>   memory.swappiness		     set/show swappiness parameter of vmscan
>  				     (See sysctl's vm.swappiness)
> - memory.move_charge_at_immigrate     set/show controls of moving charges
> -                                     This knob is deprecated and shouldn't be
> -                                     used.
> + memory.move_charge_at_immigrate     This knob is deprecated.
>   memory.oom_control		     set/show oom controls.
>                                       This knob is deprecated and shouldn't be
>                                       used.
> @@ -243,10 +241,6 @@ behind this approach is that a cgroup that aggressively uses a shared
>  page will eventually get charged for it (once it is uncharged from
>  the cgroup that brought it in -- this will happen on memory pressure).
>  
> -But see :ref:`section 8.2 <cgroup-v1-memory-movable-charges>` when moving a
> -task to another cgroup, its pages may be recharged to the new cgroup, if
> -move_charge_at_immigrate has been chosen.
> -
>  2.4 Swap Extension
>  --------------------------------------
>  
> @@ -756,78 +750,8 @@ If we want to change this to 1G, we can at any time use::
>  
>  THIS IS DEPRECATED!
>  
> -It's expensive and unreliable! It's better practice to launch workload
> -tasks directly from inside their target cgroup. Use dedicated workload
> -cgroups to allow fine-grained policy adjustments without having to
> -move physical pages between control domains.
> -
> -Users can move charges associated with a task along with task migration, that
> -is, uncharge task's pages from the old cgroup and charge them to the new cgroup.
> -This feature is not supported in !CONFIG_MMU environments because of lack of
> -page tables.
> -
> -8.1 Interface
> --------------
> -
> -This feature is disabled by default. It can be enabled (and disabled again) by
> -writing to memory.move_charge_at_immigrate of the destination cgroup.
> -
> -If you want to enable it::
> -
> -	# echo (some positive value) > memory.move_charge_at_immigrate
> -
> -.. note::
> -      Each bits of move_charge_at_immigrate has its own meaning about what type
> -      of charges should be moved. See :ref:`section 8.2
> -      <cgroup-v1-memory-movable-charges>` for details.
> -
> -.. note::
> -      Charges are moved only when you move mm->owner, in other words,
> -      a leader of a thread group.
> -
> -.. note::
> -      If we cannot find enough space for the task in the destination cgroup, we
> -      try to make space by reclaiming memory. Task migration may fail if we
> -      cannot make enough space.
> -
> -.. note::
> -      It can take several seconds if you move charges much.
> -
> -And if you want disable it again::
> -
> -	# echo 0 > memory.move_charge_at_immigrate
> -
> -.. _cgroup-v1-memory-movable-charges:
> -
> -8.2 Type of charges which can be moved
> ---------------------------------------
> -
> -Each bit in move_charge_at_immigrate has its own meaning about what type of
> -charges should be moved. But in any case, it must be noted that an account of
> -a page or a swap can be moved only when it is charged to the task's current
> -(old) memory cgroup.
> -
> -+---+--------------------------------------------------------------------------+
> -|bit| what type of charges would be moved ?                                    |
> -+===+==========================================================================+
> -| 0 | A charge of an anonymous page (or swap of it) used by the target task.   |
> -|   | You must enable Swap Extension (see 2.4) to enable move of swap charges. |
> -+---+--------------------------------------------------------------------------+
> -| 1 | A charge of file pages (normal file, tmpfs file (e.g. ipc shared memory) |
> -|   | and swaps of tmpfs file) mmapped by the target task. Unlike the case of  |
> -|   | anonymous pages, file pages (and swaps) in the range mmapped by the task |
> -|   | will be moved even if the task hasn't done page fault, i.e. they might   |
> -|   | not be the task's "RSS", but other task's "RSS" that maps the same file. |
> -|   | The mapcount of the page is ignored (the page can be moved independent   |
> -|   | of the mapcount). You must enable Swap Extension (see 2.4) to            |
> -|   | enable move of swap charges.                                             |
> -+---+--------------------------------------------------------------------------+
> -
> -8.3 TODO
> ---------
> -
> -- All of moving charge operations are done under cgroup_mutex. It's not good
> -  behavior to hold the mutex too long, so we may need some trick.
> +Reading memory.move_charge_at_immigrate will always return 0 and writing
> +to it will always return -EINVAL.
>  
>  9. Memory thresholds
>  ====================
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 81d8819f13cd..9b3b1a446c65 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -593,29 +593,19 @@ static inline int mem_cgroup_move_swap_account(swp_entry_t entry,
>  static u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
>  				struct cftype *cft)
>  {
> -	return mem_cgroup_from_css(css)->move_charge_at_immigrate;
> +	return 0;
>  }
>  
>  #ifdef CONFIG_MMU
>  static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
>  				 struct cftype *cft, u64 val)
>  {
> -	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> -
>  	pr_warn_once("Cgroup memory moving (move_charge_at_immigrate) is deprecated. "
>  		     "Please report your usecase to linux-mm@kvack.org if you "
>  		     "depend on this functionality.\n");
>  
> -	if (val & ~MOVE_MASK)
> +	if (val != 0)
>  		return -EINVAL;
> -
> -	/*
> -	 * No kind of locking is needed in here, because ->can_attach() will
> -	 * check this value once in the beginning of the process, and then carry
> -	 * on with stale data. This means that changes to this value will only
> -	 * affect task migrations starting after the change.
> -	 */
> -	memcg->move_charge_at_immigrate = val;
>  	return 0;
>  }
>  #else
> -- 
> 2.43.5

-- 
Michal Hocko
SUSE Labs

