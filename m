Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642123EC140
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 09:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhHNHyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 03:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhHNHyT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 03:54:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADBE3604D7;
        Sat, 14 Aug 2021 07:53:37 +0000 (UTC)
Date:   Sat, 14 Aug 2021 09:53:33 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        David Laight <David.Laight@aculab.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
        Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
Message-ID: <20210814075333.7333bxduk4tei57i@wittgenstein>
References: <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133>
 <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133>
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
 <CAHk-=wiJ0u33h2CXAO4b271Diik=z4jRt64=Gt6YV2jV4ef27g@mail.gmail.com>
 <CAHk-=wgi2+OSk2_uYwhL56NGzN8t2To8hm+c0BdBEbuBuzhg6g@mail.gmail.com>
 <YRcjCwfHvUZhcKf3@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRcjCwfHvUZhcKf3@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 14, 2021 at 01:57:31AM +0000, Al Viro wrote:
> On Fri, Aug 13, 2021 at 02:58:57PM -1000, Linus Torvalds wrote:
> > On Fri, Aug 13, 2021 at 2:54 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > And nobody really complained when we weakened it, so maybe removing it
> > > entirely might be acceptable.
> > 
> > I guess we could just try it and see... Worst comes to worst, we'll
> > have to put it back, but at least we'd know what crazy thing still
> > wants it..
> 
> Umm...  I'll need to go back and look through the thread, but I'm
> fairly sure that there used to be suckers that did replacement of
> binary that way (try to write, count on exclusion with execve while
> it's being written to) instead of using rename.  Install scripts
> of weird crap and stuff like that...

I'm not agains trying to remove it, but I think Al has a point.

Removing the write protection will also most certainly make certain
classes of attacks _easier_. For example, the runC container breakout
from last year using privileged containers issued CVE-2019-5736 would be
easier. I'm quoting from the commit I fixed this with:

    The attack can be made when attaching to a running container or when starting a
    container running a specially crafted image.  For example, when runC attaches
    to a container the attacker can trick it into executing itself. This could be
    done by replacing the target binary inside the container with a custom binary
    pointing back at the runC binary itself. As an example, if the target binary
    was /bin/bash, this could be replaced with an executable script specifying the
    interpreter path #!/proc/self/exe (/proc/self/exec is a symbolic link created
    by the kernel for every process which points to the binary that was executed
    for that process). As such when /bin/bash is executed inside the container,
    instead the target of /proc/self/exe will be executed - which will point to the
    runc binary on the host. The attacker can then proceed to write to the target
    of /proc/self/exe to try and overwrite the runC binary on the host.

and then the write protection kicks in of course:

    However in general, this will not succeed as the kernel will not
    permit it to be overwritten whilst runC is executing.

which the attack can of course already overcome nowadays with minimal
smarts:

    To overcome this, the attacker can instead open a file descriptor to
    /proc/self/exe using the O_PATH flag and then proceed to reopen the
    binary as O_WRONLY through /proc/self/fd/<nr> and try to write to it
    in a busy loop from a separate process. Ultimately it will succeed
    when the runC binary exits. After this the runC binary is
    compromised and can be used to attack other containers or the host
    itself.

But with write protection removed you'd allow such attacks to succeed
right away. It's not a huge deal to remove it since we need to have
other protection mechanisms in place already:

    To prevent this attack, LXC has been patched to create a temporary copy of the
    calling binary itself when it starts or attaches to containers. To do this LXC
    creates an anonymous, in-memory file using the memfd_create() system call and
    copies itself into the temporary in-memory file, which is then sealed to
    prevent further modifications. LXC then executes this sealed, in-memory file
    instead of the original on-disk binary. Any compromising write operations from
    a privileged container to the host LXC binary will then write to the temporary
    in-memory binary and not to the host binary on-disk, preserving the integrity
    of the host LXC binary. Also as the temporary, in-memory LXC binary is sealed,
    writes to this will also fail.

    Note: memfd_create() was added to the Linux kernel in the 3.17 release.

However, I still like to pich the upgrade mask idea Aleksa and we tried
to implement when we did openat2(). If we leave write-protection in
preventing /proc/self/exe from being written to:

we can take some time and upstream the upgrade mask patchset which was
part of the initial openat2() patchset but was dropped back then (and I
had Linus remove the last remants of the idea in [1]).

The idea was to add a new field to struct open_how "upgrade_mask" that
would allow a caller to specify with what permissions an fd could be
reopened with. I still like this idea a great deal and it would be a
very welcome addition to system management programs. The upgrade mask is
of course optional, i.e. the caller would have to specify the upgrade
mask at open time to restrict reopening (lest we regress the whole
world).

But, we could make it so that an O_PATH fd gotten from opening
/proc/<pid>/exe always gets a restricted upgrade mask set and so it
can't be upgraded to a O_WRONLY fd afterwards. For this to be
meaningful, write protection for /proc/self/exe would need to be kept.

[1]: commit 5c350aa11b441b32baf3bfe4018168cb8d10cef7
     Author: Christian Brauner <christian.brauner@ubuntu.com>
     Date:   Fri May 28 11:24:15 2021 +0200
     
         fcntl: remove unused VALID_UPGRADE_FLAGS
     
         We currently do not maky use of this feature and should we implement
         something like this in the future it's trivial to add it back.
     
         Link: https://lore.kernel.org/r/20210528092417.3942079-2-brauner@kernel.org
         Cc: Christoph Hellwig <hch@lst.de>
         Cc: Aleksa Sarai <cyphar@cyphar.com>
         Cc: Al Viro <viro@zeniv.linux.org.uk>
         Cc: linux-fsdevel@vger.kernel.org
         Suggested-by: Richard Guy Briggs <rgb@redhat.com>
         Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
