Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371857AD6E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 13:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjIYLXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 07:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjIYLXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:23:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D1FC6;
        Mon, 25 Sep 2023 04:22:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FA5C433C8;
        Mon, 25 Sep 2023 11:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695640978;
        bh=MHMoUXxCYhs9BmNGGcDEbJP+pWNEoaNn0qeePsIe17M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lP36I1bnv4AX491FT9KTa9La35GasogBHW+NGwO33yno8eI0bTRA5ARV2fhzi3dI6
         8KxyTiohjjcx82uGB9zABMEgo6SRdbB1t891FvIlmnW3myAdm+R52fUGQ/jk4ppHSF
         c69rla/+lM8Y5nYTdqy6ZNBCVf1bnNB7v/ptUenI2eTiyT+MW3/MB9UVMCk+MJaG3g
         JOJNHzXAQ/jO/bCffN3juJriV8nTz403tPxsqXi2IjoXzDcI42rok0vkit3NzEB/P8
         uA38bNvtLH73fEkS2+17c7dPo9yH2+dn+C2Obosc3FUxHfH5Zg3BrKlOPAk3RYWcw/
         BXGxqDMuuAs6g==
Message-ID: <9ee3b65480b227102c04272d2219f366c65a14f3.camel@kernel.org>
Subject: Re: [GIT PULL v2] timestamp fixes
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Date:   Mon, 25 Sep 2023 07:22:56 -0400
In-Reply-To: <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
         <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
         <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
         <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
         <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
         <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        MONEY_NOHTML,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-09-23 at 10:48 -0700, Linus Torvalds wrote:
> On Fri, 22 Sept 2023 at 23:36, Amir Goldstein <amir73il@gmail.com> wrote:
> >=20
> > Apparently, they are willing to handle the "year 2486" issue ;)
>=20
> Well, we could certainly do the same at the VFS layer.
>=20
> But I suspect 10ns resolution is entirely overkill, since on a lot of
> platforms you don't even have timers with that resolution.
>=20
> I feel like 100ns is a much more reasonable resolution, and is quite
> close to a single system call (think "one thousand cycles at 10GHz").
>=20
> > But the resolution change is counter to the purpose of multigrain
> > timestamps - if two syscalls updated the same or two different inodes
> > within a 100ns tick, apparently, there are some workloads that
> > care to know about it and fs needs to store this information persistent=
ly.
>=20
> Those workloads are broken garbage, and we should *not* use that kind
> of sh*t to decide on VFS internals.
>=20
> Honestly, if the main reason for the multigrain resolution is
> something like that, I think we should forget about MG *entirely*.
> Somebody needs to be told to get their act together.
>=20

As I noted in the other thread, the primary reason for this was to fix
XFS's change cookie without having to rev the on-disk format. If we
could also present fine-grained timestamps to userland and nfsd, then
that would also fix a lot of cache-coherency problems with NFSv3, and
may also help some workloads which depend on comparing timestamps
between files. That'd be a wonderful bonus, but I'm not going to lose
too much sleep if we can't make that work.


> We have *never* guaranteed nanosecond resolution on timestamps, and I
> think we should put our foot down and say that we never will.
>
> Partly because we have platforms where that kind of timer resolution
> just does not exist.
>=20
> Partly because it's stupid to expect that kind of resolution anyway.
>=20
> And partly because any load that assumes that kind of resolution is
> already broken.
>
> End result: we should ABSOLUTELY NOT have as a target to support some
> insane resolution.
>=20
> 100ns resolution for file access times is - and I'll happily go down
> in history for saying this - enough for anybody.
>=20
> If you need finer resolution than that, you'd better do it yourself in
> user space.
>=20
> And no, this is not a "but some day we'll have terahertz CPU's and
> 100ns is an eternity". Moore's law is dead, we're not going to see
> terahertz CPUs, and people who say "but quantum" have bought into a
> technological fairytale.
>=20
> 100ns is plenty, and has the advantage of having a very safe range.
>=20

The catch here is that we have at least some testcases that do things
like set specific values in the mtime and atime, and then test that the
same value is retrievable.

Are we OK with breaking those? If we can always say that the stored
resolution is X and that even values that are explicitly set get
truncated then the v8 set I sent on Friday may be ok.

Of course, that set truncates the values at jiffies granularity (~4ms on
my box). That's well above 100ns, so it's possible that's too coarse for
us to handwave this problem away.


> That said, we don't have to do powers-of-ten. In fact, in many ways,
> it would probably be a good idea to think of the fractional seconds in
> powers of two. That tends to make it cheaper to do conversions,
> without having to do a full 64-bit divide (a constant divide turns
> into a fancy multiply, but it's still painful on 32-bit
> architectures).
>=20
> So, for example, we could easily make the format be a fixed-point
> format with "sign bit, 38 bit seconds, 25 bit fractional seconds",
> which gives us about 30ns resolution, and a range of almost 9000
> years. Which is nice, in how it covers all of written history and all
> four-digit years (we'd keep the 1970 base).
>=20
> And 30ns resolution really *is* pretty much the limit of a single
> system call. I could *wish* we had system calls that fast, or CPU's
> that fast. Not the case right now, and sadly doesn't seem to be the
> case in the forseeable future - if ever - either. It would be a really
> good problem to have.
>=20
> And the nice thing about that would be that conversion to timespec64
> would be fairly straightforward:
>=20
>    struct timespec64 to_timespec(fstime_t fstime)
>    {
>         struct timespec64 res;
>         unsigned int frac;
>=20
>         frac =3D fstime & 0x1ffffffu;
>         res.tv_sec =3D fstime >> 25;
>         res.tv_nsec =3D frac * 1000000000ull >> 25;
>         return res;
>    }
>=20
>    fstime_t to_fstime(struct timespec64 a)
>    {
>         fstime_t sec =3D (fstime_t) a.tv_sec << 25;
>         unsigned frac =3D a.tv_nsec;
>=20
>         frac =3D ((unsigned long long) a.tv_nsec << 25) / 1000000000ull;
>         return sec | frac;
>    }
>=20
> and both of those generate good code (that large divide by a constant
> in to_fstime() is not great, but the compiler can turn it into a
> multiply).
>=20
> The above could be improved upon (nicer rounding and overflow
> handling, and a few modifications to generate even nicer code), but
> it's not horrendous as-is. On x86-64, to_timespec becomes a very
> reasonable
>=20
>         movq    %rdi, %rax
>         andl    $33554431, %edi
>         imulq   $1000000000, %rdi, %rdx
>         sarq    $25, %rax
>         shrq    $25, %rdx
>=20
> and to some degree that's the critical function (that code would show
> up in 'stat()').
>=20
> Of course, I might have screwed up the above conversion functions,
> they are untested garbage, but they look close enough to being in the
> right ballpark.
>=20
> Anyway, we really need to push back at any crazies who say "I want
> nanosecond resolution, because I'm special and my mother said so".
>=20


Yeah if we we're going to establish a floor granularity for timestamps
above 1ns, then making it a power-of-two factor would probably be a good
thing. These calculations are done a _lot_ so we really do want them to
be efficient.
--=20
Jeff Layton <jlayton@kernel.org>
