Return-Path: <linux-fsdevel+bounces-19912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172788CB1DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B4C1C2202D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BE01BF37;
	Tue, 21 May 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deltaq.org header.i=@deltaq.org header.b="IOOpDAay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2E17BB5
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307443; cv=none; b=LWBkFMNAffR1qxXCvVSPfb/pvnkAJXjqtL14P7W1vpBk8gUKN9XWZONxYEWnNOiqSRR2fwmytZw4AeEJR+MG+FYbYOmY9Qc6FzkJNF9rYnJW3l0JGZSho/C8Hl9e86S+59h5aAM3jSuftzpYWCrfOfZjPPaeNG8jxQqejvYWGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307443; c=relaxed/simple;
	bh=PiO4piuZ8WM1XFgbVNVEn0WUAY5AbEIxNnZT9JE1Dqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Fmuod+zgEFoqWgYmDgM0pir/5pUq9bLBxHykL17v5OcxmG4+X4yx0YCQu2orl1yvb8yddugdAUKINT8EWAf8m4oXYNx/Dz7IM8iQ00x2VXDuxjQifHjyp9v0mvLulMYCsYH+KSBuVKEVjJ5CKe9alDMuHmvzV1PcIXm7RX6F5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deltaq.org; spf=pass smtp.mailfrom=deltaq.org; dkim=pass (1024-bit key) header.d=deltaq.org header.i=@deltaq.org header.b=IOOpDAay; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deltaq.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltaq.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso846166566b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq; t=1716307439; x=1716912239; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiO4piuZ8WM1XFgbVNVEn0WUAY5AbEIxNnZT9JE1Dqw=;
        b=IOOpDAayG2laoib/oMkRatgDbpT2N4dWTawzxdv2oxvE7xU5l3joy21G1SMqLcAsbG
         AjhV/j6pIImimDiZkr0uWEywPSJpf8fMwyEvVISdvEqLRQijX1lzlMMUKoxCCL4aD1cd
         LNKDLM9b/TUCUXRI1gN4ZvN4U1JjxadlqGCBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716307439; x=1716912239;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiO4piuZ8WM1XFgbVNVEn0WUAY5AbEIxNnZT9JE1Dqw=;
        b=SNoXpR3le5ybED2/ORWb/mjmNuv5OVu4cACeC6WWDWdCn61AQy3ImGv3dfdRaowvsV
         bnXR3CgCQ/vDuvD4uHUtmLPUmRPqKMPuGaA8yC6LgNvWLNzwJdvt7dY8GzzTRaJDt/J6
         1j+qkHHzjKrFjz6lLJB5IsAlnBT/ynn+tfxOQET33XjrHKMaWeBBnMRbk6y8/HHRkyVz
         REI2iSHxd0GO26LgFvUNb/tWD8LK5rdpNy93Xqr39kUbEC4z3FjPZ5V20wWN9xamXvzX
         MZxo+i9/c1Xh6nI6Mxzyz0iHA+L/Hfl23ff0joEyOEQ8zapR+mTv3+X2xeF6mopa9rFS
         p23w==
X-Gm-Message-State: AOJu0YyuK5XzFk8HXpgvdJkmRKx0FhQ4OG6XvRg8UUlqC9IxJfGagIFQ
	7TPG4g3cDuKB47d7YIb3vTE5x2esRDoiDKkYEeOeteUmT+MkQWfEFAPAeSU9n4loIk6Y55kicGV
	F4v5GoOE4w4taaG3CNSWsyXx/DTx6dHwCXuMmVrIlEgYh7KEDMHZiaQ==
X-Google-Smtp-Source: AGHT+IHsNHg21ImQa03KFoFyXT64KVn9v6I0YXd2SjgNkVaFDrPOgImJ8AHGS0NnxlpdoQuNM2Zc8fZ8E1psZ8koLjc=
X-Received: by 2002:a17:906:66ca:b0:a59:c2c3:bb4c with SMTP id
 a640c23a62f3a-a5a2d675a9dmr2746587666b.70.1716307438701; Tue, 21 May 2024
 09:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSOpYs6Axo03bKGP1=zaJ9+f=boHvpmYj2GmQL1M3wUQnkyPw@mail.gmail.com>
 <CAOQ4uxjCaCJKOYrgY31+4=EiEVh3TZS2mAgSkNz746b-2Yh0Lw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjCaCJKOYrgY31+4=EiEVh3TZS2mAgSkNz746b-2Yh0Lw@mail.gmail.com>
