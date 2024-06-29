Return-Path: <linux-fsdevel+bounces-22818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D230591CE61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 19:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E461E1C20F89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844EA132108;
	Sat, 29 Jun 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWCGBKeh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512F4C99;
	Sat, 29 Jun 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719683197; cv=none; b=t1hhteSIB42jZMij9SJqXyAOcTKMy4vhKzVVhZ95foja9JgL+1uhmz3jlSdkXDxr3elAqvWLH/BpUJK+He48YZOtfQ6mcD2+86l/6gitZtCIeivbD5jGtz2H4JlivBFHxzIfPNYhCKWnPKwPe3jQromV6OukhJAt5HLkH2/9/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719683197; c=relaxed/simple;
	bh=dI9d3ZkEDcUi8OCXq+Czxr9kfoJgXIcUvNvNGQ0NXBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRvzQ0gNMpP9bRjhbqWBSL0f6EzsEzGFTV8dMDR7v3lJ6WLyn3KOl/4eygyFMvkLfQ+9r8Bsk8J+cUcBfMwhsRk3FfzLHyPzbCEcDOCr4sPmmVzj0nk8tZvODVhnQkwnkwV+u7kpELBG8J2FqdQwmtMV09qB3OxiSX3SsQKUAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWCGBKeh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9b523a15cso10996955ad.0;
        Sat, 29 Jun 2024 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719683195; x=1720287995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJTuEAT8kFn/N38NgReiBC7u1W13u19d45QTb6wSxDI=;
        b=CWCGBKehQ/GEOzPutmEbKRLEEmubx5jGEaFk0UxFkteX8rmIaIBL3/8r2vPi0yPKvX
         HD8R/7bnTgpiiB++BVaJTdxLBZvWvmx9NqdcVjoKozhRzEBLypFJPOkXJA1O6ARU3x81
         k30+JXQtvWf2imxLL+LpIAyeFysvJ6HtknlhbQbbaCICtHPOPuUS0YWVgIJXi4vp3dWa
         yEykgrMvO63vL2h4nAc/AFpjCrMu+sfvqlsLnrPtGl+uz5D0uKTonh56Y6vsQWrLeWsZ
         y0cNM20w9FSCnpY8K+YfP0lz3RH37TT3tkmmwpkZXBMEazaegb2gcLR0ztCZr/XsW+bM
         LDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719683195; x=1720287995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJTuEAT8kFn/N38NgReiBC7u1W13u19d45QTb6wSxDI=;
        b=HegUrbEg/MHOoylF3VtmFoW5H8c7gegDLoIhapk7v6l/TBbdUGuIIUdarJxOzb+k+g
         JTaDq2+APW8a6jUFpYsBdwWVVdhuZRfF+LbD5A7uFEji56YFdYGtptcf0ud4UPN7hLgm
         A+45PAVX3E4kGAjO97TmosVnZHm5/l9DD8pNpxNBjmGF5HT/2w48LZ4Yh+D9PxbHAorH
         PcYfAZBOIPVc+MMe7hdKlMTbeYJgvJ4nMvm6gBfv8V9OKSmCXeJ0dC83o4u/4WbNmcHV
         FB7TOnsNqYZOsjBsilHLPCxuTafC3i0GWGTmBX/CfjunXG8fQ5hgXksa7FQJvzjnmQSK
         i2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5bjV3KbyreGQ+qfDAqQYiJY2w8Q2wY4BXlGH05fplOrQCJwDgpch92ZVkqMQKweIT0XTCbIK4z2aCshJZcfmzxwQE++58VrkhOdJMcSKtBtYhb4GRI1HY1Ml56BtRvCls4geGL9JZqlFgAY+z2CgvaG98fzfd/tNQZeUrNrE7Z5UqCwv8XxBw9iiNDR3GgyAmN3pyXruMEEKVN+jYWZRASrnIzSvM0GX/aniD1wRI5iqlYXHBa3p6z0OBKuul0OpIJviqRpb7SHGos3QqcgaOF1z6I54F9oOcD0oA3DI2nIBRccTZgqYwdc4EA2wGQvKNZVEz84mkZuQ/Du7KPrbD25Dzi+r1+fmQa0HcLJPBBxsDTvqoa911gosyAlx1yfjeSwCt+Kjir0eZ7CPlX0FScwM=
