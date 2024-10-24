Return-Path: <linux-fsdevel+bounces-32788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4D49AEC8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 18:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6163A1F24730
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F451F76B5;
	Thu, 24 Oct 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDWlQ2ve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749B1F5855
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788557; cv=none; b=cGJC7Ue9Ca2MnS6kpDTw/nMIyo2JCU9HFfyYUWwC/nFKUz4buhKB/eGzVksSta8soiMcKQnCLKH1zthF50HY39F2GVq+VTARxixIamV+VBdxqt/yeruG6geTn95uo7OM50uj3I/jzPFEPcqHWKmB8DdHMokhDfuhpxsYA3DDLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788557; c=relaxed/simple;
	bh=OItVh8NM0dkEoQHpZiqpS5jB0QXriC2xXIC1xb4BKnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bka9kVD49BtNsOX91lXZN3LoAIniXaKzX8pcI9581BnZAr/e26eyG7nbD1D8L9uJujSAagE4OfyW/RH9YcH23yu7rNcgcUdP8Yh0ZyrH34eWhla0h5FQDCl99GzTDfID5RfwEcczWGExNZlJGMufDVbEZ+UJo23vsFOykTwrrmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDWlQ2ve; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460c2418e37so7341131cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788554; x=1730393354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YphvsfPfBoZbRlntZJZa3Npql4N7LYomilITzMbM1Aw=;
        b=dDWlQ2vejaKHrTY+vLJboKshDRvkPFPW9jCjW4XwExtQQv5o5eJINyuJece5W6t9eZ
         95Yw38l1UOBBL1bMpUWzfImF+XQNNLTI7KdcU8jBR/MISdwNjm8X00Fu+SEqg8NP/OnN
         uI3RifwTmdihG9cUSlZZIp6pI/j+kv+j2K6JM1SKYwic2QYj630mBZ4WH8zqeAcCFb6a
         DgH+fai6/Sk/yxxuQc/B7S+/DN9eGAq9TD6P5gBwpYTcOMpY8el7uhzR6ht97JKxhfdV
         LJHFgWM5/+6PFGADAStx+Qn57+mo1GnzanmPvDaBfGIx8gIzUFvCOK3M44obx4ECGyuk
         FM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788554; x=1730393354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YphvsfPfBoZbRlntZJZa3Npql4N7LYomilITzMbM1Aw=;
        b=PFiUimWzYILSvbI99gS92ehj7oMpHEUBpJAfVuFxTNGvZ8s5cj1Br8Z/R7k8bd2l//
         syDrWGyOguDeDcVun33C+mOBoD8YSz6iDqlkrbwm2WTuHWbdH4gxxoR75gJ/IOS3TP0H
         8G+i1Qu4VkeiI7xj7kOwtO80fizvrvmH9zp+2NZs+ZuWfVYs63H3qUd+mKRWuIyXe/Ga
         T8jNA/oqnDdrGsB0WEFcDyTNN9kC+F2xpKu2rjgr3R64SIduH7o2+tcul9V7gtW9CQmR
         6NXUvR+8dh2r3lyjG08qzqbmb2f4hHegkos5vKf1yaxdYkzUrToqQVubs8lD6JkTIiI/
         FyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDODHVGzXf6qm28EA2wiehTLDYjgwWWcwwP6cGRw+UkiCzAg3RstjC6D0ZbR6Umoi61rz4YMt045kXrVbQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoj54fmnRSe7sgqMhtHATqb0TIH8PU6uF6yhlARrr+swHotnJt
	xit+Sq3JsZ/FEzn+39LXyOA2/Y3PsOccMN/nQ3xvrw501JdjPfj9rQ4B+QNnTh+hfjxzEyV9l5m
	B7YKM5gL2y6jAP0uLuI3a1sgMkwU=
X-Google-Smtp-Source: AGHT+IFiU+Kb5u9gLbT52+vTFr0tZaQUxE9R3+l+kzkKawbiS1+I91C22ZCRJmV+v46UtFqzAOEZcygzIC7cWjAvM8s=
X-Received: by 2002:ac8:7c4e:0:b0:458:2622:808a with SMTP id
 d75a77b69052e-461145c02ffmr84090311cf.20.1729788553489; Thu, 24 Oct 2024
 09:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <1a378ca2df2ce30e5aecf7145223906a427d9037.1721931241.git.josef@toxicpanda.com>
 <20240801173831.5uzwvhzdqro3om3q@quack3> <CAOQ4uxg-yjHnDfBnu4ZVGnzA8k2UpFr+3aTLDPa6kSXBxxJ6=w@mail.gmail.com>
 <20241024163508.qlwxu65lgft5q3po@quack3>
