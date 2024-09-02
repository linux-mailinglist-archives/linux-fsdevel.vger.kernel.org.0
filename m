Return-Path: <linux-fsdevel+bounces-28277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B80968DF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 20:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F5D1C22500
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 18:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7761A304D;
	Mon,  2 Sep 2024 18:55:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFA1A3A9A;
	Mon,  2 Sep 2024 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303315; cv=none; b=KA/K0tLxj0QKg3Jj8PFsgsN2j9mUBjE436y4dCg2B+q289PXrNrA31kImPrbxEtInDkpM1UiywymhiyK2M5AUd/h29nmEpNG1P4sy1UWznUyzUmTiMHC5gQcUDAcoppN/y3bZtZFthTXWtGtAwsPmiaPId1w1iFGOQ36RLIA/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303315; c=relaxed/simple;
	bh=v5mcmTZfmlsLZXiOWnOkcdL/uKkZ0K+/8+BfFfMCxgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6LKKwQLq2tiOdKGfQvsg/s+E6w6tYDyG1hZhkbAPecY6Sg2dTFoexCcOYKvWeyrU/waUDaq1WQoNfeMQO4F9iY427CVxeEQmHwOMXAZn8HlE1FgbJZnHojhvVUYzJS06LLQCQJ4o+364tv2MpPoi9/O21r7CDZD4m588wLlMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB9EC4CEC2;
	Mon,  2 Sep 2024 18:55:09 +0000 (UTC)
Date: Mon, 2 Sep 2024 19:55:07 +0100
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
Subject: Re: [PATCH v12 25/39] arm64/signal: Expose GCS state in signal frames
Message-ID: <ZtYKC8ytQBJpudOt@arm.com>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
 <20240829-arm64-gcs-v12-25-42fec947436a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-arm64-gcs-v12-25-42fec947436a@kernel.org>

On Thu, Aug 29, 2024 at 12:27:41AM +0100, Mark Brown wrote:
> Add a context for the GCS state and include it in the signal context when
> running on a system that supports GCS. We reuse the same flags that the
> prctl() uses to specify which GCS features are enabled and also provide the
> current GCS pointer.
> 
> We do not support enabling GCS via signal return, there is a conflict
> between specifying GCSPR_EL0 and allocation of a new GCS and this is not
> an ancticipated use case.  We also enforce GCS configuration locking on
> signal return.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

It looks fine to me now.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

