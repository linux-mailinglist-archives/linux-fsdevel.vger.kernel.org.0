Return-Path: <linux-fsdevel+bounces-64318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4F5BE0A74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 22:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C38FC4E778F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD4630DED3;
	Wed, 15 Oct 2025 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj1/No2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0430C342
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560609; cv=none; b=Me1Wr8xV9tjgmde/Df3j/MXL/4vKyIcfVOBaRetknbXJBYbRx4m0tzof/3078W1snkboV34sGQWb8nmKbOT/kTtWPqnCaCLKqv4zK7n5kJgF14eoSPUAZOP82iZk1Dvbg3tDI0stV0iDZCfulrmOPfT81UtzyihiV2fqVhobJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560609; c=relaxed/simple;
	bh=wbAor5OhA6ggtXet9zEpN8MfXmdJnHDdAvCECAM9CPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtX8j+274yoDBrxLPSJxWDg3+Drs4h3VSAV18j3wMNLVXf/a27bAVpeu7dy0DI4rZOF1u/9o/a+HmTnCl9PfG17pCkfCKcFxydFJ2MszqPTg4dvyRJQX6wxlKtkz7Ylv1+urnkVMQUcxBR+DEkByDLQIiPoRQZpGKvgohX+sPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj1/No2j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760560606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9l2SAd4et9FHUQ+j/+m4vgSU0s4WtjrjNQIhvzxYPxM=;
	b=Bj1/No2j7flMpEhbSDGYgTyP+/XvwT7sm/Okes8lEzkVTa4VCyqSG+Jez+ghSQPYxpIBV8
	9f0/K+Vf5YNXV6fUOiKQvw86LJCExShl6Cioh0alGGvtXWcmC3JknD8VGI8X29hkeYxQzk
	Kbt9qW0zs/vy9YbxcMmzgvVqNPmVtp8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-VsCjS__3PmC3eNpISX8uSg-1; Wed,
 15 Oct 2025 16:36:43 -0400
X-MC-Unique: VsCjS__3PmC3eNpISX8uSg-1
X-Mimecast-MFC-AGG-ID: VsCjS__3PmC3eNpISX8uSg_1760560598
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ECB6195422D;
	Wed, 15 Oct 2025 20:36:36 +0000 (UTC)
