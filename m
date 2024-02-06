Return-Path: <linux-fsdevel+bounces-10423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8126584AFE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 09:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46541C23EEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 08:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04D812B161;
	Tue,  6 Feb 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5FcuUUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D812AAF6;
	Tue,  6 Feb 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207900; cv=none; b=jl2+M6kP8lo38Fd3gH6Whnr2FgRrxLMgm+ntLN/YmI+UXYIwGa91Jx5o9qhQ69dkJlicnZD8/+2yTQxSLRDb7Y0bAbH/r8KQoYeiOCsySP+R5x5V9KoUmJThiRym4bjGmwqOsBG7URDvgWfvnCb3nl3MTonSp9Zk7eEos9ttgv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207900; c=relaxed/simple;
	bh=X/L1gjIUUtX0kI2V+7LgpEWJjGlNkaFiW5R2AxG8xts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ct8kwR9ocu8MtifYp/k5RphWRHhDGeuchTNBH1uRfP/+A1dfE4pXVUQY7ZhqwAqXO8MvOp1meqXS6PP6QRRKOAlHMvNEhN3fw6LSax//uoUKpN2Sw5uxJjh4ikou/xDiDU57dqtj7xcgABq+P+PfNdqrTBz495vy2y3MBm+d9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5FcuUUb; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-783d4b3ad96so340510385a.3;
        Tue, 06 Feb 2024 00:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207897; x=1707812697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJnh/hZwLgWNEfFoS0DdwaPWX2fntWPodX2RriYMeW8=;
        b=P5FcuUUbyQLdEdm2FzuwsUlN+uuNNETGSb8E0uCPEO7s1gXTsk/fQ5RAlDsY6REOGP
         YZOpJ66IOCThCukZCoykJmZIl5ULj8RRLdiRvctD5PFCL3kPJbohzoDvJssdN4uIyGFa
         L8j09rMqAgKKUiUn7Z6seDPScja9CsVI8j/AYICVo/PBpfBjBsYG0agm3BZGifmpdYmh
         +wsVVZW9Qzd70w6eYc7TfcHZG09a4xkMMxH90wj7qFlBDN6WjXICcYCQGjRvoDZewYhG
         fXgxn6+iXRTVRFQfzj0VZcJwjFY+WBvaqOusWrXwUa/YvQuteMu47tOMgQ+vb7bbT+lZ
         +mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207897; x=1707812697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJnh/hZwLgWNEfFoS0DdwaPWX2fntWPodX2RriYMeW8=;
        b=GUoxlwySZJC2V4tMm7NAvNRTuBQIlmHPHQpJEX0bABMKPnh/cZ9r+w8NXAouaduaLk
         Zuoi4qRNnVwy28RpCQVPuF9sHqvCqPvb6KKhWaojEwDE10Lk+oP+bJmfWROPmxa7P0d9
         ndx05NtNLv5axv5GlBmMfQcFJ/NWfYlEFfE4UPHSJfDFVnMr8O2zvkHQwYQcPvRiesMU
         mKBFK3TJX6ZO+6Qb5tJ9xojx/bDObgm5i/ai/mkNAcqhPIa/HCHXeD8P3OZC5D73ODV2
         /XWfY90vq1GsUWVbEOaU5jAXu6i5tLrTl584Ctl97PE3QjoJfu3ofqAr7xm1ukChkL7c
         h8hg==
X-Gm-Message-State: AOJu0Yx2VnfzIxhiGDb9Looeo29ybnGQlFSGJ/IZ864Ra6d5EbrHC1S7
	YUF29qCvoqIiMuOaqYuX+bSLu0cVlUVjQHiUdBYHYewkxT4cunVbHV8fqpCGS+OQVhO1fMNItHz
	KadUsHcPe+1ATMolcV3Du5sUfV9s=
X-Google-Smtp-Source: AGHT+IGXqi4PAj7TUaBvOsy8jESmmmnmPMJhVrfK/FpfU5yWKUUDHXIKx2eSRTrGXTZRCuV+q1/jMEgqnONnIm2x0TU=
X-Received: by 2002:ad4:5de3:0:b0:68c:805e:e354 with SMTP id
 jn3-20020ad45de3000000b0068c805ee354mr2122756qvb.38.1707207897461; Tue, 06
 Feb 2024 00:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-3-kent.overstreet@linux.dev> <ZcFelmKPb374aebH@dread.disaster.area>
 <l2zdnuczo24zxc6z6hh7q5mmux3wr5iltscnrc7axdugt6ct2k@qzrpj6vc2ct5>
In-Reply-To: <l2zdnuczo24zxc6z6hh7q5mmux3wr5iltscnrc7axdugt6ct2k@qzrpj6vc2ct5>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 10:24:45 +0200
Message-ID: <CAOQ4uxjvEL4P4vV5SKpHVS5DtOwKpxAn4n4+Kfqawcu+H-MC5g@mail.gmail.com>
Subject: Re: [PATCH 2/6] fs: FS_IOC_GETUUID
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.or, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:49=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Feb 06, 2024 at 09:17:58AM +1100, Dave Chinner wrote:
> > On Mon, Feb 05, 2024 at 03:05:13PM -0500, Kent Overstreet wrote:
> > > Add a new generic ioctls for querying the filesystem UUID.
> > >
> > > These are lifted versions of the ext4 ioctls, with one change: we're =
not
> > > using a flexible array member, because UUIDs will never be more than =
16
> > > bytes.
> > >
> > > This patch adds a generic implementation of FS_IOC_GETFSUUID, which
> > > reads from super_block->s_uuid; FS_IOC_SETFSUUID is left for individu=
al
> > > filesystems to implement.
> > >

