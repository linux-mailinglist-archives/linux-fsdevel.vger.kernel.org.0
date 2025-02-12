Return-Path: <linux-fsdevel+bounces-41552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EBCA31A73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 01:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CC93A585F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 00:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFA75680;
	Wed, 12 Feb 2025 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nhVdtfnr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866217C2;
	Wed, 12 Feb 2025 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319949; cv=none; b=VqoxsPj/6mDnqSkMEuTTKm7GQrp2aa1wiF3CGoCKZt7zGAVZTz9Uk0BgqQnopdsrHQ/l859yilBM8gxQpu9gdGvAD+Jx+FTwwaUk2DcRLLbI0ayj1j3vIRrJA8gxttPOeZbh5BsVGgj/PjYBwwmarQSy1pyTLtVWjOzxt7aTIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319949; c=relaxed/simple;
	bh=Ay6QUoAXXrDtPWLO5gu+ky7Sm0KS7dsK1lsFw0HF+B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNkHA43X+2qIa5WGTaWZeDIsXXmWpvtIOV+iCc1AhSQKrwvT8VbMOB9wyMgABUCIxQR6UspAcwSJi8jSd8cMdKs5Fvfu1z8zkmifNjpOYh+l42BwRUrLCgUyyM7xMxxIM4PjNowkpCRsaHh924fQNkuEcN2Z6g0pJyEkNLHV5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nhVdtfnr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t8/7DuXDouBDy/VQB/4cT4iqHz/xTxDjJ3G/IBr61uE=; b=nhVdtfnrn2akVp8p16S9N3k01v
	lw86jqwgQ2P4I/8Tah42BFliLuxfrx0wgzt1HIX4N+eBFeWN9txv2oAJN/oVvEOsy63FwEFEz4GSi
	Ax0EQkcV4khOJGrp/458QBxfezjFFJPOAtrpB++jubO8BUw34UhVOQeAWuaD8P/M9PL6paQ8MQBfr
	W1hxRU/vGK+7YoNDs3YLVpai+1zHwK2dKEC+lVlvQd1jHP/wmT8aEup81GIBfjknK+noiUzIdHjsk
	sv8QIX59epO8tsHTGkReKWaLY/ksvpEer5c0F0qsCG0mkzSoSw/xQYZIW9CYwL6o0m+S8H4dvn+kh
	q+Sv/ZoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ti0ZT-0000000B6xk-2b4T;
	Wed, 12 Feb 2025 00:25:43 +0000
Date: Wed, 12 Feb 2025 00:25:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/19] VFS: use global wait-queue table for
 d_alloc_parallel()
Message-ID: <20250212002543.GK1977892@ZenIV>
References: <>
 <20250210051553.GY1977892@ZenIV>
 <173931694193.22054.5515495694621442391@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173931694193.22054.5515495694621442391@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 12, 2025 at 10:35:41AM +1100, NeilBrown wrote:

> Without lockdep making the dentry extra large, struct dentry is 192
> bytes, exactly 3 cache lines.  There are 16 entries per 4K slab.
> Now exactly 1/4 of possible indices are used.
> For every group of 16 possible indices, only 0, 4, 8, 12 are used.
> slabinfo says the object size is 256 which explains some of the spread. 

Interesting...

root@cannonball:~# grep -w dentry /proc/slabinfo
dentry            1370665 1410864    192   21    1 : tunables    0    0    0 : slabdata  67184  67184      0

Where does that 256 come from?  The above is on amd64, with 6.1-based debian
kernel and I see the same object size on other boxen (with local configs).

> I don't think there is a good case here for selecting bits from the
> middle of the dentry address.
> 
> If I use hash_ptr(dentry, 8) I get a more uniform distribution.  64000
> entries would hope for 250 per bucket.  Median is 248.  Range is 186 to
> 324 so +/- 25%.
> 
> Maybe that is the better choice.

That's really interesting, considering the implications for m_hash() and mp_hash()
(see fs/namespace.c)...

> > > > 3) the dance with conditional __wake_up() is worth a helper, IMO.
> > 
> > I mean an inlined helper function.
> 
> Yes.. Of course...
> 
> Maybe we should put
> 
> static inline void wake_up_key(struct wait_queue_head *wq, void *key)
> {
> 	__wake_up(wq, TASK_NORMAL, 0, key);
> }
> 
> in include/linux/wait.h to avoid the __wake_up() "internal" name, and
> then use
> 	wake_up_key(d_wait, dentry);
> in the two places in dcache.c, or did you want something
> dcache-specific?

More like
	if (wq)
		__wake_up(wq, TASK_NORMAL, 0, key);
probably...

