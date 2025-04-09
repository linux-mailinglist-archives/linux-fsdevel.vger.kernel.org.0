Return-Path: <linux-fsdevel+bounces-46080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9BDA824FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 14:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C07537B7A55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF1E25F98C;
	Wed,  9 Apr 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBqBr7RE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2022261597
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202191; cv=none; b=fd+XizkeQPQ2k4UrxYizvxp3DgBIFt9aAcX+qLZCAlcgurh9ViGxPdJ2PxsD1v0rF6WbTw9J3evxMS9Tr/NJUvowEJzJI5IB4bENm2vt25Erm7A/g7B0lXNzK6n9XdFPODuWO3v3n+eLlLX9X6vkndNcXjQybsROz0qjDt39Kms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202191; c=relaxed/simple;
	bh=zwUsPuA4z2eQ++rWeQ/gwmIxBB/3XGXiAKcivZYcsSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6Lab/jRIFnO4ahWlwv705wWnpCggOxhPivsOU11DQNlMnmE5SCEGsUf0rWgNAlpqKS6eH6C7QGUvYY+9NUkZOArYzqjwU7fSQkWxpOB7uqK8ozv1eONGXm/5UGnrBH/pd/0YLXCJPgTpDs5u1UuaZg7Pj7cetCcF2mtP99qZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBqBr7RE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso1159273866b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744202188; x=1744806988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhRIyQnOuYRhlIEPYYTgCi1WDtf1A0MJqDv0VeCT6Xg=;
        b=SBqBr7REDgS7BGyCuo1/g/jjYuax0iUe8LMrG1f2z2lninv5F7RV07g8oX7cvg4mUh
         SESOpvZppJhpCWmMohiNGwnyIjZq89mSZuZ1FKagqVk5BWOpyUXHSjMj+jUIkioB02tU
         Fxfn0lHwq/3R2JYzzdL4whl2BIQEcTrtF4421qmyTxAsm2ZmRxmNHKN1zTskhCQWwIVC
         7L51MDJ4C/qQsnnZ122ViX/tewVkm9l+wn+yBhi/OGQ+2RLikcer3ftM/HnpLY1qWN7Z
         nu/ZTc8K1l5QptpH260QISMVGxZp3iVeA1hwFmoHc/f5k2D0SAEUZD8DeBXHVhI7RxFd
         7sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744202188; x=1744806988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhRIyQnOuYRhlIEPYYTgCi1WDtf1A0MJqDv0VeCT6Xg=;
        b=guR14GERejyf3/TTL/8PeN3pwbe9FVC6ioEBqG8uOTC6qsA90uAQ1gVcGbGOY6vaSe
         t+TrNg/Z4sN6UPWLsRJdKa0X+W8j6bklFTPiRMTwANqlB1nTeCgHUXRKUSmNwolQ6RwP
         vT9fVuJTuRwMvGJYfoiRhiNhFyJQ7AjOo8NwbkgtXCABrCJcC/AyAxz//2hByN372WNy
         mDqDykbWP5RkyD9+wSyylzJIJ313m5JFGFsFS0iapPnB9h9rWkirSQLR3wcj2iKt4aUQ
         FJO9quYNXOtVD0lGo1ixkPVKlHFx9cQrijbhg68kP1pxK/QD6qcOlbeSOAw39TYmZ1pW
         71OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVapOOhQlF3n0FVBI99ugxM/PcudDuawQZEoS+6YTL1bMOOebh3XVo1m8wD58zq2E/+idy8JnOo82pkGR4Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjTXkaGsMw5wb6ZLvIW2hEDemHw8rUF1WYWqWn/+Qz2xFvlc6
	umSoSaBh9fSbf6v1/HUfazFNKP3NlT/YS70C1RvZMHWAAeibrXl3Ur7JDPm27yVCnoro+PTNDwh
	fZqyzEJ90lDkg3IprS2jbNth2Cuw=
X-Gm-Gg: ASbGncv8fZw6QxqRV1jixgVrDkSRTInF/mkVwwFJohkeTYrqwvvq7NiNQtkiY3G7ZTs
	Z1k4s5xCOfsaGw9GRjhNa8s0U7AqWcOaZ4EQaU3H5/5NEckOgVRo93K1J2hFlVN7iH3GpEyNj0A
	QCYl5Az/9xcmhn4A2kuqjuDw==
