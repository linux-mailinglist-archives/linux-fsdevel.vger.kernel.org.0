Return-Path: <linux-fsdevel+bounces-49683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD96AC0FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 17:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E63189B5DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298B828FFCE;
	Thu, 22 May 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV/suoXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5828FABE;
	Thu, 22 May 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926802; cv=none; b=ken+ZEs36l7HbnMU6688R/wC4PItwTFDW9ruIYgvjLnnHA0ZhAle/d/is+MRnjxhQ6lRFYsn8R+UFXPuUdgbitmcaW3TTf3HmEGIos7q9aQoTE3rtikbge7vGZmA7sti30xoisfheQR8TzP+e6iJCoiWWpQ19ZJUnZ0kkXcAt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926802; c=relaxed/simple;
	bh=+Fdgk1qUC3rxR6AhCY5Vo20VRvmyxneBzAEdVhsu1VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTK/voDINQSSeU6EVlFQEDiogSpz5VSW62KflNMCUi2Irr7qlCQKIovw0BfiOIR+xlllRF4/cJPZcBm2xYA6lMUgY/74BDBZvBJ0/xKED6sPioC3sHv8f7hmPr24AQKNgmfT63q+zUjjV5TQJ8fajv50boWua0N8WcArWpFeROo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV/suoXl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad5297704aaso1354485966b.2;
        Thu, 22 May 2025 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747926799; x=1748531599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHzK0rav1aiTYoCujyOVtfBOZntyVntmfFzAKlovelQ=;
        b=lV/suoXlDuDtkt8zwjj9W7cnjsEiNSjMoeCaKmEf6j8bvvf6+lQpYu1joeMUJHSsaq
         JLzbZR4r0aeH1xzOFMHPcxRlKSe21fNNnyB+/FhRn0Pd2AEOBG5j/cR+kExa2hLxCjna
         O7l1PSpE4Ui3BCMTp2SC4Y7k5KRg8IuFPr/8mOMUkQ8azw7BSqqHLm0vpU3eee1lq+rF
         lunm9SRYFl8UgfZhf90Qir5acPzzxuHoESTGrAfE2vhYfnaoGVDupmcWvrZhSJLgBO0m
         9+XZK5H8ofnL+ctk7mwVCvB2OEH7sRC8v7QatiwUvAROxiMhk+4/DkLnYbdJeK7hxBOp
         dMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747926799; x=1748531599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHzK0rav1aiTYoCujyOVtfBOZntyVntmfFzAKlovelQ=;
        b=uErWRJoIScY/zXoZ29nL/A5uODBlRaRY6Y1GEBxMlll4EeclAyTGJYYoryF3TQuS7H
         8E3ylM1z/zn4Ii6ant2LdKmJco4YPkOjWLnU0x0wHodOz6j728ufHvP8ICNkP5yvGdAh
         E//1j+1A193k1LngAqrKhUuqTDRMZEtUmYXSKLm4CVURXEhUk5K49oMg9kjE7I/k5HO4
         1HUM542ETdmWuq8DBIOS5mSO2xu2dlEaXZYSVJMJEDjiKUhHyHcLxwF2EUXzGkyFColM
         TwwagYvTtFZcnsuRgmZMobpZm47rNnW1KA61/zTBsF2B7Rj1FcNp1tE6df4XSub0fXug
         mr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb/NY1IpkzoxoCh9SQS8bVkUD5X2v6hzCteccpjxZBt/s9dmJalkDsBQnFc5cUJhB8fjm+HGLTaHGkkViVAg==@vger.kernel.org, AJvYcCV1g0Q4/a4fs4mXWQmuMYEUgyzJeati3SVI0jghTSmnav6PVaVgmJJMW99cn5kiVI6BTu+t4RHXBhPQP6Z6@vger.kernel.org, AJvYcCVz4XzV4+ruhxpuArxyQCbG0/pSoEh7TlQ/+nNJcr0HYf+dsYxBI4vUMMZwdRVtaPtpD9ffFhPDwwgWOczs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nhBUJOza55UZHLe3DkonvVBPQqH3JTEaQpUOl4Gi8DUy2bsl
	smWhDu0Qc5+/ivOrKw9am1KdkksOVRY8FVsEhZflA2xtv6fqxTbXzGXUIdsH6BH7nk+d5S1seLy
	1H/hbB7d4HrabUSVnR7+Rd0sN+8dYiRs=
X-Gm-Gg: ASbGnctkyws9tsnnXooIUuEOCFDoj7eBLNAhSNoOKB3AGsetEEne1s8nwXxISS4Mfgd
	UUnHShRp3Gszxexb1Fr2zrsElOlP3CMcDMtoQNEHz5ZPRbTclCmatDFmnY9sjiItFRIeiNwAKsy
	YWVSyQe5/wsQ/Mo6iyhGOqXgvowMGHMuJq
X-Google-Smtp-Source: AGHT+IG0OQPvETxhP3cE5S4/lxvPmTFwWqv8i5EaVF5tDzbNKfLM/UQAUxPMFR8xjjsirkUbr0UwsVu9BqM5OZU97V4=
X-Received: by 2002:a17:907:7fac:b0:aca:c4a6:cd90 with SMTP id
 a640c23a62f3a-ad52d45accemr2412877566b.5.1747926798242; Thu, 22 May 2025
 08:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521-ovl_ro-v1-1-2350b1493d94@igalia.com> <CAOQ4uxgXP8WrgLvtR6ar+OncP6Fh0JLVO0+K+NtDX1tGa2TVxA@mail.gmail.com>
 <20250521-blusen-bequem-4857e2ce9155@brauner> <32f30f6d-e995-4f00-a8ec-31100a634a38@igalia.com>
 <CAOQ4uxg6RCJf6OBzKgaWbOKn3JhtgWhD6t=yOfufHuJ7jwxKmw@mail.gmail.com> <35eded72-c2a0-4bec-9b7f-a4e39f20030a@igalia.com>
