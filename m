Return-Path: <linux-fsdevel+bounces-60197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE74B429E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 21:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEC558253D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E1C369984;
	Wed,  3 Sep 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEswwnUF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AD264FB5;
	Wed,  3 Sep 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927823; cv=none; b=maat+T1T4hI64RwX+pLpB5jM0WT+E4p88xEvI4tZ1xnHOGfOVZwcAOHEG3WIcR6bzt5+XewDjxI7Icjexx+V31DCdpuaBezJ98vtxjaTDVb7BzGJOJUV3Sz1kuhQ5uE4KWKGSILnIzgvku/LOfocn05RKip6KHHQlyCzf8sDfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927823; c=relaxed/simple;
	bh=gbiYfCYnwD77BhT/g17AX8EiRn/Z+Y0d8Hl4eh52DYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBBeUA88qoaWYQlgDXlayzAazWYJTgt6LPtXgN39+Dwm5/1qIwLjf2NeASzVA9E8d6X0RNnX3acAzCTrLiY6hxrdu9jF4ipm88WV2rR8S3Dhly5WnlWm96wuepnvQfUQBsaQZKMAG0gKfP4JZufYmAL+oFKSp8U3wFawx7O1j5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEswwnUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8947C4CEE7;
	Wed,  3 Sep 2025 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756927820;
	bh=gbiYfCYnwD77BhT/g17AX8EiRn/Z+Y0d8Hl4eh52DYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEswwnUFyX6YzOK/z9N9LFcK6410onGyQhtt7HqMPuK+Bz5kIyDe1S134VWl3YnUs
	 lZyvI6AgrLghgDHiy98MMxoZ7WvyVFYkjxu4ggWww2iXWCZCPdO+Ia4TCZZyXyLm5D
	 UT5oVtvwFau4bDLQtWOz7WkB//w1DzoalLjz1HHEtmXWa3UJMx17L3ErzqCldiZIxH
	 FmdEuS2fDqllHE+JjRk/ZP9kPsJNHnxvQD2u17gru4gEjBt8mMxdpcpLAJZMg8+ot7
	 cItYGLq9Pi0pvmfdOGQ/cJvywzKibKRdUyepLU/iOzvdqBqn/6gndLRA0AWLDHJKG4
	 CiNh1699nhn3w==
Date: Wed, 3 Sep 2025 22:29:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
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
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <aLiXNLiWNFuvh4_G@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <aLXIcUwt0HVzRpYW@kernel.org>
 <CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>
 <mafs03496w0kk.fsf@kernel.org>
 <CA+CK2bAb6s=gUTCNjMrOqptZ3a_nj3teuVSZs86AvVymvaURQA@mail.gmail.com>
 <20250902113857.GB186519@nvidia.com>
 <CA+CK2bB-CaEdvzxt9=c1SZwXBfy-nE202Q2mfHL_2K7spjf8rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bB-CaEdvzxt9=c1SZwXBfy-nE202Q2mfHL_2K7spjf8rw@mail.gmail.com>

On Wed, Sep 03, 2025 at 03:59:40PM +0000, Pasha Tatashin wrote:
> > 
> > And again in real systems we expect memfd to be fully populated too.
> 
> I thought so too, but we already have a use case for slightly sparse
> memfd, unfortunately, that becomes *very* inefficient when fully
> populated.

Wait, regardless of how sparse memfd is, once you memfd_pin_folios() the
number of folios to preserve is known and the metadata to preserve is a
fully populated array.

-- 
Sincerely yours,
Mike.

