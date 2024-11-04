Return-Path: <linux-fsdevel+bounces-33635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51059BC08F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 23:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D00B218B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 22:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C381FDF80;
	Mon,  4 Nov 2024 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VdwEbQ+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFF1F755C
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757861; cv=none; b=kR1loPm5k7myIHotWmdgB/81/ddnL47fn7NPsbWwxVkWA2egULro+lNMt3qe4gFH37gLFk9O0rbkN6elHs75Sv+LUyJW7Rb4dhJFnxsdCM6SyGUlnF1fkHMDhEn9g5pdqoYFI6NgxPgQ0fkJWe43Y0W1CSRuvovneufT1E8K3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757861; c=relaxed/simple;
	bh=YN+BHcOwfA1okLM5Oxv5eSHDfLHd3P5QWXWsldKTaMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGLPD8bxzb4IaHMMMsSiyoF1xZLmv9owdT0LLsRFva2JcWPRTIfR233GRsW7hIRrEi6sUQ35LuidJm+884QbcqSBzX/5N73tceFrE1UN+P73RkKeMzi13QCFGyjYtM4oW8F0o680zvoNryvvv8HdlHQvd5B6lFWDWIRxwZpMtA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VdwEbQ+M; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 4 Nov 2024 14:04:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730757856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjYDjleGzpBit5uFWV/jDEZiQucqK6qwPMwfVl3PmCo=;
	b=VdwEbQ+MqgqCMLrkmghP/ZwaLxAN5Su9zz73qnm1Xn3HyDKjeEzG+ANFAdq2SvZzi9ro1b
	sKrQxLMDtpGKdYbEQXKlho1vH7VwhNnNBUeuDO9eCrZ35TshKFwQFuN+VKdsox4IhwZbq/
	7sZ7jm+c9eqqqe9T1Q9NIfkwPUcxCFE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
Message-ID: <6uoqxdnchcsmjze4uosvdjh6ztxbvo63bs3tctjkzy47ryllwp@6wvnxdeghlru>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev>
 <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
 <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
 <ZykEtcHrQRq-KrBC@google.com>
 <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 04, 2024 at 01:38:34PM -0800, Andrew Morton wrote:
> On Mon, 4 Nov 2024 10:30:29 -0700 Yu Zhao <yuzhao@google.com> wrote:
> 
> > On Sat, Oct 26, 2024 at 09:26:04AM -0600, Yu Zhao wrote:
> > > On Sat, Oct 26, 2024 at 12:34 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > > > > While updating the generation of the folios, MGLRU requires that the
> > > > > folio's memcg association remains stable. With the charge migration
> > > > > deprecated, there is no need for MGLRU to acquire locks to keep the
> > > > > folio and memcg association stable.
> > > > >
> > > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > >
> > > > Andrew, can you please apply the following fix to this patch after your
> > > > unused fixup?
> > > 
> > > Thanks!
> > 
> > syzbot caught the following:
> > 
> >   WARNING: CPU: 0 PID: 85 at mm/vmscan.c:3140 folio_update_gen+0x23d/0x250 mm/vmscan.c:3140
> >   ...
> > 
> > Andrew, can you please fix this in place?
> 
> OK, but...
> 
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3138,7 +3138,6 @@ static int folio_update_gen(struct folio *folio, int gen)
> >  	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
> >  
> >  	VM_WARN_ON_ONCE(gen >= MAX_NR_GENS);
> > -	VM_WARN_ON_ONCE(!rcu_read_lock_held());
> >  
> >  	do {
> >  		/* lru_gen_del_folio() has isolated this page? */
> 
> it would be good to know why this assertion is considered incorrect? 
> And a link to the sysbot report?

So, this assertion is incorrect after this patch series that has removed
the charge migration and has removed mem_cgroup_trylock_pages() / 
mem_cgroup_unlock_pages() from the caller of this function
(folio_update_gen()).

