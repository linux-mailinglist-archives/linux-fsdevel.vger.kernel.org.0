Return-Path: <linux-fsdevel+bounces-60870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC3B5248F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 01:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F6D1893659
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 23:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB130E855;
	Wed, 10 Sep 2025 23:14:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA51376F1
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546045; cv=none; b=afBm63vklziZFnPZyIuhrb3/Y8/U4HOb/2Gxb0DlbbCGo3kE9UOBkBbfTiskHI8L3EHCx0aP3o+DxxJk3Lj3IbGa5+GC24efqqaqc3LB9vfT7B4Q5jE7pQqgU6UOtoouoTd0Ob4OmABtOZya4xNrD6W6lwqs9wNVctWsiRjy80I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546045; c=relaxed/simple;
	bh=YouiZybm6fsxgt3B+NXkycY2Qv04Cmqwix70Oe0QR3o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NMQAa/6KUBQD9vsvvHBqJbapAYqf97gn0JTp0ce4aBU7rqVkWvGGC3ZMRQFrVueFVuidjS3jQiyoIeSmcM21UHBcX+g59gjQxMHhv0k5oMKdm0HWalq+KyLZ7FEIi1tS+hPrKZUFvP7nMRKYpfkg4Dt0P3E/zMZzC3SDR1C0lm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uwU0d-0091OY-Uz;
	Wed, 10 Sep 2025 23:13:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Use simple_start_creating() in various places.
In-reply-to: <20250910041658.GQ31600@ZenIV>
References: <>, <20250910041658.GQ31600@ZenIV>
Date: Thu, 11 Sep 2025 09:13:52 +1000
Message-id: <175754603283.2850467.14095867705864477157@noble.neil.brown.name>

On Wed, 10 Sep 2025, Al Viro wrote:
> On Wed, Sep 10, 2025 at 05:12:49AM +0100, Al Viro wrote:
> > On Wed, Sep 10, 2025 at 01:01:49PM +1000, NeilBrown wrote:
> > > On Tue, 09 Sep 2025, Al Viro wrote:
> > > > On Tue, Sep 09, 2025 at 02:43:21PM +1000, NeilBrown wrote:
> > > > 
> > > > >  	d_instantiate(dentry, inode);
> > > > > -	dget(dentry);
> > > > > -fail:
> > > > > -	inode_unlock(d_inode(parent));
> > > > > -	return dentry;
> > > > > +	return simple_end_creating(dentry);
> > > > 
> > > > No.  This is the wrong model - dget() belongs with d_instantiate()
> > > > here; your simple_end_creating() calling conventions are wrong.
> > > 
> > > I can see that I shouldn't have removed the dget() there - thanks.
> > > It is not entirely clear why hypfs_create_file() returns with two
> > > references held to the dentry....
> > > I see now one is added either to ->update_file or the list at
> > > hypfs_last_dentry, and the other is disposed of by kill_litter_super().
> > > 
> > > But apart from that one error is there something broader wrong with the
> > > patch?  You say "the wrong model" but I don't see it.
> > 
> > See below for hypfs:
> 
> ... and see viro/vfs.git#work.persistency for the part of the queue that
> had order already settled down (I'm reshuffling the tail at the moment;
> hypfs commit is still in the leftovers pile - the whole thing used to
> have a really messy topology, with most of the prep work that used to
> be the cause of that topology already in mainline - e.g. rpc_pipefs
> series, securityfs one, etc.)
> 

Thanks.  
I now see you were saying that you are introducing a new model for these
simple_ filesystems and the simple_end_creating() I proposed does not
fit with that model.  Fair enough - I do agree your model is better.  I
assume it will eventually remove DCACHE_DENTRY_KILLED as setting that is
equivalent to clearing the new DCACHE_PERSISTENT.

So I'll leave those filesystems alone for now, though I would like to
change "start_creating()" in debugfs to something like
"debugfs_start_creating()" so I can use the generic name elsewhere.

But are you OK with 1-5 of this series?  I've got a comment addition but no
other changes suggested in review.
May I add the start_creating() rename patch 6?

Thanks,
NeilBrown

