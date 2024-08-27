Return-Path: <linux-fsdevel+bounces-27422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7009096168A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944DD1C224F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7471D2783;
	Tue, 27 Aug 2024 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5mmBUmC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9D1CE6F9
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782452; cv=none; b=M+VyVyMxWLwIIJ0vZxR4hMyBxyOQxMUicA7PPYAqcLvVcxtAPkfqGpVQ6XII5nRUdmLS0UuOcywNsi4B+Ki/MTxXSz4NLkJhFL67qlH8DdNypoTJszZ9/1sh9KT2APNXh6ZMdZOL0C/vRGdQ0d7X6132ff93aQGERjiF04pwpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782452; c=relaxed/simple;
	bh=SJZE6OJLdzVE2FnIiJQaJMkOfSQluTx/Gsa/bLb1x6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gffZ58aOxYoKHKYL9A4sNcD7Xl4gozC/z+iA/el9YHyH82eyF3o8zMTJILzT9oa+0RwLu9KS2WkaD5gba0qV/WozNAsypsDWZQ407Iz+pSdX4iewtZ70L26WEF3WiocDmEBn80zX4wS3AqlroI1mGQugjPC3Lo6uPV/6P0ghXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5mmBUmC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-454b3d8999aso32954011cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724782448; x=1725387248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Saixu2ZHi8LjIfX1rlik0tXctawLg6RuqecL4ASZpAg=;
        b=P5mmBUmCFjXU2lVOe0MUCxGeC24x4Fa16P1cZt/+o5uzjT7AG70UmJd8kPuSLId3CE
         eS6Bm2HmGRH8v2eiccsBBjkrAaHXINA0IXRy+zn69PDpVV1+5QWFIGfRpypl2BU3t8rc
         NzS6qBNcTyFiIOVdBcDD0ziNus95oOg+xyzYBVdTQQ2lpz4RaHIjyHsJT+3UhuNkwQ3A
         24fIlkqs0mJtYlEfcfB30e96gT/3aC80iy2Epplc9zMQbzmO5jcsYOZk8CjnWMxk4fmj
         v8J7eNiEnp6hjkWSs2RlrH4eOTuaBgSKOlCyEYcnnw7Sn+qWOs9RD90d1w8OWLVnsuKR
         AdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782448; x=1725387248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Saixu2ZHi8LjIfX1rlik0tXctawLg6RuqecL4ASZpAg=;
        b=StBP4sncjk/5fmP2pxIsDX9TfFnIk9uKDPH2OUYaOAkSPKBVqQSWvUdSCNRTCgaLFg
         TBO5QLlZcwp54AvvXnvPBWIY1yGa4ikCFhkS8YN00LLnKkFGQ04hv2ZSMvwb4Hj5tA3I
         JTXZjlW8B+WbIlBgusbYCmoETG+yAhhi/r4+/qMG7TXHb7ims3bJdfjWqF8lcvjv+hDN
         Ws36kZ0T45NdQdr5x18MXjrhoMCVm/Bn/CfL0/hYDtJEJKndacI0kFkdpeuEJXd90w4f
         WOtjhlz/UGzsZpKKHDCORJDj8+mEBEiqcVVyW9YaLfSASeavJW2jkjX0pld2TyxG+6g2
         Vl8A==
X-Forwarded-Encrypted: i=1; AJvYcCWXD1X1Yhvu2VqcL2CxRIj4DTKAzy6seYdSRqVijxbyAS/+Hf6UDS9YMfsgxA4X44O/zALD0Mh3hIPH2FLe@vger.kernel.org
X-Gm-Message-State: AOJu0YwHtd/vI/mRHRnjk6OL5eGAne1jsi1SW6EZuUCq+KmrBIM3mKv1
	xZ4HFLAZDZotKLwkcNLA7//Co+Z02AvyXlrSxza+xZeAh3qW9WiZqSXUll0pHdP5fWugJah0VkG
	7H4j47D1cLVGOGI+yRAdVeL3G/uM=
X-Google-Smtp-Source: AGHT+IFfhadsHihSkL3FcU1d3qzbcop/+rVacPBBJSLznSSbVIcr6mOj5Y0j4+eKWJxdUZm2xJF2HJQiD3intKdHXHU=
X-Received: by 2002:a05:622a:1dc4:b0:454:f400:455c with SMTP id
 d75a77b69052e-45509c35bf8mr180466871cf.30.1724782448053; Tue, 27 Aug 2024
 11:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <20240813232241.2369855-3-joannelkoong@gmail.com> <2cd21f0b-e3db-4a6f-8a5e-8da4991985e8@linux.alibaba.com>
 <CAJnrk1Z+z8JzCu4QxnGRHsXGLQNmjfi32aGMqRjAE_C0LRn-7Q@mail.gmail.com>
 <5488bfcc-80be-4eb1-aac0-ed904becdb1c@linux.alibaba.com> <CAJnrk1aPFhPG9YuOqPo4DtipsdNNmaA96aQBatz03MkH7kPcWA@mail.gmail.com>
 <cca30890-afd0-412e-b4c8-c075bcaf9ed5@linux.alibaba.com>
