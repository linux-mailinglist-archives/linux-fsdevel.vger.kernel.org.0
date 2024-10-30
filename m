Return-Path: <linux-fsdevel+bounces-33246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941A99B6343
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 13:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5316228218D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F91E908D;
	Wed, 30 Oct 2024 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZgwvwOh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916611E9060;
	Wed, 30 Oct 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292303; cv=none; b=sZMAFjjd+KCdIO1g+++mzFbdd/FEB3OZuNZ5oLrNP3LqFLIrsXjy6WdzkA4XwPkyqz8BAT5IACgQh2/SW0g6my7IbTP3KaVYiWIDA0T5nWZYdpfJpfYUpLjhh3glzNZOj4sP1hcat316FOWMhXH4LsQ8E8TDJvBV3KhGWx6uCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292303; c=relaxed/simple;
	bh=dgWvWvtO1T0XvvZpt3XHFm/OJolaOs0xEsAnQRiL46o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LCh71eOo16YLn7ImIhpF5iCcaVQwvsmaqaRFneClVBclaI4eWYpo2BOTtwpTwEnvbGL6OJjgeeqkLAMjYbZFo4eJcozVkALF+xtuTYWFVbckOXuTDBAC9SBcXg2OYBXbNLNQvgk7ReSnx1HKYBmlUBcNw9Y9dU6e8J/W8Nskz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZgwvwOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80707C4CEE3;
	Wed, 30 Oct 2024 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730292303;
	bh=dgWvWvtO1T0XvvZpt3XHFm/OJolaOs0xEsAnQRiL46o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BZgwvwOhFbVlos17TVV3IrHtVyCYEUJK0APdCOORFGypWn/J+JxCzBAUjCHNg9nRE
	 C4Rtr9F2Z5LA4J+xShz0EAiRGREGDkUH6+JrMb16MXHYZHGkcAshaQq6oTEgFSaagx
	 r6gdi+dfnIbxqK4WvKKBcgH7IaxWvT+mgmvBWJ/TVt9VAPcIGNwVZL5r95ZMyNoMUb
	 9GIDrqAndXvxpDKEJLkKI5CLnd8VHT1X92WnykskOne+1v/vC2kTuJk8xVPx+Sy55k
	 fPcATiNEm8YYoUtRkWf7WeAfG5J1JIP2h7qTl1jOKUGr1L1csKg1HgAScZoH8EUOH5
	 FPbc49GWrZeFA==
Message-ID: <869eb8b56d8d87f11bd4c1f18c395acf413555d2.camel@kernel.org>
Subject: Re: [RFC bpf-next fanotify 1/5] fanotify: Introduce fanotify
 fastpath handler
From: Jeff Layton <jlayton@kernel.org>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@linux.dev,
 viro@zeniv.linux.org.uk,  brauner@kernel.org, jack@suse.cz,
 kpsingh@kernel.org, mattbobrowski@google.com,  amir73il@gmail.com,
 repnop@google.com, josef@toxicpanda.com
