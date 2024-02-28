Return-Path: <linux-fsdevel+bounces-13076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE786AF94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 13:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B1C1F22BBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242C1487D8;
	Wed, 28 Feb 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OuuJHsgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA1673515
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125073; cv=none; b=Lm2ah9hbnsxy3jzCUa8Ys4xAIND0M2u1gAsmbFVF/GfRADI+NvE6AdHJ3tI3LFmbtHeeyFBDNzqi1C4cSsReTalzHw0aPw+tSYtKqkbZLuUr2EcuRAW8U8n6UFboQUAPbD2agB3hlsa9eAv/T59px0X5Mo0Ei59sjfCYizt5JVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125073; c=relaxed/simple;
	bh=zDo1OzW4AgnETJN+fRsFFSob0utDNqq7UlQ4KDR5Xek=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=vEP6ImouacQELFaTePR9Rc003I1fzmRqdfsUXHxxnTk5tEswcsekfn97GvNi9TUSZaNKM4F+sYRU2DcGlixojlsH0XLObu/5GvvcIO6auQYsRE++S9Q0aqKyRQu7fIG9VE+dAd+4AKP3k+s9QfEGjqqpgpqyl0yDo8AoYnU8uS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OuuJHsgZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60810219282so66214947b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 04:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709125070; x=1709729870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqY54rxLnjWhCyCRLfvQRVLRKusznOlKvNW0owLeT7Q=;
        b=OuuJHsgZMtSzKuFh9g4DxxKlYeHkEhRWLXSK5mIidinJzM/llzgliAJzDH0CJhtEyt
         RzhKIHodkLUGhLybjpaEUOYXfqkrwcNEvE5rrv/dIb1ucBk7Nm8NgyIfnSQHk6gykVDu
         e317L2bOm7QhwvPonr4D4YhKL5IYHffDMnTiExXiLx4S+Hnbd2bX3LmMIQrhYBLAxU5R
         Tse2vSxFIeQAlzGhdYURguxraJD6XQm9Dqyv0KZIsZRGqEl8Bd8hthhbZvzLNKhhu8p3
         4JwMUVVD07GDruJ8e6IC2bRT7C7m6rz4u4m7MQKU7d0p+uwJKz0gyn4YV7EKxZJyWFnW
         0BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125070; x=1709729870;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oqY54rxLnjWhCyCRLfvQRVLRKusznOlKvNW0owLeT7Q=;
        b=ZauAk4/XrKTBGDGELJ1/MZFKanOP1UikAs+IqkXvOfF8cpL7KpL8fTEIWnOkZDa4cy
         R++EHQjTkLSMUpcWPg5OVOO24XRHHqJAad+T7qE0LBN9f5O7e6FxZDdLgMG37ih8qFTt
         LgAPYwcKYgitNqIGmvMb9tCc7/y17jgPCa5l0AgQ/fMgjbfBGe1o0oBg8yDZhDhg6sOU
         vNIwXjCxe53npEPAh692Our2yCg86q1W7WUdSZvfmQWyzLAEo0m4cXL2c/POwDZnhYuv
         D+owrxs4tigaLo43jshOELRQdurSAoyUcSFz2eMxcgqPB5fr5qDulPPN5CS2gb0WFwex
         f+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvFjNh38Wdsg59twRao2fYnlTTutkKfVxNQZvscS9D2VRxZD8/NeQ4CabpCaSriGrirKFgjkq/HHtHnNHyBZE0yLtIrx3Ms6OP4S8+Dw==
X-Gm-Message-State: AOJu0YwJzG0TB9df50pZviGUZ9Hw1ZeUsJ6z9cYcoD7CQnXOyZ2cqLn/
	0yJILlhYlhpsvsGG2JDxWBhxUX2hEaHs226rxj9x1l2ESy9BApqWFGX8bdrWv1KJJiD6hvE6XBe
	/Sw==
