Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD042F90A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbhJOQ4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 12:56:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36458 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbhJOQ4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:56:45 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4318E1F45452;
        Fri, 15 Oct 2021 17:54:37 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Subject: Re: [PATCH v7 21/28] fanotify: Support merging of error events
Organization: Collabora
References: <20211014213646.1139469-1-krisman@collabora.com>
        <20211014213646.1139469-22-krisman@collabora.com>
        <CAOQ4uxiOhQjQMruHR-ZM0SNdaRyi7BGsZK=Y_nSh1=361oC81g@mail.gmail.com>
Date:   Fri, 15 Oct 2021 13:54:31 -0300
In-Reply-To: <CAOQ4uxiOhQjQMruHR-ZM0SNdaRyi7BGsZK=Y_nSh1=361oC81g@mail.gmail.com>
        (Amir Goldstein's message of "Fri, 15 Oct 2021 10:09:36 +0300")
Message-ID: <87pms6p6t4.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> Error events (FAN_FS_ERROR) against the same file system can be merged
>> by simply iterating the error count.  The hash is taken from the fsid,
>> without considering the FH.  This means that only the first error object
>> is reported.
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
>>  fs/notify/fanotify/fanotify.c | 39 ++++++++++++++++++++++++++++++++---
>>  fs/notify/fanotify/fanotify.h |  4 +++-
>>  2 files changed, 39 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
>> index 9b970359570a..7032083df62a 100644
>> --- a/fs/notify/fanotify/fanotify.c
>> +++ b/fs/notify/fanotify/fanotify.c
>> @@ -111,6 +111,16 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
>>         return fanotify_info_equal(info1, info2);
>>  }
>>
>> +static bool fanotify_error_event_equal(struct fanotify_error_event *fee1,
>> +                                      struct fanotify_error_event *fee2)
>> +{
>> +       /* Error events against the same file system are always merged. */
>> +       if (!fanotify_fsid_equal(&fee1->fsid, &fee2->fsid))
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
>>  static bool fanotify_should_merge(struct fanotify_event *old,
>>                                   struct fanotify_event *new)
>>  {
>> @@ -141,6 +151,9 @@ static bool fanotify_should_merge(struct fanotify_event *old,
>>         case FANOTIFY_EVENT_TYPE_FID_NAME:
>>                 return fanotify_name_event_equal(FANOTIFY_NE(old),
>>                                                  FANOTIFY_NE(new));
>> +       case FANOTIFY_EVENT_TYPE_FS_ERROR:
>> +               return fanotify_error_event_equal(FANOTIFY_EE(old),
>> +                                                 FANOTIFY_EE(new));
>>         default:
>>                 WARN_ON_ONCE(1);
>>         }
>> @@ -148,6 +161,22 @@ static bool fanotify_should_merge(struct fanotify_event *old,
>>         return false;
>>  }
>>
>> +static void fanotify_merge_error_event(struct fanotify_error_event *dest,
>> +                                      struct fanotify_error_event *origin)
>> +{
>> +       dest->err_count++;
>> +}
>> +
>> +static void fanotify_merge_event(struct fanotify_event *dest,
>> +                                struct fanotify_event *origin)
>> +{
>> +       dest->mask |= origin->mask;
>> +
>> +       if (origin->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
>> +               fanotify_merge_error_event(FANOTIFY_EE(dest),
>> +                                          FANOTIFY_EE(origin));
>> +}
>> +
>>  /* Limit event merges to limit CPU overhead per event */
>>  #define FANOTIFY_MAX_MERGE_EVENTS 128
>>
>> @@ -175,7 +204,7 @@ static int fanotify_merge(struct fsnotify_group *group,
>>                 if (++i > FANOTIFY_MAX_MERGE_EVENTS)
>>                         break;
>>                 if (fanotify_should_merge(old, new)) {
>> -                       old->mask |= new->mask;
>> +                       fanotify_merge_event(old, new);
>>                         return 1;
>>                 }
>>         }
>> @@ -577,7 +606,8 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>>  static struct fanotify_event *fanotify_alloc_error_event(
>>                                                 struct fsnotify_group *group,
>>                                                 __kernel_fsid_t *fsid,
>> -                                               const void *data, int data_type)
>> +                                               const void *data, int data_type,
>> +                                               unsigned int *hash)
>>  {
>>         struct fs_error_report *report =
>>                         fsnotify_data_error_report(data, data_type);
>> @@ -591,6 +621,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
>>                 return NULL;
>>
>>         fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
>> +       fee->err_count = 1;
>> +
>> +       *hash ^= fanotify_hash_fsid(fsid);
>>
>>         return &fee->fae;
>>  }
>
> Forgot to store fee->fsid?

Not really. this is part of the FID info record support, which is done
in patch 23.

-- 
Gabriel Krisman Bertazi
