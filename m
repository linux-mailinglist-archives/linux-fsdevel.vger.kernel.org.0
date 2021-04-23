Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A723692D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhDWNRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230521AbhDWNRq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619183829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u7WjucWMKhco5a0xvZlF0gB5mBL6gDa1ouYEA5LycDs=;
        b=WDUSJSqknDfV1fOKN6jBwbVF3qwsLc6vxMDzCz7HryL8E4ls5j+hqMJxIzG4+f4XmqYwbU
        a5HhBtINLEgfBG+wzgCY0OMj4Z+Hc5C7bUc3Y2tXbgPmKraI2IlMszH9PxlTdN23rnTuBn
        387R00so8gQy+SwoAtOu6+w20OJuCCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-a3otH4XROmi4zXbJq7JOCA-1; Fri, 23 Apr 2021 09:17:07 -0400
X-MC-Unique: a3otH4XROmi4zXbJq7JOCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B29F480D6A8;
        Fri, 23 Apr 2021 13:17:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76CF360C13;
        Fri, 23 Apr 2021 13:16:41 +0000 (UTC)
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
Subject: [PATCH RFC 0/7] Remove in-tree usage of MAP_DENYWRITE
Date:   Fri, 23 Apr 2021 15:16:33 +0200
Message-Id: <20210423131640.20080-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series is based on [1]
	[PATCH v1 0/3] perf/binfmt/mm: remove in-tree usage of
	MAP_EXECUTABLE
and [2]
	[PATCH v2] mm, thp: Relax the VM_DENYWRITE constraint on
	file-backed THPs

This series removes all in-tree usage of MAP_DENYWRITE from the kernel
and removes VM_DENYWRITE. We stopped supporting MAP_DENYWRITE for
user space applications a while ago because of the chance for DoS.
The last renaming user is binfmt binary loading during exec and
legacy library loading via uselib(). 

With this change, MAP_DENYWRITE is effectively ignored throughout the
kernel. Although the net change is small, I think the cleanup in mmap()
is quite nice.

There are some (minor) user-visible changes with this series, that's why
I am flagging this as RFC and cc-ing linux-api:
1. We no longer deny write access to shared libaries loaded via legacy
   uselib(); this behavior matches modern user space e.g., via dlopen().
2. We no longer deny write access to the elf interpreter after exec
   completed, treating it just like shared libraries (which it often is).
3. We always deny write access to the file linked via /proc/pid/exe:
   sys_prctl(PR_SET_MM_EXE_FILE) will fail if write access to the file
   cannot be denied, and write access to the file will remain denied
   until the link is effectivel gone (exec, termination,
   PR_SET_MM_EXE_FILE) -- just as if exec'ing the file.

I was wondering if we really care about permanently disabling write access
to the executable, or if it would be good enough to just disable write
access while loading the new executable during exec; but I don't know
the history of that -- and it somewhat makes sense to deny write access
at least to the main executable. With modern user space -- dlopen() -- we
can effectively modify the content of shared libraries while being used.

I'm not 100% sure if the race documented in patch #3 applies (forking
while another thread is doing a PR_SET_MM_EXE_FILE), but I
assume this is possible.

[1] https://lkml.kernel.org/r/20210421093453.6904-1-david@redhat.com
[2] https://lkml.kernel.org/r/20210406000930.3455850-1-cfijalkovich@google.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Chinwen Chang <chinwen.chang@mediatek.com>
Cc: Michel Lespinasse <walken@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jann Horn <jannh@google.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shawn Anastasio <shawn@anastas.io>
Cc: Steven Price <steven.price@arm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Cc: Thomas Cedeno <thomascedeno@google.com>
Cc: Collin Fijalkovich <cfijalkovich@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-api@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

David Hildenbrand (7):
  binfmt: don't use MAP_DENYWRITE when loading shared libraries via
    uselib()
  kernel/fork: factor out atomcially replacing the current MM exe_file
  kernel/fork: always deny write access to current MM exe_file
  binfmt: remove in-tree usage of MAP_DENYWRITE
  mm: remove VM_DENYWRITE
  mm: ignore MAP_DENYWRITE in ksys_mmap_pgoff()
  fs: update documentation of get_write_access() and friends

 arch/x86/ia32/ia32_aout.c      |  8 ++--
 fs/binfmt_aout.c               |  7 ++--
 fs/binfmt_elf.c                |  6 +--
 fs/binfmt_elf_fdpic.c          |  2 +-
 fs/proc/task_mmu.c             |  1 -
 include/linux/fs.h             | 19 +++++----
 include/linux/mm.h             |  3 +-
 include/linux/mman.h           |  4 +-
 include/trace/events/mmflags.h |  1 -
 kernel/events/core.c           |  2 -
 kernel/fork.c                  | 75 ++++++++++++++++++++++++++++++----
 kernel/sys.c                   | 33 +--------------
 lib/test_printf.c              |  5 +--
 mm/mmap.c                      | 29 ++-----------
 mm/nommu.c                     |  2 -
 15 files changed, 98 insertions(+), 99 deletions(-)

-- 
2.30.2