X-Google-Smtp-Source: AGHT+IEKJ83J/kvGPncQFihK+CF9avrpsVmX6L1EVJOOZe4NFh/07vKdSwxWQ4qMpfpZkFYUK3AzpG6fLjQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:81f8:4290:4f71:82e3])
 (user=gnoack job=sendgmr) by 2002:a0d:e696:0:b0:608:66be:2f71 with SMTP id
 p144-20020a0de696000000b0060866be2f71mr975790ywe.9.1709125070223; Wed, 28 Feb
 2024 04:57:50 -0800 (PST)
Date: Wed, 28 Feb 2024 13:57:42 +0100
In-Reply-To: <20240219.chu4Yeegh3oo@digikod.net>
Message-Id: <Zd8txvjeeXjRdeP-@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com> <20240209170612.1638517-2-gnoack@google.com>
 <20240219.chu4Yeegh3oo@digikod.net>
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Micka=C3=ABl!

On Mon, Feb 19, 2024 at 07:34:42PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Arn, Christian, please take a look at the following RFC patch and the
> rationale explained here.
>=20
> On Fri, Feb 09, 2024 at 06:06:05PM +0100, G=C3=BCnther Noack wrote:
> > Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
> > and increments the Landlock ABI version to 5.
> >=20
> > Like the truncate right, these rights are associated with a file
> > descriptor at the time of open(2), and get respected even when the
> > file descriptor is used outside of the thread which it was originally
> > opened in.
> >=20
> > A newly enabled Landlock policy therefore does not apply to file
> > descriptors which are already open.
> >=20
> > If the LANDLOCK_ACCESS_FS_IOCTL right is handled, only a small number
> > of safe IOCTL commands will be permitted on newly opened files.  The
> > permitted IOCTLs can be configured through the ruleset in limited ways
> > now.  (See documentation for details.)
> >=20
> > Specifically, when LANDLOCK_ACCESS_FS_IOCTL is handled, granting this
> > right on a file or directory will *not* permit to do all IOCTL
> > commands, but only influence the IOCTL commands which are not already
> > handled through other access rights.  The intent is to keep the groups
> > of IOCTL commands more fine-grained.
> >=20
> > Noteworthy scenarios which require special attention:
> >=20
> > TTY devices are often passed into a process from the parent process,
> > and so a newly enabled Landlock policy does not retroactively apply to
> > them automatically.  In the past, TTY devices have often supported
> > IOCTL commands like TIOCSTI and some TIOCLINUX subcommands, which were
> > letting callers control the TTY input buffer (and simulate
> > keypresses).  This should be restricted to CAP_SYS_ADMIN programs on
> > modern kernels though.
> >=20
> > Some legitimate file system features, like setting up fscrypt, are
> > exposed as IOCTL commands on regular files and directories -- users of
> > Landlock are advised to double check that the sandboxed process does
> > not need to invoke these IOCTLs.
>=20
> I think we really need to allow fscrypt and fs-verity IOCTLs.
>=20
> >=20
> > Known limitations:
> >=20
> > The LANDLOCK_ACCESS_FS_IOCTL access right is a coarse-grained control
> > over IOCTL commands.  Future work will enable a more fine-grained
> > access control for IOCTLs.
> >=20
> > In the meantime, Landlock users may use path-based restrictions in
> > combination with their knowledge about the file system layout to
> > control what IOCTLs can be done.  Mounting file systems with the nodev
> > option can help to distinguish regular files and devices, and give
> > guarantees about the affected files, which Landlock alone can not give
> > yet.
>=20
> I had a second though about our current approach, and it looks like we
> can do simpler, more generic, and with less IOCTL commands specific
> handling.
>=20
> What we didn't take into account is that an IOCTL needs an opened file,
> which means that the caller must already have been allowed to open this
> file in read or write mode.
>=20
> I think most FS-specific IOCTL commands check access rights (i.e. access
> mode or required capability), other than implicit ones (at least read or
> write), when appropriate.  We don't get such guarantee with device
> drivers.
>=20
> The main threat is IOCTLs on character or block devices because their
> impact may be unknown (if we only look at the IOCTL command, not the
> backing file), but we should allow IOCTLs on filesystems (e.g. fscrypt,
> fs-verity, clone extents).  I think we should only implement a
> LANDLOCK_ACCESS_FS_IOCTL_DEV right, which would be more explicit.  This
> change would impact the IOCTLs grouping (not required anymore), but
> we'll still need the list of VFS IOCTLs.


