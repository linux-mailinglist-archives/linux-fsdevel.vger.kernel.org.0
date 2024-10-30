Return-Path: <linux-fsdevel+bounces-33274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5B29B6B09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C35BB21E3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C771612E7E;
	Wed, 30 Oct 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbQ87mWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA7E1BD9C1
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309543; cv=none; b=U12tvPDkwZ7favBk7+LteoOb5dBcSqbCTMFOuOk+J3T2+47ewQ7b1auXRNpcfrgRe1f2xuuzXeD8FiWVAlPrMuKyU9SGnBy9281BBTXxgkPu4gsmwhWffW6rGeNNF1WPWXZ7K/peID40EDlJCO11oNlGVj/dKRxCnftV2UORi48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309543; c=relaxed/simple;
	bh=/BsZgehSW0X6GgbzX2IOX7UC+hOGvq6Zf9SdBZ6dXxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jca2Vvky93Qpxclfy9i79mju6GgoY/45fq4yS28MKLFnJKs7IlNs7zEi5jJrcNvXnXYnxKEQI7RtD1CxamvS7SaLbAWGSVuV2UarI2hrXuTqDN0pfBm+F2YbqJApNf4SIhxfSoHMvNxBD+gbaBMXz9f6TSZyF5WJtzpf3N5i20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbQ87mWc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b175e059bdso6713185a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730309539; x=1730914339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zy/as/W6OJzQNBExrbVGIOBYsLak37lE4bUWfOGx78s=;
        b=JbQ87mWcrMtrEiwTarvyBL7LbVofF1UbLdCO21x2TEzWJy6Mi/gPlq1loZ45K6xo3Q
         45yTQ2hoRIQIYAq9T9f37RcxuuYXNq7WoIqz4ksqNiah5dO/agfQ9m+rFuHl1qHL32ES
         l4/UzX57HLPraJdS+Zr6yQ5cd8a8cbjryKxIAfoQr5jFIsJBSYysirReC6XmuoejukCS
         nkGhHfVuslpUz9eq59g3OnNriL4NITxROG6lfdRZ8Vlg7wDvL3pmpcR9XVqUKB7o3PP3
         azEH7U1BrDOVkoEq/Al2yUSsM5mf7hpyectN26ky6+aBp+oZyl4KoLK7nOE2HkA+1yYz
         0SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730309539; x=1730914339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zy/as/W6OJzQNBExrbVGIOBYsLak37lE4bUWfOGx78s=;
        b=NkNfklygMmU7wV7cHFpvhYx/NltYog0AyFx0fgx8uFMLJtlV9eZSJXQexNVlsP9B2R
         XwQLf9YHu5nlgB8aTPF9s84javcRIbblfzfBkiQWxXR67AKnezBvYAvaIwJU79CxRfFE
         yL1vuDB9xLWeo/uwUCfxWrhVyZEvcK2IPuGnWJ6FZ/Piz/xf3JppuFzgyi2KkhPr0ZE7
         OqIG2ctxCJUP6dT255aFL/g4LVSVPW72v3ClsY6RVKoJtZ5PUV/j/dGfmFZbPPoWidO2
         fUy6L2zQrjSDrbGILDY4a87FUp5Qx5S55SWMBO9ZIgGSWQzABj8ssCwpn68se6PJSlVY
         7R7g==
X-Forwarded-Encrypted: i=1; AJvYcCUppOyFQAqFdB6nMR/jQjlpFtOiikwK364YrWmbqiw3wB6ufBWA8jjWrkRCdcCfGs0dIeHog0t20VQgXXTi@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfAQ0rK4ZAPao4UYltU87ARyHKX5n9EL64/MCsNCGQqUChHXa
	GDEnNZZW/PmVR4V7bBm+dIV+fxzmegqXUlggYmE4Q5Jn5Z2l2tlnWGpzz+ApugVEYHXmIpQmbYq
	7m9ddbQAy0q5N7yc5Q4K+iADtLTY=
X-Google-Smtp-Source: AGHT+IE/4egbt/88PsRxVFIeokB3UOewKPA6rmR8q0nL4Aygd6Mjm4HfKIPmWNtCl0QElob1ortjapZXxHpvd6YhoAo=
X-Received: by 2002:a05:622a:113:b0:460:a50b:20a5 with SMTP id
 d75a77b69052e-4613c1b7c48mr183901411cf.60.1730309539566; Wed, 30 Oct 2024
 10:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011191320.91592-1-joannelkoong@gmail.com>
 <20241011191320.91592-4-joannelkoong@gmail.com> <1876668e-eae3-46ec-a8e0-3b23e6289295@fastmail.fm>
