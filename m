Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361B963B8F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 05:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiK2EEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 23:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiK2EEq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:04:46 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF825D7;
        Mon, 28 Nov 2022 20:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SFmlSqgAPWtwF6quHxtAG0npFApZzjL0nMEqzkSuKeo=; b=faz6vq8W5eO3z9yrIbJe5AjURg
        PsyOFeSQqLqXlIam1NF0aTcptLlgTGM5w7eR/rwd1gZK8VHc0FjOQClBgsVCuC5rpY8Rk7FaiW7Zu
        okMu2mTmJV8kmNuLJLCFp5nqCXBsuLLdE6Gp6+7cNuWMeokCNkBah22G9pkj3jsDb2KVBzlJRtLnP
        8/eDWhMjN4mDRox1yk69lL6t1YVT+mpdSVf7aBuEXvQmZOvjNARFScmy0dl74YanIoDujK9iwOHAr
        JEatjFXhhjJBSB9zqfnK2M1K61uH/Hgzu+ZP3bU6d7I9XDNJpvdseX9D8Y+rf+tXbDsJwNHpW/p9n
        8HLgMm1g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ozrrH-007Zj5-1M;
        Tue, 29 Nov 2022 04:04:35 +0000
Date:   Tue, 29 Nov 2022 04:04:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] WARNING in iov_iter_revert (3)
Message-ID: <Y4WE08+n1sZvSt4M@ZenIV>
References: <000000000000519d0205ee4ba094@google.com>
 <000000000000f5ecad05ee8fccf0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f5ecad05ee8fccf0@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:57:49PM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:

[snip]

> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17219fbb880000

"syz_mount_image$ntfs3(" followed by arseloads of garbage.  And the thing
conspiciously missing?  Why, any ntfs3 maintainers in Cc...  Or lists,
for that matter...

>  generic_file_read_iter+0x3d4/0x540 mm/filemap.c:2804
>  do_iter_read+0x6e3/0xc10 fs/read_write.c:796
>  vfs_readv fs/read_write.c:916 [inline]
>  do_preadv+0x1f4/0x330 fs/read_write.c:1008
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd

At a guess - something's screwed in ntfs3 ->direct_IO() (return value, most
likely).  And something's screwed in syzbot.  If you are fuzzing some
filesystem, YOU REALLY OUGHT TO CC THE MAINTAINERS OF THAT FILESYSTEM.
Even if nothing in the stack trace happens to be in that fs.

Folks, it's that simple - "our bot needs to remember that fuzzing $FS
automatically puts maintainers of $FS into the set of people we need to Cc"
vs. "maintainers of each filesystem need to dig into every syzbot posting
on fsdevel (and follow links, no less) to check if their fs might be
involved".  If you can't be bothered to take care of the former, why
would you expect $BIGNUM people to bother with the latter, again and
again and again?

Fix your bot, already.  It's not the first time this had been brought
to your attention and the problem is still there.
