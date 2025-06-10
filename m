Return-Path: <linux-fsdevel+bounces-51176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6AAD3D61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 17:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A9E1700BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A94244667;
	Tue, 10 Jun 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0u+b6vS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B68238157
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569164; cv=none; b=YHvCEOHX84KVVGsyWLMrMUYBSwXw9N78GGnBxRAJWEEYqcM9v5a8KG+4JKqmSS1XrqYSEz0NtqxKSukob+0AdYJYdi8je6AKNRYBtVvQbh/7MJsluHuV3dUWv+7hhuugJsati6nHkcMa3O08MXDgaQYmP0YvDQX1KKU5o/AaifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569164; c=relaxed/simple;
	bh=iLu+kkeQqixnz4JKdnfpu70RrgbXIUt2SA3LZXoNvCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNwc+LoZhGqEwqzhtLOf1NukKYSJQjuxDSRBHREOdat5ofjh0cd+YA77Ie0LsrTjryrmjRx5No23Vp8XjL8/D2IhVdq7I2Q4aJKu3C69UOqBVZC/c56hMqCNrj4IAb/dWTQv8QLAey58lI9SFOWd6rj35BmQgPFzwxaY76Q3jFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0u+b6vS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acbb85ce788so924751266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749569160; x=1750173960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6ntSLzzkgDcKiYD+pdoSgRnvQrKh+X3UPoOJZiFgNQ=;
        b=f0u+b6vS0Nnx0GZGo3bNankvCQZTmOXn6lYYSJSbEKCoOc9UgYdVHCMucOri4IYkVq
         CNFb7f+UIdIeE09GQQmEhe+Tlk9a5sakwqLxJpdt54Olz3jso03KKkYMg71r3hBe2WIq
         fgK2IyKmoLIg9TcMKj/rpnXH/NHf+Q2DGC7cmKNi0+gOmtXjQQBRPRHHtlCBKbAWZp5j
         CafD375nkfX+cFkbf52QJw5POwu9sq5ud5PVTNcOIYkd6rrxQVAd67fH1YUxKwaQv8g0
         AL3DaE4nUxRA3/u9N3K5ApbYLFezA7RnCxJlUGXV+pNOiitmclkMZFvOCmUXVXrrCJgF
         89cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749569160; x=1750173960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6ntSLzzkgDcKiYD+pdoSgRnvQrKh+X3UPoOJZiFgNQ=;
        b=BHExREEPjq0spR5VGhJNn86g5S79ZPBw/aouZGW5WBZFYTSwR/W/YYPWMHD0qNA9Dn
         KGTfe5l8zUkrrS7JZQmvYiaXX9xe3xiE+QMgiNjGE5D8ATgeXJpBhzTzC8bKnPhS0X2/
         HNTkkJeb4WTjTycopUgv9ww9QeljOlM4A1eRlPs+TbczqjBr3Ho9ZLLJEe5ylxFvoRn9
         JCRycli539qwUGT0s73rNvehDxf2R5T6dWfF4fiqu+PL/tSagmfjKyHheXW4ZMnMGuwH
         nt7Aqc7kZ1cMCyjjmKeXbcKI43fF4dCP2afq89yEE31vFiC2fknX8QYeNUe39DexcNWa
         Y2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVVFnt/WjK0ckUVLxdt+RhC4Fk5B3jwgtL9mBOZ4VYW/fVoC2qawrKkbESpwUO7Mx3Fpfxu1ks1k1lw0S4o@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfkh4f2Jiy5XowXgWC7Hm7oN9uwGKJ2S9l5UUovm1lhKwAyyRs
	2TfZ7fx26HBNvXdqUWRgVmIZYqMI1Jb57+OEstbTbaypRDzCUeCcFrlpuPVNj6+WreWdwpNntYB
	VKEG7xByGsPmv+LUlmtsnOwQkxJV8BmE=
