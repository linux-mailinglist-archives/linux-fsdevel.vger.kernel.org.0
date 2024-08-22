Return-Path: <linux-fsdevel+bounces-26808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D679D95BBA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE7D0B2B761
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A231CCEF3;
	Thu, 22 Aug 2024 16:17:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4F1D130F;
	Thu, 22 Aug 2024 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343442; cv=none; b=eGmDVmK0qBG/dNhaLdFHrPNw+fy8qNVq+IqsF19V8E2H1MYFK1szUQRYoksgxd7oMybYv5asgV1VxNJ1fRJzyZ5B0z3rBHUSMyYvwlWDGnrEdVa5T/DvZuq9/BgXNweWnlpsfUglpgsteaEH9cYh50hi8dZ4cYAtEuWF03QVHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343442; c=relaxed/simple;
	bh=2lU/3y2goxQWS9PMYm6ZBCHEwiRDEHAAUriQ/kBXkJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPeua9azWlS6VQbVmFbSokqsJyevZ6unzWCto8bt4Bga2WhH5LAHrg2GNdZPJgugTabsKW7ZSOSlg7RqW62A5tzGTds8e8nbUm2oYd+AR0QF21JsE4auVTsHHftNPrDyQvRUTCkBGrAE1rhdwpa6TduYjLkatu28HYgFcPzwl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5ABC32782;
	Thu, 22 Aug 2024 16:17:16 +0000 (UTC)
Date: Thu, 22 Aug 2024 17:17:14 +0100
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 21/39] arm64/gcs: Ensure that new threads have a GCS
Message-ID: <ZsdkikRi2wgBlODX@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-21-41b81947ecb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-arm64-gcs-v11-21-41b81947ecb5@kernel.org>

On Thu, Aug 22, 2024 at 02:15:24AM +0100, Mark Brown wrote:
> @@ -512,10 +538,16 @@ static void gcs_thread_switch(struct task_struct *next)
>  		gcs_set_el0_mode(next);
>  
>  	/*
> -	 * Ensure that GCS changes are observable by/from other PEs in
> -	 * case of migration.
> +	 * Ensure that GCS memory effects of the 'prev' thread are
> +	 * ordered before other memory accesses with release semantics
> +	 * (or preceded by a DMB) on the current PE. In addition, any
> +	 * memory accesses with acquire semantics (or succeeded by a
> +	 * DMB) are ordered before GCS memory effects of the 'next'
> +	 * thread. This will ensure that the GCS memory effects are
> +	 * visible to other PEs in case of migration.
>  	 */
> -	gcsb_dsync();
> +	if (task_gcs_el0_enabled(current) || task_gcs_el0_enabled(next))
> +		gcsb_dsync();
>  }

Ah, the comment turned up in this patch. It looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

