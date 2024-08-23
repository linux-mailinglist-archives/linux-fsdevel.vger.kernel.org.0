Return-Path: <linux-fsdevel+bounces-27003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE395D962
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 00:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0311F23BF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB11C93AE;
	Fri, 23 Aug 2024 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2RxstM2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C91925A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453701; cv=none; b=qMKpbgGfb49zZ/Gwjm2N3PrHKI/80qDPDFpVVKEew67JqTjQ7XkYvZ1XfPXmnVW3prVb/c+HO6Z7gI+feg5Xepg6nVUFkAQiTjwU+rSrcagY/mK574X4RELQzHPVsGcUV05B8YD/3fFGcJYs64FSjTrzqWF7iPpIOkGzvyhawOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453701; c=relaxed/simple;
	bh=SJVb06pI7rAUMUT9SlLrkY7IwJTL9EPBFVp5bIM/ywE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lqe8ETHSxR6l38x/h8ZC5QefhqvUm2m7N8+K6HGEI8GcstaJ8A3Qbyb2LFIYEhhO3hVilk5G6kKp/L2juX1prJBAXc+p4GxnbHnhpCyWFCDw5FOPEwX6iJu8LRzRxPrh94MHV0rLzoqziyvquhI5Ew/ZMrSQ65Io3+CJCuOIeV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2RxstM2; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44fea44f725so19239861cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 15:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724453698; x=1725058498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOAvqZhaROfpoiTYw4C9Fr0Xq+31wK7fjoWQNVwjX4k=;
        b=G2RxstM24Jl/eMubA8pJ3gQbexXXgbtyOVvjiP0DVCeJfjjc3/eOFsXXRUF+USZIWZ
         ii+qtJWe5fwqox4sZskSr98jTzZIDmtnTyi/13JWKrbcZsF8iaMAbHxeEnGh6f4GMSLr
         2+xsvEgkvfZi23Bo8K6SseaodWTRkJlk3FAJ5xXFM/jgyul3hw99wZ/8vFVlZCofKxa+
         18hBlNOeyCdRjKNXV0dozYKbQ0mFmmFrsWTe1EzeN91mNboCiYo4TOHdVvss3E++fDCG
         89dfdsPEXvKJvDvULJEgp9fcqFUyrPSILNEEtXtRu/5Q40IfgYsdAuzDOIIhH3mb6gMq
         L2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724453698; x=1725058498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOAvqZhaROfpoiTYw4C9Fr0Xq+31wK7fjoWQNVwjX4k=;
        b=KQu/Rvqll4mE7nLmWYddi/W0j/8I100cXym5NG0poPIbI59yGg/F5V4y5zc4ZDWy+x
         NP3aWEwuWDPKUX1YPpUzc5IU+R7WPyUhvC1SfhR5sXskFlwKNyZszFQGJywbBH3Vco9c
         W/gWT6L1yOFgp8GxIKpn30TnBL/D47VtlG+v46Fdg4esBlROP8xYpjxfcOdj3+oJIKv1
         D9alA2tZW0XO6zAUGgiysZRVz5ZctCbe7TWfWAIta/Dq4aCKmt9P9Wf2dfJLPrdlv8LN
         j9Os9NleCU91bQ17fG9kAoLlkQn0qm6w7hyJqYWEuHxyi/wAa6dBINNWYMeRxYpRmjNR
         wz/A==
X-Forwarded-Encrypted: i=1; AJvYcCXu4o9r3Jtih3ZqV9y2Np/HY4+PRuBqcaVaWyMITBsuE8I3J6ahaF79pGvOFvxop9nnYt60TWkGunOGI0VR@vger.kernel.org
X-Gm-Message-State: AOJu0YweqKilmYl2lofeVXk1djmuF97bnM8cLJrYlpZ/DKSe32bD2GQ0
	pV9Bg6eK/Qxf8IQi3i9/ONcSRF4cORwVbjNnlekVIFlUM8GfBSyGBPnwwcZAqUFIizN78agk2Pr
	dlkr90o8fMGNdh0frKTVuonYaM2c=
X-Google-Smtp-Source: AGHT+IF+OBKA6soTj3CEQwIxWjcLljEoI2e4+dJ+otXHscBPFh2QQdbUzhSILTkioCoGTdli9C1soacG6p/xBNkzaIo=
X-Received: by 2002:a05:622a:5cc:b0:44f:fb6d:4b2f with SMTP id
 d75a77b69052e-454faebf0e4mr176213891cf.23.1724453698157; Fri, 23 Aug 2024
 15:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <20240813232241.2369855-3-joannelkoong@gmail.com> <2cd21f0b-e3db-4a6f-8a5e-8da4991985e8@linux.alibaba.com>
 <CAJnrk1Z+z8JzCu4QxnGRHsXGLQNmjfi32aGMqRjAE_C0LRn-7Q@mail.gmail.com> <5488bfcc-80be-4eb1-aac0-ed904becdb1c@linux.alibaba.com>