X-Gm-Gg: ASbGncsLSEbycHbiEimdihBVRaQZXXMVCTq9rRw9tBjOazASAcwXiyQCtfHmSP9aHbp
	fgC0fU4EJEb891KjDBT4KbeDWV7kUgyOXO+UzJGf+TopqQzDCXYzcNWpXfZ1N5PT03nkOV1UFa3
	5f7LHPApGDdfiai5nwYzualp3Ku9TvYsIx3aU1KTJXaX8=
X-Google-Smtp-Source: AGHT+IGRIG8NIP0MeV4UVGTzTJ/1Cjuu/fhf55nBqJSEMwFxWqhgag6b6SfSBmjBaCIGSxYiY7cOaZ9ILonOoL1oyjE=
X-Received: by 2002:a17:906:6a03:b0:ace:d710:a8d1 with SMTP id
 a640c23a62f3a-ade7ac756e4mr288338866b.24.1749569159675; Tue, 10 Jun 2025
 08:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604160918.2170961-1-amir73il@gmail.com> <e2rcmelzasy6q4vgggukdjb2s2qkczcgapknmnjb33advglc6y@jvi3haw7irxy>
In-Reply-To: <e2rcmelzasy6q4vgggukdjb2s2qkczcgapknmnjb33advglc6y@jvi3haw7irxy>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 10 Jun 2025 17:25:48 +0200
X-Gm-Features: AX0GCFuoAGzGVEa4pw80frVW6k5in0KClsoyidxtcGF_-dcTQXIuHj8g9NA-bfg
Message-ID: <CAOQ4uxg1k7DZazPDRuRfhnHmps_Oc8mmb1cy55eH-gzB9zwyjw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 3:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>

Hi Jan!

Thanks for taking the time to read my long email ;)

> On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> > In v1 there was only patch 1 [1] to allow FAN_PRE_ACCESS events
> > on readdir (with FAN_ONDIR).
> >
> > Following your feedback on v1, v2 adds support for FAN_PATH_ACCESS
> > event so that a non-populated directory could be populted either on
> > first readdir or on first lookup.
>
> OK, it's good that now we have a bit more wider context for the discussio=
n
> :). First, when reading this I've started wondering whether we need both
> FAN_PRE_ACCESS on directories and FAN_PATH_ACCESS (only on directories).
> Firstly, I don't love adding more use to the FAN_ONDIR flag when creating
> marks because you can only specify you want FAN_PRE_ACCESS on files,
> FAN_PRE_ACCESS on files & dirs but there's no way to tell you care only
> about FAN_PRE_ACCESS on dirs. You have to filter that when receiving
> events. Secondly, the distinction between FAN_PRE_ACCESS and
> FAN_PATH_ACCESS is somewhat weak - it's kind of similar to the situation
> with regular files when we notify about access to the whole file vs only =
to
> a specific range.  So what if we had an event like FAN_PRE_DIR_ACCESS tha=
t
> would report looked up name on lookup and nothing on readdir meaning you
> need to fetch everything?
>

This makes a lot of  sense to me. and I also like the suggested event name.
Another advantage is that FAN_PRE_ACCESS can always expect a range
(as documented)

> > I am still tagging this as RFC for two semi-related reasons:
> >
> > 1) In my original draft of man-page for FAN_PATH_ACCESS [2],
> > I had introduced a new class FAN_CLASS_PRE_PATH, which FAN_PATH_ACCESS
> > requires and is defined as:
> > "Unlike FAN_CLASS_PRE_CONTENT, this class can be used along with
> >  FAN_REPORT_DFID_NAME to report the names of the looked up files along
> >  with O_PATH file descriptos in the new path lookup events."
> >
> > I am not sure if we really need FAN_CLASS_PRE_PATH, so wanted to ask
> > your opinion.
> >
> > The basic HSM (as implemented in my POC) does not need to get the looku=
p
> > name in the event - it populates dir on first readdir or lookup access.
> > So I think that support for (FAN_CLASS_PRE_CONTENT | FAN_REPORT_DFID_NA=
ME)
> > could be added later per demand.
>
> The question here is what a real user is going to do? I know Meta guys
> don't care about directory events for their usecase. You seem to care abo=
ut
> them so I presume you have some production use in mind?

