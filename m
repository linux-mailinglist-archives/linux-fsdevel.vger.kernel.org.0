Return-Path: <linux-fsdevel+bounces-4724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABD5802AE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 05:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F286C1C2088C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 04:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2D1CA9C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3DwEmB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC6BF0
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 19:01:52 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce2ff70619so302388b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Dec 2023 19:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701658912; x=1702263712; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=CQYiiiRLontcDI44whmeD/LoEJVxuqfkBiryqv/zBTg=;
        b=q3DwEmB4PoXI90W8n4dpmreCIn3QymFrI+vnck8BQ4dZsXgYzdXpJMmLdCZsaQ6W/D
         cCuK7B29+4/j/SkY/E+9CTj9nzcV0g2DJ5jYfDlkyQ+Ovvj1Am9zG3tQH0rtpapkcr1h
         jAwkf0pAEEkKC8bGb4InCLPTPtxTR1y+i7Uc/7KHnIieKwTm64vsRpjyd3APhjoiBaBO
         ULZjb7JIafyeidTMh58sJPA/6HZysYsXrcLxEPfmTZpWPDzC7cgpN60Zn/w/U9YJQf3Z
         ktGaDBSOto0r54hhNHk1gVGqZgPEcQcsRm/RNwTMI6xA6LplPnjn9zVvxD5/pB65rjb3
         9eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701658912; x=1702263712;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQYiiiRLontcDI44whmeD/LoEJVxuqfkBiryqv/zBTg=;
        b=RJCp20CgcYFIhcteGNf13TfIh6Hc0KDqNevbQRv67hgOwdmydOn3KRUxJkwhkjUuPW
         3O1Gp0L5CXi7V3QLEQKAouFBmKQRrUOEOWYg67KSL755Wqjq365vsQ11M+lybTj2DHt+
         5c5g48hMJtGl0KYxwcmQ/3QNysp099dYOwHaHNSDumX8v46oCURo4BPa76V0Je3WhSUQ
         /V/P9Snl8kba8okGtz+IWAE0Cn3LMdwQys9k3zRyE0zlCeXRL30xyJ2X14U/UY6j4va+
         taUJFmq73ZZkzO4aTQY8Cx4+bd4S+yY13udNCoDTT6BBgIJAlKFBNseEbjaDPUQ1RYa1
         1hLw==
X-Gm-Message-State: AOJu0YxkGeLbrjLlMetj+hRpZDpSlYqDbHbYfT2XUo6r7zwMGXi5EMGd
	JsnC1G6f8yL7KViLx8aUGZMHgA==
X-Google-Smtp-Source: AGHT+IHFLJUBmtnWAvysao8TWHQlyk2Cfpox9jD8bkyNgUP4wKyxIxGZHkfjhvm//XUEUavLfPd53A==
X-Received: by 2002:a05:6a20:748f:b0:18c:8fef:22cc with SMTP id p15-20020a056a20748f00b0018c8fef22ccmr1035248pzd.24.1701658911982;
        Sun, 03 Dec 2023 19:01:51 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:979a:226c:de55:73de])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78818000000b006cd88728572sm6562301pfo.211.2023.12.03.19.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 19:01:51 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-13-201c483bd775@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 13/39] arm64/mm: Map pages for guarded control stack
In-reply-to: <20231122-arm64-gcs-v7-13-201c483bd775@kernel.org>
Date: Mon, 04 Dec 2023 00:01:49 -0300
Message-ID: <87a5qqisbm.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello,

Mark Brown <broonie@kernel.org> writes:

> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index 645fe60d000f..605d4e6edc1d 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -79,9 +79,20 @@ arch_initcall(adjust_protection_map);
>  
>  pgprot_t vm_get_page_prot(unsigned long vm_flags)
>  {
> -	pteval_t prot = pgprot_val(protection_map[vm_flags &
> +	pteval_t prot;
> +
> +	/* If this is a GCS then only interpret VM_WRITE. */
> +	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
> +		if (vm_flags & VM_WRITE)
> +			prot = _PAGE_GCS;
> +		else
> +			prot = _PAGE_GCS_RO;
> +	} else {
> +		prot = pgprot_val(protection_map[vm_flags &
>  				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
> +	}
>  
> +	/* VM_ARM64_BTI on a GCS is rejected in arch_valdiate_flags() */

s/valdiate/validate/

>  	if (vm_flags & VM_ARM64_BTI)
>  		prot |= PTE_GP;


-- 
Thiago

