Return-Path: <linux-fsdevel+bounces-33247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F79B639E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 14:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E631C20D94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 13:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12B1E907A;
	Wed, 30 Oct 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsKHhAEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB9879D2;
	Wed, 30 Oct 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293410; cv=none; b=B/wY20X2cjZ70T/79dQEEHjtHmWbKyk0Wg5KEvCFagqfudo5LoMSLm7txxEZHb43YC4/m/nCr1QhCH2pMlqwmFvHFr7I+Q6SgVYf3QXMtReT9xreWSa9f/HZ3/vLilvKPJho5D/8vxRTB0NBtYCFg1LonskrdxWRWI3vljCmJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293410; c=relaxed/simple;
	bh=4JJuFUF260AEDPKZcNLDY2ITdnV9Hn1qJCgacNVcXI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KuoQSSt7x+HN16s/GTZNaDbqwnP9Fp3ioGCcBWZcuildXasySM95/S+gq8HBNrZKWEYSk/Ff+0r5R6Nx0KBk3N2KQK7UCqQIUSlO7oU01hlTGBJXIdI1QwE8/b8fVOrxOUnavqj/sgK08uJR6H8nrLFwbkuY84xqjVBzIH/ANdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsKHhAEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D94FC4CEE3;
	Wed, 30 Oct 2024 13:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730293410;
	bh=4JJuFUF260AEDPKZcNLDY2ITdnV9Hn1qJCgacNVcXI0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jsKHhAEj174ZBAEjCPNWFn6LRcIizGpvb0Letj4m3aOyZxCrxX8rqSggxiZKKNURn
	 TgJVSwQf51t3X3ncQ4qbUM6IMnFVdrjxtIoeAQPK1QiIhVkzyNdtWg58tsnbS9OUJI
	 jzObHEA0sDoRfivOYy1lSOyDt4TkMhtdEXaoAQtPIQxJSflER9aur+P4m+KDKVeILv
	 fALxkd+BqeV9xlU7A4HbWB1cb0T1QjkybbIvZ2asZ65i/wAt6GhmdWkl7UFSXIY+bE
	 3dEdRbk5znzwbA1xjUBdAoNnUYGMAnutUxbXYZrv814igekFWKRCQEgU0850+XMmr4
	 SQMk/ee5ZTuUQ==
Message-ID: <5b8318018dd316f618eea059f610579a205c05db.camel@kernel.org>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
From: Jeff Layton <jlayton@kernel.org>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@linux.dev,
 viro@zeniv.linux.org.uk,  brauner@kernel.org, jack@suse.cz,
 kpsingh@kernel.org, mattbobrowski@google.com,  amir73il@gmail.com,
 repnop@google.com, josef@toxicpanda.com
Date: Wed, 30 Oct 2024 09:03:27 -0400
In-Reply-To: <20241029231244.2834368-3-song@kernel.org>
References: <20241029231244.2834368-1-song@kernel.org>
	 <20241029231244.2834368-3-song@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-29 at 16:12 -0700, Song Liu wrote:
