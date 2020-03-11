Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647B9180E29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 03:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCKCuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 22:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbgCKCuQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 22:50:16 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEDF220637;
        Wed, 11 Mar 2020 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583895015;
        bh=WtFMlLzPcU5BhKbuP+2KrYUwWQYx4yq+ffF9gx1TB4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1ystG146lhrdx1ECKnmJ+Gnq00mbVBlMiA9vl3KTF2QmR+GOfMmrR5MUFTybatwD
         ThRVdbuIcu+qHCl2Wz2aEBWCuC4NftqLMjxqT/L71EMNo6OcqflzJzuhbLoePIfyuA
         VrMxS7K+quWwG8SXU9sNgRZ+IAiV6J6SxXax9fNI=
Date:   Tue, 10 Mar 2020 19:50:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fscrypt: don't evict dirty inodes after removing key
Message-ID: <20200311025013.GB46757@gmail.com>
References: <20200305084138.653498-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305084138.653498-1-ebiggers@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 05, 2020 at 12:41:38AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> After FS_IOC_REMOVE_ENCRYPTION_KEY removes a key, it syncs the
> filesystem and tries to get and put all inodes that were unlocked by the
> key so that unused inodes get evicted via fscrypt_drop_inode().
> Normally, the inodes are all clean due to the sync.
> 
> However, after the filesystem is sync'ed, userspace can modify and close
> one of the files.  (Userspace is *supposed* to close the files before
> removing the key.  But it doesn't always happen, and the kernel can't
> assume it.)  This causes the inode to be dirtied and have i_count == 0.
> Then, fscrypt_drop_inode() failed to consider this case and indicated
> that the inode can be dropped, causing the write to be lost.
> 
> On f2fs, other problems such as a filesystem freeze could occur due to
> the inode being freed while still on f2fs's dirty inode list.
> 
> Fix this bug by making fscrypt_drop_inode() only drop clean inodes.
> 
> I've written an xfstest which detects this bug on ext4, f2fs, and ubifs.
> 
> Fixes: b1c0ec3599f4 ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl")
> Cc: <stable@vger.kernel.org> # v5.4+
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/crypto/keysetup.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> index 65cb09fa6ead..08c9f216a54d 100644
> --- a/fs/crypto/keysetup.c
> +++ b/fs/crypto/keysetup.c
> @@ -538,6 +538,15 @@ int fscrypt_drop_inode(struct inode *inode)
>  		return 0;
>  	mk = ci->ci_master_key->payload.data[0];
>  
> +	/*
> +	 * With proper, non-racy use of FS_IOC_REMOVE_ENCRYPTION_KEY, all inodes
> +	 * protected by the key were cleaned by sync_filesystem().  But if
> +	 * userspace is still using the files, inodes can be dirtied between
> +	 * then and now.  We mustn't lose any writes, so skip dirty inodes here.
> +	 */
> +	if (inode->i_state & I_DIRTY_ALL)
> +		return 0;
> +
>  	/*
>  	 * Note: since we aren't holding ->mk_secret_sem, the result here can
>  	 * immediately become outdated.  But there's no correctness problem with
> -- 

Applied to fscrypt.git#for-stable for 5.6.

- Eric
