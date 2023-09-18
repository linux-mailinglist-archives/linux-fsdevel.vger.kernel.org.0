Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE0F7A532D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 21:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjIRTjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 15:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIRTjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:39:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91731101;
        Mon, 18 Sep 2023 12:39:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13B6C433C9;
        Mon, 18 Sep 2023 19:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695065981;
        bh=hR/nLlP8z29UKnEn3m5fjx9kJXqIXzhgNBoFQGa+RFo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IQfVRv7jHDsn4cdMac4PvP2FVTTYv8ZRlbnK3UvnbA+lIGAfWaFw5N2aB/0GoZspF
         a8z5wOhp5uLxQLqyG7jzj3YiKe342Cz8fpJVv37j4D7YT/vtdSZcv0QtObuGbgAYo5
         RmRXzzSC71HXN5PkIgqJ50uRIlIGxWjSaaLXPMGSp4Kqj/H96L9JAcWB478G43zFTS
         aiI/41M9M88gpQjqp45WPPhBCGz0WkuYPr5F/SvwthF9FQWIkUYW7CBIWe24+FAHtw
         O8noAbCM7XCdhLe30I1q5e6MTV86JXtKOZYGXjgfv+hrZYs5w1EUEvy9ZhyEw8rsa+
         Ga0LAePE+n/+w==
Message-ID: <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
Subject: Re: [GIT PULL] timestamp fixes
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Sep 2023 15:39:39 -0400
In-Reply-To: <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
         <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
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

On Mon, 2023-09-18 at 11:24 -0700, Linus Torvalds wrote:
> On Mon, 18 Sept 2023 at 04:54, Christian Brauner <brauner@kernel.org> wro=
te:
> >=20
> > * Only update the atime if "now" is later than the current value. This
> >   can happen when the atime gets updated with a fine-grained timestamp
> >   and then later gets updated using a coarse-grained timestamp.
>=20
> I pulled this, and then I unpulled it again.
>=20
> I think this is fundamentally wrong.
>=20
> If somebody has set the time into the future (for whatever reason -
> maybe the clocks were wrong at some point), afaik accessing a file
> should reset it, and very much used to do that.
>=20
> Am I missing something? Because this really seems *horribly* broken garba=
ge.
>=20
> Any "go from fine-grained back to coarse-grained" situation needs to
> explicitly test *that* case.
>=20
> Not some kind of completely broken "don't update to past value" like this=
.
>=20

Fair point.=A0 Now that I've considered it some more, I think that commit
7df48e7d99a4 (fs: don't update the atime if existing atime is newer than
"now") is not necessary.

What prompted this was a bug report from the kernel test robot that
showed the atime going backward on a STRICTATIME LTP test, but I think
the root cause of that was the missing ctime initialization after
allocation that we fixed in 0a22d3ff61b7 (fs: initialize
inode->__i_ctime to the epoch).

In general, we always update the atime with a coarse-grained timestamp,
since atime and ctime updates are never done together during normal read
and write operations. As you note, things are a little more murky with
utimes() updates but I think we should be safe to overwrite the atime
with a coarse-grained timestamp unconditionally.

We should be able to just drop that patch from the series. Whether you
want to pull the rest now or wait for a bit, I'll leave up to you and
Christian to decide.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
