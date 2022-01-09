Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1121488A2E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jan 2022 16:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiAIP1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jan 2022 10:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiAIP1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:27:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ED9C06173F;
        Sun,  9 Jan 2022 07:27:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C4A0B80C72;
        Sun,  9 Jan 2022 15:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEB8C36AED;
        Sun,  9 Jan 2022 15:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641742048;
        bh=3b6/4NoAXJJWUq2gsg5iKUmGqebtBOvDSo33LeKf8cI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a1hj3BUPWWcC7naVx2AqX6O5K4Bl3I+t2LBa9cQpCeBaYAyBwaQn/PS+HGCeidy8q
         V59tCbLL4SVGkupihAebTzDinf84wfBOUo5fKOH7h3X5A0HUfBNkBat2GC2klEJeJY
         z+IrlZGIg9r8ZNjuzIUxUmJMEv6GlWlOIoflShkFfNhrr3x3ss7+217Fc1LcujWwRm
         7pL1r7FXe40v8cxvGgS62Sd7KvDKkZkLRU+AyfWhS4/bR++UNpoDXsTk0iczsBxVVz
         WuIg7JKBR2T5fTONlCI3jYhT3vWzHFWf9ioixoaAQwvW7eDBJGFhPbJuSq/hJfW7C+
         gd+Ip0LdKRERQ==
Message-ID: <6e44856a8711bf1eb95c16de9efdb1bb108cf25c.camel@kernel.org>
Subject: Re: [PATCH v4 63/68] cifs: Support fscache indexing rewrite
 (untested)
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Steve French <sfrench@samba.org>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 09 Jan 2022 10:27:25 -0500
In-Reply-To: <3419813.1641592362@warthog.procyon.org.uk>
References: <164021579335.640689.2681324337038770579.stgit@warthog.procyon.org.uk>
         <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
         <3419813.1641592362@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-01-07 at 21:52 +0000, David Howells wrote:
> This patch isn't quite right and needs a fix.  The attached patch fixes it.
> I'll fold that in and post a v5 of this patch.
> 
> David
> ---
> cifs: Fix the fscache cookie management
> 
> Fix the fscache cookie management in cifs in the following ways:
> 
>  (1) The cookie should be released in cifs_evict_inode() after it has been
>      unused from being pinned by cifs_set_page_dirty().
> 
>  (2) The cookie shouldn't be released in cifsFileInfo_put_final().  That's
>      dealing with closing a file, not getting rid of an inode.  The cookie
>      needs to persist beyond the last file close because writepages may
>      happen after closure.
> 
>  (3) The cookie needs to be used in cifs_atomic_open() to match
>      cifs_open().  As yet unknown files being opened for writing seem to go
>      by the former route rather than the latter.
> 
> This can be triggered by something like:
> 
>         # systemctl start cachefilesd
>         # mount //carina/test /xfstest.test -o user=shares,pass=xxxx.fsc
>         # bash 5</xfstest.test/bar
>         # echo hello >/xfstest.test/bar
> 
> The key is to open the file R/O and then open it R/W and write to it whilst
> it's still open for R/O.  A cookie isn't acquired if it's just opened R/W
> as it goes through the atomic_open method rather than the open method.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  fs/cifs/cifsfs.c |    8 ++++++++
>  fs/cifs/dir.c    |    4 ++++
>  fs/cifs/file.c   |    2 --
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index d3f3acf340f1..26cf2193c9a2 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -398,6 +398,7 @@ cifs_evict_inode(struct inode *inode)
>  	truncate_inode_pages_final(&inode->i_data);
>  	if (inode->i_state & I_PINNING_FSCACHE_WB)
>  		cifs_fscache_unuse_inode_cookie(inode, true);
> +	cifs_fscache_release_inode_cookie(inode);
>  	clear_inode(inode);
>  }
>  
> @@ -722,6 +723,12 @@ static int cifs_show_stats(struct seq_file *s, struct dentry *root)
>  }
>  #endif
>  
> +static int cifs_write_inode(struct inode *inode, struct writeback_control *wbc)
> +{
> +	fscache_unpin_writeback(wbc, cifs_inode_cookie(inode));
> +	return 0;
> +}
> +
>  static int cifs_drop_inode(struct inode *inode)
>  {
>  	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
> @@ -734,6 +741,7 @@ static int cifs_drop_inode(struct inode *inode)
>  static const struct super_operations cifs_super_ops = {
>  	.statfs = cifs_statfs,
>  	.alloc_inode = cifs_alloc_inode,
> +	.write_inode	= cifs_write_inode,
>  	.free_inode = cifs_free_inode,
>  	.drop_inode	= cifs_drop_inode,
>  	.evict_inode	= cifs_evict_inode,
> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> index 6e8e7cc26ae2..6186824b366e 100644
> --- a/fs/cifs/dir.c
> +++ b/fs/cifs/dir.c
> @@ -22,6 +22,7 @@
>  #include "cifs_unicode.h"
>  #include "fs_context.h"
>  #include "cifs_ioctl.h"
> +#include "fscache.h"
>  
>  static void
>  renew_parental_timestamps(struct dentry *direntry)
> @@ -509,6 +510,9 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
>  		rc = -ENOMEM;
>  	}
>  
> +	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
> +			   file->f_mode & FMODE_WRITE);
> +
>  out:
>  	cifs_put_tlink(tlink);
>  out_free_xid:
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index d872f6fe8e7d..44da7646f789 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -376,8 +376,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
>  	struct cifsLockInfo *li, *tmp;
>  	struct super_block *sb = inode->i_sb;
>  
> -	cifs_fscache_release_inode_cookie(inode);
> -
>  	/*
>  	 * Delete any outstanding lock records. We'll lose them when the file
>  	 * is closed anyway.
> 

Looks good.

Acked-by: Jeff Layton <jlayton@kernel.org>
