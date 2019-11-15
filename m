Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB25FD3FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 06:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKOFNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 00:13:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:53529 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfKOFNd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 00:13:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 21:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,307,1569308400"; 
   d="scan'208";a="208330915"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2019 21:13:28 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Shakeel Butt <shakeelb@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][v2] resctrl: Add CPU_RESCTRL
Date:   Fri, 15 Nov 2019 13:24:20 +0800
Message-Id: <a39663fd4ce167e65b6d41027c3433dc00bf54f0.1573788882.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573788882.git.yu.c.chen@intel.com>
References: <cover.1573788882.git.yu.c.chen@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a generic option called CPU_RESCTRL which
is selected by the arch-specific ones CONFIG_X86_RESCTRL
or CONFIG_ARM64_RESCTRL in the future. The generic one will
cover the resctrl filesystem and other generic and shared
bits of functionality.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/Kconfig     | 4 ++++
 arch/x86/Kconfig | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 5f8a5d84dbbe..3886cf0052a8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -960,6 +960,10 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config CPU_RESCTRL
+	bool
+	def_bool n
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8ef85139553f..a8a12493e8c2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -455,6 +455,7 @@ config X86_CPU_RESCTRL
 	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
+	select CPU_RESCTRL
 	help
 	  Enable x86 CPU resource control support.
 
-- 
2.17.1

