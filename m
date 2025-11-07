Return-Path: <linux-fsdevel+bounces-67415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23833C3ED10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 08:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984C61884749
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 07:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AA930E83C;
	Fri,  7 Nov 2025 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsK+QnaS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91B2D063C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501874; cv=none; b=dOXtIACD/He1kYMANk7a0pU/mSF+F/sNGtQ3Pc0tZbn5NCrI31AB+7miBfd1cxar99HOaunpwYbAS1xZ3exOhLL8JUOTITXSlVEaBkHpHKzIItvtwN9p4mQ00diMsvYZZnJkTUFTdVBjZFDm0hq6JgK59M3jx62TuPXq4g+hQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501874; c=relaxed/simple;
	bh=DBkxoSNlKaSPUMK4zellr7NQI5sAgx6z9H/pZ4MGVqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcU1cCZ/yNga7CpBjyuM/zOyO0P5z0X90mfCADq0HpbZCp2jS0MelMsNYXiwIK19+VYc8cui2R6E+7mpr9LnOucQ38hKfg+zpWtx5QvK4fSPkF55LRWlNGxLT5RAlxqEy+UGDgFlF9lzCCPaZxTIwqBu9/ok5zagFOR/DFtHU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsK+QnaS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so739018a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 23:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762501871; x=1763106671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gypdu32AjBdl8JRh/paj6OCLfQy8ztkLDfHJejFEMqc=;
        b=HsK+QnaS3sPxVxk2m3RzVCU2iYIyNIc5wvyVaCv24AUeONkHsTfrSk8lNa4Jb4QQFL
         5dR+H8N2sTQ3cf1WWLirpqmLue1oB3LfW4aRXBKDU0iBKiPPBYHMEhkVwdGYjDOKNxTd
         TrOSZAA4k9wUBFklMWGF45+1uQObdRWWMIec4W4HcxcKsvJJQYrue2iAzlYshrj1YsLL
         q9p68hUnqC5ArqOUb9bsCKL0f97NwUNIbMhhU8l3EduOpqtzjVoGVBS7dkOsvK7B5tCU
         P9f8bIq1ZAnk2t/t+h8jR4nOVRVJSuw4jOxou26H3NPehG0Cwbp60DT1hYQwK31A1fZi
         unBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762501871; x=1763106671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gypdu32AjBdl8JRh/paj6OCLfQy8ztkLDfHJejFEMqc=;
        b=WFLhz3Ix4TokJbDyjuxOMQ/2MSo54Q1bn2aTgX9/iE4vnO4Yh4yCLo3UZA6vaeCGUu
         Y4lGsBbx3ypXq2wsSLV1s7IeE9ZWPSr/j6iVjUKPWItlHALlIb0zy9kv9b32OfA5Y8Sc
         XsejRUKl6uiHaV3bX12s2KFDsc8mPtFNjl1ICSySONMMeZMz5mr0V+wpKoZrn7rX9xbc
         4xl/AFbbH+dsgud/BPbIHL8AO4fxNbox/paDqxzxFTOMa70xleFc+nM00D+KB8VQoAGY
         lrc/gVolXMCO1TpTdR7WknUiGx/rvFkJH322etiNvYUOSydNR5G0LVwq0xQt7ZG7IcNl
         PDlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvQHzcnEjXShnIASqFBRUy6Rwllxk/2CEqIhRJokV5uzHafVqYiC+x3dOBJEW56rcyApbtj/KhjJzjfLjH@vger.kernel.org
X-Gm-Message-State: AOJu0YyssM8x8F83n5AURRcXEwZ2nDOQPY0iHG3OxxhKH+ZZr9hrPvTZ
	ngL9LIYUZ72fuOXnbprZRn4N5zcAvQ1P/b2D0Qq6e5Tw/oA8/GexAAhz9Ul++iMChgn08YC1AsK
	i65hq/3wWSvtl351zbSadDq3WSJDbwgs=
X-Gm-Gg: ASbGncuKnw97i1mw7Vn/wsJS/Whq2rd5QQQolaORnC5tvzjunxb/pOlF5z7fe2iDgeA
	lQko1+AAKqYWvp4Z+2Ra7AjE3hyayuTTpQzr9oD2zyA6DzzKytKETDrT9Ap9vqyjw1FSlvamKoy
	cgBp9WiY+3kaYj1l0qkdOaTqHSO4XmT6uoraoXjrdIWFJjamrGK70bvgMwgT/XbUarPJVtR3DGD
	HJNJkx2Z8wxPkGfZ09xueGaVsrzG62dUbmuT6SkxtpnlJ+olct8CPpxEoCeHafdrvKirLYsJ18r
	IiEihVP3OxX5I4AwwgM=
X-Google-Smtp-Source: AGHT+IE0wn+JgXGDP+/X23JJiJR87uZ3bU9Eku9RD/Xf6SIQu9XEELdfWfIJb6UWtw6QwSr76TEb6t86wyo+1imQhyo=
X-Received: by 2002:a05:6402:51c6:b0:640:ca67:848d with SMTP id
 4fb4d7f45d1cf-6413eeb9fb6mr2107882a12.8.1762501870320; Thu, 06 Nov 2025
 23:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
 <CAOQ4uxj7yaX5qLEs4BOJBJwybkHzv8WmNsUt0w_zehueOLLP9A@mail.gmail.com>
 <20251105225355.GC196358@frogsfrogsfrogs> <CAOQ4uxjC+rFKrp3SMMabyBwSKOWDGGpVR7-5gyodGbH80ucnkA@mail.gmail.com>
 <20251106231215.GC196366@frogsfrogsfrogs>
