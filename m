Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC923F0425
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbhHRNDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 09:03:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42580 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbhHRNDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:03:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9CEDE21FFA;
        Wed, 18 Aug 2021 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629291774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Of/xWW25j+0qfuTt0uqhfyFoCDsIAoSKsFXcHn3KrVQ=;
        b=sBIhF0p0cHgtBFNlDwhvKlmsZy9dqpTd4MsakUchdAhS44il9Ti3LTVTErIF+t94bX+DfR
        LM6uf0h57gBgCS2bevTPknrs3L3ia9VwI+5DWBJFoWrunC+Ux7Sl4DvETOfNaW2eldG2p5
        4vaseWUYUuOcLlchpFyRbpKMhEI4ACM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629291774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Of/xWW25j+0qfuTt0uqhfyFoCDsIAoSKsFXcHn3KrVQ=;
        b=1XlBou6zFY/a+jMJWGtXXTVTg6b3wyFdWjzZZxeNMaiCLszioV2GT9Y3/9w8m4TH4t0D6v
        8+uNSe7DoLvdxfCw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 832A2A3B98;
        Wed, 18 Aug 2021 13:02:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DF7C1E14B9; Wed, 18 Aug 2021 15:02:51 +0200 (CEST)
Date:   Wed, 18 Aug 2021 15:02:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, djwong@kernel.org, repnop@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v6 20/21] samples: Add fs error monitoring example
Message-ID: <20210818130251.GD28119@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-21-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812214010.3197279-21-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-08-21 17:40:09, Gabriel Krisman Bertazi wrote:
> Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
> errors.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

<snip>

> diff --git a/samples/fanotify/fs-monitor.c b/samples/fanotify/fs-monitor.c
> new file mode 100644
> index 000000000000..e115053382be
> --- /dev/null
> +++ b/samples/fanotify/fs-monitor.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021, Collabora Ltd.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <err.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <sys/fanotify.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +
> +#ifndef FAN_FS_ERROR
> +#define FAN_FS_ERROR		0x00008000
> +#define FAN_EVENT_INFO_TYPE_ERROR	4
> +
> +struct fanotify_event_info_error {
> +	struct fanotify_event_info_header hdr;
> +	__s32 error;
> +	__u32 error_count;
> +};
> +#endif

Shouldn't we get these from uapi headers? But I guess the problem is that
you want this sample to work before glibc picks up the new headers? Is this
meant as a sample code for userspace to copy from or more as a testcase?

> +#ifndef FILEID_INO32_GEN
> +#define FILEID_INO32_GEN	1
> +#endif
> +
> +#ifndef FILEID_INVALID
> +#define	FILEID_INVALID		0xff
> +#endif
> +
> +static void print_fh(struct file_handle *fh)
> +{
> +	int i;
> +	uint32_t *h = (uint32_t *) fh->f_handle;
> +
> +	printf("\tfh: ");
> +	for (i = 0; i < fh->handle_bytes; i++)
> +		printf("%hhx", fh->f_handle[i]);
> +	printf("\n");
> +
> +	printf("\tdecoded fh: ");
> +	if (fh->handle_type == FILEID_INO32_GEN)
> +		printf("inode=%u gen=%u\n", h[0], h[1]);
> +	else if (fh->handle_type == FILEID_INVALID && !fh->handle_bytes)
> +		printf("Type %d (Superblock error)\n", fh->handle_type);
> +	else
> +		printf("Type %d (Unknown)\n", fh->handle_type);
> +
> +}
> +
> +static void handle_notifications(char *buffer, int len)
> +{
> +	struct fanotify_event_metadata *metadata;
> +	struct fanotify_event_info_error *error;
> +	struct fanotify_event_info_fid *fid;
> +	char *next;
> +
> +	for (metadata = (struct fanotify_event_metadata *) buffer;
> +	     FAN_EVENT_OK(metadata, len);
> +	     metadata = FAN_EVENT_NEXT(metadata, len)) {
> +		next = (char *)metadata + metadata->event_len;
> +		if (metadata->mask != FAN_FS_ERROR) {
> +			printf("unexpected FAN MARK: %llx\n", metadata->mask);
> +			goto next_event;
> +		} else if (metadata->fd != FAN_NOFD) {
> +			printf("Unexpected fd (!= FAN_NOFD)\n");
> +			goto next_event;
> +		}
> +
> +		printf("FAN_FS_ERROR found len=%d\n", metadata->event_len);
> +
> +		error = (struct fanotify_event_info_error *) (metadata+1);
> +		if (error->hdr.info_type != FAN_EVENT_INFO_TYPE_ERROR) {
> +			printf("unknown record: %d (Expecting TYPE_ERROR)\n",
> +			       error->hdr.info_type);
> +			goto next_event;
> +		}

The ordering of additional infos is undefined. Your code must not rely on
the fact that FAN_EVENT_INFO_TYPE_ERROR comes first and
FAN_EVENT_INFO_TYPE_FID second. Also you should ignore (maybe just print
type and len in this sample code) when you see unexpected info types as
later additions to the API may add additional info records 

> +
> +		printf("\tGeneric Error Record: len=%d\n", error->hdr.len);
> +		printf("\terror: %d\n", error->error);
> +		printf("\terror_count: %d\n", error->error_count);
> +
> +		fid = (struct fanotify_event_info_fid *) (error + 1);
> +		if ((char *) fid >= next) {
> +			printf("Event doesn't have FID\n");
> +			goto next_event;
> +		}
> +		printf("FID record found\n");
> +
> +		if (fid->hdr.info_type != FAN_EVENT_INFO_TYPE_FID) {
> +			printf("unknown record: %d (Expecting TYPE_FID)\n",
> +			       fid->hdr.info_type);
> +			goto next_event;
> +		}
> +		printf("\tfsid: %x%x\n", fid->fsid.val[0], fid->fsid.val[1]);
> +		print_fh((struct file_handle *) &fid->handle);
> +
> +next_event:
> +		printf("---\n\n");
> +	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
