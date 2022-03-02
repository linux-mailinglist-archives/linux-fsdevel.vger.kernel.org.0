Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51CC4CB1B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 23:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbiCBWFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 17:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243239AbiCBWFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:05:34 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDBCC992C;
        Wed,  2 Mar 2022 14:04:50 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1534C4B53; Wed,  2 Mar 2022 17:04:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1534C4B53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1646258690;
        bh=sFotR+Tg2pgJDac6v/deUSJGviNPIwykEumSIEAJ4Yc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=tiXoQO/RhzwwfCLvswRmulD8ntpRPROc4H+e1j4SAJMCwzuRgRWT2pJdPXwhQCaji
         +MBPDhNkK35cDRJpA2Jvk3IcBv4+Fbviq7gQ7/a7ryl9YMvt5f0jMdD2MTRx3vUulp
         mXNDK0PiNko7oYZC60s+E86q2qC/BXhjVAUZnDqY=
Date:   Wed, 2 Mar 2022 17:04:50 -0500
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: nfs generic/373 failure after "fs: allow cross-vfsmount
 reflink/dedupe"
Message-ID: <20220302220450.GD10757@fieldses.org>
References: <20220301184221.371853-1-amir73il@gmail.com>
 <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
 <20220302082658.GF3927073@dread.disaster.area>
 <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
 <20220302211226.GG3927073@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302211226.GG3927073@dread.disaster.area>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I started seeing generic/373 fail on recent linux-next in NFS testing.

Bisect lands it on aaf40970b1d0 "fs: allow cross-vfsmount
reflink/dedupe".

The test fails because a clone between two mounts is expected to fail,
and no longer does.

In my setup both mounts are nfs mounts.  They are mounts of different
exports, and the exports are exports of different filesystems.  So it
does make sense that the clone should fail.

I see the NFS client send a CLONE rpc to the server, and the server
return success.  That seems wrong.

Both exported filesystems are xfs, and from the code it looks like the
server calls vfs_clone_file_range(), which ends up calling
xfs_file_remap_range().

Are we missing a check now in that xfs case?

I haven't looked any more closely at what's going on, so I could be
missing something.

--b.

> > 
> > Sent from my iPhone
> > 
> > > On Mar 1, 2022, at 6:53 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > 
> > > ﻿This is probably moving the check for whether a cross-vfsmount reflink
> > > is allowed to someplace that makes less sense for NFS?
> > > 
> > > I did find the thread I was thinking of:
> > > 
> > >    https://lore.kernel.org/linux-fsdevel/67ae4c62a4749ae6870c452d1b458cc5f48b8263.1645042835.git.josef@toxicpanda.com/#r
> > > 
> > > though maybe they're discussing a different problem.
> > > 
> > > --b.
> > > 
> > >> On Tue, Mar 01, 2022 at 06:04:33PM -0500, J. Bruce Fields wrote:
> > >> aaf40970b1d0f4ac41dad7963f35c9e353b4a41d is the first bad commit
> > >> commit aaf40970b1d0f4ac41dad7963f35c9e353b4a41d
> > >> Author: Josef Bacik <josef@toxicpanda.com>
> > >> Date:   Fri Feb 18 09:38:14 2022 -0500
> > >> 
> > >>    fs: allow cross-vfsmount reflink/dedupe
> > >> 
> > >>    Currently we disallow reflink and dedupe if the two files aren't on the
> > >>    same vfsmount.  However we really only need to disallow it if they're
> > >>    not on the same super block.  It is very common for btrfs to have a main
> > >>    subvolume that is mounted and then different subvolumes mounted at
> > >>    different locations.  It's allowed to reflink between these volumes, but
> > >>    the vfsmount check disallows this.  Instead fix dedupe to check for the
> > >>    same superblock, and simply remove the vfsmount check for reflink as it
> > >>    already does the superblock check.
> > >> 
> > >>    Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > >>    Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> > >>    Reviewed-by: David Sterba <dsterba@suse.com>
> > >>    Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > >>    Signed-off-by: David Sterba <dsterba@suse.com>
> > >> 
> > >> fs/ioctl.c       | 4 ----
> > >> fs/remap_range.c | 7 +------
> > >> 2 files changed, 1 insertion(+), 10 deletions(-)
> > >> bisect found first bad commitgit bisect start
> > >> # bad: [6705cd745adbbeac6b13002c7a30060f7b2568a5] Add linux-next specific files for 20220228
> > >> git bisect bad 6705cd745adbbeac6b13002c7a30060f7b2568a5
> > >> # good: [7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3] Linux 5.17-rc6
> > >> git bisect good 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
> > >> # bad: [b1c65e65460a75a16cb8b658a28dd10fe465c59c] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> > >> git bisect bad b1c65e65460a75a16cb8b658a28dd10fe465c59c
> > >> # bad: [03de4e1d1f2cb2993df929a481661cdebc6c2c3d] Merge branch 'hwmon-next' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> > >> git bisect bad 03de4e1d1f2cb2993df929a481661cdebc6c2c3d
> > >> # good: [6b9c42995b55b2d01731105ef85170944d8da96f] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> > >> git bisect good 6b9c42995b55b2d01731105ef85170944d8da96f
> > >> # good: [af69a7a5a64464a756328de668041c1075f86454] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git
> > >> git bisect good af69a7a5a64464a756328de668041c1075f86454
> > >> # bad: [1f6aae68ded84c44b31249d2aae82be5ceacc758] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
> > >> git bisect bad 1f6aae68ded84c44b31249d2aae82be5ceacc758
> > >> # bad: [25ebc69693daccd38953d627151dbebc369ea3ff] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
> > >> git bisect bad 25ebc69693daccd38953d627151dbebc369ea3ff
> > >> # good: [0cbe7d755415ae2f40a8741eedb7c1717a21de53] btrfs: do not clean up repair bio if submit fails
> > >> git bisect good 0cbe7d755415ae2f40a8741eedb7c1717a21de53
> > >> # good: [5d820d692b5e550cdb590c362fdd35c000ebf420] Merge branch 'master' of git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
> > >> git bisect good 5d820d692b5e550cdb590c362fdd35c000ebf420
> > >> # good: [e9a9bca06a61e4700a8f81a1527c82966ed40922] btrfs: fix relocation crash due to premature return from btrfs_commit_transaction()
> > >> git bisect good e9a9bca06a61e4700a8f81a1527c82966ed40922
> > >> # bad: [d3cb500f9ca9e8a33a1e728cbd4c9c6e272f3fd8] Merge branch 'ext/qu/subpage-more-sizes' into for-next-next-v5.17-20220224
> > >> git bisect bad d3cb500f9ca9e8a33a1e728cbd4c9c6e272f3fd8
> > >> # bad: [fa3b92e259c8f71731e9bfb9cc6978d6184d8d8d] Merge branch 'ext/josef/cross-mount' into for-next-next-v5.17-20220224
> > >> git bisect bad fa3b92e259c8f71731e9bfb9cc6978d6184d8d8d
> > >> # bad: [aaf40970b1d0f4ac41dad7963f35c9e353b4a41d] fs: allow cross-vfsmount reflink/dedupe
> > >> git bisect bad aaf40970b1d0f4ac41dad7963f35c9e353b4a41d
> > >> # good: [244a73f987b06fd33041dc9cb0f99527a1c0815c] btrfs: remove the cross file system checks from remap
> > >> git bisect good 244a73f987b06fd33041dc9cb0f99527a1c0815c
> > >> # first bad commit: [aaf40970b1d0f4ac41dad7963f35c9e353b4a41d] fs: allow cross-vfsmount reflink/dedupe