Yes we have had it in production for a long time -
You can instantaneously create a lazy clone of the entire "cloud fs" locall=
y.
Directories get populated with sparse files on first access.
Sparse files get populated with data on first IO access.
It is essentially the same use case as Meta and many other similar users.
The need for directory populate is just a question of scale -
How much does it take to create a "metadata clone" or the remote fs copy
and create all the sparse files.
At some point, it becomes too heavy to not do it lazily.

> How's that going to
> work? Because if I should guess I'd think that someone asks for the name
> being looked up sooner rather than later because for large dirs not havin=
g
> to fetch everything on lookup would be a noticeable win...

Populating a single sparse file on lookup would be a large win, but also pr=
etty
hard to implement this "partially populated dir" state correctly. For
that reason,
We have not implemented this so far, but one can imagine (as you wrote) tha=
t
someone else may want to make use of that in the future.

> And if that's
> the case then IMHO we should design (but not necessarily fully implement)
> API that's the simplest and most logical when this is added.
>
> This ties to the discussion how the FAN_PATH_ACCESS / FAN_PRE_DIR_ACCESS
> event is going to report the name.
>

Absolutely. The FAN_PRE_DIR_ACCESS should support reporting name info
in the future. Naturally, this could be an opt-in with FAN_REPORT_NAME,
because for most implementations (like ours) the name will not be needed.

I do not see an immediate reason to implement FAN_REPORT_NAME from
the start, but OTOH, if we do want to implement FAN_REPORT_DIR_FID from
the start, implementing FAN_REPORT_NAME would be a no-brainer.

> > 2) Current code does not generate FAN_PRE_ACCESS from vfs internal
> > lookup helpers such as  lookup_one*() helpers from overalyfs and nfsd.
> > This is related to the API of reporting an O_PATH event->fd for
> > FAN_PATH_ACCESS event, which requires a mount.
>
> AFAIU this means that you could not NFS export a filesystem that is HSM
> managed and you could not use HSM managed filesystem to compose overlayfs=
.
> I don't find either of those a critical feature but OTOH it would be nice
> if the API didn't restrict us from somehow implementing this in the futur=
e.
>

Right.
There are a few ways to address this.
FAN_REPORT_DFID_NAME is one of them.

Actually, the two cases, overlayfs and nfsd are different
in the aspect that the overlayfs layer uses a private mount clone
while nfsd actually exports a specific user visible mount.
So at least in theory nfsd could report lookup events with a path
as demonstrated with commit from my WIP FAN_PRE_MODIFY patches
https://github.com/amir73il/linux/commit/4a8b6401e64d8dbe0721e5aaa496f0ad59=
208560

Another way is to say that event->fd does not need to indicate the
mount where the event happened.
Especially if event->fd is O_PATH fd, then it could simply refer to a
directory dentry using some arbitrary mount that the listener has access to=
.
For example, we can allow an opt-in flag to say that the listener keeps
an O_PATH fd for the path provided in fanotify_mark() (i.e. for an sb mark)
and let fanotify report event->fd based on the listener's mount regardless
of the event generator's mount.

There is no real concern about the listener keeping the fs mount busy becau=
se:
1. lsof will show this reference to the mount
2. A proper listener with FAN_REPORT_DFID_NAME has to keep open
   mount_fd mapped to fsid anyway to be able to repose paths from events
   (for example: fsnotifywatch implementation in inotify-tools)

Then functionally, FAN_REPORT_DIR_FID and FAN_REPORT_DIR_FD
would be similar, except that the latter keeps a reference to the object wh=
ile
in the event queue and the former does not.

