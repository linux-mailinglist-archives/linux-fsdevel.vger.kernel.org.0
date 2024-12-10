Return-Path: <linux-fsdevel+bounces-36953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1400E9EB5B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EE6162D40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88651BD004;
	Tue, 10 Dec 2024 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WEmAl+CK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30A1C1F05
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847104; cv=none; b=kmwar2uTtHv+ddEPfEe/D1PgbCAPn6vAaNbXNFA1+lNmtJfPM4I3LQ+wv39p2ghq/VaOTVVs+/sevJ3GzH/OSXpLowfoKaBTYoyng2bshuk6xexrt8g7fgx+kHaetbpDjpYbqHNCr8j9UlRltdXT/jjF58myyAnvjobX4O7q4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847104; c=relaxed/simple;
	bh=im9HiMXbXuLIdzitU/w+2CgufLy214/NVR1dppOsUY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iICGPNaeUBj8ZTX5yXNAJVRRmSZGavCKn8DxRIIynnewqs5CnG+Iq37Tou/AGaa2BTn4XbMRmljk4w1Hc0GWDQQeYcZsnDfGJ8s4dE0dFxoCalAYA4vszPhHWxgwnlycKpIcTHayhtdYYwDv89HTGzvdG42xecZsNHiQ4diNkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WEmAl+CK; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4676b7ee622so6293561cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 08:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1733847101; x=1734451901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=40iwNu3LKGQkZlhn/x3rrt1L9zj2Mvb702buqTcDKLQ=;
        b=WEmAl+CKKGgrovnRFzX/PMZBNjxukiyNEJgFsAC+RrsZJ7SGjizjrNFZghCQrL5Dy/
         Ylb4O/yQMogrIFwJCJGLPZQ8rW+Xgq4b1HzFLFpq3wbLRR1EpiOODxSa9QeWcvciLATS
         AMA1n8fC6uPodfou7/ncrU+sPZOEIwyhIhVQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847101; x=1734451901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40iwNu3LKGQkZlhn/x3rrt1L9zj2Mvb702buqTcDKLQ=;
        b=k0hz3aeXH/qCJq3trylBKBI93ReiJ8CGYzrN61FErn4NWoT96qQTkefGPS9bKTXjMN
         KUBzsAFXaWQ+515CF1KC6k+r/H20DlNySW5E4rztFXcCo/V7kkTpyKwLCDi38pgJu0og
         z3VfNaw0PB6p1ogFid3fVMTucj7cMstJm8hIkQv7qfft6EC63Zf5pq58/w4vHJzIDzQg
         78x+pEiuA3Od4wD6IAlo4CbPQnjnT6Hu+QIcp9zFNb5tHktrMvxeJmpddZvFxtEXbM26
         tQcpN4LWlWePH2BEBaAcFGGdMULQQLdWiJ247IW3oSCrsXOQ/CLnNohZXfG00JxnxZRL
         WXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY7+2wPIK8yPrt3O6nKsWWAAM6aDpx5Szmol/90I8v0r60CzeBODR1NYW6Kob/ZJ0j1FaYN4E+uv+zu/dV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7rEjNMxD/iZ0m/GsdvqErXxd3e/GzwHqYr6kx0remsbzo4V1
	yMxuEJWK81tZS6XqdQO8L2cm30KqxnbUNKkWL5ZfP+gGkOsaEhxTEdKjFP7siyOlUqDzxQX4M4+
	Figz8SDnCEovTrgrYJWtIWg4Dg3b8q3NZ2bgQbA==
X-Gm-Gg: ASbGnctvcOaQ7XIEjfblct28+wwSg/LgJAEEKylatAWQh2Af896wInCnjV2zdu4ZHoL
	/dMWtwZdGBhRECQd0AponU0VB/Y8+xvA92Qg=
