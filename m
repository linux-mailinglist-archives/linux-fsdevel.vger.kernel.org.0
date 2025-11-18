Return-Path: <linux-fsdevel+bounces-68938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7ACC69127
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 12:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C175350684
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B46B3546E1;
	Tue, 18 Nov 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQLu+9rZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69185350A15;
	Tue, 18 Nov 2025 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465307; cv=none; b=RBZMvy9JeT0J9nYJgSLhRDEZ90oIez6ruSW+8Fqu9YIbwA4I2jyIE0/drE8ZdBBj4n3s/cUSpwwgAVaFjfGaUovA81JeLxMMngNbbLxPSuxjsl9pyEEOb/m2iHVLVykImT2iUqEBBEGNufajWm6jQg4hKgi012Wjbz3J4Lni+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465307; c=relaxed/simple;
	bh=B3Ck+ZeJMAqa97fGHBodXk952kfsyzlVaAaz1fhsUjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8m4eQLQkVpwIcLgeqvfIUpWzJa+XJdEHnd6Ma5+966zU37kFXc3MpY+gBYzh/tA+Pwc+VvHffTY5c/Qa9fQO8z7Oq8tq1k1WG/u1k+PvNoTTvuYf4s3FiajWp3Nd14b1vNLf+BRAd8t7DYbAlAMgSpscyqLwNecIe8np4cjAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQLu+9rZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA73C2BCB2;
	Tue, 18 Nov 2025 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763465306;
	bh=B3Ck+ZeJMAqa97fGHBodXk952kfsyzlVaAaz1fhsUjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQLu+9rZRRAXOUo92WAJWcJwMQwCECdt5VEQNNd+yp5MfU6CT/SCqQGSMA1LzumqT
	 NfCkJGz3WVbw4jmetvEnNdBIZtFyXHwH0Uv1STbCTH3FpF6egZEea/8IThMQV2AnE7
	 Xva49r63Ie+VmHsEwIVC3bWqvEFIsND9oBQ2SEDO0+Ttol+YON6Nqe0C0GMP8C0p/x
	 nFs3/rjxgKCHsFSL3CWTeJs90Qo4ldWBUDxa8ow5mCspZWSwIXVih7aEib8XXJ+3jN
	 3u9YDrfXHY0BGetjelUPwh1a9YTF4bmTsULA+0awTrM4pf/hzkdGxtAY8qVHPr80PG
	 yj/Y/ua4PKjzw==
Date: Tue, 18 Nov 2025 13:28:00 +0200
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
Subject: Re: [PATCH v6 08/20] liveupdate: luo_flb: Introduce
 File-Lifecycle-Bound global state
Message-ID: <aRxYQKrQeP8BzR_2@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-9-pasha.tatashin@soleen.com>
 <aRrtRfJaaIHw5DZN@kernel.org>
 <CA+CK2bBxVNRkJ-8Qv1AzfHEwpxnc4fSxdzKCL_7ku0TMd6Rjow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBxVNRkJ-8Qv1AzfHEwpxnc4fSxdzKCL_7ku0TMd6Rjow@mail.gmail.com>

On Mon, Nov 17, 2025 at 10:54:29PM -0500, Pasha Tatashin wrote:
> >
> > The concept makes sense to me, but it's hard to review the implementation
> > without an actual user.
> 
> There are three users: we will have HugeTLB support that is going to
> be posted as RFC in a few weeks. Also, in two weeks we are going to
> have an updated VFIO and IOMMU series posted both using FLBs. In the
> mean time, this series provides an FLB in-kernel test that verifies
> that multiple FLBs can be attached to File-Handlers, and the basic
> interfaces are working.
 
Which means that essentially there won't be a real kernel user for FLB for
a while.
We usually don't merge dead code because some future patchset depends on
it.

I think it should stay in mm-nonmm-unstable if Andrew does not mind keeping
it there until the first user is going to land and then FLB will move
upstream along with that user.

If keeping FLB in mm tree is an issue we can set up an integration tree for
LUO/KHO.

-- 
Sincerely yours,
Mike.

