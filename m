Return-Path: <linux-fsdevel+bounces-15033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12288630A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 23:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECC71F23870
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 22:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE9137749;
	Thu, 21 Mar 2024 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="y9CgARli"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB1134CC8;
	Thu, 21 Mar 2024 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058951; cv=none; b=ksVdBVbhGRJbtkwAqbHt+hcesDpm3NLwxjdgPWh/EId8AVV6rDIqLZdIUwYKYLfYGvTG2ixHECLcnAhmOrVilTkX6453vgP16hKJcEoVJpNMocVowfHyqUWw6eigBs0bRJEvGQ7DGZ78UOagOk2f9mxxGozLxZTnlzkvX7ZEc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058951; c=relaxed/simple;
	bh=VhxyuJAKDJdilw9zvcdHtFTt3LX+RMm+Bp/Q9DPpRW4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DtwqtAUayvREvFqiaiKsh6+Uys6SaIEr1JTJtcvKFTsnBvIONC05J8guxtXG0sZn756gwNbRhj3b/L8d80kkRyZks1LIOQz9ZWT0OavB0UKLtOVsynaY9XVtAxhqsMmiBtw3fM1wyPenBPYgFVx+rpT+6vNnAcI6rRYGtPL8rH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=y9CgARli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8F3C433F1;
	Thu, 21 Mar 2024 22:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711058950;
	bh=VhxyuJAKDJdilw9zvcdHtFTt3LX+RMm+Bp/Q9DPpRW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=y9CgARliGxUh9un0RWq77BvUsv8icetsXjNRrb37j5AgzbQBVxWvl7EmT5MW08zRV
	 KzT97X78s64BZpndmQKS2jPFO2FuiZ8PVKbsoWOrRh5ggd9KkdNWmNHqmu7KFgTu0n
	 YLx1MsVpgD+D82vQMtv34P1DpdyVeCQmlYlP4sz4=
Date: Thu, 21 Mar 2024 15:09:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 05/37] fs: Convert alloc_inode_sb() to a macro
Message-Id: <20240321150908.48283ba55a6c786dee273ec3@linux-foundation.org>
In-Reply-To: <gnqztvimdnvz2hcepdh3o3dpg4cmvlkug4sl7ns5vd4lm7hmao@dpstjnacdubq>
References: <20240321163705.3067592-1-surenb@google.com>
	<20240321163705.3067592-6-surenb@google.com>
	<20240321133147.6d05af5744f9d4da88234fb4@linux-foundation.org>
	<gnqztvimdnvz2hcepdh3o3dpg4cmvlkug4sl7ns5vd4lm7hmao@dpstjnacdubq>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 17:15:39 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Thu, Mar 21, 2024 at 01:31:47PM -0700, Andrew Morton wrote:
> > On Thu, 21 Mar 2024 09:36:27 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > 
> > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > 
> > > We're introducing alloc tagging, which tracks memory allocations by
> > > callsite. Converting alloc_inode_sb() to a macro means allocations will
> > > be tracked by its caller, which is a bit more useful.
> > 
> > I'd have thought that there would be many similar
> > inlines-which-allocate-memory.  Such as, I dunno, jbd2_alloc_inode(). 
> > Do we have to go converting things to macros as people report
> > misleading or less useful results, or is there some more general
> > solution to this?
> 
> No, this is just what we have to do.

Well, this is something we strike in other contexts - kallsyms gives us
an inlined function and it's rarely what we wanted.

I think kallsyms has all the data which is needed to fix this - how
hard can it be to figure out that a particular function address lies
within an outer function?  I haven't looked...

