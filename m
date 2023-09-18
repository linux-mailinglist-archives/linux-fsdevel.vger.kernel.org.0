Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ACF7A5489
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 22:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjIRU42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 16:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIRU41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:56:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1147B10D;
        Mon, 18 Sep 2023 13:56:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23884C433C8;
        Mon, 18 Sep 2023 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695070581;
        bh=L6kH7I7vxTcEdxUEzJG0/gQjECizpvaLfH5gelE6giY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hD0k645DVxr+hYslCpXAQcfYQVp4F3bQrBwXCMMpESZ8qnbxZdaEPxL9pbFfIvzR3
         PEMPtLdbSWqZwklElcwcHRueYpeuZtOaWyyIxzMjpdo894w743aVmnOd50VRZ49za8
         rVrTHF4e6Cu+iXb16rW6iTYb+ZQojQovuOfwYyihR5hi3wAZu1j2/k2KAKC9PapY/2
         7avlqHrKhSe51s/69OOvH5wJsKqyxWTPap5Er7vU44+pPaKmW+axfPgb1niyYKcLHf
         LXJPOVcxEGx+EhjVw5msncwyQlB8jFALHQHjW8fcGPGaaFlvpnNZMd3pEkKtRCvCPp
         jyhpzTjgEhSqA==
Message-ID: <2020b8dfd062afb41cd8b74f1a41e61de0684d3f.camel@kernel.org>
Subject: Re: [GIT PULL] timestamp fixes
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Sep 2023 16:56:19 -0400
In-Reply-To: <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com>
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
         <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
         <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
         <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com>
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

On Mon, 2023-09-18 at 13:18 -0700, Linus Torvalds wrote:
> On Mon, 18 Sept 2023 at 12:39, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > In general, we always update the atime with a coarse-grained timestamp,
> > since atime and ctime updates are never done together during normal rea=
d
> > and write operations. As you note, things are a little more murky with
> > utimes() updates but I think we should be safe to overwrite the atime
> > with a coarse-grained timestamp unconditionally.
>=20
> I do think utimes() ends up always overwriting, but that's a different
> code-path entirely (ie it goes through the ->setattr() logic, not this
> inode_update_timestamps() code).
>=20
> So I *think* that even with your patch, doing a "touch" would end up
> doing the right thing - it would update atime even if it was in the
> future before.
>=20
> But doing a plain "read()" would break, and not update atime.
>=20
> That said, I didn't actually ever *test* any of this, so this is
> purely from reading the patch, and I can easily have missed something.
>=20

No, you're quite right. That's exactly what would have happened.

> Anyway, I do think that the timespec64_equal() tests are a bit iffy in
> fs/inode.c now, since the timespecs that are being tested might be of
> different precision.
>=20
> So I do think there's a *problem* here, I just do not believe that
> doing that timespec64_equal() -> timespec64_compare() is at all the
> right thing to do.
>=20
> My *gut* feel is that in both cases, we have this
>=20
>         if (timespec64_equal(&inode->i_atime, &now))
>=20
> and the problem is that *sometimes* 'now' is the coarse time, but
> sometimes it's the fine-grained one, and so checking for equality is
> simply nonsensical.
>=20
> I get the feeling that that timespec64_equal() logic for those atime
> updates should be something like
>=20
>  - if 'now' is in the future, we always considering it different, and
> update the time
>=20
>  - if 'now' is further in the past than the coarse granularity, we
> also update the time ("clearly not equal")
>=20
>  - but if 'now' is in the past, but within the coarse time
> granularity, we consider it equal and do not update anything
>=20
> but it's not like I have really given this a huge amount of thought.
> It's just that "don't update if in the past" that I am pretty sure can
> *not* be right.
>=20
>=20

I think the atime problem is solved by just dropping the patch I
mentioned before. The atime is updated for read operations and the
m/ctime for write. You only get a fine-grained timestamp when updating
the ctime, so for an atime update we always use a coarse timestamp. It
should never roll backward. [1]

We may have a problem with the ctime update though, since you pointed it
out. We have this in inode_set_ctime_current(), in the codepath where
the QUERIED bit isn't set:

                /*
                 * If we've recently updated with a fine-grained timestamp,
                 * then the coarse-grained one may still be earlier than th=
e
                 * existing ctime. Just keep the existing value if so.
                 */
                ctime.tv_sec =3D inode->__i_ctime.tv_sec;
                if (timespec64_compare(&ctime, &now) > 0)
                        return ctime;

The ctime can't be set via utimes(), so that's not an issue here, but we
could get a realtime clock jump backward that causes this to not be
updated like it should be.

I think (like you suggest above) that this needs some bounds-checking
where we make sure that the current coarse grained time isn't more than
around 1-2 jiffies earlier than the existing ctime. If it is, then we'll
go ahead and just update it anyway.

Thoughts?
--=20
Jeff Layton <jlayton@kernel.org>


[1]: You _could_ do a write and then a read against a file, and end up
with an atime that looks to be earlier than the ctime, even though you
know that they were done in the other order. I'm operating under the
assumption that this isn't a problem we need to worry about.

