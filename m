Return-Path: <linux-fsdevel+bounces-16208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1189A249
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C202821E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B13C171078;
	Fri,  5 Apr 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVEHykrA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F3171071
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333843; cv=none; b=uWKuVgEBKR1lC9MTp60/jnLTCbgfw03veeHOZeVko0t6jsJUXVXA5ybk0Kz9bMAHsJhYknfbILgBin3xwpSyZJoC4svN580lm7IEtW2dSHNFzzjud3eoFFJFzv0aFTp7bhOyt93rsX2SAoYn/NpVJpYE/72fouaTaE8BeGfzlg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333843; c=relaxed/simple;
	bh=j716WYDU0zb0H2uuy4hHEplZfYbF0j3LIHYAPbe3P6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h2j6CrZm2PJs8vKcAZjXtKWx8BjcHKPqXrs8D7QIcedu8+LYNHJxyyYuOrHDAD3YbWaeWRpUvsF2aixLKPJVLx1LH37o51N103iBPy0cwCbS2l9ikIoMavEHkWp58Kx6dxl2GZ8eavIEq3HkNCQwjGb+pC9Gti1jmuy/msLmDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVEHykrA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6f571so37650057b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712333840; x=1712938640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoSUIQYaNKaGvx64DEEXghUVYuXiy/5Rfij5Qo8Lt4c=;
        b=FVEHykrAJ/p73yXgDlqYM4y6cllN8qykWbT51Xzi5EGZDg63Xe9kBl5m3wuw3kare6
         AJYQj8II5Tnwqr6bWby4UgmW99WFyewuzJCxKjAoGqP3tMwrXg+L5qwIb1NysJcpOWml
         iSSE8lkAipXznjI/6q2KC9yyGwEUoZH22ZE6w59epjL1KHaWG+bFEuz+2D2d6jzcZ1Pq
         kbgr6KB2+BVlFR3jU8yCTF9KB7VmTd4DpZIqydImiRdTvxSRsWCeEbhur2DLQUnaTwdn
         KdYJDI7oQWtFAtZ104N2IoI80Bb3L6NXGi3O+LEVShO5CKlx4vK0ZiWTkWyY2itMFISx
         VEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333840; x=1712938640;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CoSUIQYaNKaGvx64DEEXghUVYuXiy/5Rfij5Qo8Lt4c=;
        b=MujTle/deL0VfJ9MsWDG6eCTt6svaXNGb1p42K+Ql7XokaeU71R4Uem0NhK3FvUk0b
         BloKiK8L0bmmGynnVv35NuhDR/tb8ZgfaX8zeCn1BsHOz6U+RyaiLGC8p+bvcpJOWECL
         OaEzpEh7QdjoP/7Vx2HaqnfYWBGIjUCedyQBiD6t/s4165ltO1RovtgiNusHedTLEm2Y
         DdukcOkAOqDku9hIjOj8FfTYIFIPJFMUCqWEJUc+vxhLZnoP35tbt2OhkB+CxQJU5OGT
         J4EnHNmzIRNIkbnMCYFahws8O+ecxxykVTTbX7NxawhwzrYNK+e18jBGSitOHkeMvMcb
         LJxg==
X-Forwarded-Encrypted: i=1; AJvYcCX8J8Majwk+ueAlkkgcfqf63W0jZYZxLt58shZVTXM9msKF53wyP6fFxGaRe79aQ+2YqBR6fNM/wfq14nMflTvY9wJNtWEhhQSclJvOqg==
X-Gm-Message-State: AOJu0YxPdWdPjKkW2FNJ1lYDxJAMJA1FHlcBQ8f0MfbuSrOS3YxqbKYq
	ShKHozff3Hj0EAckM3toxdPlGhdVX6wr6wHHSGByJ5tfuM9Xow7hZ/uqUHdzFEHXb1X8LddLovG
	KNg==
X-Google-Smtp-Source: AGHT+IHHNZE/n0jwc4h4g/MzWUN+xVU4zPXAE7amnzx7Sl7JYDbpvJd/bhSG1U/dk7eH7CDgknQIDonL8OE=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:6382:b0:615:df:f4bc with SMTP id
 hp2-20020a05690c638200b0061500dff4bcmr475443ywb.4.1712333840634; Fri, 05 Apr
 2024 09:17:20 -0700 (PDT)
Date: Fri, 5 Apr 2024 18:17:17 +0200
In-Reply-To: <20240403.In2aiweBeir2@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com> <20240327131040.158777-2-gnoack@google.com>
 <20240327.eibaiNgu6lou@digikod.net> <ZgxOYauBXowTIgx-@google.com> <20240403.In2aiweBeir2@digikod.net>
