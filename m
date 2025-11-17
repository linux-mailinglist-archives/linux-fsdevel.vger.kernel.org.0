Return-Path: <linux-fsdevel+bounces-68789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C16C663A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9866436025E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F61C34CFDE;
	Mon, 17 Nov 2025 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7QLXXaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F27332917;
	Mon, 17 Nov 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413902; cv=none; b=EMMfvs5BsKcHUykS1h08U2g+WUalqVgGk8y6eJ9NShGN0WQwzcxTwfGryc1cKXQm9NBRYx02g1dbH5pC6Ffi7NBqVj6+dxLdSfSF9GMZQh0HfIPQZ8PbHbisibhG51rXRBA4HxAtcSkGuuNpDVtQfQn0EbGGEXedwM/KWIbEcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413902; c=relaxed/simple;
	bh=bie3kN86Jb07qh+6ZaiIlQYo+zkE09+CG7RupsGe1d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBbcU6qwjQoq7o4MkHGCOvz9dlC3EijaJC9WmD5esH9zjo3Du2amHF56pBFkqTMR1eg98sBrNHORiqhukJt/g0fYE7mQ7CdNfPqASMJeIwtb7CxWN/bKAS1mhSD+8Z5LAFGOv7kGzhsDc5qUprbUzigLFoEnsjN8a1ecaesRDpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7QLXXaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44A7C2BCB0;
	Mon, 17 Nov 2025 21:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413901;
	bh=bie3kN86Jb07qh+6ZaiIlQYo+zkE09+CG7RupsGe1d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7QLXXaHf0sITCv4iAsxWlaf7s4zlfoviVYz/0zLfBC9hHK4TW5L+fRcWEH2flkZx
	 F8dUOHmtLf4SGQMlAX8YIg99ukJF8vz+tfpNCqDW8UAogvgq/g5brKADLQLJJMC0uO
	 IfGTLHUpNnVmfQNMRlWel9DQB0hWfJhAFG/jmDY854HSXjnOWCKUBdItbWhTrPh9N6
	 pd9o23MWct8ZxEnMv9y3CpZ7RpxlQq4v9AhEGbOYN56ObB6PyKQX9/7q4dhKY2NHK7
	 EkIQ9GGmutwSAt1xFi3zvMlFrSGw2eMb7eTS+KRyWzGWfLkfyExS0RRjfv1SNFFbAc
	 LmuWGRjhMeAkQ==
Date: Mon, 17 Nov 2025 23:11:14 +0200
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
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
Subject: Re: [PATCH v6 04/20] liveupdate: luo_session: add sessions support
Message-ID: <aRuPcjyNBZqlZuEm@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-5-pasha.tatashin@soleen.com>
 <aRoEduya5EO8Xc1b@kernel.org>
 <CA+CK2bC_z_6hgYu_qB7cBK2LrBSs8grjw7HCC+QrtUSrFuN5ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bC_z_6hgYu_qB7cBK2LrBSs8grjw7HCC+QrtUSrFuN5ZQ@mail.gmail.com>

On Mon, Nov 17, 2025 at 10:09:28AM -0500, Pasha Tatashin wrote:
> 
> > > +     }
> > > +
> > > +     for (int i = 0; i < sh->header_ser->count; i++) {
> > > +             struct luo_session *session;
> > > +
> > > +             session = luo_session_alloc(sh->ser[i].name);
> > > +             if (IS_ERR(session)) {
> > > +                     pr_warn("Failed to allocate session [%s] during deserialization %pe\n",
> > > +                             sh->ser[i].name, session);
> > > +                     return PTR_ERR(session);
> > > +             }
> >
> > The allocated sessions still need to be freed if an insert fails ;-)
> 
> No. We have failed to deserialize, so anyways the machine will need to
> be rebooted by the user in order to release the preserved resources.
> 
> This is something that Jason Gunthrope also mentioned regarding IOMMU:
> if something is not correct (i.e., if a session cannot finish for some
> reason), don't add complicated "undo" code that cleans up all
> resources. Instead, treat them as a memory leak and allow a reboot to
> perform the cleanup.
> 
> While in this particular patch the clean-up looks simple, later in the
> series we are adding file deserialization to each session to this
> function. So, the clean-up will look like this: we would have to free
> the resources for each session we deserialized, and also free the
> resources for files that were deserialized for those sessions, only to
> still boot into a "maintenance" mode where bunch of resources are not
> accessible from which the machine would have to be rebooted to get
> back to a normal state. This code will never be tested, and never be
> used, so let's use reboot to solve this problem, where devices are
> going to be properly reset, and memory is going to be properly freed.

A part of this explanation should be a comment in the code.

-- 
Sincerely yours,
Mike.

