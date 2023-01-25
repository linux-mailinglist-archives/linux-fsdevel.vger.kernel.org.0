Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9367AD88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjAYJNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAYJNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:13:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C83242DCF;
        Wed, 25 Jan 2023 01:13:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 542DC1FED6;
        Wed, 25 Jan 2023 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674638002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e4VrMGyfypl4tz1uXeNuESnRWwjS0UHF28cDMxitjFw=;
        b=2hkn8XQwTrWF/rdZq+JYhEM6axyOnMm4YD/ejapuFdLs7IYEgPv/GvMkDwGCa7Ntv3QBRJ
        cMQsbk0M8PkPZgRtZmqZluq6bp4/eNMTA2QecSMvYyKChYq8aGdHXz94yTYIla53C/7uX5
        1DXNzbiopjZKC+7wRPXxFhvjHEC72QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674638002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e4VrMGyfypl4tz1uXeNuESnRWwjS0UHF28cDMxitjFw=;
        b=V1He43snFn0CZAimkMBbkFRWiSveIdS7Q0dLdO28TeABCbmB+kQIz0QLqLPKIJ4XKietAA
        yF4KRd6ZqVYQzFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 479681339E;
        Wed, 25 Jan 2023 09:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Unp2EbLy0GOTEgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:13:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CA891A06B5; Wed, 25 Jan 2023 10:13:21 +0100 (CET)
Date:   Wed, 25 Jan 2023 10:13:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: build the legacy direct I/O code conditionally
Message-ID: <20230125091321.jhueo4cqppd2ieb6@quack3>
References: <20230125065839.191256-1-hch@lst.de>
 <20230125065839.191256-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125065839.191256-3-hch@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 25-01-23 07:58:39, Christoph Hellwig wrote:
