Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14CD4B4004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 04:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiBNDEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Feb 2022 22:04:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiBNDEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:04:36 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E12A50E2F;
        Sun, 13 Feb 2022 19:04:28 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJRf9-001dBJ-DX; Mon, 14 Feb 2022 03:04:27 +0000
Date:   Mon, 14 Feb 2022 03:04:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/namespace: eliminate unnecessary mount counting
Message-ID: <YgnGuy0GJzlqCSRj@zeniv-ca.linux.org.uk>
References: <20220123100448.GA1468@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123100448.GA1468@haolee.io>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:04:48AM +0000, Hao Lee wrote:
> propagate_one() counts the number of propagated mounts in each
> propagation. We can count them in advance and use the number in
> subsequent propagation.

You are relying upon highly non-obvious assumptions.  Namely, that
copies will have the same amount of mounts as source_mnt.  AFAICS,
it's not true in case of mount --move - there source_mnt might very
well contain the things that would be skipped in subsequent copies.
E.g. anything marked unbindable.  Or mntns binds - anything that would
be skipped by copy_tree() without special flags.

Sure, we could make count_mounts() return just the number of those
that will go into subsequent copies (with mount --move we don't add
the original subtree - it's been in the namespace and thus is already
counted), but
	1) it creates an extra dependency in already convoluted code
(copy_tree() and count_mounts() need to be kept in sync, in case we ever
add new classes of mounts to be skipped)
	2) I'm *NOT* certain that we won't ever run into the non-move
cases where the original tree contains something that would be skipped
from subsequent ones, and there we want to count the original.	Matter of
fact, we do run into that.  Look:

# arrange a private tree at /tmp/a
mkdir /tmp/a
mount --bind /tmp/a /tmp/a
mount --make-rprivate /tmp/a
# mountpoint at /tmp/a/x
mkdir /tmp/a/x
mount --bind /tmp/a/x /tmp/a/x
# this will be a peer of /tmp/a/x
mkdir /tmp/a/y
# ... and this - a mountpoint in it
mkdir /tmp/a/x/v
# ... rbind fodder:
mkdir /tmp/a/z
touch /tmp/a/z/f
# start a new mntns, so we won't run afoul of loop checks
unshare -m &
# ... and bind it on /tmp/a/z/f
mount --bind /proc/$!/ns/mnt /tmp/a/z/f
# now we can do the rest - it won't spread into child namespace
# make /tmp/a/x a peer of /tmp/b/x
mount --make-shared /tmp/a/x
mount --bind /tmp/a/x /tmp/a/y
# ... and rbind /tmp/a/z at /tmp/a/x/v
# which will propagate a copy to /tmp/b/x/v
# except that mntns bound on /tmp/a/x/v/f will *not* propagate.
mount --rbind /tmp/a/z /tmp/a/x/v
# verify that
stat /tmp/a/x/v
stat /tmp/a/y/v
stat /tmp/a/x/v/f
stat /tmp/a/y/v/f

Result:
  File: /tmp/a/x/v/
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 808h/2056d      Inode: 270607      Links: 2
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-02-13 21:43:45.058485130 -0500
Modify: 2022-02-13 21:42:37.142457622 -0500
Change: 2022-02-13 21:42:37.142457622 -0500
 Birth: 2022-02-13 21:42:37.142457622 -0500
  File: /tmp/a/y/v/
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 808h/2056d      Inode: 270607      Links: 2
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-02-13 21:43:45.058485130 -0500
Modify: 2022-02-13 21:42:37.142457622 -0500
Change: 2022-02-13 21:42:37.142457622 -0500
 Birth: 2022-02-13 21:42:37.142457622 -0500
  File: /tmp/a/x/v/f
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 4h/4d   Inode: 4026532237  Links: 1
Access: (0444/-r--r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-02-13 21:42:37.146457624 -0500
Modify: 2022-02-13 21:42:37.146457624 -0500
Change: 2022-02-13 21:42:37.146457624 -0500
 Birth: -
  File: /tmp/a/y/v/f
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 808h/2056d      Inode: 270608      Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-02-13 21:42:37.142457622 -0500
Modify: 2022-02-13 21:42:37.142457622 -0500
Change: 2022-02-13 21:42:37.142457622 -0500
 Birth: 2022-02-13 21:42:37.142457622 -0500

	Note that /tmp/a/x/v and /tmp/a/y/v resolve to the same directory
(otherwise seen at /tmp/a/z), but /tmp/a/x/v/f and /tmp/a/y/v/f do *not*
resolve to the same thing - the latter is a regular file on /dev/sda8
(nothing got propagated there), while the former is *not* - it's an
mntns descriptor we'd bound on /tmp/a/z/f

	IOW, the first copy has two mount nodes, the second - only one.
Initial copy at rbind does get mntns binds copied into it - look at
CL_COPY_MNT_NS_FILE in arguments of copy_tree() call in __do_loopback().
However, we do *not* propagate that subsequent copies (propagate_one()
never passes CL_COPY_MNT_NS_FILE).  So that's at least one case where we
want different contributions from the first copy and every subsequent one.

	So we'd need to run *two* counts, the one to be used from
attach_recursive_mnt() and another for propagate_one().  With even more
places where the things could go wrong...

	I don't believe it's worth the trouble.  Sure, you run that loop
only once, instead of once per copy.  And if that's more than noise,
compared to allocating the same mounts we'd been counting, connecting
them into tree, hashing, etc., I would be *very* surprised.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
