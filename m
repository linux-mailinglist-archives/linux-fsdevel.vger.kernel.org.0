Return-Path: <linux-fsdevel+bounces-10502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27CC84BB21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2521F2637A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F76134C6;
	Tue,  6 Feb 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcM0Morf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F795134BD
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237349; cv=none; b=YQyky1jB6TiuYRdLgS4g0P1pKO5NyO2eVPlKZRmkZ7gOWOpyPnY4riIftjXv0OZ3zQrCk3nppP8ud0iBQ7rA8BIQa5jMsx6Wdv0h1S+Co0nyahEahB3xpMlTfNOg9Bm4CRQByh+x26Yl8RCS2PxX0D9zygU7DboNC2ubuO6lMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237349; c=relaxed/simple;
	bh=TayipBZk+J0C/2i4VnPTBZ7ZdNgABfJvQWSL4hX+Fhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI0adWlEQtN5ZmYaol+ZUxY3GKsRFvq57Ep6eVunhNYZf7J+baUoO7KDsX+63oW/Lw6RRIEP0ygNLOHxYRew0O3xG+hqwduFGYcvUPhJcqZaeStyc24FIi+0W8kb6U5BimJSpcM7n/qzWKWaKK/rUGetGXi/nExZ/XaymODE7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcM0Morf; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6818a9fe380so32857296d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 08:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707237346; x=1707842146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TayipBZk+J0C/2i4VnPTBZ7ZdNgABfJvQWSL4hX+Fhw=;
        b=QcM0Morf4Un1zjkVXg46g1LRAfhNy1TvrEVWpYuAdmHd08ehm+Ws8dNsHLSVj20eGo
         MvtfcLOpHXBqOW9x897TqHkrkLWmR3j+ajWdvObi4Il3uHBwBUCx/5rj/5reN8iZrCut
         2SiKIr4Jn0g+3O9m0NqadTF+oelKanufGEtPUlL3iAYg2LAv/PAGrZk7AKNuRX0LUnGh
         UlIn9Aa5FthZdte5Rz40pXOfPeiBRPz0eWQ8F3UzGQ2qe0iqeeGSsSuyPXr19CaKGsaP
         wu0+Zc/pxEbFObN7wN0E4pVfRXbQHCzgZV6oAs0e7rNsSwzs+oVQZI7p5B48ZayBcaXZ
         8emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237346; x=1707842146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TayipBZk+J0C/2i4VnPTBZ7ZdNgABfJvQWSL4hX+Fhw=;
        b=TAMleqtKqoUgmfiOm6+TwM03tuy/+aYwhxhLi+x5LhfLH6jGTg5HGwhVCtMZWv5rZw
         2kSbiULrdbm88PMSgNCJvRwhHtwIg0ja1UsULIk3EVvV7hb5L6k+s9NgMifjqvEeC34w
         edlu2+FnqhFqyv26js0AVb8d/dyUTBdhlDxWbpZlOCiLiMsSD2HAt3mmcNhfDHiGY1BO
         x9R9/cq7bg/HDzD8QEZq1NgYnc72l/LlIPZLgpjb9fDX3MkwSxqvWNbvFK0lTq7iv+HM
         9FbPai8PdsWPE9PDML+PctVwDWqobAxnmv7yLmPAXcvCA+wFmJlWLmgTc/tjbm1FcCpU
         MrdA==
X-Gm-Message-State: AOJu0YxJpSsPPk70OjmuM8qM7dnLmDQGwhAvpyXD9UN2mJ95cpeS/ySh
	dNk9tAYsVVAuN6hd+tvK/cMBqoi5XIzdAnS+qADMwIJI2tYKpjEKZcWGWQwE+ezv30L9+hg4cfz
	j5w1FF4Z7+8Hc2LF5NFU8kbXq77zjDrzVxlU=
X-Google-Smtp-Source: AGHT+IEJvQI5eM62+4KayqC7qn7MigLmuI6VFlajOF5vpJS9iP1HuVdLkcQwKuoV38bysZA2iPwYy80B2ifApd1zUbk=
X-Received: by 2002:a05:6214:1bcc:b0:68c:7f6f:2c6 with SMTP id
 m12-20020a0562141bcc00b0068c7f6f02c6mr3116113qvc.36.1707237346260; Tue, 06
 Feb 2024 08:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208080135.4089880-1-amir73il@gmail.com> <20231213172844.ygjbkyl6i4gj52lt@quack3>
 <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>
 <20231215153108.GC683314@perftesting> <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
 <20231218143504.abj3h6vxtwlwsozx@quack3> <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
 <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com> <20240205182718.lvtgfsxcd6htbqyy@quack3>
In-Reply-To: <20240205182718.lvtgfsxcd6htbqyy@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 18:35:34 +0200
Message-ID: <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
	Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:27=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> I'm sorry for the delay. The last week was busy and this fell through the
> cracks.
>

No worries, I was busy as well.
I did already rebase fan_pre_content & fan_errno [1] (over v6.8-rc2)
last week, made the small changes I mention here and ran some
basic tests, but did not complete writing tests.
Hoping to switch back to it this week.

[1] https://github.com/amir73il/linux/commits/fan_errno

