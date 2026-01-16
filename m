Return-Path: <linux-fsdevel+bounces-74187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FEFD33AF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B29A309F1A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1B36999D;
	Fri, 16 Jan 2026 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhMSKtKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BF33A6E4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583198; cv=pass; b=FuklBoKWy7Sry/NTP2VXN/Be35hh253dSEdtK/y6Bl2S3YND7XserVTWG8Re9yzoAl1YVIfQzYevaBJICOKL0fZoyHPNrdk7MDUYX+s+F+m1HBdIwwAYiKVKC8fOXyMLIW6heRBPQBdvDIQnELoquvK3NeWlWK2qyHGCcaAQFVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583198; c=relaxed/simple;
	bh=AutWS+ChfvnwZhvgwiJu9L8XUNWLOmuOdlQ8JOwu3aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILlImBmfa2NDh2I51ZiW+1E8RHhr94SX9YpCxIJtu3JFI6Dys08vtTZcPNs12dVXIUdOD92u0W2I7mjSES+z2AY9CivlnCW81Aanba6XzXcIP5+3t9P9Qwo54Kzwr/AGkuqSJJjTSX705VmxQBvGBYPIxZMPYxyY6rhMYWVRQlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhMSKtKa; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b872f1c31f1so307426266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 09:06:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768583195; cv=none;
        d=google.com; s=arc-20240605;
        b=G1g/NbFk9xcAmSpClKmWAG+WGYLiiDWpRz7PLKfk15IyGovg1B7ADCHsuecqkMr588
         ZRD5F+8Ypv4krcYF+VkYa2HcC6p+qrT5ZfXN5rIM0PLKeHH2p4kE6jNuTaWtpy2z3abm
         HHP5xRHUOvYxXY9QtIMHi/jQ10waOwAt273zX/lUpygLtf6BzM2eSFUt+TWcbiH48x7E
         /epUK/O372+6yW/2NTGbcRzCicYazdAbw0RxzHH6WsUSrjnHMC6IyPrsKWhVuMGngRYk
         qli3DHwRKivrmN0FPgam7s34IQsTVdv6/c0YEBALzyV3qH5jtakvMNyTXdOtKs/KYEjP
         razw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XItb6VFbJFsznrM8Z1kGxSYoWMyWGsT3kv3uyFtUZ1Y=;
        fh=d16fW7V1Y+FkbHne3qA1yCgp6/C9i5BjH9GUzOwrrqg=;
        b=PnGaMX/UANPPj4l74u+N059FOdIkhZxrQ2ws/xrdx93iCGjXko5ndf7JKHm01Ogn5H
         l39JWpmSqZQWyzAcUeLA+teH3miow35UNoIJsvWVpmZj2kDjgbyGgYPb+Sxx6gwIVVDd
         Z9NpyaD1+IpzG2l+TOCm2TqdoKiSUbthmrFAa945GbE0PazswekXw1mcuyCEFocix/cL
         gk6lfTmFJIDqND7ZTxX9+3eHLuPWeSialpgJV6wqlPB72MAzoIF4hqFkeRDqTmhSoBj/
         I26y4FULIWUKozrHyBgrDdsFykBebARP0rsAKkPhV7PUWPIARddtwE5KNSM8A9RG6DD2
         m5Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768583195; x=1769187995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XItb6VFbJFsznrM8Z1kGxSYoWMyWGsT3kv3uyFtUZ1Y=;
        b=IhMSKtKaInAjrrAr5VM6ei28YAbFYHSe3d3k41G1Ruwu2yhJloJySjlPBPAMQDKx3p
         EQ5CmjuREI5k/GUIw8K+fzaDX9QShVwycft/lqao/M18lDOhI0NJBa0RpkhiJ2pvt7K8
         D/ERhK4E2MY3mZzLCc03/aTWKZ90WnhUj9Go5z7ivGLuW7wYtfn0Qeg0hzbW6hbNftgG
         df8KlNPgCvp5qQHH6KttDWpApVbKvO0SH/1KLecIF0gfrc3pqoXs4rRyTgF42lJHW/yK
         K2RoHQAms4bU8iXM3yKxjbrKs7rpkByiFEec9h2rVa66JWgAj7HIajNmoheECxLUGlH5
         rwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768583195; x=1769187995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XItb6VFbJFsznrM8Z1kGxSYoWMyWGsT3kv3uyFtUZ1Y=;
        b=RhV2BdUBtOiuEN1ADbHh1oRrAahbXymzOCv2Jp/s9RB+UyPFPY1s2QqXjVrGeN3TJ3
         Q4drZeqnlpgwKPC6tkdIOEtYiRkqrJtRSt4/e217vSl+q7H+tV4bDrlHd9MDCgXl9Msr
         +HZFVz/3exSb6rhXvygKXMwfP3Swhb2J1FFy82PDKveEBc8B+NiS7CHoVb1wY44WEMr/
         tWqodlRxuPccer3HzabjuXCxw0fq0IHsqOxZQCPBXzEXUTjiwa3CyQAkChVo6tcbWb3P
         ql9y3yd7+boMZ1PPFWCc/h4uCAqp1ycSnKAMBFzo42Pe4OY2yWSigRBFbwC6kdMCz1Ix
         zAVA==
