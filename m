Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539396CFB72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 08:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjC3GWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 02:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC3GWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7822720;
        Wed, 29 Mar 2023 23:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4432361ED4;
        Thu, 30 Mar 2023 06:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E2EC433EF;
        Thu, 30 Mar 2023 06:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680157330;
        bh=CV1MhJWmmcdEluiHaXSBfahLeQtZk22ulhw14npJM2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3Im3bxXR2Hle5mb4m5rORHZJju44BBco019Ozm65CYpXAtKMZWGAKLENuNt4GXcu
         IVYnUD5f3FO61GL2QsmbRTyFgHLZHgDLRWxhuZ9D9mc/p4L5oLupu2bLIWLs5ckAq8
         WCTHC9hzjngwgSTPl/6KO2Fr7VNDp/4GlgyxgxdHN514TqZ0c7COMxkD0jkGSGxovZ
         kh3F3tTuaKlrrA3qLjtsUI6I0TWBibMIjp71tKGzsRZ8nJr+s5KTqAp5+3RozrHYo3
         44QkXi+5vRLyeenLe2ABXIJDh+TMoLrK92MtkUoHMJpEu0iEqf5189apOPJWdUhAqN
         cAoUaCglLlwnw==
Date:   Thu, 30 Mar 2023 08:22:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+8ac3859139c685c4f597@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: null-ptr-deref Read in ida_free (3)
Message-ID: <20230330-tinsmith-grimace-008b39c60399@brauner>
References: <00000000000088694505f8132d77@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000088694505f8132d77@google.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 05:28:55PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    da8e7da11e4b Merge tag 'nfsd-6.3-4' of git://git.kernel.or..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1266331ec80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ac3859139c685c4f597
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11639815c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12128b1ec80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/62e9c5f4bead/disk-da8e7da1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c11aa933e2a7/vmlinux-da8e7da1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7a21bdd49c84/bzImage-da8e7da1.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8ac3859139c685c4f597@syzkaller.appspotmail.com

This bug deserves a #include <asm-generic/bitops/ffs.h>.

In any case, it might just be advisable to hold namespace_lock() while
cleaning up peer group ids...

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git b4/vfs-mount_setattr-propagation-fix
