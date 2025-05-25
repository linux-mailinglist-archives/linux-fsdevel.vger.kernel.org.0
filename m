Return-Path: <linux-fsdevel+bounces-49817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7858AC33E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 12:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823623B24D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4C1F03EF;
	Sun, 25 May 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTcMnnIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD91EB3D;
	Sun, 25 May 2025 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748169562; cv=none; b=ryjnpB0TLBD75s+tFyCZcHukZb+E5XhvLizdY+vRVxeOJTfXdtwVLXS2fwyTyPl3rO6HF3BQOTizQqjkCkuKQArk5VdWxIwESCGO7AJkL52/vrC2h/n9RnrZWXsOppCPzAycSILwyZjwmUZRsCDdYjNJ3mh8sVI7660oeu55f8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748169562; c=relaxed/simple;
	bh=6ZObJ8+YGW2RmH7FaUiFSizkwsCGsWLpOMZ7FF91iAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIkNEc184Yslb3A+zcwAs8vx9JKuFdxVpXW0AUQm7wl095YEFQ3PEQdUYRu8EKgTko+kkm+YcxAXqcnM6GNcRSckfaKzuiFAOXBEjTrJuETVS595BPAZPPIzVIpzzbFt/cDfEeTvdGKTSyg37/tc/aGNZWqZS3Zx/wS/SWl818k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTcMnnIK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad5297704aaso276772866b.2;
        Sun, 25 May 2025 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748169559; x=1748774359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LHWs91dzoPJQjXL2DHSMhs2R6AKcX+QCx6aoC+YCgc=;
        b=HTcMnnIKBPC4t4bXEhwcsrVKQX0tT/K5GmthsplOTg0woyBkOvv7KXQgrRQnA1rv9s
         y2iWn0BEchDkvXF+esP7ulem4EaM0NvjjCvhsxK/lf1TdDVMH/4qYKNAu+OUffQ9FQYq
         Q53cbamXsgNu8WMWyfMPrJ102WRTl/ISb6oYJjKxRn269ZcaePl6wi6s7nT3ru7HZlgP
         cYWVXUlXWKC02Xs/5U7VQzGOchESW+FlMv5PXcfwP6yaKif7i+MtmaXXV1/HY7CzIabz
         jKrRnN6rToSjvx5Qd4Tm2t1+ac90quxJFFFz/ZhysPHbDtkc6IBjAq27NMzrzC+K+5mB
         w3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748169559; x=1748774359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LHWs91dzoPJQjXL2DHSMhs2R6AKcX+QCx6aoC+YCgc=;
        b=b21CXCIMbDafHgF1+Op2ygU6WBdHyit6tsB7S/l52huFMkDQAxE9w3buClDtHCfNIC
         muHToSagLS5jRdlRUdPnRUJp2Yi5ULIqZfopxIrRC1IYeVuhx8aJXM/feKdEu3TCZrxu
         VP9YD0zwHSuT3jx1mdAGLPtIvDM+1Clc98iP4+K6h++HAGhyP/XGuqrPQ96BlPXXdeaK
         VJ5PKCO2vAiHi0l7eO9nIZyeDmjM97ed3taWAq4/hrUFTResqf/F+6w2vg0sGvVNCiuo
         VMLeG7gm+TBVY0cmSSx6DRd/rA60K5MNlWFTKAvtIqsNNDIcKEz5nHMfesVFmACIEchj
         Qjpw==
X-Forwarded-Encrypted: i=1; AJvYcCU+m2b9GpdA7bLvW6yg/2ZvxiF17Yk912vhatj2TMw218TbUuDWZMWOtgth5UqVn6CScBDR/3vikM04/R+b@vger.kernel.org, AJvYcCUkRQafkMaIkufNA4qsKqt2ySwi2lIPp0XEh81B2WVsqarGzfthwBNGwN/1V6wJcYO7r/LXDQmPAyAq4DI49g==@vger.kernel.org, AJvYcCWb+/J/r9B3C7KXaA2ahFPdiBBsRWVxy0cwZCrVzOA1anbcPLCWN8V82MNaBnzetwX6nkd5t1CUnKcRlNlF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1YP2Y6Qeqfrp0uninnOmdWvcUcG/6DhLDbhinHrKIKRArau4/
	wTTaiYCn7n9vm/sgatuDdcxYr+uQbZJizasENsXC7LPCcagLSs0DE3wa0vbJFZJffJ+cfSnsLu2
	9yem4IaCUWXHLez6eai+tIkgfFisLlM8=
