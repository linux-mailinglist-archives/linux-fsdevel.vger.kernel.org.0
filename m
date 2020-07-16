Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B912F221DAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 09:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgGPHwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 03:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPHwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:52:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13512C061755;
        Thu, 16 Jul 2020 00:52:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so3511749pls.5;
        Thu, 16 Jul 2020 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=baJTdoZqDBf4tcP+bX9BF80BsB7j/ysNPPJ0o9FHYxQ=;
        b=BVWePAiJYAquYjy18acL+Ux+fs7pyGlx7rMAo9wbwCm5YE/bg7SZn7vBnfQlJCZAZy
         u2sry427JooJKpVhb8/siYZkUZZAvcqf/lH3hAooGv2l/YzxKmTHwkAg5s8AkZ+Cx2gb
         ZUh+oCAe2B6+6TlU6S3qnhczw5cruAurEsyPrnczpR0ULw3jd48cbGq0sZB/lQ1m/lK2
         PdCtEeipHw7iIlPAo0isYmtZVIsUI92JaiHLtdmRf6scw8PPG67fxtwVeD6Rh0gmbS8z
         TlevBGHK4Scg93vOdi+75maJ4i/8RWU94aHZPzXdTN/rv5qSAYeKhBcu2KudMVVfZAKB
         EmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=baJTdoZqDBf4tcP+bX9BF80BsB7j/ysNPPJ0o9FHYxQ=;
        b=lsiM47Mao3dUZC+i8A6nvNlh2Q5/ev6uTWwEpxYBVCWxDLdfdG0rZPP0/kcgCEKX8W
         nBuqJWsJba+zO7BD63KVXZ9ynosRwBztieYc1pV1WA2RCUZMGaREqzZi2XC0yxbPV/e7
         oAgAbCzHuTYqWYTbtcJV9Cfju/b/KUL5TTbisSrwhwrgZG93AdnXzr/FNxf5rtz7t0IW
         8Dk9pRkWo53QWcNiMEgWajFU4wD2+/+2iU8QqZu8A4oFUoiAXsyO6b58bXSshtdI773r
         ei/3gIgn65ymgIh7GIye2dQDV/g3LYxRmvnXJeKI07BT+NoLOLsTT8EATAH/40wJoMC9
         H2XQ==
X-Gm-Message-State: AOAM5304HiNi98tSU2tfyh0PibvxVy3NhZZZibmMBYpwWby6KuEcigLq
        4yzAcx8NQM4k0sUm/Y5Njjs=
X-Google-Smtp-Source: ABdhPJyJuoK+m/pvVMwkBRiJD+rQvB5ytA2qSLBGBBk03AqjnQCuOSPpZ0LJsaemJvWvLYFodB3hZg==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr2746751pln.16.1594885950324;
        Thu, 16 Jul 2020 00:52:30 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id q7sm4165282pfn.23.2020.07.16.00.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 00:52:29 -0700 (PDT)
Date:   Thu, 16 Jul 2020 17:52:24 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: KCSAN: data-race in generic_file_buffered_read /
 generic_file_buffered_read
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     akpm@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        Marco Elver <elver@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot <syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Will Deacon <will@kernel.org>
References: <0000000000004a4d6505aa7c688a@google.com>
        <20200715152912.GA2209203@elver.google.com>
        <20200715163256.GB1167@sol.localdomain>
        <20200715234203.GK5369@dread.disaster.area>
        <20200716030357.GE1167@sol.localdomain>
        <1594880070.49b50i0a1p.astroid@bobo.none>
        <20200716065454.GI1167@sol.localdomain>
