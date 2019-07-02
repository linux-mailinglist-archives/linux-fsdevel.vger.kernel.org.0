Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222A25C67A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 02:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfGBAxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 20:53:37 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37284 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbfGBAxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:53:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 928818EE0E3;
        Mon,  1 Jul 2019 17:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562028816;
        bh=ziuFwfAaAOaRzTAhLJllzPXRQqxz5i1F923x1o9A8AM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Pvi8aPJMuGWkjN+Z/TudR8FB0jB7oFESWDQMxbJY6361yvwQHnwj5VsIqTtnZxzrf
         Coi0i1ifWiHKIaoqCfF2xbtm32c+tFnmeL7VZqePa9uYrJzWn0UYOEKMO6vCNJjxeS
         Hj3fLLi5intkUpYoD4H7GqocYRuJWOVE/o2AOSyA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YGa9hrlhEUxS; Mon,  1 Jul 2019 17:53:36 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 224E68EE0E0;
        Mon,  1 Jul 2019 17:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562028816;
        bh=ziuFwfAaAOaRzTAhLJllzPXRQqxz5i1F923x1o9A8AM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Pvi8aPJMuGWkjN+Z/TudR8FB0jB7oFESWDQMxbJY6361yvwQHnwj5VsIqTtnZxzrf
         Coi0i1ifWiHKIaoqCfF2xbtm32c+tFnmeL7VZqePa9uYrJzWn0UYOEKMO6vCNJjxeS
         Hj3fLLi5intkUpYoD4H7GqocYRuJWOVE/o2AOSyA=
Message-ID: <1562028814.2762.50.camel@HansenPartnership.com>
Subject: Re: [BUG] mke2fs produces corrupt filesystem if badblock list
 contains a block under 251
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Date:   Mon, 01 Jul 2019 17:53:34 -0700
In-Reply-To: <20190702002355.GB3315@mit.edu>
References: <1562021070.2762.36.camel@HansenPartnership.com>
         <20190702002355.GB3315@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-07-01 at 20:23 -0400, Theodore Ts'o wrote:
> On Mon, Jul 01, 2019 at 03:44:30PM -0700, James Bottomley wrote:
> > Background: we actually use the badblocks feature of the ext
> > filesystem group to do a poorman's boot filesystem for parisc: Our
> > system chunks up the disk searching for an Initial Program Loader
> > (IPL) signature and then executes it, so we poke a hole in an ext3
> > filesystem at creation time and place the IPL into it.  Our IP can
> > read ext3 files and directories, so it allows us to load the kernel
> > directly from the file.
> > 
> > The problem is that our IPL needs to be aligned at 256k in absolute
> > terms on the disk, so, in the usual situation of having a 64k
> > partition label and the boot partition being the first one we
> > usually end up poking the badblock hole beginning at block 224
> > (using a 1k block size).
> > 
> > The problem is that this used to work long ago (where the value of
> > long seems to be some time before 2011) but no longer does.  The
> > problem can be illustrated simply by doing
> 
> It broke sometime around 2006.  E2fsprogs 1.39 is when we started
> creating file systems with the resize inode to support the online
> resize feature.
> 
> And the problem is with a 100M file system using 1k blocks, when you
> reserve blocks 237 -- 258, you're conflicting with the reserved
> blocks used for online resizing:
> 
> Group 0: (Blocks 1-8192)
>   Primary superblock at 1, Group descriptors at 2-2
>   Reserved GDT blocks at 3-258 <========= THIS
>   Block bitmap at 451 (+450)
>   Inode bitmap at 452 (+451)
>   Inode table at 453-699 (+452)
>   7456 free blocks, 1965 free inodes, 2 directories
>   Free blocks: 715-8192
>   Free inodes: 12-1976
> 
> It's a bug that mke2fs didn't notice this issue and give an error
> message ("HAHAHAHA... NO.").  And it's also a bug that e2fsck didn't
> correctly diagnose the nature of the corruption.  Both of these bugs
> are because how the reserved blocks for online resizing are handled
> is a bit of a special case.
> 
> In any case, the workaround is to do this:
> 
> # mke2fs -b 1024 -O ^resize_inode -l
> /home/jejb/bblist.txt  /dev/loop0
> 
> For bonus points, you could even add something like this to
> /etc/mke2fs.conf:
> 
> [fs_types]
>      parisc_boot = {
> 	features = ^resize_inode
> 	blocksize = 1024
> 	inode_size = 128
>     }
> 
> Then all you would need to do something like this:
> 
> # mke2fs -T parisc_boot -l bblist.txt /dev/sda1

Actually, we control the location of the IPL, so as long as mke2fs
errors out if we get it wrong I can add an offset so it begins at >
sector 258.  Palo actually executed mke2fs when you initialize the
partition so it can add any options it likes. I was also thinking I
should update palo to support ext4 as well.

> Also, I guess this answers the other question that had recently
> crossed my mind, which is I had been thinking of deprecating and
> eventually removing the badblock feature in e2fsprogs altogether,
> since no sane user of badblocks should exist in 2019.  I guess I
> stand corrected.  :-)

Well, we don't have to use badblocks to achieve this, but we would like
a way to make an inode cover the reserved physical area of the IPL. 
Effectively it's a single contiguous area on disk with specific
absolute alignment constraints.  It doesn't actually matter if it
appears in the directory tree.

> 					- Ted
> 
> P.S.  Does this mean parisc has been using an amazingly obsolete
> version of e2fsprogs, which is why no one had noticed?  Or was there
> a static image file of the 100M boot partition, which you hadn't
> regenerated until now.... ?

Yes, since we only do this at boot, and we can actually update the IPL
on the fly when we need to because the space reserved is the maximum,
it only gets invoked on a reinitialization, which I haven't done for a
very long time.  The only reason I did it this time is because I have a
spare disk in a pa8800 which I used as an install target.

James