X-Gm-Message-State: AOJu0Yw4X+dD4cfI0R1d8XVwTuEMbaK9p/Y/eh2LGfynXZ5ZuC6UXKBV
	uGh8+ED9K9KDPKlDGwJ5KHt2Vf/CZnrRn2c4ESH7ws3yqKLy3DIL
X-Google-Smtp-Source: AGHT+IGXRwOTNfWOpdGXl+28hO8NMkh0znjd2CrkAf/HqJ5kuBn+8boNjwtHpyuWIrNeZ3XB7V/gSQ==
X-Received: by 2002:a17:902:ea0b:b0:1f6:3580:65c9 with SMTP id d9443c01a7336-1fadb4afc15mr29069525ad.26.1719683195282;
        Sat, 29 Jun 2024 10:46:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159a286sm34552615ad.282.2024.06.29.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 10:46:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 29 Jun 2024 10:46:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, libc-alpha@sourceware.org,
	musl@lists.openwall.com,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH v2 06/13] parisc: use generic sys_fanotify_mark
 implementation
Message-ID: <a913c77e-1abb-409f-86b9-8805c1451988@roeck-us.net>
References: <20240624163707.299494-1-arnd@kernel.org>
 <20240624163707.299494-7-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624163707.299494-7-arnd@kernel.org>

On Mon, Jun 24, 2024 at 06:37:04PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sys_fanotify_mark() syscall on parisc uses the reverse word order
> for the two halves of the 64-bit argument compared to all syscalls on
> all 32-bit architectures. As far as I can tell, the problem is that
> the function arguments on parisc are sorted backwards (26, 25, 24, 23,
> ...) compared to everyone else, so the calling conventions of using an
> even/odd register pair in native word order result in the lower word
> coming first in function arguments, matching the expected behavior
> on little-endian architectures. The system call conventions however
> ended up matching what the other 32-bit architectures do.
> 
> A glibc cleanup in 2020 changed the userspace behavior in a way that
> handles all architectures consistently, but this inadvertently broke
> parisc32 by changing to the same method as everyone else.
> 
> The change made it into glibc-2.35 and subsequently into debian 12
> (bookworm), which is the latest stable release. This means we
> need to choose between reverting the glibc change or changing the
> kernel to match it again, but either hange will leave some systems
> broken.
> 
> Pick the option that is more likely to help current and future
> users and change the kernel to match current glibc. This also
> means the behavior is now consistent across architectures, but
> it breaks running new kernels with old glibc builds before 2.35.
> 
> Link: https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=d150181d73d9
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/arch/parisc/kernel/sys_parisc.c?h=57b1dfbd5b4a39d
> Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>
> Tested-by: Helge Deller <deller@gmx.de>
> Acked-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I found this through code inspection, please double-check to make
> sure I got the bug and the fix right.
> 

Building parisc:allmodconfig ... failed
--------------
Error log:
In file included from fs/notify/fanotify/fanotify_user.c:14:
include/linux/syscalls.h:248:25: error: conflicting types for 'sys_fanotify_mark'; have 'long int(int,  unsigned int,  u32,  u32,  int,  const char *)' {aka 'long int(int,  unsigned int,  unsigned int,  unsigned int,  int,  const char *)'}
  248 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
      |                         ^~~
include/linux/syscalls.h:234:9: note: in expansion of macro '__SYSCALL_DEFINEx'
  234 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~
include/linux/syscalls.h:228:36: note: in expansion of macro 'SYSCALL_DEFINEx'
  228 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
      |                                    ^~~~~~~~~~~~~~~
include/linux/syscalls.h:287:27: note: in expansion of macro 'SYSCALL_DEFINE6'
  287 | #define SYSCALL32_DEFINE6 SYSCALL_DEFINE6
      |                           ^~~~~~~~~~~~~~~
fs/notify/fanotify/fanotify_user.c:1924:1: note: in expansion of macro 'SYSCALL32_DEFINE6'
 1924 | SYSCALL32_DEFINE6(fanotify_mark,
      | ^~~~~~~~~~~~~~~~~
include/linux/syscalls.h:862:17: note: previous declaration of 'sys_fanotify_mark' with type 'long int(int,  unsigned int,  u64,  int,  const char *)' {aka 'long int(int,  unsigned int,  long long unsigned int,  int,  const char *)'}
  862 | asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
      |                 ^~~~~~~~~~~~~~~~~
make[6]: [scripts/Makefile.build:244: fs/notify/fanotify/fanotify_user.o] Error 1 (ignored)

Guenter

