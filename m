Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C37A183DA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 00:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCLX71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 19:59:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37647 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgCLX70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:59:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id p14so4090334pfn.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tgJ6quu2NWo3yBMqliTZihesnP5Rn5ZlYRfPOG/UyIc=;
        b=S/gG4WoZ6NVyjulGGOa8HaqLzUV/cYtHApY2TPW2Ape6Rcp1j0gGXQZr69Jxqz/5H8
         XDfaIWBb+gCpPyvTGQrxqvTVqLTCRLTn2jRt8sadsEsgm1JrB6jCTSzDl1sOyE3B7wtG
         fOBnAMFDoNyYkiZyC+y6lPaW1BiDP9Rcql84U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tgJ6quu2NWo3yBMqliTZihesnP5Rn5ZlYRfPOG/UyIc=;
        b=RzsENExyGHsZRj8P/GG9ORo3HOweJXZO0OzFwb5gnXMM2QPA1TBftBA8+gebl59qpd
         s8R8hNtuQugTnYrKTUmhFKyyxqmYpZ71N3+1CpFAQOZOV49o5TKsdmQnM8xWiQBu+xgI
         PG4q5Q5gij8vNrxgjNWiwiVy2NxxZQic7wjdZgdDsUL17J+t8/lPMzlsn/oVMa0G5CdW
         a6G0Br/WDb4lt2rysMZd3eE6RT6HgqXZF7O/wW0e1iSfGhacmjrnai3bN6Qh+eHiXVD5
         cTpbU/9wlvjOzoFnmKIeCBJNX7O3vSRN7dMxMtoHzTlFvvGDxGN0TtP5UENG+4p+D7+7
         Erig==
X-Gm-Message-State: ANhLgQ2jQiOtVcLvYe0Z42fTB0FffSdXB7qsxtBwnHxgndVXU8WTKVcG
        Sgl8wu4dD83wuJsjHUcfI7dzgg==
X-Google-Smtp-Source: ADFU+vvNTmfYf4tCUDOaar3jFFERhQPRlY4YGwDrRqnXvPIUWElQDSZsoD90BS0b7pgnhG7vfa3j8Q==
X-Received: by 2002:a62:3808:: with SMTP id f8mr9119968pfa.38.1584057563579;
        Thu, 12 Mar 2020 16:59:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b25sm56476302pfo.38.2020.03.12.16.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 16:59:22 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:59:21 -0700
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
Subject: Re: [PATCH v9 02/13] ELF: Add ELF program property parsing support
Message-ID: <202003121658.39A47CE098@keescook>
References: <20200311192608.40095-1-broonie@kernel.org>
 <20200311192608.40095-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311192608.40095-3-broonie@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 07:25:57PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> ELF program properties will be needed for detecting whether to
> enable optional architecture or ABI features for a new ELF process.
> 
> For now, there are no generic properties that we care about, so do
> nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> 
> Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> phdrs entry (if any), and notify each property to the arch code.
> 
> For now, the added code is not used.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

