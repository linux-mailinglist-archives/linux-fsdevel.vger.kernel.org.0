Return-Path: <linux-fsdevel+bounces-45490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E4A7875F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 06:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50EF3AEBA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 04:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAFE230BE5;
	Wed,  2 Apr 2025 04:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgv2+7e0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97743199948
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743569100; cv=none; b=mLrPBAoCF+k/GkloZJ4bTkcKKVFB67Hes2vvcbX9Wjj5IgyC8b9cmepeAczFmxXUb4JUzj5UtaT9FdfwygMUPo8R/xYzxorntViSGZitFE6AetLs/S3sn17Os/6nuBW/rkBgblZJc2+lc1U/YjDuRhhO/YJZNMlexeSeHRVoIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743569100; c=relaxed/simple;
	bh=WMy/vSf/4LLdTiX6Tt202U1X3lURJIhOMA4qh6wE3Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+eZCVO3E4WODOxiFIaWNxDp9wy+WzIKjPHdQlFBRDqBhMMcpCjvyhe2eNwu+VOmzWmMNCw0DbgwRpAbqnowilXAaFP0Lodc65c+GzYHo9YynZSSBoup5/gYVr+8AJypWBrItLrzaHxPTvElxHUMXPKLEShQiSJyLpBe3Fo3vWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgv2+7e0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so10960821a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 21:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743569097; x=1744173897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2NanE9YZHP0YytzBIzyIpl5ZBTxb7bnKPFxm5yK84o=;
        b=mgv2+7e0+7rWOH8/hsCBa0lu4kov4glGdbtr0MIfREA744IhhYo7XWc2CYUq1G8QuE
         XpTDgmlxS6kEizrXloJ+e+T4HhOiGHe+lRaKjdGoI+l9/uFfT/LbpyTPsD534pV03GtZ
         Zul6kM5kQ867GRT1jC93QGOBCqHzam4hTDt9eSjt9DATq6NhHqNpEiEaC+iBRkajy1rv
         TkdN5kt46qYd9Z9jVQJfiS5eO5BRzRH/20SinjWo+626hcS/qmbdf4RE3z1u0md+ysxn
         Kc/8atuMJ0O1Y3/vjdh0KrRt0PCFdJPpS992CNZG+BohBG6Enqy90IxdZ4gfQu3tHmAl
         il7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743569097; x=1744173897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2NanE9YZHP0YytzBIzyIpl5ZBTxb7bnKPFxm5yK84o=;
        b=iiWLs5jAP1FxW+dimecn1OWyjItExPL+2cH6MN9LPPjrIqh1m/eJp7RApvoCTfTcJR
         rjw0mQXYjBoK+OXjWp2EudnCk5IKDYFFU1NeFnx6ui1xKIaZ++rNfGsvOrUEiOuMAzTV
         G3/AxwhAkoC5RxoglxLnzGKZWw2k3GOIA0yPsktlKPOrOpLjW91c/GwMVtuBvKGf47E9
         Uli9ox2aFVNFW1qvBVPRj1l1eRDS9Og+iaSyaGKOxtlv5/HvwEhoofc/c7GNjOY9srpt
         EZ9jd9gBLow8rfsViX2o0+h/MHAItuIKVUzPymnjMLY9dpuNNjKRA/rYMziGi+rBkZ8W
         VZKA==
X-Forwarded-Encrypted: i=1; AJvYcCWA/YpkNlbaaEIdNV6epmBRYciWSYkjhXMMUXRPILNy3+ipfQQ2kzKi2NAtkX4OZI8TH4c4Saq7oGW2c+bA@vger.kernel.org
X-Gm-Message-State: AOJu0YyPtsy7+kC1eQUCENLxg2N1nUfZZmrq99Wy5WznsGGDbAqBTP9J
	vDl6EXgV36oy+8RAASQz7cYHLyQ6ohF2BQilHjsu17MQ1uiAjlKDGpsUPZZpJt5uMrJaOhyiigl
	XHTIkwR9w4zFb5Zq3rzwk5SMpj9k=
