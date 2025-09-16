Return-Path: <linux-fsdevel+bounces-61722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0FDB594F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42D44E0EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392922D6624;
	Tue, 16 Sep 2025 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQDbh1Va"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707232773C3;
	Tue, 16 Sep 2025 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021539; cv=none; b=EPkEazpkFKMm/0KT7zutLn7lCrawp2HXIN2RF/Y4s40EeRJ8ZiF516E/ywXAXrOCC6+N4Oq4IglM4jqowcr1Pt84mxi4dZMzKTQfexD7zx2qksQqDnsShcFyY13zK1jZqSjua5xLJuqKsuN6GODMRsrNcgDtNa728ZOI53xjaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021539; c=relaxed/simple;
	bh=fPi2jTo0hJ6xkgxaFB3CE37jdXxU+Q3zu80o0dV1unM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oif6+3BJVrYclfn356Z4EoofjbGMmvGIipGKdVufCUNZt3hfW+73iaejBRO8hCKG2XbSAR8ku3VnnFSy45DCmxvVBb67tCvbpxpi1EbCe4NUtPjMeT7dsEczhORDjn7EFuY4ScSfkDcHVEc1NtV1pKYaft09b6mapD5XQj1j9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQDbh1Va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3C2C4CEEB;
	Tue, 16 Sep 2025 11:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758021538;
	bh=fPi2jTo0hJ6xkgxaFB3CE37jdXxU+Q3zu80o0dV1unM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQDbh1VaUF3+xG9O6//FoHCGnbQqBuJSEFwsn9AWaLs19tnsOKvOZeXgtT2Ppbvh7
	 zDCkjUFEK2bdYgvEchH4TzeIt6kwysmCsoRqQjdVJbkIYKTZ3q04vmBlHo725QsvxO
	 7AhrEzl52ZcqfZzj3uI7n5oA/VBZAihCXEtpKdn38X5G1vEogTg4rY1Xs4mpRx0rwL
	 LuyuHxRxaub0nEEe9tvc8fAnssi5DcdHD1bYPfb2UJIA2PoTryL/GJ7dwW60Kxyoqy
	 zIXqsQ3Dze7L2+355gXdYkt1Z58WO6RCsVslYfMxHuV++DyfOaya0rg/PVyTka9aHH
	 QsrmJgW1c/GmA==
Date: Tue, 16 Sep 2025 12:18:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 04/33] block: use extensible_ioctl_valid()
Message-ID: <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-4-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pXrdOnUKtpdJm8VZ"
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-4-1a247645cef5@kernel.org>
X-Cookie: You dialed 5483.


--pXrdOnUKtpdJm8VZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2025 at 01:52:27PM +0200, Christian Brauner wrote:
> Use the new extensible_ioctl_valid() helper which is equivalent to what
> is done here.

I'm seeing several LTP tests (at least getdents02, msync04, renameat01
and statx12) failing in yesterday's -next pending-fixes on Raspberry Pi
4 with bisections pointing to this commit.  renameat01 fails with:

  renameat01    0  TINFO  :  Using /tmp/LTP_renEtNZrS as tmpdir (nfs filesystem)
  renameat01    1  TBROK  :  tst_device.c:97: Could not stat loop device 0
  renameat01    2  TBROK  :  tst_device.c:97: Remaining cases broken

Full log for that run:

  https://lava.sirena.org.uk/scheduler/job/1830765#L6680

