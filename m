Return-Path: <linux-fsdevel+bounces-15878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB9895560
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DFC289A5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871FF60B96;
	Tue,  2 Apr 2024 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxipwPnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6574262;
	Tue,  2 Apr 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064468; cv=none; b=AanRzXHctAPndTtoYbgt0w68B5WNQI9pGDI3lGDQ8vIF6f/GkIKPLjLWxdqHmYOzwyCOZCK0oBkAbv2OYE9Y0LHjktgEU11Cs77spn7suMLslvTrsvnOYBBgee4KOxxO3dOLAChHehTONeVFTAScWPepqv1zTLJ9yVckPIXx7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064468; c=relaxed/simple;
	bh=mYNIPdxH5KxSzLuIfO+yTSUItPuT/1s1MntJffRenyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPCp3o4E07PPTGuLVgwXcn58Ub16hXBL0PG4A6nth6ZU/IqrQydi2z7pb9EqIW9PXumYHRuR08I0fm5PH9PCW2brAXG9IYfO6mkZ9XksIvK1B31bAQpmXOybFxWxkEJKaK1oul9ZP0mXwROttCj2UDLxEN8KaKzNSUSaxoTi43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxipwPnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDE4C433F1;
	Tue,  2 Apr 2024 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712064468;
	bh=mYNIPdxH5KxSzLuIfO+yTSUItPuT/1s1MntJffRenyA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YxipwPnzcWSOQMMwS6tXEEBI2BDEojR2qK63F1u6Ivjwx/boMdTjbyuBhWaGRFX8m
	 jmMkGrnVo8KZbWwi31014wCxIUEiecGt0qXorcWAgEJYhNQUHCUZ/gYiUYUi34/FqS
	 sgZGXTg1lJ0mmSnGFSkD6tPT+ugoSJJ8AhkBG3EtqXeQb1svZCGYU5C3E1sqfA9L2j
	 F3Y0dRjzL5ymJooiGmqjhX7BcWjGnjFhWrEXm19C1vsUWZy1FsvX7akN0ADz+kQgGq
	 YHeqh0HToioMJ3HiKRx/H1EzIr4FpFhO03KhfxR3pFv7NuS01CYn3JCc52SPtnRblP
	 hFGgF7MWfxiEw==
Message-ID: <f6bbdf158f0ca7a12de9b9f980d4d7fa31399ed9.camel@kernel.org>
Subject: Re: [PATCH v2] fuse: allow FUSE drivers to declare themselves free
 from outside changes
From: Jeff Layton <jlayton@kernel.org>
To: Bernd Schubert <bernd.schubert@fastmail.fm>, Miklos Szeredi
	 <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 02 Apr 2024 09:27:46 -0400
In-Reply-To: <8a8e8c0d-7878-4289-b490-cb9bf17e56b9@fastmail.fm>
References: <20240402-setlease-v2-1-b098a5f9295d@kernel.org>
	 <8a8e8c0d-7878-4289-b490-cb9bf17e56b9@fastmail.fm>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-02 at 15:23 +0200, Bernd Schubert wrote:
