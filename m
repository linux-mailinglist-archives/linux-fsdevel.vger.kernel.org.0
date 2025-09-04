Return-Path: <linux-fsdevel+bounces-60239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B33B430AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 05:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD627C1566
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 03:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8462264A1;
	Thu,  4 Sep 2025 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbckYjIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C8F9CB;
	Thu,  4 Sep 2025 03:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756957923; cv=none; b=VLfnpUdlGd7sqAPbtZ7N2nNDP5/ERjhzTRSIdG097j3Ra6E+vpbwHx+r3kpri+eCJ7W9YUP5cPzTKG+TfihkJm2ZvZnM5KwnkIpfEiZsfjJ0wXuh0INXWapkHNCJJpEADozVdhFoPrxwDt1TqcvvXwB7spQz75kuT2uSt2jeagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756957923; c=relaxed/simple;
	bh=Mq4Kc9uMoIrJADgD3/HVomvbYH3TWWO8E7JKatF4Z2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCHwOzUOugXyl9ZniLfiXJZqNpr+o0K0PMXie0lfA79XbSjMhvEYNzfxWh5yJNOg4Vm1EfL4jP1m08/5d3tJiS92y3Qgj1PQA4rQN6dPh98H62NWtb52IaaDV6HSeIXRQNqUvZI9U0096JjWGuWxBqiArX+IvPefTk593xXrR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbckYjIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13EEC4CEF0;
	Thu,  4 Sep 2025 03:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756957922;
	bh=Mq4Kc9uMoIrJADgD3/HVomvbYH3TWWO8E7JKatF4Z2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbckYjIHgshtdKT9gVoBz9foeJDHDPTsHZpx7aFB7pMnysbfkwoOky6VDUeT2IxIf
	 LcdKdW01cW+oSxbgcGuAnIwXWKyO+q/K3OQ8GPdHjH8sumGc9LYeDOVaHg5ON3NdDF
	 ihonL0iDBEdk5z1IU4hYm3QAfNmUJ/8QGK9BjftJx2aHM0D83ve/WdOhBGaKa0LAep
	 oq4Isj5gSgsWYL1iaPo0mNcBCJkVXWyJrGdaISZZEsnERJ5ZzJRE0M1ZJ7K0BrBYNg
	 gtBhD0M/bxLJsHpvnKE7yMdmufchRPu4X5jMjw++w94uMBHPjiX+d9juBNvrQWsq3a
	 jnkFGEBD3JHqg==
Date: Wed, 3 Sep 2025 20:52:02 -0700
From: Kees Cook <kees@kernel.org>
To: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.f, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com
Subject: Re: [RFC RESEND v3] binfmt_elf: preserve original ELF e_flags for
 core dumps
Message-ID: <202509032051.BF7FC654F@keescook>
References: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>
 <20250901135350.619485-1-svetlana.parfenova@syntacore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901135350.619485-1-svetlana.parfenova@syntacore.com>

On Mon, Sep 01, 2025 at 08:53:50PM +0700, Svetlana Parfenova wrote:
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a4b233a0659e..1bef00208bdd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -224,6 +224,7 @@ config RISCV
>  	select VDSO_GETRANDOM if HAVE_GENERIC_VDSO
>  	select USER_STACKTRACE_SUPPORT
>  	select ZONE_DMA32 if 64BIT
> +	select ARCH_HAS_ELF_CORE_EFLAGS
>  
>  config RUSTC_SUPPORTS_RISCV

I'll take this patch and alphabetize the above select into the right
place. Everything else looks great. Thank you!

-Kees

-- 
Kees Cook

