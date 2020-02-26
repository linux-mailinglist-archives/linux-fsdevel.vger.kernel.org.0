Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BFF16F798
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 06:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgBZFrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 00:47:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45163 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:47:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so856046pfg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2020 21:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mptYcm23xnKvc9dgW9yrQXDjYvemyNk9HOkOd35jyu0=;
        b=GG34xp+sWUcxvfNAwlpF2R/g3l9vUFYZh5jCdgnO1j5GJFdkhJ8n8xO7GULcjNoKEp
         QxNEXfAL5rOSEhshwXbzHaFc2qzrx7b9Gwp0mbHXHVCjBSiWC1UNiT8q6G9dTjhshfOG
         ocqn8ZnQkBG8WTcYA/SDlaoUa0SHMRrTDEjZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mptYcm23xnKvc9dgW9yrQXDjYvemyNk9HOkOd35jyu0=;
        b=PpDrWGcr2pLq6lKMtdGe/5VXAnclL3dzknz+ei5OD8u4jT9CVRupCME+hce++smoI7
         4h8saeY9nubYujkVH2zTu4GwTzflCB68gpSQ00b/Y7ShUsIsug/QKLu/brFs2Z6efvPO
         6FrliQ3mu+C44fGdVEhxoBFd5bK5Kwrawc9epPOCs7xZG0VFHQWgXOk98j3lMZuTRJ63
         w8OKicoed2WBr+K4DJ1+0g2rOKjL2EGbMJhOA6Muaoug6VZkxNAT8TMQpmJDLtv/JMk7
         tCXdJzLOW+lUJ5LM2+HIJDvGCMpRCBrk9ygz8AGjeEvcjYE3FAQ2W9aSDb6oAn42MrhX
         pimg==
X-Gm-Message-State: APjAAAUoBW5KUfS4as9lrooDKVFV8oTQ6wUdYrw6gTP9KKYlzojYAv69
        6pIGxt7j16zH5r2NnTjYh6kIdw==
X-Google-Smtp-Source: APXvYqw9Hah4jb9PwhTerdiDuprKFah9gRyTjuGaX0a1kpnDdbyuJ+/fWg81/jtilUouDk0Nrkg0Fg==
X-Received: by 2002:aa7:85d8:: with SMTP id z24mr2682501pfn.202.1582696054765;
        Tue, 25 Feb 2020 21:47:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o22sm898504pgj.58.2020.02.25.21.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 21:47:33 -0800 (PST)
Date:   Tue, 25 Feb 2020 21:47:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v6 05/11] arm64: elf: Enable BTI at exec based on ELF
 program properties
Message-ID: <202002252146.7230873E@keescook>
References: <20200212192906.53366-1-broonie@kernel.org>
 <20200212192906.53366-6-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212192906.53366-6-broonie@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:29:00PM +0000, Mark Brown wrote:
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index 1b6e8955c597..5d5b0321da0b 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -63,7 +63,11 @@ extern int elf_coredump_extra_notes_size(void);
>  extern int elf_coredump_extra_notes_write(struct coredump_params *cprm);
>  #endif
>  
> -/* NT_GNU_PROPERTY_TYPE_0 header */
> +/*
> + * NT_GNU_PROPERTY_TYPE_0 header:
> + * Keep this internal until/unless there is an agreed UAPI definition.
> + * pr_type values (GNU_PROPERTY_*) are public and defined in the UAPI header.
> + */
>  struct gnu_property {
>  	u32 pr_type;
>  	u32 pr_datasz;

I think this hunk should be in patch 1.

-- 
Kees Cook
