Return-Path: <linux-fsdevel+bounces-59167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D1CB355B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33653B031A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40997259CB6;
	Tue, 26 Aug 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3HOIO/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC69460;
	Tue, 26 Aug 2025 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193502; cv=none; b=JysAS2mJWVJBIDHuViNWEsVpNz07DBpZ1nXlGekrnUb760JiW6cXx5Ihcxor+CNXbLZrOhvZ/6g21R/1qQGdszZShNLHlTsnLvjPmQ+AuugbrSdtA+DTOjrktnH5/LoakS4+tC97BH6ybGRtt2wSXqBugbqOpku3eg2coHMChW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193502; c=relaxed/simple;
	bh=lK7yYoGLD2mjZncxMOrNOGXvDlmhPSSwl85uSiu3zmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frmMK0ytpKAuhknwb3bOQL2ZUOVhq4zwpufwR3zQyZ5BdaN3rf+3Z9FDTTdqEVfJNl1f2dJelkmwj31o4wD77e5WjtgSLKZuBQnc2gLLUMFrFEcYwizF3m6NL27+dFH6SYQgqX3CrJxM8QmOvpo8ZP6Ik0/mr5rPOKwKo1LfjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3HOIO/k; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61c3b84df28so4090020a12.1;
        Tue, 26 Aug 2025 00:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756193499; x=1756798299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDXQEvmJteS+PqtFTjwGM5ewMxvFlRB5GpzC3ArKlIA=;
        b=Y3HOIO/ki2F+DxAIfma+jv5zlkv1DxebqyyqNxH0fEvoqTVoDoeaOgERWb5vzlQSXC
         e31rdlvA4GoYVGj3j93x7KCPGZbDLZFiZqM8jyW4A/3ArIWUdZgHKZYYn+74liZWCsTo
         GYELApTY/W62ccH5grHfNjCWskFfbPFusRyD6EqaMqiNXsGZYpPO4qBWSLGHulvf5BMD
         +Y+0D/HykEgqBopkPAKIrOIMTzvLLyHjnkDRhQtanNfL2zYI0ht2B0uLWA+N98KGXMYm
         kJdoGBTb4O8csVq3gfoBiqNzoNO6EFz15bBXjczBvw5SJdAEzxcY+y9jRF/Tm5dmSdKG
         huKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193499; x=1756798299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDXQEvmJteS+PqtFTjwGM5ewMxvFlRB5GpzC3ArKlIA=;
        b=Vn50DKSj948PZyxRWFI/sd/f+0lio4WHU2tIYArVgJ5cEr3/0mSHP+raEuBzQmhkn0
         vbu8Cp/BFQdYH3Pp2XvCZm2J9IGeEWO+citRzC9GqDOgFmRX4urGLMiSsxWryxZPM1CL
         VZ9o6NrLm4BAEsI7B6/aqb1isDMxVtuN9agZ0yVmYtbNN9Qlnp1/z5Hp7p1u1/EAw6zt
         5fnWnoHgSOTQXQXtpF/io2CvDTVNqWlwvWfuy+KP/IxcwkS2kvmoj03LNTPVMDmY81UC
         ftU0Fwn6ksOUPeTrsL/YiS0YmCzEjmGzrFx8yYjbzFKDJ6ONXzRmvtUdKXVk8S5dgKNN
         gesg==
X-Forwarded-Encrypted: i=1; AJvYcCUcbw6bkGZsmdYM7pd7WwS3ccqtaVi9z1IOV39CspDP7DxA7ErIf4gql5JBxKQ/ht96IECqxxuyN31LKmhz@vger.kernel.org, AJvYcCVRfygX2tXCkK9MWAgm/tX1BGG0wZm8HN2qIkyE4DQv9Ufxz8sH1w8FnhaJzexLJScLqYfVEwdOvJR1ndx6Cg==@vger.kernel.org, AJvYcCXXZm+X+3GrF6SMiqH89qXKM1xyFlhvCXLNcQjvqICsGveSQ00ONZA1XWgX1Cz9HioIoALvP3l1BO8y8H9M@vger.kernel.org
X-Gm-Message-State: AOJu0YziSwLALATPEPif42rjTGLFLxpHHoZ7GzpwIff6wfFVU1RhiqzU
	bnNBd49MfRoJeHi2XWf7TLd4Jj3hZlKwtnvqcXsF57QjWD7GYu4yAegvKCEN0Az7zCe4AAA/ZSs
	skTFn2bGx3OkYK9XDBaLyRQ1HjHtOFhA=
X-Gm-Gg: ASbGncuz7OCVuhccet+35RKhBpBEeSniunUE9aQe/1fbPXl7AL8EKRP43jq5Q6JFMDu
	P1XZP/H9beVjSj+OwhO7u2Ven873g5sIpe1pB02JqY8/+/e1dtIEig7eMEmeCHQsRKinnyIxCLC
	niTBJlqSAPqxaPNDR03nIvmuoMspOWCkYQGqeh7KOmBNwnwKieoghnU8pUwJnsveBcSTeewfW6e
	pL4y4gfufOIxepCDQ==
