Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269CD2FF488
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 20:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbhAUTbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 14:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbhAUTFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:05:06 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451AEC061786
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 10:56:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3C4581F45F40
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, jack@suse.com, viro@zeniv.linux.org.uk,
        amir73il@gmail.com, dhowells@redhat.com, david@fromorbit.com,
        darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Organization: Collabora
References: <87lfcne59g.fsf@collabora.com>
        <20210121114453.GD24063@quack2.suse.cz>
Date:   Thu, 21 Jan 2021 15:56:12 -0300
In-Reply-To: <20210121114453.GD24063@quack2.suse.cz> (Jan Kara's message of
        "Thu, 21 Jan 2021 12:44:53 +0100")
Message-ID: <87a6t2dsqb.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:
> On Wed 20-01-21 17:13:15, Gabriel Krisman Bertazi wrote:
>>   fanotify is based on fsnotify, and the infrastructure for the
>>   visibility semantics is mostly implemented by fsnotify itself.  It
>>   would be possible to make error notifications a new mechanism on top
>>   of fsnotify, without modifying fanotify, but that would require
>>   exposing a very similar interface to userspace, new system calls, and
>>   that doesn't seem justifiable since we can extend fanotify syscalls
>>   without ABI breakage.
>
> I agree fanotify could be used for propagating the error information from
> kernel to userspace. But before we go to design how exactly the events
> should look like, I'd like to hear a usecase (or usecases) for this
> feature. Because the intended use very much determines which information we
> need to propagate to userspace and what flexibility we need there.

Hi Jan,

Thanks for the review.

My user is a cloud provider who wants to monitor several machines,
potentially with several volumes each, for metadata and data corruption
that might require attention from a sysadmin.  They would run a watcher
for each filesystem of each machine and consolidate the information.
Right now, they have a solution in-house to monitor ext4, which
basically exports to userspace any kind of condition that would trigger
one of the ext4_error_* functions.

We need to monitor a bit more than just writeback errors, but that is a
big part of the functionality we want.  We would be interested in
finding out about inode corruption, checksum failures, and read errors
as well.

Khazhy, in Cc, is more familiar with the specific requirements, and
might be able to provide more information on their usage of the existing
solution.

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
>
> So this depends on the use case. I can imagine that we could introduce new
> event type FAN_FS_ERROR (like we currently have FAN_MODIFY, FAN_ACCESS,
> FAN_CREATE, ...). This event type would be generated when error happens on
> fs object - we can generate it associated with struct file, struct dentry,
> or only superblock, depending on what information is available at the place
> where fs spots the error. Similarly to how we generate other fsnotify
> events. But here's the usecase question - is there really need for fine
> granularity of error reporting (i.e., someone watching errors only on a
> particular file, or directory)?

My use-case requires only watching an entire filesystem, and not
specific files.  I can imagine a use-case of someone watching a specific
mount point, like an application running inside a container is notified
only of errors in files/directories within that container.

>
> Then we can have FAN_REPORT_DETAILED_ERROR which would add to event more
> information about the error like you write below - although identification
> of the inode / fsid is IMO redundant - you can get all that information
> (and more) from FID / DFID event info entries if you want it.

When FID provides a handle, I'd need to get information on that handle
without opening it, as the file might be corrupted.  Would we need an
interface to retrieve inode number by handle without opening the file,
i.e. stat_by_handle?

Thanks,

-- 
Gabriel Krisman Bertazi
