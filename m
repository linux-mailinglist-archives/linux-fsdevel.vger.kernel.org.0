Return-Path: <linux-fsdevel+bounces-44922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF600A6E5CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279303B41BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90725EC4;
	Mon, 24 Mar 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsINz6VN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727619005D;
	Mon, 24 Mar 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852378; cv=none; b=hP4bw0vX0papbCv8Mfu0ey5FDZWxAupWSGXur/8SBiBh7O9ofJ1VVmC/b/qVqFeJCu6IhBCh7I1Luo8dlodcpqnoRJQDtRZQkmO7InsdrMXnTIlydrbVp3xK1sBPDs1kvJq2fW7HmffNRdEWhYGDViUMQXyvmaihB4V1Io2xb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852378; c=relaxed/simple;
	bh=/dofNyHhYdWrquLZLSEaHOeHNBCJtaYhOwJD+E5VWDE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=reCxbymLyFlw+YPhZvtGb1PsUweazpEchut2kWdMZiwr2moZt/5atq4OjQU1neWh4nlfM46IogeP4FPbfYXPOhj93p/PTuJXe2thKyLUtWapMafgfOaMpmCz+pgk7mww0dUyvnTcCUaSQ470QmwrXX1WWxkerF0BaVorLbFvass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsINz6VN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5677C4CEDD;
	Mon, 24 Mar 2025 21:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742852377;
	bh=/dofNyHhYdWrquLZLSEaHOeHNBCJtaYhOwJD+E5VWDE=;
	h=Date:From:To:Cc:Subject:From;
	b=UsINz6VNYRv46UA4TmLBn5W96MDZn+CmszWaTgbyfUnsnVrz4GsJITLvsg+N8oTjK
	 UKpv3oDODLftAystamwA0FrgGUjHl1xcuWtRRrV4BbQjCq1G1RpT+9RrNp7JUSQc0I
	 +l8Ge41h+I5x9N5SoUulKqBPx1CJXn7F+HM/JybPgyjVZxFEXCNmWZOIEtMvWHhX0+
	 91m/JO+ej2A8yVfqbX2E/35T8lluafKiGJmzJ/7jBlSfzJEIAlYyOM2FT2XAxuYMro
	 DWYGpg8aKryxYD3bL5MaLoPNy2xKrzdMEYLIqQS+rhNPPEXmyM9/PVOd0JTycjgH78
	 kNUsIi2wCKlWA==
Date: Mon, 24 Mar 2025 14:39:35 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: dennis.maisenbacher@wdc.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chuck Lever <cel@kernel.org>, Song Liu <song@kernel.org>,
	Konstantin Ryabitsev <mricon@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	kdevops@lists.linux.dev, Luis Chamberlain <mcgrof@kernel.org>,
	Song Liu <song@kernel.org>,
	Jude Gyimah <Jude.Gyimah@ruhr-uni-bochum.de>,
	Ole Schuerks <ole0811sch@gmail.com>, thorsten.berger@rub.de,
	deltaone@debian.org, jan.sollmann@rub.de, nathan@kernel.org,
	nicolas@fjasle.eu, Brendan Jackman <jackmanb@google.com>
Subject: kdevops: scaling automated testing
Message-ID: <Z-HRF6lZ6dhwFtAS@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We already have a kdevops BoF scheduled so I don't think we need another
session, but what I think is needed is references to folks or a memo about
how I think we can scale automated tests with kdevops.

Essentially we have kdevops kernel-ci support now [0], and we have not
only kernel-patches-daemon integration but also have worked with
kernel.org admins to PoC using lei based patchwork to help us reduce the
scope of what we want to test [1]. So for instance, you can request a
lei based patchwork for all kernel patches posted which modifies just
the loopback driver.

Since kdevops leverages kconfig, it also means that if you write your
kconfig logic, and since we require it for kdevops, that means you can
leverage existing CI web intrastructure to provide the variability of
your tests using existing web CI tooling, you just map your target CI
goals to a and end result kdevops .config. An example is provided with
XFS to enable testing all tests or just reduce the scope, and also
allowing you to modify say, the SOAK_DURATION. And so the github<->KPD
integration git tree we use is more useful than the usual KPD git trees,
in that we can simply enable now also kernel maintainers for each subsystem
to just git push their development branches.

