Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9471E7499F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjGFKzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjGFKyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:54:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F171BD9;
        Thu,  6 Jul 2023 03:54:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1FEB21DA8;
        Thu,  6 Jul 2023 10:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688640857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPzf1qKjrzW2/ZoQNeedY+MtGQ2h1fgv53LhpkhC6FQ=;
        b=2mv6RPMpg//bDTQf27iDVvkOUipUAECeVcrAJE+54Aka8dcsV8O2USXDP7vA/sxBUZFsPK
        W4U2vyTXlJMHJ7zRcZSTqHdOEY+9q/32EDKESIB8fTcs8LGHg+LgNtq78YjsHc8262x7RP
        Cy8axcV7b2S/nYNXG5W7LUtkjOdjP/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688640857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPzf1qKjrzW2/ZoQNeedY+MtGQ2h1fgv53LhpkhC6FQ=;
        b=Aaz1U0oC9k4h3rPKx4eDsleddfsJ8X47QZVIpNqc56fbK4x6jyeaPyP6k0JWO3sxmYOlrR
        Mflj1odJV5RRs7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B04FB138EE;
        Thu,  6 Jul 2023 10:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m10AK1mdpmSdBAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:54:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 52EEDA0707; Thu,  6 Jul 2023 12:54:17 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:54:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        codalist@coda.cs.cmu.edu
Subject: Re: [PATCH v2 31/92] coda: convert to ctime accessor functions
Message-ID: <20230706105417.v7i4w2eyfk4bvjhh@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-29-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-29-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:00:56, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/coda/coda_linux.c | 3 ++-
>  fs/coda/dir.c        | 2 +-
>  fs/coda/file.c       | 2 +-
>  fs/coda/inode.c      | 2 +-
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
> index 903ca8fa4b9b..ae023853a98f 100644
> --- a/fs/coda/coda_linux.c
> +++ b/fs/coda/coda_linux.c
> @@ -127,7 +127,8 @@ void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
>  	if (attr->va_mtime.tv_sec != -1)
>  		inode->i_mtime = coda_to_timespec64(attr->va_mtime);
>          if (attr->va_ctime.tv_sec != -1)
> -		inode->i_ctime = coda_to_timespec64(attr->va_ctime);
> +		inode_set_ctime_to_ts(inode,
> +				      coda_to_timespec64(attr->va_ctime));
>  }
>  
>  
> diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> index 8450b1bd354b..1d4f40048efc 100644
> --- a/fs/coda/dir.c
> +++ b/fs/coda/dir.c
> @@ -111,7 +111,7 @@ static inline void coda_dir_update_mtime(struct inode *dir)
>  	/* optimistically we can also act as if our nose bleeds. The
>  	 * granularity of the mtime is coarse anyways so we might actually be
>  	 * right most of the time. Note: we only do this for directories. */
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  #endif
>  }
>  
> diff --git a/fs/coda/file.c b/fs/coda/file.c
> index 12b26bd13564..42346618b4ed 100644
> --- a/fs/coda/file.c
> +++ b/fs/coda/file.c
> @@ -84,7 +84,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
>  	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
>  	coda_inode->i_size = file_inode(host_file)->i_size;
>  	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
> -	coda_inode->i_mtime = coda_inode->i_ctime = current_time(coda_inode);
> +	coda_inode->i_mtime = inode_set_ctime_current(coda_inode);
>  	inode_unlock(coda_inode);
>  	file_end_write(host_file);
>  
> diff --git a/fs/coda/inode.c b/fs/coda/inode.c
> index d661e6cf17ac..3e64679c1620 100644
> --- a/fs/coda/inode.c
> +++ b/fs/coda/inode.c
> @@ -269,7 +269,7 @@ int coda_setattr(struct mnt_idmap *idmap, struct dentry *de,
>  
>  	memset(&vattr, 0, sizeof(vattr)); 
>  
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	coda_iattr_to_vattr(iattr, &vattr);
>  	vattr.va_type = C_VNON; /* cannot set type */
>  
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
