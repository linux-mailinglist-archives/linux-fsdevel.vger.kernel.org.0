Return-Path: <linux-fsdevel+bounces-7307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B818823837
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE07B249EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096B7208AD;
	Wed,  3 Jan 2024 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gPsth09B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501061EB29
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Jan 2024 17:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704320802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WNpvu2gzuMScXdnQRqcdeB/4ZK6wtPXrPIS2KUikGK4=;
	b=gPsth09BZ4Kj+qu67O01/cycZWcN3j3rVPwJSY+w9cyiCepL5qEIYWu5JPbbLRf5eOOyQj
	/zI6hK58VFP3WacGnfNYNcuGpEQo5CGVhpcFkWucARa6JTFztiS49Br8RNwK9Mx5G28dYR
	aIR1HP5avdVq1FH8qUB8Y9vRFFW5OUg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Carl E. Thompson" <cet@carlthompson.net>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, 
	lsf-pc@lists.linux-foundation.org, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
Message-ID: <bqbkgz5ivpinp3nl6kqqp23ieow2ovglkjeqsukombuqvqm7qv@ihl5ydpo2llk>
References: <i6ugxvkuz7fsnfoqlnmtjyy2owfyr4nlkszdxkexxixxbafhqa@mbsiiiw2jwqi>
 <3EB6181B-2BEA-49BE-A290-AFDE21FFD55F@dubeyko.com>
 <mpvktfgmdhcjohcwg24ssxli3nrv2nu6ev6hyvszabyik2oiam@axba2nsiovyx>
 <74751256-EA58-4EBB-8CA9-F1DD5E2F23FA@dubeyko.com>
 <cgivkso5ugccwkhtd5rh3d6rkoxdrra3hxgxhp5e5m45kn623s@f6hd3iajb3zg>
 <1377749926.626.1704309748383@mail.carlthompson.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1377749926.626.1704309748383@mail.carlthompson.net>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 03, 2024 at 11:22:28AM -0800, Carl E. Thompson wrote:
> 
> > On 2024-01-03 9:52 AM PST Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > ...
> 
> > > Could ZNS model affects a GC operations? Or, oppositely, ZNS model can
> > > help to manage GC operations more efficiently?
> > 
> > The ZNS model only adds restrictions on top of a regular block device,
> > so no it's not _helpful_ for our GC operations.
> 
> > ...
> 
> Could he be talking about the combination of bcachefs and internal
> drive garbage collection rather than only bcachefs garbage collection
> individually? I think the idea with many (most?) ZNS flash drives is
> that they don't have internal garbage collection at all and that the
> drive's erase/write cycles are more directly controlled / managed by
> the filesystem and OS block driver. I think the idea is supposed to be
> that the OS's drivers can manage garbage collection more efficiently
> that any generic drive firmware could. So the ZNS model is not just
> adding restrictions to a regular block devices, it's also shifting the
> responsibility for the drive's **internal** garbage collection to the
> OS drivers which is supposed to improve efficiency.
> 
> Or I could be completely wrong because this is not an area of
> expertise for me.

Yeah nothing really changes for bcachefs, GC-wise. We already have to
have copygc, and it works the same with ZNS as without.

The only difference is that with the SMR hard drivers buckets are a lot
bigger than you'd otherwise pick, but how much that affects you is
entirely dependent on your workload (random overwrites or no).

