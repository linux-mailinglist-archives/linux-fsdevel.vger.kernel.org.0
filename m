Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F33F282BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfEWQTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:19:22 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:38484 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbfEWQTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:19:21 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1hTqQv-0002uo-JE; Thu, 23 May 2019 18:19:09 +0200
Date:   Thu, 23 May 2019 18:19:09 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Jan Kara <jack@suse.cz>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, darrick.wong@oracle.com,
        dsterba@suse.cz, nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 12/18] btrfs: allow MAP_SYNC mmap
Message-ID: <20190523161909.GA10771@angband.pl>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-13-rgoldwyn@suse.de>
 <20190523134449.GC2949@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523134449.GC2949@quack2.suse.cz>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 03:44:49PM +0200, Jan Kara wrote:
> On Mon 29-04-19 12:26:43, Goldwyn Rodrigues wrote:
> > From: Adam Borowski <kilobyte@angband.pl>
> > 
> > Used by userspace to detect DAX.
> > [rgoldwyn@suse.com: Added CONFIG_FS_DAX around mmap_supported_flags]
> 
> Why the CONFIG_FS_DAX bit? Your mmap(2) implementation understands
> implications of MAP_SYNC flag and that's all that's needed to set
> .mmap_supported_flags.

Good point.

Also, that check will need to be updated when the pmem-virtio patchset goes
in.

> > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/btrfs/file.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 9d5a3c99a6b9..362a9cf9dcb2 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/btrfs.h>
> >  #include <linux/uio.h>
> >  #include <linux/iversion.h>
> > +#include <linux/mman.h>
> >  #include "ctree.h"
> >  #include "disk-io.h"
> >  #include "transaction.h"
> > @@ -3319,6 +3320,9 @@ const struct file_operations btrfs_file_operations = {
> >  	.splice_read	= generic_file_splice_read,
> >  	.write_iter	= btrfs_file_write_iter,
> >  	.mmap		= btrfs_file_mmap,
> > +#ifdef CONFIG_FS_DAX
> > +	.mmap_supported_flags = MAP_SYNC,
> > +#endif
> >  	.open		= btrfs_file_open,
> >  	.release	= btrfs_release_file,
> >  	.fsync		= btrfs_sync_file,
> > -- 
> > 2.16.4
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

-- 
⢀⣴⠾⠻⢶⣦⠀ Latin:   meow 4 characters, 4 columns,  4 bytes
⣾⠁⢠⠒⠀⣿⡁ Greek:   μεου 4 characters, 4 columns,  8 bytes
⢿⡄⠘⠷⠚⠋  Runes:   ᛗᛖᛟᚹ 4 characters, 4 columns, 12 bytes
⠈⠳⣄⠀⠀⠀⠀ Chinese: 喵   1 character,  2 columns,  3 bytes <-- best!
