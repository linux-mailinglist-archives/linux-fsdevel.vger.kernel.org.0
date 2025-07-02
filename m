Return-Path: <linux-fsdevel+bounces-53680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D9AF5F35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2C21883973
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EE02E03F0;
	Wed,  2 Jul 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxuPYidc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC242F508D
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475404; cv=none; b=IV/TliHaKy8ysrFcSU4YYlES2vd+qFsBEWSO+8uhZbDx0PyR7BywxNVUDRJYDYzGvz1h6nAbY7fE/78+2b/QlelcOA1NE1CcqAVGo0tZm/OmfF8e5mZCDRQaaE8E+EIPVMePQPlBt/ED/0UZyiu8afLZZv6U0qPXuIl196/nQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475404; c=relaxed/simple;
	bh=TNukgtz7K223iRPgJOQq4pFxS7Hz+/rRCR5JZqPlbIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYV4M45pyRiL0PhiYeVKRldss3Bj2sfL1HDXMP9yLO+9lksb0t1HdXgSF1Kzd39WHmjp92NojbJC+owDuF1PG5UzbqOz6dcrFjdhhvw/fPFhirYMlZ1SoamBT3pEMI5cQUfUhr0wbjefl84d+Q6wFMCb0puEL7eqK7mF61cABjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxuPYidc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so14292083a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751475400; x=1752080200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgklSM9ShRt8Ilv/lPlLukoFT48vxPHly0E346waTs4=;
        b=GxuPYidc8ix3NbGkffC0fv6RTQtn8JRUBIV7wlIfXFkuLSxc4nJqYXfi2FjCqsYjih
         J5n2P5nLjHdhljZ9wGADkcSkBMLoJ/d2RW83gBXRA4gD0njfhrevmIAeiG+LTElZ4IYa
         JOkZCMQv8uOvMsuk4SmZn50MozVj2ZO7Hu4ArplAJcfAflv3vWtUj+QGmeX301b/Th+Y
         vDiN7ho/zT7kPrKwKjWVU8eAMpWlaKmkF0LStsV9ZvZTzdaldMQlY7K+D2Yt7c+/b3l7
         cw6Q9XRfWaGxj/F0L8G2C66aAiPJbdJ2seK7fKT7zq/oH9UkE8SI+xoYKlR8Z7ujZWXq
         279g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475400; x=1752080200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgklSM9ShRt8Ilv/lPlLukoFT48vxPHly0E346waTs4=;
        b=Z3EMSsZOZGed2c/wyojExMBa+ED5axxdEdOcKwUqS4t3zkw3MJNprINpALGOv0MeKj
         5kyAubakKiOKIuf/MM8/jhe+Mfsasbx5e7lB8YcpIt+hNILQVcSR1RhKnCpP/cdv3Grf
         4e1Xo0CazV7pT66QJk9wMm4XiAOUiMqJ+ewmos8pFZ1EBBFNAHN30QFk46SdyrDEQrRk
         MSgPR6zwQVepVorSwpIqwgZxM37tZGcKU6uDd3zxz3kfn9vrhtR0MeB2dDQv+YR/HToT
         Gl774yBE13qTcEr1dr/0VLcxU1/vvJlV9ii/9FdpBmUJGdN/xE3+VwQqYoiqdB5BPF/j
         +LKA==
X-Forwarded-Encrypted: i=1; AJvYcCWD0oldUphlQqwE/XwSYgfk5uGBaJGWEYMIACuSqNMemnNDNd9Tuhfxfy3grJ4SU6igYXAQDZ9M1AHx+kJT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxir1aFgoeTtsQ8nftbRtVjBhXJFkM+6IACnLqT9zQryqb2WxeN
	EJoXWNPZdm9Q84ZWdGuJHBSgPyzlaldOxWvIjBCkV6kjrcLAlMIOoYdIJ2+fIVXIkV5imzjowrJ
	uHQRvUXQKtPpWjd5hhacXh1xomF+parc=
