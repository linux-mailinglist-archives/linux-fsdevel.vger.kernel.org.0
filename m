Return-Path: <linux-fsdevel+bounces-26912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6819195CE33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 15:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1CA282B19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D850187877;
	Fri, 23 Aug 2024 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diJF9KTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C24430;
	Fri, 23 Aug 2024 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420540; cv=none; b=RwLAtvl+w/zBqvykUFZvNBQLWWay2Jgw74ldhLg9LvZJbj4x9TfDlNY4hRS9spbo8clDJ7TMpqyqxzIdUC8s/lGv9+6ik8CZYN7hnp2FkcQL5XdZkcGy08Fm46RuvNpHVJNlxd6gxKPa6bjxftMcQzsNp39XQ44gnuNc4lVIrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420540; c=relaxed/simple;
	bh=p7ZIANVfDlXfoD29LXtd0evBx7y2j+mvpMRvoiijjDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcTDaNrY7up4L9SptN/FfubtJ3StHIhfb9xHkVjtLXmxVzzJWC6pjJExwWI4lWPIr6jQHP5fx35lZeJaTfnmYDQhoHK7lpc9OiGv6QkTsTwWf0VYJYJAE3khcsniIKmr59GOdlqHL9rrZNZzkYRaJwlcnt44m0W8KQwEMx9a3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diJF9KTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E33C32786;
	Fri, 23 Aug 2024 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724420540;
	bh=p7ZIANVfDlXfoD29LXtd0evBx7y2j+mvpMRvoiijjDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diJF9KTvNtOkFxSbJXKbytkFAtignBqhPmYEolOHprLDUViiVjuKDHUVvblLiJoQK
	 cYAq2OFQ1lC4Ob4pfq5sgJpfMW0nC0GYloyNujsF8966uVxZOtpAfbh+JXp4NFAXi6
	 zGYX9PXuywc/Nn2EaTGKd9Kg3OUZAfcHhEG+bSe3hFweisJRBzWLqXIhMjTnOFsE0k
	 BYfyDcsS8zmIES3CMBMtscVY670iajmo99zrDiLGTOeSpVKhmRvfeA06Kvp3uAINuA
	 cgeKenNlP7lid7lc7d1aVOD3AdNXVJOFk/vBTQVF0s7Q5L+YUfHHd/MdBxMETD+T+T
	 +SkkSJYuyEi6A==
Date: Fri, 23 Aug 2024 14:42:12 +0100
From: Will Deacon <will@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 04/30] arm64: disable trapping of POR_EL0 to EL2
Message-ID: <20240823134211.GF32156@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-5-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822151113.1479789-5-joey.gouly@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 22, 2024 at 04:10:47PM +0100, Joey Gouly wrote:
> Allow EL0 or EL1 to access POR_EL0 without being trapped to EL2.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/el2_setup.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git arch/arm64/include/asm/el2_setup.h arch/arm64/include/asm/el2_setup.h
> index fd87c4b8f984..212191ecad40 100644
> --- arch/arm64/include/asm/el2_setup.h
> +++ arch/arm64/include/asm/el2_setup.h
> @@ -185,12 +185,20 @@
>  .Lset_pie_fgt_\@:
>  	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
>  	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1PIE_SHIFT, #4
> -	cbz	x1, .Lset_fgt_\@
> +	cbz	x1, .Lset_poe_fgt_\@
>  
>  	/* Disable trapping of PIR_EL1 / PIRE0_EL1 */
>  	orr	x0, x0, #HFGxTR_EL2_nPIR_EL1
>  	orr	x0, x0, #HFGxTR_EL2_nPIRE0_EL1
>  
> +.Lset_poe_fgt_\@:
> +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1POE_SHIFT, #4
> +	cbz	x1, .Lset_fgt_\@
> +
> +	/* Disable trapping of POR_EL0 */
> +	orr	x0, x0, #HFGxTR_EL2_nPOR_EL0

Dave's reworking the labels here on for-next/misc:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/misc&id=5b39db6037e7cba1659f2149aef76934370aa6d5

Please can you follow that new style for the new label so that we don't
end up with an immediate inconsistency? Leave the '.Lset_fgt' label
as-is and I'll fix it when we merge the branches.

Cheers,

Will

