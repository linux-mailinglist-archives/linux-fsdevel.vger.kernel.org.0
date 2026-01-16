Return-Path: <linux-fsdevel+bounces-74083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 248E8D2F1E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75B3D30402F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CA7357A5E;
	Fri, 16 Jan 2026 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu3uI3Ls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15A9306482
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557335; cv=none; b=P3z+DnEd2dhfq5CI8AKjPE8mLlAMdxfLcUjZXvv7eKHehtl5AQYACAAgF9Qz7C4Z+ElwOppHa5WGsjWTvs8tdhhK9PnzsOGh0rULotQu/3UVa4WVwxechPnHmOx6MRJK3uF6MXmvhymmf6cyPul18iVtyl0qF5DDEZShTIOhAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557335; c=relaxed/simple;
	bh=K1IVhgLVP4tMWa4rCPNyc3P/DTHNpSOZNTFwb25LilA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oA5nSXaEsdPNn7HdDWRHnn0P8HqIPnmQAvwMxcV7XQ+aLewYZv6/WIQehm+lPY19Cxpt+DvJpPnFKwvehy0Ashb/W0MYpVu7ACy8+QRV7Ax15FJCrSaC1aMBEcKe1iW4/Ry/+gysJdqLdUn8jtyFyD2dglDXHox0Iw5jLDLMsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu3uI3Ls; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso2830970a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557328; x=1769162128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4xFyXf1g1QrEuF2V9wAvkuU4l5f69A6f1eeQe7d3g4=;
        b=Tu3uI3LsJHfm6sNIcneQu2bYQa5YkZemeRhVLiWhyUpDatM1CaaXJ5Kqy9qakFPHU8
         19Yz0tvzaUgaLz2XacmRn2m9dK5Wi6d4SkcGT/mAGUhc4O3CLIyWdzFyM7pZeMEVZL1c
         zxJDSEym/iUbaM3nehfogYSXexEELdRnrBbDspaIjOQseheo0FQR1vDSOUR+aZsMv78P
         gSniwcsF4KoxAijuRf8ykfpVSjBSgz/h5Wc45prDz7ym4N9qZp5PjkDorEu84ilphDfJ
         AwyztpbmX22k0BqFS8dH13sn/yCuN2nYlYn7eUy2htkLJ8Lli8JGYeMoY5Gs7/rQT5Zz
         m7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557328; x=1769162128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4xFyXf1g1QrEuF2V9wAvkuU4l5f69A6f1eeQe7d3g4=;
        b=ev7dX7hIRUZsb9J0oI9oWBkIBZH9Wjm9p4I7fErt77i+uaWJ/U+wv1rmHX2v7jzipV
         K1OG5OPVjB7CP0R6SPmOz7CwoM06L8fkQkLGhLW9zV9+w9gUWx/uTThnEgSQuM6OU8ZK
         rqE7YxC1igjSkOYi8R9yItrhRm83FmX2sIiFKKXuX4sIBDnTfHP+NLgXfjZyLWiPvgxx
         f2218W2iA2/Zb7Doo+4kxx2Kxz7HHtbu5xp7UTabzQUY1JUIGDQvct18BxYwwesI52xw
         OmKXyrE7czDsh1hm5T6PQfHrWtXqssVNZ3HfAbcE8AHFT/ccbVx3zHhW3PIBXI0c0pF2
         Fc8A==
X-Forwarded-Encrypted: i=1; AJvYcCVE6hsNxv5M1BBKW6sRkiujGATJwgqg2zCBrIwq3nbrbnDkEsdZ5JeWpYMtyAJfvGQky4Jzgp5Lw6CpqI6n@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjJjmwz7AD4uR+AsV1mXWz7nhZ596xxkRCCmwm3NbeElhqy9m
	BMgz4bRHnxzI/cqlhxk7jUGI0mCTRZlbtrjtuPek6hpMtGlFS1NlxL2crt1h2OpJpZMyZEDfYzB
	3QdmAZwProGqvjXgkVmv5n2InAMU57X0=
