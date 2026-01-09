Return-Path: <linux-fsdevel+bounces-73072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED9DD0B863
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C586630318CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96D364E92;
	Fri,  9 Jan 2026 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqlIXH02"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973830DEAD
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978571; cv=none; b=d1Kvj34NrdAKuz9vJs53jU4aKZaXxvDbncjuNgHsa8j56q39bQVhSqJ5sd1iqiJ/f9+l4KjTknemqdlV2tCP7n93SA4sw+KpTfOxrQMd/3AZ5Rqhza/MGJp0AwYDjWDE5llxs24i5/HeY5ApksmlRLw6fO2Yf9wbGFgyY7/l/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978571; c=relaxed/simple;
	bh=CmmC3NzlCTnOQbz4Ij7QmBHDhBb/WMIocxB9pzKpeoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHmD7oZGLk7q/5ZaT4/K4WG4JYBRRWeJv0qjobGYMqgt6imCkMnGnfQkGzfnx1XuopHVitI0g7DumvtHolTvnlf4fAsQ/nsyCdQg00jNFKNrCV6uQ3dQxRPOtS6AoYIIyZzt2894yGVKzjPF5eaU5KfP2AzWZwk1zfwjkplRwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqlIXH02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6B6C4CEF1
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767978571;
	bh=CmmC3NzlCTnOQbz4Ij7QmBHDhBb/WMIocxB9pzKpeoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NqlIXH02rDdtTYfTQ0NhQZYEpFm8uNgYTuql9ORmjvUoPG3aUxPsI5nnbvvVEPI+V
	 jx1r+GtyyAF/9uxCylR2SwfxHSOBfjakDHRriK2D7/PtFwfMTNdaWKQ4ZHcsTFV8tq
	 S2O7FS0XnV2xrEbzBvktV1UZuwl8OkFt7dNrFpfJOryTymQvWcM1qcVijCseicu+pt
	 jMrAhYecI0m6Wr0ah/R0vzztuZp4P/P6U++/vW5fCshATYenl/wlGaZJf2fng/d1WN
	 gMAJlNJ9bCUfODzt+pXAc2LnLyoXEt6+1ZQ4hg9Nk+/LoH6pdzZE+KKrFX2zY1K/70
	 p9ADt5Tktdmgw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7ffa5d1b80so672750666b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 09:09:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9NVBRe+W/783FLl8PNycg69+py8XMb7VcLUaMN0gIk8EnHp2PrkVUIDM2l+X1ME6M980eG+XvYKqQz28f@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSYLAhKFI7YwZ5CZ5eoNXiWz1HhW/AQCh7uHf70Wgq0mRE5WV
	I9t4KGCK2mEQfqKQ7f0SVXQ7oxJMkFp+tCqHib5vm8GydWWz7Tbg2LfNNPsBSMCzFXFDclFttS4
	BIW8PiQNluEcSyswrDae4GxVAl3oZcd0=
X-Google-Smtp-Source: AGHT+IHtdU3Ba+HS2MP5A8puWjvbeDMt3AIgA6tutRjgeki7znqHviULA03UAFqEJgO1j+1H5uKJ6vF+kcwvIv8IVFU=
X-Received: by 2002:a17:907:9603:b0:b73:210a:44e with SMTP id
 a640c23a62f3a-b8444f4f675mr984174866b.30.1767978570170; Fri, 09 Jan 2026
 09:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767801889.git.fdmanana@suse.com> <a56191f13dc946951f94ddec1dc714991576d38f.1767801889.git.fdmanana@suse.com>
 <20260108214838.GO21071@twin.jikos.cz>
In-Reply-To: <20260108214838.GO21071@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 9 Jan 2026 17:08:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5svDGgRO5aMoB_bdWCQECvtPe1KMWv554ijTDw2y8k5g@mail.gmail.com>
X-Gm-Features: AQt7F2pP5UnoyMr0w_5RW0_lm7rrUo3DIW4lBozNwDrYLOiy_XDmOApMceXvnK0
Message-ID: <CAL3q7H5svDGgRO5aMoB_bdWCQECvtPe1KMWv554ijTDw2y8k5g@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs: use may_create_dentry() in btrfs_mksubvol()
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:48=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Thu, Jan 08, 2026 at 01:35:34PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There is no longer the need to use btrfs_may_create(), which was a copy
> > of the VFS private function may_create(), since now that functionality
> > is exported by the VFS as a function named may_create_dentry(). So chan=
ge
> > btrfs_mksubvol() to use the VFS function and remove btrfs_may_create().
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/ioctl.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 0cb3cd3d05a5..9cf37459ef6d 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -815,19 +815,6 @@ static int create_snapshot(struct btrfs_root *root=
, struct inode *dir,
> >       return ret;
> >  }
> >
> > -/* copy of may_create in fs/namei.c() */
> > -static inline int btrfs_may_create(struct mnt_idmap *idmap,
> > -                                struct inode *dir, const struct dentry=
 *child)
> > -{
>
> The difference to the VFS version is lack of audit_inode_child() in
> this place, so this may be good to mention in the changelog.
> Functionally the audit subsystem missed the event of subvolume creation.

I'll add that to the changelog in the next version, after getting
comments from the VFS people.

>
> > -     if (d_really_is_positive(child))
> > -             return -EEXIST;
> > -     if (IS_DEADDIR(dir))
> > -             return -ENOENT;
> > -     if (!fsuidgid_has_mapping(dir->i_sb, idmap))
> > -             return -EOVERFLOW;
> > -     return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
> > -}

