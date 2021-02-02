Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F0D30CD56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 21:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhBBUwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 15:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhBBUwl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:52:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D51C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 12:52:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 34FAB1F451DF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, khazhy@google.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Organization: Collabora
References: <87lfcne59g.fsf@collabora.com> <YAoDz6ODFV2roDIj@mit.edu>
        <87pn1xdclo.fsf@collabora.com>
        <CAOQ4uxjmUbyrghB+QHaoPEwk3sKrQY0Uy1DDTYvSw=O4UbW1LA@mail.gmail.com>
Date:   Tue, 02 Feb 2021 15:51:55 -0500
In-Reply-To: <CAOQ4uxjmUbyrghB+QHaoPEwk3sKrQY0Uy1DDTYvSw=O4UbW1LA@mail.gmail.com>
        (Amir Goldstein's message of "Fri, 22 Jan 2021 09:36:18 +0200")
Message-ID: <87wnvqchw4.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

>> I see.  But the visibility is of a watcher who can see an object, not
>> the application that caused the error.  The fact that the error happened
>> outside the context of the containerized process should not be a problem
>> here, right?  As long as the watcher is watching a mountpoint that can
>> reach the failed inode, that inode should be accessible to the watcher
>> and it should receive a notification. No?
>>
>
> No, because the mount/path is usually not available in file system
> internal context. Even in vfs, many operations have no mnt context,
> which is the reason that some fanotify event types are available for
> FAN_MARK_FILESYSTEM and not for FAN_MARK_MOUNT.

Hi Amir, thanks for the explanation.

> I understand the use case of monitoring a fleet of machines to know
> when some machine in the fleet has a corruption.
> I don't understand why the monitoring messages need to carry all the
> debugging info of that corruption.
>
> For corruption detection use case, it seems more logical to configure
> machines in the fleet to errors=remount-ro and then you'd only ever
> need to signal that a corruption was detected on a filesystem and the
> monitoring agent can access that machine to get more debugging
> info from dmesg or from filesystem recorded first/last error.

The main use-case, as Ted mentioned, is corruption detection in a bunch
of machines and, while allowing them to continue to operate if possible,
schedule the execution of repair tasks and/or data rebuilding of
specific files.  In fact, you are right, we don't need to provide enough
debug information, but the ext4 message, for instance would be
useful. This is more similar to my previous RFC at
https://lwn.net/Articles/839310/

There are other use cases requiring us to provide some more information, in
particular the place where the error was raised in the code and the type
of error, for pattern analysis. So just reporting corruption via sysfs,
for instance, wouldn't suffice.

> You may be able to avoid allocation in fanotify if a group keeps
> a pre-allocated "emergency" event, but you won't be able to
> avoid taking locks in fanotify. Even fsnotify takes srcu_read_lock
> and spin_lock in some cases, so you'd have to be carefull with the
> context you call fsnotify from.
>
> If you agree with my observation that filesystem can abort itself
> on corruption and keep the details internally, then the notification
> of a corrupted state can always be made from a safe context
> sometime after the corruption was detected, regardless of the
> context in which ext4_error() was called.
>
> IOW, if the real world use cases you have are reporting
> writeback errors and signalling that the filesystem entered a corrupted
> state, then fanotify might be the right tool for the job and you should
> have no need for variable size detailed event info.
> If you want a netoops equivalent reporting infrastructure, then
> you should probably use a different tool.

The main reason I was looking at fanotify was the ability to watch
different mountpoints and objects without watching the entire
filesystem.  This was a requirement raised against my previous
submission linked above, which provided only a mechanism based on
watch_queue to watch the entire filesystem.  If we agree to no longer
watch specific subtrees, I think it makes sense to revert to the
previous proposal, and drop fanotify all together for this use case.

-- 
Gabriel Krisman Bertazi