In-Reply-To: <20241024163508.qlwxu65lgft5q3po@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 24 Oct 2024 18:49:02 +0200
Message-ID: <CAOQ4uxgf0M2oE1kpZSw+tWv72tp55yHh385vr1D0VAeO1f-yAg@mail.gmail.com>
Subject: Re: [PATCH 08/10] fanotify: report file range info with pre-content events
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 6:35=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 24-10-24 12:06:35, Amir Goldstein wrote:
> > On Thu, Aug 1, 2024 at 7:38=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Thu 25-07-24 14:19:45, Josef Bacik wrote:
> > > > From: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > With group class FAN_CLASS_PRE_CONTENT, report offset and length in=
fo
> > > > along with FAN_PRE_ACCESS and FAN_PRE_MODIFY permission events.
> > > >
> > > > This information is meant to be used by hierarchical storage manage=
rs
> > > > that want to fill partial content of files on first access to range=
.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/notify/fanotify/fanotify.h      |  8 +++++++
> > > >  fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++=
++++
> > > >  include/uapi/linux/fanotify.h      |  7 ++++++
> > > >  3 files changed, 53 insertions(+)
> > > >
> > > > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fan=
otify.h
> > > > index 93598b7d5952..7f06355afa1f 100644
> > > > --- a/fs/notify/fanotify/fanotify.h
> > > > +++ b/fs/notify/fanotify/fanotify.h
> > > > @@ -448,6 +448,14 @@ static inline bool fanotify_is_perm_event(u32 =
mask)
> > > >               mask & FANOTIFY_PERM_EVENTS;
> > > >  }
> > > >
> > > > +static inline bool fanotify_event_has_access_range(struct fanotify=
_event *event)
> > > > +{
> > > > +     if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
> > > > +             return false;
> > > > +
> > > > +     return FANOTIFY_PERM(event)->ppos;
> > > > +}
> > >
> > > Now I'm a bit confused. Can we have legally NULL ppos for an event fr=
om
> > > FANOTIFY_PRE_CONTENT_EVENTS?
> > >
> >
> > Sorry for the very late reply...
> >
> > The short answer is that NULL FANOTIFY_PERM(event)->ppos
> > simply means that fanotify_alloc_perm_event() was called with NULL
> > range, which is the very common case of legacy permission events.
> >
> > The long answer is a bit convoluted, so bare with me.
> > The long answer is to the question whether fsnotify_file_range() can
> > be called with a NULL ppos.
> >
> > This shouldn't be possible AFAIK for regular files and directories,
> > unless some fs that is marked with FS_ALLOW_HSM opens a regular
> > file with FMODE_STREAM, which should not be happening IMO,
> > but then the assertion belongs inside fsnotify_file_range().
> >
> > However, there was another way to get NULL ppos before I added the patc=
h
> > "fsnotify: generate pre-content permission event on open"
> >
> > Which made this "half intentional" change:
> >  static inline int fsnotify_file_perm(struct file *file, int perm_mask)
> >  {
> > -       return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
> > +       return fsnotify_file_area_perm(file, perm_mask, &file->f_pos, 0=
);
> >  }
> >
> > In order to implement:
> > "The event will have a range info of (0..0) to provide an opportunity
> >  to fill the entire file content on open."
> >
> > The problem is that do_open() was not the only caller of fsnotify_file_=
perm().
> > There is another call from iterate_dir() and the change above causes
> > FS_PRE_ACCESS events on readdir to report the directory f_pos -
> > Do we want that? I think we do, but HSM should be able to tell the
> > difference between opendir() and readdir(), because my HSM only
> > wants to fill dir content on the latter.
>
> Well, I'm not so sure we want to report fpos on opendir / readdir(). For
> directories fpos is an opaque cookie that is filesystem dependent and you
> are not even allowed to carry it from open to open. It is valid only with=
in
> that one open-close session if I remember right. So userspace HSM cannot =
do
> much with it and in my opinion reporting it to userspace is a recipe for
> abuse...
>
> I'm undecided whether we want to allow pre-access events without range or
> enforce 0-0 range. I don't think there's a big practical difference.
>

So there is a practical difference.
My HSM wants to fill dir content on readdir() and not on opendir().
Other HSMs may want to fill dir content on opendir().
It could do that if opendir() (as does open()) reports range [0..0]
and readdir() reports no range.

I agree that it is somewhat ugly. I am willing to take other semantics
as long as HSM can tell the difference between opendir() and readdir().

Thanks,
Amir.

