Return-Path: <linux-fsdevel+bounces-36728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096419E8BC3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 07:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D731639CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFBC214816;
	Mon,  9 Dec 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LE9EDBqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81F1D555
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733727544; cv=none; b=WnWtXDRfZtZuay48m7vQWcbea+hCHmFzIRaP9AKN94084ZNStVySCxmC/bcS3v7RUYZ4svl8yBjEfGfO07ktErjBwg0rxF/oDr3mJrMVwateQR6mUcj+QiY52OZrDtIWneoDGoOjGZaA4QpsdGh1l69FSatuRwG8h3HcdlQfbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733727544; c=relaxed/simple;
	bh=bEHwLM+AAYWaKQlsjsuBov0izrC81prrOSgkDjNp2fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4se2bZ0usCnhWd8j5aw4ixRjkWCDqvNfGunvwPHGzCD9SW4RV+ziXZXXNsQtaNyTKSrNQvkfCd3Im3H9uSzwHuir9CAzGZo+ZV6U/uqs05xbmGKaXn2mMEJ/qCpcjaso3lYwpqrNRmtlmBV9oQrBKvFdiUd7nklv1MwC+gcApk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LE9EDBqV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g6EeXdZxv5YNnvN6v+NOWNVrzcztOBPwhpJU5y9x2dk=; b=LE9EDBqVyoIrqvTlVFLcK4oSHg
	0f6vpL3kgvQKU+aaCpdhQu+BZPtc8op24cWwE6j6TKDS2wkAA4n13WQe59HV/bCzxDQDLeJ3u9TM5
	oJ49yzoIBbnCBltootSHhfGXmHmMg0q8G5FMjh4Ju28DRrpvh3wamaQ4pKT8nYNB6kXD/2tSeqR9K
	LNkuayoil+yJ/sHPYSB+MBEDKpOR8i8VJkIGU8+SIpnuPxXXSF/SL4mG8AFbwEu3hXARNzaKvi0Hr
	LMhQ3oa6xk39Cj8waLShTIOsDS7HZe0jxV9feH6YsGE5VCPllhyoQKYkggSAWaVkdT8kmXXi/dTEk
	+BZJeZuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKXjP-00000006TEy-0qgG;
	Mon, 09 Dec 2024 06:58:59 +0000
Date: Mon, 9 Dec 2024 06:58:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241209065859.GW3387508@ZenIV>
References: <20241209035251.GV3387508@ZenIV>
 <gopibqjep5lcxs2zdwdenw4ynd4dd5jyhok7cpxdinu6h6c53n@zalbyoznwzfb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gopibqjep5lcxs2zdwdenw4ynd4dd5jyhok7cpxdinu6h6c53n@zalbyoznwzfb>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 09, 2024 at 07:33:00AM +0100, Mateusz Guzik wrote:
> On Mon, Dec 09, 2024 at 03:52:51AM +0000, Al Viro wrote:
> > There's a bunch of places where we are accessing dentry names without
> > sufficient protection and where locking environment is not predictable
> > enough to fix the things that way; take_dentry_name_snapshot() is
> > one variant of solution.  It does, however, have a problem - copying
> > is cheap, but bouncing ->d_lock may be nasty on seriously shared dentries.
> > 
> > How about the following (completely untested)?
> > 
> > Use ->d_seq instead of grabbing ->d_lock; in case of shortname dentries
> > that avoids any stores to shared data objects and in case of long names
> > we are down to (unavoidable) atomic_inc on the external_name refcount.
> >     
> > Makes the thing safer as well - the areas where ->d_seq is held odd are
> > all nested inside the areas where ->d_lock is held, and the latter are
> > much more numerous.
> 
> Is there a problem retaining the lock acquire if things fail?
> 
> As in maybe loop 2-3 times, but eventually take the lock to guarantee forward
> progress.
> 
> I don't think there is a *real* workload where this would be a problem,
> but with core counts seen today one may be able to purposefuly introduce
> stalls when running this.

By renaming the poor sucker back and forth in a tight loop?  Would be hard
to trigger on anything short of ramfs...

Hell knows - if anything, I was thinking about a variant that would
*not* loop at all, but take seq as an argument and return whether it
had been successful.  That could be adapted to build such thing -
with "pass ->d_seq sampled value (always even) *or* call it with
the name stabilized in some other way (e.g. ->d_lock, rename_lock or
->s_vfs_rename_mutex held) and pass 1 as argument to suppress checks"
for calling conventions.

The thing is, when its done to a chain of ancestors of some dentry,
with rename_lock retries around the entire thing, running into ->d_seq
change pretty much guarantees that you'll need to retry the whole thing
anyway.

