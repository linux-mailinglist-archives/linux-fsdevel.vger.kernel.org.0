Return-Path: <linux-fsdevel+bounces-35661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6589D6CCB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 07:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C004D281506
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55178187561;
	Sun, 24 Nov 2024 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igOatJ24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60341AAC;
	Sun, 24 Nov 2024 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732429536; cv=none; b=Ih/DjgG03awbJd5bglpLcfo3OTYAPqGFj5Z3DaJAG24GwpCEal+C5H+kdDxj57nKvrqdvLo7MUQEIhFXIYWL3TNp4wjsnPGRXK2XvSIPxJ+7E1ozQZoLS4RLxGbwEkjcJmTBe/A+CFXtQGGi6rKqVmWJUaWDsJtWtiJLLrL6FzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732429536; c=relaxed/simple;
	bh=uTr2DLJ8vuqnzrN0fbBp4yZZ6aZUiGeleQlMZXRGFgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpVuC0IWPdCkb6DNc8Nr6lXl28AZrZ4xf6/dVUC/ky+nxY38qfmlg5gM6SurCERA+3XY5a/IyNpeY4SWThXmxOTCs7hDBT24MWfwPOrc7jDN4UDkxIE7/BZBPgrqxbI2xrcy6jEzd9IoHIjiIbFFOqez36AbfwR77ORla+H9LIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igOatJ24; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa53a971480so100617766b.1;
        Sat, 23 Nov 2024 22:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732429533; x=1733034333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBjPqidQ0caW4DrlxEDX4pxl5FAD/5hI66myyd/R3Po=;
        b=igOatJ24nAdde7Gd9D9Nu7ZvipJhtxJB9bdAMSeejGm76z8qtMK5cD0soNkrtpvmY1
         tB5XttJ+cb7a7IGY019iyz6JaRGk4vDVoYDqw3AcrhOm7qMpc+oo5X5SZZCYMTGYWpGw
         ZqNMo21vScralos/MZW6NFfnJRHCNukgTi0R9PvV9jFdTfbMF37qyA77ZjJhHc6c6bZm
         1UAJ8rO3d2mPLLt5bBHWdWpo2w6unASpbE50PoUlCV6ewOPdlZmBVMNj/Ql+/7eSLzzf
         L15LmAtBU+hiAlDGX13Omvn6nTmQf/h7d8pYRN0Ti0e0767QqY44+6uBErbkDVRg5pDZ
         t8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732429533; x=1733034333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBjPqidQ0caW4DrlxEDX4pxl5FAD/5hI66myyd/R3Po=;
        b=olDpTNQHbrKX8mNLXJuLDV5/BLhZRQXZuRagLNHHPZmT+JpSEI58Szr54OlIb5wf/X
         Rp+giwHOLrlvYbg+npxIbnRZNpg5R8GnKTGyfTwCmJeAjRjNt5VKXEbPopaxMnSmRr6k
         f+wFDnbvAWRY819D8b5JMBG/34hPGw9M8F2LWyyW7PMQOEJ2ftAHTdk7Jp4kEC0uFlpk
         4yOM9fXhoGJiEl0kgkqM89nnC+kZiDhIOXw26uJ2Wyqcc5b1oz6FmPvh0R3iqlOPDbdM
         BdnDBOuM4EsDiJR5uxJwtkRXeVsgftb60UqMYbblQuRX9hZK+DR/R4xsWK9qaNgMY0P7
         UR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU74aiUYs0k9mogqOxjFWQIZJga4YDBCSbmXSSn/zv56185zzOrCJ0Gd5NEWORoblhDsFCJKtrTHtkFFjEH@vger.kernel.org, AJvYcCUfIRWVuTMneJYYxFOS6KBV/GluLiJWGlOHq5rnMy7KEmtZ0v6mEPWpoqyjyL2o0wDbCAP4GemGcjfHVeEY@vger.kernel.org, AJvYcCUrrMNP7eXrbGB2D1MQqy3qifzYSVd2kKmWv2H8QVPjLtXkKTsA5HHYkYauG/40pow/wUdFLWF0r1qZNk7L2IMDSf8ZwMKv@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUj5E6CxP7EVmDbr4MbUTXEE3pjW4y840sUHRIebNcBRnezyy
	Vp0Ymw7Z+l626dvpb3Ged8RzKFP7jk0vTbXaaWntrDrsHkmCyDdlt/CIVMmKFnhmlUYMSQG+SJS
	RhcoxmPNduozSHJ44U4HugkfAwSI=
