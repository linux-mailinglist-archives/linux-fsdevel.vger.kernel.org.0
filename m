Return-Path: <linux-fsdevel+bounces-14055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A6E877101
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 13:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70B5B21079
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042073A1B6;
	Sat,  9 Mar 2024 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="and6M29Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF439850
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709986558; cv=none; b=a+iJ8noDM1LLU83V1JCspJqd1Q8jg7wfmayrLRJ/bkI+W9k4Vncw5XM9xzPv1lJzIuDTWvXgm3L6jC9Bift9+6g2OJmADhpIlJvLbY2P+Ll9j/zi9XXFBNGJ5MV7qAGTbzxyFyr7XjByFxXlI/WtjPgRUV1b9WUgpiRxvmZd0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709986558; c=relaxed/simple;
	bh=LLk+nM0K2NXga73NICfooQV982tp97pwncsTG7QQzso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl8MK/5FPFFHzG7RLxz5lUqIPEXBcJBzOLWn6AmCMBGMJWSRqijRX7S2UTwI/fF50tuA6qTN4P14X+5KRu8M7VKRfDOiKU0G0nppPbJX5NxvBsoCcoBs8IGvpNP1j8ub9dJZyhL/8oSZt7OyPoGyJDoI+JM81M08VtMWCNLuyGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=and6M29Y; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 9 Mar 2024 07:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709986554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ztZwkYv2v4Kz4rLl8cXQntBezHYMi/iU5TaojHjCtJM=;
	b=and6M29Y4UnPQ+rzg7Nxgqh1IeRjVdT3hbZWP0Ca6cKWf2x3vvO7E8n+QDrKYTIM/wnd/f
	nAhaSj3gw47THDf7k9Odv0beydGzcubRy4GZ3pBWqkrDvZYe1P3I/NioyxOkhnql0BR1jO
	OVYbbtbOnMF82SjTcrslweCY4lOTNwM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <yi6fha4mz325222zfud5mlxypvl6clkkh7ko3eoyofiz3oltf2@5mhb6jqmiqtb>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <CAEg-Je96OKs_LOXorNVj1a1=e+1f=-gw34v4VWNOmfKXc6PLSQ@mail.gmail.com>
 <i2oeask3rxxd5w4k7ikky6zddnr2qgflrmu52i7ah6n4e7va26@2qmghvmb732p>
 <CAEg-Je_URgYd6VJL5Pd=YDGQM=0T5tspfnTvgVTMG-Ec1fTt6g@mail.gmail.com>
 <2uk6u4w7dp4fnd3mrpoqybkiojgibjodgatrordacejlsxxmxz@wg5zymrst2td>
 <20240308165633.GO6184@frogsfrogsfrogs>
 <6czkpcm4gxcjik3drcy6eys6lannfk55oowdesem2qr3gfgobw@lblo3vzck43e>
 <4517677900bd6a29f4763abe868ab953b477772b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4517677900bd6a29f4763abe868ab953b477772b.camel@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 09, 2024 at 06:46:54AM -0500, Jeff Layton wrote:
> On Fri, 2024-03-08 at 12:13 -0500, Kent Overstreet wrote:
> > On Fri, Mar 08, 2024 at 08:56:33AM -0800, Darrick J. Wong wrote:
> > > On Fri, Mar 08, 2024 at 11:48:31AM -0500, Kent Overstreet wrote:
> > > > It's a new feature, not a bugfix, this should never get backported. And
> > > > I the bcachefs maintainer wrote the patch, and I'm submitting it to the
> > > > VFS maintainer, so if it's fine with him it's fine with me.
> > > 
> > > But then how am I supposed to bikeshed the structure of the V2 patchset
> > > by immediately asking you to recombine the patches and spit out a V3?
> > > 
> > > </sarcasm>
> > > 
> > > But, seriously, can you update the manpage too?
> > 
> > yeah, where's that at?
> > 
> 
>     https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
> 
> 
> > > Is stx_subvol a u64
> > > cookie where userspace mustn't try to read anything into its contents?
> > > Just like st_ino and st_dev are (supposed) to be?
> > 
> > Actually, that's up for debate. I'm considering having the readdir()
> > equivalent for walking subvolumes return subvolume IDs, and then there'd
> > be a separate call to open by ID.
> > 
> > Al's idea was to return open fds to child subvolumes, then userspace can
> > get the path from /proc; that's also a possibility.
> > 
> > The key thing is that with subvolumes it's actually possible to do an
> > open_by_id() call with correct security checks on pathwalking - because
> > we don't have hardlinks so there's no ambiguity.
> > 
> > Or we might do it getdents() style and return the path directly.
> > 
> > But I think userspace is going to want to work with the volume
> > identifiers directly, which is partly why I'm considering why other
> > options might be cleaner.
> > 
> > Another thing to consider: where we're going with this is giving
> > userspace a good efficient interrface for recursive tree traversal of
> > subvolumes, but it might not be a bad idea to do that for mountpoints as
> > well - similar problems, similar scalability issues that we might want
> > to solve eventually.
> > 
> 
> All of that's fine, but Darrick's question is about whether we should
> ensure that these IDs are considered _opaque_. I think they should be.
> 
> We don't want to anyone to fall into the trap of trying to convey extra
> info to userland about the volumes via this value. It should only be
> good for uniquely identifying the volume.
> 
> We'll also need to document the scope of uniqueness. I assume we'll want
> to define this as only being unique within a single filesystem? IOW, if
> I have 2 bcachefs filesystems that are on independent devices, these
> values may collide? Someone wanting to uniquely identify a subvolume on
> a system will need to check both the st_dev and the st_vol, correct?

they're small integers, not UUIDs, so yes

