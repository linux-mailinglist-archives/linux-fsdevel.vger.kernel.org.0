Return-Path: <linux-fsdevel+bounces-47279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F3FA9B4AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 18:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA4F1BA6850
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC5B2949E2;
	Thu, 24 Apr 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7yETnR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07ED29345D;
	Thu, 24 Apr 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513473; cv=none; b=K4gd7jGXyZQlrXIQ8fvOIJCXhX3i9xpcxie4L39TE/gsBkwCiIP0ePU0pFh1gwoZfY+c19G0eSIwHFCkx8lGHVpLmfnQCH0nCSv4ogADJwo0SyjmqHAOWc+tV2aDilmiQi7QBA4lMZmT7fXT7dv0mGyaO99aOYSt1rS3cXClIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513473; c=relaxed/simple;
	bh=O30a3FalLBME3kBJ1cSEVuQL9s7QShLEWwr9eGBk9y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDdgLsKDl+Qc1xeFKgldwIz1gYu8rW2t6Ew5gQRNal1lrbFEc/PCKe6tLGvxdKFFSMtxImLYPgU/IbZEI4A5rcyBRMcP9DObkjH0jWFoofM/GVjp83S9O35nuu0cINtZchbyzREvAT9V4ADmGvtgnh1T/FG7STjKIhqLV4CX1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7yETnR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B12C4CEE3;
	Thu, 24 Apr 2025 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745513473;
	bh=O30a3FalLBME3kBJ1cSEVuQL9s7QShLEWwr9eGBk9y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7yETnR4wlf3sc5MnAFm9WBuY2XqtUAT+VUhj9x1LRWN4+0PvhSk0eRuNt8nrNd4+
	 q7Ofx48Yi4/IyPg/5JG3jwHCxVplyqYgiQ6t/KxDUDz92Z1jRama+jvFEOwoumITWG
	 UaeByzPzQHFLUX9rIyAkC+f9cgb+u0hP56+1dwUPoYw7sJuq17KIPBQooCxstMAqM1
	 xHu4rABYUpIvUTyuE/3VPFocxx63TVpclETkuhV1ecoDNRRVqzTe90MReNULFMvIvo
	 9Mju2vZw07f9TCaXAc9hje+QFS13g0ao/OQmxS96ahILjE5j7pwmWqBkcZD7ARy3p5
	 Q5XZsoyy4Iy0Q==
Date: Thu, 24 Apr 2025 12:51:12 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, trondmy@kernel.org,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Initial NFS client support for RWF_DONTCACHE
Message-ID: <aApsAAYJMMRtKr8h@kernel.org>
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
 <c608d941-c34d-4cf9-b635-7f327f0fd8f4@oracle.com>
 <aAkFrow1KTUmA_cH@casper.infradead.org>
 <97033bd0-dcf9-4049-8e44-060b7e854952@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97033bd0-dcf9-4049-8e44-060b7e854952@oracle.com>

On Wed, Apr 23, 2025 at 11:30:21AM -0400, Chuck Lever wrote:
> On 4/23/25 11:22 AM, Matthew Wilcox wrote:
> > On Wed, Apr 23, 2025 at 10:38:37AM -0400, Chuck Lever wrote:
> >> On 4/23/25 12:25 AM, trondmy@kernel.org wrote:
> >>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>>
> >>> The following patch set attempts to add support for the RWF_DONTCACHE
> >>> flag in preadv2() and pwritev2() on NFS filesystems.
> >>
> >> Hi Trond-
> >>
> >> "RFC" in the subject field noted.
> >>
> >> The cover letter does not explain why one would want this facility, nor
> >> does it quantify the performance implications.
> >>
> >> I can understand not wanting to cache on an NFS server, but don't you
> >> want to maintain a data cache as close to applications as possible?
> > 
> > If you look at the original work for RWF_DONTCACHE, you'll see this is
> > the application providing the hint that it's doing a streaming access.
> > It's only applied to folios which are created as a result of this
> > access, and other accesses to these folios while the folios are in use
> > clear the flag.  So it's kind of like O_DIRECT access, except that it
> > does go through the page cache so there's none of this funky alignment
> > requirement on the userspace buffers.
> 
> OK, was wondering whether this behavior was opt-in; sounds like it is.
> Thanks for setting me straight.

Yes, its certainly opt-in (requires setting a flag for each use).
Jens added support in fio relatively recently, see:
https://git.kernel.dk/cgit/fio/commit/?id=43c67b9f3a8808274bc1e0a3b7b70c56bb8a007f

Looking ahead relative to NFSD, as you know we've discussed exposing
per-export config controls to enable use of DONTCACHE.  Finer controls
(e.g. only large sequential IO) would be more desirable but I'm not
aware of a simple means to detect such workloads with NFSD.

Could it be that we'd do well to carry through large folio support in
NFSD and expose a configurable threshold that if met or exceeded then
DONTCACHE used?

What is the status of large folio support in NFSD?  Is anyone actively
working on it?

Thanks,
Mike

