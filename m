Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5252EB3BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 20:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbhAETxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 14:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbhAETxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:53:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB7C061574;
        Tue,  5 Jan 2021 11:52:51 -0800 (PST)
Received: from localhost (unknown [IPv6:2804:431:c7f5:406e:8979:35df:a78d:8843])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0994F1F45900;
        Tue,  5 Jan 2021 19:52:48 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 4/8] vfs: Add superblock notifications
Organization: Collabora
References: <20201208003117.342047-1-krisman@collabora.com>
        <20201208003117.342047-5-krisman@collabora.com>
        <20201210220914.GG4170059@dread.disaster.area>
        <87ft4cukor.fsf@collabora.com>
        <20201218010645.GA1199812@dread.disaster.area>
Date:   Tue, 05 Jan 2021 16:52:43 -0300
In-Reply-To: <20201218010645.GA1199812@dread.disaster.area> (Dave Chinner's
        message of "Fri, 18 Dec 2020 12:06:45 +1100")
Message-ID: <87o8i340vo.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Dave, thanks for the feedback.

Dave Chinner <david@fromorbit.com> writes:
> On Fri, Dec 11, 2020 at 05:55:32PM -0300, Gabriel Krisman Bertazi wrote:
>> > Fundamentally, though, I'm struggling to understand what the
>> > difference between watch_mount() and watch_sb() is going to be.
>> > "superblock" watches seem like the wrong abstraction for a path
>> > based watch interface. Superblocks can be shared across multiple
>> > disjoint paths, subvolumes and even filesystems.
>> 
>> As far as I understand the original patchset, watch_mount was designed
>> to monitor mountpoint operations (mount, umount,.. ) in a sub-tree,
>> while watch_sb monitors filesystem operations and errors.  I'm not
>> working with watch_mount, my current interest is in having a
>> notifications mechanism for filesystem errors, which seemed to fit
>> nicely with the watch_sb patchset for watch_queue.
>
> <shrug>
>
> The previous patches are not part of your proposal, and if they are
> not likely to be merged, then we don't really care what they are
> or what they did. The only thing that matters here is what your
> patchset is trying to implement and whether that is appropriate or
> not...

I think the mistake was only mentioning them in the commit message, in
the first place.

>> > The path based user API is really asking to watch a mount, not a
>> > superblock. We don't otherwise expose superblocks to userspace at
>> > all, so this seems like the API is somewhat exposing internal kernel
>> > implementation behind mounts. However, there -is- a watch_mount()
>> > syscall floating around somewhere, so it makes me wonder exactly why
>> > we need a second syscall and interface protocol to expose
>> > essentially the same path-based watch information to userspace.
>> 
>> I think these are indeed different syscalls, but maybe a bit misnamed.
>> 
>> If not by path, how could we uniquely identify an entire filesystem?
>
> Exactly why do we need to uniquely identify a filesystem based on
> it's superblock? Surely it's already been identified by path by the
> application that registered the watch?

I see.  In fact, we don't, as that is an internal concept. The patch
abuses the term superblock to refer to the entire filesystem.  I should
to operate in terms of mounts.

>> Maybe pointing to a block device that has a valid filesystem and in the
>> case of fs spawning through multiple devices, consider all of them?  But
>> that would not work for some misc filesystems, like tmpfs.
>
> It can't be block device based at all - think NFS, CIFS, etc. We
> can't use UUIDs, because not all filesystem have them, and snapshots
> often have identical UUIDs.
>
> Really, I think "superblock" notifications are extremely problematic
> because the same superblock can be shared across different security
> contexts. I'm not sure what the solution might be, but I really
> don't like the idea of a mechanism that can report errors in objects
> outside the visibility of a namespaced container to that container
> just because it has access to some path inside a much bigger
> filesystem that is mostly out of bounds to that container.

I see.  To solve the container visibility problem, would it suffice to
forbid watching partial mounts of a filesystem?  For instance, either
the watched path is the root_sb or the API returns EINVAL.  This limits
the usability of the API to whoever controls the root of the filesystem,
which seems to cover the use case of the host monitoring an entire
filesystem.  Would this limitation be acceptable?

Alternatively, we want something similar to fanotify FAN_MARK_FILESYSTEM
semantics? I suppose global errors (like an ext4 fs abort) should be
reported individually for every mountpoint, while inode errors are only
reported for each mountpoint for which the object is accessible.

-- 
Gabriel Krisman Bertazi
