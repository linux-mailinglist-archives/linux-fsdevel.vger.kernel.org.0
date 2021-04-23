Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEE3692EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbhDWNT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231281AbhDWNT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619183960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2oFmuFF9Ujspg66yFLYIBAD7UKWnT0Uxm+etSkS7sV8=;
        b=eXYfnnx3jyjf3c/dk8qinFBdXeydYsh1xFayfc1f3T4g71uq3Cy2HjqIh77zOvBUn3GTIN
        yvpNMrKNIgjTBHc0NhGWZw7k32eIldEf+VQU9oIC9nIL38jD7tDrjK6oemyUKnYhVDyTek
        O6o54ZYdgV/2HRGfbLLRNhalFH/murU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-UI0mO126PTWCLOOXR4Fbng-1; Fri, 23 Apr 2021 09:19:16 -0400
X-MC-Unique: UI0mO126PTWCLOOXR4Fbng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1764F8026AD;
        Fri, 23 Apr 2021 13:19:09 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 704E960BE5;
        Fri, 23 Apr 2021 13:18:47 +0000 (UTC)
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
Subject: [PATCH RFC 7/7] fs: update documentation of get_write_access() and friends
Date:   Fri, 23 Apr 2021 15:16:40 +0200
Message-Id: <20210423131640.20080-8-david@redhat.com>
In-Reply-To: <20210423131640.20080-1-david@redhat.com>
References: <20210423131640.20080-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As VM_DENYWRITE does no longer exists, let's spring-clean the
documentation of get_write_access() and friends.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/fs.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..b0a410a14170 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2906,15 +2906,20 @@ static inline void file_end_write(struct file *file)
 }
 
 /*
+ * This is used for regular files where some users -- especially the
+ * currently executed binary in a process, previously handled via
+ * VM_DENYWRITE -- cannot handle concurrent write (and maybe mmap
+ * read-write shared) accesses.
+ *
  * get_write_access() gets write permission for a file.
  * put_write_access() releases this write permission.
- * This is used for regular files.
- * We cannot support write (and maybe mmap read-write shared) accesses and
- * MAP_DENYWRITE mmappings simultaneously. The i_writecount field of an inode
- * can have the following values:
- * 0: no writers, no VM_DENYWRITE mappings
- * < 0: (-i_writecount) vm_area_structs with VM_DENYWRITE set exist
- * > 0: (i_writecount) users are writing to the file.
+ * deny_write_access() denies write access to a file.
+ * allow_write_access() re-enables write access to a file.
+ *
+ * The i_writecount field of an inode can have the following values:
+ * 0: no write access, no denied write access
+ * < 0: (-i_writecount) users that denied write access to the file.
+ * > 0: (i_writecount) users that have write access to the file.
  *
  * Normally we operate on that counter with atomic_{inc,dec} and it's safe
  * except for the cases where we don't hold i_writecount yet. Then we need to
-- 
2.30.2

