Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67693312C58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 09:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhBHIxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 03:53:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhBHIwb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:52:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42DFD64E7E;
        Mon,  8 Feb 2021 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612774212;
        bh=448/2Az2AYziS1dj8/llSEBAzJNEjV4S42FIosvR1G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpyFKgL8iQ0U61tkEuacLIaZU2QfV/7zJ0VmZwhVJ3VjP45CIxmIcC6NPqOMCTa+Q
         3L3F8GxQoZXz1plvRn51rKDBYSbrmUkkgMIVNxktkzLZwIg2NcWXBCY+MdBCXanOip
         i4UvXn+JUGHqJm83b89YzBAuXxs1J5YmZr+QkyGejUENdnXfEDJkEMaX13m+b+V3S7
         OuOfexOXBpdIR0863DrJ6+Tr5IuQxsRMII4cQcFcyQp9UQ8mOP1sBXuJaAhDqpyAMo
         0LyH9NGq/xQOCx2ygepM+wUCgqArN8RxDorw+XaGYCnfDvsnvdYkI3RvbSkAemYWjf
         uVpUz0YsFTp0w==
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
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v17 03/10] riscv/Kconfig: make direct map manipulation options depend on MMU
Date:   Mon,  8 Feb 2021 10:49:13 +0200
Message-Id: <20210208084920.2884-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210208084920.2884-1-rppt@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
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
---
 arch/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e338e9579f3e..9d941794f11c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -25,8 +25,8 @@ config RISCV
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_PTE_SPECIAL
-	select ARCH_HAS_SET_DIRECT_MAP
-	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_SET_DIRECT_MAP if MMU
+	select ARCH_HAS_SET_MEMORY if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
-- 
2.28.0

