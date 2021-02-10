Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC11315D32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 03:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhBJCZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 21:25:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50915 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235339AbhBJCW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:22:58 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11A2LeK7017895
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Feb 2021 21:21:41 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 94ED015C39E3; Tue,  9 Feb 2021 21:21:40 -0500 (EST)
Date:   Tue, 9 Feb 2021 21:21:40 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        jack@suse.com, viro@zeniv.linux.org.uk, amir73il@gmail.com,
        dhowells@redhat.com, darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <YCNDNEc2KBsi8g4L@mit.edu>
References: <87pn1xdclo.fsf@collabora.com>
 <YBM6gAB5c2zZZsx1@mit.edu>
 <871rdydxms.fsf@collabora.com>
 <YBnTekVOQipGKXQc@mit.edu>
 <87wnvi8ke2.fsf@collabora.com>
 <20210208221916.GN4626@dread.disaster.area>
 <YCHgkReD1waTItKm@mit.edu>
 <20210209085501.GS4626@dread.disaster.area>
 <YCLM9NPSwsWFPu4t@mit.edu>
 <20210210005207.GE7187@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210005207.GE7187@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:52:07PM -0800, Darrick J. Wong wrote:
> 
> I definitely don't want to implement string parsing for xfs_scrub.
> 
> The kernel already has enough information to fill out the struct
> xfs_scrub_metadata structure for userspace in case it decides to repair.

I suspect anything which is specific enough for xfs_scrub is going to
be *significantly* file system dependent.  And in the past, attempts
to do some kind of binary tag-length-value scheme has generally gotten
vetoed.  If it's just "there's something wrong with inode number 42",
that's one thing.  But if it's, "position 37 of the 3rd btree interior
node is out of order", how in the world is that supposed to be
generic?

Taking a step back, it seems that there are a number of different use
cases that people have been discussing on this thread.  One is
"there's something wrong with the file system", so the file system
should be taken off-line for repair and/or fail over the primary
server to the secondary/backup server.

Yet another use case might be "the file system is getting full, so
please expand the LVM and resize the file system".  (This is a bit
more complex since different system administrators and different
systems may want different trigger points, from 75%, 80%, 95%, or
"we've already delivered ENOSPC to the application so there are
user-visible failures", but presumably this can be configured, with
perhaps sime fixed number of configured trigger points per file
system.)

Both of these are fairly generic, and don't required exposing a file
system's detailed, complex object hierarchies to userspace.  But if
the goal is pushing out detailed metadata information sufficient for
on-line file system repair, that both seems to be a massive case of
scope creep, and very much file system specific, and not something
that could be easily made generic.

If the XFS community believes it can be done, perhaps you or Dave
could come up with a specific proposal, as opposed to claiming that
Gabriel's design is inadequate because it doesn't meet with XFS's use
case?  And perhaps this is a sufficiently different set of
requirements that it doesn't make sense to try to have a single design
that covers all possible uses of a "file system notification system".

Regards,

					- Ted
