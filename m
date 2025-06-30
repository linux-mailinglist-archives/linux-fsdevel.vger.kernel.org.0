Return-Path: <linux-fsdevel+bounces-53375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA5AEE320
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F593BEBD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6623528F92F;
	Mon, 30 Jun 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMIlXEl6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9F28DF20
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298979; cv=none; b=b2ogt3w7a6I4SO882qm5cD91whwO9dBEnWjz0k5tBeXcVMH5n8vdtQej5NmDW9VeZmO5sJc18FXD/n5wjuDM6ZY/8uKeQiTzY81ZglZyMpdIbg6VfTkDVZ/4fyaWXiiuTlZHLzz11rs2cEA78f773XgswBSTphwApO5hDvGQaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298979; c=relaxed/simple;
	bh=7/HaHvxpxOsaRBI6Zg7PrrOZNoRXxeIzZdkFJVc+aZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfO80H7LSSLIJCn/0NT1svM5SD7qBET7At6HrGZsm8Ocr7H4xHi6MPOTrBsn0JKlAFoEWwbtSVM9oarIZYmDw7Pm9nIMLN/jKEsIAiTg1O7x1QXDethxyk7+py5eupVTvF+BX+JaRX/7DGySGh/ZbVNODAmaCIjmdxuhlOqa2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMIlXEl6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ade76b8356cso465436366b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751298974; x=1751903774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd1meAS3f7Tl/yfZtgmntKCdnNIlUSTglh71M1WG89g=;
        b=QMIlXEl62AKdvWExxbsHJEsmeVTbzw2QyDqk+w3tCH3ciNtKnhqe5bvC5GD9mHfYYG
         57ne/4vvtVu1eEhnUGAG0vFj0VhC3c+PKdyk8IZU7+v/X/ZNA7hhFSqHgsJWnN9gSIVB
         Hrp9OvQW3TLItGVfYy5GClJFmO27fL+LNs0fGOOw9PUTgov55ZRPXLXaIKEgmeYae5yj
         Z2couez21Qf0q1jQn2gaMrnNmiojV7dcCDRgShw1Ax4aDVzmg7RbVV+wX+CMBWDfTUv7
         6Burrt5AAdFTZalKF0IxgB/9D1fuFeDX5PUoW3yhSglEDqBRKxurB0j17hDb2aXRC8T0
         jYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751298974; x=1751903774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rd1meAS3f7Tl/yfZtgmntKCdnNIlUSTglh71M1WG89g=;
        b=tcjYGGUwdmL4tvl5U6IoPPM/KuP6GHoCKrwTAOYVGD1nZUn8bHsGTFvNQzQZ21tEiV
         kuVNrlaCJcw2C4YFMT7om2+HYbMlLlwmZNEFRhXvDM4IRlz97uTnUCtXorgqumIPxA25
         HkoO7t+Si8Je9LNMFbxq8kt21SMv39m6RHV/JEgx525hEKn2vRakyS156G4w9zPb9jeP
         2ggvk78pWcneCxxLtnZXFkWXccbizl0fNVNAEGtkDFqbQFzQPwiYaEaL2cagp2iNfP02
         MP/UbiqjCqCv5OXQO78mJFgwITuQMVcXibfmsFMUR5lZ/qwf5vZ7TVZ3JVpTcMaBEeUB
         4vKw==
X-Forwarded-Encrypted: i=1; AJvYcCURR2S8qx00xlBeVU77vnYzBrXY672i4N5Sj7ek8+wv5WpjiV6QpFXd0RwtyLYklhcxG6thDvw1moQHkqkb@vger.kernel.org
X-Gm-Message-State: AOJu0YzznEVhI1/iLd3iLMClJNLC8zfrRh7GbXIEjNf3oI4UsjOuPOsV
	wvNEY2B2V+culujV+jASxPy+csJBkg6IGAl1tb2kLa4PZ7Qum7OMRNnajFa00Z2DWLbxpVCb/on
	X8HTxfLYkfqT6jv/XCtqwWkXg9yGe/4I=
X-Gm-Gg: ASbGncu3e7XJbrr6wz6HMUyFfFjtpUzgv5PN69rbm2rqU/WyXbiR7ZSONO6kj2yBhV/
	XNkbm1fbG+GEhxQ10ejE/ogjfISjQ99feHmoiT4prk2AxMA8kV5HNcue/fz6zrTE+XhVaQnMLPF
	pd2uzEJINBuoLGGWV57pNQPQewbyL05HRULkuGDvlVaFc=