Message-ID: <ZhAkDW2u3GItsody@google.com>
Subject: Re: [PATCH v13 01/10] landlock: Add IOCTL access right for character
 and block devices
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 01:15:45PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, Apr 02, 2024 at 08:28:49PM +0200, G=C3=BCnther Noack wrote:
> > On Wed, Mar 27, 2024 at 05:57:31PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > On Wed, Mar 27, 2024 at 01:10:31PM +0000, G=C3=BCnther Noack wrote:
> > > > +	case FIOQSIZE:
> > > > +		/*
> > > > +		 * FIOQSIZE queries the size of a regular file or directory.
> > > > +		 *
> > > > +		 * This IOCTL command only applies to regular files and
> > > > +		 * directories.
> > > > +		 */
> > > > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > >=20
> > > This should always be allowed because do_vfs_ioctl() never returns
> > > -ENOIOCTLCMD for this command.  That's why I wrote
> > > vfs_masked_device_ioctl() this way [1].  I think it would be easier t=
o
> > > read and maintain this code with a is_masked_device_ioctl() logic.  L=
isting
> > > commands that are not masked makes it difficult to review because
> > > allowed and denied return codes are interleaved.
> >=20
> > Oh, I misunderstood you on [2], I think -- I was under the impression t=
hat you
> > wanted to keep the switch case in the same order (and with the same ent=
ries?) as
> > the original in do_vfs_ioctl.  So you'd prefer to only list the always-=
allowed
> > IOCTL commands here, as you have done in vfs_masked_device_ioctl() [3]?
> >=20
> > [2] https://lore.kernel.org/all/20240326.ooCheem1biV2@digikod.net/
> > [3] https://lore.kernel.org/all/20240219183539.2926165-1-mic@digikod.ne=
t/
>=20
> That was indeed unclear.  About IOCTL commands, the same order ease
> reviewing and maintenance but we don't need to list all commands,
> which will limit updates of this list.  However, for the current
> unused/unmasked one, we can still add them very briefly in comments as I
> did with FIONREAD and file_ioctl()'s ones in vfs_masked_device_ioctl().
> Only listing the "masked" ones (for device case) shorten the list, and
> having a list with the same semantic ("mask device-specific IOCTLs")
> ease review and maintenance as well.
>=20
> >=20
> > Can you please clarify how you make up your mind about what should be p=
ermitted
> > and what should not?  I have trouble understanding the rationale for th=
e changes
> > that you asked for below, apart from the points that they are harmless =
and that
> > the return codes should be consistent.
>=20
> The rationale is the same: all IOCTL commands that are not
> passed/specific to character or block devices (i.e. IOCTLs defined in
> fs/ioctl.c) are allowed.  vfs_masked_device_ioctl() returns true if the
> IOCTL command is not passed to the related device driver but handled by
> fs/ioctl.c instead (i.e. handled by the VFS layer).

Thanks for clarifying -- this makes more sense now.  I traced the cases wit=
h
-ENOIOCTLCMD through the code more thoroughly and it is more aligned now wi=
th
what you implemented before.  The places where I ended up implementing it
differently to your vfs_masked_device_ioctl() patch are:

 * Do not blanket-permit FS_IOC_{GET,SET}{FLAGS,XATTR}.
   They fall back to the device implementation.

 * FS_IOC_GETUUID and FS_IOC_GETFSSYSFSPATH are now handled.
   These return -ENOIOCTLCMD from do_vfs_ioctl(), so they do fall back to t=
he
   handlers in struct file_operations, so we can not permit these either.

These seem like pretty clear cases to me.


> > The criteria that I have used in this patch set are that (a) it is impl=
emented
> > in do_vfs_ioctl() rather than further below, and (b) it makes sense to =
use that
> > command on a device file.  (If we permit FIOQSIZE, FS_IOC_FIEMAP and ot=
hers
> > here, we will get slightly more correct error codes in these cases, but=
 the
> > IOCTLs will still not work, because they are not useful and not impleme=
nted for
> > devices. -- On the other hand, we are also increasing the exposed code =
surface a
> > bit.  For example, FS_IOC_FIEMAP is calling into inode->i_op->fiemap().=
  That is
> > probably harmless for device files, but requires us to reason at a deep=
er level
> > to convince ourselves of that.)
>=20
> FIOQSIZE is fully handled by do_vfs_ioctl(), and FS_IOC_FIEMAP is
> implemented as the inode level, so it should not be passed at the struct
> file/device level unless ENOIOCTLCMD is returned (but it should not,
> right?).  Because it depends on the inode implementation, it looks like
> this IOCTL may work (in theory) on character or block devices too.  If
> this is correct, we should not deny it because the semantic of
> LANDLOCK_ACCESS_FS_IOCTL_DEV is to control IOCTLs passed to device
> drivers.  Furthermore, as you pointed out, error codes would be
> unaltered.
>=20
> It would be good to test (as you suggested IIRC) the masked commands on
> a simple device (e.g. /dev/null) to check that it returns ENOTTY,
> EOPNOTSUPP, or EACCES according to our expectations.

Sounds good, I'll add a test.


> I agree that this would increase a bit the exposed code surface but I'm
> pretty sure that if a sandboxed process is allowed to access a device
> file, it is also allowed to access directory or other file types as well
> and then would still be able to reach the FS_IOC_FIEMAP implementation.

I assume you mean FIGETBSZ?  The FS_IOC_FIEMAP IOCTL is the one that return=
s
file extent maps, so that user space can reason about whether a file is sto=
red
in a consecutive way on disk.


> I'd like to avoid exceptions as in the current implementation of
> get_required_ioctl_dev_access() with a switch/case either returning 0 or
> LANDLOCK_ACCESS_FS_IOCTL_DEV (excluding the default case of course).  An
> alternative approach would be to group IOCTL command cases according to
> their returned value, but I find it a bit more complex for no meaningful
> gain.  What do you think?

I don't have strong opinions about it, as long as we don't accidentally mes=
s up
the fallbacks if this changes.


> > In your implementation at [3], you were permitting FICLONE* and FIDEDUP=
ERANGE,
> > but not FS_IOC_ZERO_RANGE, which is like fallocate().  How are these ca=
ses
> > different to each other?  Is that on purpose?
>=20
> FICLONE* and FIDEDUPERANGE match device files and the
> vfs_clone_file_range()/generic_file_rw_checks() check returns EINVAL for
> device files.  So there is no need to add exceptions for these commands.
>=20
> FS_IOC_ZERO_RANGE is only implemented for regular files (see
> file_ioctl() call), so it is passed to device files.

Makes sense :)


=E2=80=94G=C3=BCnther

