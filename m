Return-Path: <linux-fsdevel+bounces-13154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD6C86BFD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 05:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAE51F2528E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 04:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC63381D9;
	Thu, 29 Feb 2024 04:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wts7wgzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B637714
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 04:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709180451; cv=none; b=GKY4QSqiXt102sx2LK78NycUu6Uu4xtS4wx/g52uKH/6CpsbgrPlVoQiliHO7xGkSdiTtiTAmvPMDu4rHnsdw0t5frsHvwF26/g6+sLqrH4tSbJRwD0t6CDAS/W9ZQ7jGbAy9v1nrTukmN1Lnbf1y5OPPilCVbsIJKIuGNaxMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709180451; c=relaxed/simple;
	bh=hcSlDbDKVUgDHJvT+u6IKypA1ISn1TV7wqAPgGMc5LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDBSkFaBfC2TDbLxBeunIe3fYzNTQPa1CylkygeL7gcqQLWsavQNV/seIFktWAtcObXgaj84xJY9EVEHZ6//jVxc+bFDR3qJs3NWICOVsaB7YHfCDInzqbwbkNkMBN1V3EzdbLje+7ZATtnElgEDYxTzfr26J9XSRnAX4qUBfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wts7wgzf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 23:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709180447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CoBY5rm4B2EvsrqolQfczRwQYyqCVgMrb4NJhBXYSY=;
	b=wts7wgzfsRR94He/W5cHbuX4aNc2eWGDi/2ZqB+HMG96w772Uq3dAFBDmNG1/OSD0HH7Uh
	SNg8W5EdfnON28K6ad5Lc4d8wfMuVw1/PVe0LSrcr6wT5V7NZ7B6LmGHhoSdzT5LiUsv/O
	0Ue5o3fSYntDMhobDpIutFkxG1VnJc8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <zam4ymn6b7dlw23rhrzh2hj7u5cpybid2bl3ujfrnu2yjyztnb@io6xvtc5vzdn>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <Zd/d/w2bFfHs5nTe@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd/d/w2bFfHs5nTe@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 12:29:35PM +1100, Dave Chinner wrote:
> On Wed, Feb 28, 2024 at 07:37:58PM +0000, Matthew Wilcox wrote:
> > On Tue, Feb 27, 2024 at 09:19:47PM +0200, Amir Goldstein wrote:
> > > On Tue, Feb 27, 2024 at 8:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > Hello!
> > > >
> > > > Recent discussions [1] suggest that greater mutual understanding between
> > > > memory reclaim on the one hand and RCU on the other might be in order.
> > > >
> > > > One possibility would be an open discussion.  If it would help, I would
> > > > be happy to describe how RCU reacts and responds to heavy load, along with
> > > > some ways that RCU's reactions and responses could be enhanced if needed.
> > > >
> > > 
> > > Adding fsdevel as this should probably be a cross track session.
> > 
> > Perhaps broaden this slightly.  On the THP Cabal call we just had a
> > conversation about the requirements on filesystems in the writeback
> > path.  We currently tell filesystem authors that the entire writeback
> > path must avoid allocating memory in order to prevent deadlock (or use
> > GFP_MEMALLOC).  Is this appropriate?
> 
> The reality is that filesystem developers have been ignoring that
> "mm rule" for a couple of decades. It was also discussed at LSFMM a
> decade ago (2014 IIRC) without resolution, so in the mean time we
> just took control of our own destiny....
> 
> > It's a lot of work to assure that
> > writing pagecache back will not allocate memory in, eg, the network stack,
> > the device driver, and any other layers the write must traverse.
> >
> > With the removal of ->writepage from vmscan, perhaps we can make
> > filesystem authors lives easier by relaxing this requirement as pagecache
> > should be cleaned long before we get to reclaiming it.
> 
> .... by removing memory reclaim page cache writeback support from
> the filesystems entirely.
> 
> IOWs, this rule hasn't been valid for a -long- time, so maybe it
> is time to remove it. :)

It's _never_ been valid, the entire IO stack allocates memory.

This is what GFP_NOIO/GFP_NOFS is for, and additionaly mempools/biosets.
If mm can't satisfy the allocation, they should fail it, and then the IO
path will have fallbacks (but they wil be slow, i.e. iodepth will be
greatly limited).

