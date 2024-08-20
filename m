Return-Path: <linux-fsdevel+bounces-26382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FAB958CC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E2B28746E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C11BDA8C;
	Tue, 20 Aug 2024 17:07:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301E196D9D;
	Tue, 20 Aug 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724173658; cv=none; b=OcziNq0Y7hwHBYLEhZVzNH751VtIGF1wzGVZ/adDalzlRM1U/q3xaBxuUamXm2QvobiFn9qYvl4iGixevfU09/KwTDjXwmprMNWBLmBDqFaUpNhrq/fX5jUwzpVOaXSQQmGaDx5p68Bk588/7QeCOIRP/f0GxnkxQmHy70PhFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724173658; c=relaxed/simple;
	bh=s2/nlNfABLd/gPvPhiiI1Kam85/3uV84O8KDv9iaquQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/NVZRii2AirrbrchHmeBLqqtPU6H2VoliTJzyKUVPW9IowWoiBB0xtdKFfNHpYLMLJUiLAbJM6UC7Jw5pmYbvyy9VSgLWFcmf1fdkV9QFcHRMxZhmqGUb5a/9Ug1YnGqnAcqGoYu0RaPpjZlzTBLKTw1ngluyYwjXS3WuVxkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B55C4AF13;
	Tue, 20 Aug 2024 17:07:31 +0000 (UTC)
Date: Tue, 20 Aug 2024 18:07:29 +0100
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
Message-ID: <ZsTNUYCMKgkrdRiS@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-19-699e2bd2190b@kernel.org>
 <ZsMwhdmE_Ai9BbM9@arm.com>
 <0f6fd3ec-2481-4507-af0e-3cbbb7406b54@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6fd3ec-2481-4507-af0e-3cbbb7406b54@sirena.org.uk>

On Mon, Aug 19, 2024 at 04:44:42PM +0100, Mark Brown wrote:
> On Mon, Aug 19, 2024 at 12:46:13PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 01, 2024 at 01:06:46PM +0100, Mark Brown wrote:
> > > +	/*
> > > +	 * Ensure that GCS changes are observable by/from other PEs in
> > > +	 * case of migration.
> > > +	 */
> > > +	if (task_gcs_el0_enabled(current) || task_gcs_el0_enabled(next))
> > > +		gcsb_dsync();
[...]
> > What's the GCSB DSYNC supposed to do here? The Arm ARM talks about
> > ordering between GCS memory effects and other memory effects. I haven't
> > looked at the memory model in detail yet (D11.9.1) but AFAICT it has
> > nothing to do with the system registers. We'll need this barrier when
> > ordering is needed between explicit or implicit (e.g. BL) GCS accesses
> > and the explicit classic memory accesses. Paging comes to mind, so maybe
> > flush_dcache_page() would need this barrier. ptrace() is another case if
> > the memory accessed is a GCS page. I can see you added it in other
> > places, I'll have a look as I go through the rest. But I don't think one
> > is needed here.
> 
> It's not particuarly for the system registers, is there's so that
> anything else that looks at the task's GCS sees the current state.

Ah, so that's the to ensure that any writes on the CPU to the GCS stack
would be observable if the task appears on a different CPU (together
with the additional classic ordering/spinlocks used for the run queues).
Maybe update the comment to say "GCS memory effects" instead of "GCS
changes". I read the latter as GCS sysreg changes. Something like below
would make it clearer:

	/*
	 * Ensure that GCS memory effects of the 'prev' thread are
	 * ordered before other memory accesses with release semantics
	 * (or preceded by a DMB) on the current PE. In addition, any
	 * memory accesses with acquire semantics (or succeeded by a
	 * DMB) are ordered before GCS memory effects of the 'next'
	 * thread. This will ensure that the GCS memory effects are
	 * visible to other PEs in case of migration.
	 */

Feel free to rephrase as you see fit.

> I'm pretty confident this excessive, the goal was to err on the side
> of correctness and then relax later.

I think we are missing some. Paging should be ok as we have a pte change
and TLBI and IIRC the same rules as for standard memory accesses apply.
ptrace() memory accesses may need something though I'm fine with
considering this a best effort (we can't guarantee anyway if any
accesses are on different CPUs). I haven't got to the signal handling
patch yet.

-- 
Catalin