X-Gm-Gg: ASbGncsFi7tBHQxMQCSDfyoLOlmH2lKoAXuG0KIfNhqPCC2X4RDHXqio/hRwnaKZbMC
	XqC/lvApLmORs67L2z1m1+b8SSGLxZuHB+dlQ/oNPWJOnfRTy/zJpWgzlsSrJ+MVZ7cQ2a6htZU
	KL+boXvlloAaX4w6/YxVyCsQPF6A==
X-Google-Smtp-Source: AGHT+IH6o9cvKbzb89eHKV76E7Cmc4czjGHd1nV1dSnLaMam7K4zFZp+SHEnsYWVHfjWrnhHUdhK9LmvjZ7LyIl3Kzo=
X-Received: by 2002:a05:6402:1e8e:b0:5e5:c5f5:f78 with SMTP id
 4fb4d7f45d1cf-5edfda04becmr14586485a12.26.1743569096353; Tue, 01 Apr 2025
 21:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr> <20250401211609.2433022-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250401211609.2433022-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Apr 2025 06:44:45 +0200
X-Gm-Features: AQ5f1JpMvQ209J5SVNgZEHKcDUwmsvNYVpGN3pGvJ7OjozdnC6ZtZEg8H6ou6zE
Message-ID: <CAOQ4uxi6PvAcT1vL0d0e+7YjvkfU-kwFVVMAN-tc-FKXe1wtSg@mail.gmail.com>
Subject: Re: Reseting pending fanotify events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 11:16=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> Hopefully the formatting works well now. Also including some replies to
> questions from earlier in the thread in case they were lost.
>

Ibrahim,

I think this is an important aspect of productizing HSM, so thank
you for bringing it to our attention.

> > But what confuses me is the following: You have fanotify instance to wh=
ich
> > you've got fd from fanotify_init(). For any process to be hanging, this=
 fd
> > must be still held open by some process. Otherwise the fanotify instanc=
e
> > gets destroyed and all processes are free to run (they get FAN_ALLOW re=
ply
> > if they were already waiting). So the fact that you see processes hangi=
ng
> > when your fanotify listener crashes means that you have likely leaked t=
he
> > fd to some other process (lsof should be able to tell you which process=
 has
> > still handle to fanotify instance). And the kernel has no way to know t=
his
> > is not the process that will eventually read these events and reply...
>
> I can clarify this further. In our case its important to not destroy the =
fanotify
> instance during daemon shutdown as giving FAN_ALLOW to waiting processes =
could
> enable accessing a file which has not actually been populated. To this en=
d, we
> persist the fd from fanotify_init accross daemon restarts. In particular =
since
> the daemon is a systemd unit, we rely on the systemd fd store (https://sy=
stemd.io/FILE_DESCRIPTOR_STORE/)
> for this, which essentially will maintain a dup of the fanotify fd. This =
is why

I suspected that this might be the case.

I do not blame you for using the fd store, but I think this was a band aid
in absence of a better solution.

With a better solution, there will be no need to keep the fd alive and no
need to recover pending events.

See some suggestions below.

