Return-Path: <linux-fsdevel+bounces-26807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523BA95BB8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0211C23F35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C691CDA1E;
	Thu, 22 Aug 2024 16:15:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55F2D03B;
	Thu, 22 Aug 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343329; cv=none; b=N97WHKnDVD0Z2oKHWLJx59LaSz/WEyZ0nMFq2StOaKC7k7iKSkK57CTZ0e7QazoswLSm+x7dyni6mb+ygCzqoE/t6Q1Mw+w9ybMmhtf55uDi9G2dl6DUDkiHaMKr8UYl57vOB7yadwvN4IETrTOZaMyo9Sn+8RoAoI8jMURToVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343329; c=relaxed/simple;
	bh=1uX7PcR4Ki0mG7RlhQG8n+uohdePjIJKoDnD5+Tuxv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyuX7/vyIFJkJGrFWf6n2YNj7Wnsf8vf6sAdc0TrGenNAhIqBH7Fo4Jb/OSmVh0wJHwp42NltKTRp6L8PAzNuYi9i0/tGiaWgxACOpLwB1y+k7dNIHMv5DswYnKKaGpAX6OegA8hK+ak/Iz6Mwu3qzXtCeXo2dBHzA7wP8knjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F58C32782;
	Thu, 22 Aug 2024 16:15:23 +0000 (UTC)
Date: Thu, 22 Aug 2024 17:15:20 +0100
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
Subject: Re: [PATCH v11 20/39] arm64/gcs: Context switch GCS state for EL0
Message-ID: <ZsdkGJb93LjLUyzo@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-20-41b81947ecb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-arm64-gcs-v11-20-41b81947ecb5@kernel.org>

On Thu, Aug 22, 2024 at 02:15:23AM +0100, Mark Brown wrote:
> There are two registers controlling the GCS state of EL0, GCSPR_EL0 which
> is the current GCS pointer and GCSCRE0_EL1 which has enable bits for the
> specific GCS functionality enabled for EL0. Manage these on context switch
> and process lifetime events, GCS is reset on exec().  Also ensure that
> any changes to the GCS memory are visible to other PEs and that changes
> from other PEs are visible on this one by issuing a GCSB DSYNC when
> moving to or from a thread with GCS.
> 
> Since the current GCS configuration of a thread will be visible to
> userspace we store the configuration in the format used with userspace
> and provide a helper which configures the system register as needed.
> 
> On systems that support GCS we always allow access to GCSPR_EL0, this
> facilitates reporting of GCS faults if userspace implements disabling of
> GCS on error - the GCS can still be discovered and examined even if GCS
> has been disabled.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

We could do with a bit more code comments around GCSB DSYNC but
otherwise it looks fine now.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

