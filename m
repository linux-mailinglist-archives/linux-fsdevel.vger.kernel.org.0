Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5303EBDA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 22:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhHMUwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 16:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233915AbhHMUwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628887897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2X6nzOXxo3H0EdqupppVKuVb2Pe4/bVUTDNmqoeLdE=;
        b=W8LIVHwvIaZOwMMIqMzpnh9nR+BugJJiua54Z7qqEJQFzZodEQbRqQwgWMTNrE8CPc12h7
        VLWqY8ui7zx20vH4OTAQKN6Rk/W9VfLPf/CYwnoR3SuC4OEFFlHuaJYUFU971aSDruhosK
        rBlN0X/IHz8GswXR6rmRnY9JYsWEMe4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-Y3LCxE_EOcGvjoJz3lSDhA-1; Fri, 13 Aug 2021 16:51:35 -0400
X-MC-Unique: Y3LCxE_EOcGvjoJz3lSDhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9ADC1008060;
        Fri, 13 Aug 2021 20:51:33 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.194.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 795DB1BCF0;
        Fri, 13 Aug 2021 20:51:11 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Shawn Anastasio" <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Marco Elver" <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
        <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
        <87lf56bllc.fsf@disp2133>
        <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
        <87eeay8pqx.fsf@disp2133>
        <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
        <87h7ft2j68.fsf@disp2133>
Date:   Fri, 13 Aug 2021 22:51:09 +0200
In-Reply-To: <87h7ft2j68.fsf@disp2133> (Eric W. Biederman's message of "Fri,
        13 Aug 2021 15:17:51 -0500")
Message-ID: <871r6xdq6a.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Eric W. Biederman:

> Florian Weimer, would it be possible to get glibc's ld.so implementation to use
> MAP_SHARED?  Just so people reading the code know what to expect of the
> kernel?  As far as I can tell there is not a practical difference
> between a read-only MAP_PRIVATE and a read-only MAP_SHARED.

Some applications use mprotect to change page protections behind glibc's
back.  Using MAP_SHARED would break fork pretty badly.

Most of the hard-to-diagnose crashes seem to come from global data or
relocations because they are wiped by truncation.  And we certainly
can't use MAP_SHARED for those.  Code often seems to come back unchanged
after the truncation because the overwritten file hasn't actually
changed.  File attributes don't help because the copying is an
adminstrative action in the context of the application (maybe the result
of some automation).

I think avoiding the crashes isn't the right approach.  What I'd like to
see is better diagnostics.  Writing mtime and ctime to the core file
might help.  Or adding a flag to the core file and /proc/PID/smaps that
indicates if the file has been truncated across the mapping since the
mapping was created.

A bit less conservative and even more obvious to diagnose would be a new
flag for the mapping (perhaps set via madvise) that causes any future
access to the mapping to fault with SIGBUS and a special si_code value
after the file has been truncated across the mapping.  I think we would
set that in the glibc dynamic loader.  It would make the crashes much
less weird.

Thanks,
Florian