X-Google-Smtp-Source: AGHT+IECbV2AnvaW351eSq1PCdN989YiDWNxLwSgp1yK+A+yBXTXBruUrW2uvseoZWJzNwFvBd4okrvt+okN3apkk48=
X-Received: by 2002:a05:6402:5109:b0:61c:5d0c:9383 with SMTP id
 4fb4d7f45d1cf-61c5d0c9c0fmr6779861a12.24.1756193499012; Tue, 26 Aug 2025
 00:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-9-8b6e9e604fa2@igalia.com> <CAOQ4uxhWE=5_+DBx7OJ94NVCZXztxf1d4sxyMuakDGKUmbNyTg@mail.gmail.com>
 <62e60933-1c43-40c2-a166-91dd27b0e581@igalia.com> <CAOQ4uxjgp20vQuMO4GoMxva_8yR+kcW3EJxDuB=T-8KtvDr4kg@mail.gmail.com>
 <6235a4c0-2b28-4dd6-8f18-4c1f98015de6@igalia.com>
In-Reply-To: <6235a4c0-2b28-4dd6-8f18-4c1f98015de6@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 26 Aug 2025 09:31:27 +0200
X-Gm-Features: Ac12FXxS3cGU0GDXUMUMUMh2i2mD1cH4gOPIdJHJWSKNIKJCGOM78i94QR0LmnM
Message-ID: <CAOQ4uxgMdeiPt1v4s07fZkGbs5+3sJw5VgcFu33_zH1dZtrSsg@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 3:31=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Hi Amir,
>
> Em 22/08/2025 16:17, Amir Goldstein escreveu:
>
> [...]
>
>    /*
> >>>> -        * Allow filesystems that are case-folding capable but deny =
composing
> >>>> -        * ovl stack from case-folded directories.
> >>>> +        * Exceptionally for layers with casefold, we accept that th=
ey have
> >>>> +        * their own hash and compare operations
> >>>>            */
> >>>> -       if (sb_has_encoding(dentry->d_sb))
> >>>> -               return IS_CASEFOLDED(d_inode(dentry));
> >>>> +       if (ofs->casefold)
> >>>> +               return false;
> >>>
> >>> I think this is better as:
> >>>           if (sb_has_encoding(dentry->d_sb))
> >>>                   return false;
> >>>
> >
> > And this still fails the test "Casefold enabled" for me.
> >
> > Maybe you are confused because this does not look like
> > a test failure. It looks like this:
> >
> > generic/999 5s ...  [19:10:21][  150.667994] overlayfs: failed lookup
> > in lower (ovl-lower/casefold, name=3D'subdir', err=3D-116): parent wron=
g
> > casefold
> > [  150.669741] overlayfs: failed lookup in lower (ovl-lower/casefold,
> > name=3D'subdir', err=3D-116): parent wrong casefold
> > [  150.760644] overlayfs: failed lookup in lower (/ovl-lower,
> > name=3D'casefold', err=3D-66): child wrong casefold
> >   [19:10:24] [not run]
> > generic/999 -- overlayfs does not support casefold enabled layers
> > Ran: generic/999
> > Not run: generic/999
> > Passed all 1 tests
> >
>
> This is how the test output looks before my changes[1] to the test:
>
> $ ./run.sh
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
> MKFS_OPTIONS  -- -F /dev/vdc
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
>
> generic/999 1s ... [not run] overlayfs does not support casefold enabled
> layers
> Ran: generic/999
> Not run: generic/999
> Passed all 1 tests
>
>
> And this is how it looks after my changes[1] to the test:
>
> $ ./run.sh
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
> MKFS_OPTIONS  -- -F /dev/vdc
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
>
> generic/999        1s
> Ran: generic/999
> Passed all 1 tests
>
> So, as far as I can tell, the casefold enabled is not being skipped
> after the fix to the test.

Is this how it looks with your v6 or after fixing the bug:
https://lore.kernel.org/linux-unionfs/68a8c4d7.050a0220.37038e.005c.GAE@goo=
gle.com/

Because for me this skipping started after fixing this bug
Maybe we fixed the bug incorrectly, but I did not see what the problem
was from a quick look.

Can you test with my branch:
https://github.com/amir73il/linux/commits/ovl_casefold/

>
> [1]
> https://lore.kernel.org/lkml/5da6b0f4-2730-4783-9c57-c46c2d13e848@igalia.=
com/
>
>
> > I'm not sure I will keep the test this way. This is not very standard n=
or
> > good practice, to run half of the test and then skip it.
> > I would probably split it into two tests.
> > The first one as it is now will run to completion on kenrels >=3D v6.17
> > and the Casefold enable test will run on kernels >=3D v6.18.
> >
> > In any case, please make sure that the test is not skipped when testing
> > Casefold enabled layers
> >
> > And then continue with the missing test cases.
> >
> > When you have a test that passes please send the test itself or
> > a fstest branch for me to test.
>
> Ok!

I assume you are testing with ext4 layers?

If we are both testing the same code and same test and getting different
results I would like to get to the bottom of this, so please share as much
information on your test setup as you can.

Thanks,
Amir.

