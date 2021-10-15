Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3226442F8B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhJOQw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 12:52:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36438 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhJOQw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:52:56 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D7FB91F45452;
        Fri, 15 Oct 2021 17:50:47 +0100 (BST)
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
Subject: Re: [PATCH v7 20/28] fanotify: Support enqueueing of error events
Organization: Collabora
References: <20211014213646.1139469-1-krisman@collabora.com>
        <20211014213646.1139469-21-krisman@collabora.com>
        <CAOQ4uxh91CD1x3WXpV3q-Ct40v7gSrr7bAZ8jKjUyPcQ81Eeqw@mail.gmail.com>
Date:   Fri, 15 Oct 2021 13:50:41 -0300
In-Reply-To: <CAOQ4uxh91CD1x3WXpV3q-Ct40v7gSrr7bAZ8jKjUyPcQ81Eeqw@mail.gmail.com>
        (Amir Goldstein's message of "Fri, 15 Oct 2021 10:04:01 +0300")
Message-ID: <87y26up6zi.fsf@collabora.com>
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
>> Once an error event is triggered, collect the data from the fs error
>> report and enqueue it in the notification group, similarly to what is
>> done for other events.  FAN_FS_ERROR is no longer handled specially,
>> since the memory is now handled by a preallocated mempool.
>>
>> For now, make the event unhashed.  A future patch implements merging for
>> these kinds of events.
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
>>  fs/notify/fanotify/fanotify.c | 35 +++++++++++++++++++++++++++++++++++
>>  fs/notify/fanotify/fanotify.h |  6 ++++++
>>  2 files changed, 41 insertions(+)
>>
>> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
>> index 01d68dfc74aa..9b970359570a 100644
>> --- a/fs/notify/fanotify/fanotify.c
>> +++ b/fs/notify/fanotify/fanotify.c
>> @@ -574,6 +574,27 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>>         return &fne->fae;
>>  }
>>
>> +static struct fanotify_event *fanotify_alloc_error_event(
>> +                                               struct fsnotify_group *group,
>> +                                               __kernel_fsid_t *fsid,
>> +                                               const void *data, int data_type)
>> +{
>> +       struct fs_error_report *report =
>> +                       fsnotify_data_error_report(data, data_type);
>> +       struct fanotify_error_event *fee;
>> +
>> +       if (WARN_ON(!report))
>
> WARN_ON_ONCE please.
>
> Commit message claims to collect the data from the report,
> but this commit does nothing with the report??

I moved it out to a separate commit and forgot to update the commit
message.  Fixed. Thanks!

-- 
Gabriel Krisman Bertazi
