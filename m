Return-Path: <linux-fsdevel+bounces-63764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D3BCD6A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44FE54FE3F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387882F3C32;
	Fri, 10 Oct 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jaurS/f2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4+R2ASCX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JGOlqjXE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WIUbwg9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197E2F3C12
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105452; cv=none; b=gtrJyGpfhKW73q6SwGaCE8e2Raur5zMEMnIfI6DaWIPOlRrVl6S1CT0bPm5xZKx5RIChlVi6LRnvN/Zj3RVdi5hMEjS+8OFvfkpU5vH1NQ3dvb6a52HoThuBMLGrpDnGXScquKFYWExOvduLXv2yWWodfWMXAd6oUB4YiqdTPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105452; c=relaxed/simple;
	bh=QPJfdriJK2iFLTpkkWOdJrj4zCWZcE5I0cZUe5Yw6B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYbZJQy2PK5ErZpyd/emAuXElBBMnYSC5BMCLXJGicdczQ6Rb0UZg2GcHlTvskPIfKK7AWZjXSgo30ZNLimH6EBAlByu+0w6kOPV11AJPFIckRoDEEKM49kMWv6Iki3n6r5h9nG/rAMYdDCv4447DhFvYCl7FysifTS5zi6Et/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jaurS/f2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4+R2ASCX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JGOlqjXE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WIUbwg9/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E59021C0D;
	Fri, 10 Oct 2025 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ErIjK66osk82FTWO/jQC5uJK81C+Kfvbz1Ey31rSUx4=;
	b=jaurS/f2PCdHD59mxQQFWKkWQ9hSWOsobrG6BoxlwRlg9Ki1tfNyb5KYDEYCWlq0t47kE0
	XAcw4J/Ag4l3TRdvST+3Gh0w4tUdwWnUbBGl2d+kGSZ1ldu+i4r8DaHfDPOn7sNQBG1Ofo
	bOIjtKgUNXIsJn81hIAa19G3blHhHoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ErIjK66osk82FTWO/jQC5uJK81C+Kfvbz1Ey31rSUx4=;
	b=4+R2ASCXJy/0bveJNHmnDkLG0mNOpkfWngtzJTVP03/rSdKIoVDVkIabHDH2VeSQnUcXPw
	wProqLvakukID8BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JGOlqjXE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="WIUbwg9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ErIjK66osk82FTWO/jQC5uJK81C+Kfvbz1Ey31rSUx4=;
	b=JGOlqjXEz8OmfCaLMPT8ImfQuAq21zkyoeyL/INzUqGB2u75gG1TKNj0kOPF583Dz4xArd
	2SSukEjnG19xAcTfA/ITkAANN2cXyyC5ca/UVoZEsGZGiBiP++F/8v5At6FZOy2wiZaDK6
	mZAo/u4aomQnnFuqBhet3tL/BiVvbTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ErIjK66osk82FTWO/jQC5uJK81C+Kfvbz1Ey31rSUx4=;
	b=WIUbwg9/zMJZXm5CEl14A2CSSpdXAHx9pK4iZTfZsl7nr3JEYqN+nioK/s/4XLHCdj/t1E
	zoHSyC2c6xIp0WAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A88E1375D;
	Fri, 10 Oct 2025 14:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n6UbFucT6WjDBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:10:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D770EA0A58; Fri, 10 Oct 2025 16:10:45 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:10:45 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 05/14] Manual conversion to use ->i_state accessors of
 all places not covered by coccinelle
