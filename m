Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB87A315D5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 03:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhBJCet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 21:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235460AbhBJCdL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:33:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92B7664E2E;
        Wed, 10 Feb 2021 02:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924350;
        bh=56Npdp7gZSFXlVDxKr9wxiW97Fxfs7OqSk81pypZscY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYPRtAqmV6U4rrhsT0hBRE15fJ+DE2iwA353cbSUVkKXxThRXp9ohmLiiDPjW5rIC
         MRttXNMZmuWlLR71gTv0i4AoFNKegNFjjJB+ydz1eXihJ8TlDnnf0hsBO939A2Dp6w
         ItuFPEFibTJdRcO1V8X+JKNNPCUsfKtRlw/BT0HE4HUbJFzDY70Kgy1Gjvs1709xx1
         yKpf2e/TKd/Npp12jdPInc+jv2wgQYp6R0gfGg99Sc54j3r80WO+KrgSf32G69TDwn
         tACLXpUwpZgIIDqwhXqkD63/ZkY8qeiRlgvRRxaA7eYo/BlOdUejnZvN+2ASbvmpLY
         8bxHgvjHhgaqQ==
Date:   Tue, 9 Feb 2021 18:32:30 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        jack@suse.com, viro@zeniv.linux.org.uk, amir73il@gmail.com,
        dhowells@redhat.com, darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <20210210023230.GF7187@magnolia>
References: <YBM6gAB5c2zZZsx1@mit.edu>
 <871rdydxms.fsf@collabora.com>
 <YBnTekVOQipGKXQc@mit.edu>
 <87wnvi8ke2.fsf@collabora.com>
 <20210208221916.GN4626@dread.disaster.area>
 <YCHgkReD1waTItKm@mit.edu>
 <20210209085501.GS4626@dread.disaster.area>
 <YCLM9NPSwsWFPu4t@mit.edu>
 <20210210005207.GE7187@magnolia>
 <YCNDNEc2KBsi8g4L@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCNDNEc2KBsi8g4L@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:21:40PM -0500, Theodore Ts'o wrote:
> On Tue, Feb 09, 2021 at 04:52:07PM -0800, Darrick J. Wong wrote:
> > 
> > I definitely don't want to implement string parsing for xfs_scrub.
> > 
> > The kernel already has enough information to fill out the struct
> > xfs_scrub_metadata structure for userspace in case it decides to repair.
> 
> I suspect anything which is specific enough for xfs_scrub is going to
> be *significantly* file system dependent.  And in the past, attempts
> to do some kind of binary tag-length-value scheme has generally gotten
> vetoed.  If it's just "there's something wrong with inode number 42",
> that's one thing.  But if it's, "position 37 of the 3rd btree interior
> node is out of order", how in the world is that supposed to be
> generic?
> 
> Taking a step back, it seems that there are a number of different use
> cases that people have been discussing on this thread.  One is
> "there's something wrong with the file system", so the file system
> should be taken off-line for repair and/or fail over the primary
> server to the secondary/backup server.
> 
> Yet another use case might be "the file system is getting full, so
> please expand the LVM and resize the file system".  (This is a bit
> more complex since different system administrators and different
> systems may want different trigger points, from 75%, 80%, 95%, or
> "we've already delivered ENOSPC to the application so there are
> user-visible failures", but presumably this can be configured, with
> perhaps sime fixed number of configured trigger points per file
> system.)
> 
> Both of these are fairly generic, and don't required exposing a file
> system's detailed, complex object hierarchies to userspace.  But if
> the goal is pushing out detailed metadata information sufficient for
> on-line file system repair, that both seems to be a massive case of
> scope creep, and very much file system specific, and not something
> that could be easily made generic.
> 
> If the XFS community believes it can be done, perhaps you or Dave
> could come up with a specific proposal, as opposed to claiming that
> Gabriel's design is inadequate because it doesn't meet with XFS's use
> case?  And perhaps this is a sufficiently different set of
> requirements that it doesn't make sense to try to have a single design
> that covers all possible uses of a "file system notification system".

I did in [1], but vger is being slow and hasn't yet delivered it to me
yet.  At least they try to hit lore first now, I guess?

--D

[1] https://lore.kernel.org/linux-fsdevel/20210210000932.GH7190@magnolia/T/#m268c5a244cb7bd749b9c029e1d7c3f00d194b181

> Regards,
> 
> 					- Ted