In-Reply-To: <20251106231215.GC196366@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Nov 2025 08:50:58 +0100
X-Gm-Features: AWmQ_bka4NhoB4_0GzsMDp2JL8GmrqvBcI2VdjLITQEvTx--8zNv2vTizrwbetI
Message-ID: <CAOQ4uxjBpm_2cUDHyU72pSRc5KLDNm9tRgGYsoaAtp6tM6yFwg@mail.gmail.com>
Subject: Re: [PATCH 01/33] misc: adapt tests to handle the fuse ext[234] drivers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 12:12=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Nov 06, 2025 at 09:58:28AM +0100, Amir Goldstein wrote:
> > On Wed, Nov 5, 2025 at 11:53=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Thu, Oct 30, 2025 at 10:51:06AM +0100, Amir Goldstein wrote:
> > > > On Wed, Oct 29, 2025 at 2:22=E2=80=AFAM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > >
> > > > > It would be useful to be able to run fstests against the userspac=
e
> > > > > ext[234] driver program fuse2fs.  A convention (at least on Debia=
n)
> > > > > seems to be to install fuse drivers as /sbin/mount.fuse.XXX so th=
at
> > > > > users can run "mount -t fuse.XXX" to start a fuse driver for a
> > > > > disk-based filesystem type XXX.
> > > > >
> > > > > Therefore, we'll adopt the practice of setting FSTYP=3Dfuse.ext4 =
to
> > > > > test ext4 with fuse2fs.  Change all the library code as needed to=
 handle
> > > > > this new type alongside all the existing ext[234] checks, which s=
eems a
> > > > > little cleaner than FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4, which also =
would
> > > > > require even more treewide cleanups to work properly because most
> > > > > fstests code switches on $FSTYP alone.
> > > > >
> > > >
> > > > I agree that FSTYP=3Dfuse.ext4 is cleaner than
> > > > FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4
> > > > but it is not extendable to future (e.g. fuse.xfs)
> > > > and it is still a bit ugly.
> > > >
> > > > Consider:
> > > > FSTYP=3Dfuse.ext4
> > > > MKFSTYP=3Dext4
> > > >
> > > > I think this is the correct abstraction -
> > > > fuse2fs/ext4 are formatted that same and mounted differently
> > > >
> > > > See how some of your patch looks nicer and naturally extends to
> > > > the imaginary fuse.xfs...
> > >
> > > Maybe I'd rather do it the other way around for fuse4fs:
> > >
> > > FSTYP=3Dext4
> > > MOUNT_FSTYP=3Dfuse.ext4
> > >
> >
> > Sounds good. Will need to see the final patch.
> >
> > > (obviously, MOUNT_FSTYP=3D$FSTYP if the test runner hasn't overridden=
 it)
> > >
> > > Where $MOUNT_FSTYP is what you pass to mount -t and what you'd see in
> > > /proc/mounts.  The only weirdness with that is that some of the helpe=
rs
> > > will end up with code like:
> > >
> > >         case $FSTYP in
> > >         ext4)
> > >                 # do ext4 stuff
> > >                 ;;
> > >         esac
> > >
> > >         case $MOUNT_FSTYP in
> > >         fuse.ext4)
> > >                 # do fuse4fs stuff that overrides ext4
> > >                 ;;
> > >         esac
> > >
> > > which would be a little weird.
> > >
> >
> > Sounds weird, but there is always going to be weirdness
> > somewhere - need to pick the least weird result or most
> > easy to understand code IMO.
> >
> > > _scratch_mount would end up with:
> > >
> > >         $MOUNT_PROG -t $MOUNT_FSTYP ...
> > >
> > > and detecting it would be
> > >
> > >         grep -q -w $MOUNT_FSTYP /proc/mounts || _fail "booooo"
> > >
> > > Hrm?
> >
> > Those look obviously nice.
> >
> > Maybe the answer is to have all MOUNT_FSTYP, MKFS_FSTYP
> > and FSTYP and use whichever best fits in the context.
>
> Hrmm well I would /like/ avoid adding MKFS_FSTYP since ext4 is ext4, no
> matter whether we're using the kernel or fuse42fs.  Do you have a use
> case for adding such a thing?
>

No use case, beyond more flexibility in writing clear code.
I agree with Zorro that ext4 is not only ext4.
ext4 is ext4 on-disk format and it is ext4 driver and this ambiguity
can be a source of confusion sometimes.

I don't see the problem with defining MKFS_FSTYP
the controversial part IMO is what FSTYP should be
referring to, the flesh or the spirit...

Trying to think up a use case, ntfs has at least 3 Linux drivers
that I know of (ntfs,ntfs3 and fuse.ntfs-3g) and another one that was recen=
tly
proposed (ntfsplus). At least some have also their matching mkfs
and should be able to cross mount an ntfs formatted by other mkfs.

So testing any variation of MKFS_FSTYP and MOUNT_FSTYP
makes sense.

Using MKFS_FSTYP in mkfs and fsck helpers and using MOUNT_FSTYP
in mount helpers is always good practice IMO.

My intuition is that FSTYP should be defined to whichever
results in less churn and less weird looking code, but I don't know
which one that would be.

Thanks,
Amir.