X-Gm-Gg: AY/fxX65N35+pQkRNiN38Mrq9U/FuOuUhMNfU3otE3Sn0IK+UVDRakjwYl4sSsHfZ3W
	8jpQ2KVGfcA5ZgFjU+dJOEcPngrwQEcbnM+IzbgfBFYFc5ZclnlBaI5iqXb8jD/obXnIbhbOhb2
	jrkGsk+Vva2907AujwtRBFEpEhfzlpia3yHD3yJHQV/d4MTy0bGea1UKCrmHspsS+94CBVcKsNb
	sDVb56BM10AlfM9NNTqaWEiq5aFh3npNObd7fbWZpIF/McvuQXFHMtNDAbBW/lkR3fxvIulGicI
	dAphc0XXIlVpZZjLCk0JY5ZpYnL/JQ==
X-Received: by 2002:a05:6402:399a:b0:64b:6e20:c92e with SMTP id
 4fb4d7f45d1cf-654526c9083mr1397349a12.10.1768557327690; Fri, 16 Jan 2026
 01:55:27 -0800 (PST)
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
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com> <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com>
In-Reply-To: <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Jan 2026 10:55:15 +0100
X-Gm-Features: AZwV_Qi6NnVcLeZQhugqg4vwwjzqnBqiBj0Y0tKNZxo4ZfD1WtvuLTyqSS9dynY
Message-ID: <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
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
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 7:55=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 15/01/2026 13:07, Amir Goldstein escreveu:
> > On Thu, Jan 15, 2026 at 4:42=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:
> >>
> >> Em 15/01/2026 04:23, Christoph Hellwig escreveu:
> >>
> >> [...]
> >>
> >>>
> >>> I still wonder what the use case is here.  Looking at Andr=C3=A9's or=
iginal
> >>> mail it states:
> >>>
> >>> "However, btrfs mounts may have volatiles UUIDs. When mounting the ex=
act same
> >>> disk image with btrfs, a random UUID is assigned for the following di=
sks each
> >>> time they are mounted, stored at temp_fsid and used across the kernel=
 as the
> >>> disk UUID. `btrfs filesystem show` presents that. Calling statfs() ho=
wever
> >>> shows the original (and duplicated) UUID for all disks."
> >>>
> >>> and this doesn't even talk about multiple mounts, but looking at
> >>> device_list_add it seems to only set the temp_fsid flag when set
> >>> same_fsid_diff_dev is set by find_fsid_by_device, which isn't documen=
ted
> >>> well, but does indeed seem to be done transparently when two file sys=
tems
> >>> with the same fsid are mounted.
> >>>
> >>> So Andr=C3=A9, can you confirm this what you're worried about?  And b=
trfs
> >>> developers, I think the main problem is indeed that btrfs simply allo=
ws
> >>> mounting the same fsid twice.  Which is really fatal for anything usi=
ng
> >>> the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uuid u=
ser.
> >>>
> >>
> >> Yes, I'm would like to be able to mount two cloned btrfs images and to
> >> use overlayfs with them. This is useful for SteamOS A/B partition sche=
me.
> >>
> >>>> If so, I think it's time to revert the behavior before it's too late=
.
> >>>> Currently the main usage of such duplicated fsids is for Steam deck =
to
> >>>> maintain A/B partitions, I think they can accept a new compat_ro fla=
g for
> >>>> that.
> >>>
> >>> What's an A/B partition?  And how are these safely used at the same t=
ime?
> >>>
> >>
> >> The Steam Deck have two main partitions to install SteamOS updates
> >> atomically. When you want to update the device, assuming that you are
> >> using partition A, the updater will write the new image in partition B=
,
> >> and vice versa. Then after the reboot, the system will mount the new
> >> image on B.
> >>
> >
> > And what do you expect to happen wrt overlayfs when switching from
> > image A to B?
> >
> > What are the origin file handles recorded in overlayfs index from image=
 A
> > lower worth when the lower image is B?
> >
> > Is there any guarantee that file handles are relevant and point to the
> > same objects?
> >
> > The whole point of the overlayfs index feature is that overlayfs inodes
> > can have a unique id across copy-up.
> >
> > Please explain in more details exactly which overlayfs setup you are
> > trying to do with index feature.
> >
>
> The problem happens _before_ switching from A to B, it happens when
> trying to install the same image from A on B.
>
> During the image installation process, while running in A, the B image
> will be mounted more than once for some setup steps, and overlayfs is
> used for this. Because A have the same UUID, each time B is remouted
> will get a new UUID and then the installation scripts fails mounting the
> image.

Please describe the exact overlayfs setup and specifically,
is it multi lower or single lower layer setup?
What reason do you need the overlayfs index for?
Can you mount with index=3Doff which should relax the hard
requirement for match with the original lower layer uuid.

Thanks,
Amir.

