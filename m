Return-Path: <linux-fsdevel+bounces-58354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3286B2D15E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 03:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41011BA757D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 01:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFB92135DD;
	Wed, 20 Aug 2025 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gg9GIEH9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97ED1459F6
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653146; cv=none; b=WQwIZ984K900J/Mpb8joFBBAC52U6OhY4E4/Qa4l+DoTKtfQQ6+i7l/JK6eE3vvEEoKs1XncZOAHMskgAwz27Dmwq0Pfm8KqFiaFpMUKbFNMtDvwASFz/n5YAuqA7rMwVXg78D0dJE/imEGVrskDD8eV2R1/3N7T+dKbBDEwicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653146; c=relaxed/simple;
	bh=tzkDKFAR8xWlPva04fv2NHk79SlfL3VC/idJkLxZQoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDH5VNdkzMZTA7ndoE+LGjyzdutZk0oRQQRAynY4sw7yDp3b8trcqDIqw1/NuqMZ3pLa6wLg7arbDXRhEN4GLr1fi6bmfkQWTU7u9Y++ukYmlvYxUlO4vKyfriRDR7teqkd3bEFfVg9G9mgjtLgXHh+Q5iJBj4wgPPmpZ6eUuJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gg9GIEH9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Aug 2025 18:25:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755653141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkCULZqBLybzeAKmdXAlETYe7ipFpeIMTG5c5FRzUbI=;
	b=Gg9GIEH9q0a7IsSCOvI6pgjSSlTFw/gjrCNDmj7tWlpKN4PIdTswdIvd+cUZlvJuG7GQr9
	OFSMilzzKNRMpGI63hXW+N3n18A1v+sA6c7rXhdjxwYhObCMeWB6fhbvXzCX007PY8FYOq
	ULwmU12vfOoJej8VZFbJtEil+/3KH4s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Boris Burkov <boris@bur.io>, akpm@linux-foundation.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com, wqu@suse.com, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v3 2/4] mm: add vmstat for cgroup uncharged pages
Message-ID: <i4hg4g75ywbera643uhtshkj6xrriqi4mi5dg3oga5os3tp6m5@u2dcv2snbiqs>
References: <cover.1755562487.git.boris@bur.io>
 <04b3a5c9944d79072d752c85dac1294ca9bee183.1755562487.git.boris@bur.io>
 <aKPmiWAwDPNdNBUA@casper.infradead.org>
 <tw5qydmgv35v63lhqgl7zbjmgwxm2cujqdjq3deicdz2k26ymh@mnxhz43e6jwl>
 <aKUM49I-4D24MmwZ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKUM49I-4D24MmwZ@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 20, 2025 at 12:46:43AM +0100, Matthew Wilcox wrote:
> On Tue, Aug 19, 2025 at 08:53:59AM -0700, Shakeel Butt wrote:
> > My initial thinking was based on Qu's original proposal which was using
> > root memcg where there will not be any difference between accounted
> > file pages and system wide file pages. However with Boris's change, we
> > can actually get the estimate, as you pointed out, by subtracting the
> > number of accounted file pages from system wide number of file pages.
> > 
> > However I still think we should keep this new metric because of
> > performance reason. To get accounted file pages, we need to read
> > memory.stat of the root memcg which can be very expensive. Basically it
> > may have to flush the rstat update trees on all the CPUs on the system.
> > Since this new metric will be used to calculate system overhead, the
> > high cost will limit how frequently a user can query the latest stat.
> 
> OK, but couldn't we make that argument for anything else?  Like slab,
> say.  Why's "file" memory different?

Good point and I think it does apply to other memory types too. I would
call "file" memory to be more important as it is one of the largest
consumer of DRAM on, at least, Meta infra. Slab needs a bit more thought.
At the system level (i.e. /proc/meminfo), we account at the page (or
slab) level while for memcg, we account per-object (plus obj_cgroup
pointer).

