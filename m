Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057E93EDE34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 21:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhHPTwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 15:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231143AbhHPTwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629143492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SpO66406P+aAOH9nMaFQuRCCfyFRAgAvhM8DGsbyqP0=;
        b=Qt66zyvNpdbC2gSla3lAyHJeT/DMjXNWujav+J0pH08E3YuVb6LEVkByvZVu4VUWF6wowJ
        tWKvuLABNX7lQg7/acM+j4tbFUTOKADOHmZJ6MOgn4GtaJq+RBnPrgJUU3hPF+f2vbEmzK
        LiapnX4eb/RdwLA2bzldN+fjs2D8ML8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-RLnww2ZlPDyuojNV_LRHyA-1; Mon, 16 Aug 2021 15:51:31 -0400
X-MC-Unique: RLnww2ZlPDyuojNV_LRHyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1199A190A7A0;
        Mon, 16 Aug 2021 19:51:26 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C242D5C1D5;
        Mon, 16 Aug 2021 19:51:06 +0000 (UTC)
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
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 6/7] mm: ignore MAP_DENYWRITE in ksys_mmap_pgoff()
Date:   Mon, 16 Aug 2021 21:48:39 +0200
Message-Id: <20210816194840.42769-7-david@redhat.com>
In-Reply-To: <20210816194840.42769-1-david@redhat.com>
References: <20210816194840.42769-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's also remove masking off MAP_DENYWRITE from ksys_mmap_pgoff():
the last in-tree occurrence of MAP_DENYWRITE is now in LEGACY_MAP_MASK,
which accepts the flag e.g., for MAP_SHARED_VALIDATE; however, the flag
is ignored throughout the kernel now.

Add a comment to LEGACY_MAP_MASK stating that MAP_DENYWRITE is ignored.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
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

