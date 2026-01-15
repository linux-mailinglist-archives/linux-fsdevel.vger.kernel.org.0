Return-Path: <linux-fsdevel+bounces-73936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C343D259DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 118C5304669D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A53BC4D4;
	Thu, 15 Jan 2026 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxkV/2AH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F73BC4C3
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493262; cv=none; b=eRW8NZy06YHdsaPXOmtkYb6Ng9xGZnZIfQbqbBBR9GjvK15RANJsqcmfS1dPEQ0M0Wdvw5z0X574S3MDyTxy1ZINuuI533D2bYJu41bdqDzDvHbAajOq8x35CLshYz/Di5o4XzIqy5DWAyi/oWZfCzWDrR62pVavAeC4VBnwlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493262; c=relaxed/simple;
	bh=x596PaRllNdpIS5h9hbxK5VONKk86ckOfrPn2xRuoYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rI9giCEYQYwck2BY2ZDgPjcLis62EBx9ftl2636t5amExlpdDIlDnC4N2JzFPecgEFtp3hIj3/61bpWL3LjLEVe+QnLqxPkAqg6gCiJmiCgHroe4Iqtc1iwO+qCURsNA1zIc8x6H5xZft4pNfmvoUtOAxj34+J+LZqnbmbZPUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxkV/2AH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so968257f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 08:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768493256; x=1769098056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bL4KgiUjakccFp8GDyIgH1rXwphyq4QxNLCwr+nqA/M=;
        b=VxkV/2AHa5JQBaAQICa5sas+eHcjykHVbERA704p8HnhoB2mMgb2rXtLkj//IoI3AC
         btn2Bo5JoPN2LhEwuy2ibPdWaRYrkxUqhWKpHXYu25u25lBKAdozXbYixKpAMtZ02Slu
         JDCQ+F2JeKsgrI2ECJhZmapjAM6rD1QMf0a1zcDwvvTHhTF/e4Grrujl3C0HJWL/fueg
         zchtSCwwaxIcmPAZlJqJGfqrQOC37L/Efl7Qg+KF2AnkfZtpGUdhgm+mw96D5jkAgJcR
         k3Kyx1PWB8XnuzwCmwkhZdLLB5YFkYUOgi1FOGKxlbpnPHLOvuZnm5rPR8enVS/t8dJz
         t8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768493256; x=1769098056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bL4KgiUjakccFp8GDyIgH1rXwphyq4QxNLCwr+nqA/M=;
        b=HrrrQBz0bCJt4PkXLk6fsWv2ZTP6TE5uuIUPHjSsp9Rosr3Omfg3XaL12XdBb8p2eN
         MZKP/ULwIb8kSSsiIgA6I8HUKKpXQc/JmRR68NY2Vda+gOLxUGwmZxNNOpC7jdTlU0a2
         k+M6YQCxGEt6BPkhvBT7THYLx5d7bVumz+BDwo9V6AVPf9ZcCh19sMyiC+Kee1i9oRsE
         pys6N2hI+qiMT2ohHEJxo6kFez1DtXxahNcGIdeZV3UkaGjlGkJyPBCh3IZyHdqqTCBR
         Z6pa9ZTc92Fcls6WQQYCES0Tmfwxr4VC38cGXR7mh1Drdf5EN8XG0dyDw5ERmsanPNC2
         o0/w==
X-Forwarded-Encrypted: i=1; AJvYcCXGWRM39eJdGEXkqQ4fWPKWhrXl3V7OyFpMoywtAUzMHugAKnehLs2OGXVYTByp3PVhblXj9YkJ4gYAD4UD@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLQ18qLVyVCR87GaSOAFtlFrw65Qbm/DMw1eziRvGba3HGVvg
	Yp6eggCg2XCsFBmrPedNP23c8xHuZ5tibucbk/40cETN5yfTdHeOQxg3VfiO8+WkK0G5Ehs3S8a
	vKX/h9jNHrlV7SwKV323C8Wrs+SGec7Y=
