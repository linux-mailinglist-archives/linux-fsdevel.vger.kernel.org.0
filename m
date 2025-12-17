Return-Path: <linux-fsdevel+bounces-71550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9BCC73E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86EB531309AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE81369999;
	Wed, 17 Dec 2025 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENrrwek3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3236997D
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966699; cv=none; b=NimpmCiMx7IO6h7v3cQnq7ukVc5yvNwKutu3KIMx7Y9IpyHIhC/beEYxKTfF6+15cPk7I3Uxu76jU5LKPYdxTSY835bYBtFYDs6sRAWzxH062M2tXe6afnbYGk2NiNFmWEBNiU1ShrNLCawFtpkHAjyahEyKUFsJ+Gz1iVkw7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966699; c=relaxed/simple;
	bh=ZH623Mxked0E9jOhyuXRnv3Y3jrKKlc+MHS9igx/qKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1Ni/qUn20rYKJRsrvwh9SY+JhR8vVcDmn70oxPY6gwLFxJtVUIKn7JVpPA6bMpObUIc9FNbKX8ucItJbOUyKA78dkT7Te415AWp6ti4CbYyFSTXD2f33+lrdd5YWeFbGqj9ZVc5ozyY3o+sZ5pLp0oLaGOzP/zFURCCfYy/d1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENrrwek3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so11034996a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 02:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765966695; x=1766571495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFBfThnZFJq8X5sFUNFIg5HNpPPSN0IsmIFWmRqg7zY=;
        b=ENrrwek3pPN0PXyDpFPItbXbSO65jpXKy3PcEbz+CYjm8KCfnHILr46kTeIuVx43Vc
         JOf5O27yqmGLCHIOCJ3lJytrd9msKGa9sIa7fau+kG2JQJ4Zkf0F3uExyrMyfoMlplrX
         IV05MqwNcQGX22g3oDZ6vZ6g5phgjwbyTQjIqKEkoSRCd8bXh2tKQiVquhiXqC0ADjet
         8doxMKIuaMwfz0cC1+aBqvNvTGzSBCnSul1ui7hkzPvGo7rmvZdH/7wxRF9587HkTFy7
         KwSgA/M5Lz1L2xeNJXTpUyRnkmaoJntj4ArmnfQ+xP9WCthiR6qyytF3iqPeMdmcNNnL
         Cd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765966695; x=1766571495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFBfThnZFJq8X5sFUNFIg5HNpPPSN0IsmIFWmRqg7zY=;
        b=LVYqewui6UJMKVRf6J5ijbhHhUfsvOPNb0T5+1+dOgH0oUc5S3uDVGiiuUJJJYyC/w
         cWuvPgjiP/h3bZLgSQJy6DHvgIELZuoNHZH/GtuRqo4Pw0g02Y+vZyXWRLtunKHFeTpU
         ombaDdm4D2rGJWNVOLYctJkEYJnzTqQx7pX6LkpGyt61HElvpaaj0+QStbAB0jbW5L9z
         Y3+jRSILPieKsKWrkXHp6o0mf33hpUKMYtJeKfQTEeozTHC9V4EN4J1Zm/bWHrDqxpp2
         Tykc3flG4XbELEko76hhAKekpcww/7psz1mrsczVDRZHPCLF0Z48oG5iD4eyRb8ln6Ye
         MalA==
X-Forwarded-Encrypted: i=1; AJvYcCVO/pIOCZEmA9G12G4xmz7ojhm93CLFcmEa9utDCyc+6ST1iVz0gce53l+3odDcpT77vYV/xVU/t9qDKHhO@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxlYm2gAD0EFN8/zk62CwESV+NgGMasAWcAteaY4ah6D7ZOfU
	wNk9fiNWV794zP49o71pnfomDOgdIJNbFEClF9r2hqZXULG1ac8q+76UxrGG+/e7uV2UBCrjfww
	i7YvGU+btAYmbFy5rbwymsQMOPq6C5ILJi2IaG3o=
X-Gm-Gg: AY/fxX5Gl8qOlj1CfnjKO93P188QKXKVUKJNTJG+6YYgNe9mlkhgTDsEPtkUU9o93P/
	5KSILezP4okMs4QQ8t3wE1x9lYCZlfCtZvO7xCeB6wzod+zSEAVtNc1h9/SqqNpvZHDdqem5td3
	K2h+euhWhwkPeNlMPcZLpl5HGrfzdVrwIlV45WseGQwOAdJ5RsV4LHwzaF5O3gUpWTTAHyTgGIo
	CojU0c5c/SHYkbMqPVbxa7or1PFnPhbmGveIlQIeCGZaxX3n4o0SofA+NK2NtJKsjN5eliM4eXe
	FfmeqoV0iz72ilXLc5lxkysz2HA+R4NYSTWP361o
