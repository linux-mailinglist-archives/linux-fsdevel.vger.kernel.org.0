Return-Path: <linux-fsdevel+bounces-61833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD168B5A45E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925204859CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAA5323F65;
	Tue, 16 Sep 2025 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Qyx3ysYD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829DA31BCA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059856; cv=none; b=HGcYlC4DY2Kk6kSS0LwKsiBhfdgdHYhFJdnKiXYLCg+SZmTpShnIpdE+PBEbrV1pANOjtpUJ3TjySLOgc5Gl5y2//FLrr7ieXyxaDGr8tBDSsFmvIk+1VVYnqZ5pvpwiHlKe6vcDmh+/3q0ZF03SCy2edR9N6Axs12A2jZp8FQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059856; c=relaxed/simple;
	bh=IGi6wW9ZwhNONQRqpRWlNHQaETJE/DXoYHyCSnrl0PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0dDDybezCTWn5R8zFdco6n3AOGcxmhyoHNkJ8mN42jIr0SG71idb6pZ9y+A/XZHHscyG0y76p5xXbc2QTHIJVsZlDT7nx4cRFuCW51U7iv6dY+/2sMJs8WpeiGp2nKNZzeXiyg04FlsWm22DkT4IRQIFiZeuZG1GCpHown64FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Qyx3ysYD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5023311a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1758059854; x=1758664654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSsNsg94xTPxgo7mtr0vhLneaLnV1NurRaDsg6aVKxA=;
        b=Qyx3ysYDBJIag093ZXSEr4hRI70hbJHvHwW6sKjnIdvE8tOxy2eUr5GvcWfanJGsA2
         b+9H7Fcsyct5E0+rHmMMZd7ZMXoGPDYV9H0aTOqLDCOnMOsL8I89zPipwxVJX9qi105I
         rpvNWP0YrAu9cn4RDVphU509dHbwN9UKc5vBPTyFXgg+33H+opp3T5XxBr6H/WbHwJjm
         3/4lq3mIl26vrY4CoTpxzLCdpbUrQy/6WF92nXz5J4QZHAMNEeIU0so/Co/HxMQ+C9Mc
         cz9io9/M0xM+o3aIPd0+NF1HwnJ+0m6Qekp6j7lxAkLgJ+GfwU2A3BzJNCJa8nKd2lJ/
         3DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059854; x=1758664654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSsNsg94xTPxgo7mtr0vhLneaLnV1NurRaDsg6aVKxA=;
        b=Xcp6bivHccJSu1EYhQ20kSiXYPiaNK3Mrn5/g1s1egdTkf4G8p9i4l1WgDRgYO+Eki
         YQTG+7BqLNhkCxTz6oEEBv80ZuC44+ymJuu/xNKS2pE8zpXNLaunpfT5bBSvSEl3yrxZ
         Di712QuapGo/pgOFY1yBtaqfkZb/UKUqafspWW5mcB0yKh0LE+3SzD1nCGQwTqVDbics
         I69WuQL4c1VK1gzPS6MJj1huGZ4WTxkkloisZEjWgPdL1L2g1R6BP6OwvrXUPQ8bvXn4
         TJVoHxZ5V6QBuVMGY9j6Fg8nI4KqNUNpId4nrgP7UuNiU8T1/wawK44f6vIIfEHgpS1K
         EQog==
X-Forwarded-Encrypted: i=1; AJvYcCX3m5vd7ycOIoJUlNn/ujp82HcP8l406N2ZZ08IiBfH4GOlEWqdXSlbk0QSCB9jSwwg7Gg7xyFCj8WQ67NP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzb95gCvq5tjOcjtRUoPnLNy9NTkQezswopZntyqQqJfPfkTAG
	Ze29jFlIr6M9SkJ+DK2Upog0hw28NAQnMnJCYY6N1oAR6splKz4R6a9u0DSfztuRosE=
