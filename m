Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6765E327154
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 07:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhB1Gu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 01:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhB1GuZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 01:50:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F61364DF4;
        Sun, 28 Feb 2021 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614494984;
        bh=BZLDEqUws59xw1Ga8DEtDJN2MCcjM8144YR7AoGDmiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mR0LrfP15ZIuQx0ePZsFHMlItDLzs4epj9wqIaqYMcdrR/EzzfKYdSBnbvM7jXOd/
         mlzw2WPp9PL+5O3Qj7Q0IwNjXbQ+dKP/3Yp5CPD5bFT2OwME1Sl9wMkUVY5dMWLgPD
         BGmhTdDPikfWXwU4mOF+tnBGnk9hGxAIP1Bmd33Np6tNokbmeDB8fz70ta4ho5Rlm8
         55dzKSmA3pM5ps5cmgK4hNlqJpfuYESimeK64FPkLTsMKVVJ0ZJ9DEB1l+ZKS+7NLS
         4oxbblwf7xZwSqyGa+vAFQcvf/DyKz/67ehtL2hiJ1+9w29IitBIkJfOxtf1Cg3eZs
         D+HZxD3EiTjmQ==
Date:   Sat, 27 Feb 2021 23:49:36 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Fangrui Song <maskray@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jethro Beekman <jethro@fortanix.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH RFC] x86: remove toolchain check for X32 ABI capability
Message-ID: <20210228064936.zixrhxlthyy6fmid@24bbad8f3778>
References: <20210227183910.221873-1-masahiroy@kernel.org>
 <CAK7LNASL_X43_nMTz1CZQB+jiLCRAJbh-wQdc23QV0pWceL_Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASL_X43_nMTz1CZQB+jiLCRAJbh-wQdc23QV0pWceL_Lw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 28, 2021 at 12:15:16PM +0900, Masahiro Yamada wrote:
