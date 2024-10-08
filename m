Return-Path: <linux-fsdevel+bounces-31281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFBE994061
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 10:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA715289C4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA21F9414;
	Tue,  8 Oct 2024 07:03:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847A1F9408;
	Tue,  8 Oct 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371010; cv=none; b=B3QCOG/X/qMKC/7G/Mc/LpNpMqFsEIWUiFHRXBk4YNHLDhzsmvU/8mZQe6B6ERH02tL1PkYirRrb6MNopOq56t8/xvtK6SPxJ7yHDQdGTDPLZuG37M0BAxxoB36I6MmOnVxw8phHjdPCuB/XgwdhoUqus/QyEnOSTR0x5Ptv6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371010; c=relaxed/simple;
	bh=qTdHcUquvVIj5n44UFGoznQhbIg+PrAhpjPHGQ/oEhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYcVy7I6rad4h45u8wFHBRS0b/pAf7sKdeSXGgTM7IlVYgnu2lBPXlIMEMXu4uIweaumYvKSs+A4L8Mf3nsH7BGAuVjoJG7+mYZqmI3uSNXOWki3WgzI0VLhpQv3kRgaWIc596cXgyn5VoNnkAhKNW8kanOVW3Kn9wRL9BI51Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 078F4DA7;
	Tue,  8 Oct 2024 00:03:57 -0700 (PDT)
Received: from [10.163.38.160] (unknown [10.163.38.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCA453F640;
	Tue,  8 Oct 2024 00:03:22 -0700 (PDT)
Message-ID: <2e9e559e-82b3-4ba7-8316-a514abe9dd38@arm.com>
Date: Tue, 8 Oct 2024 12:33:18 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4
To: Mark Brown <broonie@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Yury Khrustalev <yury.khrustalev@arm.com>,
 Wilco Dijkstra <wilco.dijkstra@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
 <20241004-arm64-elf-hwcap3-v2-1-799d1daad8b0@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241004-arm64-elf-hwcap3-v2-1-799d1daad8b0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/5/24 01:56, Mark Brown wrote:
> AT_HWCAP3 and AT_HWCAP4 were recently defined for use on PowerPC in commit
> 3281366a8e79 ("uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector,
> entries"). Since we want to start using AT_HWCAP3 on arm64 add support for
> exposing both these new hwcaps via binfmt_elf.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  fs/binfmt_elf.c        |  6 ++++++
>  fs/binfmt_elf_fdpic.c  |  6 ++++++
>  fs/compat_binfmt_elf.c | 10 ++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 06dc4a57ba78a7939bbde96bf181eefa950ea13a..3039a6b7aba4bd38f26e21b626b579cc03f3a03e 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -257,6 +257,12 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
>  #ifdef ELF_HWCAP2
>  	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
> +#endif
> +#ifdef ELF_HWCAP3
> +	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
> +#endif
> +#ifdef ELF_HWCAP4
> +	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
>  #endif
>  	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
>  	if (k_platform) {
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 4fe5bb9f1b1f5e0be6e8d1ef5b20492935b90633..31d253bd3961a8679678c600f4346bba23502598 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -623,6 +623,12 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	NEW_AUX_ENT(AT_HWCAP,	ELF_HWCAP);
>  #ifdef ELF_HWCAP2
>  	NEW_AUX_ENT(AT_HWCAP2,	ELF_HWCAP2);
> +#endif
> +#ifdef ELF_HWCAP3
> +	NEW_AUX_ENT(AT_HWCAP3,	ELF_HWCAP3);
> +#endif
> +#ifdef ELF_HWCAP4
> +	NEW_AUX_ENT(AT_HWCAP4,	ELF_HWCAP4);
>  #endif
>  	NEW_AUX_ENT(AT_PAGESZ,	PAGE_SIZE);
>  	NEW_AUX_ENT(AT_CLKTCK,	CLOCKS_PER_SEC);
> diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
> index 8f0af4f626316ed2e92204ff9bf381cd14103ae9..d5ef5469e4e620f6ee97f40ce9cbbfa48e37e33c 100644
> --- a/fs/compat_binfmt_elf.c
> +++ b/fs/compat_binfmt_elf.c
> @@ -80,6 +80,16 @@
>  #define	ELF_HWCAP2		COMPAT_ELF_HWCAP2
>  #endif
>  
> +#ifdef	COMPAT_ELF_HWCAP3
> +#undef	ELF_HWCAP3
> +#define	ELF_HWCAP3		COMPAT_ELF_HWCAP3
> +#endif
> +
> +#ifdef	COMPAT_ELF_HWCAP4
> +#undef	ELF_HWCAP4
> +#define	ELF_HWCAP4		COMPAT_ELF_HWCAP4
> +#endif
> +
>  #ifdef	COMPAT_ARCH_DLINFO
>  #undef	ARCH_DLINFO
>  #define	ARCH_DLINFO		COMPAT_ARCH_DLINFO
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