In-Reply-To: <cca30890-afd0-412e-b4c8-c075bcaf9ed5@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Aug 2024 11:13:57 -0700
Message-ID: <CAJnrk1b_95fQwWWTWOm0FG25PXOp+dgmPVx6XYrhfHOzdoW01g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, laoar.shao@gmail.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:12=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> On 8/24/24 6:54 AM, Joanne Koong wrote:
> > On Thu, Aug 22, 2024 at 7:17=E2=80=AFPM Jingbo Xu <jefflexu@linux.aliba=
ba.com> wrote:
> >>
> >> On 8/23/24 5:19 AM, Joanne Koong wrote:
> >>> On Thu, Aug 22, 2024 at 12:06=E2=80=AFAM Jingbo Xu <jefflexu@linux.al=
ibaba.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 8/14/24 7:22 AM, Joanne Koong wrote:
> >>>>> Introduce two new sysctls, "default_request_timeout" and
> >>>>> "max_request_timeout". These control timeouts on replies by the
> >>>>> server to kernel-issued fuse requests.
> >>>>>
> >>>>> "default_request_timeout" sets a timeout if no timeout is specified=
 by
> >>>>> the fuse server on mount. 0 (default) indicates no timeout should b=
e enforced.
> >>>>>
> >>>>> "max_request_timeout" sets a maximum timeout for fuse requests. If =
the
> >>>>> fuse server attempts to set a timeout greater than max_request_time=
out,
> >>>>> the system will default to max_request_timeout. Similarly, if the m=
ax
> >>>>> default timeout is greater than the max request timeout, the system=
 will
> >>>>> default to the max request timeout. 0 (default) indicates no timeou=
t should
> >>>>> be enforced.
> >>>>>
> >>>>> $ sysctl -a | grep fuse
> >>>>> fs.fuse.default_request_timeout =3D 0
> >>>>> fs.fuse.max_request_timeout =3D 0
> >>>>>
> >>>>> $ echo 0x100000000 | sudo tee /proc/sys/fs/fuse/default_request_tim=
eout
> >>>>> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> >>>>>
> >>>>> $ echo 0xFFFFFFFF | sudo tee /proc/sys/fs/fuse/default_request_time=
out
> >>>>> 0xFFFFFFFF
> >>>>>
> >>>>> $ sysctl -a | grep fuse
> >>>>> fs.fuse.default_request_timeout =3D 4294967295
> >>>>> fs.fuse.max_request_timeout =3D 0
> >>>>>
> >>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> >>>>> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> >>>>> ---
> >>>>>  Documentation/admin-guide/sysctl/fs.rst | 17 ++++++++++
> >>>>>  fs/fuse/Makefile                        |  2 +-
> >>>>>  fs/fuse/fuse_i.h                        | 16 ++++++++++
> >>>>>  fs/fuse/inode.c                         | 19 ++++++++++-
> >>>>>  fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++=
++++
> >>>>>  5 files changed, 94 insertions(+), 2 deletions(-)
> >>>>>  create mode 100644 fs/fuse/sysctl.c
> >>>>>
> >>>>> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentatio=
n/admin-guide/sysctl/fs.rst
> >>>>> index 47499a1742bd..44fd495f69b4 100644
> >>>>> --- a/Documentation/admin-guide/sysctl/fs.rst
> >>>>> +++ b/Documentation/admin-guide/sysctl/fs.rst
> >>>>> @@ -332,3 +332,20 @@ Each "watch" costs roughly 90 bytes on a 32-bi=
t kernel, and roughly 160 bytes
> >>>>>  on a 64-bit one.
> >>>>>  The current default value for ``max_user_watches`` is 4% of the
> >>>>>  available low memory, divided by the "watch" cost in bytes.
> >>>>> +
> >>>>> +5. /proc/sys/fs/fuse - Configuration options for FUSE filesystems
> >>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> +
> >>>>> +This directory contains the following configuration options for FU=
SE
> >>>>> +filesystems:
> >>>>> +
> >>>>> +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file=
 for
> >>>>> +setting/getting the default timeout (in seconds) for a fuse server=
 to
> >>>>> +reply to a kernel-issued request in the event where the server did=
 not