X-Google-Smtp-Source: AGHT+IH4vXvxaHWfsTU6xDcTc422Kr5Q5y1lbsUfjOnIjbMO/ZL3k+0Tn8mxiWrIsEMOWU9rf/sSMVRbF+fsJ0bUzAY=
X-Received: by 2002:a17:907:1b21:b0:ac3:47b1:d210 with SMTP id
 a640c23a62f3a-aca9b70dcfemr218716066b.39.1744202187609; Wed, 09 Apr 2025
 05:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxgXO0XJzYmijXu=3yDF_hq3E1yPUxHqhwka19-_jeaNFA@mail.gmail.com>
 <20250408185506.3692124-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250408185506.3692124-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Apr 2025 14:36:16 +0200
X-Gm-Features: ATxdqUFW5kKXnky1jBVZ9KH56lEhFb3dNpOQ5aOJ1YgOd4ThBYFePiRxvIel880
Message-ID: <CAOQ4uxjnjSeDpzk9j6QBQzhiSwwmOAejefxNL3Ar49BuCzBsKg@mail.gmail.com>
Subject: Re: Reseting pending fanotify events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 8:55=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.c=
om> wrote:
>
> > 1. Start a new server instance
> > 2. Set default response in case of new instance crash
> > 3. Hand over a ref of the existing group fd to the new instance if the
> > old instance is running
> > 4. Start handling events in new instance (*)
> > 5. Stop handling new events in old instance, but complete pending event=
s
> > 6. Shutdown old instance
>
> I think this should work for our case, we will only need to reconstruct
> the group/interested mask in case of crash. I can help add the feature fo=
r
> setting different default responses.
>

Please go ahead.

We did not yet get any feedback from Jan on this idea,
but ain't nothing like a patch to solicit feedback.

> > Doing this for the mount level would be possible, but TBH, it does not =
look
> > like the right object to be setting the moderation on, because even if =
we did
> > set a default mask on a mount, it would have been easy to escape it by
> > creating a bind mount, cloning a new mount namespace, etc.
> >
> > What is the reason that you are marking the mount?
> > Is it so that you could have another "unmoderated" mount to
> > populate the file conten?
> > In that case you can opt-in for permission events on sb
> > and opt-out from permission events on the "unmoderated" mount
> > and you can also populate the file content with the FMODE_NONOTIFY
> > fd provided in the permission event.
>
> Yes, essentially we surface and monitor read-only bind mounts of specific
> directories. The current setup opts-in for events per mount (via FAN_MARK=
_MOUNT),
> and initial access populates file contents. If theres a way to do this wi=
th
> sb marks we can switch to that, it would simplify things. I saw theres so=
me
> discussion of similar use-cases in this thread on sb views:
> https://lore.kernel.org/linux-fsdevel/20201109180016.80059-1-amir73il@gma=
il.com/
>

This didn't get anywhere.

But what you can do is mark the sb and opt-out of the main sb mount:

fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
                            FAN_OPEN_PERM, AT_FDCWD, "/data");
fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT | FAN_MARK_IGNORE,
                            FAN_OPEN_PERM, AT_FDCWD, "/data");

Then you will not get open perm events under /data, but if you do
$ mount -o bind /data/hsm /data/hsm

Now /data/hsm is a different mount and this mount does not have an opt-out
for open perm, so you will get the events under /data/hsm.

This should work for this very simple mount hierarchy, but every time that
this mount namespace is cloned or the /data mount is propagated to another
place in the mount namespace, it will be propaged without the opt-out.

So this is a very poor man's subtree watch setup.

> > I might have had some patches similar to this floating around.
> > If you are interested in this feature, I could write and test a proper =
patch.
>
> That would be appreciated if its not too much trouble, the approach outli=
ned
> in sketch should be enough for our use-case (pending the sb vs mount moni=
toring
> point you've raised).
>

Well, the only problem is when I can get to it, which does not appear to be
anytime soon. If this is an urgent issue for you I could give you more poin=
ters
to  try and do it yourself.

There is one design decision that we would need to make before
getting to the implementation.
Assuming that this API is acceptable:

fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM | FAN_MARK_DEFAULT, ..=
.

What happens when fd is closed?
Can the sbinfo->default_mask out live the group fd?

I think that closing this group should remove the default mask
and then the default mask is at least visible at fdinfo of this fd.

Otherwise, we would need another way to expose to userspace
the sb default mask.

Of course your service can put this fd with the default mask in the fd stor=
e
so it will survive a service crash.

Then we need to think about how we express the default mask in fsnotify_mar=
k.
I think we can express it with a flag like the flag
FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS
and enforce that if a mark HAS_DEFAULT_MASK, then the user can only set
FAN_MARK_DEFAULT, the same way that FAN_MARK_IGNORE is sticky.

IOW, you cannot mix FAN_MARK_DEFAULT and other type of masks
(normal and ignore) on the sb mark on the same group.

That's as far as hand waving goes.
If you want more details please ask.

Thanks,
Amir.