> we can run into the case of hanging events during planned restart or unin=
tented
> crash. Heres a sample trace of D-state process I had linked in earlier re=
ply:
>
> [<0>] fanotify_handle_event+0x8ac/0x10f0
> [<0>] fsnotify+0x5fb/0x8d0
> [<0>] __fsnotify_parent+0x17f/0x260
> [<0>] security_file_open+0x8f/0x130
> [<0>] vfs_open+0x109/0x4c0
> [<0>] path_openat+0x9a4/0x27d0
> [<0>] do_filp_open+0x91/0x120
> [<0>] bprm_execve+0x15c/0x690
> [<0>] do_execveat_common+0x22c/0x330
> [<0>] __x64_sys_execve+0x36/0x40
> [<0>] do_syscall_64+0x3d/0x90
> [<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> Confirmed it was killable per Jan's clarification.
>
> > > > In this case, any events that have been read but not yet responded =
to would be lost.
> > > > Initially we considered handling this internally by saving the file=
 descriptors for pending events,
> > > > however this proved to be complex to do in a robust manner.
> > > >
> > > > A more robust solution is to add a kernel fanotify api which resets=
 the fanotify pending event queue,
> > > > thereby allowing us to recover pending events in the case of daemon=
 restart.
> > > > A strawman implementation of this approach is in
> > > > https://github.com/torvalds/linux/compare/master...ibrahim-jirdeh:l=
inux:fanotify-reset-pending,
> > > > a new ioctl that resets `group->fanotify_data.access_list`.
> > > > One other alternative we considered is directly exposing the pendin=
g event queue itself
> > > > (https://github.com/torvalds/linux/commit/cd90ff006fa2732d28ff6bb59=
75ca5351ce009f1)
> > > > to support monitoring pending events, but simply resetting the queu=
e is likely sufficient for our use-case.
> > > >
> > > > What do you think of exposing this functionality in fanotify?
> > > >
> > >
> > > Ignoring the pending events for start, how do you deal with access to
> > > non-populated files while the daemon is down?
> > >
> > > We were throwing some idea about having a mount option (something
> > > like a "moderate" mount) to determine the default response for specif=
ic
> > > permission events (e.g. FAN_OPEN_PERM) in the case that there is
> > > no listener watching this event.
> > >
> > > If you have a filesystem which may contain non-populated files, you
> > > mount it with as "moderated" mount and then access to all files is
> > > denied until the daemon is running and also denied if daemon is down.
> > >
> > > For restart, it might make sense to start a new daemon to start liste=
ning
> > > to events before stopping the old daemon.
> > > If the new daemon gets the events before the old daemon, things shoul=
d
> > > be able to transition smoothly.
> >
> > I agree this would be a sensible protocol for updates. For unplanned cr=
ashes
> > I agree we need something like the "moderated" mount option.
>
> We can definitely try out the suggested approach of starting up new daemo=
n
> instance  alongside old one to prevent downtime during planned restart.

Let me list a few approaches to this problem that were floated in the past.
You may choose bits and parts that you find useful to your use case.

1. Persistent marks
Some discussion here:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxjY3eDtqXObbso1KtZTMB7+zYHBRiUA=
Ng12hO=3DT=3DvqJrw@mail.gmail.com/
a persistent mark in xattr to deny a certain operation -
quite hard to get this API right and probably an overkill

2. Fanotify filter
https://lore.kernel.org/linux-fsdevel/CAPhsuW4psFtCVqHe2wK4RO2boCbcyPtfsGzH=
zzNU_1D0gsVoaA@mail.gmail.com/
While it was proposed as a method for optimization, you can also use it
as a guard to prevent access to un populated content -
If you can implement a simple kmod/bpf program that checks if file
has content or not, then you can setup a "guard group" first that
only checks if a file has content or not and allows or denies access
in the kernel.
You then hand its fd to the fd store to keep the group alive.
After that you start the HSM group that would be called before the guard gr=
oup
to populate file content when needed.
The HSM group can use the same kmod/bpf filter to decide is HSM usersapce
needs to be called for better performance.
A bit clumsy, but should work.

3. Change the default response to pending events on group fd close
Support writing a response with
.fd =3D FAN_NOFD
.response =3D FAN_DENY | FAN_DEFAULT
to set a group parameter fanotify_data.default_response.

Instead of setting pending events response to FAN_ALLOW,
could set it to FAN_DENY, or to descriptive error like
FAN_DENY(ECONNRESET).

You could also set it to a new defined response FAN_RETRY that
would result in ERESTARTSYS returned for the caller and then
syscall will hopefully be handled by the new HSM server instance.

The default response could be used in conjunction with fd store
instead of requeueing/resetting the pending events.
All the new service instance needs to do is to get the fd from
the fd store and close it after having opened a new group fd.

That should be quite simple to implement compared to
persistent marks/moderated mount/fanotify filters and should suffice
if it is acceptable that upon crash of HSM, processes will be blocked
(killable) until the new HSM service instance comes up and then
processes will be able to continue.
This is kind of similar to the way that processes accessing an NFS
mount will behave during network outage.

WDYT?

Amir.

