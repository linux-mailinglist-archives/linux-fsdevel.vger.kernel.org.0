Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E99A2FF98F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 01:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAVApZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 19:45:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41964 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbhAVApZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:45:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1C4C61F4486F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     jack@suse.com, viro@zeniv.linux.org.uk, amir73il@gmail.com,
        dhowells@redhat.com, david@fromorbit.com, darrick.wong@oracle.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Organization: Collabora
References: <87lfcne59g.fsf@collabora.com> <YAoDz6ODFV2roDIj@mit.edu>
Date:   Thu, 21 Jan 2021 21:44:35 -0300
In-Reply-To: <YAoDz6ODFV2roDIj@mit.edu> (Theodore Ts'o's message of "Thu, 21
        Jan 2021 17:44:31 -0500")
Message-ID: <87pn1xdclo.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Wed, Jan 20, 2021 at 05:13:15PM -0300, Gabriel Krisman Bertazi wrote:
>>   - The implementation allowed an error string description (equivalent
>>     to what would be thrown in dmesg) that is too short, as it needs to
>>     fit in a single notification.
>
> ... or we need to have some kind of contnuation system where the text
> string is broken across multiple notification, with some kind of
> notification id umber.

Hi Ted,

This is something I'd like to avoid.  A notification broken in several
parts is subject to being partially overwritten by another notification
before it is fully read by userspace.  we can workaround it, of course,
but the added complexity would be unnecessary if only we had a large
enough notification - or one with a flexible size.  Consider that we
have the entire context of the notification at the moment it happens, so
we can always know the size we need before doing any allocations.

>>   - Visibility of objects.  A bind mount of a subtree shouldn't receive
>>     notifications of objects outside of that bind mount.
>
> So this is scope creep beyond the original goals of the project.  I
> understand that there is a desire by folks in the community to support
> various containerization use cases where only only a portion of file
> system is visible in a container due to a bind mount.
>
> However, we need to recall that ext4_error messages can originate in
> fairly deep inside the ext4 file system.  They indicate major problems
> with the file system --- the kind that might require drastic system
> administration reaction.  As such, at the point where we discover a
> problem with an inode, that part of the ext4 code might not have
> access to the pathname that was used to originally access the inode.
>
> We might be inside a workqueue handler, for example, so we might not
> even running in the same process that had been containerized.  We
> might be holding various file system mutexes or even in some cases a
> spinlock.

I see.  But the visibility is of a watcher who can see an object, not
the application that caused the error.  The fact that the error happened
outside the context of the containerized process should not be a problem
here, right?  As long as the watcher is watching a mountpoint that can
reach the failed inode, that inode should be accessible to the watcher
and it should receive a notification. No?

I don't mean to sound dense.  I understand the memory allocation &
locking argument.  But I don't understand why an error identified in a
workqueue context would be different from an error in a process
context.

> What follows from that is that it's not really going to be possible to
> filter notifications to a subtree.  Furthermore, if fanotify requires
> memory allocation, that's going to be problematic, we may not be in a
> context where memory allocation is possible.  So for that reason, it's
> not clear to me that fanotify is going to be a good match for this use
> case.

I see.  Do you think we would be able to refactor the error handling
code, such that we can drop spinlocks and do some non-reclaiming
allocations at least?  I noticed Google's code seems to survive doing
some allocations with GFP_ATOMIC in their internal-to-Google netlink
notification system, and even GFP_KERNEL on some other scenarios.  I
might not be seeing the full picture though.

I think changing fanotify to avoid allocations in the submission path
might be just intrusive enough for the patch to be rejected by Jan. If
we cannot do allocations at all, I would suggest I move this feature out
of fanotify, but stick with fsnotify, for its ability to link
inodes/mntpoints/superblock.

-- 
Gabriel Krisman Bertazi
