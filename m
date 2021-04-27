Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6717836C8D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 17:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhD0Pp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 11:45:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60842 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhD0PpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:45:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EDA2D1F426A1
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH RFC 00/15] File system wide monitoring
Organization: Collabora
References: <20210426184201.4177978-1-krisman@collabora.com>
        <CAOQ4uxi3yigb2gUjXHJQOVbPHR3RFDeyKc5i0X-k8CSLwurejg@mail.gmail.com>
Date:   Tue, 27 Apr 2021 11:44:37 -0400
In-Reply-To: <CAOQ4uxi3yigb2gUjXHJQOVbPHR3RFDeyKc5i0X-k8CSLwurejg@mail.gmail.com>
        (Amir Goldstein's message of "Tue, 27 Apr 2021 07:11:49 +0300")
Message-ID: <875z0791ga.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Mon, Apr 26, 2021 at 9:42 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> Hi,
>>
>> In an attempt to consolidate some of the feedback from the previous
>> proposals, I wrote a new attempt to solve the file system error reporting
>> problem.  Before I spend more time polishing it, I'd like to hear your
>> feedback if I'm going in the wrong direction, in particular with the
>> modifications to fsnotify.
>>
>
> IMO you are going in the right direction, but you have gone a bit too far ;-)
>
> My understanding of the requirements and my interpretation of the feedback
> from filesystem maintainers is that the missing piece in the ecosystem is a
> user notification that "something went wrong". The "what went wrong" part
> is something that users and admins have long been able to gather from the
> kernel log and from filesystem tools (e.g. last error recorded).
>
> I do not see the need to duplicate existing functionality in fsmonitor.
> Don't get me wrong, I understand why it would have been nice for fsmonitor
> to be able to get all the errors nicely without looking anywhere else, but I
> don't think it justifies the extra complexity.

Hi Amir,

Thanks for the detailed review.

The reasons for the location record and the ring buffer is the use case
from Google to do analysis on a series of errors.  I understand this is
important to them, which is why I expanded a bit on the 'what went
wrong' and multiple errors.  In addition, The file system specific blob
attempts to assist online recovery tools with more information, but it
might make sense to do it in the future, when it is needed.

>> This RFC follows up on my previous proposals which attempted to leverage
>> watch_queue[1] and fsnotify[2] to provide a mechanism for file systems
>> to push error notifications to user space.  This proposal starts by, as
>> suggested by Darrick, limiting the scope of what I'm trying to do to an
>> interface for administrators to monitor the health of a file system,
>> instead of a generic inteface for file errors.  Therefore, this doesn't
>> solve the problem of writeback errors or the need to watch a specific
>> subsystem.
>>
>> * Format
>>
>> The feature is implemented on top of fanotify, as a new type of fanotify
>> mark, FAN_ERROR, which a file system monitoring tool can register to
>
> You have a terminology mistake throughout your series.
> FAN_ERROR is not a type of a mark, it is a type of an event.
> A mark describes the watched object (i.e. a filesystem, mount, inode).

Right.  I understand the mistake and will fix it around the series.
>
>> receive notifications.  A notification is split in three parts, and only
>> the first is guaranteed to exist for any given error event:
>>
>>  - FS generic data: A file system agnostic structure that has a generic
>>  error code and identifies the filesystem.  Basically, it let's
>>  userspace know something happen on a monitored filesystem.
>
> I think an error seq counter per fs would be a nice addition to generic data.
> It does not need to be persistent (it could be if filesystem supports it).

Makes sense to me.

>>
>>  - FS location data: Identifies where in the code the problem
>>  happened. (This is important for the use case of analysing frequent
>>  error points that we discussed earlier).
>>
>>  - FS specific data: A detailed error report in a filesystem specific
>>  format that details what the error is.  Ideally, a capable monitoring
>>  tool can use the information here for error recovery.  For instance,
>>  xfs can put the xfs_scrub structures here, ext4 can send its error
>>  reports, etc.  An example of usage is done in the ext4 patch of this
>>  series.
>>
>> More details on the information in each record can be found on the
>> documentation introduced in patch 15.
>>
>> * Using fanotify
>>
>> Using fanotify for this kind of thing is slightly tricky because we want
>> to guarantee delivery in some complicated conditions, for instance, the
>> file system might want to send an error while holding several locks.
>>
>> Instead of working around file system constraints at the file system
>> level, this proposal tries to make the FAN_ERROR submission safe in
>> those contexts.  This is done with a new mode in fsnotify that
>> preallocates the memory at group creation to be used for the
>> notification submission.
>>
>> This new mode in fsnotify introduces a ring buffer to queue
>> notifications, which eliminates the allocation path in fsnotify.  From
>> what I saw, the allocation is the only problem in fsnotify for
>> filesystems to submit errors in constrained situations.
>>
>
> The ring buffer functionality for fsnotify is interesting and it may be
> useful on its own, but IMO, its too big of a hammer for the problem
> at hand.
>
> The question that you should be asking yourself is what is the
> expected behavior in case of a flood of filesystem corruption errors.
> I think it has already been expressed by filesystem maintainers on
> one your previous postings, that a flood of filesystem corruption
> errors is often noise and the only interesting information is the
> first error.

My idea was be to provide an ioctl for the user to resize the ring
buffer when needed, to make the flood manageable. But I understand your
main point about the ring buffer.  i'm not sure saving only the first
notification solves Google's use case of error monitoring and analysis,
though.  Khazhy, Ted, can you weight in?

> For this reason, I think that FS_ERROR could be implemented
> by attaching an fsnotify_error_info object to an fsnotify_sb_mark:
>
> struct fsnotify_sb_mark {
>         struct fsnotify_mark fsn_mark;
>         struct fsnotify_error_info info;
> }
>
> Similar to fd sampled errseq, there can be only one error report
> per sb-group pair (i.e. fsnotify_sb_mark) and the memory needed to store
> the error report can be allocated at the time of setting the filesystem mark.
>
> With this, you will not need the added complexity of the ring buffer
> and you will not need to limit FAN_ERROR reporting to a group that
> is only listening for FAN_ERROR, which is an unneeded limitation IMO.

The limitation exists because I was concerned about not breaking the
semantics of FAN_ACCESS and others, with regards to merged
notifications.  I believe there should be no other reason why
notifications of FAN_CLASS_NOTIF can't be sent to the ring buffer too.
That limitation could be lifted for everything but permission events, I
think.

-- 
Gabriel Krisman Bertazi
