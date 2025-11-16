Return-Path: <linux-fsdevel+bounces-68618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E9C61AE4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 19:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A67B35A262
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 18:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF130F928;
	Sun, 16 Nov 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJys7Lvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654351E0B9C;
	Sun, 16 Nov 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763318212; cv=none; b=aw4G89Z7BjQkm3bAFHgNe13+eQPpGMU4cQSojADX7Ws43eTUyKw5DqkdDNmQJRnx3QZKem6p6luBOu56BgWf6pqHWE1sENmyIrBbdwxd6hjN6oqcQ/dbdd23jH2WK52g9sMoX0bqxpDFGqY7NijbjTvSThb2BkOwIKNDl6Q2+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763318212; c=relaxed/simple;
	bh=pUFOQlfWPQVHlNRZMItbyB86PfyTKPMdohxZA/z8UcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKony5mP6kZpejBZGwXqszg1VbglPN3zzsCDNyp8xXrGxyAv9Qprh6gumOzl4OUFN57OG/90q0N5OBLQ6juaovohJn4FXxIE1C/C3bCSOtEWeO4orQeeen3Y9T1PNAAORTBbfb0ZTkbVGfY5j7BDEadfg8mothYMjWEr4P6Kayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJys7Lvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DB7C113D0;
	Sun, 16 Nov 2025 18:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763318212;
	bh=pUFOQlfWPQVHlNRZMItbyB86PfyTKPMdohxZA/z8UcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJys7LvsoVVVknZjFngPHDcjKFn3LaoAIMuXeiTvlE4PVCSe5jgn0CdghHhAg0i+7
	 Nq2qRiOkWybWy+d6dFjpmNUOFeenqV4chIXDaxJFsmRi8QxmuCeJmveoJXBeOTxPRX
	 RvQpXRKnKgfMyhMMLeI3nasaM+2YMYesYC1x13IagcjQBxX4f5mxyem4INd98mDX8c
	 xSC7aldwdEtvZR8m8wMMPttXxkPwxxcJODN7Sh0tH8UU/kpioNP9NBhkpuNI63jLtT
	 CnwTwjspBvrn4SdMhyLmlJNsnoJCP+E1Za+iJKk64XotlBKhWUoASH6Lckowy5wylQ
	 GlPK6D4vo4kmg==
Date: Sun, 16 Nov 2025 20:36:27 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v5 22/22] tests/liveupdate: Add in-kernel liveupdate test
Message-ID: <aRoZq2bYYm5MGihy@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-23-pasha.tatashin@soleen.com>
 <aRTs3ZouoL1CGHst@kernel.org>
 <CA+CK2bBVRHwBu6a77gkvsbmWkQFDcTvNo+5aOT586mie13zqqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBVRHwBu6a77gkvsbmWkQFDcTvNo+5aOT586mie13zqqA@mail.gmail.com>

On Wed, Nov 12, 2025 at 03:40:53PM -0500, Pasha Tatashin wrote:
> On Wed, Nov 12, 2025 at 3:24 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Fri, Nov 07, 2025 at 04:03:20PM -0500, Pasha Tatashin wrote:
> > > Introduce an in-kernel test module to validate the core logic of the
> > > Live Update Orchestrator's File-Lifecycle-Bound feature. This
> > > provides a low-level, controlled environment to test FLB registration
> > > and callback invocation without requiring userspace interaction or
> > > actual kexec reboots.
> > >
> > > The test is enabled by the CONFIG_LIVEUPDATE_TEST Kconfig option.
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  kernel/liveupdate/luo_file.c     |   2 +
> > >  kernel/liveupdate/luo_internal.h |   8 ++
> > >  lib/Kconfig.debug                |  23 ++++++
> > >  lib/tests/Makefile               |   1 +
> > >  lib/tests/liveupdate.c           | 130 +++++++++++++++++++++++++++++++
> > >  5 files changed, 164 insertions(+)
> > >  create mode 100644 lib/tests/liveupdate.c
> > >
> > > diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> > > index 713069b96278..4c0a75918f3d 100644
> > > --- a/kernel/liveupdate/luo_file.c
> > > +++ b/kernel/liveupdate/luo_file.c
> > > @@ -829,6 +829,8 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> > >       INIT_LIST_HEAD(&fh->flb_list);
> > >       list_add_tail(&fh->list, &luo_file_handler_list);
> > >
> > > +     liveupdate_test_register(fh);
> > > +
> >
> > Do it mean that every flb user will be added here?
> 
> No, FLB users will use:
> 
> liveupdate_register_flb() from various subsystems. This
> liveupdate_test_register() is only to allow kernel test to register
> test-FLBs to every single file-handler for in-kernel testing purpose
> only.

Why the in kernel test cannot liveupdate_register_flb()?
 
> Pasha

-- 
Sincerely yours,
Mike.

