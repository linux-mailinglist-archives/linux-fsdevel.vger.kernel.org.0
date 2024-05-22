Return-Path: <linux-fsdevel+bounces-19977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B68CBAA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEE72830D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63E55E53;
	Wed, 22 May 2024 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY3ss0tt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D346BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 05:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716355280; cv=none; b=ZK3atOGRM/lFM7t/HQeaAyFMIGGcPi2o/pCc44h7pmrYgIKVBUEuKBoA5SPgRpFvgY7I8tIE7K3H7zeJp6djwNO4gOa04ECdzfcjQus7gHE2oKYx1W/z87KPWqpraTzaGE2cBjzPqpgMYceRb2MYckKEqUjzyWlHdOyOaZCwHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716355280; c=relaxed/simple;
	bh=kukcvZgl7f3XRk6gkoIjN7Po872SObVN477KLfpuGW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqA+j6gAtMqWnjexcO0cMPczQHp5TyH6ncgA9SI3jOQdoABJgfDPsOdS+EJIKM/kmTSS5fpcTjRT25uAZJvf3PIQHktB6WJsHDBqYaOCspt0XIRlPf9bX52fkYZqIXnWrcHynuc150LbVAgWDEPDl4pC/Sp1Cz6r7+7IbtQqt6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY3ss0tt; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6a0ffaa079dso3963636d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 22:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716355277; x=1716960077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHqthuSHpbhdrYmPpGzlBssCJ4rO2VRux0c66MiPxEo=;
        b=gY3ss0ttIuMvu2huQqHZOIOsXphDm8lSDTWnOboF1FFvzJtoj4RSYr3cZw7aXgkzC+
         AFM+XFbeObOeaNHPCNaCu2PefGSS8jGlPADZpkX4M/lomX3zAuoGwD0Vf+/IOINbbn4F
         uOI/0VFRZy7ugoN/dZgY36NhdyzVT2PkQMfVz8gZbaQ882eboBG7IEhtM8MeH3iNcZWF
         +8ro2zRXV4Vn2VO7eYTJqq0gUCPVtKSK+TzEqRVdU0uxLWauTV0OL+FDQeLgaZspibXj
         OAeM9vGBAYFzZbc17tHL5qIu19qdFtQrx9zU+K/H2HhJZlR4vYcAZrSCSrdGa/31vuOJ
         BlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716355277; x=1716960077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHqthuSHpbhdrYmPpGzlBssCJ4rO2VRux0c66MiPxEo=;
        b=YPRyxPDX8HpvkOwkObdiPRmGUkHMMy4qZRrxpO2EAk2WdI71QWjrhLL6oUabeAXdNj
         e1m9ikTUzW6rqoiQVMpY/lGmFo0TJckVfVyQ2VyKQNX+0tO3aCo0kbHAAZmflmVdsuXn
         2dtz4I03MDF003mV40K89757AWooVnB5eVYYZujlmmOwSlToUjf0EU81gH51RPQ5fv31
         V5m+SaNA3VoXU8SogYqfm4tDW9p80Zsbd+YJKwY3KXXtk+IcQFz94TNVAum+fOJ+XrGq
         X5z7ZjXRevQE7Ao/YXt0GOfWmon/OGOmveS177SIhKB6K8xHMc7rjGkHfZuox9AExxRi
         e3Qg==
X-Gm-Message-State: AOJu0Yz2ESwFU5ImJ1/gbDoJwieGV3l7BczR2emEu0y7UOuJiWNgdZKn
	6FuvbzOaT0n1BVtLUd48B8y2pbGzfiFhlMIJXgjZO+Z286RKY2bYKVkd0fEO3rQnao2zcenDM/m
	994rhQsV4b6XNML2W2sQlgiDOgSWB0e0h
X-Google-Smtp-Source: AGHT+IG0Oyeq2vgBZYq1W7xnFere/8ellyDFiPVIgXqYW3EipHP6uPPGBxDeWEyYJzcJyLNc+L0be0rJoX7KY5umn+4=
X-Received: by 2002:a05:6214:4410:b0:6a0:6e42:601b with SMTP id
 6a1803df08f44-6ab7c8f6fd4mr17283496d6.8.1716355277516; Tue, 21 May 2024
 22:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSOpYs6Axo03bKGP1=zaJ9+f=boHvpmYj2GmQL1M3wUQnkyPw@mail.gmail.com>
 <CAOQ4uxjCaCJKOYrgY31+4=EiEVh3TZS2mAgSkNz746b-2Yh0Lw@mail.gmail.com>
 <CAPSOpYsZCw_HJhskzfe3L9OHBZHm0x=P0hDsiNuFB6Lz_huHzw@mail.gmail.com>
 <CAOQ4uxhM-KTafejKZOFmE9+REpYXqVcv_72d67qL-j6yHUriEw@mail.gmail.com> <CAPSOpYuroNYUpK1LSnmfwOqWdGg0dxO8WZE4oFzWowdodwTYGg@mail.gmail.com>
