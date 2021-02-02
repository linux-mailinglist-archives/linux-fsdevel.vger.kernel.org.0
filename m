Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0F30CD17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 21:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhBBU3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 15:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhBBU1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:27:21 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CBAC0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 12:26:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A83861F45204
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     jack@suse.com, viro@zeniv.linux.org.uk, amir73il@gmail.com,
        dhowells@redhat.com, david@fromorbit.com, darrick.wong@oracle.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Organization: Collabora
References: <87lfcne59g.fsf@collabora.com> <YAoDz6ODFV2roDIj@mit.edu>
        <87pn1xdclo.fsf@collabora.com> <YBM6gAB5c2zZZsx1@mit.edu>
Date:   Tue, 02 Feb 2021 15:26:35 -0500
In-Reply-To: <YBM6gAB5c2zZZsx1@mit.edu> (Theodore Ts'o's message of "Thu, 28
        Jan 2021 17:28:16 -0500")
Message-ID: <871rdydxms.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Thu, Jan 21, 2021 at 09:44:35PM -0300, Gabriel Krisman Bertazi wrote:
>> > We might be inside a workqueue handler, for example, so we might not
>> > even running in the same process that had been containerized.  We
>> > might be holding various file system mutexes or even in some cases a
>> > spinlock.
>> 
>> I see.  But the visibility is of a watcher who can see an object, not
>> the application that caused the error.  The fact that the error happened
>> outside the context of the containerized process should not be a problem
>> here, right?  As long as the watcher is watching a mountpoint that can
>> reach the failed inode, that inode should be accessible to the watcher
>> and it should receive a notification. No?
>
> Right.  But the corruption might be an attempt to free a block which
> is already freed.  The corruption is in a block allocation bitmap; and
> at the point where we notice this (in the journal commit callback
> function), ext4 has no idea what inode the block was originally
> associated with, let *alone* the directory pathname that the inode was
> associated with.  So how do we figure out whether or not the watcher
> "can see the object"?
>
> In other words, there is a large set of file system corruptions where
> it is impossible to map it to the question "will it be visible to the
> watcher"?

Thanks for the explanation.  That makes sense to me.  For corruptions
where it is impossible to map to a mountpoint, I thought they could be
considered global filesystem errors, being exposed only to someone
watching the entire filesystem (like FAN_MARK_FILESYSTEM).

But, as you mentioned regarding the google use case, the entire idea of
watching a subtree is a bit beyond the scope of my use-case, and was
only added given the feedback on the previous proposal of this feature.
While nice to have, I don't have the need to watch different mountpoints
for errors, only the entire filesystem.

There was a concern raised against my original submission which did
superblock watching, due to the fact that a superblock is an internal
kernel structure that must not be visible to the userspace.  It was
suggested we should be speaking in terms of paths and mountpoint.  But,
considering the existence of FAN_MARK_FILESYSTEM, I think it is the exact
same object I was looking for when proposing the watch_sb syscall.

>
>> > What follows from that is that it's not really going to be possible to
>> > filter notifications to a subtree.  Furthermore, if fanotify requires
>> > memory allocation, that's going to be problematic, we may not be in a
>> > context where memory allocation is possible.  So for that reason, it's
>> > not clear to me that fanotify is going to be a good match for this use
>> > case.
>> 
>> I see.  Do you think we would be able to refactor the error handling
>> code, such that we can drop spinlocks and do some non-reclaiming
>> allocations at least?  I noticed Google's code seems to survive doing
>> some allocations with GFP_ATOMIC in their internal-to-Google netlink
>> notification system, and even GFP_KERNEL on some other scenarios.  I
>> might not be seeing the full picture though.
>
> It would be ***hard***.  The problem is that the spinlocks may be held
> in functions higher up in the callchain from where the error was
> detected.  So what you're proposing would involve analyzing and
> potentially refactoring *all* of the call sites for the ext4_error*()
> functions.
>
>> I think changing fanotify to avoid allocations in the submission path
>> might be just intrusive enough for the patch to be rejected by Jan. If
>> we cannot do allocations at all, I would suggest I move this feature out
>> of fanotify, but stick with fsnotify, for its ability to link
>> inodes/mntpoints/superblock.
>
> At least for Google's use case, what we really need to know is the
> there has been some kind of file system corruption.  It would be
> *nice* if the full ext4 error message is sent to userspace via
> fsnotify, but for our specific use case, if we lose parts of the
> notification because the file system is so corrupted that fsnotify is
> getting flooded with problems, it really isn't end of the world.  So
> long as we know which block device the file system error was
> associated with, that's actually the most important thing that we need.
>
> In the worst case, we can always ssh to machine and grab the logs from
> /var/log/messages.  And realistically, if the file system is so sick
> that we're getting flooding with gazillion of errors, some of the
> messages are going to get lost whether they are sent via syslog or the
> serial console --- or fsnotify.  So that's no worse than what we all
> have today.  If we can get the *first* error, that's actually going to
> be the most useful one, anyway.
>

The main use case is, as you said, corruption detection with enough
information to allow us to trigger automatic recovery and data rebuilding
tools.  I understand now I can drop most of the debug info, as you
mentioned.  In this sense, the feature looks more like netoops.

But there are other uses that interests us, like pattern analysis of
error locations, such that we can detect and perhaps predict errors.
One idea that was mentioned is if an error occurs frequently enough
in a specific function, there might be a bug in that function.  This is
one of the reasons we are pushing to include function:line in the error
message.

I feel I should go back to something closer to the previous proposal
then, either in the shape of a watch_sb or a new fsnotify mechanism (to
avoid the allocation problems) which only tracks the entire
filesystem.

-- 
Gabriel Krisman Bertazi