In-Reply-To: <1876668e-eae3-46ec-a8e0-3b23e6289295@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 30 Oct 2024 10:32:08 -0700
Message-ID: <CAJnrk1bXjtTo4Y+vvs5x5KW=W5EBGtPSj=uudCFUY5cx15PqtA@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:40=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 10/11/24 21:13, Joanne Koong wrote:
> > Introduce two new sysctls, "default_request_timeout" and
> > "max_request_timeout". These control how long (in minutes) a server can
> > take to reply to a request. If the server does not reply by the timeout=
,
> > then the connection will be aborted.
> >
> > "default_request_timeout" sets the default timeout if no timeout is
> > specified by the fuse server on mount. 0 (default) indicates no default
> > timeout should be enforced. If the server did specify a timeout, then
> > default_request_timeout will be ignored.
> >
> > "max_request_timeout" sets the max amount of time the server may take t=
o
> > reply to a request. 0 (default) indicates no maximum timeout. If
> > max_request_timeout is set and the fuse server attempts to set a
> > timeout greater than max_request_timeout, the system will use
> > max_request_timeout as the timeout. Similarly, if default_request_timeo=
ut
> > is greater than max_request_timeout, the system will use
> > max_request_timeout as the timeout. If the server does not request a
> > timeout and default_request_timeout is set to 0 but max_request_timeout
> > is set, then the timeout will be max_request_timeout.
> >
> > Please note that these timeouts are not 100% precise. The request may
> > take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max timeou=
t
> > due to how it's internally implemented.
> >
> > $ sysctl -a | grep fuse.default_request_timeout
> > fs.fuse.default_request_timeout =3D 0
> >
> > $ echo 65536 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> >
> > $ echo 65535 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > 65535
> >
> > $ sysctl -a | grep fuse.default_request_timeout
> > fs.fuse.default_request_timeout =3D 65535
> >
> > $ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > 0
> >
> > $ sysctl -a | grep fuse.default_request_timeout
> > fs.fuse.default_request_timeout =3D 0
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  Documentation/admin-guide/sysctl/fs.rst | 27 +++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h                        | 10 +++++++++
> >  fs/fuse/inode.c                         | 16 +++++++++++++--
> >  fs/fuse/sysctl.c                        | 20 ++++++++++++++++++
> >  4 files changed, 71 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/ad=
min-guide/sysctl/fs.rst
> > index fa25d7e718b3..790a34291467 100644
> > --- a/Documentation/admin-guide/sysctl/fs.rst
> > +++ b/Documentation/admin-guide/sysctl/fs.rst
> > @@ -342,3 +342,30 @@ filesystems:
> >  ``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
> >  setting/getting the maximum number of pages that can be used for servi=
cing
> >  requests in FUSE.
> > +
> > +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
> > +setting/getting the default timeout (in minutes) for a fuse server to
> > +reply to a kernel-issued request in the event where the server did not
> > +specify a timeout at mount. If the server set a timeout,
> > +then default_request_timeout will be ignored.  The default
> > +"default_request_timeout" is set to 0. 0 indicates a no-op (eg
> > +requests will not have a default request timeout set if no timeout was
> > +specified by the server).
> > +
> > +``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
> > +setting/getting the maximum timeout (in minutes) for a fuse server to
> > +reply to a kernel-issued request. A value greater than 0 automatically=
 opts
