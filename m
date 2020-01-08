Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15B97133955
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 04:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgAHDAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 22:00:16 -0500
Received: from fieldses.org ([173.255.197.46]:53894 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgAHDAP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:00:15 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 2AD691C81; Tue,  7 Jan 2020 22:00:15 -0500 (EST)
Date:   Tue, 7 Jan 2020 22:00:15 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20200108030015.GB5476@fieldses.org>
References: <20191220024936.GA380394@chrisdown.name>
 <20191220213052.GB7476@magnolia>
 <20191221101652.GA494948@chrisdown.name>
 <20200107173530.GC944@fieldses.org>
 <20200107174407.GA666424@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107174407.GA666424@chrisdown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 05:44:07PM +0000, Chris Down wrote:
> J. Bruce Fields writes:
> >I thought that (dev, inum) was supposed to be unique from creation to
> >last unlink (and last close), and (dev, inum, generation) was supposed
> >to be unique for all time.
> 
> Sure, but I mean, we don't really protect against even the first case.
> 
> >>I didn't mention generation because, even though it's set on tmpfs
> >>(to prandom_u32()), it's not possible to evaluate it from userspace
> >>since `ioctl` returns ENOTTY. We can't ask userspace applications to
> >>introspect on an inode attribute that they can't even access :-)
> >
> >Is there any reason not to add IOC_GETVERSION support to tmpfs?
> >
> >I wonder if statx should return it too?
> 
> We can, but that seems like a tangential discussion/patch series.
> For the second case especially, that's something we should do
> separately from this patchset,

Oh, of course, I'm not objecting to this patchset at all, it's a "why
not also do this?" question.

> since this demonstrably fixes issues encountered in production, and
> extending a user-facing APIs is likely to be a much more extensive
> discussion.

Though if it's a question of just a new implementation of an existing
ioctl, I doubt it's such a big deal.  (Not that I'm volunteering to
write the patch.)

--b.
