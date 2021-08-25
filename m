Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B40B3F7C55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 20:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhHYSlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 14:41:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54222 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhHYSlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:41:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7F6401F43C0C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Subject: Re: [PATCH v6 09/21] fsnotify: Allow events reported with an empty
 inode
Organization: Collabora
References: <20210812214010.3197279-1-krisman@collabora.com>
        <20210812214010.3197279-10-krisman@collabora.com>
        <CAOQ4uxi7otGo6aNNMk9-fVQCx4Q0tDFe7sJaCr6jj1tNtfExTg@mail.gmail.com>
Date:   Wed, 25 Aug 2021 14:40:16 -0400
In-Reply-To: <CAOQ4uxi7otGo6aNNMk9-fVQCx4Q0tDFe7sJaCr6jj1tNtfExTg@mail.gmail.com>
        (Amir Goldstein's message of "Fri, 13 Aug 2021 10:58:56 +0300")
Message-ID: <87tujdz7u7.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> Some file system events (i.e. FS_ERROR) might not be associated with an
>> inode.  For these, it makes sense to associate them directly with the
>> super block of the file system they apply to.  This patch allows the
>> event to be reported with a NULL inode, by recovering the superblock
>> directly from the data field, if needed.
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>>
>> --
>> Changes since v5:
>>   - add fsnotify_data_sb handle to retrieve sb from the data field. (jan)
>> ---
>>  fs/notify/fsnotify.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
>> index 30d422b8c0fc..536db02cb26e 100644
>> --- a/fs/notify/fsnotify.c
>> +++ b/fs/notify/fsnotify.c
>> @@ -98,6 +98,14 @@ void fsnotify_sb_delete(struct super_block *sb)
>>         fsnotify_clear_marks_by_sb(sb);
>>  }
>>
>> +static struct super_block *fsnotify_data_sb(const void *data, int data_type)
>> +{
>> +       struct inode *inode = fsnotify_data_inode(data, data_type);
>> +       struct super_block *sb = inode ? inode->i_sb : NULL;
>> +
>> +       return sb;
>> +}
>> +
>>  /*
>>   * Given an inode, first check if we care what happens to our children.  Inotify
>>   * and dnotify both tell their parents about events.  If we care about any event
>> @@ -455,8 +463,10 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
>>   *             @file_name is relative to
>>   * @file_name: optional file name associated with event
>>   * @inode:     optional inode associated with event -
>> - *             either @dir or @inode must be non-NULL.
>> - *             if both are non-NULL event may be reported to both.
>> + *             If @dir and @inode are NULL, @data must have a type that
>> + *             allows retrieving the file system associated with this
>
> Irrelevant comment. sb must always be available from @data.
>
>> + *             event.  if both are non-NULL event may be reported to
>> + *             both.
>>   * @cookie:    inotify rename cookie
>>   */
>>  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>> @@ -483,7 +493,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>>                  */
>>                 parent = dir;
>>         }
>> -       sb = inode->i_sb;
>> +       sb = inode ? inode->i_sb : fsnotify_data_sb(data, data_type);
>
>         const struct path *path = fsnotify_data_path(data, data_type);
> +       const struct super_block *sb = fsnotify_data_sb(data, data_type);
>
> All the games with @data @inode and @dir args are irrelevant to this.
> sb should always be available from @data and it does not matter
> if fsnotify_data_inode() is the same as @inode, @dir or neither.
> All those inodes are anyway on the same sb.

Hi Amir,

I think this is actually necessary.  I could identify at least one event
(FS_CREATE | FS_ISDIR) where fsnotify is invoked with a NULL data field.
In that case, fsnotify_dirent is called with a negative dentry from
vfs_mkdir().  I'm not sure why exactly the dentry is negative after the
mkdir, but it would be possible we are racing with the file removal, I
guess?  It might be a bug in fsnotify that this case even happen, but
I'm not sure yet.

The easiest way around it is what I proposed: just use inode->i_sb if
data is NULL.  Since, as you said, data, inode and dir are all on the
same superblock, it should work, I think.

-- 
Gabriel Krisman Bertazi
