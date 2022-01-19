Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484654936CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 10:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352791AbiASJFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 04:05:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38692 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351966AbiASJFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:05:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6B9B61455;
        Wed, 19 Jan 2022 09:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D595C004E1;
        Wed, 19 Jan 2022 09:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642583151;
        bh=ZMOPZrlt2cfOSpv918Af7deBI9py27ecaOS2zZN7Fts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hk155RLaUI34TSdu/3GM/6cpGvyn1xUZLY3b5Hjh/SQ3Wcp90FhOyK91omzs4vaLP
         dC0S2YhRU37+kkL/twHPgX90Lr+heQWM0QHrlv3zkp5bIRQa8t0TwcHbZ8L4nVadxH
         /m+6uzkvqiEX5g9Y07El5k5avzpTn9EkNkcGdBmu8T6QpuupWR/DEv1h+Ttw4V7lUy
         POLBBRxOcfDGR9aefBrKC7UGyFXA8UpozwKV2BTaeO56GXMftmhiSq0zC17RfOs0eM
         QnFot1Rxish0OOwZ0JfMxo2hXVqq4AA2zXq0T0v8VTDxst29ODbAViC26bRYO7Ycdx
         JORN+q7lEZuaw==
Date:   Wed, 19 Jan 2022 10:05:45 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Brian Foster <bfoster@redhat.com>, Ian Kent <raven@themaw.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <20220119090545.b25trkg2kjigf3fi@wittgenstein>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <YeWxHPDbdSfBDtyX@zeniv-ca.linux.org.uk>
 <20220118082911.rsmv5m2pjeyt6wpg@wittgenstein>
 <YeblIix0fyXyBipW@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeblIix0fyXyBipW@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 04:04:50PM +0000, Al Viro wrote:
> On Tue, Jan 18, 2022 at 09:29:11AM +0100, Christian Brauner wrote:
> > On Mon, Jan 17, 2022 at 06:10:36PM +0000, Al Viro wrote:
> > > On Mon, Jan 17, 2022 at 04:28:52PM +0000, Al Viro wrote:
> > > 
> > > > IOW, ->free_inode() is RCU-delayed part of ->destroy_inode().  If both
> > > > are present, ->destroy_inode() will be called synchronously, followed
> > > > by ->free_inode() from RCU callback, so you can have both - moving just
> > > > the "finally mark for reuse" part into ->free_inode() would be OK.
> > > > Any blocking stuff (if any) can be left in ->destroy_inode()...
> > > 
> > > BTW, we *do* have a problem with ext4 fast symlinks.  Pathwalk assumes that
> > > strings it parses are not changing under it.  There are rather delicate
> > > dances in dcache lookups re possibility of ->d_name contents changing under
> > > it, but the search key is assumed to be stable.
> > > 
> > > What's more, there's a correctness issue even if we do not oops.  Currently
> > > we do not recheck ->d_seq of symlink dentry when we dismiss the symlink from
> > > the stack.  After all, we'd just finished traversing what used to be the
> > > contents of a symlink that used to be in the right place.  It might have been
> > > unlinked while we'd been traversing it, but that's not a correctness issue.
> > > 
> > > But that critically depends upon the contents not getting mangled.  If it
> > > *can* be screwed by such unlink, we risk successful lookup leading to the
> > 
> > Out of curiosity: whether or not it can get mangled depends on the
> > filesystem and how it implements fast symlinks or do fast symlinks
> > currently guarantee that contents are mangled?
> 
> Not sure if I understand your question correctly...
> 
> 	Filesystems should guarantee that the contents of string returned
> by ->get_link() (or pointed to by ->i_link) remains unchanged for as long
> as we are looking at it (until fs/namei.c:put_link() that drops it or
> fs/namei.c:drop_links() in the end of pathwalk).  Fast symlinks or not -
> doesn't matter.

Yep, got that.

> 
> 	The only cases where that does not hold (there are two of them in
> the entire kernel) happen to be fast symlinks.	Both cases are bugs.

Ok, that's what I was essentially after whether or not they were bugs in
the filesystems or it's a generic bug.

> ext4 case is actually easy to fix - the only reason it ends up mangling
> the string is the way ext4_truncate() implements its check for victim
> being a fast symlink (and thus needing no work).  It gets disrupted
> by zeroing ->i_size, which we need to do in this case (inode removal).
> That's not hard to get right.

Oh, I see, it zeroes i_size and erases i_data which obviously tramples
the fast symlink contents.

Given that ext4 makes use of i_flags for their ext4 inode containers why
couldn't this just be sm like

#define EXT4_FAST_SYMLINK	        0x<some-free-value>

	if (EXT4_I(inode)->i_flags & EXT4_FAST_SYMLINK)
		return <im-a-fast-symlink>;

? Which seems simpler and more obvious to someone reading that code than
logic based on substracting blocks or checking i_size.
