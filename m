Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31323F4C9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhHWOuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWOuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:50:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3D8C061575;
        Mon, 23 Aug 2021 07:49:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E62A81F41D5B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jan Kara <jack@suse.cz>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, djwong@kernel.org, repnop@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v6 20/21] samples: Add fs error monitoring example
Organization: Collabora
References: <20210812214010.3197279-1-krisman@collabora.com>
        <20210812214010.3197279-21-krisman@collabora.com>
        <20210818130251.GD28119@quack2.suse.cz>
Date:   Mon, 23 Aug 2021 10:49:31 -0400
In-Reply-To: <20210818130251.GD28119@quack2.suse.cz> (Jan Kara's message of
        "Wed, 18 Aug 2021 15:02:51 +0200")
Message-ID: <87fsv02p38.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:
n
> On Thu 12-08-21 17:40:09, Gabriel Krisman Bertazi wrote:
>> Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
>> errors.
>> 
>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> <snip>
>
>> diff --git a/samples/fanotify/fs-monitor.c b/samples/fanotify/fs-monitor.c
>> new file mode 100644
>> index 000000000000..e115053382be
>> --- /dev/null
>> +++ b/samples/fanotify/fs-monitor.c
>> @@ -0,0 +1,138 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2021, Collabora Ltd.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <errno.h>
>> +#include <err.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <fcntl.h>
>> +#include <sys/fanotify.h>
>> +#include <sys/types.h>
>> +#include <unistd.h>
>> +#include <sys/types.h>
>> +
>> +#ifndef FAN_FS_ERROR
>> +#define FAN_FS_ERROR		0x00008000
>> +#define FAN_EVENT_INFO_TYPE_ERROR	4
>> +
>> +struct fanotify_event_info_error {
>> +	struct fanotify_event_info_header hdr;
>> +	__s32 error;
>> +	__u32 error_count;
>> +};
>> +#endif
>
> Shouldn't we get these from uapi headers? But I guess the problem is that
> you want this sample to work before glibc picks up the new headers? Is this
> meant as a sample code for userspace to copy from or more as a
> testcase?

Hi,

Yes, this will be picked from the uapi headers, but the guards try to
guarantee against an older libc.  They also have the side effect of
silencing the kernel test robot about this patch... :)

This is meant as a sample code for users to copy from.  it was also used
as testing in the beginning but now I have a proper ltp testcase in a
different series. 

>> +#ifndef FILEID_INO32_GEN
>> +#define FILEID_INO32_GEN	1
>> +#endif
>> +
>> +#ifndef FILEID_INVALID
>> +#define	FILEID_INVALID		0xff
>> +#endif
>> +
>> +static void print_fh(struct file_handle *fh)
>> +{
>> +	int i;
>> +	uint32_t *h = (uint32_t *) fh->f_handle;
>> +
>> +	printf("\tfh: ");
>> +	for (i = 0; i < fh->handle_bytes; i++)
>> +		printf("%hhx", fh->f_handle[i]);
>> +	printf("\n");
>> +
>> +	printf("\tdecoded fh: ");
>> +	if (fh->handle_type == FILEID_INO32_GEN)
>> +		printf("inode=%u gen=%u\n", h[0], h[1]);
>> +	else if (fh->handle_type == FILEID_INVALID && !fh->handle_bytes)
>> +		printf("Type %d (Superblock error)\n", fh->handle_type);
>> +	else
>> +		printf("Type %d (Unknown)\n", fh->handle_type);
>> +
>> +}
>> +
>> +static void handle_notifications(char *buffer, int len)
>> +{
>> +	struct fanotify_event_metadata *metadata;
>> +	struct fanotify_event_info_error *error;
>> +	struct fanotify_event_info_fid *fid;
>> +	char *next;
>> +
>> +	for (metadata = (struct fanotify_event_metadata *) buffer;
>> +	     FAN_EVENT_OK(metadata, len);
>> +	     metadata = FAN_EVENT_NEXT(metadata, len)) {
>> +		next = (char *)metadata + metadata->event_len;
>> +		if (metadata->mask != FAN_FS_ERROR) {
>> +			printf("unexpected FAN MARK: %llx\n", metadata->mask);
>> +			goto next_event;
>> +		} else if (metadata->fd != FAN_NOFD) {
>> +			printf("Unexpected fd (!= FAN_NOFD)\n");
>> +			goto next_event;
>> +		}
>> +
>> +		printf("FAN_FS_ERROR found len=%d\n", metadata->event_len);
>> +
>> +		error = (struct fanotify_event_info_error *) (metadata+1);
>> +		if (error->hdr.info_type != FAN_EVENT_INFO_TYPE_ERROR) {
>> +			printf("unknown record: %d (Expecting TYPE_ERROR)\n",
>> +			       error->hdr.info_type);
>> +			goto next_event;
>> +		}
>
> The ordering of additional infos is undefined. Your code must not rely on
> the fact that FAN_EVENT_INFO_TYPE_ERROR comes first and
> FAN_EVENT_INFO_TYPE_FID second. Also you should ignore (maybe just print
> type and len in this sample code) when you see unexpected info types as
> later additions to the API may add additional info records 

Ah, I was really wondering whether the order is guaranteed or not.
Even though the current code forces it that way, I couldn't find the man
page explicitly saying whether it is guaranteed.  Thanks, I will fix it up.

-- 
Gabriel Krisman Bertazi