> > +the server into a timeout that will be at most "max_request_timeout", =
even if
> > +the server did not specify a timeout and default_request_timeout is se=
t to 0.
> > +If max_request_timeout is greater than 0 and the server set a timeout =
greater
> > +than max_request_timeout or default_request_timeout is set to a value =
greater
> > +than max_request_timeout, the system will use max_request_timeout as t=
he
> > +timeout. 0 indicates a no-op (eg requests will not have an upper bound=
 on the
> > +timeout and if the server did not request a timeout and default_reques=
t_timeout
> > +was not set, there will be no timeout).
> > +
> > +Please note that for the timeout options, if the server does not respo=
nd to
> > +the request by the time the timeout elapses, then the connection to th=
e fuse
> > +server will be aborted. Please also note that the timeouts are not 100=
%
> > +precise (eg you may set 10 minutes but the timeout may kick in after 1=
1
> > +minutes).
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index ef4558c2c44e..28d9230f4fcb 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -46,6 +46,16 @@
> >
> >  /** Maximum of max_pages received in init_out */
> >  extern unsigned int fuse_max_pages_limit;
> > +/*
> > + * Default timeout (in minutes) for the server to reply to a request
> > + * before the connection is aborted, if no timeout was specified on mo=
unt.
> > + */
> > +extern unsigned int fuse_default_req_timeout;
> > +/*
> > + * Max timeout (in minutes) for the server to reply to a request befor=
e
> > + * the connection is aborted.
> > + */
> > +extern unsigned int fuse_max_req_timeout;
> >
> >  /** List of active connections */
> >  extern struct list_head fuse_conn_list;
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index a78aac76b942..d97dde59eac3 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -36,6 +36,9 @@ DEFINE_MUTEX(fuse_mutex);
> >  static int set_global_limit(const char *val, const struct kernel_param=
 *kp);
> >
> >  unsigned int fuse_max_pages_limit =3D 256;
> > +/* default is no timeout */
> > +unsigned int fuse_default_req_timeout =3D 0;
> > +unsigned int fuse_max_req_timeout =3D 0;
> >
> >  unsigned max_user_bgreq;
> >  module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
> > @@ -1701,8 +1704,17 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount)=
;
> >
> >  static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_=
context *ctx)
> >  {
> > -     if (ctx->req_timeout) {
> > -             if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->ti=
meout.req_timeout))
> > +     unsigned int timeout =3D ctx->req_timeout ?: fuse_default_req_tim=
eout;
> > +
> > +     if (fuse_max_req_timeout) {
> > +             if (!timeout)
> > +                     timeout =3D fuse_max_req_timeout;
>
> Hmm, so 'max' might be used as 'min' as well. Isn't that a bit confusing?

Interesting. Yeah, i don't think there's a good name that encapsulates
the behavior of this (eg sets a min timeout if no timeout is set but
sets the max timeout if a timeout is set). in my head, I think of it
more as "max timeout that is automatically enforced if there's no timeout".


Thanks,
Joanne

>
>
> > +             else
> > +                     timeout =3D min(timeout, fuse_max_req_timeout)> +=
 }
> > +
> > +     if (timeout) {
> > +             if (check_mul_overflow(timeout * 60, HZ, &fc->timeout.req=
_timeout))
> >                       fc->timeout.req_timeout =3D U32_MAX;
> >               timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
> >               mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIME=
R_FREQ);
> > diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
> > index b272bb333005..e70b5269c16d 100644
> > --- a/fs/fuse/sysctl.c
> > +++ b/fs/fuse/sysctl.c
> > @@ -13,6 +13,8 @@ static struct ctl_table_header *fuse_table_header;
> >  /* Bound by fuse_init_out max_pages, which is a u16 */
> >  static unsigned int sysctl_fuse_max_pages_limit =3D 65535;
> >
> > +static unsigned int sysctl_fuse_max_req_timeout_limit =3D U16_MAX;
> > +
> >  static struct ctl_table fuse_sysctl_table[] =3D {
> >       {
> >               .procname       =3D "max_pages_limit",
> > @@ -23,6 +25,24 @@ static struct ctl_table fuse_sysctl_table[] =3D {
> >               .extra1         =3D SYSCTL_ONE,
> >               .extra2         =3D &sysctl_fuse_max_pages_limit,
> >       },
> > +     {
> > +             .procname       =3D "default_request_timeout",
> > +             .data           =3D &fuse_default_req_timeout,
> > +             .maxlen         =3D sizeof(fuse_default_req_timeout),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_douintvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
>
> There is slight whitespace issue here - spaces instead of tabs.

Thanks for noting - I'll fix this and the one below.


>
>
> > +             .extra2         =3D &sysctl_fuse_max_req_timeout_limit,
> > +     },
> > +     {
> > +             .procname       =3D "max_request_timeout",
> > +             .data           =3D &fuse_max_req_timeout,
> > +             .maxlen         =3D sizeof(fuse_max_req_timeout),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_douintvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
>
> And here.
>
> > +             .extra2         =3D &sysctl_fuse_max_req_timeout_limit,
> > +     },
> >  };
> >
> >  int fuse_sysctl_register(void)
>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

