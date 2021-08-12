Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DFC3EAA08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhHLSQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 14:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233283AbhHLSQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628792165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S+E4q/M54NKHA7t+0+yZiG5e1rXRHCWENhzfTmuDkeE=;
        b=EcbWKQGf9e0LexLu83WWLma+sJ5qn9WKcE+zoHcRfip06dYtvrfW0ccwsquYkDIxuefCvN
        0ZFZDhCwyqQcKt8CsrSiuQIa83cMfPkQITuLC/r9jXSho1MK1fVUU7TPmm1FJ5DhnGvE34
        fWQtv5VGwS7kQJoEgFbtyp5oYsgfoSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-gDhWt0HiO3W_TydA5ZQu8w-1; Thu, 12 Aug 2021 14:16:04 -0400
X-MC-Unique: gDhWt0HiO3W_TydA5ZQu8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A87080124F;
        Thu, 12 Aug 2021 18:16:03 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.194.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB15D1017CE5;
        Thu, 12 Aug 2021 18:15:42 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     "Andy Lutomirski" <luto@kernel.org>,
        "David Hildenbrand" <david@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Kees Cook" <keescook@chromium.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Chinwen Chang" <chinwen.chang@mediatek.com>,
        "Michel Lespinasse" <walken@google.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Huang Ying" <ying.huang@intel.com>,
        "Jann Horn" <jannh@google.com>, "Feng Tang" <feng.tang@intel.com>,
        "Kevin Brodsky" <Kevin.Brodsky@arm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Shawn Anastasio" <shawn@anastas.io>,
        "Steven Price" <steven.price@arm.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>,
        "Peter Xu" <peterx@redhat.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        "Marco Elver" <elver@google.com>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        "Nicolas Viennot" <Nicolas.Viennot@twosigma.com>,
        "Thomas Cedeno" <thomascedeno@google.com>,
        "Collin Fijalkovich" <cfijalkovich@google.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Chengguang Xu" <cgxu519@mykernel.net>,
        Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-unionfs@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
        <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
        <87lf56bllc.fsf@disp2133>
Date:   Thu, 12 Aug 2021 20:15:40 +0200
In-Reply-To: <87lf56bllc.fsf@disp2133> (Eric W. Biederman's message of "Thu,
        12 Aug 2021 12:48:31 -0500")
Message-ID: <87lf56edgz.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Eric W. Biederman:

> Given that MAP_PRIVATE for shared libraries is our strategy for handling
> writes to shared libraries perhaps we just need to use MAP_POPULATE or a
> new related flag (perhaps MAP_PRIVATE_NOW) that just makes certain that
> everything mapped from the executable is guaranteed to be visible from
> the time of the mmap, and any changes from the filesystem side after
> that are guaranteed to cause a copy on write.

I think this is called MAP_COPY:

  <https://www.gnu.org/software/hurd/glibc/mmap.html>

If we could get that functionality, we would certainly use it in the
glibc dynamic loader.  And it's not just dynamic loaders that would
benefit.

But I assume there are some rather thorny issues around semantics.  If
the changed areas of the file are in the page cache already, everything
is okay.  But if parts of the file are changed or discarded that are
not, they would have to be read in first, which is rather awkward.

That's why I suggested the signal for all future accesses.  It seems
more tractable and addresses the largest issue (the difficulty of
figuring out why some processes crash occasionally).

Thanks,
Florian

