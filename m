Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8DE5C64A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 02:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfGBAYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 20:24:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38560 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726866AbfGBAYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:24:04 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x620NuYE012079
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Jul 2019 20:23:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 042C742002E; Mon,  1 Jul 2019 20:23:55 -0400 (EDT)
Date:   Mon, 1 Jul 2019 20:23:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: [BUG] mke2fs produces corrupt filesystem if badblock list
 contains a block under 251
Message-ID: <20190702002355.GB3315@mit.edu>
References: <1562021070.2762.36.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562021070.2762.36.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 03:44:30PM -0700, James Bottomley wrote:
> Background: we actually use the badblocks feature of the ext filesystem
> group to do a poorman's boot filesystem for parisc: Our system chunks
> up the disk searching for an Initial Program Loader (IPL) signature and
> then executes it, so we poke a hole in an ext3 filesystem at creation
> time and place the IPL into it.  Our IP can read ext3 files and
> directories, so it allows us to load the kernel directly from the file.
> 
> The problem is that our IPL needs to be aligned at 256k in absolute
> terms on the disk, so, in the usual situation of having a 64k partition
> label and the boot partition being the first one we usually end up
> poking the badblock hole beginning at block 224 (using a 1k block
> size).
> 
> The problem is that this used to work long ago (where the value of long
> seems to be some time before 2011) but no longer does.  The problem can
> be illustrated simply by doing

It broke sometime around 2006.  E2fsprogs 1.39 is when we started
creating file systems with the resize inode to support the online
resize feature.

And the problem is with a 100M file system using 1k blocks, when you
reserve blocks 237 -- 258, you're conflicting with the reserved blocks
used for online resizing:

Group 0: (Blocks 1-8192)
  Primary superblock at 1, Group descriptors at 2-2
  Reserved GDT blocks at 3-258 <========= THIS
  Block bitmap at 451 (+450)
  Inode bitmap at 452 (+451)
  Inode table at 453-699 (+452)
  7456 free blocks, 1965 free inodes, 2 directories
  Free blocks: 715-8192
  Free inodes: 12-1976

It's a bug that mke2fs didn't notice this issue and give an error
message ("HAHAHAHA... NO.").  And it's also a bug that e2fsck didn't
correctly diagnose the nature of the corruption.  Both of these bugs
are because how the reserved blocks for online resizing are handled is
a bit of a special case.

In any case, the workaround is to do this:

# mke2fs -b 1024 -O ^resize_inode -l /home/jejb/bblist.txt  /dev/loop0

For bonus points, you could even add something like this to
/etc/mke2fs.conf:

[fs_types]
     parisc_boot = {
	features = ^resize_inode
	blocksize = 1024
	inode_size = 128
    }

Then all you would need to do something like this:

# mke2fs -T parisc_boot -l bblist.txt /dev/sda1


Also, I guess this answers the other question that had recently
crossed my mind, which is I had been thinking of deprecating and
eventually removing the badblock feature in e2fsprogs altogether,
since no sane user of badblocks should exist in 2019.  I guess I stand
corrected.  :-)

					- Ted

P.S.  Does this mean parisc has been using an amazingly obsolete
version of e2fsprogs, which is why no one had noticed?  Or was there a
static image file of the 100M boot partition, which you hadn't
regenerated until now.... ?
