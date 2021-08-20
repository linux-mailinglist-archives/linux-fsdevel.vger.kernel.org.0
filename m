Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B403B3F2CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 15:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbhHTNEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 09:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240375AbhHTNEB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CE066101A;
        Fri, 20 Aug 2021 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629464603;
        bh=vpNTkAzVtAqymBqf9jS7V0ipLd6rQmU/JReC+oGFdAc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dcmDtzTWNKoJjA2+EvxNaxCDTp6LXJ+l4+Nxo5lPDGZVYmdo6z25/cf8Y52TQoPeg
         /OaGgxa6731NwYc2cBjOqjtBOmVtx9qTOjvEdyD/niq3e2rM8DmLpQWpD0F15jfOGa
         aRSKZKt37z+SvrwWc2DbPhpw2GOD6fZwGW2OrSeyc+kNck5EaM5u+Cz0RYLeSE8V8u
         5Fb/hprjZ09rwsUTRawi7poo+XS03wfXu5Go4jg8Ms4bZFM+m/MxekI54ydGbKfSaB
         2w4QT70SWxhJKE3D8F7+dtojw9i/oBolVHciomvz6JXltJUbDo73S1fmcmOsvUCYJa
         gmPSD4WulbnYQ==
Message-ID: <765d446cc4190575ab400a3a8038db658196b4bf.camel@kernel.org>
Subject: Re: Removing Mandatory Locks
From:   Jeff Layton <jlayton@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
Date:   Fri, 20 Aug 2021 09:03:16 -0400
In-Reply-To: <20210820123810.GE22171@1wt.eu>
References: <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
         <YRcyqbpVqwwq3P6n@casper.infradead.org> <87k0kkxbjn.fsf_-_@disp2133>
         <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
         <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
         <a1385746582a675c410aca4eb4947320faec4821.camel@kernel.org>
         <CAHk-=wgD-SNxB=2iCurEoP=RjrciRgLtXZ7R_DejK+mXF2etfg@mail.gmail.com>
         <CAOQ4uxhwcdH1t3WVBdmeyDmvWkQLCgOAWoVZGoCKChppXBNqNA@mail.gmail.com>
         <CAOQ4uxiZXwaT9gJJweGx1kXR=y7y+cY5uUUV_CHyEeSJ6vJ0Cg@mail.gmail.com>
         <c4d6adfaae81f71341acd1c6b7b20c2e459a142f.camel@kernel.org>
         <20210820123810.GE22171@1wt.eu>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-08-20 at 14:38 +0200, Willy Tarreau wrote:
> On Fri, Aug 20, 2021 at 08:27:12AM -0400, Jeff Layton wrote:
> > I'm fine with any of these approaches if the consensus is that it's too
> > risky to just remove it. OTOH, I've yet to ever hear of any application
> > that uses this feature, even in a historical sense.
> 
> Honestly, I agree. Some have fun of me because I'm often using old
> stuff, but I don't even remember having used an application that
> made use of mandatory locking. I remember having enabled it myself in
> my kernels long ago after discovering its existence in the man pages,
> just to test it. It doesn't rule out the possibility that it exists
> somewhere though, but I think that the immediate removal combined
> with the big fat warning in previous branches should be largely
> enough to avoid the last minute surprise.
> 

Good point. It wouldn't hurt to push such a warning into stable kernels
at the same time. There always is a lag when we do something like this
before some downstream user notices.
-- 
Jeff Layton <jlayton@kernel.org>