X-Google-Smtp-Source: AGHT+IFufYUTDpuDOKFyRUwWyXFYaisnvcHAY7xene1Qq7KnGGmIkisIH4QPEGG4FDtRg/+iVBNOPReOPj7mbOf7umA=
X-Received: by 2002:ac8:7f42:0:b0:466:957c:ab22 with SMTP id
 d75a77b69052e-46771feb82emr88532201cf.43.1733847101146; Tue, 10 Dec 2024
 08:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206151154.60538-1-mszeredi@redhat.com> <CAOQ4uxhG9h6vBEyw9tZ0bMygZO=3VH5FmvxffRaLNUAyH9UYaw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhG9h6vBEyw9tZ0bMygZO=3VH5FmvxffRaLNUAyH9UYaw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 10 Dec 2024 17:11:30 +0100
Message-ID: <CAJfpeguakUSVP=zbv6=Nbp75QF8Hthv=bNk3SRLdAGqAQB8Y3w@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 19:29, Amir Goldstein <amir73il@gmail.com> wrote:

> Because with fanotify the event mask is used both as a filter for subscribe
> and as a filter to the reported event->mask, so with your current patch
> a user watching only FAN_MNT_DETACH, will get a FAN_MNT_DETACH
> event on mount move. Is that the intention?

I imagine there's a case for watching a single mount and seeing if it
goes away.   In that case it's irrelevant whether the mount got moved
away or it was destroyed.

> Is there even a use case for watching only attach or only detach?

I'm not sure, there could well be.

> Are we ever likely to add more mount events besides attach/detach?

Yes, modification (i.e. flag/propagation/etc changes).  And that one
could really make sense on a per-mount basis instead of per-ns.

> If the answers are no and no, then I think we should consider forcing
> to set and clear the mount events together.
>
> There are more simplifications that follow if we make that decision...

To me it looks like this would be a very minor simplification and the
main purpose would be to avoid confusing the user, right?

In that case maybe documenting the behavior would be preferable to
adding constraints.

> > +#ifdef CONFIG_FSNOTIFY
> > +       __u32                   n_fsnotify_mask;
>
> There is no point in this "optimization" mask if all the mntns
> marks are interested in all the two possible mount events.
> The "optimization" would not have been needed even if we would allow watching
> only attach or detach, but I guess this helps keeping the code generic...

I just did a mindless copy of other watchable objects.  Let's keep
this for now, then we'll see later if removing it is a simplification
or not.

> > @@ -303,17 +305,19 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> >         pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
> >                  __func__, iter_info->report_mask, event_mask, data, data_type);
> >
> > -       if (!fid_mode) {
> > -               /* Do we have path to open a file descriptor? */
> > -               if (!path)
> > -                       return 0;
> > -               /* Path type events are only relevant for files and dirs */
> > -               if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
> > -                       return 0;
> > -       } else if (!(fid_mode & FAN_REPORT_FID)) {
> > -               /* Do we have a directory inode to report? */
> > -               if (!dir && !ondir)
> > -                       return 0;
> > +       if (data_type != FSNOTIFY_EVENT_MNT) {
>
> Until we allow mixing other mark type (e.g. ignore mount mark for
> specific mount)
> and if we mandate watching both mount events, then all the logic below
> is irrelevant
> and if (data_type == FSNOTIFY_EVENT_MNT) can always
>      return FANOTIFY_MOUNT_EVENTS;

Hmm, but there's no hurt in keeping the logic, right?

> > +       /* FIXME: is this the proper way to check if fsnotify_init() ran? */
> > +       if (!fsnotify_mark_connector_cachep)
> > +               return;
>
> checking if (ns->n_fsnotify_marks) is easier.
> marks cannot be added before boot completed and user requested to add marks.

Yeah, okay.

> mount events are not reported with event->fd.
> The condition that uses FANOTIFY_FD_EVENTS needs to be fixed
> to accommodate the case of mount events.
>
>
>         if (mask &
> ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&

Okay.

Thanks,
Miklos

