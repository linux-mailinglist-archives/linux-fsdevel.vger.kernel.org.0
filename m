Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04305A2B50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbiHZPbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbiHZPbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:31:38 -0400
Received: from mail.stoffel.org (li1843-175.members.linode.com [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FCF399DC;
        Fri, 26 Aug 2022 08:31:34 -0700 (PDT)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 03776283F6;
        Fri, 26 Aug 2022 11:31:34 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 9A976A7E17; Fri, 26 Aug 2022 11:31:33 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25352.59221.528023.534884@quad.stoffel.home>
Date:   Fri, 26 Aug 2022 11:31:33 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/10] NFS: support parallel updates in the one directory.
In-Reply-To: <166147984378.25420.4023980607067991846.stgit@noble.brown>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
        <166147984378.25420.4023980607067991846.stgit@noble.brown>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>>> "NeilBrown" == NeilBrown  <neilb@suse.de> writes:

NeilBrown> NFS can easily support parallel updates as the locking is done on the
NeilBrown> server, so this patch enables parallel updates for NFS.

Just curious, how is this handled if I have a server with an EXT#
filesystem which is exported via NFS to multiple clients.  If those
NFS clients are doing lots of changes in a single directory, I can see
how the NFS server handles that, but what about if at the same time
someone does multiple changes on the server in that EXT# behind the
NFSd's back, how are the conflicts handled?

It would seem that this all really needs to purely happen at the VFS
layer, but I'm probably missing something.

I ask this because my home server exports /home to a couple of other
systems via NFS, but I still work in /home on the server.  


NeilBrown> Handling of silly-rename - both for unlink and for the rename target -
NeilBrown> requires some care as we need to get an exclusive lock on the chosen
NeilBrown> silly name and for rename we need to keep the original target name
NeilBrown> locked after it has been renamed to the silly name.

NeilBrown> So nfs_sillyrename() now uses d_exchange() to swap the target and the
NeilBrown> silly name after the silly-rename has happened on the server, and the
NeilBrown> silly dentry - which now has the name of the target - is returned.

NeilBrown> For unlink(), this is immediately unlocked and discarded with a call to
NeilBrown> nfs_sillyrename_finish().  For rename it is kept locked until the
NeilBrown> originally requested rename completes.

NeilBrown> Signed-off-by: NeilBrown <neilb@suse.de>
NeilBrown> ---
NeilBrown>  fs/dcache.c         |    5 ++++-
NeilBrown>  fs/nfs/dir.c        |   28 ++++++++++++++++------------
NeilBrown>  fs/nfs/fs_context.c |    6 ++++--
NeilBrown>  fs/nfs/internal.h   |    3 ++-
NeilBrown>  fs/nfs/unlink.c     |   51 ++++++++++++++++++++++++++++++++++++++-------------
NeilBrown>  5 files changed, 64 insertions(+), 29 deletions(-)

NeilBrown> diff --git a/fs/dcache.c b/fs/dcache.c
NeilBrown> index 9bf346a9de52..a5eaab16d39f 100644
NeilBrown> --- a/fs/dcache.c
NeilBrown> +++ b/fs/dcache.c
NeilBrown> @@ -3056,7 +3056,9 @@ void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
NeilBrown>  	write_seqlock(&rename_lock);
 
NeilBrown>  	WARN_ON(!dentry1->d_inode);
NeilBrown> -	WARN_ON(!dentry2->d_inode);
NeilBrown> +	/* Allow dentry2 to be negative, so we can do a rename
NeilBrown> +	 * but keep both names locked (DCACHE_PAR_UPDATE)
NeilBrown> +	 */
NeilBrown>  	WARN_ON(IS_ROOT(dentry1));
NeilBrown>  	WARN_ON(IS_ROOT(dentry2));
 
NeilBrown> @@ -3064,6 +3066,7 @@ void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
 
NeilBrown>  	write_sequnlock(&rename_lock);
NeilBrown>  }
NeilBrown> +EXPORT_SYMBOL(d_exchange);
 
