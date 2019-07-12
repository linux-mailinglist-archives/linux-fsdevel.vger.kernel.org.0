Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7D6694F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 10:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfGLIrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 04:47:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:48444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfGLIrV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:47:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A4B1AF58;
        Fri, 12 Jul 2019 08:47:19 +0000 (UTC)
Date:   Fri, 12 Jul 2019 10:47:18 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Message-ID: <20190712084718.GB16276@x250.microfocus.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <20190712080022.GA16276@x250.microfocus.com>
 <BN8PR04MB581241A65E81F79882508F4BE7F20@BN8PR04MB5812.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN8PR04MB581241A65E81F79882508F4BE7F20@BN8PR04MB5812.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 08:31:32AM +0000, Damien Le Moal wrote:
[...]
> > I know I've been advocating for having on-disk metadata, but do we really
> > sacrifice a whole zone per default? I thought we'll have on-disk metadata
> > optional (I might be completely off the track here and need more coffee to
> > wake up though).
> 
> Yes, indeed we do not really need the super block for now. But it is still super
> useful to have so that:
> 1) libblkid and other such userland tools can probe the disk to see its format,
> and preserve the usual "use -force option if you really want to overwrite"
> behavior of all format tools.
> 2) Still related to previous point, the super block allows commands like:
> mount /dev/sdX /mnt
> and
> mount -t zonefs /dev/sdX /mnt
> to have the same result. That is, without the super block, if the drive was
> previously formatted for btrfs or f2fs, the first command will mount that old
> format, while the second will mount zonefs without necessarily erasing the old
> FS super block.
> 3) Having the super block with a version number will allow in the future to add
> more metadata (e.g. file names as decided by the application) while allowing
> backward compatibility of the code.
> 
> >> +	end = zones + sbi->s_nr_zones[ZONEFS_ZTYPE_ALL];
> >> +	for (zone = &zones[1]; zone < end; zone = next) {
> > 
> > [...]
> > 
> >> +
> >> +	/* Set defaults */
> >> +	sbi->s_uid = GLOBAL_ROOT_UID;
> >> +	sbi->s_gid = GLOBAL_ROOT_GID;
> >> +	sbi->s_perm = S_IRUSR | S_IWUSR | S_IRGRP; /* 0640 */
> >> +
> >> +
> >> +	ret = zonefs_read_super(sb);
> >> +	if (ret)
> >> +		return ret;
> > 
> > That would be cool to be controllable via a mount option and have it:
> > 	sbi->s_uid = opt.uid;
> > 	sbi->s_gid = opt.gid;
> > 	sbi->s_perm = opt.mode;
> > 
> > or pass these mount options to zonefs_read_super() and they can be set after
> > the feature validation.
> 
> Yes, I thought of that and even had that implemented in a previous version. I
> switched to the static format time definition only so that the resulting
> operation of the FS is a little more like a normal file system, namely, mounting
> the device does not change file attributes and so can be mounted and seen with
> the same attribute no matter where it is mounted, regardless of the mount options.

[...]

> > I'd rather not write the uid, gid, permissions and startsect name to the
> > superblock but have it controllable via a mount option. Just write the feature
> > to the superblock so we know we _can_ control this per mount.
> 
> This is another view. See my thinking above. Thoughts ?

Hm, both a valid views and I'm not sure which is better for the production use
cases either.

With the approach I had in mind one could pre-format dozens of drives and
deploy them in the field. The admins then can decide what
UID/GID/Permission/etc.. the application layer needs for a particular drive
and supply these parameters on mount time.

With the approach you implemented here we don't have the surprises if someone
accidentally (or maliciously) passed the wrong parameters.

A combined approach is also not 100% discussion free, as what has preference,
on-disk or mount time.

I'll be thinking about it and come back once I have an idea.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