That means kernel subsystems can either opt-in for automatically testing
patches posted to the mailing lists for the subsystem and / or can just
do testing for when the maintainer wants to.

The next aspect to this is scaling archiving test results. Although github
does let you upload artifacts, these are ephemeral and so won't be around
forever. That means kernel configs may be gone eventually too...

To address this kdevops supports and uses both archiving results as ephemeral
to github and then also pushes results as persistent to github. We leverage
git LFS which lets git trees to be larger than usual, and also it enables
users to clone a tree archive and *not* download all tarballs, and on-demand
only fetch the files you really need. We do this with kdevops-results-archive.
Since even git LFS trees still has a size limit all you need to do is rotate
the archive as "epochs". For example see some results from our 2025-02 epoch
for XFS, that's a limited set of results [4] but we also have more
expanded set of results [5].

The next question is how to scale this in terms of infrasturcture.

For that we can use a SAT solver, and wouldn't it be nice? But we actually
have one proposed for kconfig and so we can just use that. So let me
paste the relevant parts:

How can we leverage a SAT solver on kdevops?

1) Feature-driven configuration and scriptable goals

Instead of having the user do the heavy work on figuring out what the
heck to enable on make menuconfig, the user just has to writes a
requirement. Something like this:

ci-goal:
  - filesystem: xfs
  - features: [reflink, 4k]
  - workload: sysbench-mysql-docker

This can also enable scriptable CI goals:

kconfig-solve --enable sysbench --fs xfs --blocksize 4k --reflink

Generates .config to let us test this.

2) Minimized configs to reproduce a test on our CI

Today if someone wants to reproduce a generic/750 test on xfs reflink 4k
profile they can just use the web interface to select just the xfs_reflink_4k
defconfig, and we have a kconfig option to let us limit the test to a
set specified [0]. That requires adding a defconfig per test profile we
support. Wouldn't it be nicer if we can just say:

ci-goal:
  - filesystem: xfs
  - features: [reflink, 4k]
  - testsuite: fstests
  - tests: generic/750

3) Generate a set of different tests for a goal

Given a set of features we want to test, we could have the
SAT solver look for satisfiable combinations we could have

ci-goal:
  - filesystem: xfs
  - features: [reflink]
  - workload: sysbench-mysql-docker

And so this may generate different .configs to help us run each one as a
setup to test test XFS on mysql using docker using all XFS profiles.

Given we support all cloud providers...

This can also be something like:

matrix:
  providers: [aws, gcp]
    storage: [ebs, nvme]
      filesystems: [xfs, ext4]
      testsuites: [fstests]
 
If we could gather data about price...

       - cost_limit: $0.50/hr

We then just need a mapping of code to tests.

code_paths:
  fs/xfs/: [fstests, ltp, gitr]
  block/: [blktets]

Ie, code maps to Kconfig attributes, and so we know what tests to run
as code gets updated on each commit.

So... if we have hardware at LF we can donate... then we can just use our
own cloud like openstack of ubicloud to let us describe our needs for
each test.

Does this make sense?

What we need? More help and focus on kpd and its code, and then also
deciding if we can give LF hw.

[0] https://github.com/linux-kdevops/kdevops/blob/main/docs/kernel-ci/README.md
[1] https://github.com/linux-kdevops/kdevops/blob/main/docs/kernel-ci/kernel-ci-kpd.md
[2] https://github.com/linux-kdevops/kdevops/blob/main/docs/kernel-ci/linux-filesystems-kdevops-CI-testing.md
[3] https://github.com/linux-kdevops/kdevops-results-archive/
[4] https://github.com/linux-kdevops/kdevops-results-archive-2025-02/commit/1b94c7227e58c0fb8e3f6362fd59e482d373c433
[5] https://github.com/linux-kdevops/kdevops-results-archive-2025-02/commit/f5c35a745220d720423af939a81b7aba93451063
[6] https://lore.kernel.org/all/Z9_JA_tuFbVJRcTR@bombadil.infradead.org/

  Luis