X-Gm-Gg: ASbGnctZ+ljV+nxggrnQJHUOBgKdULZyzIwW7jJCa3flAKw+Chr1kavkmB28v2qIj0B
	uBcPXRSFksILh/FdsdnQr9iGrr80BR1vtQsiPy2uKDuGfCZirzg+xJKWwze8B0gwHrvnGg+vUps
	blsBdtkV8V2OHa5s48xzlnITRPKQoLfu/z
X-Google-Smtp-Source: AGHT+IFno1Akxr/wJPhAiUeYUQGkgwtKtZ/T5e/mYBRpKqpoL41osOL9eLYIH81ToksZPcgucM67WaKFf0XQBysXM5w=
X-Received: by 2002:a17:907:60cf:b0:ac7:e5c4:1187 with SMTP id
 a640c23a62f3a-ad85b050454mr456141066b.11.1748169559010; Sun, 25 May 2025
 03:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521-ovl_ro-v1-1-2350b1493d94@igalia.com> <CAOQ4uxgXP8WrgLvtR6ar+OncP6Fh0JLVO0+K+NtDX1tGa2TVxA@mail.gmail.com>
 <20250521-blusen-bequem-4857e2ce9155@brauner> <32f30f6d-e995-4f00-a8ec-31100a634a38@igalia.com>
 <CAOQ4uxg6RCJf6OBzKgaWbOKn3JhtgWhD6t=yOfufHuJ7jwxKmw@mail.gmail.com>
 <35eded72-c2a0-4bec-9b7f-a4e39f20030a@igalia.com> <CAOQ4uxihs3ORNu7aVijO0_GUKbacA65Y6btcrhdL_A-rH0TkAA@mail.gmail.com>
 <c555a382-fd74-4d9b-ab3e-995049d2947f@igalia.com>
In-Reply-To: <c555a382-fd74-4d9b-ab3e-995049d2947f@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 25 May 2025 12:39:07 +0200
X-Gm-Features: AX0GCFsi6zXCclahrVGDtEMEZaDdtobghQ_tgx5mg66xZFtc9119qg0NLwEOTxs
Message-ID: <CAOQ4uxieVpcGHoD2Q+tND-2R7137-VZSg4mDwAx3UBoU6wJZmA@mail.gmail.com>
Subject: Re: [PATCH] ovl: Allow mount options to be parsed on remount
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Karel Zak <kzak@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 5:22=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 22/05/2025 12:13, Amir Goldstein escreveu:
> > cc libfuse maintainer
> >
> > On Thu, May 22, 2025 at 4:30=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:
> >>
> >> Em 22/05/2025 06:52, Amir Goldstein escreveu:
> >>> On Thu, May 22, 2025 at 8:20=E2=80=AFAM Andr=C3=A9 Almeida <andrealme=
id@igalia.com> wrote:
> >>>>
> >>>> Hi Christian, Amir,
> >>>>
> >>>> Thanks for the feedback :)
> >>>>
> >>>> Em 21/05/2025 08:20, Christian Brauner escreveu:
> >>>>> On Wed, May 21, 2025 at 12:35:57PM +0200, Amir Goldstein wrote:
> >>>>>> On Wed, May 21, 2025 at 8:45=E2=80=AFAM Andr=C3=A9 Almeida <andrea=
lmeid@igalia.com> wrote:
> >>>>>>>
> >>>>
> >>>> [...]
> >>>>
> >>>>>>
> >>>>>> I see the test generic/623 failure - this test needs to be fixed f=
or overlay
> >>>>>> or not run on overlayfs.
> >>>>>>
> >>>>>> I do not see those other 5 failures although before running the te=
st I did:
> >>>>>> export LIBMOUNT_FORCE_MOUNT2=3Dalways
> >>>>>>
> >>>>>> Not sure what I am doing differently.
> >>>>>>
> >>>>
> >>>> I have created a smaller reproducer for this, have a look:
> >>>>
> >>>>     mkdir -p ovl/lower ovl/upper ovl/merge ovl/work ovl/mnt
> >>>>     sudo mount -t overlay overlay -o lowerdir=3Dovl/lower,upperdir=
=3Dovl/
> >>>> upper,workdir=3Dovl/work ovl/mnt
> >>>>     sudo mount ovl/mnt -o remount,ro
> >>>>
> >>>
> >>> Why would you use this command?
> >>> Why would you want to re-specify the lower/upperdir when remounting r=
o?
> >>> And more specifically, fstests does not use this command in the tests
> >>> that you mention that they fail, so what am I missing?
> >>>
> >>
> >> I've added "set -x" to tests/generic/294 to see exactly which mount
> >> parameters were being used and I got this from the output:
> >>
> >> + _try_scratch_mount -o remount,ro
> >> + local mount_ret
> >> + '[' overlay =3D=3D overlay ']'
> >> + _overlay_scratch_mount -o remount,ro
> >> + echo '-o remount,ro'
> >> + grep -q remount
> >> + /usr/bin/mount /tmp/dir2/ovl-mnt -o remount,ro
> >> mount: /tmp/dir2/ovl-mnt: fsconfig() failed: ...
> >>
> >> So, from what I can see, fstests is using this command. Not sure if I
> >> did something wrong when setting up fstests.
> >>
> >
> > No you are right, I misread your reproducer.
> > The problem is that my test machine has older libmount 2.38.1
> > without the new mount API.
> >
> >
> >>>> And this returns:
> >>>>
> >>>>     mount: /tmp/ovl/mnt: fsconfig() failed: overlay: No changes allo=
wed in
> >>>>     reconfigure.
> >>>>           dmesg(1) may have more information after failed mount syst=
em call.
> >>>>
> >>>> However, when I use mount like this:
> >>>>
> >>>>     sudo mount -t overlay overlay -o remount,ro ovl/mnt
> >>>>
> >>>> mount succeeds. Having a look at strace, I found out that the first
> >>>> mount command tries to set lowerdir to "ovl/lower" again, which will=
 to
