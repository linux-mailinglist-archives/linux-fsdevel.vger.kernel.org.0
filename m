Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA233F2075
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhHSTS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhHSTS5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:18:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D15E6056B;
        Thu, 19 Aug 2021 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629400701;
        bh=RucYjuroxGmQst2JfSDCLfzdBGUla3ujUHowg41WDyE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CohXTWkzJotiOQmeVmG65jGjNWkRibbytLNpU+bQ91W5vlKqoCp6Mv0QgrfeF+v3X
         NIkEPiyLxbPyEiIbUjDIfAix7Z8AfRFOp8FzHRzPJ/1ks56kn/ez5YUSaywrIBqu9p
         ibMFdjvbtfTbgHOOUkf8HON9BkXYFIFjsMXK+3sZln2yD305IUV8ayXQvdW0ViyGV+
         Knn+U1QyVeDn8xMkbwR6EjWAXOCgI7eoh0WzwAMQzcf6pArOA3bxk5w3kF/2JMsmRW
         YT/ZZ7iNU1vf/9dmA3tdJzQDyvTdlJiqL+NzekA5CcHK+iopv5wIMajwfE1r7sRcfb
         MCupGyEyaqTTQ==
Message-ID: <8ba92aa3e97bfc3df89cd64fffcbc91b640530f1.camel@kernel.org>
Subject: Re: Removing Mandatory Locks
From:   Jeff Layton <jlayton@kernel.org>
To:     Rodrigo Campos <rodrigo@kinvolk.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Date:   Thu, 19 Aug 2021 15:18:15 -0400
In-Reply-To: <CACaBj2ZgrA2JeeGenXxEf5ha6OYaFrj2=iuVXnQxC=kZLZpjng@mail.gmail.com>
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
         <CACaBj2ZgrA2JeeGenXxEf5ha6OYaFrj2=iuVXnQxC=kZLZpjng@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-08-18 at 11:34 +0200, Rodrigo Campos wrote:
> On Tue, Aug 17, 2021 at 6:49 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > 
> > Matthew Wilcox <willy@infradead.org> writes:
> > 
> > > On Fri, Aug 13, 2021 at 05:49:19PM -0700, Andy Lutomirski wrote:
> > > > [0] we have mandatory locks, too. Sigh.
> > > 
> > > I'd love to remove that.  Perhaps we could try persuading more of the
> > > distros to disable the CONFIG option first.
> > 
> > Yes.  The support is disabled in RHEL8.
> 
> If it helps, it seems to be enabled on the just released debian stable:
>     $ grep CONFIG_MANDATORY_FILE_LOCKING /boot/config-5.10.0-8-amd64
>     CONFIG_MANDATORY_FILE_LOCKING=y
> 
> Also the new 5.13 kernel in experimental has it too:
>     $ grep CONFIG_MANDATORY_FILE_LOCKING /boot/config-5.13.0-trunk-amd64
>     CONFIG_MANDATORY_FILE_LOCKING=y

A pity. It would have been nice if they had turned it off a while ago. I
guess I should have done more outreach at the time. Sigh...

In any case, I'm still inclined toward just ripping it out at this
point. It's hard to believe that anyone really uses it.
-- 
Jeff Layton <jlayton@kernel.org>

