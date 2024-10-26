Return-Path: <linux-fsdevel+bounces-33000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5FA9B1551
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 08:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F242F1F228EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 06:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54284179954;
	Sat, 26 Oct 2024 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wOcYS5Ae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED16217F43;
	Sat, 26 Oct 2024 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729923668; cv=none; b=qKO0cMqm9CYkNGrVN2MLpibZdkp39XthT5C7MQG7Qr44kzxi5hujB+bob+VIKkfBzSJoOB0seeG5TzWeFPuoXWqaj6Wdc0K2nxeOGAuklajX9mOgV4G6mCuMFM0034U7US5GW1BZnBv1StLT+NMiqMWgEM5JrF5fm9VcDa8Hyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729923668; c=relaxed/simple;
	bh=T3cLOvLmpXT3DfruKbIZuU0dFk1rc6dmtKxGiVIILCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE4Iit9/teMV68pDaDPFrSRPoiwF1gwaPIH1apjSFQsUj0qvGfGeMwvvIyl2g+gvJSnGgo6IMxbtGL4NuItx8FrkUS1Gfrd8YtioTEaGT8AAv+LFzo1UYsv8qGHJmV+4fSjr4ON62TmsQzK7pCauC3mgVJKZ9QKmaKk3Y0Zaa4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wOcYS5Ae; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 23:20:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729923659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHAwo+JHtR0FwFONME6zc+Rb8ODXdGUmI/r0NvGK1AQ=;
	b=wOcYS5AeAxHZybTQ4tG6y7dgLM71ARuhUQ+7lbNhmGKgYAagc61eRREX3dcRLz0ZjuwE09
	ORrfNh6zQFFvU3+6cG+kuaiv+YlAV7GIoM8s5Z/1wrIxKy8H0YAJujRv+O8AbKNX0+U614
	shsB3NWF094pDlWoLg+ChAXA2Oo5ec0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
Message-ID: <zyg74lpsxu7gvnsjjrcrbejfophvas6ibfi6cpqsj6hewgongo@x6hlpemfz6ej>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev>
 <CAOUHufYCPkUH0ysujoXZaw3PSrPvaw356-Pb97=LPGVRu_7FNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYCPkUH0ysujoXZaw3PSrPvaw356-Pb97=LPGVRu_7FNQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 09:55:38PM GMT, Yu Zhao wrote:
> On Thu, Oct 24, 2024 at 7:23 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > While updating the generation of the folios, MGLRU requires that the
> > folio's memcg association remains stable. With the charge migration
> > deprecated, there is no need for MGLRU to acquire locks to keep the
> > folio and memcg association stable.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/vmscan.c | 11 -----------
> >  1 file changed, 11 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 29c098790b01..fd7171658b63 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3662,10 +3662,6 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
> >                 if (walk->seq != max_seq)
> >                         break;
> 
> Please remove the lingering `struct mem_cgroup *memcg` as well as
> folio_memcg_rcu(). Otherwise it causes both build and lockdep
> warnings.
> 

Thanks for catching this. The unused warning is already fixed by Andrew,
I will fix the folio_memcg_rcu() usage.

