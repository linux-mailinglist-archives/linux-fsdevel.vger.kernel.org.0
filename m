Return-Path: <linux-fsdevel+bounces-57972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D52FB27406
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 02:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1376917682B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 00:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5D1224F3;
	Fri, 15 Aug 2025 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="YJNnbf9+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C0A926;
	Fri, 15 Aug 2025 00:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217930; cv=none; b=E0e/FIuwLjoQGXwJtzaAsNu0UvKv0V6ZMZKbSqyuxBG7gCdWiYXdX1tI+FQzQDycvprRBZMXppoWLUq7POxzQe80t2JDFzuznS8a01VhDl4gB2ddzIXHbjF4CCcvPOgyCq+xQfaXgH4+w94pJIJJRuCIwPj/ywXvLhs6eRxwbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217930; c=relaxed/simple;
	bh=1chIFQllrPlz9PLJOracfgqd4kyuKIRNz1vM6K+Tis0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9qRsr2v+8D0oIqsgAvqYZO2zzIxslOzmg1qlr5bX4iXA4rKWPin6IRG/u1TbgdKTiVLSUdIkNRURyXK0CVlBkvy4qPhwUV7cSzJwAekyUB7OcX9LfdeQp9GsTddfheLXeWh5qByuM81cLocRrn+n3NcU69v2pH6LBcu7S2oxh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=YJNnbf9+; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c332r2FDPz9t4F;
	Fri, 15 Aug 2025 02:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755217924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZp1+BVkotkbD/PROhzy1/cfpyOyTYGkfMmmos6foy8=;
	b=YJNnbf9+agPik7mBB1D3/2pFv/TIFsvCQRbGxEeFO9y5Lbm+GMr8QqZxRv8BNWJCV9opQH
	kdtpHtNTiKhjFXPnjXFfnQ1Jc7dV1c7IS6h8fTgsi7oCCLbKMiy+/8ZLIR4YbmPFFHc87H
	9qHMwl3LI3djrr5Xcap5VDnqn6DlyjT6IYhOLwHxj2IaPrha8QlWyt0fweTlLpVf/ipWok
	iR9u1qrxuRvBUfVjqDskNE0t63X3U3eiYJKzKsr9Sxc5fUFivviz/mzFm47d6HINvo92Hc
	2OjL94FNwcJUeH206v6Xf52Ju4AGmkBCk3hvs4NXFt03Fp5bjVQrHTRiOmSNIw==
Date: Fri, 15 Aug 2025 10:31:50 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: fix mount options not being applied
Message-ID: <2025-08-14.1755193201-hissy-crazy-vista-margins-KHQ5fV@cyphar.com>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
 <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
 <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
 <2025-08-14.1755150554-popular-erased-gallons-heroism-gRtAbX@cyphar.com>
 <1dcf4661-97c2-4727-b4c5-f05785196dcb@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2hdzz3jnxmpgoaa6"
Content-Disposition: inline
In-Reply-To: <1dcf4661-97c2-4727-b4c5-f05785196dcb@sandeen.net>


--2hdzz3jnxmpgoaa6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] debugfs: fix mount options not being applied
MIME-Version: 1.0

On 2025-08-14, Eric Sandeen <sandeen@sandeen.net> wrote:
> On 8/14/25 4:05 AM, Aleksa Sarai wrote:
> > On 2025-08-05, Eric Sandeen <sandeen@redhat.com> wrote:
> >> On 8/4/25 12:22 PM, Eric Sandeen wrote:
> >>> On 8/4/25 9:30 AM, Charalampos Mitrodimas wrote:
> >>>> Mount options (uid, gid, mode) are silently ignored when debugfs is
> >>>> mounted. This is a regression introduced during the conversion to the
> >>>> new mount API.
> >>>>
> >>>> When the mount API conversion was done, the line that sets
> >>>> sb->s_fs_info to the parsed options was removed. This causes
> >>>> debugfs_apply_options() to operate on a NULL pointer.
> >>>>
> >>>> As an example, with the bug the "mode" mount option is ignored:
> >>>>
> >>>>   $ mount -o mode=3D0666 -t debugfs debugfs /tmp/debugfs_test
> >>>>   $ mount | grep debugfs_test
> >>>>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
> >>>>   $ ls -ld /tmp/debugfs_test
> >>>>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
> >>>
> >>> Argh. So, this looks a lot like the issue that got fixed for tracefs =
in:
> >>>
> >>> e4d32142d1de tracing: Fix tracefs mount options
> >>>
> >>> Let me look at this; tracefs & debugfs are quite similar, so perhaps
> >>> keeping the fix consistent would make sense as well but I'll dig
> >>> into it a bit more.
> >>
> >> So, yes - a fix following the pattern of e4d32142d1de does seem to res=
olve
> >> this issue.
> >>
> >> However, I think we might be playing whack-a-mole here (fixing one fs =
at a time,
> >> when the problem is systemic) among filesystems that use get_tree_sing=
le()
> >> and have configurable options. For example, pstore:
> >>
> >> # umount /sys/fs/pstore=20
> >>
> >> # mount -t pstore -o kmsg_bytes=3D65536 none /sys/fs/pstore
> >> # mount | grep pstore
> >> none on /sys/fs/pstore type pstore (rw,relatime,seclabel)
> >>
> >> # mount -o remount,kmsg_bytes=3D65536 /sys/fs/pstore
> >> # mount | grep pstore
> >> none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=3D=
65536)
> >> #
> >=20
> > Isn't this just a standard consequence of the classic "ignore mount
> > flags if we are reusing a superblock" behaviour? Not doing this can lead
> > to us silently clearing security-related flags ("acl" is the common
> > example used) and was the main reason for FSCONFIG_CMD_CREATE_EXCL.
>=20
> Perhaps, but I think it is a change in behavior since before the mount
> API change. On Centos Stream 8 (sorry, that was the handy VM I had around=
) ;)
>=20
> <fresh boot>
>=20
> # mount | grep pstore
> pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime,sec=
label)
>=20
> # umount /sys/fs/pstore=20
> # mount -t pstore -o kmsg_bytes=3D65536 none /sys/fs/pstore
> # mount | grep pstore
> none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=3D655=
36)
>=20
> (kmsg_bytes was accepted on older kernel, vs not in prior example on new =
kernel)
>=20
> # mount -o remount,kmsg_bytes=3D65536 /sys/fs/pstore
> # mount | grep pstore
> none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=3D655=
36)
>=20
> remount behaves as expected...

