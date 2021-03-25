Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524563495D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 16:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhCYPlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 11:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhCYPld (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:41:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63DB461A1A;
        Thu, 25 Mar 2021 15:41:32 +0000 (UTC)
Date:   Thu, 25 Mar 2021 16:41:29 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: swapfile warnings
Message-ID: <20210325154129.wf2qiwuybv7sad5j@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey,

I've been running xfstests on a v5.12-rc3 kernel using a swapfile:

ubuntu@edfu|~
> cat /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sdb1 during curtin installation
/dev/disk/by-uuid/f2c4df25-b55c-4d1b-95fa-059f72ef86eb / ext4 defaults 0 0
/swap.img       none    swap    sw      0       0

where my rootfs is ext4:

ubuntu@edfu|~
> findmnt | grep -i ext4
/                                     /dev/sdb1              ext4       rw,relatime

In addition to the /dev/sdb disk I have three other disks attached:

ubuntu@edfu|~
> lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
loop0    7:0    0  55.5M  1 loop /snap/core18/1988
loop1    7:1    0  69.9M  1 loop /snap/lxd/19188
loop2    7:2    0  70.4M  1 loop /snap/lxd/19647
loop3    7:3    0  32.3M  1 loop /snap/snapd/11107
loop4    7:4    0  32.3M  1 loop /snap/snapd/11402
sda      8:0    0 931.5G  0 disk
sdb      8:16   0 223.6G  0 disk
└─sdb1   8:17   0 223.6G  0 part /
sdc      8:32   0 279.5G  0 disk
sdd      8:48   0 931.5G  0 disk

I'm using two of them /dev/sdc and /dev/sdb for xfstests:

ubuntu@edfu|~/src/git/xfstests
> cat local.config
# Ideally define at least these 4 to match your environment
# The first 2 are required.
# See README for other variables which can be set.
#
# Note: SCRATCH_DEV >will< get overwritten!

export FSTYP=xfs
export TEST_DEV=/dev/sdc
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/sdd
export SCRATCH_MNT=/mnt/scratch

when the system gets under load during test runs I assume it sometimes
swaps and so sometimes I see the following messages pop up:

> sudo journalctl | grep -i swapon
Mar 21 00:00:58 edfu kernel: swapon: file has shared extents
Mar 21 02:25:52 edfu kernel: swapon: file has unallocated extents
Mar 21 21:38:12 edfu kernel: swapon: file has shared extents
Mar 22 00:16:03 edfu kernel: swapon: file has unallocated extents
Mar 23 11:49:46 edfu kernel: swapon: file has shared extents
Mar 23 12:34:38 edfu kernel: swapon: file has unallocated extents

I don't know enough about swapfiles to make any deep observations but I
wonder what this can be caused by and whether this is something to worry
about.

Christian