X-Gm-Gg: ASbGncsfGbnlolh42YtbyBTwxJ9Ko6Xgo4BRZiMqPsm+OlBfam/JWuYfoIAkPKvqZxl
	hGnpHdY/fq3eZAkumEJTw0GNwtPjG2+A=
X-Google-Smtp-Source: AGHT+IEOTuA2rkq2d3tavAwsFU39CVFiLGGWBG0Ef9cWIFW0Q2NcFHlhOw+7kvGvRVwFaUDNa4vylzskjCWpfh3vJac=
X-Received: by 2002:a17:907:77d4:b0:aa5:49f0:150f with SMTP id
 a640c23a62f3a-aa549f018b5mr67902266b.7.1732429532285; Sat, 23 Nov 2024
 22:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122225958.1775625-1-song@kernel.org> <20241122225958.1775625-2-song@kernel.org>
In-Reply-To: <20241122225958.1775625-2-song@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 24 Nov 2024 07:25:20 +0100
Message-ID: <CAOQ4uxgKoCztsPZ-X-annfrDwetpy1fcRJz-RdD-pAdMQKVH=Q@mail.gmail.com>
Subject: Re: [PATCH v3 fanotify 1/2] fanotify: Introduce fanotify filter
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 12:00=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> fanotify filter enables handling fanotify events within the kernel, and
> thus saves a trip to the user space. fanotify filter can be useful in
> many use cases. For example, if a user is only interested in events for
> some files in side a directory, a filter can be used to filter out
> irrelevant events.
>
> fanotify filter is attached to fsnotify_group. At most one filter can
> be attached to a fsnotify_group. The attach/detach of filter are
> controlled by two new ioctls on the fanotify fds: FAN_IOC_ADD_FILTER
> and FAN_IOC_DEL_FILTER.
>
> fanotify filter is packaged in a kernel module. In the future, it is
> also possible to package fanotify filter in a BPF program. Since loading
> modules requires CAP_SYS_ADMIN, _loading_ fanotify filter in kernel
> modules is limited to CAP_SYS_ADMIN. However, non-SYS_CAP_ADMIN users
> can _attach_ filter loaded by sys admin to their fanotify fds. The owner
> of the fanotify fitler can use flag FAN_FILTER_F_SYS_ADMIN_ONLY to
> make a filter available only to users with CAP_SYS_ADMIN.
>
> To make fanotify filters more flexible, a filter can take arguments at
> attach time.
>
> sysfs entry /sys/kernel/fanotify_filter is added to help users know
> which fanotify filters are available. At the moment, these files are
> added for each filter: flags, desc, and init_args.

It's a shame that we have fanotify knobs at /proc/sys/fs/fanotify/ and
in sysfs, but understand we don't want to make more use of proc for this.

Still I would add the filter files under a new /sys/fs/fanotify/ dir and no=
t
directly under /sys/kernel/