> This fastpath handler filters out events for files with certain prefixes.
> To use it:
>=20
>   [root] insmod fastpath-mod.ko    # This requires root.
>=20
>   [user] ./fastpath-user /tmp a,b,c &    # Root is not needed
>   [user] touch /tmp/aa   # a is in the prefix list (a,b,c), no events
>   [user] touch /tmp/xx   # x is not in the prefix list, generates events
>=20
>   Accessing file xx   # this is the output from fastpath_user
>=20
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  MAINTAINERS                      |   1 +
>  samples/Kconfig                  |  20 ++++-
>  samples/Makefile                 |   2 +-
>  samples/fanotify/.gitignore      |   1 +
>  samples/fanotify/Makefile        |   5 +-
>  samples/fanotify/fastpath-mod.c  | 138 +++++++++++++++++++++++++++++++
>  samples/fanotify/fastpath-user.c |  90 ++++++++++++++++++++
>  7 files changed, 254 insertions(+), 3 deletions(-)
>  create mode 100644 samples/fanotify/fastpath-mod.c
>  create mode 100644 samples/fanotify/fastpath-user.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ad507f49324..8939a48b2d99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8658,6 +8658,7 @@ S:	Maintained
>  F:	fs/notify/fanotify/
>  F:	include/linux/fanotify.h
>  F:	include/uapi/linux/fanotify.h
> +F:	samples/fanotify/
> =20
>  FARADAY FOTG210 USB2 DUAL-ROLE CONTROLLER
>  M:	Linus Walleij <linus.walleij@linaro.org>
> diff --git a/samples/Kconfig b/samples/Kconfig
> index b288d9991d27..b0d3dff48bb0 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -149,15 +149,33 @@ config SAMPLE_CONNECTOR
>  	  with it.
>  	  See also Documentation/driver-api/connector.rst
> =20
> +config SAMPLE_FANOTIFY
> +	bool "Build fanotify monitoring sample"
> +	depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
> +	help
> +	  When enabled, this builds samples for fanotify.
> +	  There multiple samples for fanotify. Please see the
> +	  following configs for more details of these
> +	  samples.
> +
>  config SAMPLE_FANOTIFY_ERROR
>  	bool "Build fanotify error monitoring sample"
> -	depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
> +	depends on SAMPLE_FANOTIFY
>  	help
>  	  When enabled, this builds an example code that uses the
>  	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
>  	  errors.
>  	  See also Documentation/admin-guide/filesystem-monitoring.rst.
> =20
> +config SAMPLE_FANOTIFY_FASTPATH
> +	tristate "Build fanotify fastpath sample"
> +	depends on SAMPLE_FANOTIFY && m
> +	help
> +	  When enabled, this builds kernel module that contains a
> +	  fanotify fastpath handler.
> +	  The fastpath handler filters out certain filename
> +	  prefixes for the fanotify user.
> +
>  config SAMPLE_HIDRAW
>  	bool "hidraw sample"
>  	depends on CC_CAN_LINK && HEADERS_INSTALL
> diff --git a/samples/Makefile b/samples/Makefile
> index b85fa64390c5..108360972626 100644
> --- a/samples/Makefile
> +++ b/samples/Makefile
> @@ -6,7 +6,7 @@ subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) +=3D binderfs
>  subdir-$(CONFIG_SAMPLE_CGROUP) +=3D cgroup
>  obj-$(CONFIG_SAMPLE_CONFIGFS)		+=3D configfs/
>  obj-$(CONFIG_SAMPLE_CONNECTOR)		+=3D connector/
> -obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)	+=3D fanotify/
> +obj-$(CONFIG_SAMPLE_FANOTIFY)		+=3D fanotify/
>  subdir-$(CONFIG_SAMPLE_HIDRAW)		+=3D hidraw
>  obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+=3D hw_breakpoint/
>  obj-$(CONFIG_SAMPLE_KDB)		+=3D kdb/
> diff --git a/samples/fanotify/.gitignore b/samples/fanotify/.gitignore
> index d74593e8b2de..306e1ddec4e0 100644
> --- a/samples/fanotify/.gitignore
> +++ b/samples/fanotify/.gitignore
> @@ -1 +1,2 @@
>  fs-monitor
> +fastpath-user
> diff --git a/samples/fanotify/Makefile b/samples/fanotify/Makefile
> index e20db1bdde3b..f5bbd7380104 100644
> --- a/samples/fanotify/Makefile
> +++ b/samples/fanotify/Makefile
> @@ -1,5 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -userprogs-always-y +=3D fs-monitor
> +userprogs-always-$(CONFIG_SAMPLE_FANOTIFY_ERROR) +=3D fs-monitor
> =20
>  userccflags +=3D -I usr/include -Wall
> =20
> +obj-$(CONFIG_SAMPLE_FANOTIFY_FASTPATH) +=3D fastpath-mod.o
> +
> +userprogs-always-$(CONFIG_SAMPLE_FANOTIFY_FASTPATH) +=3D fastpath-user
> diff --git a/samples/fanotify/fastpath-mod.c b/samples/fanotify/fastpath-=
mod.c
> new file mode 100644
> index 000000000000..06c4b42ff114
> --- /dev/null
> +++ b/samples/fanotify/fastpath-mod.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/fsnotify.h>
> +#include <linux/fanotify.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +
> +struct prefix_item {
> +	const char *prefix;
> +	struct list_head list;
> +};
> +
> +struct sample_fp_data {
> +	/*
> +	 * str_table contains all the prefixes to ignore. For example,
> +	 * "prefix1\0prefix2\0prefix3"
> +	 */
> +	char *str_table;
> +
> +	/* item->prefix points to different prefixes in the str_table. */
> +	struct list_head item_list;
> +};
> +
> +static int sample_fp_handler(struct fsnotify_group *group,
> +			     struct fanotify_fastpath_hook *fp_hook,
> +			     struct fanotify_fastpath_event *fp_event)
> +{
> +	const struct qstr *file_name =3D fp_event->file_name;
> +	struct sample_fp_data *fp_data;
> +	struct prefix_item *item;
> +
> +	if (!file_name)
> +		return FAN_FP_RET_SEND_TO_USERSPACE;
> +	fp_data =3D fp_hook->data;
> +
> +	list_for_each_entry(item, &fp_data->item_list, list) {
> +		if (strstr(file_name->name, item->prefix) =3D=3D (char *)file_name->na=
me)
> +			return FAN_FP_RET_SKIP_EVENT;
> +	}
> +
> +	return FAN_FP_RET_SEND_TO_USERSPACE;
> +}

