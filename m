Return-Path: <linux-fsdevel+bounces-19941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D828CB518
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 23:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59681F22791
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA73414A086;
	Tue, 21 May 2024 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deltaq.org header.i=@deltaq.org header.b="YWc+iTmK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B448149E05
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325763; cv=none; b=jFdCKvdgbn90Iop0AsG0Ki5RCeMA8l9DWzkDzjqn3f+8TtJkWsOa1hf7M5i2qDOCUAxcCoTvvWmGkJxEnw9QUivN3KyETI1NvzsOEisZuK1pFKd5zlvmU0qWLrU2qSSWu3azwLGEGIiHGBG9Wd7lk26EM7Z9ArbyC995MYs+d6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325763; c=relaxed/simple;
	bh=1aeP51VmrF3E9F20xStb4hxwESgvfrcxIjoulLxg6os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMkEP/IoV8UeC7mOYy1ITsFL394YyOejeacQT+SUll9XyQrgqU7HDpf6ZltpuY5ZensSowLvWkfXGIphSgdbx3pfxWeTeU7M5XPL1je4edSvnfz/D+/wGoMere5A6hbR5QuncQqRQhJdhddU7mkzDjAxHCYlxOIHnZo+wnDlBQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deltaq.org; spf=pass smtp.mailfrom=deltaq.org; dkim=pass (1024-bit key) header.d=deltaq.org header.i=@deltaq.org header.b=YWc+iTmK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deltaq.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltaq.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a599c55055dso882646066b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq; t=1716325758; x=1716930558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aeP51VmrF3E9F20xStb4hxwESgvfrcxIjoulLxg6os=;
        b=YWc+iTmKcfDO7U2qYA6NzsgeFRMAN6MCNSv/PZFf0z7SKDyP1A5Dgkvrs8Lep/nLs6
         8cfZc8gMzcAakObOvxzAXf5QZtFERG//mX1HcqmOjtXIyyuJZ7oLtbrDZ12vUGW3eCz9
         6XjTA4wRn7DhMhbUOveGTN4iLAmvoWWwk6fcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716325758; x=1716930558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aeP51VmrF3E9F20xStb4hxwESgvfrcxIjoulLxg6os=;
        b=TbevAHo0PWh3QtqBtsICEAF9UF1sOoEW6nffE5aRjUQFTXBqdTghwNl9jhFnD93c7j
         xJDHvmSmZAr133pEiQxjE3Ml4NQGHHwwzQnOXvCtOODDS+Ydjy2wRoUkchs4vf0SnoHY
         stNPkYQYkiG4pUkU8Pw4CIESWb2mU9t6u2qbbKqH/M7X2NFYnOOAmHBdj7+ruqYML3Lw
         TfWLSf3nDUqXfIQ9PGTpbCfnFZ4/W2y9d/ksS3Bc0xStr0G9BkKPNedbmXLs6J+z6rk6
         PVD33MV37kRxcv0hFWmPReN+JdSr7HMEvznRpZ0I5PYAGKNvE+Pgkpb1CXUrHyJnvmbM
         1t/w==
X-Gm-Message-State: AOJu0Yw/jSAj2UJi3khCW84e+X4h7aEQqZ4JfaW9MTvX7gTcdq+wUth9
	N7oUESIf1VNlq7bqZ9Nb2epHzahZ/KktA/4v1RKOoCY7zYBj79WX5Np8MswM//4grFQ+gBZ4ja4
	+VhSFz+Qt7wzyJX2wL0jI6T7EgFDqhIPROV9NlHaJdGgCwfB9WU8zXQ==
X-Google-Smtp-Source: AGHT+IE2JT8OKGI2ykRffqy37lXM/rimtcJJjpDjCDOdavleBTJkcUGoAeTQBkFYhAKkWX3xnomWsYeEih2I8WtFnps=
X-Received: by 2002:a17:906:180b:b0:a61:54c3:9f8a with SMTP id
 a640c23a62f3a-a622806bbbemr961766b.7.1716325758074; Tue, 21 May 2024 14:09:18
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSOpYs6Axo03bKGP1=zaJ9+f=boHvpmYj2GmQL1M3wUQnkyPw@mail.gmail.com>
 <CAOQ4uxjCaCJKOYrgY31+4=EiEVh3TZS2mAgSkNz746b-2Yh0Lw@mail.gmail.com>
 <CAPSOpYsZCw_HJhskzfe3L9OHBZHm0x=P0hDsiNuFB6Lz_huHzw@mail.gmail.com> <CAOQ4uxhM-KTafejKZOFmE9+REpYXqVcv_72d67qL-j6yHUriEw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhM-KTafejKZOFmE9+REpYXqVcv_72d67qL-j6yHUriEw@mail.gmail.com>