Received: from laptop.mht.redhat.com (unknown [10.17.17.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F12519560AD;
	Wed, 15 Oct 2025 20:36:25 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: debug@rivosinc.com
Cc: Liam.Howlett@oracle.com,
	a.hindborg@kernel.org,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	alexghiti@rivosinc.com,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	atishp@rivosinc.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	bp@alien8.de,
	brauner@kernel.org,
	broonie@kernel.org,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor+dt@kernel.org,
	conor@kernel.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	devicetree@vger.kernel.org,
	ebiederm@xmission.com,
	evan@rivosinc.com,
	gary@garyguo.net,
	hpa@zytor.com,
	jannh@google.com,
	jim.shu@sifive.com,
	kees@kernel.org,
	kito.cheng@sifive.com,
	krzk+dt@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	lorenzo.stoakes@oracle.com,
	lossin@kernel.org,
	mingo@redhat.com,
	ojeda@kernel.org,
	oleg@redhat.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	peterz@infradead.org,
	richard.henderson@linaro.org,
	rick.p.edgecombe@intel.com,
	robh@kernel.org,
	rust-for-linux@vger.kernel.org,
	samitolvanen@google.com,
	shuah@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu,
	vbabka@suse.cz,
	x86@kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Subject: Re: [PATCH v20 24/28] arch/riscv: dual vdso creation logic and select vdso based on hw
Date: Wed, 15 Oct 2025 16:36:11 -0400
Message-ID: <20251015203611.2572538-1-cmirabil@redhat.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-24-b9de4be9912e@rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-24-b9de4be9912e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Deepak -

On Mon, Oct 13, 2025 at 02:56:16PM -0700, Deepak Gupta wrote:
> Shadow stack instructions are taken from zimop (mandated on RVA23).
> Any hardware prior to RVA23 profile will fault on shado stack instruction.
> Any userspace with shadow stack instruction in it will fault on such
> hardware. Thus such userspace can't be brought onto such a hardware.
> 
> It's not known how userspace will respond to such binary fragmentation.
> However in order to keep kernel portable across such different hardware,
> `arch/riscv/kernel/vdso_cfi` is created which has logic (Makefile) to
> compile `arch/riscv/kernel/vdso` sources with cfi flags and then changes
> in `arch/riscv/kernel/vdso.c` for selecting appropriate vdso depending
> on whether underlying hardware(cpu) implements zimop extension. Offset
> of vdso symbols will change due to having two different vdso binaries,
> there is added logic to include new generated vdso offset header and
> dynamically select offset (like for rt_sigreturn).

This looks great. As kernel test robot highlighted, the code doesn't build
when the config is off, but I was able to fix it with the attached patch.

Assuming that these changes or equivalent are folded in, you have my:

Acked-by: Charles Mirabile <cmirabil@redhat.com>

As merely a user whose previous concerns have been addressed, I am not
sure what that is worth, but I appreciate your effort on this.

> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/Makefile                        |  3 +++
>  arch/riscv/include/asm/vdso.h              |  7 ++++++-
>  arch/riscv/kernel/Makefile                 |  1 +
>  arch/riscv/kernel/vdso.c                   |  7 +++++++
>  arch/riscv/kernel/vdso/Makefile            | 29 ++++++++++++++++++++---------
>  arch/riscv/kernel/vdso/gen_vdso_offsets.sh |  4 +++-
>  arch/riscv/kernel/vdso_cfi/Makefile        | 25 +++++++++++++++++++++++++
>  arch/riscv/kernel/vdso_cfi/vdso-cfi.S      | 11 +++++++++++
>  8 files changed, 76 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index f60c2de0ca08..b74b63da16a7 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -176,6 +176,8 @@ ifeq ($(CONFIG_MMU),y)
>  prepare: vdso_prepare
>  vdso_prepare: prepare0
>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
> +	$(if $(CONFIG_RISCV_USER_CFI),$(Q)$(MAKE) \
> +		$(build)=arch/riscv/kernel/vdso_cfi include/generated/vdso-cfi-offsets.h)
>  	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
>  		$(build)=arch/riscv/kernel/compat_vdso include/generated/compat_vdso-offsets.h)
>  
> @@ -183,6 +185,7 @@ endif
>  endif
>  
>  vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
> +vdso-install-$(CONFIG_RISCV_USER_CFI)	+= arch/riscv/kernel/vdso_cfi/vdso-cfi.so.dbg
>  vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
>  
>  BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst Image.xz loader loader.bin xipImage vmlinuz.efi
> diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
> index f80357fe24d1..3fc8f72b8bfb 100644
> --- a/arch/riscv/include/asm/vdso.h
> +++ b/arch/riscv/include/asm/vdso.h
> @@ -18,9 +18,13 @@
>  
>  #ifndef __ASSEMBLER__
>  #include <generated/vdso-offsets.h>
> +#include <generated/vdso-cfi-offsets.h>
>  
>  #define VDSO_SYMBOL(base, name)							\
> -	(void __user *)((unsigned long)(base) + __vdso_##name##_offset)
> +	((IS_ENABLED(CONFIG_RISCV_USER_CFI) &&					\
> +	  riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) ?			\
> +	  (void __user *)((unsigned long)(base) + __vdso_##name##_cfi_offset) :	\
> +	  (void __user *)((unsigned long)(base) + __vdso_##name##_offset))
>  
>  #ifdef CONFIG_COMPAT
>  #include <generated/compat_vdso-offsets.h>
> @@ -33,6 +37,7 @@ extern char compat_vdso_start[], compat_vdso_end[];
>  #endif /* CONFIG_COMPAT */
>  
>  extern char vdso_start[], vdso_end[];
> +extern char vdso_cfi_start[], vdso_cfi_end[];
>  
>  #endif /* !__ASSEMBLER__ */
>  
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 2d0e0dcedbd3..9026400cba10 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -72,6 +72,7 @@ obj-y	+= vendor_extensions/
>  obj-y	+= probes/
>  obj-y	+= tests/
>  obj-$(CONFIG_MMU) += vdso.o vdso/
> +obj-$(CONFIG_RISCV_USER_CFI) += vdso_cfi/
>  
>  obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
>  obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index 3a8e038b10a2..bf080e519101 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -98,6 +98,13 @@ static struct __vdso_info compat_vdso_info __ro_after_init = {
>  
>  static int __init vdso_init(void)
>  {
> +	/* Hart implements zimop, expose cfi compiled vdso */
> +	if (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
> +		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) {
> +		vdso_info.vdso_code_start = vdso_cfi_start;
> +		vdso_info.vdso_code_end = vdso_cfi_end;
> +	}
> +
>  	__vdso_init(&vdso_info);
>  #ifdef CONFIG_COMPAT
>  	__vdso_init(&compat_vdso_info);
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 272f1d837a80..a842dc034571 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -20,6 +20,10 @@ endif
>  ifdef VDSO_CFI_BUILD
>  CFI_MARCH = _zicfilp_zicfiss
>  CFI_FULL = -fcf-protection=full
> +CFI_SUFFIX = -cfi
> +OFFSET_SUFFIX = _cfi
> +ccflags-y += -DVDSO_CFI=1
> +asflags-y += -DVDSO_CFI=1
>  endif
>  
>  # Files to link into the vdso
> @@ -48,13 +52,20 @@ endif
>  CFLAGS_hwprobe.o += -fPIC
>  
>  # Build rules
> -targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
> +vdso_offsets := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),)-offsets.h
> +vdso_o := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).o
> +vdso_so := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).so
> +vdso_so_dbg := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).so.dbg
> +vdso_lds := vdso.lds
> +
> +targets := $(obj-vdso) $(vdso_so) $(vdso_so_dbg) $(vdso_lds)
> +
>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>  
> -obj-y += vdso.o
> -CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
> +obj-y += vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).o
> +CPPFLAGS_$(vdso_lds) += -P -C -U$(ARCH)
>  ifneq ($(filter vgettimeofday, $(vdso-syms)),)
> -CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
> +CPPFLAGS_$(vdso_lds) += -DHAS_VGETTIMEOFDAY
>  endif
>  
>  # Disable -pg to prevent insert call site
> @@ -63,12 +74,12 @@ CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>  CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>  
>  # Force dependency
> -$(obj)/vdso.o: $(obj)/vdso.so
> +$(obj)/$(vdso_o): $(obj)/$(vdso_so)
>  
>  # link rule for the .so file, .lds has to be first
> -$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
> +$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) FORCE
>  	$(call if_changed,vdsold_and_check)
> -LDFLAGS_vdso.so.dbg = -shared -soname=linux-vdso.so.1 \
> +LDFLAGS_$(vdso_so_dbg) = -shared -soname=linux-vdso.so.1 \
>  	--build-id=sha1 --eh-frame-hdr
>  
>  # strip rule for the .so file
> @@ -79,9 +90,9 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
>  # Generate VDSO offsets using helper script
>  gen-vdsosym := $(src)/gen_vdso_offsets.sh
>  quiet_cmd_vdsosym = VDSOSYM $@
> -	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
> +	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) $(OFFSET_SUFFIX) | LC_ALL=C sort > $@
>  
> -include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
> +include/generated/$(vdso_offsets): $(obj)/$(vdso_so_dbg) FORCE
>  	$(call if_changed,vdsosym)
>  
>  # actual build commands
> diff --git a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
> index c2e5613f3495..bd5d5afaaa14 100755
> --- a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
> +++ b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
> @@ -2,4 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  LC_ALL=C
> -sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2_offset\t0x\1/p'
> +SUFFIX=${1:-""}
> +sed -n -e \
> +'s/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2'$SUFFIX'_offset\t0x\1/p'
> diff --git a/arch/riscv/kernel/vdso_cfi/Makefile b/arch/riscv/kernel/vdso_cfi/Makefile
> new file mode 100644
> index 000000000000..8ebd190782b0
> --- /dev/null
> +++ b/arch/riscv/kernel/vdso_cfi/Makefile
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# RISC-V VDSO CFI Makefile
> +# This Makefile builds the VDSO with CFI support when CONFIG_RISCV_USER_CFI is enabled
> +
> +# setting VDSO_CFI_BUILD triggers build for vdso differently
> +VDSO_CFI_BUILD := 1
> +
> +# Set the source directory to the main vdso directory
> +src := $(srctree)/arch/riscv/kernel/vdso
> +
> +# Copy all .S and .c files from vdso directory to vdso_cfi object build directory
> +vdso_c_sources := $(wildcard $(src)/*.c)
> +vdso_S_sources := $(wildcard $(src)/*.S)
> +vdso_c_objects := $(addprefix $(obj)/, $(notdir $(vdso_c_sources)))
> +vdso_S_objects := $(addprefix $(obj)/, $(notdir $(vdso_S_sources)))
> +
> +$(vdso_S_objects): $(obj)/%.S: $(src)/%.S
> +	$(Q)cp $< $@
> +
> +$(vdso_c_objects): $(obj)/%.c: $(src)/%.c
> +	$(Q)cp $< $@
> +
> +# Include the main VDSO Makefile which contains all the build rules and sources
> +# The VDSO_CFI_BUILD variable will be passed to it to enable CFI compilation
> +include $(src)/Makefile
> diff --git a/arch/riscv/kernel/vdso_cfi/vdso-cfi.S b/arch/riscv/kernel/vdso_cfi/vdso-cfi.S
> new file mode 100644
> index 000000000000..d426f6accb35
> --- /dev/null
> +++ b/arch/riscv/kernel/vdso_cfi/vdso-cfi.S
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2025 Rivos, Inc
> + */
> +
> +#define	vdso_start	vdso_cfi_start
> +#define	vdso_end	vdso_cfi_end
> +
> +#define __VDSO_PATH "arch/riscv/kernel/vdso_cfi/vdso-cfi.so"
> +
> +#include "../vdso/vdso.S"
> 
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
---
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index 3fc8f72b8bfb..9cfbb390270f 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -18,13 +18,21 @@
 
 #ifndef __ASSEMBLER__
 #include <generated/vdso-offsets.h>
+#if IS_ENABLED(CONFIG_RISCV_USER_CFI)
+
 #include <generated/vdso-cfi-offsets.h>
 
 #define VDSO_SYMBOL(base, name)							\
-	((IS_ENABLED(CONFIG_RISCV_USER_CFI) &&					\
-	  riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) ?			\
-	  (void __user *)((unsigned long)(base) + __vdso_##name##_cfi_offset) :	\
-	  (void __user *)((unsigned long)(base) + __vdso_##name##_offset))
+	(riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) ?			\
+	 (void __user *)((unsigned long)(base) + __vdso_##name##_cfi_offset) :	\
+	 (void __user *)((unsigned long)(base) + __vdso_##name##_offset)
+
+#else /* !CONFIG_RISCV_USER_CFI */
+
+#define VDSO_SYMBOL(base, name)							\
+	(void __user *)((unsigned long)(base) + __vdso_##name##_offset)
+
+#endif /* CONFIG_RISCV_USER_CFI */
 
 #ifdef CONFIG_COMPAT
 #include <generated/compat_vdso-offsets.h>