X-Gm-Gg: ASbGncu8oPVtSUY9fEiJdr2gDhtgZepfX8UIxRPhqlsQ5cGL6YI5caT4ZXgiJlCfcuR
	z9hY6ZA3yNi4MO7iikHqJwayiT9OFPH1BeuvE9ggb1AUYNyZlzOcRFOe31dE11f5KWtvoK27Qto
	AkSGem5iQsshScOPaNlU8hZlqWl2bmL0eCrFefrtbXBtg=
X-Google-Smtp-Source: AGHT+IG+j1jtmyzvV7AYoDgtDG21lBl8CCWrkwRYV8bzzMVTam0AohZnsn+ukTIaMBrlWwdwqf0jSrQXrRrhkXwbTCs=
X-Received: by 2002:a17:907:96ab:b0:ae2:a7aa:7efe with SMTP id
 a640c23a62f3a-ae3c2d94db8mr381125366b.58.1751475399193; Wed, 02 Jul 2025
 09:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623192503.2673076-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxguBgMuUZqs0bT_cDyEX6465YkQkUHFPFE4tndys-y2Wg@mail.gmail.com>
 <tq6g6bkzojggcwu3bxkj57ongbvyynykylrtmlphqa7g7wb6f2@7gid5uogbfc4>
 <CAOQ4uxirFm8_U7z4ke5Z4iNbatSbXoz1YK_2eGL=1JQQOtt75Q@mail.gmail.com> <2ogjwnem7o3jwukzoq2ywnxha5ljiqnjnr4o4b5xvdvwpbyeac@v4i7jygvk7fj>
