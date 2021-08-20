Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EFA3F2C8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 14:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbhHTMzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 08:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240401AbhHTMzj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:55:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB3A06101A;
        Fri, 20 Aug 2021 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629464101;
        bh=aq47G7FYdzVG9JI5vCW3JdtF0Ql8JGW7+wEYumNG7w0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a/FYE+XmpmUrhaskDVfwprhmXpSwMty4yUBq+SXncTVPNUlIvLIBnmvTnWwggz9iG
         s4ammRLDPZdPLd+dw89KRsm4iB6PdovqHvDvOdqKIjmTHY99DXaSADQHXb0vFVv0NH
         qXD0p0atBEqht2kLinJGRlJKZ/MrgRaGAJgnTlAQ/jSgEcJ/PTrnQ6GV02RwKSuSK6
         ILPjLo6meDN5gtLC9cJgPFJgUvkYx794rjcRseD+sl8cASPtV9InoEjVyYoecgTGo2
         Wg3NKtlbNwAEJ6Rxi9E4kJkoHo1P0utsc5wzjT5paKCoOPAXUQci/3UKhb/Ql3/VoZ
         wXJZ5nNwc5veg==
Message-ID: <6b9e9485846c01d57f53adc35ddd0bfe42398eca.camel@kernel.org>
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
Date:   Fri, 20 Aug 2021 08:54:55 -0400
In-Reply-To: <20210819143348.GA21090@fieldses.org>
References: <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
         <87lf56bllc.fsf@disp2133>
         <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
         <87eeay8pqx.fsf@disp2133>
         <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
         <87h7ft2j68.fsf@disp2133>
         <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
         <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
         <20210818154217.GB24115@fieldses.org> <87bl5tv8pn.fsf@disp2133>
         <20210819143348.GA21090@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-08-19 at 10:33 -0400, J. Bruce Fields wrote:
> On Thu, Aug 19, 2021 at 08:56:52AM -0500, Eric W. Biederman wrote:
> > bfields@fieldses.org (J. Bruce Fields) writes:
> > 
> > > On Fri, Aug 13, 2021 at 05:49:19PM -0700, Andy Lutomirski wrote:
> > > > I’ll bite.  How about we attack this in the opposite direction: remove
> > > > the deny write mechanism entirely.
> > > 
> > > For what it's worth, Windows has open flags that allow denying read or
> > > write opens.  They also made their way into the NFSv4 protocol, but
> > > knfsd enforces them only against other NFSv4 clients.  Last I checked,
> > > Samba attempted to emulate them using flock (and there's a comment to
> > > that effect on the flock syscall in fs/locks.c).  I don't know what Wine
> > > does.
> > > 
> > > Pavel Shilovsky posted flags adding O_DENY* flags years ago:
> > > 
> > > 	https://lwn.net/Articles/581005/
> > > 
> > > I keep thinking I should look back at those some day but will probably
> > > never get to it.
> > > 
> > > I've no idea how Windows applications use them, though I'm told it's
> > > common.
> > 
> > I don't know in any detail.  I just have this memory of not being able
> > to open or do anything with a file on windows while any application has
> > it open.
> > 
> > We limit mandatory locks to filesystems that have the proper mount flag
> > and files that are sgid but are not executable.  Reusing that limit we
> > could probably allow such a behavior in Linux without causing chaos.
> 
> I'm pretty confused about how we're using the term "mandatory locking".
> 
> The locks you're thinking of are basically ordinary posix byte-range
> locks which we attempt to enforce as mandatory under certain conditions
> (e.g. in fs/read_write.c:rw_verify_area).  That means we have to check
> them on ordinary reads and writes, which is a pain in the butt.  (And we
> don't manage to do it correctly--the code just checks for the existence
> of a conflicting lock before performing IO, ignoring the obvious
> time-of-check/time-of-use race.)
> 

Yeah, the locks we're talking about are the locks described in:

    Documentation/filesystems/mandatory-locking.rst

They've always been racy. You have to mount the fs with '-o mand' and
set a special mode on the file (setgid bit set, with group execute bit
cleared). It's a crazypants interface.

> This has nothing to do with Windows share locks which from what I
> understand are whole-file locks that are only enforced against opens.
> 

Yep. Those are different.

Confusingly, there is also LOCK_MAND|LOCK_READ|LOCK_WRITE for flock(),
which are purported to be for emulating Windows share modes. They aren't
really mandatory though.

> --b.
> 
> > Without being very strict about which files can participate I can just
> > imagine someone hiding their presence by not allowing other applications
> > the ability to write to utmp or a log file.
> > 
> > In the windows world where everything evolved with those kinds of
> > restrictions it is probably fine (although super annoying).
> > 
> > Eric

-- 
Jeff Layton <jlayton@kernel.org>

