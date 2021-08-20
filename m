Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA73F3607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 23:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhHTVaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 17:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231761AbhHTVaO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:30:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DDF461102;
        Fri, 20 Aug 2021 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629494976;
        bh=CSpxkRr0njJFwn1bNyK1M/lOW65Uuk1c0JklPI8xo7w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=paHJbV4aD+5TZGOJ6zZf6GRISmKjaaMLmZ5WgIftKEepMQlOUns10X8IPDExdOOjN
         M/+2s9X8hIT0bzVhH2fJEWiuiA3DReUbBZJoMKhaDOClD3nTHIWlYB3Z64nnt3IhjL
         Qhyaur14Ly1nMotZUaNZOApgaDumSL5frA7f9XxVB79HQOiVXHYr7NQQccH4YDlqrf
         pCmUTnDPPVkixLdijZ31QqSe4oSUdYj8fOH7Z0pokJ7Kbt2XwdSi/ylF1dTttV1iS0
         eVX16h4vU8/pa8yUqM7lcwkLKoy6p1J7oOXmydwT/haVOnxxqpZGiI5kpbF4jOXCLq
         SEYYNJYbWsn5w==
Message-ID: <8a6737f9fa2dd3b8b9d851064cd28ca57e489a77.camel@kernel.org>
Subject: Re: Removing Mandatory Locks
From:   Jeff Layton <jlayton@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Christian =?ISO-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Fri, 20 Aug 2021 17:29:30 -0400
In-Reply-To: <D2325492-F4DD-4E7A-B4F1-0E595FF2469A@zytor.com>
References: <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
         <87eeay8pqx.fsf@disp2133>
         <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
         <87h7ft2j68.fsf@disp2133>
         <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
         <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
         <YRcyqbpVqwwq3P6n@casper.infradead.org> <87k0kkxbjn.fsf_-_@disp2133>
         <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
         <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
         <202108200905.BE8AF7C@keescook>
         <D2325492-F4DD-4E7A-B4F1-0E595FF2469A@zytor.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No, Windows has deny-mode locking at open time, but the kernel's
mandatory locks are enforced during read/write (which is why they are
such a pain). Samba will not miss these at all.

If we want something to provide windows-like semantics, we'd probably
want to start with something like Pavel Shilovsky's O_DENY_* patches.

-- Jeff

On Fri, 2021-08-20 at 12:17 -0700, H. Peter Anvin wrote:
> I thought the main user was Samba and/or otherwise providing file service for M$ systems?
> 
> On August 20, 2021 9:30:31 AM PDT, Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Aug 19, 2021 at 12:15:08PM -0700, Linus Torvalds wrote:
> > > On Thu, Aug 19, 2021 at 11:39 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > > 
> > > > I'm all for ripping it out too. It's an insane interface anyway.
> > > > 
> > > > I've not heard a single complaint about this being turned off in
> > > > fedora/rhel or any other distro that has this disabled.
> > > 
> > > I'd love to remove it, we could absolutely test it. The fact that
> > > several major distros have it disabled makes me think it's fine.
> > 
> > FWIW, it is now disabled in Ubuntu too:
> > 
> > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/impish/commit/?h=master-next&id=f3aac5e47789cbeb3177a14d3d2a06575249e14b
> > 
> > > But as always, it would be good to check Android.
> > 
> > It looks like it's enabled (checking the Pixel 4 kernel image), but it's
> > not specifically mentioned in any of the build configs that are used to
> > construct the image, so I think this is just catching the "default y". I
> > expect it'd be fine to turn this off.
> > 
> > I will ask around to see if it's actually used.
> > 
> 

-- 
Jeff Layton <jlayton@kernel.org>