X-Gm-Gg: AY/fxX7ScsQ5Nv3bz3MPip+avNr4+2USfqo/LSgX9kul0dbC+A81WGEiU4yJmBjK9AF
	AwVUKyu1gMkmgIR74AwEx06oaMOm/4Wo5AcoFj77awGaGstzSmXi2QGBPqwoTZ55cgSLZOKTCB6
	09WO6+bHRfhPwy5UvYn85WYRsdPQqvh0gd+Bq1TPlTIDkEYZsv0MUQsnX8gyG+kX/q5mtlZcjId
	gGWN4SvFadjSH5ARxCfdytHBkRWt1wXqAxP+2wDDOmXM2cnOW/wshVtEwDt+gnWDLL9eb/vLHU5
	gUElugf36DztRtM6xT+bLWISapSatg==
X-Received: by 2002:a05:6000:2303:b0:42f:a025:92b3 with SMTP id
 ffacd0b85a97d-4342d3895a7mr7282018f8f.2.1768493256065; Thu, 15 Jan 2026
 08:07:36 -0800 (PST)
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
In-Reply-To: <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 17:07:24 +0100
X-Gm-Features: AZwV_QiiOfVz5MjHOOW7TnQI8q-5ZkSKoahnBApAROcQQgB7iPXfsZHV_rRz004
Message-ID: <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
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

On Thu, Jan 15, 2026 at 4:42=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 15/01/2026 04:23, Christoph Hellwig escreveu:
>
> [...]
>
> >
> > I still wonder what the use case is here.  Looking at Andr=C3=A9's orig=
inal
> > mail it states:
> >
> > "However, btrfs mounts may have volatiles UUIDs. When mounting the exac=
t same
> > disk image with btrfs, a random UUID is assigned for the following disk=
s each
> > time they are mounted, stored at temp_fsid and used across the kernel a=
s the
> > disk UUID. `btrfs filesystem show` presents that. Calling statfs() howe=
ver
> > shows the original (and duplicated) UUID for all disks."
> >
> > and this doesn't even talk about multiple mounts, but looking at
> > device_list_add it seems to only set the temp_fsid flag when set
> > same_fsid_diff_dev is set by find_fsid_by_device, which isn't documente=
d
> > well, but does indeed seem to be done transparently when two file syste=
ms
> > with the same fsid are mounted.
> >
> > So Andr=C3=A9, can you confirm this what you're worried about?  And btr=
fs
> > developers, I think the main problem is indeed that btrfs simply allows
> > mounting the same fsid twice.  Which is really fatal for anything using
> > the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uuid use=
r.
> >
>
> Yes, I'm would like to be able to mount two cloned btrfs images and to
> use overlayfs with them. This is useful for SteamOS A/B partition scheme.
>
> >> If so, I think it's time to revert the behavior before it's too late.
> >> Currently the main usage of such duplicated fsids is for Steam deck to
> >> maintain A/B partitions, I think they can accept a new compat_ro flag =
for
> >> that.
> >
> > What's an A/B partition?  And how are these safely used at the same tim=
e?
> >
>
> The Steam Deck have two main partitions to install SteamOS updates
> atomically. When you want to update the device, assuming that you are
> using partition A, the updater will write the new image in partition B,
> and vice versa. Then after the reboot, the system will mount the new
> image on B.
>

And what do you expect to happen wrt overlayfs when switching from
image A to B?

What are the origin file handles recorded in overlayfs index from image A
lower worth when the lower image is B?

Is there any guarantee that file handles are relevant and point to the
same objects?

The whole point of the overlayfs index feature is that overlayfs inodes
can have a unique id across copy-up.

Please explain in more details exactly which overlayfs setup you are
trying to do with index feature.

FWIW, the setup you are describing sounds very familiar.
I am pretty sure that a similar setup with squashfs and OpenWRT [1]
was the use case to add the uuid=3Doff overlayfs mount options.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/32532923.JtPX5UtSzP@fgdesktop/

