Return-Path: <linux-fsdevel+bounces-44625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07894A6ABC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 18:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9CE189B80D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7B1E47CA;
	Thu, 20 Mar 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lgoPZTMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835F1E5B6D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490949; cv=none; b=WCIvHzi5pbwH6BLDInlKXkdPej/a0YuzFQzv79SovlkkTRqdEO+gTuQL4tHQ0AnpKH9Lun2FLbicrjmfcpC1Lskh5wlLiKQKYMfbvL62Fcm2XmPnCA8h0i6o0kMRCdwOCOoQlxumNURSa3kQc5wpaCFfFb70AlHBM3WVc8Laqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490949; c=relaxed/simple;
	bh=/d0va4dLjUtsDB6CWfXTmYQPUhBEQPoX5KoZpbfHCek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZGcjRFCqadLfS/ktUmqu10jO7l8WGbZyiRH5vrKQ/35MznsicNLIDAzbHNsxDgT5/PqIxe0eb6JNEvOAm3odXsQEgvv9QLjGem+ww3LO2PwTLaT3SOmWiDfs4hOQPFIpCJl+/jhjMHQnrVQDsUl5toiUY1rbWuDbannbRJ+EaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lgoPZTMT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Mar 2025 13:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742490935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7s1xDgsOv+sRUn3GW9sZwLPbvv26z1k4+WQa1WnKyPY=;
	b=lgoPZTMTgRRH3dyng9foNARrKYK0AJHiDR7FXiZQ8/A5TBw+yWJzj5VGORRQxutTvnTFBw
	A1Adrzg8LdeYQRmkxKOJnSmQCRmrKHVYXlXZKBo0VJivQLGkX0OYKbTQlN8LzIm1peujmw
	5F5Qkc0BBnMT9Qon5bvwTiynIYkMYQY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Stoffel <john@stoffel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org, 
	Roland Vet <vet.roland@protonmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/14] better handling of checksum errors/bitrot
Message-ID: <l2dd3a7lcqoug22jtkh2kxgfkhq5eqcipkqzaklnqod4quqo6m@orkkyd434mh4>
References: <20250311201518.3573009-1-kent.overstreet@linux.dev>
 <26584.35900.850011.320586@quad.stoffel.home>
 <avmzp2nswsowb3hg2tcrb6fv2djgkiw7yl3bgdn4dnccuk4yti@ephd5sxy5b7w>
 <26585.34711.506258.318405@quad.stoffel.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26585.34711.506258.318405@quad.stoffel.home>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 18, 2025 at 10:47:51AM -0400, John Stoffel wrote:
> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
> 
> > On Mon, Mar 17, 2025 at 04:55:24PM -0400, John Stoffel wrote:
> >> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
> >> 
> >> > Roland Vet spotted a good one: currently, rebalance/copygc get stuck if
> >> > we've got an extent that can't be read, due to checksum error/bitrot.
> >> 
> >> > This took some doing to fix properly, because
> >> 
> >> > - We don't want to just delete such data (replace it with
> >> >   KEY_TYPE_error); we never want to delete anything except when
> >> >   explicitly told to by the user, and while we don't yet have an API for
> >> >   "read this file even though there's errors, just give me what you
> >> >   have" we definitely will in the future.
> >> 
> >> So will open() just return an error?  How will this look from
> >> userspace?  
> 
> > Not the open, the read - the typical case is only a single extent goes
> > bad; it's like any other IO error.
> 
> Good. But then how would an application know we got a checksum error
> for data corruption?  Would I have to update all my code to do another
> special call when I get a read/write error to see if it was a
> corruption issue?  

We can only return -EIO via the normal IO paths.

> 
> >> > - Not being able to move data is a non-option: that would block copygc,
> >> >   device removal, etc.
> >> 
> >> > - And, moving said extent requires giving it a new checksum - strictly
> >> >   required if the move has to fragment it, teaching the write/move path
> >> >   about extents with bad checksums is unpalateable, and anyways we'd
> >> >   like to be able to guard against more bitrot, if we can.
> >> 
> >> Why does it need a new checksum if there are read errors?  What
> >> happens if there are more read errors?   If I have a file on a
> >> filesystem which is based in spinning rust and I get a single bit
> >> flip, I'm super happy you catch it.  
> 
> > The data move paths very strictly verify checksums as they move data
> > around so they don't introduce bitrot.
> 
> Good.  This is something I really liked as an idea in ZFS, happy to
> see it coming to bcachefs as well. 

Coming? It's been that way since long before bcachefs was merged.

> > The aforementioned poison bit ensures that you still get the error from
> > the original checksum error when you read that data - unless you use an
> > appropriate "give it to me anyways" API.
> 
> So this implies that I need to do extra work to A) know I'm on
> bcachefs filesystem, B) that I got a read/write error and I need to do
> some more checks to see what the error exactly is.  
> 
> And if I want to re-write the file I can either copy it to a new name,
> but only when I use the new API to say "give me all the data, even if
> you have a checksum error".  

This is only if you want an API for "give me possibly corrupted data".

That's pretty niche.

> > The process doing the read() can't be killed during this, no. If
> > requested this could be changed, but keep in mind retries are limited in
> > number.
> 
> How limited?  And in the worse case, if I have 10 or 100 readers of a
> file with checksum errors, now I've blocked all those processes for X
> amount of time.  Will this info be logged somewhere so a sysadm could
> possibly just do an 'rm' on the file to nuke it, or have some means of
> forcing a scrub?  

The poison bit means we won't attempt additional retries on an extent,
once we've reached the (configurable) limit. Future IOs will just return
an error without doing the actual read, since we already know it's bad.

So no, this won't bog down your system.

> > Nothing else is "locked up", everything else proceeds as normal.
> 
> But is the filesystem able to be unmounted when there's a locked up
> process?  I'm just thinking in terms of system shutdowns when you have
> failing hardware and want to get things closed as cleanly as possible
> since you're going to clone the underlying block device onto new media
> ASAP in an offline manner.  

The number of retries defaults to 3, and there's no real reason to make
it more than 5, so this isn't a real change over the current situatino
where drives sometimes take forever on a read as they're going out.

Eventually we could add a configurable hard limit on the amount of time
we spend trying to service an individual read, but that's niche so
further down the road.

