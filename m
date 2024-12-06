Return-Path: <linux-fsdevel+bounces-36670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B956B9E788C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 20:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC3318821D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 19:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5324F1CD1E1;
	Fri,  6 Dec 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+jimjcL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123AC13D516
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511957; cv=none; b=KBjHTFd1apTh81T9piVAWHW8HT/JXPMwPDyTh/fD6CC1eB2PkkVS09h6Ih4OevsaA+kDSd2upd5ijzeO8onA7WDKTWbqyXvlgVfCpIAxNvcO1mxjRxlp21sNDxC6xohlMtfvLmbOW1dG8on+lANmt1r/oZGixgJsMRqGHebH+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511957; c=relaxed/simple;
	bh=3R4civ6l5dwioI6g7h+tsEXehyi2mTb8s26sr5vO4qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch54RHLK3VeMRyalMJmIGKcgAWeHM2rdubghYSoGpXT/mAOoVarZnjB/eYaQwli8OAktu219Ic9+5K+qyGiNv+dxY3v3md058NQSnMP/GuK9Z3+ZvqwCgGhHuJjbYrh9nDBEhgsIzcVZNt+dXJiyCA+pwcrfWP+Nh5b+X0MmOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+jimjcL; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46679337c08so13450391cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733511955; x=1734116755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P42hqiLMcTTT40nwp2EDxgBvGRX9Ojn2Ud0epooW6hk=;
        b=k+jimjcLPtNTSdL4KRhy4V6J12GZ+iFdggfJn4BBv2fzD3wuuWBmwII7S8T3dJgCly
         V/cAK4J62SiuJvhresgyfywl8Mg7hkcu3uonVIHYOO1WYqYU8ViACpuxzYPOEf61jyha
         2cGUMEwXWYCHYldjJo6FX8uFHDjf/3tyThwf+vISap+JsJMcNm76wOll3aCPN5M5OSbW
         4qy1DsmuBsWgyhIc3989LMowN3JvP76ytMn1M0CXFsM79i+wTlBcyxgly66ohD6O+NY0
         P8H2e91Yqm37FRISVFqS32LendjpiMaZvQ4AVSzxUuc0vq12Tg45LpIsPQgH+rWfOgrw
         3Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511955; x=1734116755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P42hqiLMcTTT40nwp2EDxgBvGRX9Ojn2Ud0epooW6hk=;
        b=kX9eFuHU5P6nI02/NMP7diNv8xw3ejrzeJEPsSJh5o4j89rjOLxr70ZzFonu4dWxCe
         a00UgBUAlNcG8/l9uBxFtv37l91M4NUxevr0QUs7xc2I9ryUTuHvpVUNOxXYvwZ/YiPs
         +tLhLHWEsQeDa9XXCwAzvQtHwsn+cni+Qn++QnANri8gWPfByeiJK8+HxMi4fPr6Vazs
         MUmPKE119eVMDVtjxyVyN0SJ/R6UvibvGdgNti5du6KMdW/BGU86X71bbUT0ttCj7zBo
         q/4lFQBWmrFSqnsqalPXgwREhXtnao2xIr/VsifV3Am6bicPO9s90VOx5sEJZjPMrA2j
         Jyiw==
X-Forwarded-Encrypted: i=1; AJvYcCXPcsPuP2lSMK423fSqoDn1b7Zw7Kx3KiqW3hz7KQmBqv/bLLhUAeaFbQDit0zX90IVlDZB7ignhbwQSYBI@vger.kernel.org
X-Gm-Message-State: AOJu0YztkncfNKYuL9UfHe3A8HZGslNm+0oAaMPqYVnAfsVy/tkK72HX
	L7LDTYYppwEfdwMBhqcxvlBKIrQBGVYyCBoR5kkmPcKYWiiy7rYzsafTRmDQApeQgeO0CTkfSaO
	aOvQ8yTnqRAhUwo0XYsok/N73obw=
X-Gm-Gg: ASbGncvNy3yZcEZUzqwuZcj8LcQVEw8ug4PGL/xw1KW/wYM30cIL1NCi0Vj10vbw47P
	ObC0Wbos/xHmXvGxQt6O9J03MdJpJU9lUatSo7j/iid1scvk=
X-Google-Smtp-Source: AGHT+IFjoVU9HGiySep9VA53TP6bnxAaYQRcpn5nvhYYZitXeLerphOMhq6oE8CGCwtYz6n8TFgEr9JtsXhFojRj0Hk=
X-Received: by 2002:a05:622a:19a2:b0:466:a763:257a with SMTP id
 d75a77b69052e-46734fcd62bmr54730401cf.54.1733511954760; Fri, 06 Dec 2024
 11:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com> <20241114191332.669127-3-joannelkoong@gmail.com>
In-Reply-To: <20241114191332.669127-3-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Dec 2024 11:05:43 -0800
Message-ID: <CAJnrk1Yc2VN-NZb4NfDNrvMmhP3AdioRoHOB0HxmyR_8aBNXRQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, bschubert@ddn.com, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, kernel-team@meta.com, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:31=E2=80=AFAM Etienne Martineau <etmartin4313@gmai=
l.com> wrote:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is deadlocked. Currently, there's no
> > good way to detect if a server is stuck and needs to be killed manually=
.
>
> I tried this V9 patchset and realized that upon max_request_timeout the c=
onnection will be dropped irrespectively if the task is in D state or not. =
I guess this is expected behavior.

