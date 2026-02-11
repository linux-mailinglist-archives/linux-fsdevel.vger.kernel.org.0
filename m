Return-Path: <linux-fsdevel+bounces-76936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNVAOGVsjGlmngAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 12:47:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56778123F2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 12:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA7BC300EC84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88B281525;
	Wed, 11 Feb 2026 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg23IamE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9638460
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810464; cv=none; b=AcFm7qqLAC2LYZxyzfmbfk/5Dp3KzSzhoGT1tNAvQVSvMi7xKiM+DK+X3OQdWmlwBk8df4ovrjJSPAxmzxB3M54D4b81dHxvxe84aw3p+3yIoasSj2clBj0SKq/x7ZOzA6izX1MXhjbzil3x4Ijx5VnEkGii4wbjMLxxIxjkCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810464; c=relaxed/simple;
	bh=8dZBJVIVhEK4f7afDdSFCFLP5iPBdSzN9QzjkVtv6fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM9SXT6ZCglM6TQh06y33y43uJntOb+YrQRK0DS5JleEG8/YySah7kN9m8Upnw/OOpqqQyIGZc86eJlfY6Atm4vro3954DEW830FInPIjWV7TkQlo62ys5YUDA9lOtIZwaD8ynnXTzVPUUZI7RLhhZOoRiWrho13c81W038bUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg23IamE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCD5C4CEF7;
	Wed, 11 Feb 2026 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770810463;
	bh=8dZBJVIVhEK4f7afDdSFCFLP5iPBdSzN9QzjkVtv6fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lg23IamEOyJf45oHiSuWAzlbSQvIkYQ043UQOoelfGuKKq6tDRqeLzrh1mQU4EjAL
	 as4WPP/FqCed2C3q4HhMZA4GTdIv+TUZ81rFi45ZCYJsZgxsmBtY+eo3EtoCgltzjD
	 +DxhKnE+U6Xch/Z1h/T/Znj0gdAVcw/gWgyJotfyl9NjG9v2lPGoDSYg4fsR0oNdz1
	 c9uOqowwjVe8SHfCqld4uPmL6y7IsdruHnuvkvCZ+x/j5JKfW3Fg0dhlCE5ST4qXg/
	 c8yd54dwVEJiQeR6XjW2xU0NQMyb+1e26oepDpD92Gbh7xylG0+x0o3vEfohnsKryM
	 b61m7HH8fn8xg==
Date: Wed, 11 Feb 2026 11:47:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 3/7] mount: add FSMOUNT_NAMESPACE
Message-ID: <ad810bc9-5755-416b-a810-5c1019b85b76@sirena.org.uk>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
 <20260122-work-fsmount-namespace-v1-3-5ef0a886e646@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7NOatrK2jkqGg8GL"