In-Reply-To: <5488bfcc-80be-4eb1-aac0-ed904becdb1c@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 23 Aug 2024 15:54:47 -0700
Message-ID: <CAJnrk1aPFhPG9YuOqPo4DtipsdNNmaA96aQBatz03MkH7kPcWA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, laoar.shao@gmail.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 7:17=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> On 8/23/24 5:19 AM, Joanne Koong wrote:
> > On Thu, Aug 22, 2024 at 12:06=E2=80=AFAM Jingbo Xu <jefflexu@linux.alib=
aba.com> wrote:
> >>
> >>
> >>
> >> On 8/14/24 7:22 AM, Joanne Koong wrote:
> >>> Introduce two new sysctls, "default_request_timeout" and
> >>> "max_request_timeout". These control timeouts on replies by the
> >>> server to kernel-issued fuse requests.
> >>>
> >>> "default_request_timeout" sets a timeout if no timeout is specified b=
y
> >>> the fuse server on mount. 0 (default) indicates no timeout should be =
enforced.
> >>>
> >>> "max_request_timeout" sets a maximum timeout for fuse requests. If th=
e
> >>> fuse server attempts to set a timeout greater than max_request_timeou=
t,
> >>> the system will default to max_request_timeout. Similarly, if the max
> >>> default timeout is greater than the max request timeout, the system w=
ill
> >>> default to the max request timeout. 0 (default) indicates no timeout =
should
> >>> be enforced.
> >>>
> >>> $ sysctl -a | grep fuse
> >>> fs.fuse.default_request_timeout =3D 0
> >>> fs.fuse.max_request_timeout =3D 0
> >>>
> >>> $ echo 0x100000000 | sudo tee /proc/sys/fs/fuse/default_request_timeo=
ut
> >>> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> >>>
> >>> $ echo 0xFFFFFFFF | sudo tee /proc/sys/fs/fuse/default_request_timeou=
t
> >>> 0xFFFFFFFF
> >>>
> >>> $ sysctl -a | grep fuse
> >>> fs.fuse.default_request_timeout =3D 4294967295
> >>> fs.fuse.max_request_timeout =3D 0
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> >>> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> >>> ---
> >>>  Documentation/admin-guide/sysctl/fs.rst | 17 ++++++++++
> >>>  fs/fuse/Makefile                        |  2 +-
> >>>  fs/fuse/fuse_i.h                        | 16 ++++++++++
> >>>  fs/fuse/inode.c                         | 19 ++++++++++-
> >>>  fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++++=
++
> >>>  5 files changed, 94 insertions(+), 2 deletions(-)
> >>>  create mode 100644 fs/fuse/sysctl.c
> >>>
> >>> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/=
admin-guide/sysctl/fs.rst
> >>> index 47499a1742bd..44fd495f69b4 100644
> >>> --- a/Documentation/admin-guide/sysctl/fs.rst
> >>> +++ b/Documentation/admin-guide/sysctl/fs.rst
> >>> @@ -332,3 +332,20 @@ Each "watch" costs roughly 90 bytes on a 32-bit =
kernel, and roughly 160 bytes
> >>>  on a 64-bit one.
> >>>  The current default value for ``max_user_watches`` is 4% of the
> >>>  available low memory, divided by the "watch" cost in bytes.
> >>> +
> >>> +5. /proc/sys/fs/fuse - Configuration options for FUSE filesystems
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +This directory contains the following configuration options for FUSE
> >>> +filesystems:
> >>> +
> >>> +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file f=
or
> >>> +setting/getting the default timeout (in seconds) for a fuse server t=
o
> >>> +reply to a kernel-issued request in the event where the server did n=
ot
> >>> +specify a timeout at mount. 0 indicates no timeout.
> >>> +
> >>> +``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
> >>> +setting/getting the maximum timeout (in seconds) for a fuse server t=
o
> >>> +reply to a kernel-issued request. If the server attempts to set a
> >>> +timeout greater than max_request_timeout, the system will use
> >>> +max_request_timeout as the timeout. 0 indicates no timeout.
> >>
> >> "0 indicates no timeout"
> >>
> >> I think 0 max_request_timeout shall indicate that there's no explicit
> >> maximum limitation for request_timeout.
> >
> > Hi Jingbo,
> >
> > Ah I see where the confusion in the wording is (eg that "0 indicates
> > no timeout" could be interpreted to mean there is no timeout at all
> > for the connection, rather than no timeout as the max limit). Thanks
> > for pointing this out. I'll make this more explicit in v5. I'll change
> > the wording above for the "default_request_timeout" case too.
> >
> >>
> >>
> >>> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> >>> index 6e0228c6d0cb..cd4ef3e08ebf 100644
> >>> --- a/fs/fuse/Makefile
> >>> +++ b/fs/fuse/Makefile
> >>> @@ -7,7 +7,7 @@ obj-$(CONFIG_FUSE_FS) +=3D fuse.o
> >>>  obj-$(CONFIG_CUSE) +=3D cuse.o
> >>>  obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
> >>>
> >>> -fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readd=
ir.o ioctl.o
> >>> +fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readd=
ir.o ioctl.o sysctl.o
> >>>  fuse-y +=3D iomode.o
> >>>  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> >>>  fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
> >>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> >>> index 0a2fa487a3bf..dae9977fa050 100644
> >>> --- a/fs/fuse/fuse_i.h
> >>> +++ b/fs/fuse/fuse_i.h
> >>> @@ -47,6 +47,14 @@
> >>>  /** Number of dentries for each connection in the control filesystem=
 */
