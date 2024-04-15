Return-Path: <linux-fsdevel+bounces-16938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F248A5309
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971231C21860
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111B768E1;
	Mon, 15 Apr 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh2vH4co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F62762D2
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191035; cv=none; b=K+CAqKYWivXPrc9soee9igwmWy3+G/7cJ8ZG4PNGFF43ZhPSYaBVjvOf9MmWMrZv7p1SqWin5fUHLIP77/lYlVNHiTnhOj00npEFPVaU4cxgyvPovmPHRo/RJQtgtOLsjDb2700SGkzA56hk7yXpI/hG5GjV5aMs1rvcASYnhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191035; c=relaxed/simple;
	bh=r0m0tytDFCFbEdt6NRk1H3QYBHyzCdwy24YnR9XoH0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zru+m7zdINOQJjajWP9UwsltmA+mynUDdmj4iYUmpjNcDyRY7oT/cu8yPz3QIOsAdIBy/gQcf/MtAs80D0XWL33SY/ZlCcXsyFfpeyf+W3DHUtM0h0VD6/K3Gzcp2x27jRRr7eZ0Rr+nNJnV/VBu/S6O0ffFu+cdyh8/sL6fDoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh2vH4co; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-696609f5cf2so19687436d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713191032; x=1713795832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge8BAlikKV8BL+OLR/aL8F2h9w7Tl9onejBv8Wkc7wI=;
        b=fh2vH4coIQ7y1I3vNRUeMbyXI50+PJvRh4ZpmVO9inV6SnLHXIXgLlH0ZMuGZ64jEx
         uSrU/3PpmBRqJiW65jP3h4+5smDU9iObUsKvMN5bpZUdfyXbupj/IECvoeNbU3YkBubK
         wtwM0BmRBkSK6ohIsVaYgLL0qvqL9SANUpXVWF9jyCPqyPTxbFS9VqIgLK7/xGFNAklb
         YMOdCmUqrzOGtFq/tMM4cmgQTkSa2PnsqzL/lc4S6vOVbIXJKMp3qsvvKXWVLfl3EbgQ
         Rym5eV8ddyxKHIlMyV0EIgZhyRRsbae93MUqK7CEqAXdWTBgpetkttUZ70UWltbvnBZO
         /chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191032; x=1713795832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge8BAlikKV8BL+OLR/aL8F2h9w7Tl9onejBv8Wkc7wI=;
        b=V1RW6UhfO+/zsJbsYieZx79Jpe73SJFQFHSyvTi5tNJSGV8mxM1aQiAIf2dXDkm2/K
         2T6d1oTtIQUBMagYemSBoR0cZ9YBXYnpvmzlizKiEJdcImNHzyNKM7psUj+fnhDRuLlb
         wpES7P5cpn1gbR9ifxLLuB+/KWABJaPq9mYe/7xSJBDIJEaHkswZAvlkmGebDqxIJ3+B
         +eP9gNT5mvOAa1nqKsflPETUfgNvYZGqoGKM/TYzSEc0W4cf37GwzcTb5JhZmQgYRknk
         OiSUTolJLntslc2apiw1YEwiV2SlLlqV8H4ebRavM9Vgqt2nysa22VHcJKphJSJOTZdQ
         3Yeg==
X-Forwarded-Encrypted: i=1; AJvYcCXEBza9/oGwisRLhOmZ7MPZvjqve7AfbaAKVKDFXiuk8SQQveqCghsooSs6sv+VLRH7UpAHDE8t7hvh87iQuwmG/YvJYEoYUSKtTXWAbA==
X-Gm-Message-State: AOJu0Yxes4T0bgZEGO0MaIL6DNUNozrLv+Vv8zv4B1HcyFKSYTRX7hL2
	2I527kfefvU0Ox1TkSPlH5zB7sO0TyOMa6PUUmzyxGr2B/gJaRswD0bo7h6iOY9TYptKKV2FjAj
	AqIgoTLVallzeZqBlSq6x1YsrrL4=
