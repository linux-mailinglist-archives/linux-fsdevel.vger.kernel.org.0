Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82D4350211
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 16:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhCaOYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 10:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235452AbhCaOX7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:23:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 725C060FED;
        Wed, 31 Mar 2021 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617200639;
        bh=MKND8RUjXo0TsNaafQ2pFvm3xr35TmSoHeHO5Oj9xjQ=;
        h=From:To:Cc:Subject:Date:From;
        b=TAXb6eUsGCa4pdiVCqqKZnGfljZXt9haax8xWlFgCI3e0unvgRQx8xBTVeRrFGV/q
         ifZGF5satsq3w54m9YLloJlD4yd2NX9uvO/KNJ8oESnJDgML/1NhMS+UOSZqrNVaVB
         LOeHARVji+rKirnnqECw1FuhzLstxw2Vju9F73YHNEp4DrZmDImtmvzWpwBG3HHmkU
         gyTLq73p2b/dG60fDAuaUlJ92XmMV6XhiJLMiNEc5a1fHlv3Qz8pkdKafJ7VR5xJgS
         Ch6PZXwz4Jdc6b/Yk37ku10IPVem2+6nVLkRC8BEnQFfEbcLU9I3SOjITDFAaL1C8C
         nZikeyOe+Fp1w==
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
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
        x86@kernel.org
Subject: [PATCH] memfd_secret: use unsigned int rather than long as syscall flags type
Date:   Wed, 31 Mar 2021 17:23:45 +0300
Message-Id: <20210331142345.27532-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Yuri Norov says:

  If parameter size is the same for native and compat ABIs, we may
  wire a syscall made by compat client to native handler. This is
  true for unsigned int, but not true for unsigned long or pointer.

  That's why I suggest using unsigned int and so avoid creating compat
  entry point.

Use unsigned int as the type of the flags parameter in memfd_secret()
system call.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

@Andrew,
The patch is vs v5.12-rc5-mmots-2021-03-30-23, I'd appreciate if it would
be added as a fixup to the memfd_secret series.

 include/linux/syscalls.h                  | 2 +-
 mm/secretmem.c                            | 2 +-
 tools/testing/selftests/vm/memfd_secret.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 49c93c906893..1a1b5d724497 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1050,7 +1050,7 @@ asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr _
 asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
 		const void __user *rule_attr, __u32 flags);
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
-asmlinkage long sys_memfd_secret(unsigned long flags);
+asmlinkage long sys_memfd_secret(unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/mm/secretmem.c b/mm/secretmem.c
index f2ae3f32a193..3b1ba3991964 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -199,7 +199,7 @@ static struct file *secretmem_file_create(unsigned long flags)
 	return file;
 }
 
-SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
+SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 {
 	struct file *file;
 	int fd, err;
diff --git a/tools/testing/selftests/vm/memfd_secret.c b/tools/testing/selftests/vm/memfd_secret.c
index c878c2b841fc..2462f52e9c96 100644
--- a/tools/testing/selftests/vm/memfd_secret.c
+++ b/tools/testing/selftests/vm/memfd_secret.c
@@ -38,7 +38,7 @@ static unsigned long page_size;
 static unsigned long mlock_limit_cur;
 static unsigned long mlock_limit_max;
 
-static int memfd_secret(unsigned long flags)
+static int memfd_secret(unsigned int flags)
 {
 	return syscall(__NR_memfd_secret, flags);
 }
-- 
2.28.0

