Return-Path: <linux-fsdevel+bounces-26110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552709547AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBF31F21131
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9986F196D80;
	Fri, 16 Aug 2024 11:12:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2EF1991AA;
	Fri, 16 Aug 2024 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806775; cv=none; b=PDn06zk2Jb+jiOhPoGpJUGF5c7RLIzNYdAcGra8iqU6gnbQ7e9MzUkJHbVl/IfHoBEHN/w0BV0Ji1KAEyHjqLTd+58TzVswss8Y91Y1Oj43JNPXK718amfOrYRT9QWVqClEga9bvZQMQjC8TmHFHmY4B0bImH+ZOM7YVPDog55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806775; c=relaxed/simple;
	bh=6R4O9J3ICVeVbc4+EdLu04NswhU7HbU0el3VJkuKwig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUBW3o63YmYzhgw7yvhZ8ngrVX8ttOR/so2b4gOOcCtkI07L5xNFYSgSzPZrMOolY/Ib+8TXe0HEC/1gs/Q5btxnE64o7dRjE0ySi69kbscJSg/KOTZQNIUSRcgOz5qR+e86ruM9yi3VYtgO3q1Xb1KfWRd/QAplwfLfMVlwmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F3C4AF0C;
	Fri, 16 Aug 2024 11:12:49 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:12:47 +0100
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
Subject: Re: [PATCH v10 08/40] arm64/gcs: Provide put_user_gcs()
Message-ID: <Zr80L7v-kjtGbYzh@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-8-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-8-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:35PM +0100, Mark Brown wrote:
> In order for EL1 to write to an EL0 GCS it must use the GCSSTTR instruction
> rather than a normal STTR. Provide a put_user_gcs() which does this.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

