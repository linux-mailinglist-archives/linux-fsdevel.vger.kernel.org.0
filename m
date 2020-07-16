Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91469221C91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 08:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgGPGYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 02:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGPGYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:24:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AFBC061755;
        Wed, 15 Jul 2020 23:24:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 207so3209699pfu.3;
        Wed, 15 Jul 2020 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=RVf+nZWX+91+dteQBQwe8rFE2LN3RLK87/mLuBjVmYA=;
        b=h+DIx6SlQ0p4epVcvakt+XdBEBG3eS28pIKn606BO8yd7Zf3gaG7TIZIP6D6CITxNW
         3ixOcXQyCSmk5dgjJaFUoANu+qwViGTvLKshSHcjlw9C4DnQ/NCC+ixJTuJcpRMd76WY
         jPmHRpPFqYkQyEQtGsuut74SBBrwrtQ0MyrLGwyFxhjajMVbEbbqVHlAMWk0xIeYGyco
         i68M4maXzFL+UgAGOodxywfrETXmGFXhFQtyFnx18+BFXWb0eRB0VowWj/mzESgpAHqn
         eGqbDY6ytIPzCsJeLmLfNy/vfc5JbgY4gaqMraLit2KMa2RTlYi6HS+3n3X5ngF+cZgQ
         3pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=RVf+nZWX+91+dteQBQwe8rFE2LN3RLK87/mLuBjVmYA=;
        b=VOFzlH/kCR5bhg+ilncUvPfhEHXReKmp7u85zMqG6mvsT3gAcD/e9c3JVaiRZrysFg
         od+PjkVUXAiDLwUfl30ridOKI2vTeb+ufTpnnO9LJtMsFTN9uFNjk1t3S7ZR8Ypub4rX
         Uzyiy+B+6D1kZTY2hgLuPZyuj/U64p2YZuRqyYUWVQ4tPajNhJ1C1HGiw/S6Hcj0lbOk
         AQXkfzLCD5WTvFH94J3gCsxQfqoeMlzo296dhGWTo60Ltt9xugKSjN0fTew/Q1MXdw2Q
         ERPom/m9OcjZ+tJIaBY2rDGktv3ErccFZeATnf3ePdLTXKoQkZpAzq+tLvpwMj/DM3FT
         fIIA==
X-Gm-Message-State: AOAM533swyzsKPWCMVCZ4jsSWsr6NRu0fPeQVukfzEtaWQz+OFsSAwPx
        M+w5iKpKSliam3R/BroySMc=
X-Google-Smtp-Source: ABdhPJy8SHnN4hG7z//QwWsCRWGE/2K8Qc7x+LUk6kXbTBodNFFWLKqzBou2ptxC0O2bMDD7+PITgg==
X-Received: by 2002:a63:1a08:: with SMTP id a8mr2973419pga.39.1594880647192;
        Wed, 15 Jul 2020 23:24:07 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id q24sm3859410pgg.3.2020.07.15.23.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:24:06 -0700 (PDT)
Date:   Thu, 16 Jul 2020 16:24:01 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: KCSAN: data-race in generic_file_buffered_read /
 generic_file_buffered_read
To:     Dave Chinner <david@fromorbit.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     akpm@linux-foundation.org, Marco Elver <elver@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot <syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Will Deacon <will@kernel.org>
References: <0000000000004a4d6505aa7c688a@google.com>
        <20200715152912.GA2209203@elver.google.com>
        <20200715163256.GB1167@sol.localdomain>
        <20200715234203.GK5369@dread.disaster.area>
        <20200716030357.GE1167@sol.localdomain>
