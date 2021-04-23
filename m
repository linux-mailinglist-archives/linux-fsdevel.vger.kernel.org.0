Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455363692D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbhDWNSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231169AbhDWNSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619183847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HnFevLogFipnj2fiASeOMcLsoblHzZP/BSOeS5H0KU=;
        b=YAk2PZ7VF5DQPf3Az4KQtkmTyUz1ZISGl37x5+9KsYVN8UoXWiJmt0W9OfBaPiSuSM5E0C
        YMdplDXE0PgjkOtXHI6FJwTxdWGDddK3JdHmvB3Rb5m3jgnGfsqFF3lkpurFTYuMd0bFim
        9oQcFxcVjFuyaOwem4UI4dD4iQ5TJ6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-AqiXMU9LNIWsu42sVgL-3w-1; Fri, 23 Apr 2021 09:17:26 -0400
X-MC-Unique: AqiXMU9LNIWsu42sVgL-3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B582881278;
        Fri, 23 Apr 2021 13:17:21 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29CFA60BE5;
        Fri, 23 Apr 2021 13:17:00 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH RFC 1/7] binfmt: don't use MAP_DENYWRITE when loading shared libraries via uselib()
Date:   Fri, 23 Apr 2021 15:16:34 +0200
Message-Id: <20210423131640.20080-2-david@redhat.com>
In-Reply-To: <20210423131640.20080-1-david@redhat.com>
References: <20210423131640.20080-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

uselib() is the legacy systemcall for loading shared libraries.
Nowadays, applications use dlopen() to load shared libraries, completely
implemented in user space via mmap().

For example, glibc uses MAP_COPY to mmap shared libraries. While this
maps to MAP_PRIVATE | MAP_DENYWRITE on Linux, Linux ignores any
MAP_DENYWRITE specification from user space in mmap.

With this change, all remaining in-tree users of MAP_DENYWRITE use it
to map an executable. We will be able to open shared libraries loaded
via uselib() writable, just as we already can via dlopen() from user
space.

This is one step into the direction of removing MAP_DENYWRITE from the
kernel. This can be considered a minor user space visible change.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/ia32/ia32_aout.c | 2 +-
 fs/binfmt_aout.c          | 2 +-
 fs/binfmt_elf.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index 5e5b9fc2747f..321d7b22ad2d 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -293,7 +293,7 @@ static int load_aout_library(struct file *file)
 	/* Now use mmap to map the library into memory. */
 	error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_32BIT,
+			MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
 			N_TXTOFF(ex));
 	retval = error;
 	if (error != start_addr)
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index 12461f3ed04f..37df8fee63d7 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -309,7 +309,7 @@ static int load_aout_library(struct file *file)
 	/* Now use mmap to map the library into memory. */
 	error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
+			MAP_FIXED | MAP_PRIVATE;
 			N_TXTOFF(ex));
 	retval = error;
 	if (error != start_addr)
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index e0427b817425..763188ac398e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1384,7 +1384,7 @@ static int load_elf_library(struct file *file)
 			(eppnt->p_filesz +
 			 ELF_PAGEOFFSET(eppnt->p_vaddr)),
 			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_DENYWRITE,
+			MAP_FIXED_NOREPLACE | MAP_PRIVATE,
 			(eppnt->p_offset -
 			 ELF_PAGEOFFSET(eppnt->p_vaddr)));
 	if (error != ELF_PAGESTART(eppnt->p_vaddr))
-- 
2.30.2