From: Jonathan Gilbert <logic@deltaq.org>
Date: Tue, 21 May 2024 16:09:01 -0500
Message-ID: <CAPSOpYuroNYUpK1LSnmfwOqWdGg0dxO8WZE4oFzWowdodwTYGg@mail.gmail.com>
Subject: Re: fanotify and files being moved or deleted
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 12:13=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> Note that you will be combining the *current* directory path with the *pa=
st*
> filename, so you may get a path that never existed in reality, but as you=
 wrote
> fanotify is not meant for keeping historical records of the filesystem
> namespace.

And, in practice, this is almost certainly an edge case, because the
vast majority of user-driven activity will be on a time scale such
that the directory path hasn't had a chance to change since the file
event was generated, I think? It's more a, "You can't technically
guarantee 100% consistency", than a, "You should expect consistency
errors regularly," sort of thing?

> > Are FAN_MOVED_FROM and FAN_MOVED_TO guaranteed to be emitted
> > atomically, or is there a possibility they could be split up by other
> > events? If so, could there be multiple overlapping
> > FAN_MOVED_FROM/FAN_MOVED_TO pairs under the right circumstances??
>
> You are looking for FAN_RENAME, the new event that combines
> information from FAN_MOVED_FROM/FAN_MOVED_TO.

Ah, excellent, this is in fact exactly what I needed.

> > One other thing I'm seeing is that in enumerating the mount table in
> > order to mark things, I find multiple entries with the same fsid.
> > These seem to be cases where an item _inside another mount_ has been
> > used as the device for a mount. One example is /boot/grub, which is
> > mounted from /boot/efi/grub, where /boot/efi is itself mounted from a
> > physical device.
>
> Yes, this is called a bind mount, which can be generated using
> mount --bind /boot/efi/grub /boot/grub

Huh, okay. I did some reading about this, and it seems that regardless
of the order in which things are done, quite simply it is always
possible for the same underlying filesystem to be mounted in multiple
places. When this happens, there's no way to tell which mount changes
were made through, but also, it isn't relevant because the same change
is visible through all such overlapping mounts simultaneously. So,
depending on the exact semantics I need, I need to either decide which
mount I'm going to pick as being the most meaningful for the event, or
alternately figure out *all* of the mounts to which the event applies.

> > When enumerating the mounts, both of these return the
> > same fsid from fstatfs. There is at least one other with such a
> > collision, though it does not appear in fstab. Both the root
> > filesystem / and a filesystem mounted at
> > /var/snap/firefox/common/host-unspell return the same fsid. Does this
> > mean that there is simply a category of event that cannot be
> > guaranteed to return the correct path, because the only identifying
> > information, the fsid, isn't guaranteed to be unique? Or is there a
> > way to resolve this?
>
> That depends on how you are setting up your watches.
> Are you setting up FAN_MARK_FILESYSTEM watches on all
> mounted filesystem?

That is the intent, yep.

> Note that not all filesystems support NFS export file handles,
> so not all filesystem support being watched with FAN_REPORT_FID and
> FAN_MARK_FILESYSTEM.

Good to know. My initial use case for the code is on my own personal
machine, which is a pretty much stock Ubuntu 24.04 LTS system with the
default ZFS layout. In my testing thus far, it looks like the kinds of
events I'm looking for are in fact captured.

> If, for example you care about reconstructing changing over certain
> paths (e.g. /home), you can keep an open mount_fd of that path when you
> start watching it and keep it in a hash table with fsid as the key
> (that is how fsnotifywatch does it [1]) and then use that mount_fd whenev=
er
> you want to decode the path from a parent file handle.

Yeah, my starting point for development was the fatrace source code
which also does this.

> If /home is a bind mount from, say, /data/home/ and you are watching
> both /home and /data, you will need to figure out that they are the same
> underlying fs and use a mount_fd of /data.

My current plan is to discard any mounts which specify a root that is
a subpath of another mount, and in the case of multiple mounts of the
same root, pick one to move forward with (with hints from
configuration) and only mark that one.

This is starting to feel like all the bits are coming together. Thanks
so much for your insight and input :-)

Jonathan