> On Sun, Feb 28, 2021 at 3:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > This commit reverts 0bf6276392e9 ("x32: Warn and disable rather than
> > error if binutils too old").
> >
> > The help text in arch/x86/Kconfig says enabling the X32 ABI support
> > needs binutils 2.22 or later. This is met because the minimal binutils
> > version is 2.23 according to Documentation/process/changes.rst.
> >
> > I would not say I am not familiar with toolchain configuration, but
> 
> I mean:
> I would not say I am familiar ...
> That is why I added RFC.
> 
> I appreciate comments from people who are familiar
> with toolchains (binutils, llvm).
> 
> If this change is not safe,
> we can move this check to Kconfig at least.

Hi Masahiro,

As Fangrui pointed out, there are two outstanding issues with x32 with
LLVM=1, both seemingly related to LLVM=1.

https://github.com/ClangBuiltLinux/linux/issues/514
https://github.com/ClangBuiltLinux/linux/issues/1141

Additionally, there appears to be one from Arnd as well but that one has
received no triage yet.

https://github.com/ClangBuiltLinux/linux/issues/1205

I intend to test this patch as well as a few others at some point in the
coming week although I am having to play sysadmin due to moving servers
so I might not be able to get to it until later in the week.

Cheers,
Nathan

> > I checked the configure.tgt code in binutils. The elf32_x86_64
> > emulation mode seems to be included when it is configured for the
> > x86_64-*-linux-* target.
> >
> > I also tried lld and llvm-objcopy, and succeeded in building x32 VDSO.
> >
> > I removed the compile-time check in arch/x86/Makefile, in the hope of
> > elf32_x86_64 being always supported.
> >
> > With this, CONFIG_X86_X32 and CONFIG_X86_X32_ABI will be equivalent.
> > Rename the former to the latter.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/x86/Kconfig                       |  8 ++------
> >  arch/x86/Makefile                      | 16 ----------------
> >  arch/x86/include/asm/syscall_wrapper.h |  6 +++---
> >  arch/x86/include/asm/vdso.h            |  2 +-
> >  arch/x86/kernel/process_64.c           |  2 +-
> >  fs/fuse/file.c                         |  2 +-
> >  fs/xfs/xfs_ioctl32.c                   |  2 +-
> >  sound/core/control_compat.c            | 16 ++++++++--------
> >  sound/core/pcm_compat.c                | 20 ++++++++++----------
> >  9 files changed, 27 insertions(+), 47 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 2792879d398e..7272cba2744c 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2865,7 +2865,7 @@ config IA32_AOUT
> >         help
> >           Support old a.out binaries in the 32bit emulation.
> >
> > -config X86_X32
> > +config X86_X32_ABI
> >         bool "x32 ABI for 64-bit mode"
> >         depends on X86_64
> >         help
> > @@ -2874,10 +2874,6 @@ config X86_X32
> >           full 64-bit register file and wide data path while leaving
> >           pointers at 32 bits for smaller memory footprint.
> >
> > -         You will need a recent binutils (2.22 or later) with
> > -         elf32_x86_64 support enabled to compile a kernel with this
> > -         option set.
> > -
> >  config COMPAT_32
> >         def_bool y
> >         depends on IA32_EMULATION || X86_32
> > @@ -2886,7 +2882,7 @@ config COMPAT_32
> >
> >  config COMPAT
> >         def_bool y
> > -       depends on IA32_EMULATION || X86_X32
> > +       depends on IA32_EMULATION || X86_X32_ABI
> >
> >  if COMPAT
> >  config COMPAT_FOR_U64_ALIGNMENT
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 2d6d5a28c3bf..e163549f5be7 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -125,22 +125,6 @@ else
> >          KBUILD_CFLAGS += -mcmodel=kernel
> >  endif
> >
> > -ifdef CONFIG_X86_X32
> > -       x32_ld_ok := $(call try-run,\
> > -                       /bin/echo -e '1: .quad 1b' | \
> > -                       $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" - && \
> > -                       $(OBJCOPY) -O elf32-x86-64 "$$TMP" "$$TMPO" && \
> > -                       $(LD) -m elf32_x86_64 "$$TMPO" -o "$$TMP",y,n)
> > -        ifeq ($(x32_ld_ok),y)
> > -                CONFIG_X86_X32_ABI := y
> > -                KBUILD_AFLAGS += -DCONFIG_X86_X32_ABI
> > -                KBUILD_CFLAGS += -DCONFIG_X86_X32_ABI
> > -        else
> > -                $(warning CONFIG_X86_X32 enabled but no binutils support)
> > -        endif
> > -endif
> > -export CONFIG_X86_X32_ABI
> > -
> >  #
> >  # If the function graph tracer is used with mcount instead of fentry,
> >  # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
> > diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> > index a84333adeef2..69bf87c41a0b 100644
> > --- a/arch/x86/include/asm/syscall_wrapper.h
> > +++ b/arch/x86/include/asm/syscall_wrapper.h
> > @@ -158,7 +158,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
> >  #endif /* CONFIG_IA32_EMULATION */
> >
> >
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >  /*
> >   * For the x32 ABI, we need to create a stub for compat_sys_*() which is aware
> >   * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
> > @@ -176,12 +176,12 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
> >
> >  #define __X32_COMPAT_SYS_NI(name)                                      \
> >         __SYS_NI(x32, compat_sys_##name)
> > -#else /* CONFIG_X86_X32 */
> > +#else /* CONFIG_X86_X32_ABI */
> >  #define __X32_COMPAT_SYS_STUB0(name)
> >  #define __X32_COMPAT_SYS_STUBx(x, name, ...)
> >  #define __X32_COMPAT_COND_SYSCALL(name)
> >  #define __X32_COMPAT_SYS_NI(name)
> > -#endif /* CONFIG_X86_X32 */
> > +#endif /* CONFIG_X86_X32_ABI */
> >
> >
> >  #ifdef CONFIG_COMPAT
> > diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
> > index 98aa103eb4ab..2963a2f5dbc4 100644
> > --- a/arch/x86/include/asm/vdso.h
> > +++ b/arch/x86/include/asm/vdso.h
> > @@ -37,7 +37,7 @@ struct vdso_image {
> >  extern const struct vdso_image vdso_image_64;
> >  #endif
> >
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >  extern const struct vdso_image vdso_image_x32;
> >  #endif
> >
> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > index d08307df69ad..a93b6f4296fc 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -656,7 +656,7 @@ void set_personality_64bit(void)
> >
> >  static void __set_personality_x32(void)
> >  {
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >         if (current->mm)
> >                 current->mm->context.flags = 0;
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 8cccecb55fb8..c53c620d1a7a 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -2797,7 +2797,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
> >  #else
> >         if (flags & FUSE_IOCTL_COMPAT) {
> >                 inarg.flags |= FUSE_IOCTL_32BIT;
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >                 if (in_x32_syscall())
> >                         inarg.flags |= FUSE_IOCTL_COMPAT_X32;
> >  #endif
> > diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
> > index 33c09ec8e6c0..e8038bc966e7 100644
> > --- a/fs/xfs/xfs_ioctl32.c
> > +++ b/fs/xfs/xfs_ioctl32.c
> > @@ -233,7 +233,7 @@ xfs_compat_ioc_fsbulkstat(
> >         inumbers_fmt_pf         inumbers_func = xfs_fsinumbers_fmt_compat;
> >         bulkstat_one_fmt_pf     bs_one_func = xfs_fsbulkstat_one_fmt_compat;
> >
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >         if (in_x32_syscall()) {
> >                 /*
> >                  * ... but on x32 the input xfs_fsop_bulkreq has pointers
> > diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
> > index 1d708aab9c98..5d1b94bda2cd 100644
> > --- a/sound/core/control_compat.c
> > +++ b/sound/core/control_compat.c
> > @@ -153,7 +153,7 @@ struct snd_ctl_elem_value32 {
> >          unsigned char reserved[128];
> >  };
> >
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >  /* x32 has a different alignment for 64bit values from ia32 */
> >  struct snd_ctl_elem_value_x32 {
> >         struct snd_ctl_elem_id id;
> > @@ -165,7 +165,7 @@ struct snd_ctl_elem_value_x32 {
> >         } value;
> >         unsigned char reserved[128];
> >  };
> > -#endif /* CONFIG_X86_X32 */
> > +#endif /* CONFIG_X86_X32_ABI */
> >
> >  /* get the value type and count of the control */
> >  static int get_ctl_type(struct snd_card *card, struct snd_ctl_elem_id *id,
> > @@ -350,7 +350,7 @@ static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
> >         return ctl_elem_write_user(file, data32, &data32->value);
> >  }
> >
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >  static int snd_ctl_elem_read_user_x32(struct snd_card *card,
> >                                       struct snd_ctl_elem_value_x32 __user *data32)
> >  {
> > @@ -362,7 +362,7 @@ static int snd_ctl_elem_write_user_x32(struct snd_ctl_file *file,
> >  {
> >         return ctl_elem_write_user(file, data32, &data32->value);
> >  }
> > -#endif /* CONFIG_X86_X32 */
> > +#endif /* CONFIG_X86_X32_ABI */
> >
> >  /* add or replace a user control */
> >  static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
> > @@ -421,10 +421,10 @@ enum {
> >         SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
> >         SNDRV_CTL_IOCTL_ELEM_ADD32 = _IOWR('U', 0x17, struct snd_ctl_elem_info32),
> >         SNDRV_CTL_IOCTL_ELEM_REPLACE32 = _IOWR('U', 0x18, struct snd_ctl_elem_info32),
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >         SNDRV_CTL_IOCTL_ELEM_READ_X32 = _IOWR('U', 0x12, struct snd_ctl_elem_value_x32),
> >         SNDRV_CTL_IOCTL_ELEM_WRITE_X32 = _IOWR('U', 0x13, struct snd_ctl_elem_value_x32),
> > -#endif /* CONFIG_X86_X32 */
> > +#endif /* CONFIG_X86_X32_ABI */
> >  };
> >
> >  static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
> > @@ -463,12 +463,12 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
> >                 return snd_ctl_elem_add_compat(ctl, argp, 0);
> >         case SNDRV_CTL_IOCTL_ELEM_REPLACE32:
> >                 return snd_ctl_elem_add_compat(ctl, argp, 1);
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >         case SNDRV_CTL_IOCTL_ELEM_READ_X32:
> >                 return snd_ctl_elem_read_user_x32(ctl->card, argp);
> >         case SNDRV_CTL_IOCTL_ELEM_WRITE_X32:
> >                 return snd_ctl_elem_write_user_x32(ctl, argp);
> > -#endif /* CONFIG_X86_X32 */
> > +#endif /* CONFIG_X86_X32_ABI */
> >         }
> >
> >         down_read(&snd_ioctl_rwsem);
> > diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
> > index 590a46a9e78d..937f5117a81f 100644
> > --- a/sound/core/pcm_compat.c
> > +++ b/sound/core/pcm_compat.c
> > @@ -147,13 +147,13 @@ static int snd_pcm_ioctl_channel_info_compat(struct snd_pcm_substream *substream
> >         return err;
> >  }
> >
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >  /* X32 ABI has the same struct as x86-64 for snd_pcm_channel_info */
> >  static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
> >                                      struct snd_pcm_channel_info __user *src);
> >  #define snd_pcm_ioctl_channel_info_x32(s, p)   \
> >         snd_pcm_channel_info_user(s, p)
> > -#endif /* CONFIG_X86_X32 */
> > +#endif /* CONFIG_X86_X32_ABI */
> >
> >  struct compat_snd_pcm_status64 {
> >         snd_pcm_state_t state;
> > @@ -373,7 +373,7 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_substream *substream,
> >         return err;
> >  }
> >
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >  /* X32 ABI has 64bit timespec and 64bit alignment */
> >  struct snd_pcm_mmap_status_x32 {
> >         snd_pcm_state_t state;
> > @@ -464,7 +464,7 @@ static int snd_pcm_ioctl_sync_ptr_x32(struct snd_pcm_substream *substream,
> >
> >         return 0;
> >  }
> > -#endif /* CONFIG_X86_X32 */
> > +#endif /* CONFIG_X86_X32_ABI */
> >
> >  /*
> >   */
> > @@ -484,10 +484,10 @@ enum {
> >         SNDRV_PCM_IOCTL_READN_FRAMES32 = _IOR('A', 0x53, struct snd_xfern32),
> >         SNDRV_PCM_IOCTL_STATUS_COMPAT64 = _IOR('A', 0x20, struct compat_snd_pcm_status64),
> >         SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64 = _IOWR('A', 0x24, struct compat_snd_pcm_status64),
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >         SNDRV_PCM_IOCTL_CHANNEL_INFO_X32 = _IOR('A', 0x32, struct snd_pcm_channel_info),
> >         SNDRV_PCM_IOCTL_SYNC_PTR_X32 = _IOWR('A', 0x23, struct snd_pcm_sync_ptr_x32),
> > -#endif /* CONFIG_X86_X32 */
> > +#endif /* CONFIG_X86_X32_ABI */
> >  };
> >
> >  static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
> > @@ -531,10 +531,10 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
> >         case __SNDRV_PCM_IOCTL_SYNC_PTR32:
> >                 return snd_pcm_common_ioctl(file, substream, cmd, argp);
> >         case __SNDRV_PCM_IOCTL_SYNC_PTR64:
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >                 if (in_x32_syscall())
> >                         return snd_pcm_ioctl_sync_ptr_x32(substream, argp);
> > -#endif /* CONFIG_X86_X32 */
> > +#endif /* CONFIG_X86_X32_ABI */
> >                 return snd_pcm_common_ioctl(file, substream, cmd, argp);
> >         case SNDRV_PCM_IOCTL_HW_REFINE32:
> >                 return snd_pcm_ioctl_hw_params_compat(substream, 1, argp);
> > @@ -566,10 +566,10 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
> >                 return snd_pcm_status_user_compat64(substream, argp, false);
> >         case SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64:
> >                 return snd_pcm_status_user_compat64(substream, argp, true);
> > -#ifdef CONFIG_X86_X32
> > +#ifdef CONFIG_X86_X32_ABI
> >         case SNDRV_PCM_IOCTL_CHANNEL_INFO_X32:
> >                 return snd_pcm_ioctl_channel_info_x32(substream, argp);
> > -#endif /* CONFIG_X86_X32 */
> > +#endif /* CONFIG_X86_X32_ABI */
> >         }
> >
> >         return -ENOIOCTLCMD;
> > --
> > 2.27.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210227183910.221873-1-masahiroy%40kernel.org.
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
