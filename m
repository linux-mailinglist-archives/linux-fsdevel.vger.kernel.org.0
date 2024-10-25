Return-Path: <linux-fsdevel+bounces-32917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786809B0BEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904601F24B55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E340170A31;
	Fri, 25 Oct 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xt9HZ8Lp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED220C333
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878098; cv=none; b=ZLgSn09YTqc+FfzOTYzE5msZp0IHnrYvFJxOBw8x3yQpsmjkNI50QiVRzzv8oZELG4NHhu1UzHCSm2pgO6tYtAiC8NPpaYiNUyR9EVx6rzNcwtwl1KpGkKZSp9ARmSl1KNfXADFULNcTuFBlDFf28/m8g9g+XB/jeH+vPcED4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878098; c=relaxed/simple;
	bh=2RBlXLQZoCaiCxjO14j+rIfvPMbXRySz2nWQZStbs6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXbowLK0r+tXpmbS/hpRbf46w8ypjs9DcLPqD85o69ytHZzEKFpbU3giYVDKAZOrKctRdfEmhlDM9emxboe+73QywMt5uA6s162/KPGx8XHwF4k44iy0ZsQNvVFnhBwF8tG4q2/IsJpzmtz8+cmmQ84GMmrK9aw39gQfpbEImr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xt9HZ8Lp; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 17:41:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729878093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0BJAPoUjObadlMhJZKFif9mHshkgJU0/EUBmX2NSKg=;
	b=Xt9HZ8LpSdOLOPCFpPosbEPy0tc3k1RJ0QjSY5ojm2eQOKgtudY3e7F8FDCeOzj8EiAHUM
	FKApXi2ObslHu188LxiDZ72PqQ3GiQGiS7gamhKCCMfZG5Ex+iZOX9SeudelkmN+nPsZoG
	VDdPR8YDIDn40s4tDxv+zRV8egUYADA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
Message-ID: <ZxvYRpil9K-aVAe6@google.com>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-6-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 06:23:02PM -0700, Shakeel Butt wrote:
> While updating the generation of the folios, MGLRU requires that the
> folio's memcg association remains stable. With the charge migration
> deprecated, there is no need for MGLRU to acquire locks to keep the
> folio and memcg association stable.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>