I am fine with dropping the IOCTL grouping and going for this simpler appro=
ach.

This must have been a misunderstanding - I thought you wanted to align the
access checks in Landlock with the ones done by the kernel already, so that=
 we
can reason about it more locally.  But I'm fine with doing it just for devi=
ce
files as well, if that is what it takes.  It's definitely simpler.

Before I jump into the implementation, let me paraphrase your proposal to m=
ake
sure I understood it correctly:

 * We *only* introduce the LANDLOCK_ACCESS_FS_IOCTL_DEV right.

 * This access right governs the use of nontrivial IOCTL commands on
   character and block device files.

   * On open()ed files which are not character or block devices,
     all IOCTL commands keep working.

     This includes pipes and sockets, but also a variety of "anonymous" fil=
e
     types which are possibly openable through /proc/self/*/fd/*?

 * The trivial IOCTL commands are identified using the proposed function
   vfs_masked_device_ioctl().

   * For these commands, the implementations are in fs/ioctl.c, except for
     FIONREAD, in some cases.  We trust these implementations to check the
     file's type (dir/regular) and access rights (r/w) correctly.


Open questions I have:

* What about files which are neither devices nor regular files or directori=
es?

  The obvious ones which can be open()ed are pipes, where only FIONREAND an=
d two
  harmless-looking watch queue IOCTLs are implemented.

  But then I think that /proc/*/fd/* is a way through which other non-devic=
e
  files can become accessible?  What do we do for these?  (I am getting EAC=
CES
  when trying to open some anon_inodes that way... is this something we can
  count on?)

* How did you come up with the list in vfs_masked_device_ioctl()?  I notice=
 that
  some of these are from the switch() statement we had before, but not all =
of
  them are included.

  I can kind of see that for the fallocate()-like ones and for FIBMAP, beca=
use
  these **only** make sense for regular files, and IOCTLs on regular files =
are
  permitted anyway.

* What do we do for FIONREAD?  Your patch says that it should be forwarded =
to
  device implementations.  But technically, devices can implement all kinds=
 of
  surprising behaviour for that.

  If you look at the ioctl implementations of different drivers, you can ve=
ry
  quickly find a surprising amount of things that happen completely indepen=
dent
  of the IOCTL command.  (Some implementations are acquiring locks and othe=
r
  resources before they even check what the cmd value is. - and we would be
  exposing that if we let devices handle FIONREAD).


Please let me know whether I understood you correctly there.

Regarding the implementation notes you left below, I think they mostly deri=
ve
from the *_IOCTL_DEV approach in a direct way.


> > +static __attribute_const__ access_mask_t
> > +get_required_ioctl_access(const unsigned int cmd)
> > +{
> > +	switch (cmd) {
> > +	case FIOCLEX:
> > +	case FIONCLEX:
> > +	case FIONBIO:
> > +	case FIOASYNC:
> > +		/*
> > +		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
> > +		 * close-on-exec and the file's buffered-IO and async flags.
> > +		 * These operations are also available through fcntl(2), and are
> > +		 * unconditionally permitted in Landlock.
> > +		 */
> > +		return 0;
> > +	case FIONREAD:
> > +	case FIOQSIZE:
> > +	case FIGETBSZ:
> > +		/*
> > +		 * FIONREAD returns the number of bytes available for reading.
> > +		 * FIONREAD returns the number of immediately readable bytes for
> > +		 * a file.
> > +		 *
> > +		 * FIOQSIZE queries the size of a file or directory.
> > +		 *
> > +		 * FIGETBSZ queries the file system's block size for a file or
> > +		 * directory.
> > +		 *
> > +		 * These IOCTL commands are permitted for files which are opened
> > +		 * with LANDLOCK_ACCESS_FS_READ_DIR,
> > +		 * LANDLOCK_ACCESS_FS_READ_FILE, or
> > +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> > +		 */
>=20
> Because files or directories can only be opened with
> LANDLOCK_ACCESS_FS_{READ,WRITE}_{FILE,DIR}, and because IOCTLs can only
> be sent on a file descriptor, this means that we can always allow these
> 3 commands (for opened files).
>=20
> > +		return LANDLOCK_ACCESS_FS_IOCTL_RW;
> > +	case FS_IOC_FIEMAP:
> > +	case FIBMAP:
> > +		/*
> > +		 * FS_IOC_FIEMAP and FIBMAP query information about the
> > +		 * allocation of blocks within a file.  They are permitted for
> > +		 * files which are opened with LANDLOCK_ACCESS_FS_READ_FILE or
> > +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> > +		 */
> > +		fallthrough;
> > +	case FIDEDUPERANGE:
> > +	case FICLONE:
> > +	case FICLONERANGE:
> > +		/*
> > +		 * FIDEDUPERANGE, FICLONE and FICLONERANGE make files share
> > +		 * their underlying storage ("reflink") between source and
> > +		 * destination FDs, on file systems which support that.
> > +		 *
> > +		 * The underlying implementations are already checking whether
> > +		 * the involved files are opened with the appropriate read/write
> > +		 * modes.  We rely on this being implemented correctly.
> > +		 *
> > +		 * These IOCTLs are permitted for files which are opened with
> > +		 * LANDLOCK_ACCESS_FS_READ_FILE or
> > +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> > +		 */
> > +		fallthrough;
> > +	case FS_IOC_RESVSP:
> > +	case FS_IOC_RESVSP64:
> > +	case FS_IOC_UNRESVSP:
> > +	case FS_IOC_UNRESVSP64:
> > +	case FS_IOC_ZERO_RANGE:
> > +		/*
> > +		 * These IOCTLs reserve space, or create holes like
> > +		 * fallocate(2).  We rely on the implementations checking the
> > +		 * files' read/write modes.
> > +		 *
> > +		 * These IOCTLs are permitted for files which are opened with
> > +		 * LANDLOCK_ACCESS_FS_READ_FILE or
> > +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> > +		 */
>=20
> These 10 commands only make sense on directories, so we could also
> always allow them on file descriptors.