Date: Wed, 30 Oct 2024 08:45:00 -0400
In-Reply-To: <20241029231244.2834368-2-song@kernel.org>
References: <20241029231244.2834368-1-song@kernel.org>
	 <20241029231244.2834368-2-song@kernel.org>
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
> fanotify fastpath handler enables handling fanotify events within the
> kernel, and thus saves a trip to the user space. fanotify fastpath handle=
r
> can be useful in many use cases. For example, if a user is only intereste=
d
> in events for some files in side a directory, a fastpath handler can be
> used to filter out irrelevant events.
>=20
> fanotify fastpath handler is attached to fsnotify_group. At most one
> fastpath handler can be attached to a fsnotify_group. The attach/detach
> of fastpath handlers are controlled by two new ioctls on the fanotify fds=
:
> FAN_IOC_ADD_FP and FAN_IOC_DEL_FP.
>=20
> fanotify fastpath handler is packaged in a kernel module. In the future,
> it is also possible to package fastpath handler in a BPF program. Since
> loading modules requires CAP_SYS_ADMIN, _loading_ fanotify fastpath
> handler in kernel modules is limited to CAP_SYS_ADMIN. However,
> non-SYS_CAP_ADMIN users can _attach_ fastpath handler loaded by sys admin
> to their fanotify fds. To make fanotify fastpath handler more useful
> for non-CAP_SYS_ADMIN users, a fastpath handler can take arguments at
> attach time.
>=20
> TODO: Add some mechanism to help users discover available fastpath
> handlers. For example, we can add a sysctl which is similar to
> net.ipv4.tcp_available_congestion_control, or we can add some sysfs
> entries.
>=20
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/notify/fanotify/Makefile            |   2 +-
>  fs/notify/fanotify/fanotify.c          |  25 ++++
>  fs/notify/fanotify/fanotify_fastpath.c | 171 +++++++++++++++++++++++++
>  fs/notify/fanotify/fanotify_user.c     |   7 +
>  include/linux/fanotify.h               |  45 +++++++
>  include/linux/fsnotify_backend.h       |   3 +
>  include/uapi/linux/fanotify.h          |  26 ++++
>  7 files changed, 278 insertions(+), 1 deletion(-)
>  create mode 100644 fs/notify/fanotify/fanotify_fastpath.c
>=20
> diff --git a/fs/notify/fanotify/Makefile b/fs/notify/fanotify/Makefile
> index 25ef222915e5..fddab88dde37 100644
> --- a/fs/notify/fanotify/Makefile
> +++ b/fs/notify/fanotify/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_FANOTIFY)		+=3D fanotify.o fanotify_user.o
> +obj-$(CONFIG_FANOTIFY)		+=3D fanotify.o fanotify_user.o fanotify_fastpat=
h.o

This should probably be a compile-time option. Some people might be
spooked by this and we'd want a way to disable it if it was found to
cause a big issue later.

> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 224bccaab4cc..a40ec06d0218 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -18,6 +18,8 @@
> =20
>  #include "fanotify.h"
> =20
> +extern struct srcu_struct fsnotify_mark_srcu;
> +
>  static bool fanotify_path_equal(const struct path *p1, const struct path=
 *p2)