X-Gm-Gg: ASbGncsOTwpryYepJMArsWXdIxSYvHK4qnOIPjrv86SLo9IpZXbDx+1nUNY2im+at5E
	2mSb7GMBNXuv3lx6yoKfF5oR7RCrCLn7uFmwM0q95V2ailPpEOPXJd0jHUWKOYztV95j7eg5QcY
	Uxw+gyAelKemloI8zke5Kep2eQLqQhyH+IhAB/aV64nodn0btC2IqJtPmyIj6onqq7/Z5QNsPRo
	YnUxR52Affn+bG2ohmFcQiKFih/djYRCBrPSphnWRox35MuBooMx9vTk3KXBTxyT9EpxnNYzsQH
	9BHN8Vlf/dvkoDSjKzie0Vb5kB/Yo60fo4UJn0Dr/eZH+FDIyGfHP9/KVVi1durL1wP5BTFBr24
	H0Zsei9hx84qThRoKrq0hXoXewiEJ4nZe
X-Google-Smtp-Source: AGHT+IHdEe5K+YDWPhJLhlZn7IU67ePHwIpfI8vI3XiMDhr12ZwDMD7hxV3qH6hUc2/5B/bKZQSVwg==
X-Received: by 2002:a17:902:ebc9:b0:24b:4a9a:703a with SMTP id d9443c01a7336-25d24da7536mr278813885ad.17.1758059853851;
        Tue, 16 Sep 2025 14:57:33 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea3c72dacsm1636848a91.4.2025.09.16.14.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:57:33 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:57:31 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V12 3/5] riscv: Add RISC-V Svrsw60t59b extension support
Message-ID: <aMndS8F6tr1ZvILt@debug.ba.rivosinc.com>
References: <20250915101343.1449546-1-zhangchunyan@iscas.ac.cn>
 <20250915101343.1449546-4-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250915101343.1449546-4-zhangchunyan@iscas.ac.cn>

On Mon, Sep 15, 2025 at 06:13:41PM +0800, Chunyan Zhang wrote:
>The Svrsw60t59b extension allows to free the PTE reserved bits 60
>and 59 for software to use.
>
>Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

Same comment as Conor for dt-bindings.
Other than that

Reviewed-by: Deepak Gupta <debug@rivosinc.com>
>---
> arch/riscv/Kconfig             | 14 ++++++++++++++
> arch/riscv/include/asm/hwcap.h |  1 +
> arch/riscv/kernel/cpufeature.c |  1 +
> 3 files changed, 16 insertions(+)
>
>diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>index 51dcd8eaa243..e1b6a95952c4 100644
>--- a/arch/riscv/Kconfig
>+++ b/arch/riscv/Kconfig
>@@ -862,6 +862,20 @@ config RISCV_ISA_ZICBOP
>
> 	  If you don't know what to do here, say Y.
>
>+config RISCV_ISA_SVRSW60T59B
>+	bool "Svrsw60t59b extension support for using PTE bits 60 and 59"
>+	depends on MMU && 64BIT
>+	depends on RISCV_ALTERNATIVE
>+	default y
>+	help
>+	  Adds support to dynamically detect the presence of the Svrsw60t59b
>+	  extension and enable its usage.
>+
>+	  The Svrsw60t59b extension allows to free the PTE reserved bits 60
>+	  and 59 for software to use.
>+
>+	  If you don't know what to do here, say Y.
>+
> config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
> 	def_bool y
> 	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
>diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>index affd63e11b0a..f98fcb5c17d5 100644
>--- a/arch/riscv/include/asm/hwcap.h
>+++ b/arch/riscv/include/asm/hwcap.h
>@@ -106,6 +106,7 @@
> #define RISCV_ISA_EXT_ZAAMO		97
> #define RISCV_ISA_EXT_ZALRSC		98
> #define RISCV_ISA_EXT_ZICBOP		99
>+#define RISCV_ISA_EXT_SVRSW60T59B	100
>
> #define RISCV_ISA_EXT_XLINUXENVCFG	127
>
>diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>index 743d53415572..2ba71d2d3fa3 100644
>--- a/arch/riscv/kernel/cpufeature.c
>+++ b/arch/riscv/kernel/cpufeature.c
>@@ -539,6 +539,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>+	__RISCV_ISA_EXT_DATA(svrsw60t59b, RISCV_ISA_EXT_SVRSW60T59B),
> 	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
> };
>
>-- 
>2.34.1
>