X-Google-Smtp-Source: AGHT+IHj7o992nXYvQngWznhp7+vZ2s7+Ehl8a+vrz9MyFPVOrnsD5+6slNepvTofO3poNHH8EBQ/L2aVY8dfN6KGzY=
X-Received: by 2002:a05:6402:3508:b0:64b:4540:6ef5 with SMTP id
 4fb4d7f45d1cf-64b45407300mr755749a12.31.1765966694944; Wed, 17 Dec 2025
 02:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <76f21528-9b14-4277-8f4c-f30036884e75@ddn.com> <87ike6d4vx.fsf@wotan.olymp>
In-Reply-To: <87ike6d4vx.fsf@wotan.olymp>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 17 Dec 2025 11:18:03 +0100
X-Gm-Features: AQt7F2p6rs4x8_jj12HhDCQHBjNAOLUCNIcwg8bKzUIi0YY8LjYMwFit00uYUp4
Message-ID: <CAOQ4uxj8QO1pJC1nOh9g3UV34b1x-_EQrT382aS-_gUvhJfLig@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 12:48=E2=80=AFPM Luis Henriques <luis@igalia.com> w=
rote:
>
> On Mon, Dec 15 2025, Bernd Schubert wrote:
>
> > On 12/12/25 19:12, Luis Henriques wrote:
> >> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to i=
nclude
> >> an extra inarg: the file handle for the parent directory (if it is
> >> available).  Also, because fuse_entry_out now has a extra variable siz=
e
> >> struct (the actual handle), it also sets the out_argvar flag to true.
> >>
> >> Most of the other modifications in this patch are a fallout from these
> >> changes: because fuse_entry_out has been modified to include a variabl=
e size
> >> struct, every operation that receives such a parameter have to take th=
is
> >> into account:
> >>
> >>    CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE
> >>
> >> Signed-off-by: Luis Henriques <luis@igalia.com>
> >> ---
> >>   fs/fuse/dev.c             | 16 +++++++
> >>   fs/fuse/dir.c             | 87 ++++++++++++++++++++++++++++++-------=
--
> >>   fs/fuse/fuse_i.h          | 34 +++++++++++++--
> >>   fs/fuse/inode.c           | 69 +++++++++++++++++++++++++++----
> >>   fs/fuse/readdir.c         | 10 ++---
> >>   include/uapi/linux/fuse.h |  8 ++++
> >>   6 files changed, 189 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >> index 629e8a043079..fc6acf45ae27 100644
> >> --- a/fs/fuse/dev.c
> >> +++ b/fs/fuse/dev.c
> >> @@ -606,6 +606,22 @@ static void fuse_adjust_compat(struct fuse_conn *=
fc, struct fuse_args *args)
> >>      if (fc->minor < 4 && args->opcode =3D=3D FUSE_STATFS)
> >>              args->out_args[0].size =3D FUSE_COMPAT_STATFS_SIZE;
> >>
> >> +    if (fc->minor < 45) {
> >
> > Could we use fc->lookup_handle here? Numbers are hard with backports
>
> To be honest, I'm not sure this code is correct.  I just followed the
> pattern.  I'll need to dedicate some more time looking into this,
> specially because the READDIRPLUS op handling is still TBD.
>
> <snip>
>
> >> @@ -505,6 +535,30 @@ struct inode *fuse_iget(struct super_block *sb, u=
64 nodeid,
> >>      if (!inode)
> >>              return NULL;
> >>
> >> +    fi =3D get_fuse_inode(inode);
> >> +    if (fc->lookup_handle) {
> >> +            if ((fh =3D=3D NULL) && (nodeid !=3D FUSE_ROOT_ID)) {
> >> +                    pr_err("NULL file handle for nodeid %llu\n", node=
id);
> >> +                    iput(inode);
> >> +                    return NULL;
> >
> > Hmm, so there are conditions like "if (fi && fi->fh) {" in lookup and I
> > was thinking "nice, fuse-server can decide to skip the fh for some
> > inodes like FUSE_ROOT_ID. But now it gets forbidden here. In combinatio=
n
> > with the other comment in fuse_inode_handle_alloc(), could be allocate
> > here to the needed size and allow fuse-server to not send the handle
> > for some files?
>
> I'm not sure the code is consistent with this regard, but here I'm doing
> exactly that: allowing the fh to be NULL only for FUSE_ROOT_ID.  Or did I
> misunderstood your comment?
>

root inode is a special case.
The NFS server also does not encode the file handle for export root as
far as a I know
it just sends the special file handle type FILEID_ROOT to describe the
root inode
without any blob unique, so FUSE can do the same.

There is not much point in "looking up" the root inode neither by nodeid
nor by handle. unless is for making the code more generic.

I am not sure if FUSE server restart is supposed to revalidate the
root inode by file handle. That's kind of an administrative question about
the feature. My feeling is that it is not needed.

Thanks,
Amir.