X-Google-Smtp-Source: AGHT+IEsBEW6Vyx+/bMpU8Ygz8vgme1ikZQxtsoxMHxjpl5D8acOqaIPFu2pSO+P7s5CCeTnwnBl+rsAUIs4gKhRoWM=
X-Received: by 2002:a05:6214:c67:b0:69b:20a7:5669 with SMTP id
 t7-20020a0562140c6700b0069b20a75669mr13067865qvj.53.1713191032316; Mon, 15
 Apr 2024 07:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
 <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
 <20240208183127.5onh65vyho4ds7o7@quack3> <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
 <20240212120157.y5d5h2dptgjvme5c@quack3> <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
 <20240215115139.rq6resdfgqiezw4t@quack3> <CAOQ4uxh-zYN_gok2mp8jK6BysgDb+BModw+uixvwoHB6ZpiGww@mail.gmail.com>
 <20240219110121.moeds3khqgnghuj2@quack3> <CAOQ4uxizF_=PK9N9A8i8Q_QhpXe7MNrfUTRwR5jCVzgfSBm1dw@mail.gmail.com>
 <20240304103337.qdzkehmpj5gqrdcs@quack3>
In-Reply-To: <20240304103337.qdzkehmpj5gqrdcs@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Apr 2024 17:23:40 +0300
Message-ID: <CAOQ4uxh35YhMVfXHchYpgG_HoOmLY4civVpeVtz4GQmasHqWdw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
	Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 12:33=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 27-02-24 21:42:37, Amir Goldstein wrote:
> > On Mon, Feb 19, 2024 at 1:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 15-02-24 17:40:07, Amir Goldstein wrote:
> > > > > > Last time we discussed this the conclusion was an API of a grou=
p-less
> > > > > > default mask, for example:
> > > > > >
> > > > > > 1. fanotify_mark(FAN_GROUP_DEFAULT,
> > > > > >                            FAN_MARK_ADD | FAN_MARK_MOUNT,
> > > > > >                            FAN_PRE_ACCESS, AT_FDCWD, path);
> > > > > > 2. this returns -EPERM for access until some group handles FAN_=
PRE_ACCESS
> > > > > > 3. then HSM is started and subscribes to FAN_PRE_ACCESS
> > > > > > 4. and then the mount is moved or bind mounted into a path expo=
rted to users
> > > > >
> > > > > Yes, this was the process I was talking about.
> > > > >
> > > > > > It is a simple solution that should be easy to implement.
> > > > > > But it does not involve "register the HSM app with the filesyst=
em",
> > > > > > unless you mean that a process that opens an HSM group
> > > > > > (FAN_REPORT_FID|FAN_CLASS_PRE_CONTENT) should automatically
> > > > > > be given FMODE_NONOTIFY files?
> > > > >
> > > > > Two ideas: What you describe above seems like what the new mount =
API was
> > > > > intended for? What if we introduced something like an "hsm" mount=
 option
> > > > > which would basically enable calling into pre-content event handl=
ers
> > > >
> > > > I like that.
> > > > I forgot that with my suggestion we'd need a path to setup
> > > > the default mask.
> > > >
> > > > > (for sb without this flag handlers wouldn't be called and you can=
not place
> > > > > pre-content marks on such sb).
> > > >
> > > > IMO, that limitation (i.e. inside brackets) is too restrictive.
> > > > In many cases, the user running HSM may not have control over the
> > > > mount of the filesystem (inside containers?).
> > > > It is true that HSM without anti-crash protection is less reliable,
> > > > but I think that it is still useful enough that users will want the
> > > > option to run it (?).
> > > >
> > > > Think of my HttpDirFS demo - it's just a simple lazy mirroring
> > > > of a website. Even with low reliability I think it is useful (?).
> > >
> > > Yeah, ok, makes sense. But for such "unpriviledged" usecases we don't=
 have
> > > a deadlock-free way to fill in the file contents because that require=
s a
> > > special mountpoint?
> >
> > True, unless we also keep the FMODE_NONOTIFY event->fd
> > for the simple cases. I'll need to think about this some more.
>
> Well, but even creating new fds with FMODE_NONOTIFY or setting up fanotif=
y
> group with HSM events need to be somehow priviledged operation (currently
> it requires CAP_SYS_ADMIN). So the more I think about it the less obvious
> the "unpriviledged" usecase seems to be.
>

ok. Let's put this one on ice for now.

