Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B263650456
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 19:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiLRSa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 13:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiLRSaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:30:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152CBE00;
        Sun, 18 Dec 2022 10:14:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 549EE60DCF;
        Sun, 18 Dec 2022 18:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D55C433D2;
        Sun, 18 Dec 2022 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671387280;
        bh=h+5T1W0dbq0VrSbd0eXpFWwkbNKlv3NdepKrKO5N/X0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDZAnqBL5dRU+C4AocCXG0LJs6s88+o21A2CzVvHw+R8n7Fmpt6ZGmdstE1vmQw9P
         8U3dPmsC71VtH7QUIiUXr9Nb0svpp5Uk1vmBbKG32Svd6gd0oT6NihbWJox8n9aAVS
         eRhJVXaFjr1iLMtV7+e0vp/g5pwOoWcJ+5DIeD89vr2JDgiPCG7tvSAyAO7aMdSYgC
         HQdSYvM5iRudseuUhGYp2y7mwCpEkEOBMpH64zXu/GNxtXYd/U7dPnl2tiPyUConzn
         CMLAr+PZNkPRb6D8wfkRg+kD4991YFMRfNTRiLXm7BBd3fYsIasuE9lyplsA0zdk6P
         pYTb7xXp+zU0g==
Date:   Sun, 18 Dec 2022 10:14:40 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: Why fstests g/673 and g/683~687 suddently fail (on xfs, ext4...)
 on latest linux v6.1+ ?
Message-ID: <Y59YkDch8b6v/KfD@magnolia>
References: <20221218103850.cbqdq3bmw7zl7iad@zlang-mailbox>
 <CAOQ4uxhmCgyorYVtD6=n=khqwUc=MPbZs+y=sqt09XbGoNm_tA@mail.gmail.com>
 <20221218130432.fgitgsn522shmpwi@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218130432.fgitgsn522shmpwi@zlang-mailbox>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 18, 2022 at 09:04:32PM +0800, Zorro Lang wrote:
> On Sun, Dec 18, 2022 at 02:11:01PM +0200, Amir Goldstein wrote:
> > On Sun, Dec 18, 2022 at 1:06 PM Zorro Lang <zlang@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > fstests generic/673 and generic/683~687 are a series of test cases to
> > > verify suid and sgid bits are dropped properly. xfs-list writes these
> > > cases to verify xfs behavior follows vfs, e.g. [1]. And these cases
> > > test passed on xfs and ext4 for long time. Even on my last regression
> > > test on linux v6.1-rc8+, they were passed too.
> > >
> > > But now the default behavior looks like be changed again, xfs and ext4
> > > start to fail [2] on latest linux v6.1+ (HEAD [0]), So there must be
> > > changed. I'd like to make sure what's changed, and if it's expected?
> > 
> > I think that is expected and I assume Christian was planning to fix the tests.
> > 
> > See Christian's pull request:
> > https://lore.kernel.org/linux-fsdevel/20221212112053.99208-1-brauner@kernel.org/
> > 
> > "Note, that some xfstests will now fail as these patches will cause the setgid
> > bit to be lost in certain conditions for unprivileged users modifying a setgid
> > file when they would've been kept otherwise. I think this risk is worth taking
> > and I explained and mentioned this multiple times on the list:
> > https://lore.kernel.org/linux-fsdevel/20221122142010.zchf2jz2oymx55qi@wittgenstein"
> 
> Hi Amir,
> 
> Thanks for your reply. Yes, these test cases were failed on overlayfs, passed on
> xfs, ext4 and btrfs. Now it's reversed, overlayfs passed on this test, xfs and
> ext4 failed.

Odd, I'll have to look into why things work here ... maybe it's the
selinux contexts?

> Anyway, if this's an expected behavior change, and it's reviewed and accepted by
> linux upstream, I don't have objection. Just to make sure if there's a regression.
> Feel free to send patch to fstests@ to update the expected results, and show
> details about why change them again :)

Somewhat unrelated, but are you going to merge
https://lore.kernel.org/fstests/20220816121551.88407-1-glass@fydeos.io/

?

--D