NeilBrown>  /**
NeilBrown>   * d_ancestor - search for an ancestor
NeilBrown> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
NeilBrown> index 5d6c2ddc7ea6..fbb608fbe6bf 100644
NeilBrown> --- a/fs/nfs/dir.c
NeilBrown> +++ b/fs/nfs/dir.c
NeilBrown> @@ -1935,8 +1935,12 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
NeilBrown>  	/*
NeilBrown>  	 * If we're doing an exclusive create, optimize away the lookup
NeilBrown>  	 * but don't hash the dentry.
NeilBrown> +	 * A silly_rename is marked exclusive, but we need to do an
NeilBrown> +	 * explicit lookup.
NeilBrown>  	 */
NeilBrown> -	if (nfs_is_exclusive_create(dir, flags) || flags & LOOKUP_RENAME_TARGET)
NeilBrown> +	if ((nfs_is_exclusive_create(dir, flags) ||
NeilBrown> +	     flags & LOOKUP_RENAME_TARGET) &&
NeilBrown> +	    !(flags & LOOKUP_SILLY_RENAME))
NeilBrown>  		return NULL;
 
NeilBrown>  	res = ERR_PTR(-ENOMEM);
NeilBrown> @@ -2472,10 +2476,14 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
NeilBrown>  	spin_lock(&dentry->d_lock);
NeilBrown>  	if (d_count(dentry) > 1 && !test_bit(NFS_INO_PRESERVE_UNLINKED,
NeilBrown>  					     &NFS_I(d_inode(dentry))->flags)) {
NeilBrown> +		struct dentry *silly;
NeilBrown> +
NeilBrown>  		spin_unlock(&dentry->d_lock);
NeilBrown>  		/* Start asynchronous writeout of the inode */
NeilBrown>  		write_inode_now(d_inode(dentry), 0);
NeilBrown> -		error = nfs_sillyrename(dir, dentry);
NeilBrown> +		silly = nfs_sillyrename(dir, dentry);
NeilBrown> +		error = PTR_ERR_OR_ZERO(silly);
NeilBrown> +		nfs_sillyrename_finish(dir, silly);
NeilBrown>  		goto out;
NeilBrown>  	}
NeilBrown>  	/* We must prevent any concurrent open until the unlink
NeilBrown> @@ -2685,16 +2693,12 @@ int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
NeilBrown>  			spin_unlock(&new_dentry->d_lock);
 
NeilBrown> -			/* copy the target dentry's name */
NeilBrown> -			dentry = d_alloc(new_dentry->d_parent,
NeilBrown> -					 &new_dentry->d_name);
NeilBrown> -			if (!dentry)
NeilBrown> -				goto out;
NeilBrown> -
NeilBrown>  			/* silly-rename the existing target ... */
NeilBrown> -			err = nfs_sillyrename(new_dir, new_dentry);
NeilBrown> -			if (err)
NeilBrown> +			dentry = nfs_sillyrename(new_dir, new_dentry);
NeilBrown> +			if (IS_ERR(dentry)) {
NeilBrown> +				err = PTR_ERR(dentry);
NeilBrown>  				goto out;
NeilBrown> +			}
 
NeilBrown>  			new_dentry = dentry;
NeilBrown>  			new_inode = NULL;
NeilBrown> @@ -2750,9 +2754,9 @@ int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
NeilBrown>  	} else if (error == -ENOENT)
NeilBrown>  		nfs_dentry_handle_enoent(old_dentry);
 