Yes, you're quite right.

I was mostly thinking about the later discussion about making this
generic. Though I think even for filesystems that want this feature (or
have to have it because of back-compat) we should still emit some kind
of warning (or at least an informational message if it is opt-in?). This
superblock reuse behaviour is basically undocumented (though I am
including it in the new fsconfig(2) man pages, finally) and so it seems
prudent to actually provide this information to userspace.

For what it's worth, David Howells actually did implement a way to port
things from mount_single() and maintain the reconf-on-mount behaviour
back in commit 43ce4c1feadb ("vfs: Add a single-or-reconfig keying to
vfs_get_super()") and probably intended to port filesystems to it but
this never happened and it was removed in commit e062abaec65b ("super:
remove get_tree_single_reconf()"). Maybe he changed his mind? @David?

It's also seems a little fruity (from a userspace perspective) to me
that s_flags won't be reconfigured by this AFAICS -- this is made worse
by the fact that fsconfig(2) makes the configuration interface for
fc->sb_flags into the same one as fc->s_fs_info and so userspace doesn't
immediately see which flags are in which set. If we did make this a
generic opt-in per-filesystem maybe we would want to at least make that
bit consistent (but for bdev-backed supers we would need to keep the
current SB_RDONLY checks, obviously).

> -Eric
>=20
> > Maybe for some filesystems (like debugfs), it makes sense to permit a
> > mount operation to silently reconfigure existing mounts, but this should
> > be an opt-in knob per-filesystem.
> >=20
> > Also, if we plan to do this then you almost certainly want to have
> > fs_context track which set of parameters were set and then only
> > reconfigure those parameters *which were set*. At the moment,
> > fs_context_for_reconfigure() works around this by having the current
> > sb_flags and other configuration be loaded via init_fs_context(), but if
> > you do an auto-reconfigure with an fs_context created for mounting then
> > you won't inherit _any_ of the old mount options. This could lead to a
> > situation like:
> >=20
> >   % mount -t pstore -o ro /sys/fs/pstore
> >   % mount -t pstore -o kmsg_bytes=3D65536 /tmp
> >   % # /sys/fs/pstore is now rw.
> >=20
> > Which is really not ideal, as it would make it incredibly fragile for
> > anyone to try to mount these filesystems without breaking other mounts
> > on the system.
> >=20
> > If fs_context tracked which parameters were configured and only applied
> > the set ones, at least you would avoid unintentionally unsetting
> > parameters of the original mount.
> >=20
> > FWIW, cgroupv1 has a warning when this situation happens (see the
> > pr_warn() in cgroup1_root_to_use()). I always wondered why this wasn't
> > done on the VFS level, as a warning is probably enough to alert admins
> > about this behaviour without resorting to implicitly changing the mount
> > options of existing mounts.
> >=20
> >> I think gadgetfs most likely has the same problem but I'm not yet sure
> >> how to test that.
> >>
> >> I have no real objection to merging your patch, though I like the
> >> consistency of following e4d32142d1de a bit more. But I think we should
> >> find a graceful solution so that any filesystem using get_tree_single
> >> can avoid this pitfall, if possible.
> >>
> >> -Eric
> >>
> >>
> >=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--2hdzz3jnxmpgoaa6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJ5/9hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9M8wD/dy67DoEuCUQugjGKsOMQ
ERAtFgLB3/bZQhSowIALMK8A/250lzYpineV5jCI5QKl348qMejjboh7eTHxkqaz
TB8E
=rPKZ
-----END PGP SIGNATURE-----

--2hdzz3jnxmpgoaa6--

