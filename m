Return-Path: <linux-fsdevel+bounces-27501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F469961D08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABE9B225C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1113C670;
	Wed, 28 Aug 2024 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Ho4gSxBg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE7611E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815946; cv=none; b=IdvdgGmXqH/1sfGySIBglgWCqF8d8gH1oSC+AHON+6pAJFEcjYiEvZy68kgy2MTe4rY6HwvHcy3jV0TvS01WN82nsYSfAgxVsDfGhkVioW1IHdCPYQOS1OzkIEjgpS65K2McAVeCEcQClR7epDPJtwK9Cqk/ntnyuIfXMYJ8yew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815946; c=relaxed/simple;
	bh=LGXlHY009TvNznTX3c4gbHgo/PGn48DHAu/OfUtduR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQfNcJasVbObxR8cNtBLwvx8Zi/2nOrK+yJ/3iquTLDd+gh432fyKOL5WDKZDZTclpTcO+7XXw4Ai3cpckAfYcSh5Wqz/c8U/EuUeLSTumvi2nHdrkvM2fnr3SL7dkowdDPyZWh4xcRWh5l/myNULB81Gp3oKDGB5QscOmxzvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Ho4gSxBg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso4872199a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724815944; x=1725420744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOUwFnh8dRGJzRbK7IWvINcshuS8hyE9hSMQAPyOBfI=;
        b=Ho4gSxBgY81JBaVvZp8dI9NxNM4Qw41zoBHbkK4TQxQJgqqtJ/fo9tk3L9Rn3W91R/
         lTpEZL8AphxTWB3KvTILaymc1jkC8w5EP1dTp2IN/KPk0ndmu9mPKAaYBD6y4ooJXXom
         MFF/9zYWhpQj6weQg3YlqfUgNiNRpOVm4b3T0uCdSUiMY+MPxbipzu+Nht7dMrINtxl0
         YxG0gVb4TNLWPPE4WSv1hTbShIgk0s8e9Dzn551dR9ZdB65T7Y/dEHeyxGl8BmW+GvR5
         E8UQTJAbL6FrtYzlvAthXjlkBLn5ZLhWRW7vWr4yxEvWgqO0NlVMwGHrIF6uOKsQfgrm
         xbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724815944; x=1725420744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOUwFnh8dRGJzRbK7IWvINcshuS8hyE9hSMQAPyOBfI=;
        b=UUNR8fei01F9DE/btvPsa2O30y+mJgq+MiKb0MBfeVrYPKNwd80iJznMoR6CjFd3Nb
         t48R/eJJ5eq6tBZ2HMod1s2ZJKh0gg487MG86MA+MEZZG6N/6cOUbuIiXJo3DCsL30dj
         css3UERbWhdzHHb1fx9VmvdiRcDgzY8p9Q/rqlD1DkrHLml1vtgvRV57OXwp6ww6ol/i
         cY2Sok9tjMroFH1sn2blKBOIGzJXHpMklTKpp/QWFzf3zUv1R67vRrekkeQ2nIgi2WBS
         YEUpl9btJ6OyWCIs4D22jKZ9FYkVGWiIZ4bWW4V1ft5xnwwxDcnKMir+u3yvY6EI5vay
         LXFQ==
X-Gm-Message-State: AOJu0Yy8fCmO4nGg4yHA8yLvlLEpLa3vhgo23rDjv93gTX4RjevL9UlY
	VQwnNGAevBJ8EzB5v/aPGSJfz5TAWygpfjYNcPJkjTORMfucM0A+QHNoJAKDnRNV7/1XvzYhXhk
	e
X-Google-Smtp-Source: AGHT+IGQnmK2Kx24hDKpI+BVFCeBMtIVqGG2N0/z6DHuYSL/PxeKxx30BPfqZGyDNMUOFOzL+KIWmg==
X-Received: by 2002:a17:90a:9ad:b0:2c9:77d8:bb60 with SMTP id 98e67ed59e1d1-2d646d6f468mr16953327a91.35.1724815944575;
        Tue, 27 Aug 2024 20:32:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84462af10sm362282a91.34.2024.08.27.20.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 20:32:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sj9Px-00FI5C-0A;
	Wed, 28 Aug 2024 13:32:21 +1000
Date: Wed, 28 Aug 2024 13:32:21 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 02/10] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <Zs6aRZrjqPXQue6r@dread.disaster.area>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
 <20240824191020.3170516-3-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824191020.3170516-3-kent.overstreet@linux.dev>

On Sat, Aug 24, 2024 at 03:10:09PM -0400, Kent Overstreet wrote:
> This adds a new callback method to shrinkers which they can use to
> describe anything relevant to memory reclaim about their internal state,
> for example object dirtyness.
....

> +	if (!mutex_trylock(&shrinker_mutex)) {
> +		seq_buf_puts(out, "(couldn't take shrinker lock)");
> +		return;
> +	}

Please don't use the shrinker_mutex like this. There can be tens of
thousands of entries in the shrinker list (because memcgs) and
holding the shrinker_mutex for long running traversals like this is
known to cause latency problems for memcg reaping. If we are at
ENOMEM, the last thing we want to be doing is preventing memcgs from
being reaped.

> +	list_for_each_entry(shrinker, &shrinker_list, list) {
> +		struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };

This iteration and counting setup is neither node or memcg aware.
For node aware shrinkers, this will only count the items freeable
on node 0, and ignore all the other memory in the system. For memcg
systems, it will also only scan the root memcg and so miss counting
any memory in memcg owned caches.

IOWs, the shrinker iteration mechanism needs to iterate both by NUMA
node and by memcg. On large machines with multiple nodes and hosting
thousands of memcgs, a total shrinker state iteration is has to walk
a -lot- of structures.

And example of this is drop_slab() - called from
/proc/sys/vm/drop_caches(). It does this to iterate all the
shrinkers for all the nodes and memcgs in the system:

static unsigned long drop_slab_node(int nid)
{
        unsigned long freed = 0;
        struct mem_cgroup *memcg = NULL;

        memcg = mem_cgroup_iter(NULL, NULL, NULL);
        do {
                freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
        } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);

        return freed;
}

void drop_slab(void)
{
        int nid;
        int shift = 0;
        unsigned long freed;

        do {
                freed = 0;
                for_each_online_node(nid) {
                        if (fatal_signal_pending(current))
                                return;

                        freed += drop_slab_node(nid);
                }
        } while ((freed >> shift++) > 1);
}

Hence any iteration for finding the 10 largest shrinkable caches in
the system needs to do something similar. Only, it needs to iterate
memcgs first and then aggregate object counts across all nodes for
shrinkers that are NUMA aware.

Because it needs direct access to the shrinkers, it will need to use
the RCU lock + refcount method of traversal because that's the only
safe way to go from memcg to shrinker instance. IOWs, it
needs to mirror the code in shrink_slab/shrink_slab_memcg to obtain
a safe reference to the relevant shrinker so it can call
->count_objects() and store a refcounted pointer to the shrinker(s)
that will get printed out after the scan is done....

Once the shrinker iteration is sorted out, I'll look further at the
rest of the code in this patch...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

