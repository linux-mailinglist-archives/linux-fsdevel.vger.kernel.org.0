Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122CD3F217C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 22:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhHSUTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 16:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhHSUTV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:19:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44918610D2;
        Thu, 19 Aug 2021 20:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629404324;
        bh=KOZeEQ6+e5vmt7Bs8g0Kbr0+54TTcsuZ0T/h9pwZyM8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y0no770OomjNFKB035BfRxjOBa/7l57z8/67cAYgKi9iEIilRwEA1+MpReyNUBE2g
         5K74KeGOo72rKpjlb8I5kwPM/rJtNeru9AbzDGva5VpHOWJz3+GFglKge5ZXRxMFJO
         FzXuaTZ05YyY+nzLVR2FfqKPFWs+46609wU7EK6AWDQakrwORkMEcjKRym6Xy8B47S
         FN/YGXAIoEU7NOyw1WMzXKaqMEUXzlDGECiK0k5nOkIXI7t1uSi2QOYb+4+AbAli9U
         nza8j1aClMWkrZPs2goP6EyoM4qH5A9zWanMR3kfyksw/Y9DUXBFUF1qUS2reHecSE
         90fjuIrO52COg==
Message-ID: <a1385746582a675c410aca4eb4947320faec4821.camel@kernel.org>
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
Date:   Thu, 19 Aug 2021 16:18:38 -0400
In-Reply-To: <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
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
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-08-19 at 12:15 -0700, Linus Torvalds wrote:
> On Thu, Aug 19, 2021 at 11:39 AM Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > I'm all for ripping it out too. It's an insane interface anyway.
> > 
> > I've not heard a single complaint about this being turned off in
> > fedora/rhel or any other distro that has this disabled.
> 
> I'd love to remove it, we could absolutely test it. The fact that
> several major distros have it disabled makes me think it's fine.
> 
> But as always, it would be good to check Android.
> 
> The desktop distros tend to have the same tools and programs, so if
> Fedora and RHEL haven't needed it for years, then it's likely stale in
> Debian too (despite being enabled).
> 
> But Android tends to be very different. Does anybody know?
> 

Now that I think about it a little more, I actually did get one
complaint a few years ago:

Someone had upgraded from an earlier distro that supported the -o mand
mount option to a later one that had disabled it, and they had an (old)
fstab entry that specified it. They didn't actually use mandatory
locking and weren't sure why the option was set, so they removed it and
moved on.

I would feel a lot better about it if we had gotten Debian to turn it
off several years ago too, but I agree it's unlikely anyone uses this
and the risk of removing it is low.

I've spun up a patch to just rip it out. I'll do a bit of testing with
it tomorrow and then send it out.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

