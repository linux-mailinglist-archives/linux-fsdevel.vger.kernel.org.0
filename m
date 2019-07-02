Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29465D6E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 21:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfGBTbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 15:31:36 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54080 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfGBTbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:31:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BA8828EE1D2;
        Tue,  2 Jul 2019 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562095895;
        bh=JBX/2nO3FHARX4ymbcJkMjTq0cIFdufNkCgkEvhO5ME=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=w115Mw0J5VCsK4dt7uurP9KI+RZW90cUV7gZLeb8g19q9kf+epy9wePLMtOzMQPQU
         n3HBjCjsUlQ8rCEVug30ewsRQUDtj1kwgxhgs7zrTSUHvDRaO4rfaojt2XVax6xrxC
         NH9d07J3R5g04AIRomzvuXG+ynk9Lc92iIIDzEB4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1Cdmh94aPKqA; Tue,  2 Jul 2019 12:31:35 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 456F08EE0CC;
        Tue,  2 Jul 2019 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562095895;
        bh=JBX/2nO3FHARX4ymbcJkMjTq0cIFdufNkCgkEvhO5ME=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=w115Mw0J5VCsK4dt7uurP9KI+RZW90cUV7gZLeb8g19q9kf+epy9wePLMtOzMQPQU
         n3HBjCjsUlQ8rCEVug30ewsRQUDtj1kwgxhgs7zrTSUHvDRaO4rfaojt2XVax6xrxC
         NH9d07J3R5g04AIRomzvuXG+ynk9Lc92iIIDzEB4=
Message-ID: <1562095894.3321.52.camel@HansenPartnership.com>
Subject: Re: [BUG] mke2fs produces corrupt filesystem if badblock list
 contains a block under 251
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Date:   Tue, 02 Jul 2019 12:31:34 -0700
In-Reply-To: <20190702173301.GA3032@mit.edu>
References: <1562021070.2762.36.camel@HansenPartnership.com>
         <20190702002355.GB3315@mit.edu>
         <1562028814.2762.50.camel@HansenPartnership.com>
         <20190702173301.GA3032@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-07-02 at 13:33 -0400, Theodore Ts'o wrote:
> On Mon, Jul 01, 2019 at 05:53:34PM -0700, James Bottomley wrote:
> > 
> > Actually, we control the location of the IPL, so as long as mke2fs
> > errors out if we get it wrong I can add an offset so it begins at
> > sector 258.  Palo actually executed mke2fs when you initialize the
> > partition so it can add any options it likes. I was also thinking I
> > should update palo to support ext4 as well.
> 
> If you never going to resize the boot partition, because it's fixed
> size, you might as we not waste space on the reserving blocks for
> online resize.  So having the palo bootloader be very restrictive
> about what features it enables probably makes sense.

Yes, I think given I've only created one partition in the last ten
years, that's reasonable.  I was just worrying about eliminating a
feature which could later become mandatory, but if it never will,
that's not a problem.  However, moving the bootloader is also very
simple, so if 

> > Well, we don't have to use badblocks to achieve this, but we would
> > like a way to make an inode cover the reserved physical area of the
> > IPL.  Effectively it's a single contiguous area on disk with
> > specific absolute alignment constraints.  It doesn't actually
> > matter if it appears in the directory tree.
> 
> If you don't mind that it is visible in the namespace, you could take
> advantage of the existing mk_hugefile feature[1][2]
> 
> [1] http://man7.org/linux/man-pages/man5/mke2fs.conf.5.html
> [2] https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/misc/mk
> _hugefiles.c
> 
> # cat >> /etc/mke2fs.conf < EOF
> 
> [fs_types]
>     palo_boot = {
>     	features = ^resize_inode
> 	blocksize = 1024		 
>     	make_hugefiles = true
> 	num_hugefiles = 1
> 	hugefiles_dir = /palo
> 	hugefiles_name = IPL
> 	hugefiles_size = 214k
> 	hugefiles_align = 256k
> 	hugefiles_align_disk = true
>     }
> EOF
> # mke2fs -T palo_boot /dev/sda1
> 
> Something like this will create a 1k block file system, containing a
> zero-filled /palo/IPL which is 214k long, aligned with respect to the
> beginning of the disk at an 256k boundary.  (This feature was
> sponsored by the letters, 'S', 'M', and 'R'.  :-)

Actually, this is giving me:

mke2fs: Operation not supported for inodes containing extents while
creating huge files

Is that because it's an ext4 only feature?

Having it visible is useful for updating the IPL, which occurs more
often than intializing the partition.

James

> If you wanted it to be hidden from the file system you could just
> drop the hugefiles_dir line above, and then after mounting the file
> system run open the /IPL file and then execute the EXT4_IOC_SWAP_BOOT
> ioctl on it.  This will move those blocks so they are owned by inode
> #5, an inode reserved for the boot loader.
> 
> Cheers,
> 
>        	       	    	       - Ted
> 