> >>>  #define FUSE_CTL_NUM_DENTRIES 5
> >>>
> >>> +/*
> >>> + * Default timeout (in seconds) for the server to reply to a request
> >>> + * if no timeout was specified on mount
> >>> + */
> >>> +extern u32 fuse_default_req_timeout;
> >>> +/** Max timeout (in seconds) for the server to reply to a request */
> >>> +extern u32 fuse_max_req_timeout;
> >>> +
> >>>  /** List of active connections */
> >>>  extern struct list_head fuse_conn_list;
> >>>
> >>> @@ -1486,4 +1494,12 @@ ssize_t fuse_passthrough_splice_write(struct p=
ipe_inode_info *pipe,
> >>>                                     size_t len, unsigned int flags);
> >>>  ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_stru=
ct *vma);
> >>>
> >>> +#ifdef CONFIG_SYSCTL
> >>> +int fuse_sysctl_register(void);
> >>> +void fuse_sysctl_unregister(void);
> >>> +#else
> >>> +static inline int fuse_sysctl_register(void) { return 0; }
> >>> +static inline void fuse_sysctl_unregister(void) { return; }
> >>> +#endif /* CONFIG_SYSCTL */
> >>> +
> >>>  #endif /* _FS_FUSE_I_H */
> >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >>> index 9e69006fc026..cf333448f2d3 100644
> >>> --- a/fs/fuse/inode.c
> >>> +++ b/fs/fuse/inode.c
> >>> @@ -35,6 +35,10 @@ DEFINE_MUTEX(fuse_mutex);
> >>>
> >>>  static int set_global_limit(const char *val, const struct kernel_par=
am *kp);
> >>>
> >>> +/* default is no timeout */
> >>> +u32 fuse_default_req_timeout =3D 0;
> >>> +u32 fuse_max_req_timeout =3D 0;
> >>> +
> >>>  unsigned max_user_bgreq;
> >>>  module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
> >>>                 &max_user_bgreq, 0644);
> >>> @@ -1678,6 +1682,7 @@ int fuse_fill_super_common(struct super_block *=
sb, struct fuse_fs_context *ctx)
> >>>       struct fuse_conn *fc =3D fm->fc;
> >>>       struct inode *root;
> >>>       struct dentry *root_dentry;
> >>> +     u32 req_timeout;
> >>>       int err;
> >>>
> >>>       err =3D -EINVAL;
> >>> @@ -1730,10 +1735,16 @@ int fuse_fill_super_common(struct super_block=
 *sb, struct fuse_fs_context *ctx)
