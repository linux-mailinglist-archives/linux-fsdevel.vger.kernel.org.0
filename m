Return-Path: <linux-fsdevel+bounces-57896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA13B26824
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3441C25A89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC13009F0;
	Thu, 14 Aug 2025 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="XeMACWsP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49002FCC1A;
	Thu, 14 Aug 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179272; cv=none; b=jXeq86UvLUnN7dV7yydmDurWfQ0BeJ/adhQT0rRdGgqhOTWLmRTJIogYRNclSRtqKlXjyBIk1YLAJwy9WxjRjM7435lwevufZUVYvyJHGEqK/dB06bdXC001rdUM2itXf0Hgoirm0wY5D/ZJTuruA01WIGVYKmZoiSuLXz5VWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179272; c=relaxed/simple;
	bh=bHLlQ+i7MUaszUfOEpThaWyGiB8ftDea67xt4jpYH7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwDjR5mpsMn8Q5WWY6LcLEYqzPuguB3+ZSQzTAdlH/rNTDRNxNxCiAuJwqrj+8XLjHshRDoG0+3R7/Zvty8YwXow1g3H1ww0zKBEiuxbh6SJUURE/m9VPtKzQRupE6PEM45RFH9W1UzrkNZVYm93fpeVxwXWIjip9u1IQqycn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=XeMACWsP; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c2mlJ3KJSz9slm;
	Thu, 14 Aug 2025 15:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755179260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uki2al884XzKP49qjOl830kb/sNWeIrrfQ7gI47948k=;
	b=XeMACWsPRRrEdyomOJfL2aOqZ1Synd5sgH4SEZXXzDfB+5pL8EC8Y0ZnSAjUy+m+fzaTUK
	i7qQCHAp/Qy/Uqo+BDd67QyoFeFYa+g78T4cVS028jxGqgkM1AKk+gqqxxQ+KkBjcDz1oC
	pxt6QyTzPkqyBe2V92fayiGQ7H83hhX527Kg5+0fYiIy3gREAuKgErRQjosUnpdbLhdppl
	KnDnUXjk4GTQmMxljRAImWegqc3LCbGS9jwS850U4n4PdEU7udVUV0cJ3zei2som0C8oSX
	oi3omMpBPyOlNeRlvCDpJvEUdES9vJnjPaN8/vQJgetV714WYHsasKtUQWCkTw==
Date: Thu, 14 Aug 2025 23:47:24 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: fix mount options not being applied
Message-ID: <2025-08-14.1755177392-elderly-somber-portal-duress-1AbFcr@cyphar.com>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
 <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
 <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
 <2025-08-14.1755150554-popular-erased-gallons-heroism-gRtAbX@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gbonwdwtpt3b6c5h"
Content-Disposition: inline
In-Reply-To: <2025-08-14.1755150554-popular-erased-gallons-heroism-gRtAbX@cyphar.com>


--gbonwdwtpt3b6c5h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] debugfs: fix mount options not being applied
MIME-Version: 1.0

