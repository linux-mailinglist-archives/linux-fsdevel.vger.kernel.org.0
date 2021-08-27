Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454353F9809
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 12:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbhH0KUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 06:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244708AbhH0KUA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:20:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6CAF60560;
        Fri, 27 Aug 2021 10:18:56 +0000 (UTC)
Date:   Fri, 27 Aug 2021 12:18:52 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Laight <David.Laight@aculab.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
Message-ID: <20210827101852.7vbb2pqqyixqzd3b@wittgenstein>
References: <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133>
 <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133>
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
 <CAHk-=wiJ0u33h2CXAO4b271Diik=z4jRt64=Gt6YV2jV4ef27g@mail.gmail.com>
 <b60e9bd1-7232-472d-9c9c-1d6593e9e85e@www.fastmail.com>
 <0ed69079-9e13-a0f4-776c-1f24faa9daec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ed69079-9e13-a0f4-776c-1f24faa9daec@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:47:07PM +0200, David Hildenbrand wrote:
> On 26.08.21 19:48, Andy Lutomirski wrote:
> > On Fri, Aug 13, 2021, at 5:54 PM, Linus Torvalds wrote:
> > > On Fri, Aug 13, 2021 at 2:49 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > > 
> > > > I’ll bite.  How about we attack this in the opposite direction: remove the deny write mechanism entirely.
> > > 
> > > I think that would be ok, except I can see somebody relying on it.
> > > 
> > > It's broken, it's stupid, but we've done that ETXTBUSY for a _loong_ time.
> > 
> > Someone off-list just pointed something out to me, and I think we should push harder to remove ETXTBSY.  Specifically, we've all been focused on open() failing with ETXTBSY, and it's easy to make fun of anyone opening a running program for write when they should be unlinking and replacing it.
> > 
> > Alas, Linux's implementation of deny_write_access() is correct^Wabsurd, and deny_write_access() *also* returns ETXTBSY if the file is open for write.  So, in a multithreaded program, one thread does:
> > 
> > fd = open("some exefile", O_RDWR | O_CREAT | O_CLOEXEC);
> > write(fd, some stuff);
> > 
> > <--- problem is here
> > 
> > close(fd);
> > execve("some exefile");
> > 
> > Another thread does:
> > 
> > fork();
> > execve("something else");
> > 
> > In between fork and execve, there's another copy of the open file description, and i_writecount is held, and the execve() fails.  Whoops.  See, for example:
> > 
> > https://github.com/golang/go/issues/22315
> > 
> > I propose we get rid of deny_write_access() completely to solve this.
> > 
> > Getting rid of i_writecount itself seems a bit harder, since a handful of filesystems use it for clever reasons.
> > 
> > (OFD locks seem like they might have the same problem.  Maybe we should have a clone() flag to unshare the file table and close close-on-exec things?)
> > 
> 
> It's not like this issue is new (^2017) or relevant in practice. So no need
> to hurry IMHO. One step at a time: it might make perfect sense to remove
> ETXTBSY, but we have to be careful to not break other user space that
> actually cares about the current behavior in practice.

I agree. As I at least tried to show, removing write-protection can make
some exploits easier. I'm all for trying to remove this if it simplifies
things but for sure this shouldn't be part of this patchset and we
should be careful about it.

The removal of a (misguided or only partially functioning) protection
mechanism doesn't introduce but removes a failure point.
And I don't think removal and addition of a failure point usually have
the same consequences. Introducing a new failure point will often mean
userspace quickly detects regressions. Such regressions are pretty
common due to security fixes we introduce. Recent examples include [1].
Right after this was merged the regression was reported.

But when allowing behavior that used to fail like ETXTBSY it can be
difficult for userspace to detect such regressions. The reason for that
is quite often that userspace applications don't tend to do something
that they know upfront will fail. Attackers however might.

[1]: bfb819ea20ce ("proc: Check /proc/$pid/attr/ writes against file opener")

Christian
