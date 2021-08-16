Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49E03EDE16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 21:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhHPTtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 15:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231298AbhHPTtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629143354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=celAbCKZabJZZFRZffcKhJ6LMDssZFIlnWwC0cSAxUw=;
        b=KjOI/51g6/E4oHqv0DBbM2WwJGap54czY9QYM+spiSg/o4ghmVPFFd8oF+JB5Y5fb5oKNC
        O3ui0fZtiDIT87nU+dgnv/btiSHeFK7mq3nQx+f0yC8hwRPF5na0CNjhChDKynx6GWC3Fv
        qpYpgKeWu+ipkdUOtxH4I5P7m1JYCtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-rJSQIq_GNXW0E4KyKKFVGg-1; Mon, 16 Aug 2021 15:49:13 -0400
X-MC-Unique: rJSQIq_GNXW0E4KyKKFVGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E4DA871803;
        Mon, 16 Aug 2021 19:49:05 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F0865C1D5;
        Mon, 16 Aug 2021 19:48:41 +0000 (UTC)
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
Subject: [PATCH v2 0/7] Remove in-tree usage of MAP_DENYWRITE
Date:   Mon, 16 Aug 2021 21:48:33 +0200
Message-Id: <20210816194840.42769-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series removes all in-tree usage of MAP_DENYWRITE from the kernel
and removes VM_DENYWRITE. We stopped supporting MAP_DENYWRITE for
user space applications a while ago because of the chance for DoS.
The last renaming user is binfmt binary loading during exec and
legacy library loading via uselib().

With this change, MAP_DENYWRITE is effectively ignored throughout the
kernel. Although the net change is small (well, we actually add code and
comments), I think the cleanup in mmap() is quite nice.

There are some (minor) user-visible changes with this series:
1. We no longer deny write access to shared libaries loaded via legacy
   uselib(); this behavior matches modern user space e.g., via dlopen().
2. We no longer deny write access to the elf interpreter after exec
   completed, treating it just like shared libraries (which it often is).
3. We always deny write access to the file linked via /proc/pid/exe:
   sys_prctl(PR_SET_MM_MAP/EXE_FILE) will fail if write access to the file
   cannot be denied, and write access to the file will remain denied
   until the link is effectivel gone (exec, termination,
   sys_prctl(PR_SET_MM_MAP/EXE_FILE)) -- just as if exec'ing the file.

There is a related problem [2] with overlayfs, that should at least partly
be tackled by this series. I don't quite understand the interaction of
overlayfs and deny_write_access()/allow_write_access() at exec time:

If we end up denying write access to the wrong file and not to the
realfile, that would be fundamentally broken. We would have to reroute
our deny_write_access()/ allow_write_access() calls for the exec file to
the realfile -- but I leave figuring out the details to overlayfs guys, as
that would be a related but different issue.

There was a lengthy discussion in [3] whether to remove deny_write_access()
completely; however, if we decide to go that way, it would ideally be done
on top, because it could be that some applications even rely on the current
behavior.

v1 -> v2:
- "kernel/fork: factor out replacing the current MM exe_file"
-- Call the function "replace_mm_exe_file()" instead
-- Add some doc, similar to set_mm_exe_file()
-- Update patch subject/description
- "kernel/fork: always deny write access to current MM exe_file"
-- Introduce dup_mm_exe_file()
-- Make set_mm_exe_file() return an error to make the code easier to
   grasp.
-- Improve comments
- Added ACKs
- Mention "sys_prctl(PR_SET_MM_MAP/EXE_FILE)" everywhere instead of
  only "sys_prctl(PR_SET_MM_EXE_FILE)".

RFC -> v1:
- "binfmt: remove in-tree usage of MAP_DENYWRITE"
-- Add a note that this should fix part of a problem with overlayfs

[1] https://lore.kernel.org/r/20210423131640.20080-1-david@redhat.com/
[2] https://lore.kernel.org/r/YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com/
[3] https://lkml.kernel.org/r/20210812084348.6521-1-david@redhat.com

Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
Cc: Michal Hocko <mhocko@suse.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chengguang Xu <cgxu519@mykernel.net>
Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

David Hildenbrand (7):
  binfmt: don't use MAP_DENYWRITE when loading shared libraries via
    uselib()
  kernel/fork: factor out replacing the current MM exe_file
  kernel/fork: always deny write access to current MM exe_file
  binfmt: remove in-tree usage of MAP_DENYWRITE
  mm: remove VM_DENYWRITE
  mm: ignore MAP_DENYWRITE in ksys_mmap_pgoff()
  fs: update documentation of get_write_access() and friends

 arch/x86/ia32/ia32_aout.c      |  8 ++-
 fs/binfmt_aout.c               |  7 ++-
 fs/binfmt_elf.c                |  6 +--
 fs/binfmt_elf_fdpic.c          |  2 +-
 fs/exec.c                      |  4 +-
 fs/proc/task_mmu.c             |  1 -
 include/linux/fs.h             | 19 ++++---
 include/linux/mm.h             |  4 +-
 include/linux/mman.h           |  4 +-
 include/trace/events/mmflags.h |  1 -
 kernel/events/core.c           |  2 -
 kernel/fork.c                  | 95 ++++++++++++++++++++++++++++++----
 kernel/sys.c                   | 33 +-----------
 lib/test_printf.c              |  5 +-
 mm/mmap.c                      | 29 ++---------
 mm/nommu.c                     |  2 -
 16 files changed, 119 insertions(+), 103 deletions(-)


base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
-- 
2.31.1

