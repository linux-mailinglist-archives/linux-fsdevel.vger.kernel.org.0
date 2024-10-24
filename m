Return-Path: <linux-fsdevel+bounces-32796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 085319AED87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39ABD1C225B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0671FAC51;
	Thu, 24 Oct 2024 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FKGU0YC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83B1F6697
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790229; cv=none; b=FvvHxvO+X3sHHzuKtHaoeLqBln+/Mv05I5VI9F9o6kFMz+kr3HHMiL71z6b5JvSUtqdbwpFF5hWqIn5v43BsdvTlPwDb4+D12UPkkquwcc709Gj07yuEoMHFTL0LEaqTRE7uuke5WFr5urlXK20Ys9dshhwKwDdcalNZ3vLo2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790229; c=relaxed/simple;
	bh=iOljpUiWFrtffYQ62z1//nC5+YML7iCZj+R+HVWyJAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8xEtbVqMu0FTXp5frkfc2EdX4t+7QaIKXM6XQvgmnIWRiEavcWZ7sh9yv3dzY5m+pledmKNuoZXdYfblLDD5fR5DAeg7DFZ4htGlqTw4cxJrbqfRVWWdylGsP/txLuU5mzTvcR8xEnFNpGXBfqyhtiyA+IOUGVecLqN/Ml7jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FKGU0YC8; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 10:16:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729790224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=38joqWY7s8hm5BlhGDOYUHiPg6nN7sm6VmhGdHfvDLU=;
	b=FKGU0YC8ovYh8vg0Y5gIjFH/7Df71GaJry0Zd93QQ48d5L/90kQ/X7iYvj0xMztxGPEnAn
	769+1TJWAmUO0DkiSoz3m+QcZDV4dczhqOcXRUJ3pKR5f73YK1gV2+9a0QJ/6WAMRjsPh+
	BG39YdZ4UPfOsJxzEin7y6qj5rKxGLk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 1/3] memcg-v1: fully deprecate
 move_charge_at_immigrate
Message-ID: <hmvt2ydrluiwmautt63gf4w6kypytvb7dztc2c74b5rt5p4er3@v5an7gu462ff>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-2-shakeel.butt@linux.dev>
 <ZxoP2TLCGnSm9c8p@tiehlicka>
 <Zxp7ItxIf744tFbD@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxp7ItxIf744tFbD@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 04:51:46PM GMT, Roman Gushchin wrote:
> On Thu, Oct 24, 2024 at 11:14:01AM +0200, Michal Hocko wrote:
> > On Wed 23-10-24 23:57:10, Shakeel Butt wrote:
> > > Proceed with the complete deprecation of memcg v1's charge moving
> > > feature. The deprecation warning has been in the kernel for almost two
> > > years and has been ported to all stable kernel since. Now is the time to
> > > fully deprecate this feature.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > 
> > I fine with this move, just one detail we might need to consider
> > [...]
> > > @@ -606,17 +606,7 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
> > >  		     "Please report your usecase to linux-mm@kvack.org if you "
> > >  		     "depend on this functionality.\n");
> > >  
> > > -	if (val & ~MOVE_MASK)
> > > -		return -EINVAL;
> > > -
> > > -	/*
> > > -	 * No kind of locking is needed in here, because ->can_attach() will
> > > -	 * check this value once in the beginning of the process, and then carry
> > > -	 * on with stale data. This means that changes to this value will only
> > > -	 * affect task migrations starting after the change.
> > > -	 */
> > > -	memcg->move_charge_at_immigrate = val;
> > > -	return 0;
> > > +	return -EINVAL;
> > 
> > Would it make more sense to -EINVAL only if val != 0? The reason being
> > that some userspace might be just writing 0 here for whatever reason and
> > see the failure unexpected.
> 
> I think it's a good idea.
> 
> Thanks!

Thanks Michal and Roman for the review and I will make this change in
the next version.

