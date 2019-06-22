Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2FE4F884
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2019 00:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfFVWSO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jun 2019 18:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFVWSO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jun 2019 18:18:14 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7D8C20862;
        Sat, 22 Jun 2019 22:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561241892;
        bh=aL5ZbVVWiFeYPbhaqN3zYqtsFHIMk0l/RXgTunPmNGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gk0P59ReUmP5WcLnj6sWDkMCVW2otxDLfVGqXBug3VcTyYRBpOPtjrdL6ECwn7Ao5
         3I/sPMbVqablLz07Q/tdfixwZojnbXqMbwhoGNGHFbUQkrTx0x7YtVfTPsat3WtdQV
         lFJA22AYsm4IhmWEowCbgTNEc8INfVCzS22KbGe8=
Date:   Sat, 22 Jun 2019 15:18:12 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 06/16] fs-verity: add inode and superblock fields
Message-ID: <20190622221812.GF19686@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-7-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620205043.64350-7-ebiggers@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/20, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Analogous to fs/crypto/, add fields to the VFS inode and superblock for
> use by the fs/verity/ support layer:
> 
> - ->s_vop: points to the fsverity_operations if the filesystem supports
>   fs-verity, otherwise is NULL.
> 
> - ->i_verity_info: points to cached fs-verity information for the inode
>   after someone opens it, otherwise is NULL.
> 
> - S_VERITY: bit in ->i_flags that identifies verity inodes, even when
>   they haven't been opened yet and thus still have NULL ->i_verity_info.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  include/linux/fs.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f7fdfe93e25d3e..a80a192cdcf285 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -64,6 +64,8 @@ struct workqueue_struct;
>  struct iov_iter;
>  struct fscrypt_info;
>  struct fscrypt_operations;
> +struct fsverity_info;
> +struct fsverity_operations;
>  struct fs_context;
>  struct fs_parameter_description;
>  
> @@ -723,6 +725,10 @@ struct inode {
>  	struct fscrypt_info	*i_crypt_info;
>  #endif
>  
> +#ifdef CONFIG_FS_VERITY
> +	struct fsverity_info	*i_verity_info;
> +#endif
> +
>  	void			*i_private; /* fs or device private pointer */
>  } __randomize_layout;
>  
> @@ -1429,6 +1435,9 @@ struct super_block {
>  	const struct xattr_handler **s_xattr;
>  #ifdef CONFIG_FS_ENCRYPTION
>  	const struct fscrypt_operations	*s_cop;
> +#endif
> +#ifdef CONFIG_FS_VERITY
> +	const struct fsverity_operations *s_vop;
>  #endif
>  	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
>  	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
> @@ -1964,6 +1973,7 @@ struct super_operations {
>  #endif
>  #define S_ENCRYPTED	16384	/* Encrypted file (using fs/crypto/) */
>  #define S_CASEFOLD	32768	/* Casefolded file */
> +#define S_VERITY	65536	/* Verity file (using fs/verity/) */
>  
>  /*
>   * Note that nosuid etc flags are inode-specific: setting some file-system
> @@ -2005,6 +2015,7 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
>  #define IS_DAX(inode)		((inode)->i_flags & S_DAX)
>  #define IS_ENCRYPTED(inode)	((inode)->i_flags & S_ENCRYPTED)
>  #define IS_CASEFOLDED(inode)	((inode)->i_flags & S_CASEFOLD)
> +#define IS_VERITY(inode)	((inode)->i_flags & S_VERITY)
>  
>  #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
>  				 (inode)->i_rdev == WHITEOUT_DEV)
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
