Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE631FF49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfD3SFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 14:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfD3SFM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:05:12 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D23421670;
        Tue, 30 Apr 2019 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556647510;
        bh=/OrHy1Or/tyMkA8JUJFX7tmvV8Be/iBCONobI1vb+xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fANeawP5TAq6sRMZ/KC3wd91yZDKR94hcwD2nevA76D5zwVKGGSEThU3yNO4Eitf9
         Xfp9tIhoNQJwVu1DnMNi/wYu1fyC8rXQzk3ZZ+asjjsOQuNgiGvJ4kesxWA258NbF8
         yZVsqVqmOAjshcPPqPltf8l640w0/DHpRH49Wyxc=
Date:   Tue, 30 Apr 2019 11:05:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V2 02/13] Consolidate "read callbacks" into a new file
Message-ID: <20190430180507.GD48973@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190428043121.30925-3-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190428043121.30925-3-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 28, 2019 at 10:01:10AM +0530, Chandan Rajendra wrote:
> The "read callbacks" code is used by both Ext4 and F2FS. Hence to
> remove duplicity, this commit moves the code into
> include/linux/read_callbacks.h and fs/read_callbacks.c.
> 
> The corresponding decrypt and verity "work" functions have been moved
> inside fscrypt and fsverity sources. With these in place, the read
> callbacks code now has to just invoke enqueue functions provided by
> fscrypt and fsverity.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/Kconfig                     |   4 +
>  fs/Makefile                    |   4 +
>  fs/crypto/Kconfig              |   1 +
>  fs/crypto/bio.c                |  23 ++---
>  fs/crypto/crypto.c             |  17 +--
>  fs/crypto/fscrypt_private.h    |   3 +
>  fs/ext4/ext4.h                 |   2 -
>  fs/ext4/readpage.c             | 183 +++++----------------------------
>  fs/ext4/super.c                |   9 +-
>  fs/f2fs/data.c                 | 148 ++++----------------------
>  fs/f2fs/super.c                |   9 +-
>  fs/read_callbacks.c            | 136 ++++++++++++++++++++++++
>  fs/verity/Kconfig              |   1 +
>  fs/verity/verify.c             |  12 +++
>  include/linux/fscrypt.h        |  20 +---
>  include/linux/read_callbacks.h |  21 ++++
>  16 files changed, 251 insertions(+), 342 deletions(-)
>  create mode 100644 fs/read_callbacks.c
>  create mode 100644 include/linux/read_callbacks.h
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 97f9eb8df713..03084f2dbeaf 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -308,6 +308,10 @@ config NFS_COMMON
>  	depends on NFSD || NFS_FS || LOCKD
>  	default y
>  
> +config FS_READ_CALLBACKS
> +       bool
> +       default n
> +
>  source "net/sunrpc/Kconfig"
>  source "fs/ceph/Kconfig"
>  source "fs/cifs/Kconfig"

This shouldn't be under the 'if NETWORK_FILESYSTEMS' block, since it has nothing
to do with network filesystems.  When trying to compile this I got:

	WARNING: unmet direct dependencies detected for FS_READ_CALLBACKS
	  Depends on [n]: NETWORK_FILESYSTEMS [=n]
	  Selected by [y]:
	  - FS_ENCRYPTION [=y]
	  - FS_VERITY [=y]

Perhaps put it just below FS_IOMAP?

> diff --git a/fs/Makefile b/fs/Makefile
> index 9dd2186e74b5..e0c0fce8cf40 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -21,6 +21,10 @@ else
>  obj-y +=	no-block.o
>  endif
>  
> +ifeq ($(CONFIG_FS_READ_CALLBACKS),y)
> +obj-y +=	read_callbacks.o
> +endif
> +
>  obj-$(CONFIG_PROC_FS) += proc_namespace.o
>  
>  obj-y				+= notify/
> diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
> index f0de238000c0..163c328bcbd4 100644
> --- a/fs/crypto/Kconfig
> +++ b/fs/crypto/Kconfig
> @@ -8,6 +8,7 @@ config FS_ENCRYPTION
>  	select CRYPTO_CTS
>  	select CRYPTO_SHA256
>  	select KEYS
> +	select FS_READ_CALLBACKS
>  	help
>  	  Enable encryption of files and directories.  This
>  	  feature is similar to ecryptfs, but it is more memory

This selection needs to be conditional on BLOCK.

	select FS_READ_CALLBACKS if BLOCK

Otherwise, building without BLOCK and with UBIFS encryption support fails.

	fs/read_callbacks.c: In function ‘end_read_callbacks’:
	fs/read_callbacks.c:34:23: error: storage size of ‘iter_all’ isn’t known
	  struct bvec_iter_all iter_all;
			       ^~~~~~~~
	fs/read_callbacks.c:37:20: error: dereferencing pointer to incomplete type ‘struct buffer_head’
	   if (!PageError(bh->b_page))

	[...]

- Eric
