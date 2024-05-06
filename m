Return-Path: <linux-fsdevel+bounces-18847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585898BD3D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26731F22D10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 17:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25991157498;
	Mon,  6 May 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="BUPvsMWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908D156F2C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016606; cv=none; b=AITrE3r6+vrnCPtOlDqIu47Kc3y7TOzR6uVM+ebfISkY90wpPwLXo5ObXFENOTWXLgf3SRoJIivudw5KaU/h9dmEfytke4EdpEzOn7v0QKrWx3JyuQdnYoDbEGabyoietV/FoIxKEB7LGkERgo1Z4ofZtzFp9BUd1nuMg2vYJBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016606; c=relaxed/simple;
	bh=2m0Apzo9xFxDXw8sTML7iaX9VanueAJ0oBXUB2ncRpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4mTiZkH3HBN+lhSBF5X8+E2ysSnVbncZXOvDqBJwJkFoPwaskUPV8zasZqqRrVo8Q4zhoVzxsVjPchIb/2+twVpvDV1cfkJpa3XoWaAlGllcBPwj6GYoyFPnqsbqc+9Xb55zNgst+TVQd98YctznCtG+j6yDF9QIL6cBQwZibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=BUPvsMWm; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4df4016b3c9so466440e0c.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1715016604; x=1715621404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK5ZIv+/3lQIzy70C0Ibh9w+v+69s0hinhfnxG/B7mw=;
        b=BUPvsMWmCd4X2qaPPkpGLxsQXM16NTbxbaiVA2WdYwJM9ais3+u7Z+Hcw2xY4N5yJa
         lLS1yodK7osJcAbc9lGXMPUeRTG9qpf5qYRV0Bz6z4l/1G3EDkXQLwnos9ARNUcdlzm3
         ebklOdTlswwfC0tu6+fAeBHhZiCfu1Xqo1FGJLTE3geirF1iSvIhtGTkCKSDJWmqTkJP
         4C+Dnbzx/UcBYRApRz8c4fCQonZsUhcQw/9S952M+jsSs8Ayxpr3ICkWBTUdvy7VUlL+
         Ni0SiCAUQ6hS8/qN0X2A/2SjMB6TMWNg6L9Lj0Dolnf7C2r+qwWUqU/YmlRckvIGd0t0
         clHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016604; x=1715621404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK5ZIv+/3lQIzy70C0Ibh9w+v+69s0hinhfnxG/B7mw=;
        b=OVZclt6V9dZTZidefiznK44Zs9HxvyWoyze29OaXUVzMlutdKWvL7iDpCYikU+tpdl
         X5lG6MwoBMfImYhvBTNcO83QBh1EENIVgvpuuI/yCMrgobGQNG1TS3KwoBhfeuAZXQre
         mGksH/jgmE5YvAXbUkAxpQo7Ut4xoqvT07vcLZIbZVMDlyGM3rMVTE410fcnHeFZvEkl
         Xo/2jemJ4NCA6TsMnwDgcgv0kmWIpfJAFjgNoB53q9vdxOZZ2wVCz45Me97xtf+RyXQw
         G8MZKk79uBcz/Ad8Ue6aemHU+m/ET9z/t18YunZaVRHRM03+iAgxpknfbJH31jHwM/0G
         ZQHw==
X-Forwarded-Encrypted: i=1; AJvYcCWP1gooSUvJkE2abE5vFj2V2JHS3V7jSdfoKvd0ROf2QQCKsO+WJBAI8XomI28zLd12pm86yzxxz8ILfbYk6eWCrS1yV4/eKi2XEuT1SA==
X-Gm-Message-State: AOJu0Ywb1818hN1dHnCjYHqgDjjyuvMzOFoEtu57KvioprT6BRg5qzmT
	ASqKxgAafhOB7uYl2d0dTh5sn3pXOd7mzuEJVIMSHZ4TMLk0tbdsHCzzgwuEDr79xwzCpM6UA0U
	V2keSimeS9MtxZ4C5pfWie/GP/ntq8YLjFYE+dksEr0zrmKO7jQ==
