Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BE4D8D55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 20:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbiCNTwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 15:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244707AbiCNTwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:52:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1E23F30A;
        Mon, 14 Mar 2022 12:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8CEA611A6;
        Mon, 14 Mar 2022 19:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D32EC340E9;
        Mon, 14 Mar 2022 19:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647287420;
        bh=Dro4LZI2ieLx7MeHOzF/p3bWs/a6rgtiTs1GrLOSZ7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWRPnEw8M5XArLed9BsUXmtAwsnFEbxJGpaEV1blCB7CSCzNf9cfzJq6E8qCEiDwS
         mGn48rkhoppdRnh7heBi+oTkIu60H0aTVY6cPkZQPAKp1bYGHpzuoD1kN0xJs9lJw5
         E0F8FZY4VgAqnUqJnKQ1Kr0qtqek3/uqDBVj/ko9JY7kQayP1yaNHn+i/+gAEod2Kh
         k4piJWOo4t/DUoXQ9YdffIxJ5V5ojGfrnHkVO5GezwgN11p4/XLFhTy9qzGpuQuwsH
         gUkH5XP4sk3BBswDO1zyeDF6/7LXVJTkKD+xSm06gVyGWIvpoTrHSeuObo4tXY/hal
         AuIUcfRHwkMyg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/2] x86: Remove toolchain check for X32 ABI capability
Date:   Mon, 14 Mar 2022 12:48:41 -0700
Message-Id: <20220314194842.3452-2-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314194842.3452-1-nathan@kernel.org>
References: <20220314194842.3452-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