> >>>> return -EINVAL from ovl_parse_param():
> >>>>
> >>>>       fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) =3D 4
> >>>>       fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "/tmp/ovl/lower",=
 0) =3D
> >>>> -1 EINVAL (Invalid argument)
> >>>>
> >>>> Now, the second mount command sets just the "ro" flag, which will re=
turn
> >>>> after vfs_parse_sb_flag(), before getting to ovl_parse_param():
> >>>>
> >>>>       fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) =3D 4
> >>>>       fsconfig(4, FSCONFIG_SET_FLAG, "ro", NULL, 0) =3D 0
> >>>>
> >>>> After applying my patch and running the first mount command again, w=
e
> >>>> can set that this flag is set only after setting all the strings:
> >>>>
> >>>>       fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "/tmp/ovl/lower",=
 0) =3D 0
> >>>>       fsconfig(4, FSCONFIG_SET_STRING, "upperdir", "/tmp/ovl/upper",=
 0) =3D 0
> >>>>       fsconfig(4, FSCONFIG_SET_STRING, "workdir", "/tmp/ovl/work", 0=
) =3D 0
> >>>>       fsconfig(4, FSCONFIG_SET_STRING, "uuid", "on", 0) =3D 0
> >>>>       fsconfig(4, FSCONFIG_SET_FLAG, "ro", NULL, 0) =3D 0
> >>>>
> >>>> I understood that the patch that I proposed is wrong, and now I wond=
er
> >>>> if the kernel needs to be fixed at all, or if the bug is how mount i=
s
> >>>> using fsconfig() in the first mount command?
> >>>
> >
> > If you ask me, when a user does:
> > /usr/bin/mount /tmp/dir2/ovl-mnt -o remount,ro
> >
> > The library only needs to do the FSCONFIG_SET_FLAG command and has no
> > business re-sending the other config commands, but that's just me.
> >
>
> Yes, this makes sense to me as well.
>
> > BTW, which version of libmount (mount --version) are you using?
> > I think there were a few problematic versions when the new mount api
> > was first introduced.
> >
>
> mount from util-linux 2.41 (libmount 2.41.0: btrfs, verity, namespaces,
> idmapping, fd-based-mount, statmount, assert, debug)
>

All right, I upgraded my test machine to a newer distro so
I see those errors.

I will post a patch to xfstests to use LIBMOUNT_FORCE_MOUNT2
for overlayfs remount.

Thanks,
Amir.