Message-ID: <7usoxyepocnzqniinh4ejyxu2qqsrbemmdrvdxucaoffl42dop@kt32jlimx7ll>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-6-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-6-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 6E59021C0D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 09-10-25 09:59:19, Mateusz Guzik wrote:
> Nothing to look at apart from iput_final().
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/porting.rst |  2 +-
>  fs/afs/inode.c                        |  2 +-
>  fs/ext4/inode.c                       | 10 +++++-----
>  fs/ext4/orphan.c                      |  4 ++--
>  fs/inode.c                            | 18 ++++++++----------
>  include/linux/backing-dev.h           |  2 +-
>  include/linux/fs.h                    |  6 +++---
>  include/linux/writeback.h             |  2 +-
>  include/trace/events/writeback.h      |  8 ++++----
>  9 files changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 7233b04668fc..35f027981b21 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -211,7 +211,7 @@ test and set for you.
>  e.g.::
>  
>  	inode = iget_locked(sb, ino);
> -	if (inode->i_state & I_NEW) {
> +	if (inode_state_read_once(inode) & I_NEW) {
>  		err = read_inode_from_disk(inode);
>  		if (err < 0) {
>  			iget_failed(inode);
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 2fe2ccf59c7a..dde1857fcabb 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -427,7 +427,7 @@ static void afs_fetch_status_success(struct afs_operation *op)
>  	struct afs_vnode *vnode = vp->vnode;
>  	int ret;
>  
> -	if (vnode->netfs.inode.i_state & I_NEW) {
> +	if (inode_state_read_once(&vnode->netfs.inode) & I_NEW) {
>  		ret = afs_inode_init_from_status(op, vp, vnode);
>  		afs_op_set_error(op, ret);
>  		if (ret == 0)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f9e4ac87211e..b864e9645f85 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
>  	if (!S_ISREG(inode->i_mode) ||
>  	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
>  	    is_special_ino(inode->i_sb, inode->i_ino) ||
> -	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
> +	    (inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
>  	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
>  	    ext4_verity_in_progress(inode))
>  		return;
> @@ -3473,7 +3473,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  	/* Any metadata buffers to write? */
>  	if (!list_empty(&inode->i_mapping->i_private_list))
>  		return true;
> -	return inode->i_state & I_DIRTY_DATASYNC;
> +	return inode_state_read_once(inode) & I_DIRTY_DATASYNC;
>  }
>  
>  static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
> @@ -4552,7 +4552,7 @@ int ext4_truncate(struct inode *inode)
>  	 * or it's a completely new inode. In those cases we might not
>  	 * have i_rwsem locked because it's not necessary.
>  	 */
> -	if (!(inode->i_state & (I_NEW|I_FREEING)))
> +	if (!(inode_state_read_once(inode) & (I_NEW | I_FREEING)))
>  		WARN_ON(!inode_is_locked(inode));
>  	trace_ext4_truncate_enter(inode);
>  
> @@ -5210,7 +5210,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	inode = iget_locked(sb, ino);
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
> -	if (!(inode->i_state & I_NEW)) {
> +	if (!(inode_state_read_once(inode) & I_NEW)) {
>  		ret = check_igot_inode(inode, flags, function, line);
>  		if (ret) {
>  			iput(inode);
> @@ -5541,7 +5541,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
>  	if (inode_is_dirtytime_only(inode)) {
>  		struct ext4_inode_info	*ei = EXT4_I(inode);
>  
> -		inode->i_state &= ~I_DIRTY_TIME;
> +		inode_state_clear(inode, I_DIRTY_TIME);
>  		spin_unlock(&inode->i_lock);
>  
>  		spin_lock(&ei->i_raw_lock);
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index 33c3a89396b1..c4903d98ff81 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -107,7 +107,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
>  	if (!sbi->s_journal || is_bad_inode(inode))
>  		return 0;
>  
> -	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
> +	WARN_ON_ONCE(!(inode_state_read_once(inode) & (I_NEW | I_FREEING)) &&
>  		     !inode_is_locked(inode));
>  	if (ext4_inode_orphan_tracked(inode))
>  		return 0;
> @@ -232,7 +232,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
>  	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
>  		return 0;
>  
> -	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
> +	WARN_ON_ONCE(!(inode_state_read_once(inode) & (I_NEW | I_FREEING)) &&
>  		     !inode_is_locked(inode));
>  	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
>  		return ext4_orphan_file_del(handle, inode);
> diff --git a/fs/inode.c b/fs/inode.c
> index f094ed3e6f30..3153d725859c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -829,7 +829,7 @@ static void evict(struct inode *inode)
>  	 * This also means we don't need any fences for the call below.
>  	 */
>  	inode_wake_up_bit(inode, __I_NEW);
> -	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
> +	BUG_ON(inode_state_read_once(inode) != (I_FREEING | I_CLEAR));
>  
>  	destroy_inode(inode);
>  }
> @@ -1883,7 +1883,6 @@ static void iput_final(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	const struct super_operations *op = inode->i_sb->s_op;
> -	unsigned long state;
>  	int drop;
>  
>  	WARN_ON(inode_state_read(inode) & I_NEW);
> @@ -1908,20 +1907,19 @@ static void iput_final(struct inode *inode)
>  	 */
>  	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
>  
> -	state = inode_state_read(inode);
> -	if (!drop) {
> -		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
> +	if (drop) {
> +		inode_state_set(inode, I_FREEING);
> +	} else {
> +		inode_state_set(inode, I_WILL_FREE);
>  		spin_unlock(&inode->i_lock);
>  
>  		write_inode_now(inode, 1);
>  
>  		spin_lock(&inode->i_lock);
> -		state = inode_state_read(inode);
> -		WARN_ON(state & I_NEW);
> -		state &= ~I_WILL_FREE;
> +		WARN_ON(inode_state_read(inode) & I_NEW);
> +		inode_state_replace(inode, I_WILL_FREE, I_FREEING);
>  	}
>  
> -	WRITE_ONCE(inode->i_state, state | I_FREEING);
>  	if (!list_empty(&inode->i_lru))
>  		inode_lru_list_del(inode);
>  	spin_unlock(&inode->i_lock);
> @@ -2985,7 +2983,7 @@ void dump_inode(struct inode *inode, const char *reason)
>  	pr_warn("%s encountered for inode %px\n"
>  		"fs %s mode %ho opflags 0x%hx flags 0x%x state 0x%x count %d\n",
>  		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
> -		inode->i_flags, inode->i_state, atomic_read(&inode->i_count));
> +		inode->i_flags, inode_state_read_once(inode), atomic_read(&inode->i_count));
>  }
>  
>  EXPORT_SYMBOL(dump_inode);
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 065cba5dc111..0c8342747cab 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -280,7 +280,7 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
>  	 * Paired with a release fence in inode_do_switch_wbs() and
>  	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
>  	 */
> -	cookie->locked = inode->i_state & I_WB_SWITCH;
> +	cookie->locked = inode_state_read_once(inode) & I_WB_SWITCH;
>  	smp_rmb();
>  
>  	if (unlikely(cookie->locked))
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 909eb1e68637..77b6486dcae7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1026,7 +1026,7 @@ static inline void inode_fake_hash(struct inode *inode)
>  static inline void wait_on_inode(struct inode *inode)
>  {
>  	wait_var_event(inode_state_wait_address(inode, __I_NEW),
> -		       !(READ_ONCE(inode->i_state) & I_NEW));
> +		       !(inode_state_read_once(inode) & I_NEW));
>  	/*
>  	 * Pairs with routines clearing I_NEW.
>  	 */
> @@ -2719,8 +2719,8 @@ static inline int icount_read(const struct inode *inode)
>   */
>  static inline bool inode_is_dirtytime_only(struct inode *inode)
>  {
> -	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
> -				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
> +	return (inode_state_read_once(inode) &
> +	       (I_DIRTY_TIME | I_NEW | I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
>  }
>  
>  extern void inc_nlink(struct inode *inode);
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 06195c2a535b..102071ffedcb 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -227,7 +227,7 @@ static inline void inode_attach_wb(struct inode *inode, struct folio *folio)
>  static inline void inode_detach_wb(struct inode *inode)
>  {
>  	if (inode->i_wb) {
> -		WARN_ON_ONCE(!(inode->i_state & I_CLEAR));
> +		WARN_ON_ONCE(!(inode_state_read_once(inode) & I_CLEAR));
>  		wb_put(inode->i_wb);
>  		inode->i_wb = NULL;
>  	}
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index c08aff044e80..311a341e6fe4 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -120,7 +120,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
>  		/* may be called for files on pseudo FSes w/ unregistered bdi */
>  		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
>  		__entry->ino		= inode->i_ino;
> -		__entry->state		= inode->i_state;
> +		__entry->state		= inode_state_read_once(inode);
>  		__entry->flags		= flags;
>  	),
>  
> @@ -748,7 +748,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  		strscpy_pad(__entry->name,
>  			    bdi_dev_name(inode_to_bdi(inode)), 32);
>  		__entry->ino		= inode->i_ino;
> -		__entry->state		= inode->i_state;
> +		__entry->state		= inode_state_read_once(inode);
>  		__entry->dirtied_when	= inode->dirtied_when;
>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
>  	),
> @@ -787,7 +787,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>  		strscpy_pad(__entry->name,
>  			    bdi_dev_name(inode_to_bdi(inode)), 32);
>  		__entry->ino		= inode->i_ino;
> -		__entry->state		= inode->i_state;
> +		__entry->state		= inode_state_read_once(inode);
>  		__entry->dirtied_when	= inode->dirtied_when;
>  		__entry->writeback_index = inode->i_mapping->writeback_index;
>  		__entry->nr_to_write	= nr_to_write;
> @@ -839,7 +839,7 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
>  	TP_fast_assign(
>  		__entry->dev	= inode->i_sb->s_dev;
>  		__entry->ino	= inode->i_ino;
> -		__entry->state	= inode->i_state;
> +		__entry->state	= inode_state_read_once(inode);
>  		__entry->mode	= inode->i_mode;
>  		__entry->dirtied_when = inode->dirtied_when;
>  	),
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