From: Jonathan Gilbert <logic@deltaq.org>
Date: Tue, 21 May 2024 11:03:42 -0500
Message-ID: <CAPSOpYsZCw_HJhskzfe3L9OHBZHm0x=P0hDsiNuFB6Lz_huHzw@mail.gmail.com>
Subject: Re: fanotify and files being moved or deleted
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm, okay. In earlier testing, I must have had a bug because I wasn't
seeing filenames for FAN_MOVE or FAN_DELETE. But, my code is more
robust now, and when I switch it to those events I do see filenames --
but not paths. Looks like I can do the open_by_handle_at trick on the
fd in the main FAN_MOVED_FROM, FAN_MOVED_TO and FAN_DELETE event and
that'll give me the directory path and then I can combine it with the
file name in the info structure?

Are FAN_MOVED_FROM and FAN_MOVED_TO guaranteed to be emitted
atomically, or is there a possibility they could be split up by other
events? If so, could there be multiple overlapping
FAN_MOVED_FROM/FAN_MOVED_TO pairs under the right circumstances??

One other thing I'm seeing is that in enumerating the mount table in
order to mark things, I find multiple entries with the same fsid.
These seem to be cases where an item _inside another mount_ has been
used as the device for a mount. One example is /boot/grub, which is
mounted from /boot/efi/grub, where /boot/efi is itself mounted from a
physical device. When enumerating the mounts, both of these return the
same fsid from fstatfs. There is at least one other with such a
collision, though it does not appear in fstab. Both the root
filesystem / and a filesystem mounted at
/var/snap/firefox/common/host-unspell return the same fsid. Does this
mean that there is simply a category of event that cannot be
guaranteed to return the correct path, because the only identifying
information, the fsid, isn't guaranteed to be unique? Or is there a
way to resolve this?

Thanks,

Jonathan Gilbert

On Mon, May 20, 2024 at 10:58=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Tue, May 21, 2024 at 4:04=E2=80=AFAM Jonathan Gilbert <logic@deltaq.or=
g> wrote:
> >
> > Hello :-)
> >
> > I want to use fanotify to construct a best-effort log of changes to
> > the filesystem over time. It would be super useful if events like
> > FAN_MOVE_SELF and FAN_DELETE_SELF could report the path that the file
> > _was_ at just prior to the event. Reporting an FID value is of limited
> > use, because even if it still exists, looking up the name (e.g. by
> > open_by_handle_at, the way fatrace does) will only reveal the new name
> > after a FAN_MOVE_SELF -- and after a FAN_DELETE_SELF, the file no
> > longer has any path!
> >
> > I understand that in terms of a strictly accurate reconstruction of
> > changes over time, fanotify events are of limited use, because they
> > aren't guaranteed to be ordered and from what I have read it seems it
> > is possible for some changes to "slip through" from time to time. But,
> > this is not a problem for my use case.
> >
> > I have no idea what things are available where in the kernel code that
> > generates these events, but in the course of writing the code that
> > reads the event data that gets sent to an fanotify fd, I was thinking
> > that the simplest way to achieve this would be for FAN_MOVE_SELF and
> > FAN_DELETE_SELF events to have associated info structures with paths
> > in them. FAN_DELETE_SELF could provide an info structure with the path
> > that just got unlinked, and FAN_MOVE_SELF could provide two info
> > structures, one for the old path and one for the new.
> >
> > Of course, it is possible that this information isn't currently
> > available at the spot where the events are being generated!
>
> This statement is correct for FAN_DELETE_SELF.
>
> >
> > But, this would be immensely useful to my use case. Any possibility?
> >
>
> FAN_DELETE emitted for every unlink() has the unlinked file name -
> a file can have many names (i.e. hardlinks) will almost always come
> before the final FAN_DELETE_SELF, which is emitted only when st_nlink
> drops to zero.and last file reference is closed.
>
> I say almost always, because moving over a file, can also unlink it,
> so either FAN_DELETE or FAN_RENAME should be observed
> before FAN_DELETE_SELF and those should be enough for your
> purpose.
>
> FAN_MOVE_SELF could in theory have info about source and target
> file names, same as FAN_RENAME because it is being generated
> within the exact same fsnotify_move() hook, but that's the reason
> that FAN_RENAME is enough for your purpose.
>
> FAN_MOVE_SELF intentionally does not carry this information
> so that watchers of FAN_MOVE_SELF could get all the move events
> merged and get a single move event with the FID after a series of
> many renames.
>
> Thanks,
> Amir.

