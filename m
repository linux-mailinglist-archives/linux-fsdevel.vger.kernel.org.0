Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5317A744F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 09:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjITHhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 03:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjITHhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:37:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24058FB;
        Wed, 20 Sep 2023 00:37:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60753C433C7;
        Wed, 20 Sep 2023 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695195421;
        bh=z1dy31UeAiNB72SwXICT2TJ42xSh8mt5/7TGfDru1x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/66sa17bNa1qC8ThA1zSpgs9biCJH1Ajq5zq+89aqkyyGbjOYvXo/ix8Ipb4iCbJ
         prWNMZnrLsew+TlFTLIEqYJ0sVZkH3HvclRrEsMYJVRIV4pUKy2Uz0sOWBMOQZE2hj
         n9SC8mBlrHgeSegE0Ii4Sg9EwFJ1viOeEpJDATKEG7WHw94hPro747FW/4htGtWSO2
         vXoQKlxD8oaN8exIdqpRKtQWTGUKpKr4c7O2XrYV42TXjlaPA1bzwi3KR2w6OMd9Ck
         G3YBFcWZxiFlIaJJdOQEavZpDwaPVRVojE1MmeCM/4Q2GkOLHauvubw5qiw/xQhm/h
         1XyGgUohrjsfw==
Date:   Wed, 20 Sep 2023 00:36:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+9cf75dc581fb4307d6dd@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, krisman@collabora.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] [ext4?] general protection fault in utf8nlookup
Message-ID: <20230920073659.GC2739@sol.localdomain>
References: <0000000000001f0b970605c39a7e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001f0b970605c39a7e@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:25:22PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e42bebf6db29 Merge tag 'efi-fixes-for-v6.6-1' of git://git..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=179f4a38680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
> dashboard link: https://syzkaller.appspot.com/bug?extid=9cf75dc581fb4307d6dd
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374a174680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b12928680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/14a6a5d23944/disk-e42bebf6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/98cc4c220388/vmlinux-e42bebf6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6a1d09cf21bf/bzImage-e42bebf6.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/37e5beb24789/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/f219a9e665e9/mount_8.gz
> 
> The issue was bisected to:
> 
> commit b81427939590450172716093dafdda8ef52e020f
> Author: Eric Biggers <ebiggers@google.com>
> Date:   Mon Aug 14 18:29:02 2023 +0000
> 
>     ext4: remove redundant checks of s_encoding
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10852352680000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12852352680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14852352680000

This report is expected for now, since the repro involves writing to the page
cache of a mounted block device.  For more information see
https://lore.kernel.org/linux-fsdevel/20230813001202.GE41642@sol.localdomain and
https://lore.kernel.org/linux-fsdevel/20230814182903.37267-2-ebiggers@kernel.org.
Also https://lore.kernel.org/linux-fsdevel/20230704122727.17096-1-jack@suse.cz
which will ultimately be the fix for this class of issue.

Note: the repro that syzkaller generated for this is very strange (even moreso
than usual for syzkaller repros...) because it replaces its "scratch space" at
address 0x20000000 with a different mapping, specifically a mapping for a file
that is mounted as a filesystem via loopback.  That makes "syscalls" have weird
side effects as a result of the repro writing parameters to the address that is
supposed to contain its scratch space.  I don't think this should be happening,
so I've opened https://github.com/google/syzkaller/issues/4216 for it.

- Eric