It's fine to have a generic implementation, but the filesystem should
have the option to opt-in for a specific implementation.

There are several examples, even with xfs and btrfs where ->s_uuid
does not contain the filesystem's UUID or there is more than one
uuid and ->s_uuid is not the correct one to expose to the user.

A model like ioctl_[gs]etflags() looks much more appropriate
and could be useful for network filesystems/FUSE as well.

> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Dave Chinner <dchinner@redhat.com>
> > > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > > Cc: Theodore Ts'o <tytso@mit.edu>
> > > Cc: linux-fsdevel@vger.kernel.or
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > ---
> > >  fs/ioctl.c              | 16 ++++++++++++++++
> > >  include/uapi/linux/fs.h | 16 ++++++++++++++++
> > >  2 files changed, 32 insertions(+)
> > >
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index 76cf22ac97d7..858801060408 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -763,6 +763,19 @@ static int ioctl_fssetxattr(struct file *file, v=
oid __user *argp)
> > >     return err;
> > >  }
> > >
> > > +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > > +{
> > > +   struct super_block *sb =3D file_inode(file)->i_sb;
> > > +
> > > +   if (WARN_ON(sb->s_uuid_len > sizeof(sb->s_uuid)))
> > > +           sb->s_uuid_len =3D sizeof(sb->s_uuid);
> >
> > A "get"/read only ioctl should not be change superblock fields -
> > this is not the place for enforcing superblock filed constraints.
> > Make a helper function super_set_uuid(sb, uuid, uuid_len) for the
> > filesystems to call that does all the validity checking and then
> > sets the superblock fields appropriately.
>
> *nod* good thought...
>
> > > +struct fsuuid2 {
> > > +   __u32       fsu_len;
> > > +   __u32       fsu_flags;
> > > +   __u8        fsu_uuid[16];
> > > +};
> >
> > Nobody in userspace will care that this is "version 2" of the ext4
> > ioctl. I'd just name it "fs_uuid" as though the ext4 version didn't
> > ever exist.
>
> I considered that - but I decided I wanted the explicit versioning,
> because too often we live with unfixed mistakes because versioning is
> ugly, or something?
>
> Doing a new revision of an API should be a normal, frequent thing, and I
> want to start making it a convention.
>
> >
> > > +
> > >  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl def=
initions */
> > >  #define FILE_DEDUPE_RANGE_SAME             0
> > >  #define FILE_DEDUPE_RANGE_DIFFERS  1
> > > @@ -215,6 +229,8 @@ struct fsxattr {
> > >  #define FS_IOC_FSSETXATTR          _IOW('X', 32, struct fsxattr)
> > >  #define FS_IOC_GETFSLABEL          _IOR(0x94, 49, char[FSLABEL_MAX])
> > >  #define FS_IOC_SETFSLABEL          _IOW(0x94, 50, char[FSLABEL_MAX])
> > > +#define FS_IOC_GETFSUUID           _IOR(0x94, 51, struct fsuuid2)
> > > +#define FS_IOC_SETFSUUID           _IOW(0x94, 52, struct fsuuid2)
> >
> > 0x94 is the btrfs ioctl space, not the VFS space - why did you
> > choose that? That said, what is the VFS ioctl space identifier? 'v',
> > perhaps?
>
> "Promoting ioctls from fs to vfs without revising and renaming
> considered harmful"... this is a mess that could have been avoided if we
> weren't taking the lazy route.
>
> And 'v' doesn't look like it to me, I really have no idea what to use
> here. Does anyone?
>

All the other hoisted FS_IOC_* use the original fs ioctl namespace they
came from. Although it is not an actual hoist, I'd use:

struct fsuuid128 {
       __u32       fsu_len;
       __u32       fsu_flags;
       __u8        fsu_uuid[16];
};

#define FS_IOC_GETFSUUID              _IOR('f', 45, struct fsuuid128)
#define FS_IOC_SETFSUUID              _IOW('f', 46, struct fsuuid128)

Technically, could also overload EXT4_IOC_[GS]ETFSUUID numbers
because of the different type:

#define FS_IOC_GETFSUUID              _IOR('f', 44, struct fsuuid128)
#define FS_IOC_SETFSUUID              _IOW('f', 44, struct fsuuid128)

and then ext4 can follow up with this patch, because as far as I can tell,
the ext4 implementation is already compatible with the new ioctls.

Thanks,
Amir.

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1613,8 +1613,10 @@ static long __ext4_ioctl(struct file *filp,
unsigned int cmd, unsigned long arg)
                return ext4_ioctl_setlabel(filp,
                                           (const void __user *)arg);

+       case FS_IOC_GETFSUUID:
         case EXT4_IOC_GETFSUUID:
                 return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg)=
;
+       case FS_IOC_SETFSUUID:
         case EXT4_IOC_SETFSUUID:
                 return ext4_ioctl_setuuid(filp, (const void __user *)arg);

