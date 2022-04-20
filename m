Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897E6508819
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 14:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378514AbiDTM3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 08:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353193AbiDTM3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:29:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4BE286E1;
        Wed, 20 Apr 2022 05:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAFDFB81ECD;
        Wed, 20 Apr 2022 12:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F20C385A0;
        Wed, 20 Apr 2022 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650457575;
        bh=iECp8GFjCkhpAv51gZMBcltLbreh5Jd0z16B9i8dGhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K9JLCLk1cvj6L2BUtW7SHoF2XwCCyJeDqlDglccjY64wW5vHz9YutWn+Qhx/mmO6B
         i2AOcQRyOmimm3rFTNeM2dWpQuJeZrPAFmgnXyL1cX4K/3zFGQaah+dTo4bvQa7Wf/
         inAUVba37yveUyQlszapXlHX2OFrnEiE20vR5CIqTQUM6e4dIXqYvVhe29jwSaatGX
         LGbWSHjxaWHHCgVeIJfqtYmJfRpxlJ4leH7rVATPJ8prUX6WZgeY6I6P2EA6PrfBFT
         fihe6+IH3Y6W03OlB6MwqQ1t+hU56tj55lNqUM1TW9egbnZzpGpMVNv0XvmsGiOwMH
         fETLGHUh0mWzQ==
Date:   Wed, 20 Apr 2022 14:26:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com>
Cc:     fweisbec@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] INFO: rcu detected stall in sys_setxattr (2)
Message-ID: <20220420122610.7k2qx5dwdchu27mg@wittgenstein>
References: <0000000000007cc21d05dd0432b8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000007cc21d05dd0432b8@google.com>
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
> HEAD commit:    b2d229d4ddb1 Linux 5.18-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=144417ccf00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6cb89c879305f336
> dashboard link: https://syzkaller.appspot.com/bug?extid=10a16d1c43580983f6a2
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104a88e8f00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132a840cf00000
> 
> The issue was bisected to:
> 
> commit e257039f0fc7da36ac3a522ef9a5cb4ae7852e67
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Tue Mar 1 04:04:20 2022 +0000
> 
>     mount_setattr(): clean the control flow and calling conventions
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b313c0f00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15b313c0f00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b313c0f00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com
> Fixes: e257039f0fc7 ("mount_setattr(): clean the control flow and calling conventions")

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git fs.mount_setattr.cleanup


