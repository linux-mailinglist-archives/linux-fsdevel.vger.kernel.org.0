Return-Path: <linux-fsdevel+bounces-60714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07B3B5042D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 19:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DFF16D715
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEDD356904;
	Tue,  9 Sep 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iKyeMhFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575683168E1
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437987; cv=none; b=H5h2H3H2aldKKbiRqdt6V3vqF3TaVJSmDF3VneosAA7B6xveFadLHm8cFENyOMra5/COewQacVXppXNSAg4Ald8cNvrJ+HMFpGhZ0LptY965mXXCMdPDHLW7lE2ddh8i0ec54X1otUYC0Au7juB7iy/kOcyqZlepo0v62slYrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437987; c=relaxed/simple;
	bh=gNg8AqfR0tciB3ysEt43D3UHmeklQnCdJd6jEFYWjjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puITZx3C7lR4q67gAsHRWSKi+HXQfLrI8bzAFfqQ3NPSO+kZohyyRnOUqN+7DE/VoAPYzBFrka2wX/LKJWTGsfW8MMUCK47Gm7sgXIUUe6Ec8PFW7uiI/1qpTibgKIO7pSEbQsuMQXlbs33AAOMEP6Xw9KoekoKmhp2AAwJdBzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iKyeMhFC; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-889b846c568so223357139f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1757437984; x=1758042784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLUjg7yNG/ewQNg8kcK05UeNpGcVlJZKIKA/TtV5FkM=;
        b=iKyeMhFCx5QyLzib+c0UcMUyy3ci9O35rqkX52CzGjFLcIRPpbnuvQXbSdV0ae+gLG
         nLWhgFjuBZNPiZF6inrxX+CA+RE5ewT/7KGB1YJeNcSPdVyMZ4BsTexmnZpuaw5ArUPQ
         +yLJMvEke0l3vTxAgt+J7NsamHsH5C3EFtyR9nNEu+0dQzh+xve2E23EGLFXWlQs9TNa
         v70afC1HZI7RnAxRoPw1YBz3Ub0ZTp5+p/XHLcuqRisZeHMnj/1gc8ZrwrHb3X+NFgrE
         CgB13cmOAYjtXJHwpKzhG0JKdbTRDlCTeaJex9BNtegCWuVNOD0sTu95MJvJRqZBAH+p
         HqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437984; x=1758042784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLUjg7yNG/ewQNg8kcK05UeNpGcVlJZKIKA/TtV5FkM=;
        b=M+b1xD0d5XUFjKyiU3+0JD1UH/KmQ4U/7g+PMHMrWC7ENrnZw7ewEMM/rV0lmSgXrb
         K5+DxDD4/pT8GkMR17towInPYQGVAMSifUsFpMv03p6V8uirYMMROBiQUO1doXoMjN5B
         kGiT7S78UMNf0AadibPihDwfimIr6gNxry+6XYRz+kAAAmuLj/aa0ZMiDa2Ek28iKJO/
         YnPuHuplauidLDamEXKQMVF0JKjt67clALkJL/0nSRSxbZDNW2qoTDUE6t6KblGaSyO0
         Kw9IZKcO9IVXccvdsqR1461DML+WLa8wc3LMUfc969/vVSpqVDMYQEi6fpzLcRGTIbTS
         QAfA==
X-Forwarded-Encrypted: i=1; AJvYcCVZvKSRi0LyRgpLjqBRWqqYHSpDgnBd80CdTc+twL8Bpm9QuBsE0myi0qZAkw7iy7tw+qLwGSxZEkngx3Uy@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNU6lWmenXZRjULlP2tLEHp4xhm7HjC2fAXwjZmrvJ4UIIq0e
	nmExUD4USgq5AhxmyvV2QMzVFquq8/iHu5p6sGL0eS92QG2oT64KNtddIrpq9/bLzk8=
X-Gm-Gg: ASbGncudY6aVvFae30gr3BPvOxk76FEKFuJGwfI1eJdwcd29y4TNlvWv+Whf2OzmuRM
	wR2zF7vs1g5kfj8OuGZZmNiNnuCwMDpThXsVRMey25rxhVl8ySR+NbLja06YHjOPQE3slyh9Ko5
	p4IsjJFM8u7OJ9IANXmhQ3cgHbgeuENho2X/oGTRKiqzc9BbD0BokADilm5vNkM2EusFjJYWbZQ
	lxxVGyMiFMK8BZFRX9mj+ZpLtF4H3DKfJ+ds/LUYrFA9ZhaT0Pod9Po6ZVCSeLzpEfNkp/zFhvF
	8MN8N0NE3B31b95gxE2A63cyurVY+EFBo1fh3S1jC+0w3zk96kIRGR04sj42msnGedM3O2/38+d
	NDWm/UHUM/l3n2Bcd2EdE73Zc2u0hH37kMQQ=
X-Google-Smtp-Source: AGHT+IEMFpaj8bMLzDHV4JtX7+vWxYaXCZCBKZ479bbfT1RoejNAOJVpK28JUe1NbmGtyLq/mXgp8A==
X-Received: by 2002:a05:6e02:1a0c:b0:40a:e839:a2e4 with SMTP id e9e14a558f8ab-40ae839a49bmr96540285ab.30.1757437980965;
        Tue, 09 Sep 2025 10:13:00 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5104c5a4d0dsm5507495173.0.2025.09.09.10.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:13:00 -0700 (PDT)
Date: Tue, 9 Sep 2025 12:12:59 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Deepak Gupta <debug@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V10 3/5] riscv: Add RISC-V Svrsw60t59b extension support
Message-ID: <20250909-2130daabd7f57a8a357c677f@orel>
References: <20250909095611.803898-1-zhangchunyan@iscas.ac.cn>
 <20250909095611.803898-4-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909095611.803898-4-zhangchunyan@iscas.ac.cn>

On Tue, Sep 09, 2025 at 05:56:09PM +0800, Chunyan Zhang wrote:
> The Svrsw60t59b extension allows to free the PTE reserved bits 60
> and 59 for software to use.
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>  arch/riscv/Kconfig             | 14 ++++++++++++++
>  arch/riscv/include/asm/hwcap.h |  1 +
>  arch/riscv/kernel/cpufeature.c |  1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a4b233a0659e..d99df67cc7a4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -862,6 +862,20 @@ config RISCV_ISA_ZICBOP
>  
>  	  If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_SVRSW60T59B
> +	bool "Svrsw60t59b extension support for using PTE bits 60 and 59"
> +	depends on MMU && 64BIT
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	  Adds support to dynamically detect the presence of the Svrsw60t59b
> +	  extension and enable its usage.
> +
> +	  The Svrsw60t59b extension allows to free the PTE reserved bits 60
> +	  and 59 for software to use.
> +
> +	  If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>  	def_bool y
>  	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index affd63e11b0a..f98fcb5c17d5 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -106,6 +106,7 @@
>  #define RISCV_ISA_EXT_ZAAMO		97
>  #define RISCV_ISA_EXT_ZALRSC		98
>  #define RISCV_ISA_EXT_ZICBOP		99
> +#define RISCV_ISA_EXT_SVRSW60T59B	100
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 743d53415572..de29562096ff 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -540,6 +540,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>  	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
> +	__RISCV_ISA_EXT_DATA(svrsw60t59b, RISCV_ISA_EXT_SVRSW60T59B),

svrsw60t59b should come before svvptc. See the ordering rule comment at
the top of the array.

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

>  };
>  
>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

