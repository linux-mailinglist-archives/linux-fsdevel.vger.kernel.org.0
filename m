Return-Path: <linux-fsdevel+bounces-26078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2328F953793
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0867B24522
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9554A1B3F2D;
	Thu, 15 Aug 2024 15:45:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8615E88;
	Thu, 15 Aug 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736759; cv=none; b=GItVBVpzMx3rHv1FnAvWnCh+/TxT3jz9CGD6MXat/QWV+l7h4hoehv/LzXkm2de6j/lJ4YkWyZeK4SgFvSAOq8/mEHyUaM3RlMREcMGbIVFzjB1LsA8HXExVkqbbLc5KdfCxiM3ypYOXdcg5zPSYbkVp9MB3+2WPhPciNy86ukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736759; c=relaxed/simple;
	bh=Xp9jlxYgDXqltUmPuPufUyP7g6Q5pctnBv2GovQ16XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F94WwCcjQ4jvHVpjl6xtUmxfJSs+4zimiKwcMFj4HKzLf+4rqSTFjHf6qhBkRgNSZon3b0JevYQidWDAN9IVBeCc8fDcFDcf2/6ANNve0WBaTelhEs71bjGWODBt7qTp57CtGv3iOjmM4nBGFIi7Ehm3AJHLQTa3K3vn8vweuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74432C4AF09;
	Thu, 15 Aug 2024 15:45:53 +0000 (UTC)
Date: Thu, 15 Aug 2024 16:45:51 +0100
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
Subject: Re: [PATCH v10 03/40] mman: Add map_shadow_stack() flags
Message-ID: <Zr4ir5YUxPdwqdkp@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-3-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-3-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:30PM +0100, Mark Brown wrote:
> In preparation for adding arm64 GCS support make the map_shadow_stack()
> SHADOW_STACK_SET_TOKEN flag generic and add _SET_MARKER. The existing
> flag indicats that a token usable for stack switch should be added to

Nit: indicates

> diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
> index 57e8195d0b53..d6a282687af5 100644
> --- a/include/uapi/asm-generic/mman.h
> +++ b/include/uapi/asm-generic/mman.h
> @@ -19,4 +19,8 @@
>  #define MCL_FUTURE	2		/* lock all future mappings */
>  #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
>  
> +#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
> +#define SHADOW_STACK_SET_MARKER (1ULL << 1)     /* Set up a top of stack merker in the shadow stack */

s/merker/marker/

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

