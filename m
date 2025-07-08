Return-Path: <linux-fsdevel+bounces-54242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994EEAFCB27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 14:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5AA7A6C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECEF2DC35C;
	Tue,  8 Jul 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8IAvoPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E8B2DC34D
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979526; cv=none; b=JxRWyTrIQ0YdpnOkKEGXwTfCMRcb8v9cPb/rC/r22YqEtEhgE2T59FfdmNs7Ev7vjrx0abS607fBo02qCeD8t5Z28n9fNYHsDICkiIRBYpVdJvVBt4Aue6YJLe+nEchqDy8jZ4JJdpXdSOe9w/Ple0rHmzDX+4xNE3mBZ/79ELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979526; c=relaxed/simple;
	bh=alkoyjUYfYretHljrlu/LRLe7347epIocvfxspTDkgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQExgyzi4HXRB4LIf/qMBQVUxpTRBw8jasueQdxOBK6wECQBTAerZX6iW+mG3LPNEBf7/UB8EtTTOwGimPnKrTpsxzLGeyU6LxwD2N1MM9CnA9ohkao+HvTUN67eeKiRGecPkgsopzpHOSKdbKMja3chGbnO4Pgzh0jmxyA6/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8IAvoPZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so839439866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751979523; x=1752584323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHGiqCWC0Mfv7WvGoqZNfIMEiGBgLNB8qy6v9PkyaE0=;
        b=M8IAvoPZ/vS059PgkbWjhilyz3I+dQ75zifJq4IWTTnGgpjifSh9384RWTODYVccM4
         GHvVsPjolpaU3IxLgzrl1KSMcL6zg+qyjRk4b3vh7kwZF9kphmdk7jhNdw3/mloFFltb
         hIeqXJWKnKOZad7O8MY7/bvhE5cYuUt5gHt1bj2m2naKGRRYe67Nc7uc6tG1LwKdRUOO
         VihJXdO++Jr0Qu9kOW36ZKpnnYqEfIT3WDuXL0fIcaelaS/pmzNQ57HL8NPejsJ6Eu+N
         HlQfENa19ALnSXi2V8LaoGDfaHcX3UaVRBk8t/eJqchUxNZMASx3eT7caG1ROgSe+J/5
         INvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751979523; x=1752584323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHGiqCWC0Mfv7WvGoqZNfIMEiGBgLNB8qy6v9PkyaE0=;
        b=pIEnv+FHEOSGiSFcvmlXBV4x7ow1T5bWCaKGCMWKAq8VxQ7ie36ImsUvimHNIp34qU
         MOkxzITHsRYeqGTTvKFqDiwyraKZ8CQtHy1lgpC/M8DUub2wSsZUEG+7UXg2dj68SpoW
         ct6kRLs6HSz2ebkA9ino6u3nxWcpmGQOuEcBIaZwndQ6lDFv27KSA5TCqA3UJ9U4NKul
         72lJbj/KgohmgLVV5nmIbXjpf8YtIGlvaHzrlH4LraEw+SsR7kGpI0+Med3A/cnmObey
         jSas/RyA2337e3DLTLSz7V5PPWZ7jS0DvVujMyJ5f3b7dzrv3L7qt8/34OQJ67zptknu
         jLZA==
X-Forwarded-Encrypted: i=1; AJvYcCWacnqALiltgy4yEmnL4R9m6ViLEpDAZeDt7tkIniRew+ejpTxT3C/LEROZtq+7DYQa1ITcLMSvU4h8Kcvk@vger.kernel.org
X-Gm-Message-State: AOJu0YySA71PdXV872nANA1EZHgdFrCMybLM0K3WoMsc5uyAslyfTsEC
	ugNmrbrrJHiE2vOOs5rvbioletA6fHzytwcgn3OGsLy08FhMGggaF0naeaIvlzTw9FxpeX8U0vK
	4k6FdW7yuVFAQPPdwayox6hUGzGnkrCI=
X-Gm-Gg: ASbGncvpB3Kfi3O6hIVgFPXLrBEZf4nWzgIX9RvTzrImVMcUjCAfq/mo3G9FdySFE+f
	lDAZhWtrB6JISgu6BhitvbriYuXYqk9otX49RkX5/7I2CAW7PHDKWzIUq1ci6UpHUot+C3839Yo
	So3YWAbmSsTdDDIbE+tAmC2ZECol408IMMYx6nqwHKDiEmuE7nKgcYsg==