Content-Disposition: inline
In-Reply-To: <20260122-work-fsmount-namespace-v1-3-5ef0a886e646@kernel.org>
X-Cookie: Often things ARE as bad as they seem!
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,kernel.org,gmail.com,toxicpanda.com,cyphar.com];
	TAGGED_FROM(0.00)[bounces-76936-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sirena.org.uk:url,sirena.org.uk:mid,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 56778123F2D
X-Rspamd-Action: no action


--7NOatrK2jkqGg8GL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 22, 2026 at 11:48:48AM +0100, Christian Brauner wrote:
> Add FSMOUNT_NAMESPACE flag to fsmount() that creates a new mount
> namespace with the newly created filesystem attached to a copy of the
> real rootfs. This returns a namespace file descriptor instead of an
> O_PATH mount fd, similar to how OPEN_TREE_NAMESPACE works for open_tree().

I'm seeing a regression in the LTP fsmount02 test in yesterday's -next
on arm64 which bisect to this patch, the test reports some unexpected
successes with logs like this:

  tst_test.c:1956: TINFO: === Testing on ext2 ===
  tst_test.c:1280: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
  mke2fs 1.47.2 (1-Jan-2025)
  fsmount02.c:67: TPASS: invalid-fd: fsmount() failed as expected: EBADF (9)
  fsmount02.c:56: TFAIL: invalid-flags: fsmount() succeeded unexpectedly (index: 1)
  fsmount02.c:67: TPASS: invalid-attrs: fsmount() failed as expected: EINVAL (22)

for each filesystem it tests.

Full log:

   https://lava.sirena.org.uk/scheduler/job/2445995#L5878

Bisect log:

# bad: [fd9678829d6dd0c10fde080b536abf4b1121c346] Add linux-next specific files for 20260210
# good: [0b6f6fa3363fdb9234e4b91e4cf22b5d50bff4f7] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [a9aabb3b839aba094ed80861054993785c61462c] Merge tag 'rust-6.20-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux
# good: [1a4b0c999101b2532723f9bd9818b70ffa7580f4] regulator: mt6363: Fix interrmittent timeout
# good: [5578da7d957fbaf91f6c39ba2363c2d2e4273183] ASoC: rt721-sdca: Fix issue of fail to detect OMTP jack type
# good: [3a17ba6557e28d5d99b7e3cad31f22ad28a36cc2] mfd: sec: Add support for S2MPG11 PMIC via ACPM
# good: [fe8429a2717fc01082502b0adf680a50b230eff7] regulator: s2mps11: more descriptive gpio consumer name
# good: [6ffdc7eb48bd2268c37c2accad454c043b9cc987] regcache: Demote defaults readback from HW to debug print
# good: [20c4701b75a3d6ce09d61e17125aefe77e7eb333] dt-bindings: regulator: mark regulator-suspend-microvolt as deprecated
# good: [dccc66b0e92d48d9a1908a3ccb8142e0ee3381f5] regmap: Enable REGMAP when REGMAP_SLIMBUS is enabled
# good: [62b04225e99a5d1c71c5c73d2aa6618bc2c0738f] regulator: dt-bindings: rpi-panel: Mark 7" Raspberry Pi as GPIO controller
# good: [de9f1b1583aecb246b659effb03f2456604fab64] regulator: dt-bindings: mediatek,mt6331: Add missing ldo-vio28 vreg
# good: [b0fc1e7701940d12ea2c41f386aa552bc4cc3629] regulator: Add TPS65185 driver
# good: [09dc08b396c954820f119e1ab0c7d72333c18323] regulator: dummy, make dummy_regulator_driver static
# good: [8d38423d9dea7353a8a54a3ab2e0d0aa04ed34d0] regulator: core: don't fail regulator_register() with missing required supply
# good: [b0655377aa5a410df02d89170c20141a1a5bbc28] rust: regulator: replace `kernel::c_str!` with C-Strings
# good: [32a708ba5db50cf928a1f1b2039ceef33de2c286] regulator: Add rt8092 support
# good: [9e92c559d49d6fb903af17a31a469aac51b1766d] regulator: max77675: Add MAX77675 regulator driver
# good: [03d281f384768610bf90697bce9e35d3d596de77] rust: regulator: add __rust_helper to helpers
# good: [6c177775dcc5e70a64ddf4ee842c66af498f2c7c] Merge branch 'next/drivers' into for-next
git bisect start 'fd9678829d6dd0c10fde080b536abf4b1121c346' '0b6f6fa3363fdb9234e4b91e4cf22b5d50bff4f7' 'a9aabb3b839aba094ed80861054993785c61462c' '1a4b0c999101b2532723f9bd9818b70ffa7580f4' '5578da7d957fbaf91f6c39ba2363c2d2e4273183' '3a17ba6557e28d5d99b7e3cad31f22ad28a36cc2' 'fe8429a2717fc01082502b0adf680a50b230eff7' '6ffdc7eb48bd2268c37c2accad454c043b9cc987' '20c4701b75a3d6ce09d61e17125aefe77e7eb333' 'dccc66b0e92d48d9a1908a3ccb8142e0ee3381f5' '62b04225e99a5d1c71c5c73d2aa6618bc2c0738f' 'de9f1b1583aecb246b659effb03f2456604fab64' 'b0fc1e7701940d12ea2c41f386aa552bc4cc3629' '09dc08b396c954820f119e1ab0c7d72333c18323' '8d38423d9dea7353a8a54a3ab2e0d0aa04ed34d0' 'b0655377aa5a410df02d89170c20141a1a5bbc28' '32a708ba5db50cf928a1f1b2039ceef33de2c286' '9e92c559d49d6fb903af17a31a469aac51b1766d' '03d281f384768610bf90697bce9e35d3d596de77' '6c177775dcc5e70a64ddf4ee842c66af498f2c7c'
# test job: [a9aabb3b839aba094ed80861054993785c61462c] https://lava.sirena.org.uk/scheduler/job/2445657
# test job: [1a4b0c999101b2532723f9bd9818b70ffa7580f4] https://lava.sirena.org.uk/scheduler/job/2444892
# test job: [5578da7d957fbaf91f6c39ba2363c2d2e4273183] https://lava.sirena.org.uk/scheduler/job/2445060
# test job: [3a17ba6557e28d5d99b7e3cad31f22ad28a36cc2] https://lava.sirena.org.uk/scheduler/job/2430473
# test job: [fe8429a2717fc01082502b0adf680a50b230eff7] https://lava.sirena.org.uk/scheduler/job/2429403
# test job: [6ffdc7eb48bd2268c37c2accad454c043b9cc987] https://lava.sirena.org.uk/scheduler/job/2409190
# test job: [20c4701b75a3d6ce09d61e17125aefe77e7eb333] https://lava.sirena.org.uk/scheduler/job/2386850
# test job: [dccc66b0e92d48d9a1908a3ccb8142e0ee3381f5] https://lava.sirena.org.uk/scheduler/job/2377205
# test job: [62b04225e99a5d1c71c5c73d2aa6618bc2c0738f] https://lava.sirena.org.uk/scheduler/job/2369398
# test job: [de9f1b1583aecb246b659effb03f2456604fab64] https://lava.sirena.org.uk/scheduler/job/2368840
# test job: [b0fc1e7701940d12ea2c41f386aa552bc4cc3629] https://lava.sirena.org.uk/scheduler/job/2364654
# test job: [09dc08b396c954820f119e1ab0c7d72333c18323] https://lava.sirena.org.uk/scheduler/job/2365445
# test job: [8d38423d9dea7353a8a54a3ab2e0d0aa04ed34d0] https://lava.sirena.org.uk/scheduler/job/2354317
# test job: [b0655377aa5a410df02d89170c20141a1a5bbc28] https://lava.sirena.org.uk/scheduler/job/2291672
# test job: [32a708ba5db50cf928a1f1b2039ceef33de2c286] https://lava.sirena.org.uk/scheduler/job/2279437
# test job: [9e92c559d49d6fb903af17a31a469aac51b1766d] https://lava.sirena.org.uk/scheduler/job/2232506
# test job: [03d281f384768610bf90697bce9e35d3d596de77] https://lava.sirena.org.uk/scheduler/job/2231124
# test job: [6c177775dcc5e70a64ddf4ee842c66af498f2c7c] https://lava.sirena.org.uk/scheduler/job/1780443
# test job: [fd9678829d6dd0c10fde080b536abf4b1121c346] https://lava.sirena.org.uk/scheduler/job/2445995
# bad: [fd9678829d6dd0c10fde080b536abf4b1121c346] Add linux-next specific files for 20260210
git bisect bad fd9678829d6dd0c10fde080b536abf4b1121c346
# test job: [1256bc7912123bf6f6c0b97809af184a55b0d9df] https://lava.sirena.org.uk/scheduler/job/2446075
# bad: [1256bc7912123bf6f6c0b97809af184a55b0d9df] Merge branch 'main' of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad 1256bc7912123bf6f6c0b97809af184a55b0d9df
# test job: [8fb729d87a37ced2889940c150622cd44f2d029d] https://lava.sirena.org.uk/scheduler/job/2446199
# good: [8fb729d87a37ced2889940c150622cd44f2d029d] Merge branch 'xtensa-for-next' of https://github.com/jcmvbkbc/linux-xtensa.git
git bisect good 8fb729d87a37ced2889940c150622cd44f2d029d
# test job: [275da93ce2b8fa2f82da1e8785d6f1930670ef88] https://lava.sirena.org.uk/scheduler/job/2446280
# good: [275da93ce2b8fa2f82da1e8785d6f1930670ef88] gve: Remove jumbo_remove step from TX path
git bisect good 275da93ce2b8fa2f82da1e8785d6f1930670ef88
# test job: [9329068ac66b4a8cc64faea43691f95f29cd32ab] https://lava.sirena.org.uk/scheduler/job/2446342
# bad: [9329068ac66b4a8cc64faea43691f95f29cd32ab] Merge branch 'for-next/pstore' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
git bisect bad 9329068ac66b4a8cc64faea43691f95f29cd32ab
# test job: [dbfcce773f91a093d32cfd02821257765bf5ae78] https://lava.sirena.org.uk/scheduler/job/2446442
# good: [dbfcce773f91a093d32cfd02821257765bf5ae78] Merge branch 'nfsd-next' of https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good dbfcce773f91a093d32cfd02821257765bf5ae78
# test job: [cb3ca564682a0a02a9f95b7b22ad434a7389daaf] https://lava.sirena.org.uk/scheduler/job/2446484
# good: [cb3ca564682a0a02a9f95b7b22ad434a7389daaf] Merge branch 'pci/controller/cadence-j721e'
git bisect good cb3ca564682a0a02a9f95b7b22ad434a7389daaf
# test job: [522a46affdceda863df9bf652119f463f480479d] https://lava.sirena.org.uk/scheduler/job/2446519
# good: [522a46affdceda863df9bf652119f463f480479d] Merge branch 'pci/controller/misc'
git bisect good 522a46affdceda863df9bf652119f463f480479d
# test job: [ee80126d7dee1f0e0a72683b6f38388e90ffaaf1] https://lava.sirena.org.uk/scheduler/job/2446657
# good: [ee80126d7dee1f0e0a72683b6f38388e90ffaaf1] Merge branch '9p-next' of https://github.com/martinetd/linux
git bisect good ee80126d7dee1f0e0a72683b6f38388e90ffaaf1
# test job: [19d1ad6cc1e8e435bbbeb9310388f1d3ba089c4e] https://lava.sirena.org.uk/scheduler/job/2446772
# bad: [19d1ad6cc1e8e435bbbeb9310388f1d3ba089c4e] Merge branch 'deferred.namespace-7.0' into vfs.all
git bisect bad 19d1ad6cc1e8e435bbbeb9310388f1d3ba089c4e
# test job: [a39162f77f49b618df5a721a1e48d8b903280fbd] https://lava.sirena.org.uk/scheduler/job/2446808
# good: [a39162f77f49b618df5a721a1e48d8b903280fbd] exportfs: clarify the documentation of open()/permission() expotrfs ops
git bisect good a39162f77f49b618df5a721a1e48d8b903280fbd
# test job: [30d2122405f27f19de5e8c38762c78088a6abe8d] https://lava.sirena.org.uk/scheduler/job/2446835
# bad: [30d2122405f27f19de5e8c38762c78088a6abe8d] selftests: add FSMOUNT_NAMESPACE tests
git bisect bad 30d2122405f27f19de5e8c38762c78088a6abe8d
# test job: [4f5ba37ddcdf5eaac2408178050183345d56b2d3] https://lava.sirena.org.uk/scheduler/job/2446918
# bad: [4f5ba37ddcdf5eaac2408178050183345d56b2d3] mount: add FSMOUNT_NAMESPACE
git bisect bad 4f5ba37ddcdf5eaac2408178050183345d56b2d3
# test job: [1d497d97fb22dfd3cd215a38f8dd56fc974c76a7] https://lava.sirena.org.uk/scheduler/job/2446991
# good: [1d497d97fb22dfd3cd215a38f8dd56fc974c76a7] mount: simplify __do_loopback()
git bisect good 1d497d97fb22dfd3cd215a38f8dd56fc974c76a7
# first bad commit: [4f5ba37ddcdf5eaac2408178050183345d56b2d3] mount: add FSMOUNT_NAMESPACE

--7NOatrK2jkqGg8GL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmMbFoACgkQJNaLcl1U
h9Bmqgf/fSHrmjAAXTf/pD2WcmwTzhdaHvLjZtunNbp4hHmxvne2r3Si2aG5tHDG
Q6YLX0VglMtNDOAgBKQjQP6iA7j1norhWaqx0yQL9GWvcdo5O9PkC7rl6FpCWs9Y
JbGhpwVwse3AzHqPWtZPMr38pGcCSH3958auqV/zFIC5ZF85BFefke9G4BO2y6ur
FvHq6mROim8uuVYr4rluaoraP8Nu6XEfxg84Nf9egfkAggyzSy3cQvg63F5HkAzZ
2Nq9ki4LkTZ042PDfVnUh0Gd4CvJKO4KLMtJeD0bhVtI85C4EOM07rCqpb/I/Gh0
Cxc1Rey6bVMT+/I5ykemHcO0b0ZRlQ==
=KZ3j
-----END PGP SIGNATURE-----

--7NOatrK2jkqGg8GL--