In-Reply-To: <20200716065454.GI1167@sol.localdomain>
MIME-Version: 1.0
Message-Id: <1594884557.u5rf1h2p6r.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Eric Biggers's message of July 16, 2020 4:54 pm:
> On Thu, Jul 16, 2020 at 04:24:01PM +1000, Nicholas Piggin wrote:
>> Excerpts from Eric Biggers's message of July 16, 2020 1:03 pm:
>> > On Thu, Jul 16, 2020 at 09:42:03AM +1000, Dave Chinner wrote:
>> >> On Wed, Jul 15, 2020 at 09:32:56AM -0700, Eric Biggers wrote:
>> >> > [+Cc linux-fsdevel]
>> >> >=20
>> >> > On Wed, Jul 15, 2020 at 05:29:12PM +0200, 'Marco Elver' via syzkall=
er-bugs wrote:
>> >> > > On Wed, Jul 15, 2020 at 08:16AM -0700, syzbot wrote:
>> >> > > > Hello,
>> >> > > >=20
>> >> > > > syzbot found the following issue on:
>> >> > > >=20
>> >> > > > HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.=
kernel.org/..
>> >> > > > git tree:       upstream
>> >> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D121=
7a83b100000
>> >> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D570=
eb530a65cd98e
>> >> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0f1e4=
70df6a4316e0a11
>> >> > > > compiler:       clang version 11.0.0 (https://github.com/llvm/l=
lvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
>> >> > > >=20
>> >> > > > Unfortunately, I don't have any reproducer for this issue yet.
>> >> > > >=20
>> >> > > > IMPORTANT: if you fix the issue, please add the following tag t=
o the commit:
>> >> > > > Reported-by: syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.=
com
>> >> > > >=20
>> >> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > > > BUG: KCSAN: data-race in generic_file_buffered_read / generic_f=
ile_buffered_read
>> >> > >=20
>> >> > > Our guess is that this is either misuse of an API from userspace,=
 or a
>> >> > > bug. Can someone clarify?
>> >> > >=20
>> >> > > Below are the snippets of code around these accesses.
>> >> >=20
>> >> > Concurrent reads on the same file descriptor are allowed.  Not with=
 sys_read(),
>> >> > as that implicitly uses the file position.  But it's allowed with s=
ys_pread(),
>> >> > and also with sys_sendfile() which is the case syzbot is reporting =
here.
>> >>=20
>> >> Concurrent read()s are fine, they'll just read from the same offset.
>> >>=20
>> >=20
>> > Actually the VFS serializes concurrent read()'s on the same fd, at lea=
st for
>> > regular files.
>>=20
>> Hmm, where?
>=20
> It's serialized by file->f_pos_lock.  See fdget_pos().

Ah thanks! Missed that.

>> >> > > > write to 0xffff8880968747b0 of 8 bytes by task 6336 on cpu 0:
>> >> > > >  generic_file_buffered_read+0x18be/0x19e0 mm/filemap.c:2246
>> >> > >=20
>> >> > > 	...
>> >> > > 	would_block:
>> >> > > 		error =3D -EAGAIN;
>> >> > > 	out:
>> >> > > 		ra->prev_pos =3D prev_index;
>> >> > > 		ra->prev_pos <<=3D PAGE_SHIFT;
>> >> > > 2246)		ra->prev_pos |=3D prev_offset;
>> >> > >=20
>> >> > > 		*ppos =3D ((loff_t)index << PAGE_SHIFT) + offset;
>> >> > > 		file_accessed(filp);
>> >> > > 		return written ? written : error;
>> >> > > 	}
>> >> > > 	EXPORT_SYMBOL_GPL(generic_file_buffered_read);
>> >> > > 	...
>> >> >=20
>> >> > Well, it's a data race.  Each open file descriptor has just one rea=
dahead state
>> >> > (struct file_ra_state), and concurrent reads of the same file descr=
iptor
>> >> > use/change that readahead state without any locking.
>> >> >=20
>> >> > Presumably this has traditionally been considered okay, since reada=
head is
>> >> > "only" for performance and doesn't affect correctness.  And for per=
formance
>> >> > reasons, we want to avoid locking during file reads.
>> >> >=20
>> >> > So we may just need to annotate all access to file_ra_state with
>> >> > READ_ONCE() and WRITE_ONCE()...
>> >>=20
>> >> Please, no. Can we stop making the code hard to read, more difficult
>> >> to maintain and preventing the compiler from optimising it by doing
>> >> stupid "turn off naive static checker warnings" stuff like this?
>> >>=20
>> >> If the code is fine with races, then -leave it alone-. If it's not
>> >> fine with a data race, then please go and work out the correct
>> >> ordering and place well documented barriers and/or release/acquire
>> >> ordering semantics in the code so that we do not need to hide data
>> >> races behind a compiler optimisation defeating macro....
>> >>=20
>> >> Yes, I know data_race() exists to tell the tooling that it should
>> >> ignore data races in the expression, but that makes just as much
>> >> mess of the code as READ_ONCE/WRITE_ONCE being spewed everywhere
>> >> indiscriminately because <some tool said we need to do that>.
>> >>=20
>> >=20
>> > Data races are undefined behavior, so it's never guaranteed "fine".
>>=20
>> Is this a new requirement for the kernel? Even code which is purely an=20
>> optimisation (e.g. a readahead heuristic) can never be guaranteed to
>> be fine for a data race? As in, the compiler might be free to start
>> scribbling on memory because of undefined behaviour?
>>=20
>> What we used to be able to do is assume that the variable might take on=20
>> one or other value at any time its used (or even see split between the
>> two if the thing wasn't naturally aligned for example), but that was=20
>> quite well "defined". So we could in fact guarantee that it would be=20
>> fine.
>=20
> Not really, it's always been undefined behavior.
>=20
> AFAICT, there's tribal knowledge among some kernel developers about what =
types
> of undefined behavior are "okay" because they're thought to be unlikely t=
o cause
> problems in practice.  However except in certain cases (e.g., the kernel =
uses
> -fwrapv to make signed integer overflow well-defined, and -fno-strict-ali=
asing
> to make type aliasing well-defined) these cases have never been formally
> defined, and people disagree about them.  If they have actually been form=
ally
> defined, please point me to the documentation or compiler options.

Well we did traditionally say stores to natural aligned word types and
smaller were atomic (although being loff_t may not be true for 32-bit).
Kernel behaviour, rather than C (which as you say is not kernel=20
semantics).

>=20
> Data races in particular are tricky because there are a lot of ways for t=
hings
> to go wrong that people fail to think of; for some examples see:
> https://www.usenix.org/legacy/event/hotpar11/tech/final_files/Boehm.pdf
> https://software.intel.com/content/www/us/en/develop/blogs/benign-data-ra=
ces-what-could-possibly-go-wrong.html

If we abandon that and go with always explicit accessors okay. But none=20
of those are things that surprise the kernel model except this one

"So if a program stores to a variable X, the compiler can legally reuse=20
X=E2=80=99s storage for any temporal data inside of some region of code bef=
ore=20
the store (e.g. to reduce stack frame size)."

Which is wrong and we'd never tolerate it in the kernel. We don't just
race with other threads but also our interrupts. preempt_enable()
called somewhere can't allow the compiler to enable preemption by
spilling zero to preempt_count in code before the call, for example.

So that would be disabled exactly the same as other insanity.

The only argument really is for race checkers.

>=20
>> > We can only
>> > attempt to conclude that it's fine "in practice" and is too difficult =
to fix,
>> > and therefore doesn't meet the bar to be fixed (for now).
>> >=20
>> > Of course, in most cases the preferred solution for data races is to i=
ntroduce
>> > proper synchronization.  As I said, I'm not sure that's feasible here.=
  Memory
>> > barriers aren't the issue here; we'd need *locking*, which would mean =
concurrent
>> > readers would start contending for the lock.  Other suggestions apprec=
iated...
>>=20
>>=20
>>  		ra->prev_pos =3D prev_index;
>>  		ra->prev_pos <<=3D PAGE_SHIFT;
>>  2246)		ra->prev_pos |=3D prev_offset;
>>=20
>>=20
>> In this case we can do better I guess, in case some compiler decides to=20
>> store a half-done calculation there because it ran out of registers.
>>=20
>> WRITE_ONCE(ra->prev_pos, ((loff_t)prev_index << PAGE_SHIFT) | prev_offse=
t);
>>=20
>> As Dave said, adding WRITE_ONCE to the individual accesses would be=20
>> stupid because it does nothing to solve the actual race and makes it=20
>> harder to read in more than one way.
>=20
> Yes, obviously if we were to add READ/WRITE_ONCE we'd want to avoid stori=
ng
> intermediate results like that, in order to avoid some obvious race condi=
tions.

Well the suggestion was to just simply add READ/WRITE once to all=20
accesses, not to fix them up. That would actually add more race
conditions.

> However, the overall use of file_ra_state is still racy.  And it's passed=
 to the
> functions in mm/readahead.c like page_cache_async_readahead() too, so all=
 the
> accesses to it in those functions are data races too.
>=20
> I'm not really suggesting any specific solution; locking isn't really fea=
sible
> here, and there would be an annoyingly large number of places that would =
need
> READ/WRITE_ONCE.

If you put behind some accessor functions it might become easier,
but...

> I just wish we had a better plan than "let's write some code with
> undefined behavior and hope it's okay".

It really isn't so undefined as you think. Again, we enforce against
insane compilers de facto if not written anywhere with our interrupt
races. So we really can guarantee it'll be okay.

Thanks,
Nick