Commit 0bf6276392e9 ("x32: Warn and disable rather than error if
binutils too old") added a small test in arch/x86/Makefile because
binutils 2.22 or newer is needed to properly support elf32-x86-64. This
check is no longer necessary, as the minimum supported version of
binutils is 2.23, which is enforced at configuration time with
scripts/min-tool-version.sh.

Remove this check and replace all uses of CONFIG_X86_X32 with
CONFIG_X86_X32_ABI, as two symbols are no longer necessary.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
[nathan: Rebase, fix up a few places where CONFIG_X86_X32 was still
         used, and simplify commit message to satisfy -tip requirements]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/Kconfig                       |  8 ++------
 arch/x86/Makefile                      | 16 ----------------
 arch/x86/entry/syscalls/Makefile       |  2 +-
 arch/x86/include/asm/syscall_wrapper.h |  6 +++---
 arch/x86/include/asm/vdso.h            |  2 +-
 arch/x86/kernel/process_64.c           |  2 +-
 fs/fuse/ioctl.c                        |  2 +-
 fs/xfs/xfs_ioctl32.c                   |  2 +-
 sound/core/control_compat.c            | 16 ++++++++--------
 sound/core/pcm_compat.c                | 20 ++++++++++----------
 10 files changed, 28 insertions(+), 48 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 870e0d10452d..b903bfcd713c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2861,7 +2861,7 @@ config IA32_AOUT
 	help
 	  Support old a.out binaries in the 32bit emulation.
 
-config X86_X32
+config X86_X32_ABI
 	bool "x32 ABI for 64-bit mode"
 	depends on X86_64
 	help
@@ -2870,10 +2870,6 @@ config X86_X32
 	  full 64-bit register file and wide data path while leaving
 	  pointers at 32 bits for smaller memory footprint.
 
-	  You will need a recent binutils (2.22 or later) with
-	  elf32_x86_64 support enabled to compile a kernel with this
-	  option set.
-
 config COMPAT_32
 	def_bool y
 	depends on IA32_EMULATION || X86_32
@@ -2882,7 +2878,7 @@ config COMPAT_32
 
 config COMPAT
 	def_bool y
-	depends on IA32_EMULATION || X86_X32
+	depends on IA32_EMULATION || X86_X32_ABI
 
 if COMPAT
 config COMPAT_FOR_U64_ALIGNMENT
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f29c2c9c3216..63d50f65b828 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -152,22 +152,6 @@ else
         KBUILD_CFLAGS += -mcmodel=kernel
 endif
 
-ifdef CONFIG_X86_X32
-	x32_ld_ok := $(call try-run,\
-			/bin/echo -e '1: .quad 1b' | \
-			$(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" - && \
-			$(OBJCOPY) -O elf32-x86-64 "$$TMP" "$$TMP.o" && \
-			$(LD) -m elf32_x86_64 "$$TMP.o" -o "$$TMP",y,n)
-        ifeq ($(x32_ld_ok),y)
-                CONFIG_X86_X32_ABI := y
-                KBUILD_AFLAGS += -DCONFIG_X86_X32_ABI
-                KBUILD_CFLAGS += -DCONFIG_X86_X32_ABI
-        else
-                $(warning CONFIG_X86_X32 enabled but no binutils support)
-        endif
-endif
-export CONFIG_X86_X32_ABI
-
 #
 # If the function graph tracer is used with mcount instead of fentry,
 # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index 5b3efed0e4e8..7f3886eeb2ff 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -67,7 +67,7 @@ uapisyshdr-y			+= unistd_32.h unistd_64.h unistd_x32.h
 syshdr-y			+= syscalls_32.h
 syshdr-$(CONFIG_X86_64)		+= unistd_32_ia32.h unistd_64_x32.h
 syshdr-$(CONFIG_X86_64)		+= syscalls_64.h
-syshdr-$(CONFIG_X86_X32)	+= syscalls_x32.h
+syshdr-$(CONFIG_X86_X32_ABI)	+= syscalls_x32.h
 syshdr-$(CONFIG_XEN)		+= xen-hypercalls.h
 
 uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 6a2827d0681f..59358d1bf880 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -159,7 +159,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #endif /* CONFIG_IA32_EMULATION */
 
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 /*
  * For the x32 ABI, we need to create a stub for compat_sys_*() which is aware
  * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
@@ -177,12 +177,12 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 #define __X32_COMPAT_SYS_NI(name)					\
 	__SYS_NI(x64, compat_sys_##name)
-#else /* CONFIG_X86_X32 */
+#else /* CONFIG_X86_X32_ABI */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #define __X32_COMPAT_COND_SYSCALL(name)
 #define __X32_COMPAT_SYS_NI(name)
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 98aa103eb4ab..2963a2f5dbc4 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -37,7 +37,7 @@ struct vdso_image {
 extern const struct vdso_image vdso_image_64;
 #endif
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 extern const struct vdso_image vdso_image_x32;
 #endif
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3402edec236c..e459253649be 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -681,7 +681,7 @@ void set_personality_64bit(void)
 
 static void __set_personality_x32(void)
 {
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	if (current->mm)
 		current->mm->context.flags = 0;
 
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fbc09dab1f85..7143c85cc4aa 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -170,7 +170,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 #else
 	if (flags & FUSE_IOCTL_COMPAT) {
 		inarg.flags |= FUSE_IOCTL_32BIT;
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 		if (in_x32_syscall())
 			inarg.flags |= FUSE_IOCTL_COMPAT_X32;
 #endif
diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index 004ed2a251e8..ca25ed89b706 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -217,7 +217,7 @@ xfs_compat_ioc_fsbulkstat(
 	inumbers_fmt_pf		inumbers_func = xfs_fsinumbers_fmt_compat;
 	bulkstat_one_fmt_pf	bs_one_func = xfs_fsbulkstat_one_fmt_compat;
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	if (in_x32_syscall()) {
 		/*
 		 * ... but on x32 the input xfs_fsop_bulkreq has pointers
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index edff063e088d..d8a86d1a99d6 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -150,7 +150,7 @@ struct snd_ctl_elem_value32 {
         unsigned char reserved[128];
 };
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 /* x32 has a different alignment for 64bit values from ia32 */
 struct snd_ctl_elem_value_x32 {
 	struct snd_ctl_elem_id id;
@@ -162,7 +162,7 @@ struct snd_ctl_elem_value_x32 {
 	} value;
 	unsigned char reserved[128];
 };
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 
 /* get the value type and count of the control */
 static int get_ctl_type(struct snd_card *card, struct snd_ctl_elem_id *id,
@@ -347,7 +347,7 @@ static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
 	return ctl_elem_write_user(file, data32, &data32->value);
 }
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 static int snd_ctl_elem_read_user_x32(struct snd_card *card,
 				      struct snd_ctl_elem_value_x32 __user *data32)
 {
@@ -359,7 +359,7 @@ static int snd_ctl_elem_write_user_x32(struct snd_ctl_file *file,
 {
 	return ctl_elem_write_user(file, data32, &data32->value);
 }
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 
 /* add or replace a user control */
 static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
@@ -418,10 +418,10 @@ enum {
 	SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_ADD32 = _IOWR('U', 0x17, struct snd_ctl_elem_info32),
 	SNDRV_CTL_IOCTL_ELEM_REPLACE32 = _IOWR('U', 0x18, struct snd_ctl_elem_info32),
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	SNDRV_CTL_IOCTL_ELEM_READ_X32 = _IOWR('U', 0x12, struct snd_ctl_elem_value_x32),
 	SNDRV_CTL_IOCTL_ELEM_WRITE_X32 = _IOWR('U', 0x13, struct snd_ctl_elem_value_x32),
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 };
 
 static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
@@ -460,12 +460,12 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
 		return snd_ctl_elem_add_compat(ctl, argp, 0);
 	case SNDRV_CTL_IOCTL_ELEM_REPLACE32:
 		return snd_ctl_elem_add_compat(ctl, argp, 1);
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	case SNDRV_CTL_IOCTL_ELEM_READ_X32:
 		return snd_ctl_elem_read_user_x32(ctl->card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE_X32:
 		return snd_ctl_elem_write_user_x32(ctl, argp);
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 	}
 
 	down_read(&snd_ioctl_rwsem);
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index e4e176854ce7..917c5b4f19d7 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -147,13 +147,13 @@ static int snd_pcm_ioctl_channel_info_compat(struct snd_pcm_substream *substream
 	return err;
 }
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 /* X32 ABI has the same struct as x86-64 for snd_pcm_channel_info */
 static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
 				     struct snd_pcm_channel_info __user *src);
 #define snd_pcm_ioctl_channel_info_x32(s, p)	\
 	snd_pcm_channel_info_user(s, p)
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 
 struct compat_snd_pcm_status64 {
 	snd_pcm_state_t state;
@@ -375,7 +375,7 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_substream *substream,
 	return err;
 }
 
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 /* X32 ABI has 64bit timespec and 64bit alignment */
 struct snd_pcm_mmap_status_x32 {
 	snd_pcm_state_t state;
@@ -468,7 +468,7 @@ static int snd_pcm_ioctl_sync_ptr_x32(struct snd_pcm_substream *substream,
 
 	return 0;
 }
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 
 #ifdef __BIG_ENDIAN
 typedef char __pad_before_u32[4];
@@ -560,10 +560,10 @@ enum {
 	SNDRV_PCM_IOCTL_READN_FRAMES32 = _IOR('A', 0x53, struct snd_xfern32),
 	SNDRV_PCM_IOCTL_STATUS_COMPAT64 = _IOR('A', 0x20, struct compat_snd_pcm_status64),
 	SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64 = _IOWR('A', 0x24, struct compat_snd_pcm_status64),
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	SNDRV_PCM_IOCTL_CHANNEL_INFO_X32 = _IOR('A', 0x32, struct snd_pcm_channel_info),
 	SNDRV_PCM_IOCTL_SYNC_PTR_X32 = _IOWR('A', 0x23, struct snd_pcm_sync_ptr_x32),
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 };
 
 static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
@@ -607,10 +607,10 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 	case __SNDRV_PCM_IOCTL_SYNC_PTR32:
 		return snd_pcm_common_ioctl(file, substream, cmd, argp);
 	case __SNDRV_PCM_IOCTL_SYNC_PTR64:
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 		if (in_x32_syscall())
 			return snd_pcm_ioctl_sync_ptr_x32(substream, argp);
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 		return snd_pcm_ioctl_sync_ptr_buggy(substream, argp);
 	case SNDRV_PCM_IOCTL_HW_REFINE32:
 		return snd_pcm_ioctl_hw_params_compat(substream, 1, argp);
@@ -642,10 +642,10 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 		return snd_pcm_status_user_compat64(substream, argp, false);
 	case SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64:
 		return snd_pcm_status_user_compat64(substream, argp, true);
-#ifdef CONFIG_X86_X32
+#ifdef CONFIG_X86_X32_ABI
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO_X32:
 		return snd_pcm_ioctl_channel_info_x32(substream, argp);
-#endif /* CONFIG_X86_X32 */
+#endif /* CONFIG_X86_X32_ABI */
 	}
 
 	return -ENOIOCTLCMD;
-- 
2.35.1

