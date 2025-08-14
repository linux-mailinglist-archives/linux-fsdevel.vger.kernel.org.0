Return-Path: <linux-fsdevel+bounces-57862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D455B26074
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 11:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2013C1CC6C56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 09:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130222F1FF0;
	Thu, 14 Aug 2025 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="GVdboG4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D042F0C79;
	Thu, 14 Aug 2025 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162381; cv=none; b=gARsB0vZWtkIsxxCd27Dztsz3J3JVNcFV2MtDjEFpvHDOewupEXxwx6Mhg8kq/TDaAZMJERxug1lKRMDo57eI3I7mOn82r7W/7xJ7t2hpQuiRA0XxE7liLZV/2eMNXhnPwnGQCzvArK07baQdGswJrfOg2gbUz+EN+ZxGTqtIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162381; c=relaxed/simple;
	bh=+XJpVvE21WVU+tDwJtwUMcf+cpwAT3a4rqX+R/I98SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTtj1R3S9fJrgyW0AC5MTG6w5raWLqRs90Vqjmec6DbReWzEv22woT30YdYBYv5JeSFsOJumi3iQ4NbAAxNmJGjxolSiu2DvkBVL0PiJO6EKHUO0v9vQjfYYrGq5DGWciWa2PK/PiF655jHNBgg7iCQhEtsbm33CvM/L1uIrrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=GVdboG4L; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c2fVS6h9yz9tN7;
	Thu, 14 Aug 2025 11:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755162369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lacvlhHJko7L0Zj6YG5wxeTUhnJTGJ0YL0dgP7IGeWE=;
	b=GVdboG4L5KZoaptfllgH24liXxsavAQOp9I98NcbdJIHCM55+9MtqWQ+pA2RLe/E64f9Ep
	Bib+9Qx5GEbgVw6lcI4Rk587wP3wis/UjDYrsJbye3q9fKUjw3mflYMle/93hX+Hvu2fGm
	zMiQQmqe3zg+QMTwJ8hd6PYt0illza6t2ZhuvrgzqHGJbnLA4rYzvH3m/+aPALCpfumEYm
	WycH2iBsodwsuaxAp5EaVR/gcigj+zUl9J9aVK6nuOM7z0S1iGrE3BHTd7hz99BbJZKzI4
	i6iAEgKPfm9H+XJKj73O13SKuDz92ZX2q8LJX9rU//YFQNCmBB7eH4HLyMXhhQ==
Date: Thu, 14 Aug 2025 19:05:55 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: fix mount options not being applied
Message-ID: <2025-08-14.1755150554-popular-erased-gallons-heroism-gRtAbX@cyphar.com>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
 <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
 <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qnujrbhe3dicbnwt"
Content-Disposition: inline
In-Reply-To: <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>


--qnujrbhe3dicbnwt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] debugfs: fix mount options not being applied
MIME-Version: 1.0

On 2025-08-05, Eric Sandeen <sandeen@redhat.com> wrote:
> On 8/4/25 12:22 PM, Eric Sandeen wrote:
> > On 8/4/25 9:30 AM, Charalampos Mitrodimas wrote:
> >> Mount options (uid, gid, mode) are silently ignored when debugfs is
> >> mounted. This is a regression introduced during the conversion to the
> >> new mount API.
> >>
> >> When the mount API conversion was done, the line that sets
> >> sb->s_fs_info to the parsed options was removed. This causes
> >> debugfs_apply_options() to operate on a NULL pointer.
> >>
> >> As an example, with the bug the "mode" mount option is ignored:
> >>
> >>   $ mount -o mode=3D0666 -t debugfs debugfs /tmp/debugfs_test
> >>   $ mount | grep debugfs_test
> >>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
> >>   $ ls -ld /tmp/debugfs_test
> >>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
> >=20
> > Argh. So, this looks a lot like the issue that got fixed for tracefs in:
> >=20
> > e4d32142d1de tracing: Fix tracefs mount options
> >=20
> > Let me look at this; tracefs & debugfs are quite similar, so perhaps
> > keeping the fix consistent would make sense as well but I'll dig
> > into it a bit more.
>=20
> So, yes - a fix following the pattern of e4d32142d1de does seem to resolve
> this issue.
>=20
> However, I think we might be playing whack-a-mole here (fixing one fs at =
a time,
> when the problem is systemic) among filesystems that use get_tree_single()
> and have configurable options. For example, pstore:
>=20
> # umount /sys/fs/pstore=20
>=20
> # mount -t pstore -o kmsg_bytes=3D65536 none /sys/fs/pstore
> # mount | grep pstore
> none on /sys/fs/pstore type pstore (rw,relatime,seclabel)
>=20
> # mount -o remount,kmsg_bytes=3D65536 /sys/fs/pstore
> # mount | grep pstore
> none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=3D655=
36)
> #

Isn't this just a standard consequence of the classic "ignore mount
flags if we are reusing a superblock" behaviour? Not doing this can lead
to us silently clearing security-related flags ("acl" is the common
example used) and was the main reason for FSCONFIG_CMD_CREATE_EXCL.

Maybe for some filesystems (like debugfs), it makes sense to permit a
mount operation to silently reconfigure existing mounts, but this should
be an opt-in knob per-filesystem.

Also, if we plan to do this then you almost certainly want to have
fs_context track which set of parameters were set and then only
reconfigure those parameters *which were set*. At the moment,
fs_context_for_reconfigure() works around this by having the current
sb_flags and other configuration be loaded via init_fs_context(), but if
you do an auto-reconfigure with an fs_context created for mounting then
you won't inherit _any_ of the old mount options. This could lead to a
situation like:

  % mount -t pstore -o ro /sys/fs/pstore
  % mount -t pstore -o kmsg_bytes=3D65536 /tmp
  % # /sys/fs/pstore is now rw.

Which is really not ideal, as it would make it incredibly fragile for
anyone to try to mount these filesystems without breaking other mounts
on the system.

If fs_context tracked which parameters were configured and only applied
the set ones, at least you would avoid unintentionally unsetting
parameters of the original mount.

FWIW, cgroupv1 has a warning when this situation happens (see the
pr_warn() in cgroup1_root_to_use()). I always wondered why this wasn't
done on the VFS level, as a warning is probably enough to alert admins
about this behaviour without resorting to implicitly changing the mount
options of existing mounts.

> I think gadgetfs most likely has the same problem but I'm not yet sure
> how to test that.
>=20
> I have no real objection to merging your patch, though I like the
> consistency of following e4d32142d1de a bit more. But I think we should
> find a graceful solution so that any filesystem using get_tree_single
> can avoid this pitfall, if possible.
>=20
> -Eric
>=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--qnujrbhe3dicbnwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJ2m8xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+LUwEA/YTqvTuDzgW3sNLhhWr4
xlAACWxs6hdbvYr9j7HUyWUBAOATZI4eh774t30KP8d172hMH35ciJ8cV8fn+4w1
6OIC
=yPCb
-----END PGP SIGNATURE-----

--qnujrbhe3dicbnwt--

