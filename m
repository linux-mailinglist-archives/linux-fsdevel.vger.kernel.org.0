Return-Path: <linux-fsdevel+bounces-7243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309918233DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 18:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2CF286BF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CBE1C2AE;
	Wed,  3 Jan 2024 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OJtRakfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DDE1C29D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Jan 2024 12:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704304361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khNmJzjGWlE8eh+xfUBZMGjQlfvaaj0d9UZKWMuJ6bU=;
	b=OJtRakfhfPe0RCNZc6D8+hY4U5YfWw3Wuw4wqYMpHta18s6iQDR65hHQ9k8f4LurxiLz3x
	ArIYf3r/+pxNc0/w1dQz1bmhVY+ox5BrluXTeZpio/WfaWZaV9YxbR5L2li2G4GU7KkDjY
	9k4esUnQP72+xPcZLHv8Tiq062W4ASE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
Message-ID: <cgivkso5ugccwkhtd5rh3d6rkoxdrra3hxgxhp5e5m45kn623s@f6hd3iajb3zg>
References: <i6ugxvkuz7fsnfoqlnmtjyy2owfyr4nlkszdxkexxixxbafhqa@mbsiiiw2jwqi>
 <3EB6181B-2BEA-49BE-A290-AFDE21FFD55F@dubeyko.com>
 <mpvktfgmdhcjohcwg24ssxli3nrv2nu6ev6hyvszabyik2oiam@axba2nsiovyx>
 <74751256-EA58-4EBB-8CA9-F1DD5E2F23FA@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74751256-EA58-4EBB-8CA9-F1DD5E2F23FA@dubeyko.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 03, 2024 at 10:39:50AM +0300, Viacheslav Dubeyko wrote:
> 
> 
> > On Jan 2, 2024, at 7:05 PM, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > 
> > On Tue, Jan 02, 2024 at 11:02:59AM +0300, Viacheslav Dubeyko wrote:
> >> 
> >> 
> >>> On Jan 2, 2024, at 1:56 AM, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >>> 
> >>> LSF topic: bcachefs status & roadmap
> >>> 
> >> 
> >> <skipped>
> >> 
> >>> 
> >>> A delayed allocation for btree nodes mode is coming, which is the main
> >>> piece needed for ZNS support
> >>> 
> >> 
> >> I could miss some emails. But have you shared the vision of ZNS support
> >> architecture for the case of bcachefs already? It will be interesting to hear
> >> the high-level concept.
> > 
> > There's not a whole lot to it. bcache/bcachefs allocation is already
> > bucket based, where the model is that we allocate a bucket, then write
> > to it sequentially and never overwrite until the whole bucket is reused.
> > 
> > The main exception has been btree nodes, which are log structured and
> > typically smaller than a bucket; that doesn't break the "no overwrites"
> > property ZNS wants, but it does mean writes within a bucket aren't
> > happening sequentially.
> > 
> > So I'm adding a mode where every time we do a btree node write we write
> > out the whole node to a new location, instead of appending at an
> > existing location. It won't be as efficient for random updates across a
> > large working set, but in practice that doesn't happen too much; average
> > btree write size has always been quite high on any filesystem I've
> > looked at.
> > 
> > Aside from that, it's mostly just plumbing and integration; bcachefs on
> > ZNS will work pretty much just the same as bcachefs on regular block devices.
> 
> I assume that you are aware about limited number of open/active zones
> on ZNS device. It means that you can open for write operations
> only N zones simultaneously (for example, 14 zones for the case of WDC
> ZNS device). Can bcachefs survive with such limitation? Can you limit the number
> of buckets for write operations?

Yes, open/active zones correspond to write points in the bcachefs
allocator. The default number of write points is 32 for user writes plus
a few for internal ones, but it's not a problem to run with fewer.

> Another potential issue could be the zone size. WDC ZNS device introduces
> 2GB zone size (with 1GB capacity). Could be the bucket is so huge? And could
> btree model of operations works with such huge zones?

Yes. It'll put more pressure on copying garbage collection, but that's
about it.

> Technically speaking, limitation (14 open/active zones) could be the factor of
> performance degradation. Could such limitation doesn’t effect the bcachefs
> performance?

I'm not sure what performance degradation you speak of, but no, that
won't affect bcachefs. 

> Could ZNS model affects a GC operations? Or, oppositely, ZNS model can
> help to manage GC operations more efficiently?

The ZNS model only adds restrictions on top of a regular block device,
so no it's not _helpful_ for our GC operations.

But: since our existing allocation model maps so well to zones, our
existing GC model won't be hurt either, and doing GC in the filesystem
will naturally have benefits in that we know exactly what data is live
and we have access to the LBA mapping so can better avoid fragmentation.

> Do you need in conventional zone? Could bcachefs work without using
> the conventional zone of ZNS device?

Not required, but if zones are all 1GB+ you'd want a small conventional
zone so as to avoid burning two whole zones for the superblock.