> >>>>> +specify a timeout at mount. 0 indicates no timeout.
> >>>>> +
> >>>>> +``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
> >>>>> +setting/getting the maximum timeout (in seconds) for a fuse server=
 to
> >>>>> +reply to a kernel-issued request. If the server attempts to set a
> >>>>> +timeout greater than max_request_timeout, the system will use
> >>>>> +max_request_timeout as the timeout. 0 indicates no timeout.
> >>>>
> >>>> "0 indicates no timeout"
> >>>>
> >>>> I think 0 max_request_timeout shall indicate that there's no explici=
t
> >>>> maximum limitation for request_timeout.
> >>>
> >>> Hi Jingbo,
> >>>
> >>> Ah I see where the confusion in the wording is (eg that "0 indicates
> >>> no timeout" could be interpreted to mean there is no timeout at all
> >>> for the connection, rather than no timeout as the max limit). Thanks
> >>> for pointing this out. I'll make this more explicit in v5. I'll chang=
e
> >>> the wording above for the "default_request_timeout" case too.
> >>>
> >>>>
> >>>>
> >>>>> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> >>>>> index 6e0228c6d0cb..cd4ef3e08ebf 100644
> >>>>> --- a/fs/fuse/Makefile
> >>>>> +++ b/fs/fuse/Makefile
> >>>>> @@ -7,7 +7,7 @@ obj-$(CONFIG_FUSE_FS) +=3D fuse.o
> >>>>>  obj-$(CONFIG_CUSE) +=3D cuse.o
> >>>>>  obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
> >>>>>
> >>>>> -fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o rea=
ddir.o ioctl.o
> >>>>> +fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o rea=
ddir.o ioctl.o sysctl.o
> >>>>>  fuse-y +=3D iomode.o
> >>>>>  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> >>>>>  fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
> >>>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> >>>>> index 0a2fa487a3bf..dae9977fa050 100644
> >>>>> --- a/fs/fuse/fuse_i.h
> >>>>> +++ b/fs/fuse/fuse_i.h
> >>>>> @@ -47,6 +47,14 @@
> >>>>>  /** Number of dentries for each connection in the control filesyst=
em */
> >>>>>  #define FUSE_CTL_NUM_DENTRIES 5
> >>>>>
> >>>>> +/*
> >>>>> + * Default timeout (in seconds) for the server to reply to a reque=
st
> >>>>> + * if no timeout was specified on mount
> >>>>> + */
> >>>>> +extern u32 fuse_default_req_timeout;
> >>>>> +/** Max timeout (in seconds) for the server to reply to a request =
*/
> >>>>> +extern u32 fuse_max_req_timeout;
> >>>>> +
> >>>>>  /** List of active connections */
> >>>>>  extern struct list_head fuse_conn_list;
> >>>>>
> >>>>> @@ -1486,4 +1494,12 @@ ssize_t fuse_passthrough_splice_write(struct=
 pipe_inode_info *pipe,
> >>>>>                                     size_t len, unsigned int flags)=
;
> >>>>>  ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_st=
ruct *vma);
> >>>>>
> >>>>> +#ifdef CONFIG_SYSCTL
> >>>>> +int fuse_sysctl_register(void);
> >>>>> +void fuse_sysctl_unregister(void);
> >>>>> +#else
> >>>>> +static inline int fuse_sysctl_register(void) { return 0; }
> >>>>> +static inline void fuse_sysctl_unregister(void) { return; }
> >>>>> +#endif /* CONFIG_SYSCTL */
> >>>>> +
> >>>>>  #endif /* _FS_FUSE_I_H */
> >>>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >>>>> index 9e69006fc026..cf333448f2d3 100644
> >>>>> --- a/fs/fuse/inode.c
> >>>>> +++ b/fs/fuse/inode.c
> >>>>> @@ -35,6 +35,10 @@ DEFINE_MUTEX(fuse_mutex);
> >>>>>
> >>>>>  static int set_global_limit(const char *val, const struct kernel_p=
aram *kp);
> >>>>>
> >>>>> +/* default is no timeout */
> >>>>> +u32 fuse_default_req_timeout =3D 0;
> >>>>> +u32 fuse_max_req_timeout =3D 0;
> >>>>> +
> >>>>>  unsigned max_user_bgreq;
> >>>>>  module_param_call(max_user_bgreq, set_global_limit, param_get_uint=
,
> >>>>>                 &max_user_bgreq, 0644);
> >>>>> @@ -1678,6 +1682,7 @@ int fuse_fill_super_common(struct super_block=
 *sb, struct fuse_fs_context *ctx)
