Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8B3EA0EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 10:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhHLIqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230040AbhHLIqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628757976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35wUXv1jSLd4Y2PTErtZ5+2TNdih1YbrbBc7k9U7DsY=;
        b=DC7WWFPr8SPQltH3DYqhDcCbw7gpFh7PyrZKkFM2yfD5xZV+nYy2QcEW0mnfUsfWoYstPZ
        HtUnShjJhRp07WP5h5nFzeHwsBVuC+avI2y7yvkI0rJbtTiscyez7iBoj07TQLvxv1ChUj
        3/xRyOw3bNA9jwnTXiojRA38aWtqSDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-CCb9WVXDM32AzaMUNVc6MA-1; Thu, 12 Aug 2021 04:46:15 -0400
X-MC-Unique: CCb9WVXDM32AzaMUNVc6MA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B65E190B2A1;
        Thu, 12 Aug 2021 08:46:14 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2D365FC22;
        Thu, 12 Aug 2021 08:45:54 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 6/7] mm: ignore MAP_DENYWRITE in ksys_mmap_pgoff()
Date:   Thu, 12 Aug 2021 10:43:47 +0200
Message-Id: <20210812084348.6521-7-david@redhat.com>
In-Reply-To: <20210812084348.6521-1-david@redhat.com>
References: <20210812084348.6521-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's also remove masking off MAP_DENYWROTE from ksys_mmap_pgoff():
the last in-tree occurrence of MAP_DENYWRITE is now in LEGACY_MAP_MASK,
which accepts the flag e.g., for MAP_SHARED_VALIDATE; however, the flag
is ignored throughout the kernel now.

Add a comment to LEGACY_MAP_MASK stating that MAP_DENYWRITE is ignored.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mman.h | 3 ++-
 mm/mmap.c            | 2 --
 mm/nommu.c           | 2 --
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index bd9aadda047b..b66e91b8176c 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -32,7 +32,8 @@
  * The historical set of flags that all mmap implementations implicitly
  * support when a ->mmap_validate() op is not provided in file_operations.
  *
- * MAP_EXECUTABLE is completely ignored throughout the kernel.
+ * MAP_EXECUTABLE and MAP_DENYWRITE are completely ignored throughout the
+ * kernel.
  */
 #define LEGACY_MAP_MASK (MAP_SHARED \
 		| MAP_PRIVATE \
diff --git a/mm/mmap.c b/mm/mmap.c
index 589dc1dc13db..bf11fc6e8311 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1626,8 +1626,6 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			return PTR_ERR(file);
 	}
 
-	flags &= ~MAP_DENYWRITE;
-
 	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 out_fput:
 	if (file)
diff --git a/mm/nommu.c b/mm/nommu.c
index 3a93d4054810..0987d131bdfc 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1296,8 +1296,6 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			goto out;
 	}
 
-	flags &= ~MAP_DENYWRITE;
-
 	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 
 	if (file)
-- 
2.31.1