X-Forwarded-Encrypted: i=1; AJvYcCUDGWuCKWQ9h82Fp8Tzc1Z/NH9Eu0b5ziGB4YqEzoOTgSKtTXuZ/pKmHTjHEGOP1flilW40MTx0Y1GWmpCX@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYxRtROsFPs2MfzH18KhayhoRCPxS2I328PfljsYfQsbJtjk2
	lhb88f2soOrhjPBWAYi+SmstpOKtg4n2+mTFhyjhxZ2QJRdhEpVEzm42Ygo9WutWVG0prMcDNFS
	af0CnweQbWpE2/XRZHxV+csRbeVZeiIY=
X-Gm-Gg: AY/fxX5dmc1C22u0SP5/hoMInaBgOpeBUo6LKv/h4UGKDDXLEDDTvnO+xlRNIIIpSZk
	TNLMsK67SKnUSc2ynxXZ40UgjoDpyyE7mlqVJqQFZtdG1pEK1gclyL9UT7KQUEBhs75jZYXBdbR
	92PCCXl4f7ypCX04IDaYhH153b/5qSi2aSX8t5GI0dLQZ7zuIgVXfXkb9eFzEnF1q8tMPoC0KyF
	UNRPfdhBHqfToBSrO9uAU6WrbZZEEsuavqiOFyf5W9SRybOK2o7Q/irNXky1NuiNQRJSot2Tm9g
	0C7MIlXL7aHJARR9nB+OHikHAiSf9ywaNr9rJcT7
X-Received: by 2002:a17:907:8692:b0:b87:63a8:8849 with SMTP id
 a640c23a62f3a-b8793035646mr264423966b.46.1768583194354; Fri, 16 Jan 2026
 09:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com> <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com>
In-Reply-To: <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Jan 2026 18:06:22 +0100
X-Gm-Features: AZwV_QiycpCXWte0-e38-ESYar7TKmRhifBZp2CxcdBlO9fcQ_xptdhi8v4o5sg
Message-ID: <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com, vivek@collabora.com, 
	Ludovico de Nittis <ludovico.denittis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 2:28=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> [+CC SteamOS developers]
>
> Em 16/01/2026 06:55, Amir Goldstein escreveu:
> > On Thu, Jan 15, 2026 at 7:55=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:
> >>
> >> Em 15/01/2026 13:07, Amir Goldstein escreveu:
> >>> On Thu, Jan 15, 2026 at 4:42=E2=80=AFPM Andr=C3=A9 Almeida <andrealme=
id@igalia.com> wrote:
> >>>>
> >>>> Em 15/01/2026 04:23, Christoph Hellwig escreveu:
> >>>>
> >>>> [...]
> >>>>
> >>>>>
> >>>>> I still wonder what the use case is here.  Looking at Andr=C3=A9's =
original
> >>>>> mail it states:
> >>>>>
> >>>>> "However, btrfs mounts may have volatiles UUIDs. When mounting the =
exact same
> >>>>> disk image with btrfs, a random UUID is assigned for the following =
disks each
> >>>>> time they are mounted, stored at temp_fsid and used across the kern=
el as the
> >>>>> disk UUID. `btrfs filesystem show` presents that. Calling statfs() =
however
> >>>>> shows the original (and duplicated) UUID for all disks."
> >>>>>
> >>>>> and this doesn't even talk about multiple mounts, but looking at
> >>>>> device_list_add it seems to only set the temp_fsid flag when set
> >>>>> same_fsid_diff_dev is set by find_fsid_by_device, which isn't docum=
ented
> >>>>> well, but does indeed seem to be done transparently when two file s=
ystems
> >>>>> with the same fsid are mounted.
> >>>>>
> >>>>> So Andr=C3=A9, can you confirm this what you're worried about?  And=
 btrfs
