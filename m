Return-Path: <linux-fsdevel+bounces-32911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8DF9B09CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52971F21467
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100761885B7;
	Fri, 25 Oct 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M6kK4d9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A513212A;
	Fri, 25 Oct 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873396; cv=none; b=OCTgRCwNVnsQmYytqKGOS8g7oVMzJnKuj2I19+0xNUZxmh327cZDibxe2xH0WY4GppAseHPlJ2vaTjfwEiht+G5eak/jYvLAU0zQB7rSRDAodMdUL+8YlKz+OK3XYBHHHm2JBJpimor4nwO3mvfxDmrhit79vPZh+5iwgngYeoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873396; c=relaxed/simple;
	bh=xFXss10JsYOL42MxLrvdJL/k4QUc7wxpsX65RUScLnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX+p+MjuMOFUxzX+s7q9cLKqA40Qe0q8cpn60OXfuryAqNPxVKC/qd4zaKNYXjL456n2RatbuRuCj3SM5UUhZ663WF0XBjlHgGWwjoJ5d6LqJhnUOYdW4xWCvBc9fmGt2749RYQYH6GZ73NDcsao2yFymtSCyNMTCFwKuXwUnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M6kK4d9r; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 09:22:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729873387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/s1HiPozNDCLY2sfzZo8MbsmZBXS0D1TUxHd6nmBpk=;
	b=M6kK4d9rwA4Hp5N257wzdPh4zptGcZCPuDWy9mskFI3SACn3X4z03/xCukMcVbf/GC/A84
	7fakSeuXQltzo5xL0B7PDYz9OLPIh9kDQqVLlhD4EtL9Vkeb8/g+tNEYLTftJIsdGm9co1
	z81irbOwTKsros3zRK2LdmJcCWmqcAs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 3/6] memcg-v1: no need for memcg locking for dirty
 tracking
Message-ID: <gheva2cmexg5pite3nacrxewpu5vhihp6pz5gtlf6aublcbtmd@7szn2jfnwmkx>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-4-shakeel.butt@linux.dev>
 <ZxtBDglHg0C8aRTT@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxtBDglHg0C8aRTT@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 08:56:14AM GMT, Michal Hocko wrote:
> On Thu 24-10-24 18:23:00, Shakeel Butt wrote:
> > During the era of memcg charge migration, the kernel has to be make sure
> > that the dirty stat updates do not race with the charge migration.
> > Otherwise it might update the dirty stats of the wrong memcg. Now with
> > the memcg charge migration deprecated, there is no more race for dirty
> 
> s@deprecated@gone@
> 
> > stat updates and the previous locking can be removed.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> LGTM otherwise
> Acked-by: Michal Hocko <mhocko@suse.com>
> 

Thanks Michal for the review.

Andrew, please fixup the commit message as suggested by Michal when you
pick this series.

