Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA833F3AAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Aug 2021 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhHUMqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Aug 2021 08:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhHUMqj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Aug 2021 08:46:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26DB461222;
        Sat, 21 Aug 2021 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629549960;
        bh=BWRBpnQrNoRcs319+vTr8OUV7hK/02HoruNC5g/r9g8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fa7ZeHuGl+4XP1WpEyzmi5hufYrREjDgNdRg4U3s/96SFCEqdGYDGUtBnHEuVeQqG
         15E2/qqommNNVF93RIEDLEQP4hibseJYGAbILdAXC/LwejAZfgBOGT6SdESXBfYcDN
         cd7+Xd17PsJ2c9mp9buI/usXYtVu6bkO7afSWz4635iAHyaAYKSzDM3WPhavCSsRv0
         ClTsJRXKpG8hsODsdUHQ/aV4CV1rhOspJM2fWX2hRqBJCYHxYAYyp8at738ytBtNYE
         0IToQvyCx1mwLtuRTjN4k+vGA4g035zp2YTFthSWuCdKxQhCRB0nph9IOGgywfzekG
         j3T7MrokxJRCg==
Message-ID: <18b073b95d692f4c7782c68de1f803681c15a467.camel@kernel.org>
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
Date:   Sat, 21 Aug 2021 08:45:54 -0400
In-Reply-To: <8a6737f9fa2dd3b8b9d851064cd28ca57e489a77.camel@kernel.org>
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
         <8a6737f9fa2dd3b8b9d851064cd28ca57e489a77.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-08-20 at 17:29 -0400, Jeff Layton wrote:
> No, Windows has deny-mode locking at open time, but the kernel's
> mandatory locks are enforced during read/write (which is why they are
> such a pain). Samba will not miss these at all.
> 
> If we want something to provide windows-like semantics, we'd probably
> want to start with something like Pavel Shilovsky's O_DENY_* patches.
> 
> -- Jeff
> 

Doh! It completely slipped my mind about byte-range locks on windows...

Those are mandatory and they do block read and write activity to the
ranges locked. They have weird semantics vs. POSIX locks (they stack
instead of splitting/merging, etc.).

Samba emulates these with (advisory) POSIX locks in most cases. Using
mandatory locks is probably possible, but I think it would add more
potential for deadlock and security issues.
-- 
Jeff Layton <jlayton@kernel.org>

