Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A371387313
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 09:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347085AbhERHWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 03:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245465AbhERHWc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 03:22:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF8D661360;
        Tue, 18 May 2021 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621322474;
        bh=VPlgDYwLzrYfExLKq4qVF51gZCyV282lUs8rNsT8l0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5PwhRMD8bU2CDOmwnKDlaJHdTSqbGy94jnbyid+awVbgoi49NA2qX0lHna9rjEri
         HGWd24NXUy8nAnevipFFL71wTfg1bN5FDkc3mRxx1IA3VUAbMx9rezhrfVwGID5AvI
         i7VzPEd1EEPMRB4/1TBMgP1crvAe2gmJ7u0SLRoizKm8tj72NVPYRq9zQuIsrNCCHl
         tTd86MGJWlGdWWgZZavxtFO02uQ1kMiG5HRg471f+i+y5N+/hXW1MITKC1ZpemNaI3
         5HAuWd5vaYG/xOTSCuiw7I7DLoffN9emLRTI69Z/2qhVahAtWZW8ncGDSX4g4viYtu
         IYdJMq9UlwMnQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v20 2/7] riscv/Kconfig: make direct map manipulation options depend on MMU
Date:   Tue, 18 May 2021 10:20:29 +0300
Message-Id: <20210518072034.31572-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210518072034.31572-1-rppt@kernel.org>
References: <20210518072034.31572-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

ARCH_HAS_SET_DIRECT_MAP and ARCH_HAS_SET_MEMORY configuration options have
no meaning when CONFIG_MMU is disabled and there is no point to enable
them for the nommu case.

Add an explicit dependency on MMU for these options.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 arch/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a8ad8eb76120..c426e7d20907 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -26,8 +26,8 @@ config RISCV
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_PTE_SPECIAL
-	select ARCH_HAS_SET_DIRECT_MAP
-	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_SET_DIRECT_MAP if MMU
+	select ARCH_HAS_SET_MEMORY if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-- 
2.28.0

