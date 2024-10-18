Return-Path: <linux-fsdevel+bounces-32294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8E9A3443
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 07:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAB5285CDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 05:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F5C17CA03;
	Fri, 18 Oct 2024 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NpHEZ29Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52AF17B4FC
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 05:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229502; cv=none; b=S8iMq9D9KTq0MSSX7OYz3dHVwA71U1SPdtj6kwYhkVIUeUug7sU8zqBaH4SgsSq0Z2IbW4eZtAu3o0T3Fxih1wI8ozuti8jcSAP03Dux0mRD0AQ1M+rcm7tcW0WwmTroq7K+Fw0aJkfnxGdj0t8lgQwiOiUW1epVTO7qB4ey+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229502; c=relaxed/simple;
	bh=4trCDHCHW08/iCyXzfQ83WGG/pZ1/9eka910dyiLOKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idN0GBmgv7nl1+rVByXXu+EPq3+Hx7kDk3STMhdBwAnkl4QwXRY6CMz5WqOKUWFRGIvzMx4AhUd8WyuCLuu7lIzblJ1CUqrBivd106swmele4+zDs73PkTT/RA4V8u9QNpBtrq3K2VTvF76UtJ54XaQoqWHH35eDrgELB2f53G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NpHEZ29Y; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Oct 2024 22:31:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729229498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MMiNLJFyavBpZ4JXtIhgjcdmUGIO3nY80lFVYxM6sEw=;
	b=NpHEZ29YjHQkZeemGGygG84jYRx3xOAUtSoL4BTyHVv1VaGst+b8x9yyEDkoZLP7z/D9uN
	y3rtgvALXhwJv4HhDtEjulM5fERq2qAY8ZcgrW5iSmmLvvCqIA6h75wS/ipQ5IMGukafFk
	NrtFc2G7UP6B+uODa5BJc5BQ7Tf8sN0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
 <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 17, 2024 at 03:31:48PM GMT, Miklos Szeredi wrote:
> On Wed, 16 Oct 2024 at 23:27, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > Why is it bad? I can understand fuse server getting blocked on fuse
> > folios is bad but why it is bad for other applications/tasks? I am
> > wondering network filesystems have to handle similar situation then why
> > is it bad just for fuse?
> 
> You need privileges (physical access) to unplug the network cable.
> You don't need privileges (in most setups) to run a fuse server.

I feel like this is too much restrictive and I am still not sure why
blocking on fuse folios served by non-privileges fuse server is worse
than blocking on folios served from the network.

> 
> > It might be a bit more than sprinkling. The reclaim code has to activate
> > the folio to avoid reclaiming the folio in near future. I am not sure
> > what we will need to do for move_pages() syscall.
> 
> Maybe move_pages() is okay, because it is explicitly targeting a fuse
> mmap.   Is this the only way to trigger MIGRATE_SYNC?

It can happen through migrate_pages(), mbind(), compaction which can
caused by hugepage allcations.


