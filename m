Return-Path: <linux-fsdevel+bounces-5845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D954A81111A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9412F281AC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 12:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319128E2A;
	Wed, 13 Dec 2023 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p4I5dWh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB3593
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 04:28:25 -0800 (PST)
Date: Wed, 13 Dec 2023 07:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702470503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2SHrjOLltjYuc+gz9t4OxGv8R3eQGhOC7inTMaN4EA=;
	b=p4I5dWh1X7WHSCcaHKvlH8SSpPkHwmzCgRGzRtCKzDZgNUJj9ngMYn/kPdQG3CC/RkS3wA
	RyfIJO8nCppOMIcAjjzLbGn1fY8iXbvQyj1DrEUyij2mEOFfq3Hgs4Pii/SODbVXild6Ig
	LEz6fZNfFFFndyOzjf2DSywahC5GZDc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>,
	NeilBrown <neilb@suse.de>, linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx
Message-ID: <20231213122820.umqmp3yvbbvizfym@moria.home.lan>
References: <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>
 <20231212152016.GB142380@mit.edu>
 <a0f820a7-3cf5-4826-a15b-e536abb5b1de@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f820a7-3cf5-4826-a15b-e536abb5b1de@molgen.mpg.de>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 13, 2023 at 08:37:57AM +0100, Donald Buczek wrote:
> Probably not for the specific applications I mentioned (backup, mirror,
> accounting). These are intended to run continuously, slowly and unnoticed
> in the background, so they are memory and i/o throttled via cgroups anyway
> and one is even using sleep after so-and-so many stat calls to reduce
> its impact.
> 
> If they could tell a directory from a snapshot, I would probably stop them
> from walking into snapshots. And if not, the snapshot id is all that is
> needed to tell a clone in a snapshot from a hardlink. So these don't really
> need the filehandle.

Perhaps we should allocate a bit for differentiating a snapshot from a
non snapshot subvolume?

> In the thread it was assumed, that there are other (unspecified)
> applications which need the filehandle and currently use name_to_handle_at().
> 
> I though it was self-evident that a single syscall to retrieve all
> information atomically is better than a set of syscalls. Each additional
> syscall has overhead and you need to be concerned with the data changing
> between the calls.

All other things being equal, yeah it would be. But things are never
equal :)

Expanding struct statx is not going to be as easy as hoped, so we need
to be a bit careful how we use the remaining space, and since as Dave
pointed out the filehandle isn't needed for checking uniqueness unless
nlink > 1 it's not really a hotpath in any application I can think of.

(If anyone does know of an application where it might matter, now's the
time to bring it up!)

> Userspace nfs server as an example of an application, where visible
> performance is more relevant, was already mentioned by someone else.

I'd love to hear confirmation from someone more intimately familiar with
NFS, but AFAIK it shouldn't matter there; the filehandle exists to
support resuming IO or other operations to a file (because the server
can go away and come back). If all the client did was a stat, there's no
need for a filehandle - that's not needed until a file is opened.

