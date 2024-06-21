Return-Path: <linux-fsdevel+bounces-22134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0932912C3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58514B2C297
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7250F1662F0;
	Fri, 21 Jun 2024 17:07:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8D20314;
	Fri, 21 Jun 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989661; cv=none; b=sBxCCh298fQpKHUNz+mM+ZwedFvABn6Q3QU29WnIXf961cewHi3rKM/eIkMA1nOTmGdDHZCX0P3UGE96dm/Lq8ZMAt8niHOMFyJ92YCInP5gHfy1MigoDX9vfd6rjk9Cp6+6TsYIMG9gQPjCDgWJsN04JyT9Qo8EgWYFgunKHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989661; c=relaxed/simple;
	bh=X+jc+6nTJUN9R7eBEkca2bkre1ujOjmzla1sbAkxzng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDlaoAqo+98BtlP5lCZnf6tMMVz4nJ2FOAOLUhJ8jcNmplz18fH78pwa78r3vcMyycxSjvwzLvhObubF/jzrPT7kwi2IwSJ3d/myDEN3JaLE6OYTnbk6liS3Xe0NrpeNlmK2LKuM2zSNw3SS7kBT61Jv2X1SVm5Z2LLd8nwgbY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9058C3277B;
	Fri, 21 Jun 2024 17:07:36 +0000 (UTC)
Date: Fri, 21 Jun 2024 18:07:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 06/29] arm64: context switch POR_EL0 register
Message-ID: <ZnWzVnbDMqH_-Sk6@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-7-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-7-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:24PM +0100, Joey Gouly wrote:
> +static void flush_poe(void)
> +{
> +	if (!system_supports_poe())
> +		return;
> +
> +	write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> +	/* ISB required for kernel uaccess routines when chaning POR_EL0 */

Nit: s/chaning/changing/

-- 
Catalin