X-Google-Smtp-Source: AGHT+IFguOEX/yHY74dVa5aYiAF96YP0rqWWOSq39Bd4EiFGdWgzXiYFVVgzyivzhXsBR2cbuf9ozFi12VgNlCCa4Go=
X-Received: by 2002:a17:907:2d90:b0:ade:1863:6ff2 with SMTP id
 a640c23a62f3a-ae6b0769eadmr311711166b.52.1751979522737; Tue, 08 Jul 2025
 05:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxi8xjfhKLc7T0WGjOmtO4wRQT6b5MLUdaST2KE01BsKBg@mail.gmail.com>
 <20250701072209.1549495-1-ibrahimjirdeh@meta.com> <CAOQ4uxhrbN4k+YMd99h8jGyRc0d_n05H8q-gTuJ35jkO1aLO7A@mail.gmail.com>
 <pcyd4ejepc6akgw3uq2bxuf2e255zhirbpfxxe463zj2m7iyfl@6bgetglt74ei>
In-Reply-To: <pcyd4ejepc6akgw3uq2bxuf2e255zhirbpfxxe463zj2m7iyfl@6bgetglt74ei>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Jul 2025 14:58:31 +0200
X-Gm-Features: Ac12FXwiYwwaRQ_okP6d5bp6ooRH4UL3RtorYVp9sXbNs1JDLdyEuSH57YoPeHg
Message-ID: <CAOQ4uxiAtKcdzpBP_ZA2hxpECULri+T9DTQRnT1iOCVJfYcryg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 1:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 07-07-25 18:33:41, Amir Goldstein wrote:
> > On Tue, Jul 1, 2025 at 9:23=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@me=
ta.com> wrote:
> > > On 6/30/25, 9:06 AM, "Amir Goldstein" <amir73il@gmail.com <mailto:ami=
r73il@gmail.com>> wrote:
> > > > On Mon, Jun 30, 2025 at 4:50=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > > I agree expanding fanotify_event_metadata painful. After all that=
's the
> > > > > reason why we've invented the additional info records in the firs=
t place :).
> > > > > So I agree with putting the id either in a separate info record o=
r overload
> > > > > something in fanotify_event_metadata.
> > > > >
> > > > > On Sun 29-06-25 08:50:05, Amir Goldstein wrote:
> > > > > > I may have mentioned this before, but I'll bring it up again.
> > > > > > If we want to overload event->fd with response id I would consi=
der
> > > > > > allocating response_id with idr_alloc_cyclic() that starts at 2=
56
> > > > > > and then set event->fd =3D -response_id.
> > > > > > We want to skip the range -1..-255 because it is used to report
> > > > > > fd open errors with FAN_REPORT_FD_ERROR.
> > > > >
> > > > > I kind of like this. It looks elegant. The only reason I'm hesita=
ting is
> > > > > that as you mentioned with persistent notifications we'll likely =
need
> > > > > 64-bit type for identifying event. But OTOH requirements there ar=
e unclear
> > > > > and I can imagine even userspace assigning the ID. In the worst c=
ase we
> > > > > could add info record for this persistent event id.
> > > >
> > > > Yes, those persistent id's are inherently different from the respon=
se key,
> > > > so I am not really worried about duplicity.
> > > >
> > > > > So ok, let's do it as you suggest.
> > > >
> > > > Cool.
> > > >
> > > > I don't think that we even need an explicit FAN_REPORT_EVENT_ID,
> > > > because it is enough to say that (fid_mode !=3D 0) always means tha=
t
> > > > event->fd cannot be >=3D 0 (like it does today), but with pre-conte=
nt events
> > > > event->fd can be a key < -255?
> > > >
> > > > Ibrahim,
> > > >
> > > > Feel free to post the patches from my branch, if you want
> > > > post the event->fd =3D -response_id implementation.
> > > >
> > > > I also plan to post them myself when I complete the pre-dir-content=
 patches.
