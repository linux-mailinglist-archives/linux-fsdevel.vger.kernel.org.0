Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3163BFEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 13:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiK2MVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 07:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiK2MVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:21:00 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F8F5D6B4;
        Tue, 29 Nov 2022 04:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wo3aQUARnvFFz3/ffXVvv/DF/a1pENBpfxbf9Xt1fwM=; b=KJTHbTIbPVkXCbiycEs5416p02
        FtZDbTcFBFwPJznbCyxuFjP6mdBLkBOST6haJGyzOjeVODvjZW/ZWCiErFYVrnn3WOSRnaezdUkF7
        HytYXVABQdSFQ1kYYVGN70z6gjMWJQn0tR54eaPdNChu+yY/VNMjhOQD5svbZiEH/ADhLiSSH0WEX
        aOG+CfEyKKrcWZb0uS8UdgixShctMh4enJ38h6yed1tYWWQ7L3/t3Zft6T/rU69b2T7VPazS4LYCB
        DWm+wr8IFHqueZGNSEqR4FqWPj0QFxweKEQihig3fIR4ba72YIaAz404owVNI4AYNvP9mRfC3cHNk
        kUZn0bzA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ozzbL-007f5j-1t;
        Tue, 29 Nov 2022 12:20:39 +0000
Date:   Tue, 29 Nov 2022 12:20:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dan.j.williams@intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] WARNING in iov_iter_revert (3)
Message-ID: <Y4X5F43D+As21b6M@ZenIV>
References: <000000000000519d0205ee4ba094@google.com>
 <000000000000f5ecad05ee8fccf0@google.com>
 <20221129090831.6281-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129090831.6281-1-hdanton@sina.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 05:08:31PM +0800, Hillf Danton wrote:
> On 29 Nov 2022 04:04:35 +0000 Al Viro <viro@zeniv.linux.org.uk>
> > On Mon, Nov 28, 2022 at 02:57:49PM -0800, syzbot wrote:
> > > syzbot has found a reproducer for the following issue on:
> > 
> > [snip]
> > 
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17219fbb880000
> > 
> > "syz_mount_image$ntfs3(" followed by arseloads of garbage.  And the thing
> > conspiciously missing?  Why, any ntfs3 maintainers in Cc...  Or lists,
> > for that matter...
> > 
> > >  generic_file_read_iter+0x3d4/0x540 mm/filemap.c:2804
> > >  do_iter_read+0x6e3/0xc10 fs/read_write.c:796
> > >  vfs_readv fs/read_write.c:916 [inline]
> > >  do_preadv+0x1f4/0x330 fs/read_write.c:1008
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > At a guess - something's screwed in ntfs3 ->direct_IO() (return value, most
> > likely).
> 
> 2798		retval = mapping->a_ops->direct_IO(iocb, iter);
> 2799		if (retval >= 0) {
> 2800		        iocb->ki_pos += retval;
> 2801		        count -= retval;
> 2802		}
> 2803		if (retval != -EIOCBQUEUED)
> 2804		        iov_iter_revert(iter, count - iov_iter_count(iter));
> 2805		
> 2806		/*
> 2807		 * Btrfs can have a short DIO read if we encounter
> 2808		 * compressed extents, so if there was an error, or if
> 2809		 * we've already read everything we wanted to, or if
> 2810		 * there was a short read because we hit EOF, go ahead
> 2811		 * and return.  Otherwise fallthrough to buffered io for
> 2812		 * the rest of the read.  Buffered reads will not work for
> 2813		 * DAX files, so don't bother trying.
> 2814		 */
> 2815		if (retval < 0 || !count || IS_DAX(inode))
> 2816		        return retval;
> 2817		if (iocb->ki_pos >= i_size_read(inode))
> 2818		        return retval;
> 
> 
> If ntfs3 is supposed to do nothing wrong with retval set to 5, why is
> iov_iter_revert() invoked? Is it correct to check -EIOCBQUEUED only if
> the direct_IO callback returns error?

->direct_IO() should return the amount of data actually copied to userland;
if that's how much it has consumed from iterator - great, iov_iter_revert(i, 0)
is a no-op.  If it has consumed more, the caller will take care of that.
If it has consumed say 4Kb of data from iterator, but claims that it has
managed to store 12Kb into that, it's broken and should be fixed.

If it wants to do revert on its own, for whatever reason, it is welcome - nothing
will break, as long as you do *not* return the value greater than the amount you
ended up taking from iterator.  However, I don't understand the reason why ntfs3
wants to bother (and appears to get it wrong, at that); the current rules are
such that caller will take care of revert.
