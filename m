Return-Path: <linux-fsdevel+bounces-31975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17EE99EB57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2B51F209AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FE01D5ABD;
	Tue, 15 Oct 2024 13:05:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649631C07DB;
	Tue, 15 Oct 2024 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997546; cv=none; b=usNFuBUxBrV9m9Ek6i+H5bEIlw3FZOMH/LbJU6KdotJPmf1+brzskWY5OvZQFDV1WWyCqHG6gj02EsA8QRqcs85DCRm0y6A0wqOZ+GTBXECFouItDJIjwyYXSPUOLZtfNU7hpzoT+V+TZoBWmdkiEor1deJZOf3rtv5oTf5NQ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997546; c=relaxed/simple;
	bh=gK4QnrS2Sm+VO7VdVB+g+vOjiZv1ni06CPOZFvH/IkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef+2CogbkcsYs0XuxO5/HeKmVSFxr95HKyJr7G1NeiS6x43uY0Kz0qfdnBqIKsMoixmIs1hXJlASq8j85cJvNQzZ79NMj5PuNpJ1GXLMgSMRPi3vWCRj7cokcyfVysRjuIZN806NK3o4e1I3lduvgqwQH2MliagmpdMSVi7RVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25155C4CEC6;
	Tue, 15 Oct 2024 13:05:39 +0000 (UTC)
Date: Tue, 15 Oct 2024 14:05:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	David Spickett <david.spickett@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 11/40] arm64/gcs: Provide basic EL2 setup to allow
 GCS usage at EL0 and EL1
Message-ID: <Zw5oofuDjuCemq19@arm.com>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
 <20241001-arm64-gcs-v13-11-222b78d87eee@kernel.org>
 <20241009204903.GA3353168@thelio-3990X>
 <86msjc56mi.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86msjc56mi.wl-maz@kernel.org>

On Thu, Oct 10, 2024 at 04:18:13PM +0100, Marc Zyngier wrote:
> From 20c98d2647c11db1e40768f92c5998ff5d764a3a Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Thu, 10 Oct 2024 16:13:26 +0100
> Subject: [PATCH] KVM: arm64: Shave a few bytes from the EL2 idmap code
> 
> Our idmap is becoming too big, to the point where it doesn't fit in
> a 4kB page anymore.
> 
> There are some low-hanging fruits though, such as the el2_init_state
> horror that is expanded 3 times in the kernel. Let's at least limit
> ourselves to two copies, which makes the kernel link again.
> 
> At some point, we'll have to have a better way of doing this.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20241009204903.GA3353168@thelio-3990X

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>

Please merge it as a KVM fix if you can. Thanks.

-- 
Catalin