On 2025-08-14, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2025-08-05, Eric Sandeen <sandeen@redhat.com> wrote:
> > On 8/4/25 12:22 PM, Eric Sandeen wrote:
> > > On 8/4/25 9:30 AM, Charalampos Mitrodimas wrote:
> > >> Mount options (uid, gid, mode) are silently ignored when debugfs is
> > >> mounted. This is a regression introduced during the conversion to the
> > >> new mount API.
> > >>
> > >> When the mount API conversion was done, the line that sets
> > >> sb->s_fs_info to the parsed options was removed. This causes
> > >> debugfs_apply_options() to operate on a NULL pointer.
> > >>
> > >> As an example, with the bug the "mode" mount option is ignored:
> > >>
> > >>   $ mount -o mode=3D0666 -t debugfs debugfs /tmp/debugfs_test
> > >>   $ mount | grep debugfs_test
> > >>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
> > >>   $ ls -ld /tmp/debugfs_test
> > >>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
> > >=20
> > > Argh. So, this looks a lot like the issue that got fixed for tracefs =
in:
> > >=20
> > > e4d32142d1de tracing: Fix tracefs mount options
> > >=20
> > > Let me look at this; tracefs & debugfs are quite similar, so perhaps
> > > keeping the fix consistent would make sense as well but I'll dig
> > > into it a bit more.
> >=20
> > So, yes - a fix following the pattern of e4d32142d1de does seem to reso=
lve
> > this issue.
> >=20
> > However, I think we might be playing whack-a-mole here (fixing one fs a=
t a time,
> > when the problem is systemic) among filesystems that use get_tree_singl=
e()
> > and have configurable options. For example, pstore:
> >=20
> > # umount /sys/fs/pstore=20
> >=20
> > # mount -t pstore -o kmsg_bytes=3D65536 none /sys/fs/pstore
> > # mount | grep pstore
> > none on /sys/fs/pstore type pstore (rw,relatime,seclabel)
> >=20
> > # mount -o remount,kmsg_bytes=3D65536 /sys/fs/pstore
> > # mount | grep pstore
> > none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=3D6=
5536)
> > #
>=20
> Isn't this just a standard consequence of the classic "ignore mount
> flags if we are reusing a superblock" behaviour? Not doing this can lead
> to us silently clearing security-related flags ("acl" is the common
> example used) and was the main reason for FSCONFIG_CMD_CREATE_EXCL.
>=20
> Maybe for some filesystems (like debugfs), it makes sense to permit a
> mount operation to silently reconfigure existing mounts, but this should
> be an opt-in knob per-filesystem.
>=20
> Also, if we plan to do this then you almost certainly want to have
> fs_context track which set of parameters were set and then only
> reconfigure those parameters *which were set*. At the moment,
> fs_context_for_reconfigure() works around this by having the current
> sb_flags and other configuration be loaded via init_fs_context(), but if
> you do an auto-reconfigure with an fs_context created for mounting then
> you won't inherit _any_ of the old mount options. This could lead to a
> situation like:
>=20
>   % mount -t pstore -o ro /sys/fs/pstore
>   % mount -t pstore -o kmsg_bytes=3D65536 /tmp
>   % # /sys/fs/pstore is now rw.
>=20
> Which is really not ideal, as it would make it incredibly fragile for
> anyone to try to mount these filesystems without breaking other mounts
> on the system.
>=20
> If fs_context tracked which parameters were configured and only applied
> the set ones, at least you would avoid unintentionally unsetting
> parameters of the original mount.

My mistake, fs_context does this already with fc->sb_flags_mask. That
leaves each filesystem to handle this properly for fc->s_fs_info, and
the ones I've checked _do_ handle this properly -- false alarm! (I
missed this on the first pass-through.)

I guess then that this is more of a question of what users expect. I
agree with what David Howells was quoted as saying, which is that
silently doing this is really suboptimal. I still feel that logging a
warning is more preferable -- if the VFS can be told whether
fc->s_fs_info diverges from sb->s_fs_info, then we can log a warning (or
alternatively, it could be done by each filesystem and VFS does it for
the generic s_flags).

This is arguably more practical than FSCONFIG_CMD_CREATE_EXCL for most
users because it could give you feedback on what parameters were
problematic, and if there was no warning then you don't need to worry
about the mount sharing a superblock. FSCONFIG_CMD_CREATE_EXCL would
then only be needed for truly paranoid programs. AFAICS, mount(8) does
now forward warning messages from fclog, so this would mean admins would
be able to see the warning immediately from their mount(8) call. Older
mount(2)-based users would see it in dmesg.

I can take a look writing a patch for this?

> FWIW, cgroupv1 has a warning when this situation happens (see the
> pr_warn() in cgroup1_root_to_use()). I always wondered why this wasn't
> done on the VFS level, as a warning is probably enough to alert admins
> about this behaviour without resorting to implicitly changing the mount
> options of existing mounts.
>
> > I think gadgetfs most likely has the same problem but I'm not yet sure
> > how to test that.
> >=20
> > I have no real objection to merging your patch, though I like the
> > consistency of following e4d32142d1de a bit more. But I think we should
> > find a graceful solution so that any filesystem using get_tree_single
> > can avoid this pitfall, if possible.
> >=20
> > -Eric

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--gbonwdwtpt3b6c5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJ3o7BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8uFAD8D6BvKVqzSuguwXOZR87r
x3LVUElRso6HkG56g8pV8aIA/3VeQxywwXuC+Xm7tGcH0y8jmFl0E2j0zA7Fvg93
NmIJ
=/t/I
-----END PGP SIGNATURE-----

--gbonwdwtpt3b6c5h--

