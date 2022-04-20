Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CA50881D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 14:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353193AbiDTM3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 08:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiDTM3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7C8286E1;
        Wed, 20 Apr 2022 05:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE26361988;
        Wed, 20 Apr 2022 12:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEC5C385A0;
        Wed, 20 Apr 2022 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650457627;
        bh=jxli10XRiJdu42WSS8669uK+pbmxZax4+eLzHGUJeog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QvMQcJRWhCY8JiZNLpIrt4IupUkvwhgGmFy1kp+vXYY6YuokOuL2TiMZ0DaciGLCa
         A7Oa33f7bYiHsZEbrcpPg/qE70QOJIjrWyOml+v1oQ84ZD1VAuQpO6hTl9cnE9gn4d
         FV3VxPKgBBTHiJY/nhD6g3HJCvmjhRY9CmPrpbUemxU3A7+y366NCRBuEaqMjNqer1
         uczOwTmgshhIFM6YZNNefno2zGYnw/PiVUdcA9MAqbdI+o/zhRDeuA1hdsylzjGvzi
         HY6MGJfU1UtzkDwLArtWaBy7GCfA6eNCTEj67CYSRX+TBOwJ3oMLGlAvKW4R1UG6lu
         3XuRYLzl7q8iQ==
Date:   Wed, 20 Apr 2022 14:27:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com>
Cc:     fweisbec@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] INFO: rcu detected stall in sys_lsetxattr
Message-ID: <20220420122702.lseed5l3lrssyat2@wittgenstein>
References: <00000000000080e10e05dd043247@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000080e10e05dd043247@google.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:16:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    40354149f4d7 Add linux-next specific files for 20220414
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ae0bd0f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a44d62051576f6f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=306090cfa3294f0bbfb3
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164417ccf00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104d63d0f00000
> 
> The issue was bisected to:
> 
> commit e257039f0fc7da36ac3a522ef9a5cb4ae7852e67
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Tue Mar 1 04:04:20 2022 +0000
> 
>     mount_setattr(): clean the control flow and calling conventions
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14622210f00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16622210f00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12622210f00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com
> Fixes: e257039f0fc7 ("mount_setattr(): clean the control flow and calling conventions")

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git fs.mount_setattr.cleanup
