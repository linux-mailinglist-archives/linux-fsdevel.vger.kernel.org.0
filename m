Return-Path: <linux-fsdevel+bounces-30027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82E9850DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 04:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7CD282FFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 02:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6931487FF;
	Wed, 25 Sep 2024 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dKfgOgVd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BAA13D53A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727230389; cv=none; b=lOYAS5W9rmabIz+i/8iSOjya4A8aqF2B+oK1dpTliegt9wRGjXdEU5EaUhJyoGPMRGunVHbT4TtExuRj785rrWu5AG1l/C2I4h05B0OYRwM/c5hN+++MVw3PjAcz56aazMuOynDgiW8qVzRY33De1kXNMfaVPf9syAvwzMs81Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727230389; c=relaxed/simple;
	bh=80X2Gp24nNMX8cXLPZsZvliNWxzeYD78Zp8JZk8dOng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUZnE3tpJkhyWc3QrzPYuFvwyNH+JOSOOWJNXXZTU2sNJaG5rQe6Flbgjoo9aqcTD79l4BGDHXT5CLOSxCY0hBSlk6jvi+m+X0DfpifrPoe7xPESQ5gvW9KrVS7gmipyyN5nDMycgBJMBg1eorwT5USOPHQEFX+eJfKHDX5F9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dKfgOgVd; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Sep 2024 22:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727230386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBkMp/0eODCP6liVuxv3l7JuWVErFP5s89WUrTpn8/s=;
	b=dKfgOgVdYMp8dbkclyYFcyazgNGRS2mgqFwJkwWIUg4o4iBZbkmEmt8s8jBYaiRM8qxFcw
	IKpCHY9kzGlZFMnL3sc56kSDJXCqrl/78cyNyM/LoUNtUsssrnvE2aWfXhMd0iRWzr9/5z
	amWebubHMpGQw50NZNEEhqgllvST3gk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <v5lvhjauvcx27fcsyhyugzexdk7sik7an2soyxtx5dxj3oxjqa@gbvyu2kc7vpy>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <74sgzrvtnry4wganaatcmxdsfwauv6r33qggxo27yvricrzxvq@77knsf6cfftl>
 <ZvIzNlIPX4Dt8t6L@dread.disaster.area>
 <dia6l34faugmuwmgpyvpeeppqjwmv2qhhvu57nrerc34qknwlo@ltwkoy7pstrm>
 <ZvNgmoKgWF0TBXP8@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvNgmoKgWF0TBXP8@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 25, 2024 at 11:00:10AM GMT, Dave Chinner wrote:
> > Eh? Of course it'd have to be coherent, but just checking if an inode is
> > present in the VFS cache is what, 1-2 cache misses? Depending on hash
> > table fill factor...
> 
> Sure, when there is no contention and you have CPU to spare. But the
> moment the lookup hits contention problems (i.e. we are exceeding
> the cache lookup scalability capability), we are straight back to
> running a VFS cache speed instead of uncached speed.

The cache lookups are just reads; they don't introduce scalability
issues, unless they're contending with other cores writing to those
cachelines - checking if an item is present in a hash table is trivial
to do locklessly.

But pulling an inode into and then evicting it from the inode cache
entails a lot more work - just initializing a struct inode is
nontrivial, and then there's the (multiple) shared data structures you
have to manipulate.

> Keep in mind that not having a referenced inode opens up the code to
> things like pre-emption races. i.e. a cache miss doesn't prevent
> the current task from being preempted before it reads the inode
> information into the user buffer. The VFS inode could bei
> instantiated and modified before the uncached access runs again and
> pulls stale information from the underlying buffer and returns that
> to userspace.

Yeah, if you're reading from a buffer cache that doesn't have a lock
that does get dicy - but for bcachefs where we're reading from a btree
node that does have a lock it's quite manageable.

And incidentally this sort of "we have a cache on top of the btree, but
sometimes we have to do direct access" is already something that comes
up a lot in bcachefs, primarily for the alloc btree. _Tons_ of fun, but
doesn't actually come up here for us since we don't use the vfs inode
cache as a writeback cache.

Now, for some completely different sillyness, there's actually _three_
levels of caching for inodes in bcachefs: btree node cache, btree key
cache, then the vfs cache. In the first two inodes are packed down to
~100 bytes so it's not that bad, but it does make you go "...what?". It
would be nice in theory to collapse - but the upside is that we don't
have the interactions between the vfs inode cache and journalling that
xfs has.

But if vfs inodes no longer have their own lifetime like you've been
talking about, that might open up interesting possibilities.

