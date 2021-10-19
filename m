Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B11433B19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 17:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhJSPvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 11:51:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57622 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhJSPvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:51:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DFBC2219D0;
        Tue, 19 Oct 2021 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634658563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AuFXMWgPNu/ob1w45v2bwC1eTYwhpFz8+Ou6HJ1sINc=;
        b=jI8mBT9NN3CJ98e8TRrBe6+W4IX9QJHhQVVEKnl3en/oUgwXJ1BtjxKiiFkWwgj9VIseiX
        T6qtord8tZ7xDsvRJGxPWnmadejJJpLBcmyDH1ASV21xRAuFOoTHhuO2Q+aN+0HjYC0TeU
        RoIu5cPOyMzZsNgD6DpIFmTLpD/TZLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634658563;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AuFXMWgPNu/ob1w45v2bwC1eTYwhpFz8+Ou6HJ1sINc=;
        b=+hXA1ubFurqb0bbuOQkaDlB7NFuBhX15D2Rqr0TyPRZda1n6LcfRhIwECdaOHILJn/cbn7
        7km0z2ZAp5KnwzBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C3672A3B85;
        Tue, 19 Oct 2021 15:49:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A80B01E0983; Tue, 19 Oct 2021 17:49:20 +0200 (CEST)
Date:   Tue, 19 Oct 2021 17:49:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 31/32] samples: Add fs error monitoring example
Message-ID: <20211019154920.GS3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-32-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-32-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 21:00:14, Gabriel Krisman Bertazi wrote:
> Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
> errors.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v4:
>   - Protect file_handle defines with ifdef guards
> 
> Changes since v1:
>   - minor fixes
> ---
>  samples/Kconfig               |   9 +++
>  samples/Makefile              |   1 +
>  samples/fanotify/Makefile     |   5 ++
>  samples/fanotify/fs-monitor.c | 142 ++++++++++++++++++++++++++++++++++
>  4 files changed, 157 insertions(+)
>  create mode 100644 samples/fanotify/Makefile
>  create mode 100644 samples/fanotify/fs-monitor.c
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index b0503ef058d3..88353b8eac0b 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -120,6 +120,15 @@ config SAMPLE_CONNECTOR
>  	  with it.
>  	  See also Documentation/driver-api/connector.rst
>  
> +config SAMPLE_FANOTIFY_ERROR
> +	bool "Build fanotify error monitoring sample"
> +	depends on FANOTIFY
> +	help
> +	  When enabled, this builds an example code that uses the
> +	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
> +	  errors.
> +	  See also Documentation/admin-guide/filesystem-monitoring.rst.
> +
>  config SAMPLE_HIDRAW
>  	bool "hidraw sample"
>  	depends on CC_CAN_LINK && HEADERS_INSTALL
> diff --git a/samples/Makefile b/samples/Makefile
> index 087e0988ccc5..931a81847c48 100644
> --- a/samples/Makefile
> +++ b/samples/Makefile
> @@ -5,6 +5,7 @@ subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
>  subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
>  obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
>  obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
> +obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)	+= fanotify/
>  subdir-$(CONFIG_SAMPLE_HIDRAW)		+= hidraw
>  obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+= hw_breakpoint/
>  obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
> diff --git a/samples/fanotify/Makefile b/samples/fanotify/Makefile
> new file mode 100644
> index 000000000000..e20db1bdde3b
> --- /dev/null
> +++ b/samples/fanotify/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +userprogs-always-y += fs-monitor
> +
> +userccflags += -I usr/include -Wall
> +
> diff --git a/samples/fanotify/fs-monitor.c b/samples/fanotify/fs-monitor.c
> new file mode 100644
> index 000000000000..a0e44cd31e6f
> --- /dev/null
> +++ b/samples/fanotify/fs-monitor.c
> @@ -0,0 +1,142 @@
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
> +#define FAN_EVENT_INFO_TYPE_ERROR	5
> +
> +struct fanotify_event_info_error {
> +	struct fanotify_event_info_header hdr;
> +	__s32 error;
> +	__u32 error_count;
> +};
> +#endif
> +
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
> +	struct fanotify_event_metadata *event =
> +		(struct fanotify_event_metadata *) buffer;
> +	struct fanotify_event_info_header *info;
> +	struct fanotify_event_info_error *err;
> +	struct fanotify_event_info_fid *fid;
> +	int off;
> +
> +	for (; FAN_EVENT_OK(event, len); event = FAN_EVENT_NEXT(event, len)) {
> +
> +		if (event->mask != FAN_FS_ERROR) {
> +			printf("unexpected FAN MARK: %llx\n", event->mask);
> +			goto next_event;
> +		}
> +
> +		if (event->fd != FAN_NOFD) {
> +			printf("Unexpected fd (!= FAN_NOFD)\n");
> +			goto next_event;
> +		}
> +
> +		printf("FAN_FS_ERROR (len=%d)\n", event->event_len);
> +
> +		for (off = sizeof(*event) ; off < event->event_len;
> +		     off += info->len) {
> +			info = (struct fanotify_event_info_header *)
> +				((char *) event + off);
> +
> +			switch (info->info_type) {
> +			case FAN_EVENT_INFO_TYPE_ERROR:
> +				err = (struct fanotify_event_info_error *) info;
> +
> +				printf("\tGeneric Error Record: len=%d\n",
> +				       err->hdr.len);
> +				printf("\terror: %d\n", err->error);
> +				printf("\terror_count: %d\n", err->error_count);
> +				break;
> +
> +			case FAN_EVENT_INFO_TYPE_FID:
> +				fid = (struct fanotify_event_info_fid *) info;
> +
> +				printf("\tfsid: %x%x\n",
> +				       fid->fsid.val[0], fid->fsid.val[1]);
> +				print_fh((struct file_handle *) &fid->handle);
> +				break;
> +
> +			default:
> +				printf("\tUnknown info type=%d len=%d:\n",
> +				       info->info_type, info->len);
> +			}
> +		}
> +next_event:
> +		printf("---\n\n");
> +	}
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int fd;
> +
> +	char buffer[BUFSIZ];
> +
> +	if (argc < 2) {
> +		printf("Missing path argument\n");
> +		return 1;
> +	}
> +
> +	fd = fanotify_init(FAN_CLASS_NOTIF|FAN_REPORT_FID, O_RDONLY);
> +	if (fd < 0)
> +		errx(1, "fanotify_init");
> +
> +	if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
> +			  FAN_FS_ERROR, AT_FDCWD, argv[1])) {
> +		errx(1, "fanotify_mark");
> +	}
> +
> +	while (1) {
> +		int n = read(fd, buffer, BUFSIZ);
> +
> +		if (n < 0)
> +			errx(1, "read");
> +
> +		handle_notifications(buffer, n);
> +	}
> +
> +	return 0;
> +}
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
