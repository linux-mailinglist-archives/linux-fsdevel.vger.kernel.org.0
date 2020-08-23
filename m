Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C9C24ECB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Aug 2020 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHWKQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Aug 2020 06:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgHWKQq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Aug 2020 06:16:46 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B41E32075B;
        Sun, 23 Aug 2020 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598177805;
        bh=sNNU0HlYekzwB0yfQZcmKIYq2ZWNe4GIlaHSv3C2l9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKxqZMhRzqVjwR2QmOX3sxlP6fn47/3fYdnBtc6mArmbJHLBzQCI1MWeCAOWblRmu
         GscRa4oXOF85qjvNybdV+J5Y6goEuWhuu4irt4fcqe3URt/LFGfwQo6H6rgiqgB2h8
         o/H/nv4cNEhWjZmZj+s6yqwhQMYn3EphvxKuQ4ss=
Received: by pali.im (Postfix)
        id E9490EA3; Sun, 23 Aug 2020 12:16:43 +0200 (CEST)
Date:   Sun, 23 Aug 2020 12:16:43 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Message-ID: <20200823101643.2qljlqzxne4r32am@pali>
References: <74de75d537ac486e9fcfe7931181a9b9@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74de75d537ac486e9fcfe7931181a9b9@paragon-software.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 21 August 2020 16:25:37 Konstantin Komarov wrote:
> +Mount Options
> +=============
> +
> +The list below describes mount options supported by NTFS3 driver in addtion to
> +generic ones.
> +
> +===============================================================================
> +
> +nls=name		These options inform the driver how to interpret path
> +			strings and translate them to Unicode and back. In case
> +			none of these options are set, or if specified codepage
> +			doesn't exist on the system, the default codepage will be
> +			used (CONFIG_NLS_DEFAULT).
> +			Examples:
> +				'nls=utf8'
> +
> +uid=
> +gid=

IIRC ntfs filesystem had concept of storing unix owner/group. Was it
dropped? Or it is incompatible with current Windows implementation? I'm
just curious if we cannot use ntfs-native unix permissions instead of
forcing them from mount options. Maybe as improvement for future.

Normally owner/group on ntfs is stored in that windows SID format.
ntfs-3g fuse driver has some mount option where you can specify mapping
table between SID and unix to make permissions compatible with existing
windows installations.

Such functionality could be a nice feature once somebody would have time
to implement it in future...

> +umask=			Controls the default permissions for files/directories created
> +			after the NTFS volume is mounted.
> +
> +fmask=
> +dmask=			Instead of specifying umask which applies both to
> +			files and directories, fmask applies only to files and
> +			dmask only to directories.
> +
> +nohidden		Files with the Windows-specific HIDDEN (FILE_ATTRIBUTE_HIDDEN)
> +			attribute will not be shown under Linux.

What other people think? It is useful mount option which would disallow
access to hidden files? Hidden attribute is normal attribute which even
normal user without admin rights on Windows can set on its own files.

Also concept of hidden files is already present for fat filesystems and
we do not have such mount option nor for msdosfs, vfat nor for exfat.

Konstantin, what is purpose of this mount option? I would like to know
what usecases have this option.

> +sys_immutable		Files with the Windows-specific SYSTEM
> +			(FILE_ATTRIBUTE_SYSTEM) attribute will be marked as system
> +			immutable files.
> +
> +discard			Enable support of the TRIM command for improved performance
> +			on delete operations, which is recommended for use with the
> +			solid-state drives (SSD).
> +
> +force			Forces the driver to mount partitions even if 'dirty' flag
> +			(volume dirty) is set. Not recommended for use.
> +
> +sparse			Create new files as "sparse".
> +
> +showmeta		Use this parameter to show all meta-files (System Files) on
> +			a mounted NTFS partition.
> +			By default, all meta-files are hidden.
> +
> +no_acs_rules		"No access rules" mount option sets access rights for
> +			files/folders to 777 and owner/group to root. This mount
> +			option absorbs all other permissions:
> +			- permissions change for files/folders will be reported
> +				as successful, but they will remain 777;
> +			- owner/group change will be reported as successful, but
> +				they will stay as root

What about rather adding "mode=" and "dmode=" mount option which would
specify permissions for all files and directories? Other filesystems
have support for "mode=" mount option and I think it is better if
filesystems have some "common" options and not each filesystem its own
mount option for similar features.

> diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> new file mode 100644
> index 000000000000..92a9c68008c8
> --- /dev/null
> +++ b/fs/ntfs3/Kconfig
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NTFS3_FS
> +	tristate "NTFS Read-Write file system support"
> +	select NLS
> +	help
> +	  Windows OS native file system (NTFS) support up to NTFS version 3.1.
> +
> +	  Y or M enables the NTFS3 driver with full features enabled (read,
> +	  write, journal replaying, sparse/compressed files support).
> +	  File system type to use on mount is "ntfs3". Module name (M option)
> +	  is also "ntfs3".
> +
> +	  Documentation: <file:Documentation/filesystems/ntfs3.rst>
> +
> +config NTFS3_64BIT_CLUSTER
> +	bool "64 bits per NTFS clusters"
> +	depends on NTFS3_FS && 64BIT
> +	help
> +	  Windows implementation of ntfs.sys uses 32 bits per clusters.
> +	  If activated 64 bits per clusters you will be able to use 4k cluster
> +	  for 16T+ volumes. Windows will not be able to mount such volumes.

Would it be possible to change this compile time option into mount
option?

Because I do not see any benefit in compile time option which makes
kernel's ntfs driver "fully" incompatible with Windows implementation.

For me it looks like that mount option for such functionality is more
suitable.