X-Google-Smtp-Source: AGHT+IEUiIcy0GOYu8BB1OirIXvX5Yu34V0OsXJvQrj6CB8J0noq/BJOsBMaSMkgqcHRU1CL2GM1OR8B88hj8PARo8U=
X-Received: by 2002:a05:6122:4105:b0:4df:235b:8ba1 with SMTP id
 ce5-20020a056122410500b004df235b8ba1mr9922482vkb.7.1715016603540; Mon, 06 May
 2024 10:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru> <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
In-Reply-To: <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 6 May 2024 10:29:52 -0700
Message-ID: <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Stas Sergeev <stsp2@yandex.ru>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Replying to a couple emails at once...

On Mon, May 6, 2024 at 12:14=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2024-04-28, Andy Lutomirski <luto@amacapital.net> wrote:
> > > On Apr 26, 2024, at 6:39=E2=80=AFAM, Stas Sergeev <stsp2@yandex.ru> w=
rote:
> > > =EF=BB=BFThis patch-set implements the OA2_CRED_INHERIT flag for open=
at2() syscall.
> > > It is needed to perform an open operation with the creds that were in
> > > effect when the dir_fd was opened, if the dir was opened with O_CRED_=
ALLOW
> > > flag. This allows the process to pre-open some dirs and switch eUID
> > > (and other UIDs/GIDs) to the less-privileged user, while still retain=
ing
> > > the possibility to open/create files within the pre-opened directory =
set.
> > >
> >
> > I=E2=80=99ve been contemplating this, and I want to propose a different=
 solution.
> >
> > First, the problem Stas is solving is quite narrow and doesn=E2=80=99t
> > actually need kernel support: if I want to write a user program that
> > sandboxes itself, I have at least three solutions already.  I can make
> > a userns and a mountns; I can use landlock; and I can have a separate
> > process that brokers filesystem access using SCM_RIGHTS.
> >
> > But what if I want to run a container, where the container can access
> > a specific host directory, and the contained application is not aware
> > of the exact technology being used?  I recently started using
> > containers in anger in a production setting, and =E2=80=9Canger=E2=80=
=9D was
> > definitely the right word: binding part of a filesystem in is
> > *miserable*.  Getting the DAC rules right is nasty.  LSMs are worse.
> > Podman=E2=80=99s =E2=80=9Cbind,relabel=E2=80=9D feature is IMO utterly =
disgusting.  I think I
> > actually gave up on making one of my use cases work on a Fedora
> > system.
> >
> > Here=E2=80=99s what I wanted to do, logically, in production: pick a ho=
st
> > directory, pick a host *principal* (UID, GID, label, etc), and have
> > the *entire container* access the directory as that principal. This is
> > what happens automatically if I run the whole container as a userns
> > with only a single UID mapped, but I don=E2=80=99t really want to do th=
at for
> > a whole variety and of reasons.
> >
> > So maybe reimagining Stas=E2=80=99 feature a bit can actually solve thi=
s
> > problem.  Instead of a special dirfd, what if there was a special
> > subtree (in the sense of open_tree) that captures a set of creds and
> > does all opens inside the subtree using those creds?
> >
> > This isn=E2=80=99t a fully formed proposal, but I *think* it should be
> > generally fairly safe for even an unprivileged user to clone a subtree
> > with a specific flag set to do this. Maybe a capability would be
> > needed (CAP_CAPTURE_CREDS?), but it would be nice to allow delegating
> > this to a daemon if a privilege is needed, and getting the API right
> > might be a bit tricky.
>
> Tying this to an actual mount rather than a file handle sounds like a
> more plausible proposal than OA2_CRED_INHERIT, but it just seems that
> this is going to re-create all of the work that went into id-mapped
> mounts but with the extra-special step of making the generic VFS
> permissions no longer work normally (unless the idea is that everything
> would pretend to be owned by current_fsuid()?).

I was assuming that the owner uid and gid would be show to stat, etc
as usual.  But the permission checks would be done against the
captured creds.

