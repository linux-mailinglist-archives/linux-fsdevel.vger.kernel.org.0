Return-Path: <linux-fsdevel+bounces-66529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06212C22829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 23:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5753B3A96DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75A337BA7;
	Thu, 30 Oct 2025 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo+/DM8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2127332EB6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862002; cv=none; b=ZvfYanQgQzXZzs/Ul+PI4FbJVWiqGy3a3HsezaWxUKKYM5QWshpj4Ek/8vu7m6xdeF88BBcQGZOkNuMYBlQ4fCBlbQYGTrGc6DlVrUPGT5oc0ZzN5+wJa9fFPaOeshhvzepi7C0pHHPbW/0ZtGPJA5eMaM8WOS8C0mrEoBNInDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862002; c=relaxed/simple;
	bh=775JFgGFr4UW9VpPzLFJHF884jKX3r9AqaWx6Gn3pb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL2qJWPjmr4X4AcW+RgBi2vQUI2Nfo0AZN9+i6SkF4dFFP8QpU3vcxPV1Vkf0FRi+GQtqvzlWnnepPvfOlpR39I85xATgBnFuFyobTOkstRHiLlHzHV8WN55qnwHCQXlxGAw0IgCrzhb+Wa5is12qjkevMOSZInBRJPqKrdBRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo+/DM8s; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so301792466b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761861995; x=1762466795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BFME8hHxHQNkuGOVwLthIkcP2SAdz5dPSExiMuGgtdE=;
        b=Eo+/DM8sQgNxm2esBkuL1vDZZQiXDD4CO92UTga2gmS69cjYizZnrYyhKo6GoADoF3
         i7XdnPPR+FAOewXq2tIu/vL/+RKZ/rzeK68kX1RBiglETM+Op+QkNmcD7BlSAPlScSW1
         ZYjQr18qFWo3cUWaRsm49hz45yhX2d6IOifNv5d/5q0RDy2g42spAKVc+kx2iY6hZhZ1
         dlgnB/xHasg5+j/WFDcb9wV/Yt0ZuyyEXbz8rgob+JvXQ877NYG2kYZSS/qCdC1cd+Uf
         kwub+rfHpYU0cXPd/ntHYOeyXlP12g2VeMg20U5lTPNS4bOd6nA2LBl8+NMfD/L7RCYb
         SYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861995; x=1762466795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFME8hHxHQNkuGOVwLthIkcP2SAdz5dPSExiMuGgtdE=;
        b=HW0s6cbM1tfHuv356VizxWMROw/D0Wtt85hXubzwUl/qH+/fsAFaxEPU/P620l8LQr
         m03xrJ/uBy+Fi0v0NOlsRL2XKxlETsZyJnm4anyNk1KJgg8FPehwYo+NKR61hT7sSqnd
         /Y6snNx3ulJKGf6H6kShK04dvCNIWrf4WhiEIkFXYOhzxT43dPv1oWRzTqQ+w8rS4Ylj
         DwgCyAy28xSMKI/hJ0b6UVniCxRHwcucFWaU4ijUOE9Iw5bmmqqGD4iDN9tcrxLjVwf7
         B8mfo167zqm8bpXUSjNY0KzTRdWdIDgw4VBKiOwPZs1LplqCYflwU1fGUBMNoOjKmDgq
         5TPw==
X-Forwarded-Encrypted: i=1; AJvYcCVRu+ft/JpnHCs8L4E10ojKmCenL5eSsTTh8Rmr1mClIbrkku2oAhhr89p26mNpHIZlIO3eokVFmWawuWfy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmf6Wad/IVyi/+tk517pcKyRQjXlxZqaUwSvtRPkSc+G2FcrSn
	jD8DIidP5ZYJp3VM8EQRjtIHrZvphMAydlnMR0x2kHw4i+07AcwLx6q5
X-Gm-Gg: ASbGncufWJTV2m8CDgfL10v16n8bJyJZEawKvnnSqNFtb8dZM9JrjCbn979m92T4m1p
	7NAojji08LFyHOXVDI+lsKi6XOt3Aucv2gwtMTPcwx1GEOQQxrbFtBRm2cQvqZqrLpqpH109z45
	FnQ3qZ5BDKqLBkkI8SbdvRI4WFHb+Rqc7yWXN+sNalbvpXzT71Vrz61njpqDOEOTO82/WZkk953
	FaaEHJlfnSYZUmVyT2CAWZ6I96mzVgyMM2Yss10sYAyLMMclO9idvUaVv4Ioj+uxUEFs/9P4fqZ
	fn/dqaBP89/l2CBORt3hWRA/reDMtUYL46JLxS+EPLaAeFVX4nsf5apbkWh3lWwvF35QAEYgwV3
	BRLb3kYP1j80HnnDle6Pdb26/614lW7qJUfCzKiuvfB2WTEPiGho5kVYU8WRgZttaIv69GcT3bC
	yqLW5Ls3QcfjGLDnSDlw18zTogJX+CG47Wdzb0DBVetAMCeQ==
