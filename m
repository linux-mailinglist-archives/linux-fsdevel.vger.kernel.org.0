Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A173ECAB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 21:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhHOTnW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 15:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhHOTnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 15:43:22 -0400
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Aug 2021 12:42:51 PDT
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1373C061764;
        Sun, 15 Aug 2021 12:42:51 -0700 (PDT)
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 105091A0;
        Sun, 15 Aug 2021 19:35:05 +0000 (UTC)
Date:   Mon, 16 Aug 2021 00:35:05 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for
 btrfs export
Message-ID: <20210816003505.7b3e9861@natsu>
In-Reply-To: <bf49ef31-0c86-62c8-7862-719935764036@libero.it>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
        <162881913686.1695.12479588032010502384@noble.neil.brown.name>
        <bf49ef31-0c86-62c8-7862-719935764036@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 15 Aug 2021 09:39:08 +0200
Goffredo Baroncelli <kreijack@libero.it> wrote:

> I am sure that it was discussed already but I was unable to find any track
> of this discussion. But if the problem is the collision between the inode
> number of different subvolume in the nfd export, is it simpler if the export
> is truncated to the subvolume boundary ? It would be more coherent with the
> current behavior of vfs+nfsd.

See this bugreport thread which started it all:
https://www.spinics.net/lists/linux-btrfs/msg111172.html

In there the reporting user replied that it is strongly not feasible for them
to export each individual snapshot.

> In fact in btrfs a subvolume is a complete filesystem, with an "own
> synthetic" device. We could like or not this solution, but this solution is
> the more aligned to the unix standard, where for each filesystem there is a
> pair (device, inode-set). NFS (by default) avoids to cross the boundary
> between the filesystems. So why in BTRFS this should be different ?

From the user point of view subvolumes are basically directories; that they
are "complete filesystems"* is merely a low-level implementation detail.

* well except they are not, as you cannot 'dd' a subvolume to another
blockdevice.

> Why don't rename "ino_uniquifier" as "ino_and_subvolume" and leave to the
> filesystem the work to combine the inode and the subvolume-id ?
>
> I am worried that the logic is split between the filesystem, which
> synthesizes the ino_uniquifier, and to NFS which combine to the inode. I am
> thinking that this combination is filesystem specific; for BTRFS is a simple
> xor but for other filesystem may be a more complex operation, so leaving an
> half in the filesystem and another half to the NFS seems to not optimal if
> other filesystem needs to use ino_uniquifier.

I wondered a bit myself, what are the downsides of just doing the
uniquefication inside Btrfs, not leaving that to NFSD?

I mean not even adding the extra stat field, just return the inode itself with
that already applied. Surely cannot be any worse collision-wise, than
different subvolumes straight up having the same inode numbers as right now?

Or is it a performance concern, always doing more work, for something which
only NFSD has needed so far.

-- 
With respect,
Roman
