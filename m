Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004433F226C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 23:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhHSVnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 17:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhHSVny (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:43:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B86860EB5;
        Thu, 19 Aug 2021 21:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629409397;
        bh=Qis+W6zkQTZYe1xg6ZIKtAmEgvOKVtPfN5JHB97wMwQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YTUn0yw6nUpw51PPvGczp49OOM+H1/c0m9xuwthLJuMkJqgdjYyHhxg8yOVhLoMhp
         VQ+kOA2nK3nhlvsSZkMrnAmapLGmZO5D9b5U+9pjr0wEXPLMr89NHRfDOeTICElwOR
         UDLw9ONtcKXd+UOZ+28FEdQmSXsWLjD6eQtInZHGtle5q5vbJScMkDjxRegKOnVTsA
         DzTXn6ZIpdre07HZcF0GF/Cg/1+MxL9XJ4erYKgPyBE7EJV0zvxUGYBus1fbx8iV+b
         29BaTatgVsRYZK0KFkT7pKy3feYPjYRPQBD3IfHS/hePE0iNlBCAfro/UuzVtKP44L
         vA+TnCI/ui3iA==
Message-ID: <639d90212662cf5cdf80c71bbfec95907c70114a.camel@kernel.org>
Subject: Re: Removing Mandatory Locks
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        David Hildenbrand <david@redhat.com>,
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
Date:   Thu, 19 Aug 2021 17:43:12 -0400
In-Reply-To: <CAHk-=wgD-SNxB=2iCurEoP=RjrciRgLtXZ7R_DejK+mXF2etfg@mail.gmail.com>
References: <20210812084348.6521-1-david@redhat.com>
         <87o8a2d0wf.fsf@disp2133>
         <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
         <87lf56bllc.fsf@disp2133>
         <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
         <87eeay8pqx.fsf@disp2133>
         <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
         <87h7ft2j68.fsf@disp2133>
         <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
         <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
         <YRcyqbpVqwwq3P6n@casper.infradead.org> <87k0kkxbjn.fsf_-_@disp2133>
         <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
         <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
         <a1385746582a675c410aca4eb4947320faec4821.camel@kernel.org>
         <CAHk-=wgD-SNxB=2iCurEoP=RjrciRgLtXZ7R_DejK+mXF2etfg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-08-19 at 13:31 -0700, Linus Torvalds wrote:
> On Thu, Aug 19, 2021 at 1:18 PM Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > Now that I think about it a little more, I actually did get one
> > complaint a few years ago:
> > 
> > Someone had upgraded from an earlier distro that supported the -o mand
> > mount option to a later one that had disabled it, and they had an (old)
> > fstab entry that specified it.
> 
> Hmm. We might be able to turn the "return -EINVAL" into just a warning.
> 
> Yes, yes, currently if you turn off CONFIG_MANDATORY_FILE_LOCKING, we
> already do that
> 
>         VFS: "mand" mount option not supported
> 
> warning print, but then we fail the mount.
> 
> If CONFIG_MANDATORY_FILE_LOCKING goes away entirely, it might make
> sense to turn that warning into something bigger, but then let the
> mount continue - since now that "mand" flag would be purely a legacy
> thing.
> 
> And yes, if we do that, we'd want the warning to be a big ugly thing,
> just to make people very aware of it happening. Right now it's a
> one-liner that is easy to miss, and the "oh, the mount failed" is the
> thing that hopefully informs people about the fact that they need to
> enable CONFIG_MANDATORY_FILE_LOCKING.
> 
> The logic being that if you can no longer enable mandatory locking in
> the kernel, the current hard failure seems overly aggressive (and
> might cause boot failures and inability to fix/report things when it
> possibly keeps you from using the system at all).
> 

What sort of big, ugly warning did you have in mind?

I'm fine with that general approach though and will plan to roll that
change into the patch I'm testing.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