In-Reply-To: <35eded72-c2a0-4bec-9b7f-a4e39f20030a@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 May 2025 17:13:06 +0200
X-Gm-Features: AX0GCFszZsE5XZrpt1_NuhS5Bmf_VZ7QtS0MUeu0yfTHj19lGEu-gx34Syx31Fw
Message-ID: <CAOQ4uxihs3ORNu7aVijO0_GUKbacA65Y6btcrhdL_A-rH0TkAA@mail.gmail.com>
Subject: Re: [PATCH] ovl: Allow mount options to be parsed on remount
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Karel Zak <kzak@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cc libfuse maintainer

On Thu, May 22, 2025 at 4:30=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 22/05/2025 06:52, Amir Goldstein escreveu:
> > On Thu, May 22, 2025 at 8:20=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:
> >>
> >> Hi Christian, Amir,
> >>
> >> Thanks for the feedback :)
> >>
> >> Em 21/05/2025 08:20, Christian Brauner escreveu:
> >>> On Wed, May 21, 2025 at 12:35:57PM +0200, Amir Goldstein wrote:
> >>>> On Wed, May 21, 2025 at 8:45=E2=80=AFAM Andr=C3=A9 Almeida <andrealm=
eid@igalia.com> wrote:
> >>>>>
> >>
> >> [...]
> >>
> >>>>
> >>>> I see the test generic/623 failure - this test needs to be fixed for=
 overlay
> >>>> or not run on overlayfs.
> >>>>
> >>>> I do not see those other 5 failures although before running the test=
 I did:
> >>>> export LIBMOUNT_FORCE_MOUNT2=3Dalways
> >>>>
> >>>> Not sure what I am doing differently.
> >>>>
> >>
> >> I have created a smaller reproducer for this, have a look:
> >>
> >>    mkdir -p ovl/lower ovl/upper ovl/merge ovl/work ovl/mnt
> >>    sudo mount -t overlay overlay -o lowerdir=3Dovl/lower,upperdir=3Dov=
l/
> >> upper,workdir=3Dovl/work ovl/mnt
> >>    sudo mount ovl/mnt -o remount,ro
> >>
> >
> > Why would you use this command?
> > Why would you want to re-specify the lower/upperdir when remounting ro?
> > And more specifically, fstests does not use this command in the tests
> > that you mention that they fail, so what am I missing?
> >
>
> I've added "set -x" to tests/generic/294 to see exactly which mount
> parameters were being used and I got this from the output:
>
> + _try_scratch_mount -o remount,ro
> + local mount_ret
> + '[' overlay =3D=3D overlay ']'
> + _overlay_scratch_mount -o remount,ro
> + echo '-o remount,ro'
> + grep -q remount
> + /usr/bin/mount /tmp/dir2/ovl-mnt -o remount,ro
> mount: /tmp/dir2/ovl-mnt: fsconfig() failed: ...
>
> So, from what I can see, fstests is using this command. Not sure if I
> did something wrong when setting up fstests.
>

No you are right, I misread your reproducer.
The problem is that my test machine has older libmount 2.38.1
without the new mount API.


> >> And this returns:
> >>
> >>    mount: /tmp/ovl/mnt: fsconfig() failed: overlay: No changes allowed=
 in
> >>    reconfigure.
> >>          dmesg(1) may have more information after failed mount system =
call.
> >>
> >> However, when I use mount like this:
> >>
> >>    sudo mount -t overlay overlay -o remount,ro ovl/mnt
> >>
> >> mount succeeds. Having a look at strace, I found out that the first
> >> mount command tries to set lowerdir to "ovl/lower" again, which will t=
o
> >> return -EINVAL from ovl_parse_param():
> >>
> >>      fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) =3D 4
> >>      fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "/tmp/ovl/lower", 0)=
 =3D
> >> -1 EINVAL (Invalid argument)
> >>
> >> Now, the second mount command sets just the "ro" flag, which will retu=
rn
> >> after vfs_parse_sb_flag(), before getting to ovl_parse_param():
> >>
> >>      fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) =3D 4
> >>      fsconfig(4, FSCONFIG_SET_FLAG, "ro", NULL, 0) =3D 0
> >>
> >> After applying my patch and running the first mount command again, we
> >> can set that this flag is set only after setting all the strings:
> >>
> >>      fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "/tmp/ovl/lower", 0)=
 =3D 0
> >>      fsconfig(4, FSCONFIG_SET_STRING, "upperdir", "/tmp/ovl/upper", 0)=
 =3D 0
> >>      fsconfig(4, FSCONFIG_SET_STRING, "workdir", "/tmp/ovl/work", 0) =
=3D 0
> >>      fsconfig(4, FSCONFIG_SET_STRING, "uuid", "on", 0) =3D 0
> >>      fsconfig(4, FSCONFIG_SET_FLAG, "ro", NULL, 0) =3D 0
> >>
> >> I understood that the patch that I proposed is wrong, and now I wonder
> >> if the kernel needs to be fixed at all, or if the bug is how mount is
> >> using fsconfig() in the first mount command?
> >

If you ask me, when a user does:
/usr/bin/mount /tmp/dir2/ovl-mnt -o remount,ro

The library only needs to do the FSCONFIG_SET_FLAG command and has no
business re-sending the other config commands, but that's just me.

BTW, which version of libmount (mount --version) are you using?
I think there were a few problematic versions when the new mount api
was first introduced.

Thanks,
Amir.