Yes, the connection will be dropped regardless of what state the task is in=
.

> To me the concerning aspect is when tasks are going in D state because of=
 the consequence when running with hung_task_timeout_secs and hung_task_pan=
ic=3D1.

Could you elaborate on this a bit more? When running with
hung_task_timeout_secs and hung_task_panic=3D1, how does it cause the
task to go into D state?

>
> >
> > This commit adds an option for enforcing a timeout (in minutes) for
> > requests where if the timeout elapses without the server responding to
> > the request, the connection will be automatically aborted.
> >
> > Please note that these timeouts are not 100% precise. The request may
> > take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
> > timeout due to how it's internally implemented.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> > ---
> >  fs/fuse/dev.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h | 21 +++++++++++++
> >  fs/fuse/inode.c  | 21 +++++++++++++
> >  3 files changed, 122 insertions(+)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 29fc61a072ba..536aa4525e8f 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -45,6 +45,82 @@ static struct fuse_dev *fuse_get_dev(struct file *fi=
le)
> >       return READ_ONCE(file->private_data);
> >  }
> >
> > +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req=
)
> > +{
> > +     return jiffies > req->create_time + fc->timeout.req_timeout;
> > +}
> > +
> > +/*
> > + * Check if any requests aren't being completed by the specified reque=
st
> > + * timeout. To do so, we:
> > + * - check the fiq pending list
> > + * - check the bg queue
> > + * - check the fpq io and processing lists
> > + *
> > + * To make this fast, we only check against the head request on each l=
ist since
> > + * these are generally queued in order of creation time (eg newer requ=
ests get
> > + * queued to the tail). We might miss a few edge cases (eg requests tr=
ansitioning
> > + * between lists, re-sent requests at the head of the pending list hav=
ing a
> > + * later creation time than other requests on that list, etc.) but tha=
t is fine
> > + * since if the request never gets fulfilled, it will eventually be ca=
ught.
> > + */
> > +void fuse_check_timeout(struct timer_list *timer)
> > +{
> > +     struct fuse_conn *fc =3D container_of(timer, struct fuse_conn, ti=
meout.timer);
> Here this timer may get queued and if echo 1 > /sys/fs/fuse/connections/'=
nn'/abort is done at more or less the same time over the same connection I'=
m wondering what will happen?
> At least I think we may need timer_delete_sync() instead of timer_delete(=
) in fuse_abort_conn() and potentially call it from the top of fuse_abort_c=
onn() instead.

I don't think this is an issue because there's still a reference on
the "struct fuse_conn" when fuse_abort_conn() is called. The fuse_conn
struct is freed in fuse_conn_put() when the last refcount is dropped,
and in fuse_conn_put() there's this line

if (fc->timeout.req_timeout)
  timer_shutdown_sync(&fc->timeout.timer);

that guarantees the timer is not queued / callback of timer is not
running / cannot be rearmed.

>
> > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > +     struct fuse_req *req;
> > +     struct fuse_dev *fud;
> > +     struct fuse_pqueue *fpq;
> > +     bool expired =3D false;
> > +     int i;
> > +
> > +     spin_lock(&fiq->lock);
> Do we need spin_lock_irq instead bcos this is irq context no?

Yeah, I missed that spin_lock doesn't disable interrupts. Sergey noted
this as well in [1] and for the next iteration of this patchset, I'm
planning to use use a kthread per server connection, similar to what
the hung task watchdog does.

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1bwYjHGGNsPwjsd5Kp3iL6ua_hm=
yN3kFZo1b8OVV9bOpw@mail.gmail.com/

>
> >
> > +static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_=
context *ctx)
> > +{
> > +     if (ctx->req_timeout) {
> > +             if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->ti=
meout.req_timeout))
> > +                     fc->timeout.req_timeout =3D ULONG_MAX;
> > +             timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
> > +             mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIME=
R_FREQ);
> > +     } else {
> > +             fc->timeout.req_timeout =3D 0;
> > +     }
> > +}
> > +
> >  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_cont=
ext *ctx)
> >  {
> >       struct fuse_dev *fud =3D NULL;
> > @@ -1753,6 +1773,7 @@ int fuse_fill_super_common(struct super_block *sb=
, struct fuse_fs_context *ctx)
> >       fc->destroy =3D ctx->destroy;
> >       fc->no_control =3D ctx->no_control;
> >       fc->no_force_umount =3D ctx->no_force_umount;
> > +     fuse_init_fc_timeout(fc, ctx);
>
> The max_request_timeout is latched in fc->timeout.req_timeout during fuse=
_fill_super_common() so any further modification are not taking into effect
> Say:
>  sudo bash -c 'echo 100 > /proc/sys/fs/fuse/max_request_timeout'
>  sshfs -o allow_other,default_permissions you@localhost:/home/you/test ./=
mnt
>  kill -STOP `pidof /usr/lib/openssh/sftp-server`
>  ls ./mnt/
>  ^C
>   # Trying to change back the timeout doesn't have any effect
>  sudo bash -c 'echo 10 > /proc/sys/fs/fuse/max_request_timeout'
>

This is expected behavior. The timeout that's set at mount time will
be the timeout for the duration of the connection.


Thanks,
Joanne

> Thanks
>

