Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F80737CC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 10:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjFUIFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 04:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjFUIF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E691199E;
        Wed, 21 Jun 2023 01:05:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3222B6148D;
        Wed, 21 Jun 2023 08:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533AFC433C0;
        Wed, 21 Jun 2023 08:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687334723;
        bh=A0nwC/s2ji+8UKgD6FCXPyKxJZJQg3sYdNzUYtkF8cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TF1TB1X1ojZbqpj39jYJnNpIrddkPfoGr61YuBVsLHjD7C/ixqCfulfKAU4cj7USq
         cfbumCWgDf3xGlK7BdjT5IFed2TMYYIkbB6eRyczbUwlmS2WqkShU/RnsFDweJz5mr
         khf41H49v1SoN4AMQbMDMBOj1J7S2w1THHnUHmo6A/k/oR0TB0bYN0TTclQ8OwJYv+
         eLobEDN9pM3iJq7VX/nMiyIbxuoK4Ilox7QxVugRG4859Dij9mjU0iTQyLmAMEquzm
         CG1jMbrRRMFA9eVnxdW88IcGi1Px7Gebg7jAdc7EW18XQqFUYzObnWVEElZheu4G4X
         9AAZLvsoxtINA==
Date:   Wed, 21 Jun 2023 01:05:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] UBSAN: array-index-out-of-bounds in
 xfs_attr3_leaf_add_work
Message-ID: <20230621080521.GB56560@sol.localdomain>
References: <0000000000001c8edb05fe518644@google.com>
 <ZI+3QXDHiohgv/Pb@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZI+3QXDHiohgv/Pb@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On Mon, Jun 19, 2023 at 12:02:41PM +1000, 'Dave Chinner' via syzkaller-bugs wrote:
> On Sat, Jun 17, 2023 at 04:22:59AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    1f6ce8392d6f Add linux-next specific files for 20230613
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e629dd280000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=510dcbdc6befa1e6b2f6
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139d8d2d280000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b371f1280000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/2d9bf45aeae9/disk-1f6ce839.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e0b03ef83e17/vmlinux-1f6ce839.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b6c21a24174d/bzImage-1f6ce839.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/65eca6891c21/mount_0.gz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com
> > 
> > XFS (loop0): Mounting V4 Filesystem 5e6273b8-2167-42bb-911b-418aa14a1261
> > XFS (loop0): Ending clean mount
> > xfs filesystem being mounted at /root/file0 supports timestamps until 2038-01-19 (0x7fffffff)
> > ================================================================================
> > UBSAN: array-index-out-of-bounds in fs/xfs/libxfs/xfs_attr_leaf.c:1560:3
> > index 14 is out of range for type '__u8 [1]'
> > CPU: 1 PID: 5021 Comm: syz-executor198 Not tainted 6.4.0-rc6-next-20230613-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
> >  ubsan_epilogue lib/ubsan.c:217 [inline]
> >  __ubsan_handle_out_of_bounds+0xd5/0x140 lib/ubsan.c:348
> >  xfs_attr3_leaf_add_work+0x1528/0x1730 fs/xfs/libxfs/xfs_attr_leaf.c:1560
> >  xfs_attr3_leaf_add+0x750/0x880 fs/xfs/libxfs/xfs_attr_leaf.c:1438
> >  xfs_attr_leaf_try_add+0x1b7/0x660 fs/xfs/libxfs/xfs_attr.c:1242
> >  xfs_attr_leaf_addname fs/xfs/libxfs/xfs_attr.c:444 [inline]
> >  xfs_attr_set_iter+0x16c4/0x2f90 fs/xfs/libxfs/xfs_attr.c:721
> >  xfs_xattri_finish_update+0x3c/0x140 fs/xfs/xfs_attr_item.c:332
> 
> The on disk format for this field is defined as:
> 
> typedef struct xfs_attr_leaf_name_local {
>         __be16  valuelen;               /* number of bytes in value */
>         __u8    namelen;                /* length of name bytes */
>         __u8    nameval[1];             /* name/value bytes */
> } xfs_attr_leaf_name_local_t
> 
> If someone wants to do change the on-disk format definition to use
> "kernel proper" flex arrays in both the kernel code and user space,
> update all the documentation and do all the validation work that
> on-disk format changes require for all XFS disk structures that are
> defined this way, then we'll fix this.
> 
> But as it stands, these structures have been defined this way for 25
> years and the code accessing them has been around for just as long.
> The code is not broken and it does not need fixing. We have way more
> important things to be doing that fiddling with on disk format
> definitions and long standing, working code just to shut up UBSAN
> and/or syzbot.
> 
> WONTFIX, NOTABUG.

My understanding is that the main motivation for the conversions to flex arrays
is kernel hardening, as it allows bounds checking to be enabled.

You can probably get away with not fixing this for a little while longer, as
that stuff is still a work in progress.  But I would suggest you be careful
about potentially getting yourself into a position where XFS is blocking
enabling security mitigations for the whole kernel...

- Eric