In-Reply-To: <20200716030357.GE1167@sol.localdomain>
MIME-Version: 1.0
Message-Id: <1594880070.49b50i0a1p.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Eric Biggers's message of July 16, 2020 1:03 pm:
> On Thu, Jul 16, 2020 at 09:42:03AM +1000, Dave Chinner wrote:
>> On Wed, Jul 15, 2020 at 09:32:56AM -0700, Eric Biggers wrote:
>> > [+Cc linux-fsdevel]
>> >=20
>> > On Wed, Jul 15, 2020 at 05:29:12PM +0200, 'Marco Elver' via syzkaller-=
bugs wrote:
>> > > On Wed, Jul 15, 2020 at 08:16AM -0700, syzbot wrote:
>> > > > Hello,
>> > > >=20
>> > > > syzbot found the following issue on:
>> > > >=20
>> > > > HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.ker=
nel.org/..
>> > > > git tree:       upstream
>> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1217a8=
3b100000
>> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D570eb5=
30a65cd98e
>> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0f1e470d=
f6a4316e0a11
>> > > > compiler:       clang version 11.0.0 (https://github.com/llvm/llvm=
-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
>> > > >=20
>> > > > Unfortunately, I don't have any reproducer for this issue yet.
>> > > >=20
>> > > > IMPORTANT: if you fix the issue, please add the following tag to t=
he commit:
>> > > > Reported-by: syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com
>> > > >=20
>> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > > BUG: KCSAN: data-race in generic_file_buffered_read / generic_file=
_buffered_read
>> > >=20
>> > > Our guess is that this is either misuse of an API from userspace, or=
 a
>> > > bug. Can someone clarify?
>> > >=20
>> > > Below are the snippets of code around these accesses.
>> >=20
>> > Concurrent reads on the same file descriptor are allowed.  Not with sy=
s_read(),
>> > as that implicitly uses the file position.  But it's allowed with sys_=
pread(),
>> > and also with sys_sendfile() which is the case syzbot is reporting her=
e.
>>=20
>> Concurrent read()s are fine, they'll just read from the same offset.
>>=20
>=20
> Actually the VFS serializes concurrent read()'s on the same fd, at least =
for
> regular files.

Hmm, where?

> Anyway, doesn't matter since we can consider pread() instead.
>=20
>>=20
>> >=20
>> > >=20
>> > > > write to 0xffff8880968747b0 of 8 bytes by task 6336 on cpu 0:
>> > > >  generic_file_buffered_read+0x18be/0x19e0 mm/filemap.c:2246
>> > >=20
>> > > 	...
>> > > 	would_block:
>> > > 		error =3D -EAGAIN;
>> > > 	out:
>> > > 		ra->prev_pos =3D prev_index;
>> > > 		ra->prev_pos <<=3D PAGE_SHIFT;
>> > > 2246)		ra->prev_pos |=3D prev_offset;
>> > >=20
>> > > 		*ppos =3D ((loff_t)index << PAGE_SHIFT) + offset;
>> > > 		file_accessed(filp);
>> > > 		return written ? written : error;
>> > > 	}
>> > > 	EXPORT_SYMBOL_GPL(generic_file_buffered_read);
>> > > 	...
>> >=20
>> > Well, it's a data race.  Each open file descriptor has just one readah=
ead state
>> > (struct file_ra_state), and concurrent reads of the same file descript=
or
>> > use/change that readahead state without any locking.
>> >=20
>> > Presumably this has traditionally been considered okay, since readahea=
d is
>> > "only" for performance and doesn't affect correctness.  And for perfor=
mance
>> > reasons, we want to avoid locking during file reads.
>> >=20
>> > So we may just need to annotate all access to file_ra_state with
>> > READ_ONCE() and WRITE_ONCE()...
>>=20
>> Please, no. Can we stop making the code hard to read, more difficult
>> to maintain and preventing the compiler from optimising it by doing
>> stupid "turn off naive static checker warnings" stuff like this?
>>=20
>> If the code is fine with races, then -leave it alone-. If it's not
>> fine with a data race, then please go and work out the correct
>> ordering and place well documented barriers and/or release/acquire
>> ordering semantics in the code so that we do not need to hide data
>> races behind a compiler optimisation defeating macro....
>>=20
>> Yes, I know data_race() exists to tell the tooling that it should
>> ignore data races in the expression, but that makes just as much
>> mess of the code as READ_ONCE/WRITE_ONCE being spewed everywhere
>> indiscriminately because <some tool said we need to do that>.
>>=20
>=20
> Data races are undefined behavior, so it's never guaranteed "fine".

Is this a new requirement for the kernel? Even code which is purely an=20
optimisation (e.g. a readahead heuristic) can never be guaranteed to
be fine for a data race? As in, the compiler might be free to start
scribbling on memory because of undefined behaviour?

What we used to be able to do is assume that the variable might take on=20
one or other value at any time its used (or even see split between the
two if the thing wasn't naturally aligned for example), but that was=20
quite well "defined". So we could in fact guarantee that it would be=20
fine.

> We can only
> attempt to conclude that it's fine "in practice" and is too difficult to =
fix,
> and therefore doesn't meet the bar to be fixed (for now).
>=20
> Of course, in most cases the preferred solution for data races is to intr=
oduce
> proper synchronization.  As I said, I'm not sure that's feasible here.  M=
emory
> barriers aren't the issue here; we'd need *locking*, which would mean con=
current
> readers would start contending for the lock.  Other suggestions appreciat=
ed...


 		ra->prev_pos =3D prev_index;
 		ra->prev_pos <<=3D PAGE_SHIFT;
 2246)		ra->prev_pos |=3D prev_offset;


In this case we can do better I guess, in case some compiler decides to=20
store a half-done calculation there because it ran out of registers.

WRITE_ONCE(ra->prev_pos, ((loff_t)prev_index << PAGE_SHIFT) | prev_offset);

As Dave said, adding WRITE_ONCE to the individual accesses would be=20
stupid because it does nothing to solve the actual race and makes it=20
harder to read in more than one way.

Thanks,
Nick