> >>>>> developers, I think the main problem is indeed that btrfs simply al=
lows
> >>>>> mounting the same fsid twice.  Which is really fatal for anything u=
sing
> >>>>> the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uuid=
 user.
> >>>>>
> >>>>
> >>>> Yes, I'm would like to be able to mount two cloned btrfs images and =
to
> >>>> use overlayfs with them. This is useful for SteamOS A/B partition sc=
heme.
> >>>>
> >>>>>> If so, I think it's time to revert the behavior before it's too la=
te.
> >>>>>> Currently the main usage of such duplicated fsids is for Steam dec=
k to
> >>>>>> maintain A/B partitions, I think they can accept a new compat_ro f=
lag for
> >>>>>> that.
> >>>>>
> >>>>> What's an A/B partition?  And how are these safely used at the same=
 time?
> >>>>>
> >>>>
> >>>> The Steam Deck have two main partitions to install SteamOS updates
> >>>> atomically. When you want to update the device, assuming that you ar=
e
> >>>> using partition A, the updater will write the new image in partition=
 B,
> >>>> and vice versa. Then after the reboot, the system will mount the new
> >>>> image on B.
> >>>>
> >>>
> >>> And what do you expect to happen wrt overlayfs when switching from
> >>> image A to B?
> >>>
> >>> What are the origin file handles recorded in overlayfs index from ima=
ge A
> >>> lower worth when the lower image is B?
> >>>
> >>> Is there any guarantee that file handles are relevant and point to th=
e
> >>> same objects?
> >>>
> >>> The whole point of the overlayfs index feature is that overlayfs inod=
es
> >>> can have a unique id across copy-up.
> >>>
> >>> Please explain in more details exactly which overlayfs setup you are
> >>> trying to do with index feature.
> >>>
> >>
> >> The problem happens _before_ switching from A to B, it happens when
> >> trying to install the same image from A on B.
> >>
> >> During the image installation process, while running in A, the B image
> >> will be mounted more than once for some setup steps, and overlayfs is
> >> used for this. Because A have the same UUID, each time B is remouted
> >> will get a new UUID and then the installation scripts fails mounting t=
he
> >> image.
> >
> > Please describe the exact overlayfs setup and specifically,
> > is it multi lower or single lower layer setup?
> > What reason do you need the overlayfs index for?
> > Can you mount with index=3Doff which should relax the hard
> > requirement for match with the original lower layer uuid.
> >
>
> The setup has a single lower layer. This is how the mount command looks
> like:
>
> mount -t overlay -o
> "lowerdir=3D${DEV_DIR}/etc,upperdir=3D${DEV_DIR}/var/lib/overlays/etc/upp=
er,workdir=3D${DEV_DIR}/var/lib/overlays/etc/work"
> none "${DEV_DIR}/etc"
>
> They would rather not disable index, to avoid mounting the wrong layers
> and to avoid corner cases with hardlinks.

IIUC you have all the layers on the same fs ($DEV_DIR)?

See mount option uuid=3Doff, created for this exact use case:

Documentation/filesystems/overlayfs.rst:
Note: the mount option uuid=3Doff can be used to replace UUID of the underl=
ying
filesystem in file handles with null, and effectively disable UUID checks. =
This
can be useful in case the underlying disk is copied and the UUID of this co=
py
is changed. This is only applicable if all lower/upper/work directories are=
 on
the same filesystem, otherwise it will fallback to normal behaviour.

commit 5830fb6b54f7167cc7c9d43612eb01c24312c7ca
Author: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Date:   Tue Oct 13 17:59:54 2020 +0300

    ovl: introduce new "uuid=3Doff" option for inodes index feature

    This replaces uuid with null in overlayfs file handles and thus relaxes
    uuid checks for overlay index feature. It is only possible in case ther=
e is
    only one filesystem for all the work/upper/lower directories and bare f=
ile
    handles from this backing filesystem are unique. In other case when we =
have
    multiple filesystems lets just fallback to "uuid=3Don" which is and
    equivalent of how it worked before with all uuid checks.

    This is needed when overlayfs is/was mounted in a container with index
    enabled ...

    If you just change the uuid of the backing filesystem, overlay is not
    mounting any more. In Virtuozzo we copy container disks (ploops) when
    create the copy of container and we require fs uuid to be unique for a =
new
    container.

TBH, I am trying to remember why we require upper/work to be on the
same fs as lower for uuid=3Doff,index=3Don and I can't remember.
If this is important I can look into it.

Thanks,
Amir.