NeilBrown> -	/* new dentry created? */
NeilBrown>  	if (dentry)
NeilBrown> -		dput(dentry);
NeilBrown> +		nfs_sillyrename_finish(new_dir, dentry);
NeilBrown> +
NeilBrown>  	return error;
NeilBrown>  }
NeilBrown>  EXPORT_SYMBOL_GPL(nfs_rename);
NeilBrown> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
NeilBrown> index 4da701fd1424..7133ca9433d2 100644
NeilBrown> --- a/fs/nfs/fs_context.c
NeilBrown> +++ b/fs/nfs/fs_context.c
NeilBrown> @@ -1577,7 +1577,8 @@ struct file_system_type nfs_fs_type = {
NeilBrown>  	.init_fs_context	= nfs_init_fs_context,
NeilBrown>  	.parameters		= nfs_fs_parameters,
NeilBrown>  	.kill_sb		= nfs_kill_super,
NeilBrown> -	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
NeilBrown> +	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
NeilBrown> +				  FS_PAR_DIR_UPDATE,
NeilBrown>  };
NeilBrown>  MODULE_ALIAS_FS("nfs");
NeilBrown>  EXPORT_SYMBOL_GPL(nfs_fs_type);
NeilBrown> @@ -1589,7 +1590,8 @@ struct file_system_type nfs4_fs_type = {
NeilBrown>  	.init_fs_context	= nfs_init_fs_context,
NeilBrown>  	.parameters		= nfs_fs_parameters,
NeilBrown>  	.kill_sb		= nfs_kill_super,
NeilBrown> -	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
NeilBrown> +	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
NeilBrown> +				  FS_PAR_DIR_UPDATE,
NeilBrown>  };
NeilBrown>  MODULE_ALIAS_FS("nfs4");
NeilBrown>  MODULE_ALIAS("nfs4");
NeilBrown> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
NeilBrown> index 27c720d71b4e..3a7fd30a8e29 100644
NeilBrown> --- a/fs/nfs/internal.h
NeilBrown> +++ b/fs/nfs/internal.h
NeilBrown> @@ -611,7 +611,8 @@ extern struct rpc_task *
NeilBrown>  nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
NeilBrown>  		 struct dentry *old_dentry, struct dentry *new_dentry,
NeilBrown>  		 void (*complete)(struct rpc_task *, struct nfs_renamedata *));
NeilBrown> -extern int nfs_sillyrename(struct inode *dir, struct dentry *dentry);
NeilBrown> +extern struct dentry *nfs_sillyrename(struct inode *dir, struct dentry *dentry);
NeilBrown> +extern void nfs_sillyrename_finish(struct inode *dir, struct dentry *dentry);
 