> > > > > These handlers would return EACCESS unless
> > > > > there's somebody handling events and returning something else.
> > > > >
> > > > > You could then do:
> > > > >
> > > > > fan_fd =3D fanotify_init()
> > > > > ffd =3D fsopen()
> > > > > fsconfig(ffd, FSCONFIG_SET_STRING, "source", device, 0)
> > > > > fsconfig(ffd, FSCONFIG_SET_FLAG, "hsm", NULL, 0)
> > > > > rootfd =3D fsconfig(ffd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)
> > > > > fanotify_mark(fan_fd, FAN_MARK_ADD, ... , rootfd, NULL)
> > > > > <now you can move the superblock into the mount hierarchy>
> > > >
> > > > Not too bad.
> > > > I think that "hsm_deny_mask=3D" mount options would give more flexi=
bility,
> > > > but I could be convinced otherwise.
> > > >
> > > > It's probably not a great idea to be running two different HSMs on =
the same
> > > > fs anyway, but if user has an old HSM version installed that handle=
s only
> > > > pre-content events, I don't think that we want this old version if =
it happens
> > > > to be run by mistake, to allow for unsupervised create,rename,delet=
e if the
> > > > admin wanted to atomically mount a fs that SHOULD be supervised by =
a
> > > > v2 HSM that knows how to handle pre-path events.
> > > >
> > > > IOW, and "HSM bit" on sb is too broad IMO.
> > >
> > > OK. So "hsm_deny_mask=3D" would esentially express events that we req=
uire HSM
> > > to handle, the rest would just be accepted by default. That makes sen=
se.
> >
> > Yes.
> >
> > > The only thing I kind of dislike is that this ties fanotify API with =
mount
> > > API. So perhaps hsm_deny_mask should be specified as a string? Like
> > > preaccess,premodify,prelookup,... and transformed into a bitmask only
> > > inside the kernel? It gives us more maneuvering space for the future.
> > >
> >
> > Urgh. I see what you are saying, but this seems so ugly to me.
> > I have a strong feeling that we are trying to reinvent something
> > and that we are going to reinvent it badly.
> > I need to look for precedents, maybe in other OS.
> > I believe that in Windows, there is an API to register as a
> > Cloud Engine Provider, so there is probably a way to have multiple HSMs
> > working on different sections of the filesystem in some reliable
> > crash safe manner.
>
> OK, let's see what other's have came up with :)

From my very basic Google research (did not ask Chat GPT yet ;))
I think that MacOS FSEvents do not have blocking permission events at all,
so there is no built-in HSM API.

The Windows Cloud Sync Engine API:
https://learn.microsoft.com/en-us/windows/win32/cfapi/build-a-cloud-file-sy=
nc-engine
Does allow registring different "Storage namespace providers".
AFAICT, the persistence of "Place holder" files is based on NTFS
"Reparse points",
which are a long time native concept which allows registering a persistent
hook on a file to be handled by a specific Windows driver.

So for example, a Dropbox place holder file, is a file with "reparse point"
that has some label to direct the read/write calls to the Windows
Cloud Sync Engine
driver and a sub-label to direct the handling of the upcall by the Dropbox
CloudSync Engine service.

I do not want to deal with "persistent fanotify marks" at this time, so may=
be
something like:

fsconfig(ffd, FSCONFIG_SET_STRING, "hsmid", "dropbox", 0)
fsconfig(ffd, FSCONFIG_SET_STRING, "hsmver", "1", 0)

Add support ioctls in fanotify_ioctl():
- FANOTIFY_IOC_HSMID
- FANOTIFY_IOC_HSMVER

And require that a group with matching hsmid and recent hsmver has a live
filesystem mark on the sb.

If this is an acceptable API for a single crash-safe HSM provider, then the
question becomes:
How would we extend this to multiple crash-safe HSM providers in the future=
?

Or maybe we do not need to support multiple HSM groups per sb?
Maybe in the future a generic service could be implemented to
delegate different HSM modules, e.g.:

fsconfig(ffd, FSCONFIG_SET_STRING, "hsmid", "cloudsync", 0)
fsconfig(ffd, FSCONFIG_SET_STRING, "hsmver", "1", 0)

And a generic "cloudsync" service could be in charge of
registration of "cloudsync" engines and dispatching the pre-content
event to the appropriate module based on path (i.e. under the dropbox folde=
r).

Once this gets passed NACKs from fs developers I'd like to pull in
some distro people to the discussion and maybe bring this up as
a topic discussion for LSFMM if we feel that there is something to discuss.

Thoughts?

Amir.