>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/notify/fanotify/Kconfig           |  13 ++
>  fs/notify/fanotify/Makefile          |   1 +
>  fs/notify/fanotify/fanotify.c        |  44 +++-
>  fs/notify/fanotify/fanotify_filter.c | 289 +++++++++++++++++++++++++++
>  fs/notify/fanotify/fanotify_user.c   |   7 +
>  include/linux/fanotify.h             | 128 ++++++++++++
>  include/linux/fsnotify_backend.h     |   6 +-
>  include/uapi/linux/fanotify.h        |  36 ++++
>  8 files changed, 520 insertions(+), 4 deletions(-)
>  create mode 100644 fs/notify/fanotify/fanotify_filter.c
>
> diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
> index 0e36aaf379b7..abfd59d95f49 100644
> --- a/fs/notify/fanotify/Kconfig
> +++ b/fs/notify/fanotify/Kconfig
> @@ -24,3 +24,16 @@ config FANOTIFY_ACCESS_PERMISSIONS
>            hierarchical storage management systems.
>
>            If unsure, say N.
> +
> +config FANOTIFY_FILTER
> +       bool "fanotify in kernel filter"
> +       depends on FANOTIFY
> +       default y
> +       help
> +          Say Y here if you want to use fanotify in kernel filter.
> +          The filter can be implemented in a kernel module or a
> +          BPF program. The filter can speed up fanotify in many
> +          use cases. For example, when the listener is only interested i=
n
> +          a subset of events.
> +
> +          If unsure, say Y.
> \ No newline at end of file
> diff --git a/fs/notify/fanotify/Makefile b/fs/notify/fanotify/Makefile
> index 25ef222915e5..d95ec0aeffb5 100644
> --- a/fs/notify/fanotify/Makefile
> +++ b/fs/notify/fanotify/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_FANOTIFY)         +=3D fanotify.o fanotify_user.o
> +obj-$(CONFIG_FANOTIFY_FILTER)  +=3D fanotify_filter.o
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 224bccaab4cc..c70184cd2d45 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -18,6 +18,8 @@
>
>  #include "fanotify.h"
>
> +extern struct srcu_struct fsnotify_mark_srcu;
> +
>  static bool fanotify_path_equal(const struct path *p1, const struct path=
 *p2)
