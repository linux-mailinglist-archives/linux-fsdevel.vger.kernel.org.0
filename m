Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8355AA0F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbfIELJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 07:09:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59887 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732051AbfIELJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:09:54 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i5pdd-0000xz-G0; Thu, 05 Sep 2019 11:09:17 +0000
Date:   Thu, 5 Sep 2019 13:09:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user
 helpers
Message-ID: <20190905110915.4vvhicg4ldmpi5u6@wittgenstein>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904201933.10736-2-cyphar@cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 06:19:22AM +1000, Aleksa Sarai wrote:
> A common pattern for syscall extensions is increasing the size of a
> struct passed from userspace, such that the zero-value of the new fields
> result in the old kernel behaviour (allowing for a mix of userspace and
> kernel vintages to operate on one another in most cases). This is done
> in both directions -- hence two helpers -- though it's more common to
> have to copy user space structs into kernel space.
> 
> Previously there was no common lib/ function that implemented
> the necessary extension-checking semantics (and different syscalls
> implemented them slightly differently or incompletely[1]). A future
> patch replaces all of the common uses of this pattern to use the new
> copy_struct_{to,from}_user() helpers.
> 
> [1]: For instance {sched_setattr,perf_event_open,clone3}(2) all do do
>      similar checks to copy_struct_from_user() while rt_sigprocmask(2)
>      always rejects differently-sized struct arguments.
> 
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

I would probably split this out into a separate patchset. It can very
well go in before openat2(). Thoughts?

Christian