In-Reply-To: <CAPSOpYuroNYUpK1LSnmfwOqWdGg0dxO8WZE4oFzWowdodwTYGg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 May 2024 08:21:06 +0300
Message-ID: <CAOQ4uxgOmJjJT=mX96-AwWY_p9fHXtvNZFUcPgqggKgGtpsq9A@mail.gmail.com>
Subject: Re: fanotify and files being moved or deleted
To: Jonathan Gilbert <logic@deltaq.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 12:09=E2=80=AFAM Jonathan Gilbert <logic@deltaq.org=
> wrote:
>
> On Tue, May 21, 2024 at 12:13=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > Note that you will be combining the *current* directory path with the *=
past*
> > filename, so you may get a path that never existed in reality, but as y=
ou wrote
> > fanotify is not meant for keeping historical records of the filesystem
> > namespace.
>
> And, in practice, this is almost certainly an edge case, because the
> vast majority of user-driven activity will be on a time scale such
> that the directory path hasn't had a chance to change since the file
> event was generated, I think? It's more a, "You can't technically
> guarantee 100% consistency", than a, "You should expect consistency
> errors regularly," sort of thing?
>

I guess so, but I would not call this "consistency errors", because
fanotify does not claim to report a "consistent" state or a snapshot,
although it could be used to construct an "eventual consistent" state
by examining the information in the events.

- You should expect out of order events.
- You should expect that the object information in the event
   that is described with dfid+name+fid may not exist with the
   same description at the time that the event is reported.

> > > Are FAN_MOVED_FROM and FAN_MOVED_TO guaranteed to be emitted
> > > atomically, or is there a possibility they could be split up by other
> > > events? If so, could there be multiple overlapping
> > > FAN_MOVED_FROM/FAN_MOVED_TO pairs under the right circumstances??
> >
> > You are looking for FAN_RENAME, the new event that combines
> > information from FAN_MOVED_FROM/FAN_MOVED_TO.
>
> Ah, excellent, this is in fact exactly what I needed.
>
> > > One other thing I'm seeing is that in enumerating the mount table in
> > > order to mark things, I find multiple entries with the same fsid.
> > > These seem to be cases where an item _inside another mount_ has been
> > > used as the device for a mount. One example is /boot/grub, which is
> > > mounted from /boot/efi/grub, where /boot/efi is itself mounted from a
> > > physical device.
> >
> > Yes, this is called a bind mount, which can be generated using
> > mount --bind /boot/efi/grub /boot/grub
>
> Huh, okay. I did some reading about this, and it seems that regardless
> of the order in which things are done, quite simply it is always
> possible for the same underlying filesystem to be mounted in multiple
> places. When this happens, there's no way to tell which mount changes
> were made through, but also, it isn't relevant because the same change
> is visible through all such overlapping mounts simultaneously. So,
> depending on the exact semantics I need, I need to either decide which
> mount I'm going to pick as being the most meaningful for the event, or
> alternately figure out *all* of the mounts to which the event applies.
>
> > > When enumerating the mounts, both of these return the
> > > same fsid from fstatfs. There is at least one other with such a
> > > collision, though it does not appear in fstab. Both the root
> > > filesystem / and a filesystem mounted at
> > > /var/snap/firefox/common/host-unspell return the same fsid. Does this
> > > mean that there is simply a category of event that cannot be
> > > guaranteed to return the correct path, because the only identifying
> > > information, the fsid, isn't guaranteed to be unique? Or is there a
> > > way to resolve this?
> >
> > That depends on how you are setting up your watches.
> > Are you setting up FAN_MARK_FILESYSTEM watches on all
> > mounted filesystem?
>
> That is the intent, yep.
>
> > Note that not all filesystems support NFS export file handles,
> > so not all filesystem support being watched with FAN_REPORT_FID and
> > FAN_MARK_FILESYSTEM.
>
> Good to know. My initial use case for the code is on my own personal
> machine, which is a pretty much stock Ubuntu 24.04 LTS system with the
> default ZFS layout. In my testing thus far, it looks like the kinds of
> events I'm looking for are in fact captured.
>

It's good to know that someone is testing fanotify on ZFS ;-)

> > If, for example you care about reconstructing changing over certain
> > paths (e.g. /home), you can keep an open mount_fd of that path when you
> > start watching it and keep it in a hash table with fsid as the key
> > (that is how fsnotifywatch does it [1]) and then use that mount_fd when=
ever
> > you want to decode the path from a parent file handle.
>
> Yeah, my starting point for development was the fatrace source code
> which also does this.
>

Cool. I wasn't aware that fatrace has adopted FAN_REPORT_FID a long time
before I added support to inotify-tools :)


> > If /home is a bind mount from, say, /data/home/ and you are watching
> > both /home and /data, you will need to figure out that they are the sam=
e
> > underlying fs and use a mount_fd of /data.
>
> My current plan is to discard any mounts which specify a root that is
> a subpath of another mount, and in the case of multiple mounts of the
> same root, pick one to move forward with (with hints from
> configuration) and only mark that one.
>

You can also use open_by_handle() to determine if one mount
is a subtree of another.

if you have two fds and two different fhandles from the root of two mounts
of the same fsid, only one of these commands will result in an fd with
non empty path:
fd2inmount1 =3D open_by_handle_at(mount1_fd, fhandle2, O_PATH);
fd1inmount2 =3D open_by_handle_at(mount2_fd, fhandle1, O_PATH);

So you can throw away subtree mounts of the same fsid keeping
only one mount_fd per fsid as you traverse the mounts.

> This is starting to feel like all the bits are coming together. Thanks
> so much for your insight and input :-)
>

You're welcome.

Thanks,
Amir.

