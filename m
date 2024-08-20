Return-Path: <linux-fsdevel+bounces-26388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC82958D6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CFF287356
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA31C2329;
	Tue, 20 Aug 2024 17:30:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80418F2C1;
	Tue, 20 Aug 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724175016; cv=none; b=XsMwLth9KwmTj36+uvEzsFwsrdjvLpAhNtOt/6bVggxQdemGCccHgNxSdhoTaVz9QoGuwz6G/klm1rNqaFEtE1VFaIGJ09fuYMNsxjttEShOgllez0jD5ikfAKyFTf4tzbMAYAKruKUPSRm0nsUeiV5Km/LJmC1hI/Kke9uR2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724175016; c=relaxed/simple;
	bh=EKv/6g0B787M/ao79ZkDIikg1jmgFTajJr+aTG8aYbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oc6D3FPVwEqiiUqge9ArIjdh+BegmWJwxO9+mR/xm+Ya5hYzbyGbLI/O/HEDnwVTnMBhyITeAA8VLsZtrFvfWHrw/1wZMWmCjFmrMT4Ju2Bnw8KRO67++9Y7pmE+mGsF552aqad75pxEY0FSwLjb10YeuxDm1VfpuPPdG1J8qVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB55C4AF52;
	Tue, 20 Aug 2024 17:30:09 +0000 (UTC)
Date: Tue, 20 Aug 2024 18:30:07 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 13/40] arm64/mm: Map pages for guarded control stack
Message-ID: <ZsTSnx_IEqF-RkyJ@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-13-699e2bd2190b@kernel.org>
 <ZsMMDNIp6Pkfbg1e@arm.com>
 <d43f8036-cc06-430c-9e9e-b938037fc64c@sirena.org.uk>
 <ZsSvSeE303LGtk4b@arm.com>
 <ec999bf5-6273-4a3c-b1df-f8594d7bb228@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec999bf5-6273-4a3c-b1df-f8594d7bb228@sirena.org.uk>

On Tue, Aug 20, 2024 at 04:28:21PM +0100, Mark Brown wrote:
> On Tue, Aug 20, 2024 at 03:59:21PM +0100, Catalin Marinas wrote:
> > On Mon, Aug 19, 2024 at 05:33:24PM +0100, Mark Brown wrote:
> > > On Mon, Aug 19, 2024 at 10:10:36AM +0100, Catalin Marinas wrote:
> > > > Is there any arch restriction with setting BTI and GCS? It doesn't make
> > > > sense but curious if it matters. We block the exec permission anyway
> > > > (unless the BTI pages moved to PIE as well, I don't remember).
> 
> > > As you say BTI should be meaningless for a non-executable page like GCS,
> > > I'm not aware of any way in which it matters.  BTI is separate to PIE.
> 
> > My thoughts were whether we can get rid of this hunk entirely by
> > handling it in the core code. We'd allow BTI if one wants such useless
> > combination but clear VM_MAYEXEC in the core code (and ignore VM_SHARED
> > since you can't set it anyway).
> 
> I have to admit that the BTI because I was shoving _EXEC in there rather
> than because it specifically needed to be blocked.  So change the check
> for VM_SHARED to a VM_WARN_ON(), and leave the _EXEC check for now
> pending the above core change?

Yes, sounds good.

-- 
Catalin

