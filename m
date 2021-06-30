Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CADB3B87DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 19:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhF3Rph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbhF3Rpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:45:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715F7C061756;
        Wed, 30 Jun 2021 10:43:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A47AE1F43AAB
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v3 12/15] fanotify: Introduce FAN_FS_ERROR event
Organization: Collabora
References: <20210629191035.681913-1-krisman@collabora.com>
        <20210629191035.681913-13-krisman@collabora.com>
        <CAOQ4uxiUYAwj561=ap_Hq6AwRdAdZFY1yQ99Y9_ahsd82-qFug@mail.gmail.com>
Date:   Wed, 30 Jun 2021 13:43:01 -0400
In-Reply-To: <CAOQ4uxiUYAwj561=ap_Hq6AwRdAdZFY1yQ99Y9_ahsd82-qFug@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 30 Jun 2021 13:26:03 +0300")
Message-ID: <87v95vgsey.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

>> +       fee->fsid = fee->mark->connector->fsid;
>> +
>> +       fsnotify_get_mark(fee->mark);
>> +
>> +       /*
>> +        * Error reporting needs to happen in atomic context.  If this
>> +        * inode's file handler is more than we initially predicted,
>> +        * there is nothing better we can do than report the error with
>> +        * a bad FH.
>> +        */
>> +       fh_len = fanotify_encode_fh_len(inode);
>> +       if (WARN_ON(fh_len > fee->max_fh_len))
>
> WARN_ON() is not acceptable for things that can logically happen
> if you think this is important you could use pr_warn_ratelimited()
> like we do in fanotify_encode_fh(),
> but since fs-monitor will observe the lack of FID anyway, I think
> there is little point in reporting this to kmsg.

Hi Amir,

Thanks for all the review so far.

Consider that fh_len > max_fh_len can happen only if the filesystem
requires a longer handler for the failed inode than it requires for the
root inode.  Looking at the FH types, I don't think this would be
possible to happen currently, but this WARN_ON is trying to catch future
problems.

Notice this would not be a fs-monitor misuse of the uAPI,  but an actual
kernel bug. The FH size we predicted when allocating the static error
slot is not large enough for at least one FH of this filesystem.  So I
think a WARN_ON or a pr_warn is desired.  I will change it to a
pr_warn_ratelimited as you suggested.


>> @@ -896,6 +933,43 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
>>                                     flags, umask);
>>  }
>>
>> +static int fanotify_create_fs_error_event(struct fsnotify_mark *fsn_mark,
>> +                                          fsnotify_connp_t *connp)
>> +{
>> +       struct fanotify_sb_mark *sb_mark = FANOTIFY_SB_MARK(fsn_mark);
>> +       struct super_block *sb =
>> +               container_of(connp, struct super_block, s_fsnotify_marks);
>> +       struct fanotify_error_event *fee;
>> +       int fh_len;
>> +
>> +       /*
>> +        * Since the allocation is done holding group->mark_mutex, the
>> +        * error event allocation is guaranteed not to race with itself.
>
> If this is protected by a mutex then READ_ONCE/WRITE_ONCE are not need
> and the comment above is confusing.
> You should fire your code reviewer ;-)

okay :)

>
>> +        */
>> +       if (READ_ONCE(sb_mark->error_event))
>> +               return 0;
>> +
>> +       /* Since, for error events, every memory must be preallocated,
>> +        * the FH buffer size is predicted to be the same as the root
>> +        * inode file handler size.  This should work for file systems
>> +        * without variable sized FH.
>> +        */
>> +       fh_len = fanotify_encode_fh_len(sb->s_root->d_inode);
>> +
>> +       fee = kzalloc(sizeof(*fee) + fh_len, GFP_KERNEL);
>
> GFP_KERNEL_ACCOUNT

will do.

>> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
>> index a16dbeced152..d086a19aff63 100644
>> --- a/include/linux/fanotify.h
>> +++ b/include/linux/fanotify.h
>> @@ -81,13 +81,17 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>>   */
>>  #define FANOTIFY_DIRENT_EVENTS (FAN_MOVE | FAN_CREATE | FAN_DELETE)
>>
>> -/* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
>> +#define FANOTIFY_ERROR_EVENTS  (FAN_FS_ERROR)
>> +
>> +/* Events that can only be reported to groups that support FID mode */
>
> Let's not do that.
> How about the opposite:
>
> /* Events that can be reported with event->fd */
> #define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
>
>         /*
>          * Events that do not carry enough information to report event->fd
>          * require a group that supports reporting fid.
>          * Those events are not supported on a mount mark, because they do
>          * not carry enough information (i.e. path) to be filtered by
> mount point.
>          */
>         fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>         if (!(mask & FANOTIFY_FD_EVENTS) &&
>             (!fid_mode || mark_type == FAN_MARK_MOUNT))
>

Will do.

Thanks,

-- 
Gabriel Krisman Bertazi
