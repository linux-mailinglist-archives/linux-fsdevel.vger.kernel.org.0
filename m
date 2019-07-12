Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8507E66813
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfGLIAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 04:00:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:36336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfGLIAZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:00:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DFFFAF83;
        Fri, 12 Jul 2019 08:00:23 +0000 (UTC)
Date:   Fri, 12 Jul 2019 10:00:22 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Message-ID: <20190712080022.GA16276@x250.microfocus.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190712030017.14321-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 12:00:17PM +0900, Damien Le Moal wrote:

Hi Daminen,

Thanks for submitting zonefs.

Please find my first few comments, I'll have a second look later as well.

[...]

> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  fs/Kconfig                 |    2 +
>  fs/Makefile                |    1 +
>  fs/zonefs/Kconfig          |    9 +
>  fs/zonefs/Makefile         |    4 +
>  fs/zonefs/super.c          | 1004 ++++++++++++++++++++++++++++++++++++
>  fs/zonefs/zonefs.h         |  190 +++++++
>  include/uapi/linux/magic.h |    1 +
>  7 files changed, 1211 insertions(+)
>  create mode 100644 fs/zonefs/Kconfig
>  create mode 100644 fs/zonefs/Makefile
>  create mode 100644 fs/zonefs/super.c
>  create mode 100644 fs/zonefs/zonefs.h

It'll probably be good to add yourself as a maitainer in MAINTAINERS, so
people see there's a go-to person for patches. Also a list (fsdevel@) and a
git tree won't harm.

> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index f1046cf6ad85..e48cc0e0efbb 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -41,6 +41,7 @@ source "fs/ocfs2/Kconfig"
>  source "fs/btrfs/Kconfig"
>  source "fs/nilfs2/Kconfig"
>  source "fs/f2fs/Kconfig"
> +source "fs/zonefs/Kconfig"
>  
>  config FS_DAX
>  	bool "Direct Access (DAX) support"
> @@ -262,6 +263,7 @@ source "fs/romfs/Kconfig"
>  source "fs/pstore/Kconfig"
>  source "fs/sysv/Kconfig"
>  source "fs/ufs/Kconfig"
> +source "fs/ufs/Kconfig"
>  

This hunk looks wrong.

>  endif # MISC_FILESYSTEMS
>  

[...]

> +	/*
> +	 * Note: The first zone contains the super block: skip it.
> +	 */

I know I've been advocating for having on-disk metadata, but do we really
sacrifice a whole zone per default? I thought we'll have on-disk metadata
optional (I might be completely off the track here and need more coffee to
wake up though).

> +	end = zones + sbi->s_nr_zones[ZONEFS_ZTYPE_ALL];
> +	for (zone = &zones[1]; zone < end; zone = next) {

[...]

> +
> +	/* Set defaults */
> +	sbi->s_uid = GLOBAL_ROOT_UID;
> +	sbi->s_gid = GLOBAL_ROOT_GID;
> +	sbi->s_perm = S_IRUSR | S_IWUSR | S_IRGRP; /* 0640 */
> +
> +
> +	ret = zonefs_read_super(sb);
> +	if (ret)
> +		return ret;

That would be cool to be controllable via a mount option and have it:
	sbi->s_uid = opt.uid;
	sbi->s_gid = opt.gid;
	sbi->s_perm = opt.mode;

or pass these mount options to zonefs_read_super() and they can be set after
the feature validation.

> +
> +	zones = zonefs_get_zone_info(sb);
> +	if (IS_ERR(zones))
> +		return PTR_ERR(zones);
> +
> +	pr_info("zonefs: Mounting %s, %u zones",
> +		sb->s_id, sbi->s_nr_zones[ZONEFS_ZTYPE_ALL]);
> +
> +	/* Create root directory inode */
> +	ret = -ENOMEM;
> +	inode = new_inode(sb);
> +	if (!inode)
> +		goto out;

Nit: please add a blank line after the goto.

> +	inode->i_ino = get_next_ino();
> +	inode->i_mode = S_IFDIR | 0755;
> +	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
> +	inode->i_op = &simple_dir_inode_operations;
> +	inode->i_fop = &simple_dir_operations;
> +	inode->i_size = sizeof(struct dentry) * 2;
> +	set_nlink(inode, 2);

Nit: please add a blank line here as well.

> +	sb->s_root = d_make_root(inode);
> +	if (!sb->s_root)
> +		goto out;

[...]

> +/*
> + * Maximum length of file names: this only needs to be large enough to fit
> + * the zone group directory names and a decimal value of the start sector of
> + * the zones for file names. 16 characterse is plenty.
                           characters ^

[...]

> +struct zonefs_super {
> +
> +	/* Magic number */
> +	__le32		s_magic;		/*    4 */
> +
> +	/* Metadata version number */
> +	__le32		s_version;		/*    8 */
> +
> +	/* Features */
> +	__le64		s_features;		/*   16 */
> +
> +	/* 128-bit uuid */
> +	__u8		s_uuid[16];		/*   32 */
> +
> +	/* UID/GID to use for files */
> +	__le32		s_uid;			/*   36 */
> +	__le32		s_gid;			/*   40 */
> +
> +	/* File permissions */
> +	__le32		s_perm;			/*   44 */
> +
> +	/* Padding to 4K */
> +	__u8		s_reserved[4052];	/* 4096 */
> +
> +} __attribute__ ((packed));

I'm not sure the (end)offset comments are of any value here, it's nothing that
can't be obtained from pahole or gdb (or even by hand).

> +
> +/*
> + * Metadata version.
> + */
> +#define ZONEFS_VERSION	1
> +
> +/*
> + * Feature flags.
> + */
> +enum zonefs_features {
> +	/*
> +	 * Use a zone start sector value as file name.
> +	 */
> +	ZONEFS_F_STARTSECT_NAME,
> +	/*
> +	 * Aggregate contiguous conventional zones into a single file.
> +	 */
> +	ZONEFS_F_AGRCNV,
> +	/*
> +	 * Use super block specified UID for files instead of default.
> +	 */
> +	ZONEFS_F_UID,
> +	/*
> +	 * Use super block specified GID for files instead of default.
> +	 */
> +	ZONEFS_F_GID,
> +	/*
> +	 * Use super block specified file permissions instead of default 640.
> +	 */
> +	ZONEFS_F_PERM,
> +};

I'd rather not write the uid, gid, permissions and startsect name to the
superblock but have it controllable via a mount option. Just write the feature
to the superblock so we know we _can_ control this per mount.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
