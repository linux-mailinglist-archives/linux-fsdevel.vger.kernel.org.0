Return-Path: <linux-fsdevel+bounces-32812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A801E9AEDF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA681F23125
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5AF1FC7F8;
	Thu, 24 Oct 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pCmhJlLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763281FAEEB
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790785; cv=none; b=bqn9qKEHRJTLsVSw3Fp/4vD1lv6GcByfsLDSxBj4aIic2tUe8uEEZLzxc825R6Ez+YYxQQbyy6KllHqZUsx92Hw6pTnpyWVpkTbQjtgCK7aYX06+z/XPFceZA2MpNsBJ00KI/py+w2IqnRaQkrqvpWtn7Xmgn06hsvgPGAe6FNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790785; c=relaxed/simple;
	bh=mZy3gH8hiW0A+IkBao8g6kJ+dPCUrqLtDAb39XcdETw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GACBPnjoI0Y3bYF2HSVXZRqVLSn5pVHafvEBiA6iRvr0gdZY3Ed3sqbHNRmc05pjrHPhyBB8thM38u9hevR3Pglld5xKVV6xdkrbxlWsCRCdFoAD8oGxbQUxa/PWIpkhZHnA26QEti1+NtfJAJ3mHE7nQaqy0exZNdjGJru9hBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pCmhJlLo; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 10:26:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729790780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8R1hlFXC1iEAhNiTAY04zaD5qomPk8wLiMSHdfUvjQA=;
	b=pCmhJlLo+awlJ1B+3t7IW8LaVA2tC/Qps/pAgSG+bCpusILq+Ruj7SJ7JKPnGAqKrv5PS+
	59E6MzrcspYqHjiGVg8MNQzKvH6jXBn5h4scJe0DSYcr0dPkbgO96SYo2O7IR0U5Bl9L5J
	BY8u54XjMBQQspmHOK1gwT1Tm9bKv8Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
Message-ID: <7w4xusjyyobyvacm6ogc3q2l26r2vema5rxlb5oqlhs4hpqiu3@dfbde5arh3rg>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev>
 <Zxp63b9WlI4sTwWk@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxp63b9WlI4sTwWk@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 04:50:37PM GMT, Roman Gushchin wrote:
> On Wed, Oct 23, 2024 at 11:57:12PM -0700, Shakeel Butt wrote:
> > The memcg v1's charge move feature has been deprecated. There is no need
> > to have any locking or protection against the moving charge. Let's
> > proceed to remove all the locking code related to charge moving.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks Roman for the review. Based on Michal's question, I am planning
to keep the RCU locking in the next version of this patch and folowup
with clear understanding where we really need RCU and where we don't.