> Thanks,
> Zorro
> 
> > 
> > Thanks,
> > Amir.
> > 
> > >
> > > Thanks,
> > > Zorro
> > >
> > > [0]
> > > commit f9ff5644bcc04221bae56f922122f2b7f5d24d62
> > > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > Date:   Sat Dec 17 08:55:19 2022 -0600
> > >
> > >     Merge tag 'hsi-for-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-h
> > >
> > > [1]
> > > commit e014f37db1a2d109afa750042ac4d69cf3e3d88e
> > > Author: Darrick J. Wong <djwong@kernel.org>
> > > Date:   Tue Mar 8 10:51:16 2022 -0800
> > >
> > >     xfs: use setattr_copy to set vfs inode attributes
> > >
> > > [2]
> > > FSTYP         -- xfs (debug)
> > > PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
> > > MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
> > > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR
> > >
> > > generic/673       - output mismatch (see /var/lib/xfstests/results//generic/673.out.bad)
> > >     --- tests/generic/673.out   2022-12-17 13:57:40.336589178 -0500
> > >     +++ /var/lib/xfstests/results//generic/673.out.bad  2022-12-18 00:00:53.627210256 -0500
> > >     @@ -51,7 +51,7 @@
> > >      310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > >      2666 -rw-rwSrw- SCRATCH_MNT/a
> > >      3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> > >     -2666 -rw-rwSrw- SCRATCH_MNT/a
> > >     +666 -rw-rw-rw- SCRATCH_MNT/a
> > >
> > >      Test 10 - qa_user, group-exec file, only sgid
> > >     ...
> > >     (Run 'diff -u /var/lib/xfstests/tests/generic/673.out /var/lib/xfstests/results//generic/673.out.bad'  to see the entire diff)
> > > Ran: generic/673
> > > Failures: generic/673
> > > Failed 1 of 1 tests
> > >
> > > FSTYP         -- xfs (debug)
> > > PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
> > > MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
> > > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR
> > >
> > > generic/683       - output mismatch (see /var/lib/xfstests/results//generic/683.out.bad)
> > >     --- tests/generic/683.out   2022-12-17 13:57:40.696589178 -0500
> > >     +++ /var/lib/xfstests/results//generic/683.out.bad  2022-12-18 00:04:55.297220255 -0500
> > >     @@ -33,7 +33,7 @@
> > >
> > >      Test 9 - qa_user, non-exec file falloc, only sgid
> > >      2666 -rw-rwSrw- TEST_DIR/683/a
> > >     -2666 -rw-rwSrw- TEST_DIR/683/a
> > >     +666 -rw-rw-rw- TEST_DIR/683/a
> > >
> > >      Test 10 - qa_user, group-exec file falloc, only sgid
> > >     ...
> > >     (Run 'diff -u /var/lib/xfstests/tests/generic/683.out /var/lib/xfstests/results//generic/683.out.bad'  to see the entire diff)
> > > Ran: generic/683
> > > Failures: generic/683
> > > Failed 1 of 1 tests
> > >
> > > FSTYP         -- xfs (debug)
> > > PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
> > > MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
> > > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR
> > >
> > > generic/684       - output mismatch (see /var/lib/xfstests/results//generic/684.out.bad)
> > >     --- tests/generic/684.out   2022-12-17 13:57:40.766589178 -0500
> > >     +++ /var/lib/xfstests/results//generic/684.out.bad  2022-12-18 00:05:27.597220255 -0500
> > >     @@ -33,7 +33,7 @@
> > >
> > >      Test 9 - qa_user, non-exec file fpunch, only sgid
> > >      2666 -rw-rwSrw- TEST_DIR/684/a
> > >     -2666 -rw-rwSrw- TEST_DIR/684/a
> > >     +666 -rw-rw-rw- TEST_DIR/684/a
> > >
> > >      Test 10 - qa_user, group-exec file fpunch, only sgid
> > >     ...
> > >     (Run 'diff -u /var/lib/xfstests/tests/generic/684.out /var/lib/xfstests/results//generic/684.out.bad'  to see the entire diff)
> > > Ran: generic/684
> > > Failures: generic/684
> > > Failed 1 of 1 tests
> > > ....
> > > ....
> > >
> > >
> > > Thanks,
> > > Zorro
> > >
> > 
> 
