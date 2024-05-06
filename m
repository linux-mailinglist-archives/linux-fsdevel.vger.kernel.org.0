Return-Path: <linux-fsdevel+bounces-18820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF38BCA1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0881F2102F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838B1422A8;
	Mon,  6 May 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gS2TAt28"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A481420DE
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985866; cv=none; b=s+K+5GLT6uLI2ws51qBn9bY8E6SolPMRf19fR10qpjNuk+zq1RuIyP6+2bL2sPRfl5tdvjG8BJhoWgO6963GABDqqPNkyuUpQ+Xz5Z1i0hwbEiC3Cs0qoJAikfWEUS5G16DFzQvyzhzo2PXwZLIdGI9JVWaKQtCUfFidF4ZnGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985866; c=relaxed/simple;
	bh=3chMsjDBSVl6/YzmBwyDmo8vb4MCwHLCL/FCQilywTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NjPdVw26izND5a8tIrjB/zESOJ8WkmsHk4NDGBlErsF1x1N82WZwqn7I30/TFB02GDUHdEIkmms14dXds+l/CQXhZxTTDlMzxL/1GcpOXaLL0QhYh9D97mSgKlYyEiOna/Y/1yG/7KrdHaMeMzH0bgKVlv+QIhS/O6y3WohClKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=gS2TAt28; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714985861;
	bh=cckhLARkyb3oh/wDwudJRWGBL6LODBWmZxbKJGkql3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gS2TAt28hdJp0GVGuxc0GqF0HBwJIIE6g865JbTcDlQ4Bq15z5L2lKpDYOEn9r1ww
	 hsX15AwxZD1CjOwo4xRbYzBcwoiSq0TNZUiTXUub8V24eZGadzhzkvFJHFFu9oZt3H
	 QAcIpzLF9IzLL8/RJlkwnpXW7MyeKY0uF2NehUEzm9/Bim0CzqfU9w9cwum+5pGQwF
	 xSI1GAbrHs1469EaFCgMZwVhfD2AiSCW6nWax66+g5qkjilBF79mQZpSQL5OrQSGXu
	 e5172dSMmCRQxc4I8MOmnYs1NF2QAnG5NjOlhgW4zHUvQ/3D8+TxMr/9S1YopiTt4Z
	 JS27CStBxNFLw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VXwKC2cR3z4x12;
	Mon,  6 May 2024 18:57:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
 catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, joey.gouly@arm.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
 naveen.n.rao@linux.ibm.com, npiggin@gmail.com, oliver.upton@linux.dev,
 shuah@kernel.org, szabolcs.nagy@arm.com, tglx@linutronix.de,
 will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 01/29] powerpc/mm: add ARCH_PKEY_BITS to Kconfig
In-Reply-To: <20240503130147.1154804-2-joey.gouly@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-2-joey.gouly@arm.com>
Date: Mon, 06 May 2024 18:57:32 +1000
Message-ID: <8734qvnwqr.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joey Gouly <joey.gouly@arm.com> writes:
> The new config option specifies how many bits are in each PKEY.
>
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1c4be3373686..6e33e4726856 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -1020,6 +1020,10 @@ config PPC_MEM_KEYS
>  
>  	  If unsure, say y.
>  
> +config ARCH_PKEY_BITS
> +	int
> +	default 5
> +
>  config PPC_SECURE_BOOT
>  	prompt "Enable secure boot support"
>  	bool
> -- 
> 2.25.1

