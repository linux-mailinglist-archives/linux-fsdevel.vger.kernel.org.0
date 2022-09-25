Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B415E9379
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 15:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiIYNlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 09:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiIYNlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 09:41:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597F42AE13;
        Sun, 25 Sep 2022 06:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dj7nhKh/NArGj0oG4bk8DRORTaIrXKrcLhcogP+lz6Y=; b=mKTRISh+9VUbiTu6AFs6FLolcC
        /3vzWHEzmuBqdRgSNr4qIMUTn8MPy8XsDcGb/Oc8vnfXhgruqjh9SG8lp+yw+AEaq9IHUt/iPLorf
        9Oqvq27xlLoRmgLtsqSgAdOSrRGHg1uftXBbmVLe8Vm7Ap2ba4w+n3fXq0Ow8+maapsed4Z9xv6/X
        OO/bA1/AqNFwaWNq01MleVSm8m1MumatrOFGVfH4B3t/iEyazD4fIDhWn9j/3j6AXxV/g2470Y86M
        KFvL4eA56ENiMlda+2ajRQ0rqdknkLzuCfQKFTClcoZNFriZ+PUMihrcGkq/eY0NXajjjceVCM4PF
        RYD6cg5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ocRsk-003ckC-1i;
        Sun, 25 Sep 2022 13:41:18 +0000
Date:   Sun, 25 Sep 2022 14:41:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+4353c86db4e58720cd11@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: [syzbot] kernel panic: stack is corrupted in lock_release (3)
Message-ID: <YzBafjvhv1qfv5A1@ZenIV>
References: <000000000000ba0dcb05e97e239b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ba0dcb05e97e239b@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 25, 2022 at 03:47:38AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3db61221f4e8 Merge tag 'io_uring-6.0-2022-09-23' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10135a88880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
> dashboard link: https://syzkaller.appspot.com/bug?extid=4353c86db4e58720cd11
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1792e6e4880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1059fcdf080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4353c86db4e58720cd11@syzkaller.appspotmail.com

[ntfs_fill_super() failure exits are still buggered]

Folks, could syzbot be taught that ntfs involved in testing means that
ntfs maintainers need to be on Cc?

FWIW,

1) failing d_make_root() does *NOT* need the caller to drop inode; it consumes
inode reference itself, precisely to make that failure exits easier.

2) you never set ->i_op to NULL.  Initial value is to an empty method table;
nothing out of alloc_inode(), let alone iget5_locked() should ever see
NULL ->i_op there.

3) the same goes for ->i_fop; it should never be NULL.  Initial value points
to an empty method table; if you don't want any methods, leave it as-is.
Yes, even for symlinks.

That - from quick eyeballing the code in question.  There might be more (and
almost certainly is).  The thing is, ntfs3 clearly corrupts memory of failure
exits in mount, and syzbot reports in that direction really ought to go to ntfs
folks; Cc to fsdevel is OK, but at least mark those as likely to be ntfs-related.
