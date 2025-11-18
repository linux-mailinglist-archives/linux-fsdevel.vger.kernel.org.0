Return-Path: <linux-fsdevel+bounces-68937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63035C690BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 12:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6540B2AF33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8392BE644;
	Tue, 18 Nov 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiVE8uzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1B345CD0;
	Tue, 18 Nov 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464921; cv=none; b=nYcdWVAOKvwz1SHNsLDc+rqAAuCjdlLXaRMm/+YrKLrRlkDobHxcBUnHin9JZFbmJ9mujr7bXEoBNrFUr2/M7Pk7YqaWmZl/hZlOONDT/nZ8SAqrUnNkjgOakJNqgAJsK7/8EuvJz0fdMyLv8ELEEN2s8rFDCgIb3t0k2BBX4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464921; c=relaxed/simple;
	bh=OSqrTzVKPfEphWSOWozqjN2DP6jQ1KyGCt3LKIzrAwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKuflkr3uMeHWXmjsjte6c11WP/XEWppW4d9JkGKJReZquBjrwc9eFAARyu5XxKif2/YPP3uaIGfTShJf+TJ4m/9ffMjhQd/IK57XLsqzNmyDuOt4aDTrUjVCM6baXAOnDW07O3OAuM1mzptn7W4O/k3/aRNc4Yd9oGmQIaZwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiVE8uzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7B3C19423;
	Tue, 18 Nov 2025 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763464920;
	bh=OSqrTzVKPfEphWSOWozqjN2DP6jQ1KyGCt3LKIzrAwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiVE8uzMlUpbGMOt63k6vT8hw2abfpbdQAia0dP8s95gP0HGX5fqQBVw6T71VApzj
	 KxmYgAGG71dqGOdUg4HjnG6IuQfg5PpRaH9zD70xx5QpJ7SyM66AJNLOx41zAmQA76
	 Se7qyl+Bj42AlkZ9gFU1Kz+G0qbs1PPVvgf6TZpliCSjdo57yFzup0baGiLn44pKgD
	 ovt78WFggNj7PnxWuPJy7GVjcsYBZ9hWBPefxqqiLlACZYHUOKyU51ZYZ1hV8/c5am
	 LqW7CgaFMV4iZ3wVEipl+0eGPKrwlgcDDl07AGZJpMGkGhJL2ogQFrtaNtLOsITVkS
	 VYdo9nZgRP7GA==
Date: Tue, 18 Nov 2025 13:21:34 +0200
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
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
Message-ID: <aRxWvsdv1dQz8oZ4@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-3-pasha.tatashin@soleen.com>
 <aRnG8wDSSAtkEI_z@kernel.org>
 <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
 <aRoi-Pb8jnjaZp0X@kernel.org>
 <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>
 <aRuODFfqP-qsxa-j@kernel.org>
 <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>

On Mon, Nov 17, 2025 at 11:22:54PM -0500, Pasha Tatashin wrote:
> > You can avoid that complexity if you register the device with a different
> > fops, but that's technicality.
> >
> > Your point about treating the incoming FDT as an underlying resource that
> > failed to initialize makes sense, but nevertheless userspace needs a
> > reliable way to detect it and parsing dmesg is not something we should rely
> > on.
> 
> I see two solutions:
> 
> 1. LUO fails to retrieve the preserved data, the user gets informed by
> not finding /dev/liveupdate, and studying the dmesg for what has
> happened (in reality in fleets version mismatches should not be
> happening, those should be detected in quals).
> 2. Create a zombie device to return some errno on open, and still
> study dmesg to understand what really happened.

User should not study dmesg. We need another solution.
What's wrong with e.g. ioctl()?
 
> I think that 1 is better
> 
> Pasha

-- 
Sincerely yours,
Mike.

