Return-Path: <linux-fsdevel+bounces-26458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E025995980C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 12:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B31C21A51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CDE1BF800;
	Wed, 21 Aug 2024 08:50:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865F1547C2;
	Wed, 21 Aug 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230231; cv=none; b=bfSLzsptzWHGrM04ob6zKSGHjJ1vrmJ/sBJVRspq7rPczM9h2NyCZgPB5Qg7yDTwNLMb33H7yw40oWMMnLApB7QBBz7b6pcR14meOmqDCBSz9s2p6b/DmCC9DhlJ1lzyOwYFu6zwWbd3YDQXEqocdfQfZ9Vxc2NS9Itq1jSxHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230231; c=relaxed/simple;
	bh=tnrxtob0yb9eMmfLRERGvYJGOSdmCt6YF/gYnTDfJ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIgOSgd1AuLpSXERShrgmYznd3wAfPk6UQk4cgtiAaPTScbsEMh7q75xpZqYV83RrEJLhTSJOm2cG/eETjcDdEWH7ghQxrsluvVRxpuce4XVkFofMNxlSVmsr2WoPIQTrV+1d7Cf7D7HRDeXGz42jm9YysL5ZA+JQyPtktGfwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F403AC32782;
	Wed, 21 Aug 2024 08:50:24 +0000 (UTC)
Date: Wed, 21 Aug 2024 09:50:22 +0100
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
Subject: Re: [PATCH v10 19/40] arm64/gcs: Context switch GCS state for EL0
Message-ID: <ZsWqTtCq1mNJH1vz@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-19-699e2bd2190b@kernel.org>
 <ZsMwhdmE_Ai9BbM9@arm.com>
 <0f6fd3ec-2481-4507-af0e-3cbbb7406b54@sirena.org.uk>
 <3b316422-7f88-4f5d-a691-eb9209ec4ba9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b316422-7f88-4f5d-a691-eb9209ec4ba9@sirena.org.uk>

On Tue, Aug 20, 2024 at 06:56:19PM +0100, Mark Brown wrote:
> On Mon, Aug 19, 2024 at 04:44:52PM +0100, Mark Brown wrote:
> > On Mon, Aug 19, 2024 at 12:46:13PM +0100, Catalin Marinas wrote:
> > > On Thu, Aug 01, 2024 at 01:06:46PM +0100, Mark Brown wrote:
> 
> > > > +	/*
> > > > +	 * Ensure that GCS changes are observable by/from other PEs in
> > > > +	 * case of migration.
> > > > +	 */
> > > > +	if (task_gcs_el0_enabled(current) || task_gcs_el0_enabled(next))
> > > > +		gcsb_dsync();
> 
> > > Could we do the sysreg writing under this 'if' block? If no app is using
> > > GCS (which would be the case for a while), it looks like unnecessary
> > > sysreg accesses.
> 
> > Yes, that should be fine I think.
> 
> I forgot when writing the above that we always allow reads from
> GCSPR_EL0 in order to avoid corner cases for unwinders in the case of
> asynchronous disable.  I'd expect that to be cheap to access though.

But then gcs_preserve_current_state() doesn't save the GCSPR_EL0 value
if the shadow stack was disabled. At the subsequent switch to this task,
we write some stale value.

-- 
Catalin