>=20
> On 4/2/24 15:10, Jeff Layton wrote:
> > Traditionally, we've allowed people to set leases on FUSE inodes.  Some
> > FUSE drivers are effectively local filesystems and should be fine with
> > kernel-internal lease support. Others are backed by a network server
> > that may have multiple clients, or may be backed by something non-file
> > like entirely. On those, we don't want to allow leases.
> >=20
> > Have the filesytem driver to set a fuse_conn flag to indicate whether
> > the inodes are subject to outside changes, not done via kernel APIs.  I=
f
> > the flag is unset (the default), then setlease attempts will fail with
> > -EINVAL, indicating that leases aren't supported on that inode.
> >=20
> > Local-ish filesystems may want to start setting this value to true to
> > preserve the ability to set leases.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > This is only tested for compilation, but it's fairly straightforward.
> >=20
> > I've left the default the "safe" value of false, so that we assume that
> > outside changes are possible unless told otherwise.
> > ---
> > Changes in v2:
> > - renamed flag to FUSE_NO_OUTSIDE_CHANGES
> > - flesh out comment describing the new flag
> > ---
> >  fs/fuse/file.c            | 11 +++++++++++
> >  fs/fuse/fuse_i.h          |  5 +++++
> >  fs/fuse/inode.c           |  4 +++-
> >  include/uapi/linux/fuse.h |  1 +
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index a56e7bffd000..79c7152c0d12 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -3298,6 +3298,16 @@ static ssize_t fuse_copy_file_range(struct file =
*src_file, loff_t src_off,
> >  	return ret;
> >  }
> > =20
> > +static int fuse_setlease(struct file *file, int arg,
> > +			 struct file_lease **flp, void **priv)
> > +{
> > +	struct fuse_conn *fc =3D get_fuse_conn(file_inode(file));
> > +
> > +	if (fc->no_outside_changes)
> > +		return generic_setlease(file, arg, flp, priv);
> > +	return -EINVAL;
> > +}
> > +
> >  static const struct file_operations fuse_file_operations =3D {
> >  	.llseek		=3D fuse_file_llseek,
> >  	.read_iter	=3D fuse_file_read_iter,
> > @@ -3317,6 +3327,7 @@ static const struct file_operations fuse_file_ope=
rations =3D {
> >  	.poll		=3D fuse_file_poll,
> >  	.fallocate	=3D fuse_file_fallocate,
> >  	.copy_file_range =3D fuse_copy_file_range,
> > +	.setlease	=3D fuse_setlease,
> >  };
> > =20
> >  static const struct address_space_operations fuse_file_aops  =3D {
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index b24084b60864..49d44a07b0db 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -860,6 +860,11 @@ struct fuse_conn {
> >  	/** Passthrough support for read/write IO */
> >  	unsigned int passthrough:1;
> > =20
> > +	/** Can we assume that the only changes will be done via the local
> > +	 *  kernel? If the driver represents a network filesystem or is a fro=
nt
> > +	 *  for data that can change on its own, set this to false. */
> > +	unsigned int no_outside_changes:1;
> > +
> >  	/** Maximum stack depth for passthrough backing files */
> >  	int max_stack_depth;
> > =20
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 3a5d88878335..f33aedccdb26 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1330,6 +1330,8 @@ static void process_init_reply(struct fuse_mount =
*fm, struct fuse_args *args,
> >  			}
> >  			if (flags & FUSE_NO_EXPORT_SUPPORT)
> >  				fm->sb->s_export_op =3D &fuse_export_fid_operations;
> > +			if (flags & FUSE_NO_OUTSIDE_CHANGES)
> > +				fc->no_outside_changes =3D 1;
> >  		} else {
> >  			ra_pages =3D fc->max_read / PAGE_SIZE;
> >  			fc->no_lock =3D 1;
> > @@ -1377,7 +1379,7 @@ void fuse_send_init(struct fuse_mount *fm)
> >  		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
> >  		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
> >  		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
> > -		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
> > +		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_NO_OUTSIDE_CHANGES;
> >  #ifdef CONFIG_FUSE_DAX
> >  	if (fm->fc->dax)
> >  		flags |=3D FUSE_MAP_ALIGNMENT;
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index d08b99d60f6f..703d149d45ff 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -463,6 +463,7 @@ struct fuse_file_lock {
> >  #define FUSE_PASSTHROUGH	(1ULL << 37)
> >  #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
> >  #define FUSE_HAS_RESEND		(1ULL << 39)
> > +#define FUSE_NO_OUTSIDE_CHANGES	(1ULL << 40)
>=20
> Above all of these flags are comments explaining the flags, so that one
> doesn't need to look up in kernel sources what the exact meaning is.
>=20
> Could you please add something like below?
>=20
> FUSE_NO_OUTSIDE_CHANGES: No file changes through other mounts / clients
>=20

Definitely. I've added that in my local branch. I can either resend
later, or maybe Miklos can just add that if he's otherwise OK with this
patch.

--=20
Jeff Layton <jlayton@kernel.org>

