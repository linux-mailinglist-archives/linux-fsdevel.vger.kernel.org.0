Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA8317465
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 00:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhBJXaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 18:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhBJXae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:30:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D5FC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 15:29:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 796571F457C9
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     tytso@mit.edu, jack@suse.com, viro@zeniv.linux.org.uk,
        amir73il@gmail.com, dhowells@redhat.com, david@fromorbit.com,
        darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Organization: Collabora
References: <87lfcne59g.fsf@collabora.com> <20210210000932.GH7190@magnolia>
Date:   Wed, 10 Feb 2021 18:29:44 -0500
In-Reply-To: <20210210000932.GH7190@magnolia> (Darrick J. Wong's message of
        "Tue, 9 Feb 2021 16:09:32 -0800")
Message-ID: <87tuqj1oyf.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> Hi Gabriel,
>
> Sorry that it has taken me nearly three weeks to respond to this; I've
> been buried in XFS refactoring for 5.12. :(

Hi Darrick,

Thanks for description of both use cases. It helped a lot to clarify my
thoughts.

> This structure /could/ include an instruction pointer for more advanced
> reporting, but it's not a hard requirement to have such a thing.  As far
> as xfs is concerned, something decided the fs was bad, and the only
> thing to do now is to recover.  I don't think it matters critically
> whether the notices are presented via fanotify or watch_queue.
>
> The tricky problem here is (I think?) how to multiplex different
> filesystem types wanting to send corruption reports to userspace.  I
> suppose you could define the fs metadata error format as:
>
> 	[struct fanotify_event_metadata]
> 	[optional struct fanotify_event_info_fid]
> 	[u32 magic code corresponding to statvfs.f_type?]
> 	[fs-specific blob of data And]

This seems similar to what I proposed, minus the first use case i was
integrating.

> here then you'd use fanotify_event_metadata.event_len to figure out the
> length of the fs-specific blob.  That way XFS could export the short
> structure I outlined above, and ext4 can emit instruction pointer
> addresses or strings or whatever else you and Ted settle on.
>
> If that sounds like "Well you go plumb in the fanotify bits with just
> enough information for dispatching and then we'll go write our own xfs
> specific thing"... yep. :)
>
> To be clear: I'm advocating for cleaving these two usescases completely
> apart, and not mixing them at all like what you defined below, because I
> now think these are totally separate use cases.

Yes, this makes a lot of sense.


>>   On the other hand, fanotify already has support for the visibility
>>   semantics we are looking for. fsnotify allows an inode to notify only
>>   its subtree, mountpoints, or the entire filesystem, depending on the
>>   watcher flags, while an equivalent support would need to be written
>>   from scratch for watch_queue.  fanotify also has in-band overflow
>>   handling, already implemented.  Finally, since fanotify supports much
>>   larger notifications, there is no need to link separate notifications,
>>   preventing buffer overruns from erasing parts of a notification chain.
>> 
>>   fanotify is based on fsnotify, and the infrastructure for the
>>   visibility semantics is mostly implemented by fsnotify itself.  It
>>   would be possible to make error notifications a new mechanism on top
>>   of fsnotify, without modifying fanotify, but that would require
>>   exposing a very similar interface to userspace, new system calls, and
>>   that doesn't seem justifiable since we can extend fanotify syscalls
>>   without ABI breakage.
>
> <nod> AFAICT it sounds like fanotify is a good fit for that first
> usecase I outlined.  It'd probably work for both.

The main advantage of the fanotify/fsnotify api, in my opinion, is the
hooking to a specific file or the entire file system.  This makes it
specially useful for the first use case you explained, even if some
changes are needed to drop the CAP_SYS_ADMIN requirement.

But for the second case, which interests me a bit more, can you clarify
if the same infrastructure of watching specific files is indeed
necessary?  In your use case description, there would be a single daemon
watching the entire filesystem, which would use an equivalent (fanotify
or not) of FAN_MARK_FILESYSTEM. It seems there isn't a need to watch
specific files for the second use case, as long as the events identify
the object that triggered the error. In other words, you always want to
watch the entire filesystem.

If we are indeed treating this second use case separately from the
first, it seems to fit a much simpler model of a filesystem-wide "pipe"
where different parts of the filesystem can dump different errors, no?

watch_queue provisions the filtering specific types of events.  Maybe we
can extend its filtering capabilities?

>> 3 Proposal
>> ==========
>> 
>>   The error notification framework is based on fanotify instead of
>>   watch_queue.  It is exposed through a new set of marks FAN_ERROR_*,
>>   exposed through the fanotify_mark(2) API.
>> 
>>   fanotify (fsnotify-based) has the infrastructure in-place to link
>>   notifications happening at filesystem objects to mountpoints and to
>>   filesystems, and already exposes an interface with well defined
>>   semantics of how those are exposed to watchers in different
>>   mountpoints or different subtrees.
>> 
>>   A new message format is exposed, if the user passed
>>   FAN_REPORT_DETAILED_ERROR fanotify_init(2) flag.  FAN_ERROR messages
>>   don't have FID/DFID records.
>> 
>>   A FAN_REPORT_DETAILED_ERROR record has the same struct
>>   fanotify_event_metadata header, but it is followed by one or more
>>   additional information record as follows:
>> 
>>   struct fanotify_event_error_hdr {
>>   	struct fanotify_event_info_header hdr;
>>   	__u32 error;
>>         __u64 inode;
>>         __u64 offset;
>>   }
>> 
>>   error is a VFS generic error number that can notify generic conditions
>>   like EFSCORRUPT. If hdr.len is larger than sizeof(struct
>>   fanotify_event_error_hdr), this structure is followed by an optional
>>   filesystem specific record that further specifies the error,
>>   originating object and debug data. This record has a generic header:
>> 
>>   struct fanotify_event_fs_error_hdr {
>>   	struct fanotify_event_error_hdr hdr;
>>         __kernel_fsid_t fsid;
>>         __u32 fs_error;
>>   }
>> 
>>   fs_error is a filesystem specific error record, potentially more
>>   detailed than fanotify_event_error.hdr.error . Each type of filesystem
>
> Er... is fs_error supposed to be a type code that tells the program that
> the next byte is the start of a fanotify_event_ext4_inode_error
> structure?

Yes.  Sorry for the mistake.  fs_error would identify a filesystem
specific blob (record), that would follow in the same notification.

Thanks,

-- 
Gabriel Krisman Bertazi