> >>>>>       struct fuse_conn *fc =3D fm->fc;
> >>>>>       struct inode *root;
> >>>>>       struct dentry *root_dentry;
> >>>>> +     u32 req_timeout;
> >>>>>       int err;
> >>>>>
> >>>>>       err =3D -EINVAL;
> >>>>> @@ -1730,10 +1735,16 @@ int fuse_fill_super_common(struct super_blo=
ck *sb, struct fuse_fs_context *ctx)
> >>>>>       fc->group_id =3D ctx->group_id;
> >>>>>       fc->legacy_opts_show =3D ctx->legacy_opts_show;
> >>>>>       fc->max_read =3D max_t(unsigned int, 4096, ctx->max_read);
> >>>>> -     fc->req_timeout =3D ctx->req_timeout * HZ;
> >>>>>       fc->destroy =3D ctx->destroy;
> >>>>>       fc->no_control =3D ctx->no_control;
> >>>>>       fc->no_force_umount =3D ctx->no_force_umount;
> >>>>> +     req_timeout =3D ctx->req_timeout ?: fuse_default_req_timeout;
> >>>>> +     if (!fuse_max_req_timeout)
> >>>>> +             fc->req_timeout =3D req_timeout * HZ;
> >>>>> +     else if (!req_timeout)
> >>>>> +             fc->req_timeout =3D fuse_max_req_timeout * HZ;
> >>>>
> >>>> So if fuse_max_req_timeout is non-zero and req_timeout is zero (eith=
er
> >>>> because of 0 fuse_default_req_timeout, or explicit "-o request_timeo=
ut =3D
> >>>> 0" mount option), the final request timeout is exactly
> >>>> fuse_max_req_timeout, which is unexpected as I think 0
> >>>> fuse_default_req_timeout, or "-o request_timeout=3D0" shall indicate=
 no
> >>>> timeout.
> >>>
> >>> fuse_max_req_timeout takes precedence over fuse_default_req_timeout
> >>> (eg if the system administrator wants to enforce a max limit on fuse
> >>> timeouts, that is imposed even if a specific fuse server didn't
> >>> indicate a timeout or indicated no timeout). Sorry, that wasn't made
> >>> clear in the documentation. I'll add that in for v5.
> >>
> >> OK that is quite confusing.  If the system admin wants to enforce a
> >> timeout, then a non-zero fuse_default_req_timeout is adequate.  What's
> >> the case where fuse_default_req_timeout must be 0, and the aystem admi=
n
> >> has to impose the enforced timeout through fuse_max_req_timeout?
> >>
> >> IMHO the semantics of fuse_max_req_timeout is not straightforward and
> >> can be confusing if it implies an enforced timeout when no timeout is
> >> specified, while at the same time it also imposes a maximum limitation
> >> when timeout is specified.
> >
> > In my point of view, max_req_timeout is the ultimate safeguard the
> > administrator can set to enforce a timeout on all fuse requests on the
> > system (eg to mitigate rogue servers). When this is set, this
> > guarantees that absolutely no request will take longer than
> > max_req_timeout for the server to respond.
> >
> > My understanding of /proc/sys sysctls is that ACLs can be used to
> > grant certain users/groups write permission for specific sysctl
> > parameters. So if a user wants to enforce a default request timeout,
> > they can set that. If that timeout is shorter than what the max
> > request timeout has been set to, then the request should time out
> > earlier according to that desired default timeout. But if it's greater
> > than what the max request timeout allows, then the max request timeout
> > limits the timeout on the request (the max request timeout is the
> > absolute upper bound on how long a request reply can take). It doesn't
> > matter if the user set no timeout as the default req timeout - what
> > matters is that there is a max req timeout on the system, and that
> > takes precedence for enforcing how long request replies can take.
> >
>
> Sorry for the late reply, just back from vacation these days.
>
> Anyway, if max_req_timeout enforces a maximum timeout no matter whether
> the fuse server explicitly specifies a timeout or not, then the
> semantics of fuse_default_req_timeout seems a little bit overlapped with
> max_req_timeout, right?  The only place where fuse_default_req_timeout
> plays a role is when ctx->req_timeout and fuse_max_req_timeout are both
> zero, in which case we can get the same effect if we eliminate
> fuse_default_req_timeout and configure a non-zero fuse_max_req_timeout.
>

The behavior would not be the same if we eliminated
fuse_default_request_timeout and configured a non-zero
fuse_max_request_timeout instead. For example, say we want a default
timeout of 10 secs. With fuse_default_request_timeout set to 10 secs,
if a server specifies a timeout that is 15 secs, that is perfectly ok.
If we get rid of fuse_default_request_timeout and just use
fuse_max_request_timeout of 10 secs, that will limit servers to 10
secs even if they specified 15 secs.

Thanks,
Joanne

> --
> Thanks,
> Jingbo

