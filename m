Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B67142F8D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 18:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbhJOQza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 12:55:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36456 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbhJOQza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:55:30 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AD44D1F45452;
        Fri, 15 Oct 2021 17:53:21 +0100 (BST)
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
Subject: Re: [PATCH v7 19/28] fanotify: Limit number of marks with
 FAN_FS_ERROR per group
Organization: Collabora
References: <20211014213646.1139469-1-krisman@collabora.com>
        <20211014213646.1139469-20-krisman@collabora.com>
        <CAOQ4uxjhTu+fPwZfjGtzcoj3-RLxBSh8ozyLjWzcTC0YJAwnwA@mail.gmail.com>
Date:   Fri, 15 Oct 2021 13:53:16 -0300
In-Reply-To: <CAOQ4uxjhTu+fPwZfjGtzcoj3-RLxBSh8ozyLjWzcTC0YJAwnwA@mail.gmail.com>
        (Amir Goldstein's message of "Fri, 15 Oct 2021 09:15:46 +0300")
Message-ID: <87tuhip6v7.fsf@collabora.com>
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
>> Since FAN_FS_ERROR memory must be pre-allocated, limit a single group
>> from watching too many file systems at once.  The current scheme
>> guarantees 1 slot per filesystem, so limit the number of marks with
>> FAN_FS_ERROR per group.
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
>>  fs/notify/fanotify/fanotify_user.c | 10 ++++++++++
>>  include/linux/fsnotify_backend.h   |  1 +
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
>> index f1cf863d6f9f..5324890500fc 100644
>> --- a/fs/notify/fanotify/fanotify_user.c
>> +++ b/fs/notify/fanotify/fanotify_user.c
>> @@ -959,6 +959,10 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
>>
>>         removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
>>                                                  umask, &destroy_mark);
>> +
>> +       if (removed & FAN_FS_ERROR)
>> +               group->fanotify_data.error_event_marks--;
>> +
>>         if (removed & fsnotify_conn_mask(fsn_mark->connector))
>>                 fsnotify_recalc_mask(fsn_mark->connector);
>>         if (destroy_mark)
>> @@ -1057,6 +1061,9 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>>
>>  static int fanotify_group_init_error_pool(struct fsnotify_group *group)
>>  {
>> +       if (group->fanotify_data.error_event_marks >= FANOTIFY_DEFAULT_FEE_POOL)
>> +               return -ENOMEM;
>
> Why not try to mempool_resize()?

Jan suggested we might not need to bother with it, but I can do that for
the next version.

> Also, I did not read the rest of the patches yet, but don't we need two
> slots per mark? one for alloc-pre-enqueue and one for free-post-dequeue?

I don't understand what you mean by two slots for alloc-pre-enqueue and
free-post-dequeue.  I suspect it is no longer necessary now that
FAN_FS_ERROR is handled like any other event on enqueue/dequeue, but can
you confirm or clarify?

Thanks,

-- 
Gabriel Krisman Bertazi