X-Google-Smtp-Source: AGHT+IHySut1aFgKvqA1Hf59IIwmMKdY6To9ybgxV3cQVzl7nyrilXyziJcG/FcMZx/3Wh/PNgYOLQ==
X-Received: by 2002:a17:907:2d25:b0:b3e:5f20:88ad with SMTP id a640c23a62f3a-b70701c3f34mr119156466b.28.1761861995404;
        Thu, 30 Oct 2025 15:06:35 -0700 (PDT)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7067d0f4d8sm174892066b.70.2025.10.30.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:06:34 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:06:25 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
Message-ID: <vi5eesl223u6s3zqb27kyaojnncsro3725escqp2mcrd2mhcbx@hbmfepqluveh>
References: <20251030105242.801528-1-mjguzik@gmail.com>
 <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
 <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
 <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>

On Thu, Oct 30, 2025 at 10:39:46PM +0100, Mateusz Guzik wrote:
> On Thu, Oct 30, 2025 at 7:07 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > [ Adding Thomas, because he's been working on our x86 uaccess code,
> > and I actually think we get this all wrong for access_ok() etc ]
> >
> > On Thu, 30 Oct 2025 at 09:35, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > I don't know if you are suggesting to make the entire thing fail to
> > > compile if included for a module, or to transparently convert
> > > runtime-optimized access into plain access.
> > >
> > > I presume the former.
> >
> > I think *including* it should be ok, because we have things like
> > <asm/uaccess.h> - or your addition to <linux/fs.h> - that use it for
> > core functionality that is then not supported for module use.
> >
> > Yeah, in a perfect world we'd have those things only in "internal"
> > headers and people couldn't include them even by mistake, but that
> > ends up being a pain.
> >
> > So I don't think your
> >
> > +#ifdef MODULE
> > +#error "this functionality is not available for modules"
> > +#endif
> >
> > model works, because I think it might be too painful to fix (but hey,
> > maybe I'm wrong).
> >
> 
> In my proposal the patch which messes with the namei cache address
> would have the following in fs.h:
> #ifndef MODULE
> #include <asm/runtime-const.h>
> #endif
> 
> As in, unless the kernel itself is being compiled, it would pretend
> the runtime machinery does not even exist, which imo is preferable to
> failing later at link time.
> 
> Then whatever functionality using runtime-const is straight up not
> available and code insisting on providing something for modules anyway
> is forced to provide an ifdefed implementation.
> 

Here is a build-tested diff for bzImage itself and M=fs/erofs on the
x86-64 architecture.

It keeps access_ok() inline for demostrative purposes, I have no opinion
what to do with this specific sucker.

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 8d983cfd06ea..dc3273ac2034 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H
 
+#ifdef MODULE
+#error "this functionality is not available for modules"
+#endif
+
 #ifdef __ASSEMBLY__
 
 .macro RUNTIME_CONST_PTR sym reg
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c8a5ae35c871..ce8f6be1964e 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -12,13 +12,14 @@
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
 #include <asm/percpu.h>
-#include <asm/runtime-const.h>
 
-/*
- * Virtual variable: there's no actual backing store for this,
- * it can purely be used as 'runtime_const_ptr(USER_PTR_MAX)'
- */
 extern unsigned long USER_PTR_MAX;
+#ifdef MODULE
+#define __USER_PTR_MAX	USER_PTR_MAX
+#else
+#include <asm/runtime-const.h>
+#define __USER_PTR_MAX runtime_const_ptr(USER_PTR_MAX)
+#endif
 
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -54,7 +55,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
 #endif
 
 #define valid_user_address(x) \
-	likely((__force unsigned long)(x) <= runtime_const_ptr(USER_PTR_MAX))
+	likely((__force unsigned long)(x) <= __USER_PTR_MAX)
 
 /*
  * Masking the user address is an alternative to a conditional
@@ -67,7 +68,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
 	asm("cmp %1,%0\n\t"
 	    "cmova %1,%0"
 		:"=r" (ret)
-		:"r" (runtime_const_ptr(USER_PTR_MAX)),
+		:"r" (__USER_PTR_MAX),
 		 "0" (ptr));
 	return ret;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3ff9682d8bc4..5a3d89ed75d1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -78,6 +78,9 @@
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+unsigned long USER_PTR_MAX __ro_after_init = TASK_SIZE_MAX;
+EXPORT_SYMBOL(USER_PTR_MAX);
+
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
@@ -2575,8 +2578,6 @@ void __init arch_cpu_finalize_init(void)
 	alternative_instructions();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
-		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
-
 		/*
 		 * Enable this when LAM is gated on LASS support
 		if (cpu_feature_enabled(X86_FEATURE_LAM))