The sample is a little underwhelming and everyone hates string parsing
in the kernel ;). It'd be nice to see a more real-world use-case for
this.

Could this be used to implement subtree filtering? I guess you'd have
to walk back up the directory tree and see whether it had a given
ancestor?

> +
> +static int add_item(struct sample_fp_data *fp_data, const char *prev)
> +{
> +	struct prefix_item *item;
> +
> +	item =3D kzalloc(sizeof(*item), GFP_KERNEL);
> +	if (!item)
> +		return -ENOMEM;
> +	item->prefix =3D prev;
> +	list_add_tail(&item->list, &fp_data->item_list);
> +	return 0;
> +}
> +
> +static void free_sample_fp_data(struct sample_fp_data *fp_data)
> +{
> +	struct prefix_item *item, *tmp;
> +
> +	list_for_each_entry_safe(item, tmp, &fp_data->item_list, list) {
> +		list_del_init(&item->list);
> +		kfree(item);
> +	}
> +	kfree(fp_data->str_table);
> +	kfree(fp_data);
> +}
> +
> +static int sample_fp_init(struct fanotify_fastpath_hook *fp_hook, const =
char *args)
> +{
> +	struct sample_fp_data *fp_data =3D kzalloc(sizeof(struct sample_fp_data=
), GFP_KERNEL);
> +	char *p, *prev;
> +	int ret;
> +
> +	if (!fp_data)
> +		return -ENOMEM;
> +
> +	/* Make a copy of the list of prefix to ignore */
> +	fp_data->str_table =3D kstrndup(args, FAN_FP_ARGS_MAX, GFP_KERNEL);
> +	if (!fp_data->str_table) {
> +		ret =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	INIT_LIST_HEAD(&fp_data->item_list);
> +	prev =3D fp_data->str_table;
> +	p =3D fp_data->str_table;
> +
> +	/* Update the list replace ',' with '\n'*/
> +	while ((p =3D strchr(p, ',')) !=3D NULL) {
> +		*p =3D '\0';
> +		ret =3D add_item(fp_data, prev);
> +		if (ret)
> +			goto err_out;
> +		p =3D p + 1;
> +		prev =3D p;
> +	}
> +
> +	ret =3D add_item(fp_data, prev);
> +	if (ret)
> +		goto err_out;
> +
> +	fp_hook->data =3D fp_data;
> +
> +	return 0;
> +
> +err_out:
> +	free_sample_fp_data(fp_data);
> +	return ret;
> +}
> +
> +static void sample_fp_free(struct fanotify_fastpath_hook *fp_hook)
> +{
> +	free_sample_fp_data(fp_hook->data);
> +}
> +
> +static struct fanotify_fastpath_ops fan_fp_ignore_a_ops =3D {
> +	.fp_handler =3D sample_fp_handler,
> +	.fp_init =3D sample_fp_init,
> +	.fp_free =3D sample_fp_free,
> +	.name =3D "ignore-prefix",
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int __init fanotify_fastpath_sample_init(void)
> +{
> +	return fanotify_fastpath_register(&fan_fp_ignore_a_ops);
> +}
> +static void __exit fanotify_fastpath_sample_exit(void)
> +{
> +	fanotify_fastpath_unregister(&fan_fp_ignore_a_ops);
> +}
> +
> +module_init(fanotify_fastpath_sample_init);
> +module_exit(fanotify_fastpath_sample_exit);
> +
> +MODULE_AUTHOR("Song Liu");
> +MODULE_DESCRIPTION("Example fanotify fastpath handler");
> +MODULE_LICENSE("GPL");
> diff --git a/samples/fanotify/fastpath-user.c b/samples/fanotify/fastpath=
-user.c
> new file mode 100644
> index 000000000000..f301c4e0d21a
> --- /dev/null
> +++ b/samples/fanotify/fastpath-user.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <err.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/fanotify.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +
> +static int total_event_cnt;
> +
> +static void handle_notifications(char *buffer, int len)
> +{
> +	struct fanotify_event_metadata *event =3D
> +		(struct fanotify_event_metadata *) buffer;
> +	struct fanotify_event_info_header *info;
> +	struct fanotify_event_info_fid *fid;
> +	struct file_handle *handle;
> +	char *name;
> +	int off;
> +
> +	for (; FAN_EVENT_OK(event, len); event =3D FAN_EVENT_NEXT(event, len)) =
{
> +		for (off =3D sizeof(*event) ; off < event->event_len;
> +		     off +=3D info->len) {
> +			info =3D (struct fanotify_event_info_header *)
> +				((char *) event + off);
> +			switch (info->info_type) {
> +			case FAN_EVENT_INFO_TYPE_DFID_NAME:
> +				fid =3D (struct fanotify_event_info_fid *) info;
> +				handle =3D (struct file_handle *)&fid->handle;
> +				name =3D (char *)handle + sizeof(*handle) + handle->handle_bytes;
> +
> +				printf("Accessing file %s\n", name);
> +				total_event_cnt++;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct fanotify_fastpath_args args =3D {
> +		.name =3D "ignore-prefix",
> +		.version =3D 1,
> +		.flags =3D 0,
> +	};
> +	char buffer[BUFSIZ];
> +	int fd;
> +
> +	if (argc < 3) {
> +		printf("Usage\n"
> +		       "\t %s <path to monitor> <prefix to ignore>\n",
> +			argv[0]);
> +		return 1;
> +	}
> +
> +	args.init_args =3D (__u64)argv[2];
> +	args.init_args_len =3D strlen(argv[2]) + 1;
> +
> +	fd =3D fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_NAME | FAN_REPORT_DIR=
_FID, O_RDONLY);
> +	if (fd < 0)
> +		errx(1, "fanotify_init");
> +
> +	if (fanotify_mark(fd, FAN_MARK_ADD,
> +			  FAN_OPEN | FAN_ONDIR | FAN_EVENT_ON_CHILD,
> +			  AT_FDCWD, argv[1])) {
> +		errx(1, "fanotify_mark");
> +	}
> +
> +	if (ioctl(fd, FAN_IOC_ADD_FP, &args))
> +		errx(1, "ioctl");
> +
> +	while (total_event_cnt < 10) {
> +		int n =3D read(fd, buffer, BUFSIZ);
> +
> +		if (n < 0)
> +			errx(1, "read");
> +
> +		handle_notifications(buffer, n);
> +	}
> +
> +	ioctl(fd, FAN_IOC_DEL_FP);
> +	close(fd);
> +
> +	return 0;
> +}

--=20
Jeff Layton <jlayton@kernel.org>