>  {
>  	return p1->mnt =3D=3D p2->mnt && p1->dentry =3D=3D p2->dentry;
> @@ -888,6 +890,7 @@ static int fanotify_handle_event(struct fsnotify_grou=
p *group, u32 mask,
>  	struct fsnotify_event *fsn_event;
>  	__kernel_fsid_t fsid =3D {};
>  	u32 match_mask =3D 0;
> +	struct fanotify_fastpath_hook *fp_hook;
> =20
>  	BUILD_BUG_ON(FAN_ACCESS !=3D FS_ACCESS);
>  	BUILD_BUG_ON(FAN_MODIFY !=3D FS_MODIFY);
> @@ -933,6 +936,25 @@ static int fanotify_handle_event(struct fsnotify_gro=
up *group, u32 mask,
>  	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
>  		fsid =3D fanotify_get_fsid(iter_info);
> =20
> +	fp_hook =3D srcu_dereference(group->fanotify_data.fp_hook, &fsnotify_ma=
rk_srcu);
> +	if (fp_hook) {
> +		struct fanotify_fastpath_event fp_event =3D {
> +			.mask =3D mask,
> +			.data =3D data,
> +			.data_type =3D data_type,
> +			.dir =3D dir,
> +			.file_name =3D file_name,
> +			.fsid =3D &fsid,
> +			.match_mask =3D match_mask,
> +		};
> +
> +		ret =3D fp_hook->ops->fp_handler(group, fp_hook, &fp_event);
> +		if (ret =3D=3D FAN_FP_RET_SKIP_EVENT) {
> +			ret =3D 0;
> +			goto finish;
> +		}
> +	}
> +
>  	event =3D fanotify_alloc_event(group, mask, data, data_type, dir,
>  				     file_name, &fsid, match_mask);
>  	ret =3D -ENOMEM;
> @@ -976,6 +998,9 @@ static void fanotify_free_group_priv(struct fsnotify_=
group *group)
> =20
>  	if (mempool_initialized(&group->fanotify_data.error_events_pool))
>  		mempool_exit(&group->fanotify_data.error_events_pool);
> +
> +	if (group->fanotify_data.fp_hook)
> +		fanotify_fastpath_hook_free(group->fanotify_data.fp_hook);
>  }
> =20
>  static void fanotify_free_path_event(struct fanotify_event *event)
> diff --git a/fs/notify/fanotify/fanotify_fastpath.c b/fs/notify/fanotify/=
fanotify_fastpath.c
> new file mode 100644
> index 000000000000..0453a1ac25b1
> --- /dev/null
> +++ b/fs/notify/fanotify/fanotify_fastpath.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/fanotify.h>
> +#include <linux/module.h>
> +
> +#include "fanotify.h"
> +
> +extern struct srcu_struct fsnotify_mark_srcu;
> +
> +static DEFINE_SPINLOCK(fp_list_lock);
> +static LIST_HEAD(fp_list);
> +
> +static struct fanotify_fastpath_ops *fanotify_fastpath_find(const char *=
name)
> +{
> +	struct fanotify_fastpath_ops *ops;
> +
> +	list_for_each_entry(ops, &fp_list, list) {
> +		if (!strcmp(ops->name, name))
> +			return ops;
> +	}
> +	return NULL;
> +}
> +
> +
> +/*
> + * fanotify_fastpath_register - Register a new fastpath handler.
> + *
> + * Add a fastpath handler to the fp_list. These fastpath handlers are
> + * available for all users in the system.
> + *
> + * @ops:	pointer to fanotify_fastpath_ops to add.
> + *
> + * Returns:
> + *	0	- on success;
> + *	-EEXIST	- fastpath handler of the same name already exists.
> + */
> +int fanotify_fastpath_register(struct fanotify_fastpath_ops *ops)
> +{
> +	spin_lock(&fp_list_lock);
> +	if (fanotify_fastpath_find(ops->name)) {
> +		/* cannot register two handlers with the same name */
> +		spin_unlock(&fp_list_lock);
> +		return -EEXIST;
> +	}
> +	list_add_tail(&ops->list, &fp_list);
> +	spin_unlock(&fp_list_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fanotify_fastpath_register);
> +
> +/*
> + * fanotify_fastpath_unregister - Unregister a new fastpath handler.
> + *
> + * Remove a fastpath handler from fp_list.
> + *
> + * @ops:	pointer to fanotify_fastpath_ops to remove.
> + */
> +void fanotify_fastpath_unregister(struct fanotify_fastpath_ops *ops)
> +{
> +	spin_lock(&fp_list_lock);
> +	list_del_init(&ops->list);
> +	spin_unlock(&fp_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(fanotify_fastpath_unregister);
> +
> +/*
> + * fanotify_fastpath_add - Add a fastpath handler to fsnotify_group.
> + *
> + * Add a fastpath handler from fp_list to a fsnotify_group.
> + *
> + * @group:	fsnotify_group that will have add
> + * @argp:	fanotify_fastpath_args that specifies the fastpath handler
> + *		and the init arguments of the fastpath handler.
> + *
> + * Returns:
> + *	0	- on success;
> + *	-EEXIST	- fastpath handler of the same name already exists.
> + */
> +int fanotify_fastpath_add(struct fsnotify_group *group,
> +			  struct fanotify_fastpath_args __user *argp)
> +{
> +	struct fanotify_fastpath_hook *fp_hook;
> +	struct fanotify_fastpath_ops *fp_ops;
> +	struct fanotify_fastpath_args args;
> +	int ret =3D 0;
> +
> +	ret =3D copy_from_user(&args, argp, sizeof(args));
> +	if (ret)
> +		return -EFAULT;
> +
> +	if (args.version !=3D 1 || args.flags || args.init_args_len > FAN_FP_AR=
GS_MAX)
> +		return -EINVAL;
> +
> +	args.name[FAN_FP_NAME_MAX - 1] =3D '\0';
> +
> +	fsnotify_group_lock(group);
> +
> +	if (rcu_access_pointer(group->fanotify_data.fp_hook)) {
> +		fsnotify_group_unlock(group);
> +		return -EBUSY;
> +	}
> +
> +	fp_hook =3D kzalloc(sizeof(*fp_hook), GFP_KERNEL);
> +	if (!fp_hook) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	spin_lock(&fp_list_lock);
> +	fp_ops =3D fanotify_fastpath_find(args.name);
> +	if (!fp_ops || !try_module_get(fp_ops->owner)) {
> +		spin_unlock(&fp_list_lock);
> +		ret =3D -ENOENT;
> +		goto err_free_hook;
> +	}
> +	spin_unlock(&fp_list_lock);
> +
> +	if (fp_ops->fp_init) {
> +		char *init_args =3D NULL;
> +
> +		if (args.init_args_len) {
> +			init_args =3D strndup_user(u64_to_user_ptr(args.init_args),
> +						 args.init_args_len);
> +			if (IS_ERR(init_args)) {
> +				ret =3D PTR_ERR(init_args);
> +				if (ret =3D=3D -EINVAL)
> +					ret =3D -E2BIG;
> +				goto err_module_put;
> +			}
> +		}
> +		ret =3D fp_ops->fp_init(fp_hook, init_args);
> +		kfree(init_args);
> +		if (ret)
> +			goto err_module_put;
> +	}
> +	fp_hook->ops =3D fp_ops;
> +	rcu_assign_pointer(group->fanotify_data.fp_hook, fp_hook);
> +
> +out:
> +	fsnotify_group_unlock(group);
> +	return ret;
> +
> +err_module_put:
> +	module_put(fp_ops->owner);
> +err_free_hook:
> +	kfree(fp_hook);
> +	goto out;
> +}
> +
> +void fanotify_fastpath_hook_free(struct fanotify_fastpath_hook *fp_hook)
> +{
> +	if (fp_hook->ops->fp_free)
> +		fp_hook->ops->fp_free(fp_hook);
> +
> +	module_put(fp_hook->ops->owner);
> +}
> +
> +void fanotify_fastpath_del(struct fsnotify_group *group)
> +{
> +	struct fanotify_fastpath_hook *fp_hook;
> +
> +	fsnotify_group_lock(group);
> +	fp_hook =3D group->fanotify_data.fp_hook;
> +	if (!fp_hook)
> +		goto out;
> +
> +	rcu_assign_pointer(group->fanotify_data.fp_hook, NULL);
> +	fanotify_fastpath_hook_free(fp_hook);
> +
> +out:
> +	fsnotify_group_unlock(group);
> +}
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 8e2d43fc6f7c..e96cb83f8409 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -987,6 +987,13 @@ static long fanotify_ioctl(struct file *file, unsign=
ed int cmd, unsigned long ar
>  		spin_unlock(&group->notification_lock);
>  		ret =3D put_user(send_len, (int __user *) p);
>  		break;
> +	case FAN_IOC_ADD_FP:
> +		ret =3D fanotify_fastpath_add(group, p);
> +		break;
> +	case FAN_IOC_DEL_FP:
> +		fanotify_fastpath_del(group);
> +		ret =3D 0;
> +		break;
>  	}
> =20
>  	return ret;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 89ff45bd6f01..cea95307a580 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -136,4 +136,49 @@
>  #undef FAN_ALL_PERM_EVENTS
>  #undef FAN_ALL_OUTGOING_EVENTS
> =20
> +struct fsnotify_group;
> +struct qstr;
> +struct inode;
> +struct fanotify_fastpath_hook;
> +

This would be a nice place for a doc header that describes what all of
these fields represent. Most of it should probably be the same as the
comment header over the struct fsnotify_ops definition:

> +struct fanotify_fastpath_event {
> +	u32 mask;
> +	const void *data;
> +	int data_type;
> +	struct inode *dir;
> +	const struct qstr *file_name;
> +	__kernel_fsid_t *fsid;
> +	u32 match_mask;
> +};
> +

Ditto here. This should have a kerneldoc comment that describes the
purpose, arguments and the "contract" around these new operations.

> +struct fanotify_fastpath_ops {
> +	int (*fp_handler)(struct fsnotify_group *group,
> +			  struct fanotify_fastpath_hook *fp_hook,
> +			  struct fanotify_fastpath_event *fp_event);
> +	int (*fp_init)(struct fanotify_fastpath_hook *hook, const char *args);
> +	void (*fp_free)(struct fanotify_fastpath_hook *hook);
> +
> +	char name[FAN_FP_NAME_MAX];
> +	struct module *owner;
> +	struct list_head list;
> +	int flags;
> +};
> +
> +enum fanotify_fastpath_return {
> +	FAN_FP_RET_SEND_TO_USERSPACE =3D 0,
> +	FAN_FP_RET_SKIP_EVENT =3D 1,
> +};
> +
> +struct fanotify_fastpath_hook {
> +	struct fanotify_fastpath_ops *ops;
> +	void *data;
> +};
> +
> +int fanotify_fastpath_register(struct fanotify_fastpath_ops *ops);
> +void fanotify_fastpath_unregister(struct fanotify_fastpath_ops *ops);
> +int fanotify_fastpath_add(struct fsnotify_group *group,
> +			  struct fanotify_fastpath_args __user *args);
> +void fanotify_fastpath_del(struct fsnotify_group *group);
> +void fanotify_fastpath_hook_free(struct fanotify_fastpath_hook *fp_hook)=
;
> +
>  #endif /* _LINUX_FANOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 3ecf7768e577..ef251b4e4e6f 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -117,6 +117,7 @@ struct fsnotify_fname;
>  struct fsnotify_iter_info;
> =20
>  struct mem_cgroup;
> +struct fanotify_fastpath_hook;
> =20
>  /*
>   * Each group much define these ops.  The fsnotify infrastructure will c=
all
> @@ -255,6 +256,8 @@ struct fsnotify_group {
>  			int f_flags; /* event_f_flags from fanotify_init() */
>  			struct ucounts *ucounts;
>  			mempool_t error_events_pool;
> +
> +			struct fanotify_fastpath_hook __rcu *fp_hook;
>  		} fanotify_data;
>  #endif /* CONFIG_FANOTIFY */
>  	};
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index 34f221d3a1b9..9c30baeebae0 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -3,6 +3,7 @@
>  #define _UAPI_LINUX_FANOTIFY_H
> =20
>  #include <linux/types.h>
> +#include <linux/ioctl.h>
> =20
>  /* the following events that user-space can register for */
>  #define FAN_ACCESS		0x00000001	/* File was accessed */
> @@ -243,4 +244,29 @@ struct fanotify_response_info_audit_rule {
>  				(long)(meta)->event_len >=3D (long)FAN_EVENT_METADATA_LEN && \
>  				(long)(meta)->event_len <=3D (long)(len))
> =20
> +#define FAN_FP_NAME_MAX 64
> +#define FAN_FP_ARGS_MAX 1024
> +
> +/* This is the arguments used to add fastpath handler to a group. */
> +struct fanotify_fastpath_args {
> +	/* user space pointer to the name of fastpath handler */
> +	char name[FAN_FP_NAME_MAX];
> +
> +	__u32 version;
> +	__u32 flags;
> +
> +	/*
> +	 * user space pointer to the init args of fastpath handler,
> +	 * up to init_args_len (<=3D FAN_FP_ARGS_MAX).
> +	 */
> +	__u64 init_args;
> +	/* length of init_args */
> +	__u32 init_args_len;
> +} __attribute__((__packed__));
> +
> +#define FAN_IOC_MAGIC 'F'
> +
> +#define FAN_IOC_ADD_FP _IOW(FAN_IOC_MAGIC, 0, struct fanotify_fastpath_a=
rgs)
> +#define FAN_IOC_DEL_FP _IOW(FAN_IOC_MAGIC, 1, char[FAN_FP_NAME_MAX])
> +
>  #endif /* _UAPI_LINUX_FANOTIFY_H */

Otherwise, this looks fairly straightforward. Nice work, Song!
--=20
Jeff Layton <jlayton@kernel.org>

