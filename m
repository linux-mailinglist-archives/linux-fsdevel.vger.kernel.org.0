Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEA430811C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 23:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhA1W3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 17:29:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54004 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231308AbhA1W3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:29:16 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10SMSGDb012771
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 17:28:17 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5C43715C344F; Thu, 28 Jan 2021 17:28:16 -0500 (EST)
Date:   Thu, 28 Jan 2021 17:28:16 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, viro@zeniv.linux.org.uk, amir73il@gmail.com,
        dhowells@redhat.com, david@fromorbit.com, darrick.wong@oracle.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <YBM6gAB5c2zZZsx1@mit.edu>
References: <87lfcne59g.fsf@collabora.com>
 <YAoDz6ODFV2roDIj@mit.edu>
 <87pn1xdclo.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn1xdclo.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:44:35PM -0300, Gabriel Krisman Bertazi wrote:
> > We might be inside a workqueue handler, for example, so we might not
> > even running in the same process that had been containerized.  We
> > might be holding various file system mutexes or even in some cases a
> > spinlock.
> 
> I see.  But the visibility is of a watcher who can see an object, not
> the application that caused the error.  The fact that the error happened
> outside the context of the containerized process should not be a problem
> here, right?  As long as the watcher is watching a mountpoint that can
> reach the failed inode, that inode should be accessible to the watcher
> and it should receive a notification. No?

Right.  But the corruption might be an attempt to free a block which
is already freed.  The corruption is in a block allocation bitmap; and
at the point where we notice this (in the journal commit callback
function), ext4 has no idea what inode the block was originally
associated with, let *alone* the directory pathname that the inode was
associated with.  So how do we figure out whether or not the watcher
"can see the object"?

In other words, there is a large set of file system corruptions where
it is impossible to map it to the question "will it be visible to the
watcher"?

> > What follows from that is that it's not really going to be possible to
> > filter notifications to a subtree.  Furthermore, if fanotify requires
> > memory allocation, that's going to be problematic, we may not be in a
> > context where memory allocation is possible.  So for that reason, it's
> > not clear to me that fanotify is going to be a good match for this use
> > case.
> 
> I see.  Do you think we would be able to refactor the error handling
> code, such that we can drop spinlocks and do some non-reclaiming
> allocations at least?  I noticed Google's code seems to survive doing
> some allocations with GFP_ATOMIC in their internal-to-Google netlink
> notification system, and even GFP_KERNEL on some other scenarios.  I
> might not be seeing the full picture though.

It would be ***hard***.  The problem is that the spinlocks may be held
in functions higher up in the callchain from where the error was
detected.  So what you're proposing would involve analyzing and
potentially refactoring *all* of the call sites for the ext4_error*()
functions.

> I think changing fanotify to avoid allocations in the submission path
> might be just intrusive enough for the patch to be rejected by Jan. If
> we cannot do allocations at all, I would suggest I move this feature out
> of fanotify, but stick with fsnotify, for its ability to link
> inodes/mntpoints/superblock.

At least for Google's use case, what we really need to know is the
there has been some kind of file system corruption.  It would be
*nice* if the full ext4 error message is sent to userspace via
fsnotify, but for our specific use case, if we lose parts of the
notification because the file system is so corrupted that fsnotify is
getting flooded with problems, it really isn't end of the world.  So
long as we know which block device the file system error was
associated with, that's actually the most important thing that we need.

In the worst case, we can always ssh to machine and grab the logs from
/var/log/messages.  And realistically, if the file system is so sick
that we're getting flooding with gazillion of errors, some of the
messages are going to get lost whether they are sent via syslog or the
serial console --- or fsnotify.  So that's no worse than what we all
have today.  If we can get the *first* error, that's actually going to
be the most useful one, anyway.

Cheers,

					- Ted