NeilBrown>  /* direct.c */
NeilBrown>  void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
NeilBrown> diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
NeilBrown> index 9697cd5d2561..c8a718f09fe6 100644
NeilBrown> --- a/fs/nfs/unlink.c
NeilBrown> +++ b/fs/nfs/unlink.c
NeilBrown> @@ -428,6 +428,10 @@ nfs_complete_sillyrename(struct rpc_task *task, struct nfs_renamedata *data)
NeilBrown>   *
NeilBrown>   * The final cleanup is done during dentry_iput.
NeilBrown>   *
NeilBrown> + * We exchange the original with the new (silly) dentries, and return
NeilBrown> + * the new dentry which will have the original name.  This ensures that
NeilBrown> + * the target name remains locked until the rename completes.
NeilBrown> + *
NeilBrown>   * (Note: NFSv4 is stateful, and has opens, so in theory an NFSv4 server
NeilBrown>   * could take responsibility for keeping open files referenced.  The server
NeilBrown>   * would also need to ensure that opened-but-deleted files were kept over
NeilBrown> @@ -436,7 +440,7 @@ nfs_complete_sillyrename(struct rpc_task *task, struct nfs_renamedata *data)
NeilBrown>   * use to advertise that it does this; some day we may take advantage of
NeilBrown>   * it.))
NeilBrown>   */
NeilBrown> -int
NeilBrown> +struct dentry *
NeilBrown>  nfs_sillyrename(struct inode *dir, struct dentry *dentry)
NeilBrown>  {
NeilBrown>  	static unsigned int sillycounter;
NeilBrown> @@ -445,6 +449,8 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
NeilBrown>  	struct dentry *sdentry;
NeilBrown>  	struct inode *inode = d_inode(dentry);
NeilBrown>  	struct rpc_task *task;
NeilBrown> +	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
NeilBrown> +	struct path path = {};
NeilBrown>  	int            error = -EBUSY;
 
NeilBrown>  	dfprintk(VFS, "NFS: silly-rename(%pd2, ct=%d)\n",
NeilBrown> @@ -459,10 +465,11 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 
NeilBrown>  	fileid = NFS_FILEID(d_inode(dentry));
 
NeilBrown> +	path.dentry = d_find_alias(dir);
NeilBrown>  	sdentry = NULL;
NeilBrown>  	do {
NeilBrown>  		int slen;
NeilBrown> -		dput(sdentry);
NeilBrown> +
NeilBrown>  		sillycounter++;
NeilBrown>  		slen = scnprintf(silly, sizeof(silly),
NeilBrown>  				SILLYNAME_PREFIX "%0*llx%0*x",
NeilBrown> @@ -472,14 +479,19 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
NeilBrown>  		dfprintk(VFS, "NFS: trying to rename %pd to %s\n",
NeilBrown>  				dentry, silly);
 
NeilBrown> -		sdentry = lookup_one_len(silly, dentry->d_parent, slen);
NeilBrown> -		/*
NeilBrown> -		 * N.B. Better to return EBUSY here ... it could be
NeilBrown> -		 * dangerous to delete the file while it's in use.
NeilBrown> -		 */
NeilBrown> -		if (IS_ERR(sdentry))
NeilBrown> -			goto out;
NeilBrown> -	} while (d_inode(sdentry) != NULL); /* need negative lookup */
NeilBrown> +		sdentry = filename_create_one_len(silly, slen,
NeilBrown> +						  &path,
NeilBrown> +						  LOOKUP_CREATE | LOOKUP_EXCL |
NeilBrown> +						  LOOKUP_SILLY_RENAME,
NeilBrown> +						  &wq);
NeilBrown> +	} while (PTR_ERR_OR_ZERO(sdentry) == -EEXIST);
NeilBrown> +	dput(path.dentry);
NeilBrown> +	/*
NeilBrown> +	 * N.B. Better to return EBUSY here ... it could be
NeilBrown> +	 * dangerous to delete the file while it's in use.
NeilBrown> +	 */
NeilBrown> +	if (IS_ERR(sdentry))
NeilBrown> +		goto out;
 
NeilBrown>  	ihold(inode);
 
NeilBrown> @@ -513,7 +525,7 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
NeilBrown>  						     NFS_INO_INVALID_CTIME |
NeilBrown>  						     NFS_INO_REVAL_FORCED);
NeilBrown>  		spin_unlock(&inode->i_lock);
NeilBrown> -		d_move(dentry, sdentry);
NeilBrown> +		d_exchange(dentry, sdentry);
NeilBrown>  		break;
NeilBrown>  	case -ERESTARTSYS:
NeilBrown>  		/* The result of the rename is unknown. Play it safe by
NeilBrown> @@ -524,7 +536,20 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
NeilBrown>  	rpc_put_task(task);
NeilBrown>  out_dput:
NeilBrown>  	iput(inode);
NeilBrown> -	dput(sdentry);
NeilBrown> +	if (!error)
NeilBrown> +		return sdentry;
NeilBrown> +
NeilBrown> +	d_lookup_done(sdentry);
NeilBrown> +	__done_path_update(&path, sdentry, true, LOOKUP_SILLY_RENAME);
NeilBrown>  out:
NeilBrown> -	return error;
NeilBrown> +	return ERR_PTR(error);
NeilBrown> +}
NeilBrown> +
NeilBrown> +void nfs_sillyrename_finish(struct inode *dir, struct dentry *dentry)
NeilBrown> +{
NeilBrown> +	struct path path = { .dentry = d_find_alias(dir) };
NeilBrown> +
NeilBrown> +	if (!IS_ERR(dentry))
NeilBrown> +		__done_path_update(&path, dentry, true, LOOKUP_SILLY_RENAME);
NeilBrown> +	dput(path.dentry);
NeilBrown>  }