> Add a new LEGACY_DIRECT_IO config symbol that is only selected by the
> file systems that still use the legacy blockdev_direct_IO code, so that
> kernels without support for those file systems don't need to build the
> code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/Kconfig          | 4 ++++
>  fs/Makefile         | 3 ++-
>  fs/affs/Kconfig     | 1 +
>  fs/exfat/Kconfig    | 1 +
>  fs/ext2/Kconfig     | 1 +
>  fs/fat/Kconfig      | 1 +
>  fs/hfs/Kconfig      | 1 +
>  fs/hfsplus/Kconfig  | 1 +
>  fs/jfs/Kconfig      | 1 +
>  fs/nilfs2/Kconfig   | 1 +
>  fs/ntfs3/Kconfig    | 1 +
>  fs/ocfs2/Kconfig    | 1 +
>  fs/reiserfs/Kconfig | 1 +
>  fs/udf/Kconfig      | 1 +
>  14 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 2685a4d0d35318..e99830c650336a 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -18,6 +18,10 @@ config VALIDATE_FS_PARSER
>  config FS_IOMAP
>  	bool
>  
> +# old blockdev_direct_IO implementation.  Use iomap for new code instead
> +config LEGACY_DIRECT_IO
> +	bool
> +
>  if BLOCK
>  
>  source "fs/ext2/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index 4dea17840761a0..606c029e1c9bc3 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -19,13 +19,14 @@ obj-y :=	open.o read_write.o file_table.o super.o \
>  		kernel_read_file.o remap_range.o
>  
>  ifeq ($(CONFIG_BLOCK),y)
> -obj-y +=	buffer.o direct-io.o mpage.o
> +obj-y +=	buffer.o mpage.o
>  else
>  obj-y +=	no-block.o
>  endif
>  
>  obj-$(CONFIG_PROC_FS) += proc_namespace.o
>  
> +obj-$(CONFIG_LEGACY_DIRECT_IO)	+= direct-io.o
>  obj-y				+= notify/
>  obj-$(CONFIG_EPOLL)		+= eventpoll.o
>  obj-y				+= anon_inodes.o
> diff --git a/fs/affs/Kconfig b/fs/affs/Kconfig
> index eb9d0ab850cb1d..962b86374e1c15 100644
> --- a/fs/affs/Kconfig
> +++ b/fs/affs/Kconfig
> @@ -2,6 +2,7 @@
>  config AFFS_FS
>  	tristate "Amiga FFS file system support"
>  	depends on BLOCK
> +	select LEGACY_DIRECT_IO
>  	help
>  	  The Fast File System (FFS) is the common file system used on hard
>  	  disks by Amiga(tm) systems since AmigaOS Version 1.3 (34.20).  Say Y
> diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
> index 5a65071b5ecf10..147edeb044691d 100644
> --- a/fs/exfat/Kconfig
> +++ b/fs/exfat/Kconfig
> @@ -3,6 +3,7 @@
>  config EXFAT_FS
>  	tristate "exFAT filesystem support"
>  	select NLS
> +	select LEGACY_DIRECT_IO
>  	help
>  	  This allows you to mount devices formatted with the exFAT file system.
>  	  exFAT is typically used on SD-Cards or USB sticks.
> diff --git a/fs/ext2/Kconfig b/fs/ext2/Kconfig
> index 1248ff4ef56254..77393fda99af09 100644
> --- a/fs/ext2/Kconfig
> +++ b/fs/ext2/Kconfig
> @@ -2,6 +2,7 @@
>  config EXT2_FS
>  	tristate "Second extended fs support"
>  	select FS_IOMAP
> +	select LEGACY_DIRECT_IO
>  	help
>  	  Ext2 is a standard Linux file system for hard disks.
>  
> diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
> index 238cc55f84c429..afe83b4e717280 100644
> --- a/fs/fat/Kconfig
> +++ b/fs/fat/Kconfig
> @@ -2,6 +2,7 @@
>  config FAT_FS
>  	tristate
>  	select NLS
> +	select LEGACY_DIRECT_IO
>  	help
>  	  If you want to use one of the FAT-based file systems (the MS-DOS and
>  	  VFAT (Windows 95) file systems), then you must say Y or M here
> diff --git a/fs/hfs/Kconfig b/fs/hfs/Kconfig
> index 129926b5142d8f..d985066006d588 100644
> --- a/fs/hfs/Kconfig
> +++ b/fs/hfs/Kconfig
> @@ -3,6 +3,7 @@ config HFS_FS
>  	tristate "Apple Macintosh file system support"
>  	depends on BLOCK
>  	select NLS
> +	select LEGACY_DIRECT_IO
>  	help
>  	  If you say Y here, you will be able to mount Macintosh-formatted
>  	  floppy disks and hard drive partitions with full read-write access.
> diff --git a/fs/hfsplus/Kconfig b/fs/hfsplus/Kconfig
> index 7d4229aecec05b..8034e7827a690b 100644
> --- a/fs/hfsplus/Kconfig
> +++ b/fs/hfsplus/Kconfig
> @@ -4,6 +4,7 @@ config HFSPLUS_FS
>  	depends on BLOCK
>  	select NLS
>  	select NLS_UTF8
> +	select LEGACY_DIRECT_IO
>  	help
>  	  If you say Y here, you will be able to mount extended format
>  	  Macintosh-formatted hard drive partitions with full read-write access.
> diff --git a/fs/jfs/Kconfig b/fs/jfs/Kconfig
> index 05cb0e8e4382ee..51e856f0e4b8d6 100644
> --- a/fs/jfs/Kconfig
> +++ b/fs/jfs/Kconfig
> @@ -3,6 +3,7 @@ config JFS_FS
>  	tristate "JFS filesystem support"
>  	select NLS
>  	select CRC32
> +	select LEGACY_DIRECT_IO
>  	help
>  	  This is a port of IBM's Journaled Filesystem .  More information is
>  	  available in the file <file:Documentation/admin-guide/jfs.rst>.
> diff --git a/fs/nilfs2/Kconfig b/fs/nilfs2/Kconfig
> index 254d102e79c99b..7d59567465e121 100644
> --- a/fs/nilfs2/Kconfig
> +++ b/fs/nilfs2/Kconfig
> @@ -2,6 +2,7 @@
>  config NILFS2_FS
>  	tristate "NILFS2 file system support"
>  	select CRC32
> +	select LEGACY_DIRECT_IO
>  	help
>  	  NILFS2 is a log-structured file system (LFS) supporting continuous
>  	  snapshotting.  In addition to versioning capability of the entire
> diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> index 6e4cbc48ab8e43..96cc236f7f7bd3 100644
> --- a/fs/ntfs3/Kconfig
> +++ b/fs/ntfs3/Kconfig
> @@ -2,6 +2,7 @@
>  config NTFS3_FS
>  	tristate "NTFS Read-Write file system support"
>  	select NLS
> +	select LEGACY_DIRECT_IO
>  	help
>  	  Windows OS native file system (NTFS) support up to NTFS version 3.1.
>  
> diff --git a/fs/ocfs2/Kconfig b/fs/ocfs2/Kconfig
> index 5d11380d872417..304d12186ccd38 100644
> --- a/fs/ocfs2/Kconfig
> +++ b/fs/ocfs2/Kconfig
> @@ -7,6 +7,7 @@ config OCFS2_FS
>  	select QUOTA
>  	select QUOTA_TREE
>  	select FS_POSIX_ACL
> +	select LEGACY_DIRECT_IO
>  	help
>  	  OCFS2 is a general purpose extent based shared disk cluster file
>  	  system with many similarities to ext3. It supports 64 bit inode
> diff --git a/fs/reiserfs/Kconfig b/fs/reiserfs/Kconfig
> index 33c8b0dd07a2e7..4d22ecfe0fab65 100644
> --- a/fs/reiserfs/Kconfig
> +++ b/fs/reiserfs/Kconfig
> @@ -2,6 +2,7 @@
>  config REISERFS_FS
>  	tristate "Reiserfs support (deprecated)"
>  	select CRC32
> +	select LEGACY_DIRECT_IO
>  	help
>  	  Reiserfs is deprecated and scheduled to be removed from the kernel
>  	  in 2025. If you are still using it, please migrate to another
> diff --git a/fs/udf/Kconfig b/fs/udf/Kconfig
> index 26e1a49f3ba795..82e8bfa2dfd989 100644
> --- a/fs/udf/Kconfig
> +++ b/fs/udf/Kconfig
> @@ -3,6 +3,7 @@ config UDF_FS
>  	tristate "UDF file system support"
>  	select CRC_ITU_T
>  	select NLS
> +	select LEGACY_DIRECT_IO
>  	help
>  	  This is a file system used on some CD-ROMs and DVDs. Since the
>  	  file system is supported by multiple operating systems and is more
> -- 
> 2.39.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
