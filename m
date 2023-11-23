Return-Path: <linux-fsdevel+bounces-3584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2F57F6B3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A104C1F20EF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207E53AA;
	Fri, 24 Nov 2023 04:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="agUeiy+m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UUPLwpzX"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 99 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 20:19:21 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA5D43;
	Thu, 23 Nov 2023 20:19:21 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D36D01FD14;
	Thu, 23 Nov 2023 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700753592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omeWePB3jH6tIgfQoj8aRvHvFRnEFTlgknAY1wCXGoU=;
	b=agUeiy+mXLYfptxnifo6GkUdb6gDP+S7iYTI+TBDR7orWZWNjulyvAN/A3M68PeLzYATQz
	LvInQv4emsDYrpxjfdyExBOjL9cfA5bSzJN3yUD8YuU8GTofOumb2Vg9xyXT3rSPPGuDAQ
	FoOFvOUFG/foLOXpxkXje6OVer6CqSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700753592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omeWePB3jH6tIgfQoj8aRvHvFRnEFTlgknAY1wCXGoU=;
	b=UUPLwpzXbPgqzNm4TugN2s0bkxoe8qMx5ZRbUvDEQVV1zuSwy6sthWxdlXLRMVpJWhOHSb
	8SQ1Is1qz1EL9FAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 059DF13A82;
	Thu, 23 Nov 2023 11:57:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zMEEAS0+X2WiZgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 11:57:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5AF64A07DB; Thu, 23 Nov 2023 10:31:12 +0100 (CET)
Date: Thu, 23 Nov 2023 10:31:12 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] ext4: don't access the source subdirectory content
 on same-directory rename
Message-ID: <20231123093112.rkgqmyaocisvyeyh@quack3>
References: <20231122193028.GE38156@ZenIV>
 <20231122193652.419091-1-viro@zeniv.linux.org.uk>
 <20231122193652.419091-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122193652.419091-5-viro@zeniv.linux.org.uk>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.60
X-Spam-Level: 
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,gmail.com,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed 22-11-23 19:36:48, Al Viro wrote:
> We can't really afford locking the source on same-directory rename;
> currently vfs_rename() tries to do that, but it will have to be changed.
> The logics in ext4 is lazy and goes looking for ".." in source even in
> same-directory case.  It's not hard to get rid of that, leaving that
> behaviour only for cross-directory case; that VFS can get locks safely
> (and will keep doing that after the coming changes).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index d252935f9c8a..467ba47a691c 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3591,10 +3591,14 @@ struct ext4_renament {
>  	int dir_inlined;
>  };
>  
> -static int ext4_rename_dir_prepare(handle_t *handle, struct ext4_renament *ent)
> +static int ext4_rename_dir_prepare(handle_t *handle, struct ext4_renament *ent, bool is_cross)
>  {
>  	int retval;
>  
> +	ent->is_dir = true;
> +	if (!is_cross)
> +		return 0;
> +
>  	ent->dir_bh = ext4_get_first_dir_block(handle, ent->inode,
>  					      &retval, &ent->parent_de,
>  					      &ent->dir_inlined);
> @@ -3612,6 +3616,9 @@ static int ext4_rename_dir_finish(handle_t *handle, struct ext4_renament *ent,
>  {
>  	int retval;
>  
> +	if (!ent->dir_bh)
> +		return 0;
> +
>  	ent->parent_de->inode = cpu_to_le32(dir_ino);
>  	BUFFER_TRACE(ent->dir_bh, "call ext4_handle_dirty_metadata");
>  	if (!ent->dir_inlined) {
> @@ -3900,7 +3907,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  			if (new.dir != old.dir && EXT4_DIR_LINK_MAX(new.dir))
>  				goto end_rename;
>  		}
> -		retval = ext4_rename_dir_prepare(handle, &old);
> +		retval = ext4_rename_dir_prepare(handle, &old, new.dir != old.dir);
>  		if (retval)
>  			goto end_rename;
>  	}
> @@ -3964,7 +3971,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	}
>  	inode_set_mtime_to_ts(old.dir, inode_set_ctime_current(old.dir));
>  	ext4_update_dx_flag(old.dir);
> -	if (old.dir_bh) {
> +	if (old.is_dir) {
>  		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
>  		if (retval)
>  			goto end_rename;
> @@ -3987,7 +3994,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	if (unlikely(retval))
>  		goto end_rename;
>  
> -	if (S_ISDIR(old.inode->i_mode)) {
> +	if (old.is_dir) {
>  		/*
>  		 * We disable fast commits here that's because the
>  		 * replay code is not yet capable of changing dot dot
> @@ -4114,14 +4121,12 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		ext4_handle_sync(handle);
>  
>  	if (S_ISDIR(old.inode->i_mode)) {
> -		old.is_dir = true;
> -		retval = ext4_rename_dir_prepare(handle, &old);
> +		retval = ext4_rename_dir_prepare(handle, &old, new.dir != old.dir);
>  		if (retval)
>  			goto end_rename;
>  	}
>  	if (S_ISDIR(new.inode->i_mode)) {
> -		new.is_dir = true;
> -		retval = ext4_rename_dir_prepare(handle, &new);
> +		retval = ext4_rename_dir_prepare(handle, &new, new.dir != old.dir);
>  		if (retval)
>  			goto end_rename;
>  	}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

