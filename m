Return-Path: <linux-fsdevel+bounces-37162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C18F9EE6FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2BA283344
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3F20ADC8;
	Thu, 12 Dec 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TlaK4lHX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3ED20A5D6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007523; cv=none; b=oLXdDVZS/Rs6HnAgeL7b0Ia+djzUw7Vs4Nfk+hvx1LBbpinfNx2IeJYHHDX18n+d6Ng699CkHPcLGX4L+ZhB8IV5a1Y4bCYXHgF5B2ad9fxQM0Bwm3YqNVmijc55PxII98lXOvkp6BQz+LvNJRGKsO+0Qo9shLavdYtatYYnqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007523; c=relaxed/simple;
	bh=wlo/POjQRnQiS2uENR8x8H1yKcsgLV9I/DX1yth+ckk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwsIcqIYbwoH/+RHGgy1gbraGgie0hOohiliUiu/ppYuy3Z0UAP2IKKV8jn1yFOueOtlVYO7wtA50Hf/Rk5bOlKZH+ERMbxR7/3ylV+A/iTCA6t1xysNs+kJX6k4vlvyJuBWxuglrjGPCH+ueWmGCTPNua9XB328Qt8qBnQixjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TlaK4lHX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4679d366adeso3121301cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 04:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1734007520; x=1734612320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOqgOns+9Th8/mCh+q6zNc++wgLFuxG4hucNbERK4hw=;
        b=TlaK4lHXCY0S3Hj5g8sPBm5LAsTOhDezQYDJALwjdweRYWcQmAiNdPIuZ6h9aLXEoC
         Ln/0nwgS+FF1EgACt5lQcVADKuuSeO2W08xwBKfwdp9sJ83Yn9MVgXePb5/HWBcJRxfB
         9lr9TiAQKv74/rg4IAKnjIRfjqGiVzYYqICoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007520; x=1734612320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOqgOns+9Th8/mCh+q6zNc++wgLFuxG4hucNbERK4hw=;
        b=jrSK8BqtKZSPLnjhsDRVcNEfPZh44C2yRfslVqzSP3FNu/zjw8YjhxZD1PfU7BWVIY
         lg4FAp5O7+sZEdLQJINNA2AXp3vJ/qxBek5buUbqw3tYyKmg9jd3JfabUW2DjQ3WxPz5
         Alx3MFYRnyaUnpvGVPRArWX8mIbvcKUlhMXiqI5Kp3URZDmu6Md7rLUDgFDS1GsYCMVx
         KdKKaXi/u4lA/EvvPUmwReHYbCfTQSImU7cbc/uk4zbcT2/vjyU81ByEvDjqvueKPAjZ
         ymbxf5Y8fNUZsrPdL2SbE41NT1O7/rnetBtKqZ+JU2p1uYrMCUjA0cIBfOEVCcAw/SCZ
         7YHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfSOJMNQrSq1EDS/s02v16pnSCWshJqGAtW7OHqv4kqFyqKCOF0WDJq7ic2radCXov0bmxzSTZHvOgWO+F@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMxW0CUhzltYdKLI04+fay4SZYCZoMz7EIrmGEa7PoDysqAZl
	QphjvQaTbTuQWjMoZxXUIY8tUpB1avSG9QpRaphs4wSQyPa8mb43s4fPlEDN5BRt+bk61Xomz/q
	5UKlX2aDMicyF5LCcXsvDqBeBjrokr3voajK/jg==
X-Gm-Gg: ASbGncuWKw7poOLcojFUgikhPJVpZikp2EnI4yPl8oUc/4ZAh6yCBMK8Id7MbyKsNy+
	SC4lGugUu7wHFhdkAjceLo0Jf/1Gfidn8ViOGiA==
X-Google-Smtp-Source: AGHT+IETYBrgkdxb7AmXv36RI29VfiRaQOddEqV1DjHbmID77E3xEDNYxKdztewDYmfo3ufvNoD80lfxEsCExE5bLEw=
X-Received: by 2002:a05:622a:106:b0:462:ea1d:9e2 with SMTP id
 d75a77b69052e-467a14cf96cmr2295451cf.16.1734007519836; Thu, 12 Dec 2024
 04:45:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211153709.149603-1-mszeredi@redhat.com> <20241212112707.6ueqp5fwgk64bry2@quack3>
In-Reply-To: <20241212112707.6ueqp5fwgk64bry2@quack3>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Dec 2024 13:45:09 +0100
Message-ID: <CAJfpeguN6bfPa1rBWHFcA4HhCCkHN_CatGB4cC-z6mKa_dckWA@mail.gmail.com>
Subject: Re: [PATCH v3] fanotify: notify on mount attach and detach
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 12:27, Jan Kara <jack@suse.cz> wrote:

> Why not:
>         if (p->prev_ns == p->mnt_ns) {
>                 fsnotify_mnt_move(p->mnt_ns, &p->mnt);
>                 return;
>         }

I don't really care, but I think this fails both as an optimization
(zero chance of actually making a difference) and as a readability
improvement.

> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 24c7c5df4998..a9dc004291bf 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -166,6 +166,8 @@ static bool fanotify_should_merge(struct fanotify_event *old,
> >       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> >               return fanotify_error_event_equal(FANOTIFY_EE(old),
> >                                                 FANOTIFY_EE(new));
> > +     case FANOTIFY_EVENT_TYPE_MNT:
> > +             return false;
>
> Perhaps instead of handling this in fanotify_should_merge(), we could
> modify fanotify_merge() directly to don't even try if the event is of type
> FANOTIFY_EVENT_TYPE_MNT? Similarly as we do it there for permission events.

Okay.

>
> > @@ -303,7 +305,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> >       pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
> >                __func__, iter_info->report_mask, event_mask, data, data_type);
> >
> > -     if (!fid_mode) {
> > +     if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> > +     {
>
> Unusual style here..

Yeah, fixed.

> Now if we expect these mount notification groups will not have more than
> these two events, then probably it isn't worth the hassle. If we expect
> more event types may eventually materialize, it may be worth it. What do
> people think?

I have a bad feeling about just overloading mask values.  How about
reserving a single mask bit for all mount events?  I.e.

#define FAN_MNT_ATTACH 0x00100001
#define FAN_MNT_DETACH 0x00100002
...

Thanks,
Miklos

