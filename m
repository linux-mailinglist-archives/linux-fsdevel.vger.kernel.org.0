Return-Path: <linux-fsdevel+bounces-33001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8909B1554
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 08:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDA2B21D22
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 06:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B95D17C7B1;
	Sat, 26 Oct 2024 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNR1Svtn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745170816
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Oct 2024 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729923974; cv=none; b=WNhnlRyQiiZfmDxTOEKzjNyUabKRfavp6qffs7lEbLCZ5VAxfD++U4WYDvmNI1qc17K3e73o7xQoTyNrRlKYaykYz4K8YZSaot4mSz8J2hqQouRDqM2PpuPWEjAZ+1Mi1o66yUBaZ2XiB0p04cWGa3/xIpGnpU1fzdY+IjLm4rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729923974; c=relaxed/simple;
	bh=lbWlF7R1HWUKgXdHmjenASs4uIgstpF1+TEZM/hHnUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAYkEm66tbbVhDnhArzjAkOg8Zhk4XTZuXt1Tv+WSScuPC/OKK4Uyq8J3qEJ29Ir8iLlmdAz5mZrjCfeeqMNw9DvrV5eKrmeri9B0jhb9G2I+EQDA4avLMccozcihfShRWUGMFc51+S753fock8pjDBsdlbNfEza3drP7eWcuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNR1Svtn; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 23:26:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729923969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhwJgu8R8B7Mg/n0iWKRDn2WDz29p+DH76mo78CE+bY=;
	b=XNR1Svtnwv+r6wljuv2HEudirb6FZVKbWV+4TDptG7TU0XZF+VshdJgNqeZdCQCm97m4K8
	FXm50sKfNEEffjEpL7sdf7kwgX/gNGXwaN+K0DV91H9HrJhUSamBXRQQ/xotuhREY8oVFU
	qj293ojC4vlQJDrj5sVXdQh0dww+fs8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 6/6] memcg-v1: remove memcg move locking code
Message-ID: <f2xyyzlzmlcuuhjawwmq7fdzeg43q2ot54jgqwkbc22fxptgky@2ytv5uehhqfj>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-7-shakeel.butt@linux.dev>
 <CAOUHufYgvcAvbGv_3rDhj_NX-ND-TMX_nyF7ZHQRW8ZxniObOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYgvcAvbGv_3rDhj_NX-ND-TMX_nyF7ZHQRW8ZxniObOQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 09:58:45PM GMT, Yu Zhao wrote:
> On Thu, Oct 24, 2024 at 7:23 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > The memcg v1's charge move feature has been deprecated. All the places
> > using the memcg move lock, have stopped using it as they don't need the
> > protection any more. Let's proceed to remove all the locking code
> > related to charge moving.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >
> > Changes since RFC:
> > - Remove the memcg move locking in separate patches.
> >
> >  include/linux/memcontrol.h | 54 -------------------------
> >  mm/filemap.c               |  1 -
> >  mm/memcontrol-v1.c         | 82 --------------------------------------
> >  mm/memcontrol.c            |  5 ---
> >  mm/rmap.c                  |  1 -
> >  5 files changed, 143 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 798db70b0a30..932534291ca2 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -299,20 +299,10 @@ struct mem_cgroup {
> >         /* For oom notifier event fd */
> >         struct list_head oom_notify;
> >
> > -       /* taken only while moving_account > 0 */
> > -       spinlock_t move_lock;
> > -       unsigned long move_lock_flags;
> > -
> >         /* Legacy tcp memory accounting */
> >         bool tcpmem_active;
> >         int tcpmem_pressure;
> >
> > -       /*
> > -        * set > 0 if pages under this cgroup are moving to other cgroup.
> > -        */
> > -       atomic_t moving_account;
> > -       struct task_struct *move_lock_task;
> > -
> >         /* List of events which userspace want to receive */
> >         struct list_head event_list;
> >         spinlock_t event_list_lock;
> > @@ -428,9 +418,7 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
> >   *
> >   * - the folio lock
> >   * - LRU isolation
> > - * - folio_memcg_lock()
> >   * - exclusive reference
> > - * - mem_cgroup_trylock_pages()
> >   *
> >   * For a kmem folio a caller should hold an rcu read lock to protect memcg
> >   * associated with a kmem folio from being released.
> > @@ -499,9 +487,7 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
> 
> I think you missed folio_memcg_rcu().
> 
> (I don't think workingset_activation() needs it, since its only caller
> must hold a refcnt on the folio.)
> 

Yes I think so too but I will send a separate followup patch for that.