> > If we decide that we want to support FAN_PATH_ACCESS from all the
> > path-less lookup_one*() helpers, then we need to support reporting
> > FAN_PATH_ACCESS event with directory fid.
> >
> > If we allow FAN_PATH_ACCESS event from path-less vfs helpers, we still
> > have to allow setting FAN_PATH_ACCESS in a mount mark/ignore mask, beca=
use
> > we need to provide a way for HSM to opt-out of FAN_PATH_ACCESS events
> > on its "work" mount - the path via which directories are populated.
> >
> > There may be a middle ground:
> > - Pass optional path arg to __lookup_slow() (i.e. from walk_component()=
)
> > - Move fsnotify hook into __lookup_slow()
> > - fsnotify_lookup_perm() passes optional path data to fsnotify()
> > - fanotify_handle_event() returns -EPERM for FAN_PATH_ACCESS without
> >   path data
> >
> > This way, if HSM is enabled on an sb and not ignored on specific dir
> > after it was populated, path lookup from syscall will trigger
> > FAN_PATH_ACCESS events and overalyfs/nfsd will fail to lookup inside
> > non-populated directories.
>
> OK, but how will this manifest from the user POV? If we have say nfs
> exported filesystem that is HSM managed then there would have to be some
> knowledge in nfsd to know how to access needed files so that HSM can pull
> them? I guess I'm missing the advantage of this middle-ground solution...
>

The advantage is that an admin is able to set up a "lazy populated fs"
with the guarantee that:
1. Non-populated objects can never be accessed
2. If the remote fetch service is up and the objects are accessed
    from a supported path (i.e. not overlayfs layer) then the objects
    will be populated on access

This is stronger and more useful than silently serving invalid content IMO.

This is related to the discussion about persistent marks and how to protect
against access to non-populated objects while service is down, but since
we have at least one case that can result in an EIO error (service down)
then another case (access from overlayfs) maybe is not a game changer(?)

> > Supporting populate events from overalyfs/nfsd could be implemented
> > later per demand by reporting directory fid instead of O_PATH fd.
> >
> > If you think that is worth checking, I can prepare a patch for the abov=
e
> > so we can expose it to performance regression bots.
> >
> > Better yet, if you have no issues with the implementation in this
> > patch set, maybe let it soak in for_next/for_testing as is to make
> > sure that it does not already introduce any performance regressions.
> >
> > Thoughts?
>
> If I should summarize the API situation: If we ever want to support HSM +
> NFS export / overlayfs, we must implement support for pre-content events
> with FID (DFID + name to be precise).

Yes, but there may be alternatives to FID.

> If we want to support HSM events on
> lookup with looked up name, we don't have to go for full DFID + name but =
we
> must at least add additional info with the name to the event.

Yes, reporting name is really a feature that could be opt-in.
And if we report name, it is no effort to also report FID,
regardless if we also report event->fd or not.

> Also if we go
> for reporting directory pre-content events with standard events, you want
> to add support for returning O_PATH fds for better efficiency and the cod=
e
> to handle FMODE_NONOTIFY directory fds in path lookup.
>

Yes. technically, O_PATH fd itself could be used to perform the populate of
dir in a kin way to event->fd being used to populate a file, so it is
elegant IMO.

> Frankly seeing all this I think that going for DFID + name events for
> directory HSM events from the start may be the cleanest choice long term
> because then we'll have one way how to access the directory HSM
> functionality with possibility of extensions without having to add
> different APIs for it.

I see the appeal in that.
I definitely considered that when we planned the API
just wanted to consult with you before going forward with implementation.

> We'd just have to implement replying to FID events
> because we won't have fd to identify event we reply to so that will need
> some thought.

I keep forgetting about that :-D

My suggestion for FAN_REPORT_DIR_FD could work around this
problem ellegantly.

>
> What are your thoughts? Am I missing something?
>

My thoughts are that FAN_REPORT_DIR_FD and
FAN_REPORT_DFID_NAME may both be valid solutions and
they are not even conflicting.
In fact, there is no clear reason to deny mixing them together.

If you do not have any objection to the FAN_REPORT_DIR_FD
solution, then we need to decide if we want to do them both?
one at a time? both from the start?

My gut feeling is that FAN_REPORT_DIR_FD is going to be
more easy to implement and to users to use for first version
and then whether or not we need to extend to report name
we can deal with later.

WDYT?

Thanks,
Amir.