bisect log for renameat (all the bisects cover the same builds, though I
split the jobs up so it's different test jobs for some of the tests):

# bad: [179688318d56cee63802eb49e3503d799c43db6c] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [f83ec76bf285bea5727f478a68b894f5543ca76e] Linux 6.17-rc6
# good: [690aa09b1845c0d5c3c29dabd50a9d0488c97c48] ASoC: Intel: catpt: Expose correct bit depth to userspace
# good: [3254959b4dd065eae396cf78ccc1361460b2f53e] ASoC: amd: amd_sdw: Add quirks for some new Dell laptops
# good: [9004a450fccbeb40a71cc173747da37a459fd4dc] ASoC: codecs: lpass-wsa-macro: Fix speaker quality distortion
# good: [ec630c2c8ce215dd365b8c3644f004f645714a0f] ASoC: SDCA: Reorder members of hide struct to remove holes
# good: [68f27f7c7708183e7873c585ded2f1b057ac5b97] ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed
# good: [0c28431f6fe13f3a3be0978f79c1a7ae8a93d028] ASoC: SOF: imx: Fix devm_ioremap_resource check
# good: [28edfaa10ca1b370b1a27fde632000d35c43402c] ASoC: SDCA: Add quirk for incorrect function types for 3 systems
# good: [35fc531a59694f24a2456569cf7d1a9c6436841c] ASoC: SOF: Intel: hda-stream: Fix incorrect variable used in error message
# good: [9b17d3724df55ecc2bc67978822585f2b023be48] ASoC: wm8974: Correct PLL rate rounding
# good: [f54d87dad7619c8026e95b848d6ef677b9f2b55f] ASoC: rt712: avoid skipping the blind write
git bisect start '179688318d56cee63802eb49e3503d799c43db6c' 'f83ec76bf285bea5727f478a68b894f5543ca76e' '690aa09b1845c0d5c3c29dabd50a9d0488c97c48' '3254959b4dd065eae396cf78ccc1361460b2f53e' '9004a450fccbeb40a71cc173747da37a459fd4dc' 'ec630c2c8ce215dd365b8c3644f004f645714a0f' '68f27f7c7708183e7873c585ded2f1b057ac5b97' '0c28431f6fe13f3a3be0978f79c1a7ae8a93d028' '28edfaa10ca1b370b1a27fde632000d35c43402c' '35fc531a59694f24a2456569cf7d1a9c6436841c' '9b17d3724df55ecc2bc67978822585f2b023be48' 'f54d87dad7619c8026e95b848d6ef677b9f2b55f'
# test job: [690aa09b1845c0d5c3c29dabd50a9d0488c97c48] https://lava.sirena.org.uk/scheduler/job/1805508
# test job: [3254959b4dd065eae396cf78ccc1361460b2f53e] https://lava.sirena.org.uk/scheduler/job/1769788
# test job: [9004a450fccbeb40a71cc173747da37a459fd4dc] https://lava.sirena.org.uk/scheduler/job/1774162
# test job: [ec630c2c8ce215dd365b8c3644f004f645714a0f] https://lava.sirena.org.uk/scheduler/job/1772919
# test job: [68f27f7c7708183e7873c585ded2f1b057ac5b97] https://lava.sirena.org.uk/scheduler/job/1772831
# test job: [0c28431f6fe13f3a3be0978f79c1a7ae8a93d028] https://lava.sirena.org.uk/scheduler/job/1762707
# test job: [28edfaa10ca1b370b1a27fde632000d35c43402c] https://lava.sirena.org.uk/scheduler/job/1762245
# test job: [35fc531a59694f24a2456569cf7d1a9c6436841c] https://lava.sirena.org.uk/scheduler/job/1762959
# test job: [9b17d3724df55ecc2bc67978822585f2b023be48] https://lava.sirena.org.uk/scheduler/job/1758830
# test job: [f54d87dad7619c8026e95b848d6ef677b9f2b55f] https://lava.sirena.org.uk/scheduler/job/1758090
# test job: [179688318d56cee63802eb49e3503d799c43db6c] https://lava.sirena.org.uk/scheduler/job/1830765
# bad: [179688318d56cee63802eb49e3503d799c43db6c] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect bad 179688318d56cee63802eb49e3503d799c43db6c
# test job: [4c3c40178b0e1578a3898092cc33ffb2618edc51] https://lava.sirena.org.uk/scheduler/job/1830986
# good: [4c3c40178b0e1578a3898092cc33ffb2618edc51] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
git bisect good 4c3c40178b0e1578a3898092cc33ffb2618edc51
# test job: [78ca913586336540ec12f262c5bdf16f8925de82] https://lava.sirena.org.uk/scheduler/job/1831233
# bad: [78ca913586336540ec12f262c5bdf16f8925de82] Merge branch 'vfs.all' of https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
git bisect bad 78ca913586336540ec12f262c5bdf16f8925de82
# test job: [06dd3eda0e958cdae48ca755eb5047484f678d78] https://lava.sirena.org.uk/scheduler/job/1831745
# good: [06dd3eda0e958cdae48ca755eb5047484f678d78] Merge branch 'vfs-6.18.rust' into vfs.all
git bisect good 06dd3eda0e958cdae48ca755eb5047484f678d78
# test job: [a7ec4da2c05c5f8be52c2ac884d5672d0a805ee0] https://lava.sirena.org.uk/scheduler/job/1832263
# bad: [a7ec4da2c05c5f8be52c2ac884d5672d0a805ee0] Merge patch series "ns: support file handles"
git bisect bad a7ec4da2c05c5f8be52c2ac884d5672d0a805ee0
# test job: [670f2f915084d1c53f14d59946011b7645601813] https://lava.sirena.org.uk/scheduler/job/1832304
# bad: [670f2f915084d1c53f14d59946011b7645601813] nstree: make iterator generic
git bisect bad 670f2f915084d1c53f14d59946011b7645601813
# test job: [011090b6c0a97a3aa1f659d670d85bbf0eddbe06] https://lava.sirena.org.uk/scheduler/job/1832355
# bad: [011090b6c0a97a3aa1f659d670d85bbf0eddbe06] cgroup: use ns_common_init()
git bisect bad 011090b6c0a97a3aa1f659d670d85bbf0eddbe06
# test job: [60949057a2e71c9244e82608adf269e62e6ac443] https://lava.sirena.org.uk/scheduler/job/1832402
# bad: [60949057a2e71c9244e82608adf269e62e6ac443] block: use extensible_ioctl_valid()
git bisect bad 60949057a2e71c9244e82608adf269e62e6ac443
# test job: [4d906371d1f9fc9ce47b2c8f37444680246557bc] https://lava.sirena.org.uk/scheduler/job/1832439
# good: [4d906371d1f9fc9ce47b2c8f37444680246557bc] nsfs: drop tautological ioctl() check
git bisect good 4d906371d1f9fc9ce47b2c8f37444680246557bc
# test job: [f8527a29f4619f74bc30a9845ea87abb9a6faa1e] https://lava.sirena.org.uk/scheduler/job/1832550
# good: [f8527a29f4619f74bc30a9845ea87abb9a6faa1e] nsfs: validate extensible ioctls
git bisect good f8527a29f4619f74bc30a9845ea87abb9a6faa1e
# first bad commit: [60949057a2e71c9244e82608adf269e62e6ac443] block: use extensible_ioctl_valid()

--pXrdOnUKtpdJm8VZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjJR5kACgkQJNaLcl1U
h9CJ4Af+ISZ3lljoI72V72kUBKwG6lq4beym3VICH+8DyjBOtQJqkqIE5OlcUns9
gY6sqsqpxxIvI+a6v6GPW0eqWuAu36UuvdqjURrMubJCQi6zeT4lYVIgcioh4U4G
FWmhUV1LC5FGYKc7KfibPRCcggsT/XKqMH88jkIfAYSUiQHyuMZMaiA+vNDdVDK+
f3ZZj6bKcB6h0wVse+BUtM5+Ha+RIzS4bpK9JNzJqV3pHra6Yg3myz2sd46lT4mg
5K5amhS9uYN26RZGTr3ioMhuGUywjeyWsLccmtBq/fG+bofT1tEReGLdVC9fsvOO
wPu0MoWdSMaeA2rJE/z5wrxA2nePqA==
=6jkN
-----END PGP SIGNATURE-----

--pXrdOnUKtpdJm8VZ--

