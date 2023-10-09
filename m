Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597327BDC46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 14:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376459AbjJIMha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 08:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346571AbjJIMh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:37:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733769D;
        Mon,  9 Oct 2023 05:37:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5626C433C8;
        Mon,  9 Oct 2023 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696855047;
        bh=a5bE6yi0Y8uBlf8hd66K9CjHe4sGRHljieVfPGaGVY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLoe32ZISCJRKawT1uuNATHYyBY0BEf/Y2lK6hZUCa4JrCY8F+ywn0LdfpdNKceIG
         I4vcIrrrb3tkUN+F5sEjgNQitgaCcWmLuYydcIM/biY9rnIfiyRSxm20OTJbPoH/rr
         tX7p005mKCi5AEnxIBKmqITGWk1YFjGPD6qP8w32K4+cmVOl6HcWEyQKUsKXTz8HRj
         V87KuBuW5ejNn4FYa1fAbJV/RdVFtYLAdfRn34QBWSi9wwZMBRw4aRo2rCoWYxv4To
         yIfnPC2k7v5wurg0LAwN//88Ndv2JseTrt1kt91pJRJC3e8xRsnw4VXRAnvUHw6Zq+
         Pb7l3XYbqCK2A==
Date:   Mon, 9 Oct 2023 14:37:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, chao@kernel.org, daniel.vetter@ffwll.ch,
        hdanton@sina.com, jack@suse.cz, jaegeuk@kernel.org,
        jinpu.wang@ionos.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mairacanal@riseup.net, mcanal@igalia.com,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com, willy@infradead.org, yukuai3@huawei.com
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
Message-ID: <20231009-leihgabe-abseilen-26e86d03f787@brauner>
References: <0000000000001825ce06047bf2a6@google.com>
 <00000000000071133306073f06ca@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00000000000071133306073f06ca@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 08, 2023 at 07:05:32PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 7908632f2927b65f7486ae6b67c24071666ba43f
> Author: Maíra Canal <mcanal@igalia.com>
> Date:   Thu Sep 14 10:19:02 2023 +0000
> 
>     Revert "drm/vkms: Fix race-condition between the hrtimer and the atomic commit"
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fc0565680000
> start commit:   2cf0f7156238 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14020565680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10020565680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
> dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107e9518680000
> 
> Reported-by: syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com
> Fixes: 7908632f2927 ("Revert "drm/vkms: Fix race-condition between the hrtimer and the atomic commit"")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

The bisect is obviously bogus. I haven't seend that bug report before
otherwise I would've already fixed this way earlier:

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git b4/vfs-fixes-reiserfs