> >>>       fc->group_id =3D ctx->group_id;
> >>>       fc->legacy_opts_show =3D ctx->legacy_opts_show;
> >>>       fc->max_read =3D max_t(unsigned int, 4096, ctx->max_read);
> >>> -     fc->req_timeout =3D ctx->req_timeout * HZ;
> >>>       fc->destroy =3D ctx->destroy;
> >>>       fc->no_control =3D ctx->no_control;
> >>>       fc->no_force_umount =3D ctx->no_force_umount;
> >>> +     req_timeout =3D ctx->req_timeout ?: fuse_default_req_timeout;
> >>> +     if (!fuse_max_req_timeout)
> >>> +             fc->req_timeout =3D req_timeout * HZ;
> >>> +     else if (!req_timeout)
> >>> +             fc->req_timeout =3D fuse_max_req_timeout * HZ;
> >>
> >> So if fuse_max_req_timeout is non-zero and req_timeout is zero (either
> >> because of 0 fuse_default_req_timeout, or explicit "-o request_timeout=
 =3D
> >> 0" mount option), the final request timeout is exactly
> >> fuse_max_req_timeout, which is unexpected as I think 0
> >> fuse_default_req_timeout, or "-o request_timeout=3D0" shall indicate n=
o
> >> timeout.
> >
> > fuse_max_req_timeout takes precedence over fuse_default_req_timeout
> > (eg if the system administrator wants to enforce a max limit on fuse
> > timeouts, that is imposed even if a specific fuse server didn't
> > indicate a timeout or indicated no timeout). Sorry, that wasn't made
> > clear in the documentation. I'll add that in for v5.
>
> OK that is quite confusing.  If the system admin wants to enforce a
> timeout, then a non-zero fuse_default_req_timeout is adequate.  What's
> the case where fuse_default_req_timeout must be 0, and the aystem admin
> has to impose the enforced timeout through fuse_max_req_timeout?
>
> IMHO the semantics of fuse_max_req_timeout is not straightforward and
> can be confusing if it implies an enforced timeout when no timeout is
> specified, while at the same time it also imposes a maximum limitation
> when timeout is specified.

In my point of view, max_req_timeout is the ultimate safeguard the
administrator can set to enforce a timeout on all fuse requests on the
system (eg to mitigate rogue servers). When this is set, this
guarantees that absolutely no request will take longer than
max_req_timeout for the server to respond.

My understanding of /proc/sys sysctls is that ACLs can be used to
grant certain users/groups write permission for specific sysctl
parameters. So if a user wants to enforce a default request timeout,
they can set that. If that timeout is shorter than what the max
request timeout has been set to, then the request should time out
earlier according to that desired default timeout. But if it's greater
than what the max request timeout allows, then the max request timeout
limits the timeout on the request (the max request timeout is the
absolute upper bound on how long a request reply can take). It doesn't
matter if the user set no timeout as the default req timeout - what
matters is that there is a max req timeout on the system, and that
takes precedence for enforcing how long request replies can take.


Thanks,
Joanne
>
> >
> >>
> >>> +     else
> >>> +             fc->req_timeout =3D min(req_timeout, fuse_max_req_timeo=
ut) * HZ;
> >>>
> >>>       err =3D -ENOMEM;
> >>>       root =3D fuse_get_root_inode(sb, ctx->rootmode);
> >>> @@ -2046,8 +2057,14 @@ static int __init fuse_fs_init(void)
> >>>       if (err)
> >>>               goto out3;
> >>>
> >>> +     err =3D fuse_sysctl_register();
> >>> +     if (err)
> >>> +             goto out4;
> >>> +
> >>>       return 0;
> >>>
> >>> + out4:
> >>> +     unregister_filesystem(&fuse_fs_type);
> >>>   out3:
> >>>       unregister_fuseblk();
> >>>   out2:
> >>> diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
> >>> new file mode 100644
> >>> index 000000000000..c87bb0ecbfa9
> >>> --- /dev/null
> >>> +++ b/fs/fuse/sysctl.c
> >>> @@ -0,0 +1,42 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> +* linux/fs/fuse/fuse_sysctl.c
> >>> +*
> >>> +* Sysctl interface to fuse parameters
> >>> +*/
> >>> +#include <linux/sysctl.h>
> >>> +
> >>> +#include "fuse_i.h"
> >>> +
> >>> +static struct ctl_table_header *fuse_table_header;
> >>> +
> >>> +static struct ctl_table fuse_sysctl_table[] =3D {
> >>> +     {
> >>> +             .procname       =3D "default_request_timeout",
> >>> +             .data           =3D &fuse_default_req_timeout,
> >>> +             .maxlen         =3D sizeof(fuse_default_req_timeout),
> >>> +             .mode           =3D 0644,
> >>> +             .proc_handler   =3D proc_douintvec,
> >>> +     },
> >>> +     {
> >>> +             .procname       =3D "max_request_timeout",
> >>> +             .data           =3D &fuse_max_req_timeout,
> >>> +             .maxlen         =3D sizeof(fuse_max_req_timeout),
> >>> +             .mode           =3D 0644,
> >>> +             .proc_handler   =3D proc_douintvec,
> >>> +     },
> >>
> >> Missing "{}" here?  The internal implementation of register_sysctl()
> >> depends on an empty last element of the array as the sentinel.
> >
> > Could you point me to where this is enforced? I admittedly copied this
> > formatting from how other "struct ctl_table"s are getting defined, and
> > I don't see them using an extra {} here as well? (eg pty_table,
> > inotify_table, epolll_table)
>
> Alright.  When I pick this patch to an older kernel version. e.g. 5.10,
> and use register_sysctl_table() API instead as register_sysctl() API is
> not available yet at that time.  The register_sysctl_table() API depends
> on an empty last element in the array as the sentinel as I said above,
> while the new register_sysctl_sz() API, which is called by
> register_sysctl(), actually takes the size of the ctl_table in to avoid
> array out-of-bounds access.  So please ignore my noise.  Sorry for that.
>
>
> --
> Thanks,
> Jingbo