X-Google-Smtp-Source: AGHT+IGL/Pp9kVQut9Ye96X/8bCh9IVDiP6mTpYcSxdUBxI2X0o0M+OMB0OVEANMD/jMZQV0NpXv8N3gldSRWLeXZyo=
X-Received: by 2002:a17:907:f1cc:b0:ad8:9a86:cf52 with SMTP id
 a640c23a62f3a-ae34fd336camr1202598266b.11.1751298973673; Mon, 30 Jun 2025
 08:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623192503.2673076-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxguBgMuUZqs0bT_cDyEX6465YkQkUHFPFE4tndys-y2Wg@mail.gmail.com> <tq6g6bkzojggcwu3bxkj57ongbvyynykylrtmlphqa7g7wb6f2@7gid5uogbfc4>
In-Reply-To: <tq6g6bkzojggcwu3bxkj57ongbvyynykylrtmlphqa7g7wb6f2@7gid5uogbfc4>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 30 Jun 2025 17:56:00 +0200
X-Gm-Features: Ac12FXykXdlWaHLWg78IEkScbZ83OpFRLpm7LM5q1zzrCNtDFLOZ2HkNsuFNAEU
Message-ID: <CAOQ4uxirFm8_U7z4ke5Z4iNbatSbXoz1YK_2eGL=1JQQOtt75Q@mail.gmail.com>
Subject: Re: [PATCH] fanotify: support custom default close response
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 5:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 24-06-25 08:30:03, Amir Goldstein wrote:
> > On Mon, Jun 23, 2025 at 9:26=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@m=
eta.com> wrote:
> > >
> > > Currently the default response for pending events is FAN_ALLOW.
> > > This makes default close response configurable. The main goal
> > > of these changes would be to provide better handling for pending
> > > events for lazy file loading use cases which may back fanotify
> > > events by a long-lived daemon. For earlier discussion see:
> > > https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6b=
i44canfsg2aajgkialt@c3ujlrjzkppr/
> >
> > These lore links are typically placed at the commit message tail block
> > if related to a suggestion you would typically use:
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxi6PvAcT1vL0d0e+7Yjvk=
fU-kwFVVMAN-tc-FKXe1wtSg@mail.gmail.com/
> > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> >
> > This way reviewers whose response is "what a terrible idea!" can
> > point their arrows at me instead of you ;)
> >
> > Note that this is a more accurate link to the message where the default
> > response API was proposed, so readers won't need to sift through
> > this long thread to find the reference.
>
> I've reread that thread to remember how this is supposed to be used. Afte=
r
> thinking about it now maybe we could just modify how pending fanotify
> events behave in case of group destruction? Instead of setting FAN_ALLOW =
in
> fanotify_release() we'd set a special event state that will make fanotify
> group iteration code bubble up back to fsnotify() and restart the event
> generation loop there?
>
> In the usual case this would behave the same way as setting FAN_ALLOW (ju=
st
> in case of multiple permission event watchers some will get the event two
> times which shouldn't matter). In case of careful design with fd store
> etc., the daemon can setup the new notification group as needed and then
> close the fd from the old notification group at which point it would
> receive all the pending events in the new group. I can even see us adding
> ioctl to the fanotify group which when called will result in the same
> behavior (i.e., all pending permission events will get the "retry"
> response). That way the new daemon could just take the old fd from the fd
> store and call this ioctl to receive all the pending events again.
>
> No need for the new default response. We probably need to provide a group
> feature flag for this so that userspace can safely query kernel support f=
or
> this behavior but otherwise even that wouldn't be really needed.
>
> What do you guys think?

With proper handover I am not sure why this is needed, because:
- new group gets fd from store and signals old group
- old group does not take any new event, completes in-flight events,
  signals back new group and exists
- new group starts processing events
- so why do we need a complex mechanism in kernel to do what can easily
  be done in usersapce?

Also, regardless I think that we need the default response, because:
- groups starts, set default response to DENY and handsover fd to store
- if group crashes unexpectedly, access to all files is denied, which is
  exactly what we needed to do with the "moderated" mount
- it is similar to access to FUSE mount when server is down

For a requirement that non-populated content MUST NOT be
accessed, the default response is a very easy way to achieve it.

Thanks,
Amir.





>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

