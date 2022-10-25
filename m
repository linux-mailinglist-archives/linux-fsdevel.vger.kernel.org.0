Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD24160C334
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 07:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiJYFYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 01:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiJYFYe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:24:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1991F607;
        Mon, 24 Oct 2022 22:24:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61148B81A49;
        Tue, 25 Oct 2022 05:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC2CC433D7;
        Tue, 25 Oct 2022 05:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666675471;
        bh=dF49dTW/qT+v3oJiK1K3/C1aumfpE7sXiBGXB2F/8l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlUZ1IwcOMNkZ38elGsKCy6rF73OkwlQt8JQRkjYWFrq2pQn27I2nDUmOE/tEf3Kw
         zImfgEn8IoIZ/S4SxG3N/31ZcQvlxyWGW8GM5iaZdKN37bYK0fzD/W7IqNHjYrVatz
         c0fAxVtMvaNvHazGXLmG48scNHatmty/SVNYvq9FaZ/14FJIu7c8l6kXhwgEaYvr1A
         nJDHYi4cs59AuY1eHQTqfaznnKce23WOHZJp37aPHLWO1TdVDnG0T5jt5KI3rgW4to
         9F+dz21hzxE9Rf4NeC0NgXiDTR4tmBh5EuGZdW+xDogMiscNzm9vrlfLaH+Q6MpFQj
         w81NEUrvj5Cxg==
Date:   Mon, 24 Oct 2022 22:24:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     hirofumi@mail.parknet.co.jp, jack@suse.cz,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu,
        syzbot <syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] KASAN: use-after-free Read in move_expired_inodes (2)
Message-ID: <Y1dzDVZQ49nQdMUv@sol.localdomain>
References: <00000000000037b96205eabe49b5@google.com>
 <000000000000673b6305eac37e1f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000673b6305eac37e1f@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 07:57:23AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit cbfecb927f429a6fa613d74b998496bd71e4438a
> Author: Lukas Czerner <lczerner@redhat.com>
> Date:   Thu Aug 25 10:06:57 2022 +0000
> 
>     fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e93452880000
> start commit:   493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14193452880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10193452880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> dashboard link: https://syzkaller.appspot.com/bug?extid=6ba92bd00d5093f7e371
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1724028a880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17419234880000
> 
> Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
> Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Lukas, are you looking into this?

- Eric