> > >
> > > Sounds good. I will pull in the FAN_CLASS_PRE_CONTENT | FAN_REPORT_FI=
D branch
> > > and resubmit this patch now that we have consensus on the approach he=
re.
> >
> > FYI, I pushed some semantic changed to fan_pre_content_fid branch:
> >
> > - Created shortcut macro FAN_CLASS_PRE_CONTENT_FID
> > - Created a group priority FSNOTIFY_PRIO_PRE_CONTENT_FID
> >
> > Regarding the question whether reporting response_id instead of event->=
fd
> > requires an opt-in, so far my pre-dir-content patches can report event-=
>fd,
> > so my preference id the response_id behavior will require opt-in with i=
nit
> > flag FAN_REPORT_RESPONSE_ID.
>
> No problem with the FAN_REPORT_RESPONSE_ID feature flag, just we'll see
> whether the classical fd-based events are useful enough with
> pre-dir-content events to justify their existence ;).
>
> > @@ -67,6 +67,7 @@
> >  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target=
 id  */
> >  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report=
 error */
> >  #define FAN_REPORT_MNT         0x00004000      /* Report mount events =
*/
> > +#define FAN_REPORT_RESPONSE_ID 0x00008000      /* event->fd is a respo=
nse id */
> >
> >  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
> >  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> > @@ -144,7 +145,10 @@ struct fanotify_event_metadata {
> >         __u8 reserved;
> >         __u16 metadata_len;
> >         __aligned_u64 mask;
> > -       __s32 fd;
> > +       union {
> > +               __s32 fd;
> > +               __s32 id; /* FAN_REPORT_RESPONSE_ID */
> > +       }
> >         __s32 pid;
> >  };
> >
> > @@ -228,7 +232,10 @@ struct fanotify_event_info_mnt {
> >  #define FAN_RESPONSE_INFO_AUDIT_RULE   1
> >
> >  struct fanotify_response {
> > -       __s32 fd;
> > +       union {
> > +               __s32 fd;
> > +               __s32 id; /* FAN_REPORT_RESPONSE_ID */
> > +       }
> >         __u32 response;
> >  };
> >
> > And to add a check like this:
> >
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1583,6 +1583,16 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int,
> > flags, unsigned int, event_f_flags)
> >             (class | fid_mode) !=3D FAN_CLASS_PRE_CONTENT_FID)
> >                 return -EINVAL;
> >
> > +       /*
> > +        * With group that reports fid info and allows only pre-content=
 events,
> > +        * user may request to get a response id instead of event->fd.
> > +        * FAN_REPORT_FD_ERROR does not make sense in this case.
> > +        */
> > +       if ((flags & FAN_REPORT_RESPONSE_ID) &&
> > +           ((flag & FAN_REPORT_FD_ERROR) ||
> > +            !fid_mode || class !=3D FAN_CLASS_PRE_CONTENT_FID))
> > +               return -EINVAL;
> > +
> >
> >
> > This new group mode is safe, because:
> > 1. event->fd is redundant to target fid
> > 2. other group priorities allow mixing async events in the same group
> >     async event can have negative event->fd which signifies an error
> >     to open event->fd
>
> I'm not sure I follow here. I'd expect:
>
>         if ((flags & FAN_REPORT_RESPONSE_ID) && !fid_mode)
>                 return -EINVAL;
>
> I.e., if you ask for event ids, we don't return fds at all so you better
> had FID enabled to see where the event happened. And then there's no need
> for FAN_CLASS_PRE_CONTENT_FID at all. Yes, you cannot mix async fanotify
> events with fd with permission events using event id but is that a sane
> combination? What case do you have in mind that justifies this
> complication?

Not sure what complication you are referring to.
Maybe this would have been more clear:

+       if ((flags & FAN_REPORT_RESPONSE_ID) && (!fid_mode ||
+           ((flag & FAN_REPORT_FD_ERROR) || class =3D=3D FAN_CLASS_NOTIFY)=
)
+               return -EINVAL;
+

Yes, !fid_mode is the more important check.
The checks in the second line are because the combination of
FAN_REPORT_RESPONSE_ID with those other flags does not make sense.

FAN_CLASS_NOTIFY does not support permission events
and when not reporting event->fd reporting FD_ERROR does not make sense.
My intention is to reduce the test matrix for flag combinations that
do not make sense.

Thanks,
Amir.

