Return-Path: <linux-fsdevel+bounces-27082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349895E72B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 05:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CF21C210CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 03:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB20B22071;
	Mon, 26 Aug 2024 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HRPmht9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A855769
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641479; cv=none; b=YwWknee6VxZ9J6InJbF1GP3uJHKy62BIf4oxwlVI3920ak1iFy3WQArGjrkRlsL/ZcRzYI+W1ZWYKlKdSAmYhbVS/5XWR/pAKT/qPKqHpB/tGvpzLJp+LWK6BNV+lvpJ3qIO7EHT19ikkQY/Pag0WV+oNl5Eckfu9c/G5PShgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641479; c=relaxed/simple;
	bh=KXQusk8Z+uYHiQ6fvrCI9bwPLq+HXWH0UiX6CzQpnvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSUqX3sWH3HufTV44ptbrPmIUuzzVzSjP+5icWK48TkWl1BhtZhxWU3lqeT/ljKYP/IdmI0malEqRArK6mE/oI82foRZCzqOHooCTAj9kXtXpdUGUIIn7wONtKplzvnbWAkBlE6hxXBfNfJ+fTyk0xptDuEY2RWhC/42G9jRAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HRPmht9t; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Aug 2024 23:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724641473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+n/9Fxr2xrcZx51pJMS5KHROlmUvJ6LIsGBARrvBq0=;
	b=HRPmht9tv0MApkzWVzJGzUPukhO+bhLXnhdTKlkE8cUU2XnMJ2D6N/YAyb4OlfC9UYmUfB
	+D5eAOK8ps8BgkFbEpc3P+H7gsIwMyKbGa+k38JF2NlGMa6OJBA1PD3O9LntWFzOm2tfOx
	VTe58SBj17o+s1XrHw/oAdbu8J8CnFg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@fromorbit.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 02/10] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <h4i4wn5xnics2wjuwzjmx6pscfuajhrkwbz2sceiihktgzuefr@llohtbim43jg>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
 <20240824191020.3170516-3-kent.overstreet@linux.dev>
 <122be87e-132f-4944-88d9-3d13fd1050ad@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122be87e-132f-4944-88d9-3d13fd1050ad@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 11:01:50AM GMT, Qi Zheng wrote:
> 
> 
> On 2024/8/25 03:10, Kent Overstreet wrote:
> > This adds a new callback method to shrinkers which they can use to
> > describe anything relevant to memory reclaim about their internal state,
> > for example object dirtyness.
> > 
> > This patch also adds shrinkers_to_text(), which reports on the top 10
> > shrinkers - by object count - in sorted order, to be used in OOM
> > reporting.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >   include/linux/shrinker.h |  7 +++-
> >   mm/shrinker.c            | 73 +++++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 78 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > index 1a00be90d93a..6193612617a1 100644
> > --- a/include/linux/shrinker.h
> > +++ b/include/linux/shrinker.h
> > @@ -24,6 +24,8 @@ struct shrinker_info {
> >   	struct shrinker_info_unit *unit[];
> >   };
> > +struct seq_buf;
> > +
> >   /*
> >    * This struct is used to pass information from page reclaim to the shrinkers.
> >    * We consolidate the values for easier extension later.
> > @@ -80,10 +82,12 @@ struct shrink_control {
> >    * @flags determine the shrinker abilities, like numa awareness
> >    */
> >   struct shrinker {
> > +	const char *name;
> >   	unsigned long (*count_objects)(struct shrinker *,
> >   				       struct shrink_control *sc);
> >   	unsigned long (*scan_objects)(struct shrinker *,
> >   				      struct shrink_control *sc);
> > +	void (*to_text)(struct seq_buf *, struct shrinker *);
> >   	long batch;	/* reclaim batch size, 0 = default */
> >   	int seeks;	/* seeks to recreate an obj */
> > @@ -110,7 +114,6 @@ struct shrinker {
> >   #endif
> >   #ifdef CONFIG_SHRINKER_DEBUG
> >   	int debugfs_id;
> > -	const char *name;
> >   	struct dentry *debugfs_entry;
> >   #endif
> >   	/* objs pending delete, per node */
> > @@ -135,6 +138,8 @@ __printf(2, 3)
> >   struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
> >   void shrinker_register(struct shrinker *shrinker);
> >   void shrinker_free(struct shrinker *shrinker);
> > +void shrinker_to_text(struct seq_buf *, struct shrinker *);
> > +void shrinkers_to_text(struct seq_buf *);
> >   static inline bool shrinker_try_get(struct shrinker *shrinker)
> >   {
> > diff --git a/mm/shrinker.c b/mm/shrinker.c
> > index dc5d2a6fcfc4..ad52c269bb48 100644
> > --- a/mm/shrinker.c
> > +++ b/mm/shrinker.c
> > @@ -1,8 +1,9 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   #include <linux/memcontrol.h>
> > +#include <linux/rculist.h>
> >   #include <linux/rwsem.h>
> > +#include <linux/seq_buf.h>
> >   #include <linux/shrinker.h>
> > -#include <linux/rculist.h>
> >   #include <trace/events/vmscan.h>
> >   #include "internal.h"
> > @@ -807,3 +808,73 @@ void shrinker_free(struct shrinker *shrinker)
> >   	call_rcu(&shrinker->rcu, shrinker_free_rcu_cb);
> >   }
> >   EXPORT_SYMBOL_GPL(shrinker_free);
> > +
> > +void shrinker_to_text(struct seq_buf *out, struct shrinker *shrinker)
> > +{
> > +	struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
> > +
> > +	seq_buf_puts(out, shrinker->name);
> > +	seq_buf_printf(out, " objects: %lu\n", shrinker->count_objects(shrinker, &sc));
> > +
> > +	if (shrinker->to_text) {
> > +		shrinker->to_text(out, shrinker);
> > +		seq_buf_puts(out, "\n");
> > +	}
> > +}
> > +
> > +/**
> > + * shrinkers_to_text - Report on shrinkers with highest usage
> > + *
> > + * This reports on the top 10 shrinkers, by object counts, in sorted order:
> > + * intended to be used for OOM reporting.
> > + */
> > +void shrinkers_to_text(struct seq_buf *out)
> > +{
> > +	struct shrinker *shrinker;
> > +	struct shrinker_by_mem {
> > +		struct shrinker	*shrinker;
> > +		unsigned long	mem;
> > +	} shrinkers_by_mem[10];
> > +	int i, nr = 0;
> > +
> > +	if (!mutex_trylock(&shrinker_mutex)) {
> > +		seq_buf_puts(out, "(couldn't take shrinker lock)");
> > +		return;
> > +	}
> 
> I remember I pointed out that the RCU + refcount method should be used
> here. Otherwise you will block other shrinkers from
> registering/unregistering, etc.

The more complex iteration isn't needed here - this is a slowpath
function and we're not doing anything blocking inside it.