> On Mon 29-01-24 20:30:34, Amir Goldstein wrote:
> > On Mon, Dec 18, 2023 at 5:53=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > > In the HttpDirFS HSM demo, I used FAN_OPEN_PERM on a mount mark
> > > to deny open of file during the short time that it's content is being
> > > punched out [1].
> > > It is quite complicated to explain, but I only used it for denying ac=
cess,
> > > not to fill content and not to write anything to filesystem.
> > > It's worth noting that returning EBUSY in that case would be more mea=
ningful
> > > to users.
> > >
> > > That's one case in favor of allowing FAN_DENY_ERRNO for FAN_OPEN_PERM=
,
> > > but mainly I do not have a proof that people will not need it.
> > >
> > > OTOH, I am a bit concerned that this will encourage developer to use
> > > FAN_OPEN_PERM as a trigger to filling file content and then we are ba=
ck to
> > > deadlock risk zone.
> > >
> > > Not sure which way to go.
> > >
> > > Anyway, I think we agree that there is no reason to merge FAN_DENY_ER=
RNO
> > > before FAN_PRE_* events, so we can continue this discussion later whe=
n
> > > I post FAN_PRE_* patches - not for this cycle.
> >
> > I started to prepare the pre-content events patches for posting and got=
 back
> > to this one as well.
> >
> > Since we had this discussion I have learned of another use case that
> > requires filling file content in FAN_OPEN_PERM hook, FAN_OPEN_EXEC_PERM
> > to be exact.
> >
> > The reason is that unless an executable content is filled at execve() t=
ime,
> > there is no other opportunity to fill its content without getting -ETXT=
BSY.
>
> Yes, I've been scratching my head over this usecase for a few days. I was
> thinking whether we could somehow fill in executable (and executed) files=
 on
> access but it all seemed too hacky so I agree that we probably have to fi=
ll
> them in on open.
>

Normally, I think there will not be a really huge executable(?)
If there were huge executables, they would have likely been broken down
into smaller loadable libraries which should allow more granular
content filling,
but I guess there will always be worst case exceptions.

> > So to keep things more flexible, I decided to add -ETXTBSY to the
> > allowed errors with FAN_DENY_ERRNO() and to decided to allow
> > FAN_DENY_ERRNO() with all permission events.
> >
> > To keep FAN_DENY_ERRNO() a bit more focused on HSM, I have
> > added a limitation that FAN_DENY_ERRNO() is allowed only for
> > FAN_CLASS_PRE_CONTENT groups.
>
> I have no problem with adding -ETXTBSY to the set of allowed errors. That
> makes sense. Adding FAN_DENY_ERRNO() to all permission events in
> FAN_CLASS_PRE_CONTENT groups - OK,

done that.

I am still not very happy about FAN_OPEN_PERM being part of HSM
event family when I know that O_TRUCT and O_CREAT call this hook
with sb writers held.

The irony, is that there is no chance that O_TRUNC will require filling
content, same if the file is actually being created by O_CREAT, so the
cases where sb writers is actually needed and the case where content
filling is needed do not overlap, but I cannot figure out how to get those
cases out of the HSM risk zone. Ideas?

> if we don't find anything better - I
> wanted to hash out another possibility here: Currently all permission
> events (and thus also the events we plan to use for HSM AFAIU) are using
> 'fd' to identify file where the event happened. This is used as identifie=
r
> for response, can be used to fill in file contents for HSM but it also
> causes issues such as the problem with exec(2) occasionally failing if th=
is
> fd happens to get closed only after exec(2) gets to checking
> deny_write_access(). So what if we implemented events needed for HSM as F=
ID
> events (we'd have think how to match replies to events)? Then the app wou=
ld
> open the file for filling in using FID as well as it would naturally clos=
e
> the handle before replying so problems with exec(2) would not arise. Thes=
e

The two things are independent IMO.
We can use an event->key instead of event->fd, which I like,
but we may still leave event->fd as a way to get an FMODE_NONOTIFY
fd as long as the user closes event->fd before responding or we can
implement Sargun's suggestion of the FAN_CLOSE_FD response flag.

If a user needs to open an FMODE_NONOTIFY fd from fid, we will
need to provide a way to do that.
My WIP pre-lookup event patches [2] implements inheritance of
FMODE_NONOTIFY from dirfd used for openat().
Perhaps we can do the same for open_by_handle_at() and inherit
FMODE_NONOTIFY from mount_fd to implement your suggestion?

[2] https://github.com/amir73il/linux/commits/fan_lookup_perm

> would be essentially new events (so far we didn't allow permission events
> in FID groups) so allowing FAN_DENY_ERRNO() replies for them would be
> natural. Overall it would seem like a cleaner "clean room implementation"
> API?

I like the idea of a clean slate.

Looking a head, for the PRE_PATH events (e.g. lookup,create)
I was planning to use FAN_EVENT_INFO_TYPE_DFID_NAME
to carry the last component lookup name, but then also have
event->fd as the dirfd of lookup/create.

That's a bit ugly duplicity and also it does not cover rename(), because
if we use FAN_EVENT_INFO_TYPE_{OLD,NEW}_DFID_NAME
to report names, where would newdirfd, olddirfd be reported?

Your suggestion solves both these questions elegantly and
if you agree to adapting open_by_handle_at() to cater fanotify needs,
then we have a plan to propose.

The bad side of clean slate is that it reduces the chances of me
being able to get pre-content events ready in time for 6.9, which
is a shame, but we got to do what we got to do ;)

Thanks,
Amir.