In-Reply-To: <2ogjwnem7o3jwukzoq2ywnxha5ljiqnjnr4o4b5xvdvwpbyeac@v4i7jygvk7fj>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Jul 2025 18:56:27 +0200
X-Gm-Features: Ac12FXwz-bY0WE8HxDlCJMYDilMJH7Xmb6yOcxXJDKwoyw9LMkTiv5aem4ZuJps
Message-ID: <CAOQ4uxjTtyn04XC65hv2MVsRByGyvxJ0wK=-FZmb1sH1w0CFtA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: support custom default close response
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 30-06-25 17:56:00, Amir Goldstein wrote:
> > On Mon, Jun 30, 2025 at 5:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Tue 24-06-25 08:30:03, Amir Goldstein wrote:
> > > > On Mon, Jun 23, 2025 at 9:26=E2=80=AFPM Ibrahim Jirdeh <ibrahimjird=
eh@meta.com> wrote:
> > > > >
> > > > > Currently the default response for pending events is FAN_ALLOW.
> > > > > This makes default close response configurable. The main goal
> > > > > of these changes would be to provide better handling for pending
> > > > > events for lazy file loading use cases which may back fanotify
> > > > > events by a long-lived daemon. For earlier discussion see:
> > > > > https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbb=
xi6bi44canfsg2aajgkialt@c3ujlrjzkppr/
> > > >
> > > > These lore links are typically placed at the commit message tail bl=
ock
> > > > if related to a suggestion you would typically use:
> > > >
> > > > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > > > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxi6PvAcT1vL0d0e+7=
YjvkfU-kwFVVMAN-tc-FKXe1wtSg@mail.gmail.com/
> > > > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> > > >
> > > > This way reviewers whose response is "what a terrible idea!" can
> > > > point their arrows at me instead of you ;)
> > > >
> > > > Note that this is a more accurate link to the message where the def=
ault
> > > > response API was proposed, so readers won't need to sift through
> > > > this long thread to find the reference.
> > >
> > > I've reread that thread to remember how this is supposed to be used. =
After
> > > thinking about it now maybe we could just modify how pending fanotify
> > > events behave in case of group destruction? Instead of setting FAN_AL=
LOW in
> > > fanotify_release() we'd set a special event state that will make fano=
tify
> > > group iteration code bubble up back to fsnotify() and restart the eve=
nt
> > > generation loop there?
> > >
> > > In the usual case this would behave the same way as setting FAN_ALLOW=
 (just
> > > in case of multiple permission event watchers some will get the event=
 two
> > > times which shouldn't matter). In case of careful design with fd stor=
e
> > > etc., the daemon can setup the new notification group as needed and t=
hen
> > > close the fd from the old notification group at which point it would
> > > receive all the pending events in the new group. I can even see us ad=
ding
> > > ioctl to the fanotify group which when called will result in the same
> > > behavior (i.e., all pending permission events will get the "retry"
> > > response). That way the new daemon could just take the old fd from th=
e fd
> > > store and call this ioctl to receive all the pending events again.
> > >
> > > No need for the new default response. We probably need to provide a g=
roup
> > > feature flag for this so that userspace can safely query kernel suppo=
rt for
> > > this behavior but otherwise even that wouldn't be really needed.
> > >
> > > What do you guys think?
> >
> > With proper handover I am not sure why this is needed, because:
> > - new group gets fd from store and signals old group
> > - old group does not take any new event, completes in-flight events,
> >   signals back new group and exists
> > - new group starts processing events
> > - so why do we need a complex mechanism in kernel to do what can easily
> >   be done in usersapce?
>
> This works for clean handover (say service update) - no need for any
> mechanism (neither retry nor default response there). We are in agreement
> here. If retry is supported, it will make the handover somewhat simpler f=
or
> userspace but that's not really substantial.
>
> > Also, regardless I think that we need the default response, because:
> > - groups starts, set default response to DENY and handsover fd to store
> > - if group crashes unexpectedly, access to all files is denied, which i=
s
> >   exactly what we needed to do with the "moderated" mount
> > - it is similar to access to FUSE mount when server is down
>
> Yes, crashes are what I had in mind. With crashes you have nobody to
> cleanly handle events still pending for the old group and you have to sol=
ve
> it. Reporting FAN_DENY (through default response) is one way, what I
> suggest with retry has the advantage that userspace doesn't have to deal
> with spurious FAN_DENY errors in case of daemon crash. It is not a huge
> benefit (crashes should better be rare ;)) but it is IMO a benefit.
>
> Now regarding your comment about moderated mount: You are somewhat terse =
on
> details so let me try to fill in. First let's differentiate between servi=
ce
> (daemon) and the notification group because they may have a different
> lifetime. So the service starts, creates a notification group, places mar=
k
> on the sb with pre-content events. You didn't mention a mark in your
> description but until the mark is set, the group receives no events so
> there's nothing to respond to. Now if the service crashes there are two
> options:
>
> 1) You didn't save your group fd anywhere. In that case the group and mar=
k
> is gone with the crash of the service, all accesses happening after this
> moment are allowed =3D> not good. Whether we have default response or not
> doesn't really matter in this case for those few events that were possibl=
y
> pending. Agreed so far?

Yes.

>
> 2) You've saved group fd to fd store. In this case the group is (from
> kernel POV) fully alive even after the service crash and the default
> response does not activate. The events will be queued to the group and
> waiting for reply. No access to the fs is allowed to happen which is good=
.

Well this was my mistake.
I somehow forgot that the events would be blocked in this case.
I had imagined the desired "moderated mount" behavior where
events would be auto denied.

But that would require more work.
It would require decoupling the "control" fd which identifies the group
and can be used to setup marks and for ioctls from the "queue" fd that
is used to reading events and writing responses.

> Eventually the new service starts and we are in the situation I describe =
3
> paragraphs above about handling pending events.
>
> So if we'd implement resending of pending events after group closure, I
> don't see how default response (at least in its current form) would be
> useful for anything.
>
> Why I like the proposal of resending pending events:
> a) No spurious FAN_DENY errors in case of service crash
> b) No need for new concept (and API) for default response, just a feature
>    flag.
> c) With additional ioctl to trigger resending pending events without grou=
p
>    closure, the newly started service can simply reuse the
>    same notification group (even in case of old service crash) thus
>    inheriting all placed marks (which is something Ibrahim would like to
>    have).

Yes I see the benefits now.

>
> Regarding complexity of the approach I propose the attached (untested)
> patch should implement it and I don't think it is very complex logic...
> So what do you think now? :)
>

Does not look complex at all :)
so no objections.

Thanks,
Amir.