>  {
>         return p1->mnt =3D=3D p2->mnt && p1->dentry =3D=3D p2->dentry;
> @@ -888,6 +890,7 @@ static int fanotify_handle_event(struct fsnotify_grou=
p *group, u32 mask,
>         struct fsnotify_event *fsn_event;
>         __kernel_fsid_t fsid =3D {};
>         u32 match_mask =3D 0;
> +       struct fanotify_filter_hook *filter_hook __maybe_unused;
>
>         BUILD_BUG_ON(FAN_ACCESS !=3D FS_ACCESS);
>         BUILD_BUG_ON(FAN_MODIFY !=3D FS_MODIFY);
> @@ -921,6 +924,39 @@ static int fanotify_handle_event(struct fsnotify_gro=
up *group, u32 mask,
>         pr_debug("%s: group=3D%p mask=3D%x report_mask=3D%x\n", __func__,
>                  group, mask, match_mask);
>
> +       if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
> +               fsid =3D fanotify_get_fsid(iter_info);
> +
> +#ifdef CONFIG_FANOTIFY_FILTER
> +       filter_hook =3D srcu_dereference(group->fanotify_data.filter_hook=
, &fsnotify_mark_srcu);

Do we actually need the sleeping rcu protection for calling the hook?
Can regular rcu read side be nested inside srcu read side?

Jan,

I don't remember why srcu is needed since we are not holding it
when waiting for userspace anymore?

> +       if (filter_hook) {
> +               struct fanotify_filter_event filter_event =3D {
> +                       .mask =3D mask,
> +                       .data =3D data,
> +                       .data_type =3D data_type,
> +                       .dir =3D dir,
> +                       .file_name =3D file_name,
> +                       .fsid =3D &fsid,
> +                       .match_mask =3D match_mask,
> +               };
> +
> +               ret =3D filter_hook->ops->filter(group, filter_hook, &fil=
ter_event);
> +
> +               /*
> +                * The filter may return
> +                * - FAN_FILTER_RET_SEND_TO_USERSPACE =3D> continue the r=
est;
> +                * - FAN_FILTER_RET_SKIP_EVENT =3D> return 0 now;
> +                * - < 0 error =3D> return error now.
> +                *
> +                * For the latter two cases, we can just return ret.
> +                */
> +               BUILD_BUG_ON(FAN_FILTER_RET_SKIP_EVENT !=3D 0);
> +
> +               if (ret !=3D FAN_FILTER_RET_SEND_TO_USERSPACE)
> +                       return ret;
> +       }
> +#endif
> +
>         if (fanotify_is_perm_event(mask)) {
>                 /*
>                  * fsnotify_prepare_user_wait() fails if we race with mar=
k
> @@ -930,9 +966,6 @@ static int fanotify_handle_event(struct fsnotify_grou=
p *group, u32 mask,
>                         return 0;
>         }
>
> -       if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
> -               fsid =3D fanotify_get_fsid(iter_info);
> -
>         event =3D fanotify_alloc_event(group, mask, data, data_type, dir,
>                                      file_name, &fsid, match_mask);
>         ret =3D -ENOMEM;
> @@ -976,6 +1009,11 @@ static void fanotify_free_group_priv(struct fsnotif=
y_group *group)
>
>         if (mempool_initialized(&group->fanotify_data.error_events_pool))
>                 mempool_exit(&group->fanotify_data.error_events_pool);
> +
> +#ifdef CONFIG_FANOTIFY_FILTER
> +       if (group->fanotify_data.filter_hook)
> +               fanotify_filter_hook_free(group->fanotify_data.filter_hoo=
k);
> +#endif
>  }
>
>  static void fanotify_free_path_event(struct fanotify_event *event)
> diff --git a/fs/notify/fanotify/fanotify_filter.c b/fs/notify/fanotify/fa=
notify_filter.c
> new file mode 100644
> index 000000000000..9215612e2fcb
> --- /dev/null
> +++ b/fs/notify/fanotify/fanotify_filter.c
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/fanotify.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +
> +#include "fanotify.h"
> +
> +extern struct srcu_struct fsnotify_mark_srcu;
> +
> +static DEFINE_SPINLOCK(filter_list_lock);
> +static LIST_HEAD(filter_list);
> +
> +static struct kobject *fan_filter_root_kobj;
> +
> +static struct {
> +       enum fanotify_filter_flags flag;
> +       const char *name;
> +} fanotify_filter_flags_names[] =3D {
> +       {
> +               .flag =3D FAN_FILTER_F_SYS_ADMIN_ONLY,
> +               .name =3D "SYS_ADMIN_ONLY",
> +       }
> +};
> +
> +static ssize_t flags_show(struct kobject *kobj,
> +                         struct kobj_attribute *attr, char *buf)
> +{
> +       struct fanotify_filter_ops *ops;
> +       ssize_t len =3D 0;
> +       int i;
> +
> +       ops =3D container_of(kobj, struct fanotify_filter_ops, kobj);
> +       for (i =3D 0; i < ARRAY_SIZE(fanotify_filter_flags_names); i++) {
> +               if (ops->flags & fanotify_filter_flags_names[i].flag) {
> +                       len +=3D sysfs_emit_at(buf, len, "%s%s", len ? " =
" : "",
> +                                            fanotify_filter_flags_names[=
i].name);
> +               }
> +       }
> +       len +=3D sysfs_emit_at(buf, len, "\n");
> +       return len;
> +}
> +
> +static ssize_t desc_show(struct kobject *kobj,
> +                        struct kobj_attribute *attr, char *buf)
> +{
> +       struct fanotify_filter_ops *ops;
> +
> +       ops =3D container_of(kobj, struct fanotify_filter_ops, kobj);
> +
> +       return sysfs_emit(buf, "%s\n", ops->desc ?: "N/A");
> +}
> +
> +static ssize_t init_args_show(struct kobject *kobj,
> +                             struct kobj_attribute *attr, char *buf)
> +{
> +       struct fanotify_filter_ops *ops;
> +
> +       ops =3D container_of(kobj, struct fanotify_filter_ops, kobj);
> +
> +       return sysfs_emit(buf, "%s\n", ops->init_args ?: "N/A");
> +}
> +
> +static struct kobj_attribute flags_kobj_attr =3D __ATTR_RO(flags);
> +static struct kobj_attribute desc_kobj_attr =3D __ATTR_RO(desc);
> +static struct kobj_attribute init_args_kobj_attr =3D __ATTR_RO(init_args=
);
> +
> +static struct attribute *fan_filter_attrs[] =3D {
> +       &flags_kobj_attr.attr,
> +       &desc_kobj_attr.attr,
> +       &init_args_kobj_attr.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(fan_filter);
> +
> +static void fan_filter_kobj_release(struct kobject *kobj)
> +{
> +}
> +
> +static const struct kobj_type fan_filter_ktype =3D {
> +       .release =3D fan_filter_kobj_release,
> +       .sysfs_ops =3D &kobj_sysfs_ops,
> +       .default_groups =3D fan_filter_groups,
> +};
> +
> +static struct fanotify_filter_ops *fanotify_filter_find(const char *name=
)
> +{
> +       struct fanotify_filter_ops *ops;
> +
> +       list_for_each_entry(ops, &filter_list, list) {
> +               if (!strcmp(ops->name, name))
> +                       return ops;
> +       }
> +       return NULL;
> +}
> +
> +static void __fanotify_filter_unregister(struct fanotify_filter_ops *ops=
)
> +{
> +       spin_lock(&filter_list_lock);
> +       list_del_init(&ops->list);
> +       spin_unlock(&filter_list_lock);
> +}
> +
> +/*
> + * fanotify_filter_register - Register a new filter.
> + *
> + * Add a filter to the filter_list. These filter are
> + * available for all users in the system.
> + *
> + * @ops:       pointer to fanotify_filter_ops to add.
> + *
> + * Returns:
> + *     0       - on success;
> + *     -EEXIST - filter of the same name already exists.
> + *     -ENODEV - fanotify filter was not properly initialized.
> + */
> +int fanotify_filter_register(struct fanotify_filter_ops *ops)
> +{
> +       int ret;
> +
> +       if (!fan_filter_root_kobj)
> +               return -ENODEV;
> +
> +       spin_lock(&filter_list_lock);
> +       if (fanotify_filter_find(ops->name)) {
> +               /* cannot register two filters with the same name */
> +               spin_unlock(&filter_list_lock);
> +               return -EEXIST;
> +       }
> +       list_add_tail(&ops->list, &filter_list);
> +       spin_unlock(&filter_list_lock);
> +
> +
> +       kobject_init(&ops->kobj, &fan_filter_ktype);
> +       ret =3D kobject_add(&ops->kobj, fan_filter_root_kobj, "%s", ops->=
name);
> +       if (ret) {
> +               __fanotify_filter_unregister(ops);
> +               return ret;
> +       }
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(fanotify_filter_register);
> +
> +/*
> + * fanotify_filter_unregister - Unregister a new filter.
> + *
> + * Remove a filter from filter_list.
> + *
> + * @ops:       pointer to fanotify_filter_ops to remove.
> + */
> +void fanotify_filter_unregister(struct fanotify_filter_ops *ops)
> +{
> +       kobject_put(&ops->kobj);
> +       __fanotify_filter_unregister(ops);
> +}
> +EXPORT_SYMBOL_GPL(fanotify_filter_unregister);
> +
> +/*
> + * fanotify_filter_add - Add a filter to fsnotify_group.
> + *
> + * Add a filter from filter_list to a fsnotify_group.
> + *
> + * @group:     fsnotify_group that will have add
> + * @argp:      fanotify_filter_args that specifies the filter
> + *             and the init arguments of the filter.
> + *
> + * Returns:
> + *     0       - on success;
> + *     -EEXIST - filter of the same name already exists.
> + */
> +int fanotify_filter_add(struct fsnotify_group *group,
> +                       struct fanotify_filter_args __user *argp)
> +{
> +       struct fanotify_filter_hook *filter_hook;
> +       struct fanotify_filter_ops *filter_ops;
> +       struct fanotify_filter_args args;
> +       void *init_args =3D NULL;
> +       int ret =3D 0;
> +
> +       ret =3D copy_from_user(&args, argp, sizeof(args));
> +       if (ret)
> +               return -EFAULT;
> +
> +       if (args.init_args_size > FAN_FILTER_ARGS_MAX)
> +               return -EINVAL;
> +
> +       args.name[FAN_FILTER_NAME_MAX - 1] =3D '\0';
> +
> +       fsnotify_group_lock(group);
> +
> +       if (rcu_access_pointer(group->fanotify_data.filter_hook)) {
> +               fsnotify_group_unlock(group);
> +               return -EBUSY;
> +       }
> +
> +       filter_hook =3D kzalloc(sizeof(*filter_hook), GFP_KERNEL);
> +       if (!filter_hook) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       spin_lock(&filter_list_lock);
> +       filter_ops =3D fanotify_filter_find(args.name);
> +       if (!filter_ops || !try_module_get(filter_ops->owner)) {
> +               spin_unlock(&filter_list_lock);
> +               ret =3D -ENOENT;
> +               goto err_free_hook;
> +       }
> +       spin_unlock(&filter_list_lock);
> +
> +       if (!capable(CAP_SYS_ADMIN) && (filter_ops->flags & FAN_FILTER_F_=
SYS_ADMIN_ONLY)) {

1. feels better to opt-in for UNPRIV (and maybe later on) rather than
make it the default.
2. need to check that filter_ops->flags has only "known" flags
3. probably need to add filter_ops->version check in case we want to
change the ABI

> +               ret =3D -EPERM;
> +               goto err_module_put;
> +       }
> +
> +       if (filter_ops->filter_init) {
> +               if (args.init_args_size !=3D filter_ops->init_args_size) =
{
> +                       ret =3D -EINVAL;
> +                       goto err_module_put;
> +               }
> +               if (args.init_args_size) {
> +                       init_args =3D kzalloc(args.init_args_size, GFP_KE=
RNEL);
> +                       if (!init_args) {
> +                               ret =3D -ENOMEM;
> +                               goto err_module_put;
> +                       }
> +                       if (copy_from_user(init_args, (void __user *)args=
.init_args,
> +                                          args.init_args_size)) {
> +                               ret =3D -EFAULT;
> +                               goto err_free_args;
> +                       }
> +
> +               }
> +               ret =3D filter_ops->filter_init(group, filter_hook, init_=
args);
> +               if (ret)
> +                       goto err_free_args;
> +               kfree(init_args);
> +       }
> +       filter_hook->ops =3D filter_ops;
> +       rcu_assign_pointer(group->fanotify_data.filter_hook, filter_hook)=
;
> +
> +out:
> +       fsnotify_group_unlock(group);
> +       return ret;
> +
> +err_free_args:
> +       kfree(init_args);
> +err_module_put:
> +       module_put(filter_ops->owner);
> +err_free_hook:
> +       kfree(filter_hook);
> +       goto out;
> +}
> +
> +void fanotify_filter_hook_free(struct fanotify_filter_hook *filter_hook)
> +{
> +       if (filter_hook->ops->filter_free)
> +               filter_hook->ops->filter_free(filter_hook);
> +
> +       module_put(filter_hook->ops->owner);
> +       kfree(filter_hook);
> +}
> +
> +/*
> + * fanotify_filter_del - Delete a filter from fsnotify_group.
> + */
> +void fanotify_filter_del(struct fsnotify_group *group)
> +{
> +       struct fanotify_filter_hook *filter_hook;
> +
> +       fsnotify_group_lock(group);
> +       filter_hook =3D group->fanotify_data.filter_hook;
> +       if (!filter_hook)
> +               goto out;
> +
> +       rcu_assign_pointer(group->fanotify_data.filter_hook, NULL);
> +       fanotify_filter_hook_free(filter_hook);

The read side is protected with srcu and there is no srcu/rcu delay of free=
ing.
You will either need something along the lines of
fsnotify_connector_destroy_workfn() with synchronize_srcu()
or use regular rcu delay and read side (assuming that it can be nested insi=
de
srcu read side?).

Thanks,
Amir.