>
> IMHO it also isn't enough to just make open work, you need to make all
> operations work (which leads to a non-trivial amount of
> filesystem-specific handling), which is just idmapped mounts. A lot of
> work was put into making sure that is safe, and collapsing owners seems
> like it will cause a lot of headaches.
>
> I also find it somewhat amusing that this proposal is to basically give
> up on multi-user permissions for this one directory tree because it's
> too annoying to deal with. In that case, isn't chmod 777 a simpler
> solution? (I'm being a bit flippant, of course there is a difference,
> but the net result is that all users in the container would have the
> same permissions with all of the fun issues that implies.)
>
> In short, AFAICS idmapped mounts pretty much solve this problem (minus
> the ability to collapse users, which I suspect is not a good idea in
> general)?
>

With my kernel hat on, maybe I agree.  But with my *user* hat on, I
think I pretty strongly disagree.  Look, idmapis lousy for
unprivileged use:

$ install -m 0700 -d test_directory
$ echo 'hi there' >test_directory/file
$ podman run -it --rm
--mount=3Dtype=3Dbind,src=3Dtest_directory,dst=3D/tmp,idmap [debian-slim]
# cat /tmp/file
hi there

<-- Hey, look, this kind of works!

# setpriv --reuid=3D1 ls /tmp
ls: cannot open directory '/tmp': Permission denied

<-- Gee, thanks, Linux!


Obviously this is a made up example.  But it's quite analogous to a
real example.  Suppose I want to make a directory that will contain
some MySQL data.  I don't want to share this directory with anyone
else, so I set its mode to 0700.  Then I want to fire up an
unprivileged MySQL container, so I build or download it, and then I
run it and bind my directory to /var/lib/mysql and I run it.  I don't
need to think about UIDs or anything because it's 2024 and containers
just work.  Okay, I need to setenforce 0 because I'm on Fedora and
SELinux makes absolutely no sense in a container world, but I can live
with that.

Except that it doesn't work!  Because unless I want to manually futz
with the idmaps to get mysql to have access to the directory inside
the container, only *root* gets to get in.  But I bet that even
futzing with the idmap doesn't work, because software like mysql often
expects that root *and* a user can access data.  And some software
even does privilege separation and uses more than one UID.

So I want a way to give *an entire container* access to a directory.
Classic UNIX DAC is just *wrong* for this use case.  Maybe idmaps
could learn a way to squash multiple ids down to one.  Or maybe
something like my silly credential-capturing mount proposal could
work.  But the status quo is not actually amazing IMO.

I haven't looked at the idmap implementation nearly enough to have any
opinion as to whether squashing UID is practical or whether there's
any sensible way to specify it in the configuration.

> On Apr 29, 2024, at 2:12=E2=80=AFAM, Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Nowadays it's extremely simple due tue open_tree(OPEN_TREE_CLONE) and
> move_mount(). I rewrote the bind-mount logic in systemd based on that
> and util-linux uses that as well now.
> https://brauner.io/2023/02/28/mounting-into-mount-namespaces.html
>

Yep, I remember that.

>> Podman=E2=80=99s =E2=80=9Cbind,relabel=E2=80=9D feature is IMO utterly d=
isgusting.  I think I
>> actually gave up on making one of my use cases work on a Fedora
>> system.
>>
>> Here=E2=80=99s what I wanted to do, logically, in production: pick a hos=
t
>> directory, pick a host *principal* (UID, GID, label, etc), and have
>> the *entire container* access the directory as that principal. This is
>> what happens automatically if I run the whole container as a userns
>> with only a single UID mapped, but I don=E2=80=99t really want to do tha=
t for
>> a whole variety and of reasons.
>
> You're describing idmapped mounts for the most part which are upstream
> and are used in exactly that way by a lot of userspace.
>

See above...

>>
>> So maybe reimagining Stas=E2=80=99 feature a bit can actually solve this
>> problem.  Instead of a special dirfd, what if there was a special
>> subtree (in the sense of open_tree) that captures a set of creds and
>> does all opens inside the subtree using those creds?
>
> That would mean override creds in the VFS layer when accessing a
> specific subtree which is a terrible idea imho. Not just because it will
> quickly become a potential dos when you do that with a lot of subtrees
> it will also have complex interactions with overlayfs.

I was deliberately talking about semantics, not implementation. This
may well be impossible to implement straightforwardly.

