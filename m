Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962E15D54D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGBRdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 13:33:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39746 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbfGBRdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:33:10 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62HX2i8005893
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 13:33:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C545142002E; Tue,  2 Jul 2019 13:33:01 -0400 (EDT)
Date:   Tue, 2 Jul 2019 13:33:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: [BUG] mke2fs produces corrupt filesystem if badblock list
 contains a block under 251
Message-ID: <20190702173301.GA3032@mit.edu>
References: <1562021070.2762.36.camel@HansenPartnership.com>
 <20190702002355.GB3315@mit.edu>
 <1562028814.2762.50.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562028814.2762.50.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 05:53:34PM -0700, James Bottomley wrote:
> 
> Actually, we control the location of the IPL, so as long as mke2fs
> errors out if we get it wrong I can add an offset so it begins at
> sector 258.  Palo actually executed mke2fs when you initialize the
> partition so it can add any options it likes. I was also thinking I
> should update palo to support ext4 as well.

If you never going to resize the boot partition, because it's fixed
size, you might as we not waste space on the reserving blocks for
online resize.  So having the palo bootloader be very restrictive
about what features it enables probably makes sense.

> Well, we don't have to use badblocks to achieve this, but we would like
> a way to make an inode cover the reserved physical area of the IPL. 
> Effectively it's a single contiguous area on disk with specific
> absolute alignment constraints.  It doesn't actually matter if it
> appears in the directory tree.

If you don't mind that it is visible in the namespace, you could take
advantage of the existing mk_hugefile feature[1][2]

[1] http://man7.org/linux/man-pages/man5/mke2fs.conf.5.html
[2] https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/misc/mk_hugefiles.c

# cat >> /etc/mke2fs.conf < EOF

[fs_types]
    palo_boot = {
    	features = ^resize_inode
	blocksize = 1024		 
    	make_hugefiles = true
	num_hugefiles = 1
	hugefiles_dir = /palo
	hugefiles_name = IPL
	hugefiles_size = 214k
	hugefiles_align = 256k
	hugefiles_align_disk = true
    }
EOF
# mke2fs -T palo_boot /dev/sda1

Something like this will create a 1k block file system, containing a
zero-filled /palo/IPL which is 214k long, aligned with respect to the
beginning of the disk at an 256k boundary.  (This feature was
sponsored by the letters, 'S', 'M', and 'R'.  :-)

If you wanted it to be hidden from the file system you could just drop
the hugefiles_dir line above, and then after mounting the file system
run open the /IPL file and then execute the EXT4_IOC_SWAP_BOOT ioctl
on it.  This will move those blocks so they are owned by inode #5, an
inode reserved for the boot loader.

Cheers,

       	       	    	       - Ted
