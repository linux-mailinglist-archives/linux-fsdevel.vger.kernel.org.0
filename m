Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BBA6CB919
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 10:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjC1IMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjC1IMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FACB9;
        Tue, 28 Mar 2023 01:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 395F26142A;
        Tue, 28 Mar 2023 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2FAC433EF;
        Tue, 28 Mar 2023 08:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679991152;
        bh=LRbbuqQU+btfYJj1KNTECuQb0OM2ThLCdkzOsTTMfxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFpXOElTeh0AJN8Pay1PgL31riPt0MN3OFDAmThnCTftu1pz+kU2DRlYgjRGFC4pe
         XaVvq2W+SXCKzkC/V67/Sg0pSrqt7fiponAjVhJ4P2KBKft8eTr1RsiLzj11f1lXfN
         QCHJKLoGvKtfV3BcKSFFyMEdxAFG2ZxIsQubgI/USb+Grshw0Pv16uGJTtisAXeL9b
         NhETZPq06ddr+ZDkl8MONDzqxak5MZ31gOnjHaCLHIjOdauUJwNED3I0YBg4B1jpxH
         OgFYtXn9fGuo64OIohTvpfrvJAMlu/TSrup/E/5GUMxKQnGmqjvN0wj2n07KAmsMJz
         ZHkE8Esr6CZCA==
Date:   Tue, 28 Mar 2023 10:12:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
Message-ID: <20230328081227.keyadx3gdymr7fzf@wittgenstein>
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
 <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
 <20230321142413.6mlowi5u6ewecodx@wittgenstein>
 <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
 <CAKbZUD1N-jsrro_9ix12vNmjL0iUqqvicCv7MHyj19O5LJs1aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbZUD1N-jsrro_9ix12vNmjL0iUqqvicCv7MHyj19O5LJs1aQ@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,WEIRD_QUOTING autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 09:13:18PM +0100, Pedro Falcato wrote:
> On Tue, Mar 21, 2023 at 4:17 PM Christian Brauner <brauner@kernel.org> wrote:
> > It would be very nice if we had tests for the new behavior. So if @Pedro
> > would be up for it that would be highly appreciated. If not I'll put it
> > on my ToDo...
> 
> Where do you want them? selftests? I have a relatively self-contained
> ""testsuite"" of namei stuff that could fit in there well, after some
> cleanup.

I think I would prefer to have them as part of xfstests:
https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

as that's where nearly all of the fs testing is taking place. It's never
great when developers have to run 3 separate testsuites to get
meaningful coverage. So having it central to xfstests would be my
preference.

A while ago I added a testsuite that tests generic core VFS behavior
it's located under src/vfs:
https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/vfs

and covers a lot of different things. So I would ask you to consider
adding a new testsuite into that file:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/vfs/vfstest.c

I think the structure should be somewhat understandable. Then create a
new test in xfstests using the "new" helper in the generic sectionA

> ./new generic
Next test id is 728
Append a name to the ID? Test name will be 728-$name. y,[n]:
Creating test file '728'
Add to group(s) [auto] (separate by space, ? for list): auto quick
Creating skeletal script for you to edit ...

then call the vfstest binary from the generated test case:

echo "Silence is golden"

$here/src/vfs/vfstest --test-THAT-NEW-SWITCH-NAME-YOU-ADDED --device "$TEST_DEV" \
        --mount "$TEST_DIR" --fstype "$FSTYP"

status=$?
exit

(You can also submit this to LTP or tell them about this change and
they'll likely add tests in addition to xfstests.)

> 
> > The expectation often is that this particular combination would create
> > and open a directory. This suggests users who tried to use that
> > combination would stumble upon the counterintuitive behavior no matter
> > if pre-v5.7 or post v5.7 and quickly realize neither semantics give them
> > what they want. For some examples see the code examples in [1] to [3]
> > and the discussion in [4].
> 
> Ok so, silly question: Could it not be desirable to have these
> semantics (open a dir or mkdir, atomically)?
> It does seem to be why POSIX left this edge case implementation
> defined, and if folks are asking for it, could it be the right move?
> 
> And yes, I do understand (from reading the room) that no one here is
> too excited about this possibility.

Forgive me for being lazy and instead of repeating everything I'll just
leave a link to the other part of the thread
https://lore.kernel.org/lkml/20230328075735.d3rs27jjvarmn6dw@wittgenstein
