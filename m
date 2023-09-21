Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078D77A9B59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjIUS61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjIUS6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:58:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C9897C3;
        Thu, 21 Sep 2023 11:51:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E72C433C8;
        Thu, 21 Sep 2023 18:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695322315;
        bh=MjEQXRnyykk3f+hE0AdC9BNxbWYC3YZL7JXWVjB6uXg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rG9rpLr3oZNEKtAptEta2PNN+Dai42WSwt3484Rf3cZR+AG9xUGY0AVamEDuEoyC0
         6l+w4C7KujAKCkGxsV6dOlibIQJM295WdUc2P3yxKPIX0Xc8ikAJPgHPI9RomtikGY
         E9G5jp1KEDA1ADB8Uah+YLDf6MQAm2gHIg1XLbPfc2YebzGaThS76pkA4b2N/uWkoy
         sLAgI5VRoNKS/OmZsPfPR2fsBmW0kjWisCGYFJH3nWMnypvqRvvh3M8TFT5gqjLjFH
         G2iXdeIMr2GNbZb6q7AISuJI9LCfTihbLoFO2c/F5RcYRluRLvoiguYzucyZIoSbMX
         Xh9PtHfejeLKg==
Message-ID: <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
Subject: Re: [GIT PULL v2] timestamp fixes
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Date:   Thu, 21 Sep 2023 14:51:53 -0400
In-Reply-To: <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
         <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-09-21 at 11:24 -0700, Linus Torvalds wrote:
> On Thu, 21 Sept 2023 at 04:21, Christian Brauner <brauner@kernel.org> wro=
te:
> >=20
> >   git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc=
3.vfs.ctime.revert
>=20
> So for some reason pr-tracker-bot doesn't seem to have reacted to this
> pull request, but it's in my tree now.
>=20
> I *do* have one reaction to all of this: now that you have made
> "i_ctime" be something that cannot be accessed directly (and renamed
> it to "__i_ctime"), would you mind horribly going all the way, and do
> the same for i_atime and i_mtime too?
>=20
> The reason I ask is that I *really* despise "struct timespec64" as a type=
.
>=20
> I despise it inherently, but I despise it even more when you really
> use it as another type entirely, and are hiding bits in there.
>=20
> I despise it because "tv_sec" obviously needs to be 64-bit, but then
> "tv_nsec" is this horrible abomination. It's defined as "long", which
> is all kinds of crazy. It's bogus and historical.
>=20
> And it's wasteful.
>=20
> Now, in the case of i_ctime, you took advantage of that waste by using
> one (of the potentially 2..34!) unused bits for that
> "fine-granularity" flag.
>=20
> But even when you do that, there's up to 33 other bits just lying
> around, wasting space in a very central data structure.
>=20
> So it would actually be much better to explode the 'struct timespec64'
> into explicit 64-bit seconds field, and an explicit 32-bit field with
> two bits reserved. And not even next to each other, because they don't
> pack well in general.
>=20
> So instead of
>=20
>         struct timespec64       i_atime;
>         struct timespec64       i_mtime;
>         struct timespec64       __i_ctime;
>=20
> where that last one needs accessors to access, just make them *all*
> have helper accessors, and make it be
>=20
>         u64  i_atime_sec;
>         u64  i_mtime_sec;
>         u64  i_ctime_sec;
>         u32  i_atime_nsec;
>         u32  i_mtime_nsec;
>         u32  i_ctime_nsec;
>=20
> and now that 'struct inode' should shrink by 12 bytes.
>=20

I like it.

> Then do this:
>=20
>   #define inode_time(x) \
>        (struct timespec64) { x##_sec, x##_nsec }
>=20
> and you can now create a timespec64 by just doing
>=20
>     inode_time(inode->i_atime)
>=20
> or something like that (to help create those accessor functions).
>=20
> Now, I agree that 12 bytes in the disaster that is 'struct inode' is
> likely a drop in the ocean. We have tons of big things in there (ie
> several list_heads, a whole 'struct address_space' etc etc), so it's
> only twelve bytes out of hundreds.
>=20
> But dammit, that 'timespec64' really is ugly, and now that you're
> hiding bits in it and it's no longer *really* a 'timespec64', I feel
> like it would be better to do it right, and not mis-use a type that
> has other semantics, and has other problems.
>=20


We have many, many inodes though, and 12 bytes per adds up!

I'm on board with the idea, but...that's likely to be as big a patch
series as the ctime overhaul was. In fact, it'll touch a lot of the same
code. I can take a stab at that in the near future though.

Since we're on the subject...another thing that bothers me with all of
the timestamp handling is that we don't currently try to mitigate "torn
reads" across the two different words. It seems like you could fetch a
tv_sec value and then get a tv_nsec value that represents an entirely
different timestamp if there are stores between them.

Should we be concerned about this? I suppose we could do something with
a seqlock, though I'd really want to avoid locking on the write side.=20
--=20
Jeff Layton <jlayton@kernel.org>