I imagine that's a typo?  The commands above do make sense on regular files=
.


> > +		return LANDLOCK_ACCESS_FS_IOCTL_RW_FILE;
> > +	default:
> > +		/*
> > +		 * Other commands are guarded by the catch-all access right.
> > +		 */
> > +		return LANDLOCK_ACCESS_FS_IOCTL;
> > +	}
> > +}
> > +
> > +/**
> > + * expand_ioctl() - Return the dst flags from either the src flag or t=
he
> > + * %LANDLOCK_ACCESS_FS_IOCTL flag, depending on whether the
> > + * %LANDLOCK_ACCESS_FS_IOCTL and src access rights are handled or not.
> > + *
> > + * @handled: Handled access rights.
> > + * @access: The access mask to copy values from.
> > + * @src: A single access right to copy from in @access.
> > + * @dst: One or more access rights to copy to.
> > + *
> > + * Returns: @dst, or 0.
> > + */
> > +static __attribute_const__ access_mask_t
> > +expand_ioctl(const access_mask_t handled, const access_mask_t access,
> > +	     const access_mask_t src, const access_mask_t dst)
> > +{
> > +	access_mask_t copy_from;
> > +
> > +	if (!(handled & LANDLOCK_ACCESS_FS_IOCTL))
> > +		return 0;
> > +
> > +	copy_from =3D (handled & src) ? src : LANDLOCK_ACCESS_FS_IOCTL;
> > +	if (access & copy_from)
> > +		return dst;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * landlock_expand_access_fs() - Returns @access with the synthetic IO=
CTL group
> > + * flags enabled if necessary.
> > + *
> > + * @handled: Handled FS access rights.
> > + * @access: FS access rights to expand.
> > + *
> > + * Returns: @access expanded by the necessary flags for the synthetic =
IOCTL
> > + * access rights.
> > + */
> > +static __attribute_const__ access_mask_t landlock_expand_access_fs(
> > +	const access_mask_t handled, const access_mask_t access)
> > +{
> > +	return access |
> > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_WRITE_FILE,
> > +			    LANDLOCK_ACCESS_FS_IOCTL_RW |
> > +				    LANDLOCK_ACCESS_FS_IOCTL_RW_FILE) |
> > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_FILE,
> > +			    LANDLOCK_ACCESS_FS_IOCTL_RW |
> > +				    LANDLOCK_ACCESS_FS_IOCTL_RW_FILE) |
> > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_DIR,
> > +			    LANDLOCK_ACCESS_FS_IOCTL_RW);
> > +}
> > +
> > +/**
> > + * landlock_expand_handled_access_fs() - add synthetic IOCTL access ri=
ghts to an
> > + * access mask of handled accesses.
> > + *
> > + * @handled: The handled accesses of a ruleset that is being created.
> > + *
> > + * Returns: @handled, with the bits for the synthetic IOCTL access rig=
hts set,
> > + * if %LANDLOCK_ACCESS_FS_IOCTL is handled.
> > + */
> > +__attribute_const__ access_mask_t
> > +landlock_expand_handled_access_fs(const access_mask_t handled)
> > +{
> > +	return landlock_expand_access_fs(handled, handled);
> > +}
> > +
> >  /* Ruleset management */
> > =20
> >  static struct landlock_object *get_inode_object(struct inode *const in=
ode)
> > @@ -148,7 +331,8 @@ static struct landlock_object *get_inode_object(str=
uct inode *const inode)
> >  	LANDLOCK_ACCESS_FS_EXECUTE | \
> >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> > -	LANDLOCK_ACCESS_FS_TRUNCATE)
> > +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > +	LANDLOCK_ACCESS_FS_IOCTL)
> >  /* clang-format on */
> > =20
> >  /*
> > @@ -158,6 +342,7 @@ int landlock_append_fs_rule(struct landlock_ruleset=
 *const ruleset,
> >  			    const struct path *const path,
> >  			    access_mask_t access_rights)
> >  {
> > +	access_mask_t handled;
> >  	int err;
> >  	struct landlock_id id =3D {
> >  		.type =3D LANDLOCK_KEY_INODE,
> > @@ -170,9 +355,11 @@ int landlock_append_fs_rule(struct landlock_rulese=
t *const ruleset,
> >  	if (WARN_ON_ONCE(ruleset->num_layers !=3D 1))
> >  		return -EINVAL;
> > =20
> > +	handled =3D landlock_get_fs_access_mask(ruleset, 0);
> > +	/* Expands the synthetic IOCTL groups. */
> > +	access_rights |=3D landlock_expand_access_fs(handled, access_rights);
> >  	/* Transforms relative access rights to absolute ones. */
> > -	access_rights |=3D LANDLOCK_MASK_ACCESS_FS &
> > -			 ~landlock_get_fs_access_mask(ruleset, 0);
> > +	access_rights |=3D LANDLOCK_MASK_ACCESS_FS & ~handled;
> >  	id.key.object =3D get_inode_object(d_backing_inode(path->dentry));
> >  	if (IS_ERR(id.key.object))
> >  		return PTR_ERR(id.key.object);
> > @@ -1333,7 +1520,9 @@ static int hook_file_open(struct file *const file=
)
> >  {
> >  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
> >  	access_mask_t open_access_request, full_access_request, allowed_acces=
s;
> > -	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
> > +	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE |
> > +					      LANDLOCK_ACCESS_FS_IOCTL |
> > +					      IOCTL_GROUPS;
> >  	const struct landlock_ruleset *const dom =3D get_current_fs_domain();
> > =20
> >  	if (!dom)
>=20
> We should set optional_access according to the file type before
> `full_access_request =3D open_access_request | optional_access;`
>=20
> const bool is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode)=
;
>=20
> optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
> if (is_device)
>     optional_access |=3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
>=20
>=20
> Because LANDLOCK_ACCESS_FS_IOCTL_DEV is dedicated to character or block
> devices, we may want landlock_add_rule() to only allow this access right
> to be tied to directories, or character devices, or block devices.  Even
> if it would be more consistent with constraints on directory-only access
> rights, I'm not sure about that.
>=20
>=20
> > @@ -1375,6 +1564,16 @@ static int hook_file_open(struct file *const fil=
e)
> >  		}
> >  	}
> > =20
> > +	/*
> > +	 * Named pipes should be treated just like anonymous pipes.
> > +	 * Therefore, we permit all IOCTLs on them.
> > +	 */
> > +	if (S_ISFIFO(file_inode(file)->i_mode)) {
> > +		allowed_access |=3D LANDLOCK_ACCESS_FS_IOCTL |
> > +				  LANDLOCK_ACCESS_FS_IOCTL_RW |
> > +				  LANDLOCK_ACCESS_FS_IOCTL_RW_FILE;
> > +	}
>=20
> Instead of this S_ISFIFO check:
>=20
> if (!is_device)
>     allowed_access |=3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
>=20
> > +
> >  	/*
> >  	 * For operations on already opened files (i.e. ftruncate()), it is t=
he
> >  	 * access rights at the time of open() which decide whether the
> > @@ -1406,6 +1605,25 @@ static int hook_file_truncate(struct file *const=
 file)
> >  	return -EACCES;
> >  }
> > =20
> > +static int hook_file_ioctl(struct file *file, unsigned int cmd,
> > +			   unsigned long arg)
> > +{
> > +	const access_mask_t required_access =3D get_required_ioctl_access(cmd=
);
>=20
> const access_mask_t required_access =3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
>=20
>=20
> > +	const access_mask_t allowed_access =3D
> > +		landlock_file(file)->allowed_access;
> > +
> > +	/*
> > +	 * It is the access rights at the time of opening the file which
> > +	 * determine whether IOCTL can be used on the opened file later.
> > +	 *
> > +	 * The access right is attached to the opened file in hook_file_open(=
).
> > +	 */
> > +	if ((allowed_access & required_access) =3D=3D required_access)
> > +		return 0;
>=20
> We could then check against the do_vfs_ioctl()'s commands, excluding
> FIONREAD and file_ioctl()'s commands, to always allow VFS-related
> commands:
>=20
> if (vfs_masked_device_ioctl(cmd))
>     return 0;
>=20
> As a safeguard, we could define vfs_masked_device_ioctl(cmd) in
> fs/ioctl.c and make it called by do_vfs_ioctl() as a safeguard to make
> sure we keep an accurate list of VFS IOCTL commands (see next RFC patch).


> The compat IOCTL hook must also be implemented.

Thanks!  I can't believe I missed that one.


> What do you think? Any better idea?

It seems like a reasonable approach.  I'd like to double check with you tha=
t we
are on the same page about it before doing the next implementation step.  (=
These
iterations seems cheaper when we do them in English than when we do them in=
 C.)

Thanks for the review!
=E2=80=94G=C3=BCnther

