Return-Path: <linux-fsdevel+bounces-6182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01D814988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41291284DDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B1F2DF9E;
	Fri, 15 Dec 2023 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lw270NG4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dqlEYDWh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lw270NG4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dqlEYDWh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947992DB8B;
	Fri, 15 Dec 2023 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ADAA91FE1A;
	Fri, 15 Dec 2023 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702647852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S2cgVTUxvRqiURRedKmVqJU+Akymyd8v6asPAEOTZTw=;
	b=lw270NG4xpp8rrs8hM5/kPPtzv9f7cFFkqJH6pHJrjg2Sv2eAobVvDBeoyZLfdCRg1btUy
	xyBTU+9jHM+5N+2B3eHo8Yv2+yavU+oStyp0trvKjIQGk/kvy+kgtJAS7r4FExapGl3nh1
	bSGoF+x+8GziY+5kEIr7oYMwZ+4q0NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702647852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S2cgVTUxvRqiURRedKmVqJU+Akymyd8v6asPAEOTZTw=;
	b=dqlEYDWhZa6eEJwC5t40rDVYm2cD/h86P1VSsOtndVrMxQQ5YHSOn1nnkwa84jCWg0ysxL
	GRmwcLL1dwKHfoAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702647852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S2cgVTUxvRqiURRedKmVqJU+Akymyd8v6asPAEOTZTw=;
	b=lw270NG4xpp8rrs8hM5/kPPtzv9f7cFFkqJH6pHJrjg2Sv2eAobVvDBeoyZLfdCRg1btUy
	xyBTU+9jHM+5N+2B3eHo8Yv2+yavU+oStyp0trvKjIQGk/kvy+kgtJAS7r4FExapGl3nh1
	bSGoF+x+8GziY+5kEIr7oYMwZ+4q0NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702647852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S2cgVTUxvRqiURRedKmVqJU+Akymyd8v6asPAEOTZTw=;
	b=dqlEYDWhZa6eEJwC5t40rDVYm2cD/h86P1VSsOtndVrMxQQ5YHSOn1nnkwa84jCWg0ysxL
	GRmwcLL1dwKHfoAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 995FD13A08;
	Fri, 15 Dec 2023 13:44:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hzUuJSxYfGV3XQAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 15 Dec 2023 13:44:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 244DEA07E0; Fri, 15 Dec 2023 14:44:12 +0100 (CET)
Date: Fri, 15 Dec 2023 14:44:12 +0100
From: Jan Kara <jack@suse.cz>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix doc comment typo fs tree wide
Message-ID: <20231215134412.eghjpfsfam2bvgnr@quack3>
References: <20231215130927.136917-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215130927.136917-1-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Level: **
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lw270NG4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dqlEYDWh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,suse.cz:dkim,suse.cz:email,linux.org.uk:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: ADAA91FE1A
X-Spam-Flag: NO

On Fri 15-12-23 14:09:27, Alexander Mikhalitsyn wrote:
> Do the replacement:
> s/simply passs @nop_mnt_idmap/simply passs @nop_mnt_idmap/
> in the fs/ tree.
> 
> Found by chance while working on support for idmapped mounts in fuse.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Sure, thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/attr.c      |  2 +-
>  fs/inode.c     |  2 +-
>  fs/namei.c     | 22 +++++++++++-----------
>  fs/posix_acl.c |  4 ++--
>  fs/stat.c      |  2 +-
>  5 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index bdf5deb06ea9..5a13f0c8495f 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -157,7 +157,7 @@ static bool chgrp_ok(struct mnt_idmap *idmap,
>   * the vfsmount must be passed through @idmap. This function will then
>   * take care to map the inode according to @idmap before checking
>   * permissions. On non-idmapped mounts or if permission checking is to be
> - * performed on the raw inode simply passs @nop_mnt_idmap.
> + * performed on the raw inode simply pass @nop_mnt_idmap.
>   *
>   * Should be called as the first thing in ->setattr implementations,
>   * possibly after taking additional locks.
> diff --git a/fs/inode.c b/fs/inode.c
> index edcd8a61975f..60d0667cbd27 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2402,7 +2402,7 @@ EXPORT_SYMBOL(inode_init_owner);
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  bool inode_owner_or_capable(struct mnt_idmap *idmap,
>  			    const struct inode *inode)
> diff --git a/fs/namei.c b/fs/namei.c
> index 71c13b2990b4..200eb919cdc0 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -289,7 +289,7 @@ EXPORT_SYMBOL(putname);
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  static int check_acl(struct mnt_idmap *idmap,
>  		     struct inode *inode, int mask)
> @@ -334,7 +334,7 @@ static int check_acl(struct mnt_idmap *idmap,
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  static int acl_permission_check(struct mnt_idmap *idmap,
>  				struct inode *inode, int mask)
> @@ -395,7 +395,7 @@ static int acl_permission_check(struct mnt_idmap *idmap,
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  int generic_permission(struct mnt_idmap *idmap, struct inode *inode,
>  		       int mask)
> @@ -3158,7 +3158,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	       struct dentry *dentry, umode_t mode, bool want_excl)
> @@ -3646,7 +3646,7 @@ static int do_open(struct nameidata *nd,
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  static int vfs_tmpfile(struct mnt_idmap *idmap,
>  		       const struct path *parentpath,
> @@ -3954,7 +3954,7 @@ EXPORT_SYMBOL(user_path_create);
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	      struct dentry *dentry, umode_t mode, dev_t dev)
> @@ -4080,7 +4080,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	      struct dentry *dentry, umode_t mode)
> @@ -4161,7 +4161,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  		     struct dentry *dentry)
> @@ -4290,7 +4290,7 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
>  	       struct dentry *dentry, struct inode **delegated_inode)
> @@ -4443,7 +4443,7 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  		struct dentry *dentry, const char *oldname)
> @@ -4535,7 +4535,7 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
>   * the vfsmount must be passed through @idmap. This function will then take
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs @nop_mnt_idmap.
> + * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
>  	     struct inode *dir, struct dentry *new_dentry,
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index a05fe94970ce..e1af20893ebe 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -600,7 +600,7 @@ EXPORT_SYMBOL(__posix_acl_chmod);
>   * the vfsmount must be passed through @idmap. This function will then
>   * take care to map the inode according to @idmap before checking
>   * permissions. On non-idmapped mounts or if permission checking is to be
> - * performed on the raw inode simply passs @nop_mnt_idmap.
> + * performed on the raw inode simply pass @nop_mnt_idmap.
>   */
>  int
>   posix_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry,
> @@ -700,7 +700,7 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
>   * the vfsmount must be passed through @idmap. This function will then
>   * take care to map the inode according to @idmap before checking
>   * permissions. On non-idmapped mounts or if permission checking is to be
> - * performed on the raw inode simply passs @nop_mnt_idmap.
> + * performed on the raw inode simply pass @nop_mnt_idmap.
>   *
>   * Called from set_acl inode operations.
>   */
> diff --git a/fs/stat.c b/fs/stat.c
> index 24bb0209e459..0ab525f80a49 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -41,7 +41,7 @@
>   * the vfsmount must be passed through @idmap. This function will then
>   * take care to map the inode according to @idmap before filling in the
>   * uid and gid filds. On non-idmapped mounts or if permission checking is to be
> - * performed on the raw inode simply passs @nop_mnt_idmap.
> + * performed on the raw inode simply pass @nop_mnt_idmap.
>   */
>  void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
>  		      struct inode *inode, struct kstat *stat)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

