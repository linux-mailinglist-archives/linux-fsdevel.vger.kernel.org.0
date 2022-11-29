Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255663C439
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 16:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbiK2Pz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 10:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiK2PzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:55:25 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509E031DCC;
        Tue, 29 Nov 2022 07:55:23 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ATFsq3G012855
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 10:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669737296; bh=zy1UIZPqhoCDwUnrkLYvCQpT85PKbbZrepuvTkbgSAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UcgtUtu12f3XiwepHFKSOTDqnQuVYIPW/YMZdXumAsUGQ7dHH/6CPJ4Ht+zVd11aA
         kTeAG2t03CqDQ8ZeNn07kPbazdlpNiM/sMxmenLdCGs4YXFpfxdI9baCrLU/EL0cV5
         UV5fci8LtA6xQjeA17cv4NkLrLt2GQnjHur5+HFIw5RgIRw9txsIY3gSZPMSk0S+Ln
         2JY2fyOxsoiXfhi60JiAJJofTgb5LIiSB3fz6j+Cax9q0S2kygCyGGhvDG2CAXAOgp
         qIDwG1NBUzrSNahl5Zvtba3qL1ODsxbK5P40kiPLCCDcmjWYYqTQuJKN2vxvH41l3L
         Gdr8Ji7ttkzFw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EEC3C15C00E4; Tue, 29 Nov 2022 10:54:51 -0500 (EST)
Date:   Tue, 29 Nov 2022 10:54:51 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dan.j.williams@intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] WARNING in iov_iter_revert (3)
Message-ID: <Y4YrS8taMsidF33F@mit.edu>
References: <000000000000519d0205ee4ba094@google.com>
 <000000000000f5ecad05ee8fccf0@google.com>
 <Y4WE08+n1sZvSt4M@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4WE08+n1sZvSt4M@ZenIV>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 04:04:35AM +0000, Al Viro wrote:
> On Mon, Nov 28, 2022 at 02:57:49PM -0800, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> 
> [snip]
> 
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17219fbb880000
> 
> "syz_mount_image$ntfs3(" followed by arseloads of garbage.  And the thing
> conspiciously missing?  Why, any ntfs3 maintainers in Cc...  Or lists,
> for that matter...
> 
> >  generic_file_read_iter+0x3d4/0x540 mm/filemap.c:2804
> >  do_iter_read+0x6e3/0xc10 fs/read_write.c:796
> >  vfs_readv fs/read_write.c:916 [inline]
> >  do_preadv+0x1f4/0x330 fs/read_write.c:1008
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> At a guess - something's screwed in ntfs3 ->direct_IO() (return value, most
> likely).  And something's screwed in syzbot.  If you are fuzzing some
> filesystem, YOU REALLY OUGHT TO CC THE MAINTAINERS OF THAT FILESYSTEM.
> Even if nothing in the stack trace happens to be in that fs.

The scheme which syzbot appears to use involves looking at the symbol
in EIP from the stack trace to determine who to CC.  This... mostly
works, but occasionally results in hilarity.

For example, there was the time when the fuzzing program fed some
other file system (f2fs, as I recall) several hundred invalid file
systems, and then for some reason it fed ext4 an invalid file system,
and ext4 tripped on an invalid pointer dereference.  Of course, just
feeding ext4 the invalid file system had no issues, and a human being
might have intuited that maybe the several hundred invalid f2fs file
systems triggered some kind of memory corruption which ext4 then
tripped across ---- but since the EIP was in the ext4 file system, the
ext4 maintainers got cc'ed, and if you look in the dashboard, it just
shows an ext4 symbol, so it's unlikely the f2fs developers would ever
have discovered it on their own.  (I did cc it to them, but they
weren't able to get to it immediately, and it'll be hard to find it
again, since we don't have a bug tracking system and there's no way to
set some kind of "subsystem really at fault" state in the Syzkaller
dashboard.)

> Folks, it's that simple - "our bot needs to remember that fuzzing $FS
> automatically puts maintainers of $FS into the set of people we need to Cc"
> vs. "maintainers of each filesystem need to dig into every syzbot posting
> on fsdevel (and follow links, no less) to check if their fs might be
> involved".  If you can't be bothered to take care of the former, why
> would you expect $BIGNUM people to bother with the latter, again and
> again and again?

The strength and weakness of syzkaller is that it will combine fuzzing
with, say, setting up and tearing down a gazllion wireguard tunnels,
or some other random set of system calls.  Sometimes that finds a real
bug.  Other times, for some strange reason, the syzkaller minimizer
can't figure out that the extraneous noise in setting up and tearing
down the network connections is pointless noise, except that on the
specific hardware/VM used by syzkaller, it helps make it easier to
trigger a timing-related bug --- but $DEITY help you if you try to
reproduce on anything other than the specific VM used by the syzkaller
bug.

And then, of course, there are cases where the reproducer is only
doing one thing, such as say messing with ntfs3, and the syzbot
*should* be able to figure out a better set of maintainers to notify
--- but then, given that the syzbot subjust line/summary is something
generic, such as iov_iter_XXX, and there's no way to set up an
affected subsystem state in the dashboard, good luck having anyone
else find it in the syzkaller dashboard later on.

> Fix your bot, already.  It's not the first time this had been brought
> to your attention and the problem is still there.

I've brought this to the Syzkaller team's attention multiple times.
Unfortunately, it's not exactly a trivial problem to solve, and other
things have been considered higher priority.

(Hint to the Syzkaller team; if you can prioritize and share a roadmap
with upstream developer vis-a-vis upstream concerns, it might make
some upstream developers a bit more receptive to patches designed to
make life easier for syzkaller to find EVEN MORE FILESYSTEM FUZZING
BUGS, such as [1].  Otherwise, it is perhaps understandable why some
might consider this more of a threat rather than a benefit...  Note:
[1] doesn't make a difference for ext4 either way, since metadata
checksums is a file system feature that can be enabled or disabled at
mkfs time; this patch series is about finding more file system bugs
for file systems which don't make disabling checksum to be an option,
such as XFS.)

[1] https://lore.kernel.org/all/20221014084837.1787196-1-hrkanabar@gmail.com/