I think my review got lost along the way. Please consider this:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> ---
>  fs/binfmt_elf.c          | 127 +++++++++++++++++++++++++++++++++++++++
>  fs/compat_binfmt_elf.c   |   4 ++
>  include/linux/elf.h      |  19 ++++++
>  include/uapi/linux/elf.h |   4 ++
>  4 files changed, 154 insertions(+)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index f4713ea76e82..1fb67e506b68 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -39,12 +39,18 @@
>  #include <linux/sched/coredump.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/cputime.h>
> +#include <linux/sizes.h>
> +#include <linux/types.h>
>  #include <linux/cred.h>
>  #include <linux/dax.h>
>  #include <linux/uaccess.h>
>  #include <asm/param.h>
>  #include <asm/page.h>
>  
> +#ifndef ELF_COMPAT
> +#define ELF_COMPAT 0
> +#endif
> +
>  #ifndef user_long_t
>  #define user_long_t long
>  #endif
> @@ -681,6 +687,111 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>   * libraries.  There is no binary dependent code anywhere else.
>   */
>  
> +static int parse_elf_property(const char *data, size_t *off, size_t datasz,
> +			      struct arch_elf_state *arch,
> +			      bool have_prev_type, u32 *prev_type)
> +{
> +	size_t o, step;
> +	const struct gnu_property *pr;
> +	int ret;
> +
> +	if (*off == datasz)
> +		return -ENOENT;
> +
> +	if (WARN_ON_ONCE(*off > datasz || *off % ELF_GNU_PROPERTY_ALIGN))
> +		return -EIO;
> +	o = *off;
> +	datasz -= *off;
> +
> +	if (datasz < sizeof(*pr))
> +		return -ENOEXEC;
> +	pr = (const struct gnu_property *)(data + o);
> +	o += sizeof(*pr);
> +	datasz -= sizeof(*pr);
> +
> +	if (pr->pr_datasz > datasz)
> +		return -ENOEXEC;
> +
> +	WARN_ON_ONCE(o % ELF_GNU_PROPERTY_ALIGN);
> +	step = round_up(pr->pr_datasz, ELF_GNU_PROPERTY_ALIGN);
> +	if (step > datasz)
> +		return -ENOEXEC;
> +
> +	/* Properties are supposed to be unique and sorted on pr_type: */
> +	if (have_prev_type && pr->pr_type <= *prev_type)
> +		return -ENOEXEC;
> +	*prev_type = pr->pr_type;
> +
> +	ret = arch_parse_elf_property(pr->pr_type, data + o,
> +				      pr->pr_datasz, ELF_COMPAT, arch);
> +	if (ret)
> +		return ret;
> +
> +	*off = o + step;
> +	return 0;
> +}
> +
> +#define NOTE_DATA_SZ SZ_1K
> +#define GNU_PROPERTY_TYPE_0_NAME "GNU"
> +#define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
> +
> +static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
> +				struct arch_elf_state *arch)
> +{
> +	union {
> +		struct elf_note nhdr;
> +		char data[NOTE_DATA_SZ];
> +	} note;
> +	loff_t pos;
> +	ssize_t n;
> +	size_t off, datasz;
> +	int ret;
> +	bool have_prev_type;
> +	u32 prev_type;
> +
> +	if (!IS_ENABLED(CONFIG_ARCH_USE_GNU_PROPERTY) || !phdr)
> +		return 0;
> +
> +	/* load_elf_binary() shouldn't call us unless this is true... */
> +	if (WARN_ON_ONCE(phdr->p_type != PT_GNU_PROPERTY))
> +		return -ENOEXEC;
> +
> +	/* If the properties are crazy large, that's too bad (for now): */
> +	if (phdr->p_filesz > sizeof(note))
> +		return -ENOEXEC;
> +
> +	pos = phdr->p_offset;
> +	n = kernel_read(f, &note, phdr->p_filesz, &pos);
> +
> +	BUILD_BUG_ON(sizeof(note) < sizeof(note.nhdr) + NOTE_NAME_SZ);
> +	if (n < 0 || n < sizeof(note.nhdr) + NOTE_NAME_SZ)
> +		return -EIO;
> +
> +	if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
> +	    note.nhdr.n_namesz != NOTE_NAME_SZ ||
> +	    strncmp(note.data + sizeof(note.nhdr),
> +		    GNU_PROPERTY_TYPE_0_NAME, n - sizeof(note.nhdr)))
> +		return -ENOEXEC;
> +
> +	off = round_up(sizeof(note.nhdr) + NOTE_NAME_SZ,
> +		       ELF_GNU_PROPERTY_ALIGN);
> +	if (off > n)
> +		return -ENOEXEC;
> +
> +	if (note.nhdr.n_descsz > n - off)
> +		return -ENOEXEC;
> +	datasz = off + note.nhdr.n_descsz;
> +
> +	have_prev_type = false;
> +	do {
> +		ret = parse_elf_property(note.data, &off, datasz, arch,
> +					 have_prev_type, &prev_type);
> +		have_prev_type = true;
> +	} while (!ret);
> +
> +	return ret == -ENOENT ? 0 : ret;
> +}
> +
>  static int load_elf_binary(struct linux_binprm *bprm)
>  {
>  	struct file *interpreter = NULL; /* to shut gcc up */
> @@ -688,6 +799,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	int load_addr_set = 0;
>  	unsigned long error;
>  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
> +	struct elf_phdr *elf_property_phdata = NULL;
>  	unsigned long elf_bss, elf_brk;
>  	int bss_prot = 0;
>  	int retval, i;
> @@ -733,6 +845,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
>  		char *elf_interpreter;
>  
> +		if (elf_ppnt->p_type == PT_GNU_PROPERTY) {
> +			elf_property_phdata = elf_ppnt;
> +			continue;
> +		}
> +
>  		if (elf_ppnt->p_type != PT_INTERP)
>  			continue;
>  
> @@ -820,9 +937,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  			goto out_free_dentry;
>  
>  		/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
> +		elf_property_phdata = NULL;
>  		elf_ppnt = interp_elf_phdata;
>  		for (i = 0; i < loc->interp_elf_ex.e_phnum; i++, elf_ppnt++)
>  			switch (elf_ppnt->p_type) {
> +			case PT_GNU_PROPERTY:
> +				elf_property_phdata = elf_ppnt;
> +				break;
> +
>  			case PT_LOPROC ... PT_HIPROC:
>  				retval = arch_elf_pt_proc(&loc->interp_elf_ex,
>  							  elf_ppnt, interpreter,
> @@ -833,6 +955,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  			}
>  	}
>  
> +	retval = parse_elf_properties(interpreter ?: bprm->file,
> +				      elf_property_phdata, &arch_state);
> +	if (retval)
> +		goto out_free_dentry;
> +
>  	/*
>  	 * Allow arch code to reject the ELF at this point, whilst it's
>  	 * still possible to return an error to the code that invoked
> diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
> index aaad4ca1217e..13a087bc816b 100644
> --- a/fs/compat_binfmt_elf.c
> +++ b/fs/compat_binfmt_elf.c
> @@ -17,6 +17,8 @@
>  #include <linux/elfcore-compat.h>
>  #include <linux/time.h>
>  
> +#define ELF_COMPAT	1
> +
>  /*
>   * Rename the basic ELF layout types to refer to the 32-bit class of files.
>   */
> @@ -28,11 +30,13 @@
>  #undef	elf_shdr
>  #undef	elf_note
>  #undef	elf_addr_t
> +#undef	ELF_GNU_PROPERTY_ALIGN
>  #define elfhdr		elf32_hdr
>  #define elf_phdr	elf32_phdr
>  #define elf_shdr	elf32_shdr
>  #define elf_note	elf32_note
>  #define elf_addr_t	Elf32_Addr
> +#define ELF_GNU_PROPERTY_ALIGN	ELF32_GNU_PROPERTY_ALIGN
>  
>  /*
>   * Some data types as stored in coredump.
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index f7b24c5fcfb6..db5113479f5e 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -22,6 +22,9 @@
>  	SET_PERSONALITY(ex)
>  #endif
>  
> +#define ELF32_GNU_PROPERTY_ALIGN	4
> +#define ELF64_GNU_PROPERTY_ALIGN	8
> +
>  #if ELF_CLASS == ELFCLASS32
>  
>  extern Elf32_Dyn _DYNAMIC [];
> @@ -32,6 +35,7 @@ extern Elf32_Dyn _DYNAMIC [];
>  #define elf_addr_t	Elf32_Off
>  #define Elf_Half	Elf32_Half
>  #define Elf_Word	Elf32_Word
> +#define ELF_GNU_PROPERTY_ALIGN	ELF32_GNU_PROPERTY_ALIGN
>  
>  #else
>  
> @@ -43,6 +47,7 @@ extern Elf64_Dyn _DYNAMIC [];
>  #define elf_addr_t	Elf64_Off
>  #define Elf_Half	Elf64_Half
>  #define Elf_Word	Elf64_Word
> +#define ELF_GNU_PROPERTY_ALIGN	ELF64_GNU_PROPERTY_ALIGN
>  
>  #endif
>  
> @@ -68,4 +73,18 @@ struct gnu_property {
>  	u32 pr_datasz;
>  };
>  
> +struct arch_elf_state;
> +
> +#ifndef CONFIG_ARCH_USE_GNU_PROPERTY
> +static inline int arch_parse_elf_property(u32 type, const void *data,
> +					  size_t datasz, bool compat,
> +					  struct arch_elf_state *arch)
> +{
> +	return 0;
> +}
> +#else
> +extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
> +				   bool compat, struct arch_elf_state *arch);
> +#endif
> +
>  #endif /* _LINUX_ELF_H */
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index c37731407074..20900f4496b7 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -368,6 +368,7 @@ typedef struct elf64_shdr {
>   * Notes used in ET_CORE. Architectures export some of the arch register sets
>   * using the corresponding note types via the PTRACE_GETREGSET and
>   * PTRACE_SETREGSET requests.
> + * The note name for all these is "LINUX".
>   */
>  #define NT_PRSTATUS	1
>  #define NT_PRFPREG	2
> @@ -430,6 +431,9 @@ typedef struct elf64_shdr {
>  #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
>  #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
>  
> +/* Note types with note name "GNU" */
> +#define NT_GNU_PROPERTY_TYPE_0	5
> +
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {
>    Elf32_Word	n_namesz;	/* Name size */
> -- 
> 2.20.1
> 

-- 
Kees Cook
