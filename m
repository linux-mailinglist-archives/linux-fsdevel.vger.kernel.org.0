Return-Path: <linux-fsdevel+bounces-79629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBC2Ct7yqmncYwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 16:29:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9450B223CD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CCB030AA7C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7553BD642;
	Fri,  6 Mar 2026 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3amuKMwh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wwov2LW6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3amuKMwh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wwov2LW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356503BD637
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810730; cv=none; b=qZOUiUFrNKpj0g3gSKCeGO1TklQP+xMrKt26nvjKL24TOEghLymM2ht4wlUl1cZ/45YkwMIMyMCRwYxL3yuZVssMWog/fFatyV6jagoNxdSwdRACIQ/bMT8TjnQdf2uM8VLiWV4BQuHGiI5LRbQogSGDKArxxvbJL29NIktwa58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810730; c=relaxed/simple;
	bh=FIJPT2ytJZ3Qsl3qNmclYY/zx742CdL2zVehVZ0Zkto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJkjb2GpujSIC+kaUbCipEb0EVU/0pEABFolpjiZONL3qsV/VB5+EicIdXDramKMZIy5FDJlLHhWo48Kcc/B7aT88eJPlDWXddggq27a48LbI6hNSPTy9/h9xnImuKhRjyB4QR4c3uQS12mB6/W6FjsPxDVg3zjJwZPJVCQbMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3amuKMwh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wwov2LW6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3amuKMwh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wwov2LW6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52AAC3E6F7;
	Fri,  6 Mar 2026 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772810727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsB2TCDrL3VjreiID5Dmg1otW+nyqzxO42mbu6p0Nzg=;
	b=3amuKMwhWtxDw1E1wKkerRfamvs1CDYq8E5Jlr+owLQomaZQBk+Le9ENx5APPhIRB9Zj6k
	3Qfh+wBw4Zzzn2U/dfbiJAZVAT8L2ZgizIao+Q/auL2+0tTkUcol0cxA54n//95Tv1RvQC
	Doe1cDjx3wXXZB4zAOuUPqdEhJ4C8kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772810727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsB2TCDrL3VjreiID5Dmg1otW+nyqzxO42mbu6p0Nzg=;
	b=wwov2LW61Ele1iXshdztuQLPkzrnmdT+XthNwClIc8zjJH1nLesYU599PPSnEq2rVycqAl
	cHer8A94cQ6c5kCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3amuKMwh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wwov2LW6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772810727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsB2TCDrL3VjreiID5Dmg1otW+nyqzxO42mbu6p0Nzg=;
	b=3amuKMwhWtxDw1E1wKkerRfamvs1CDYq8E5Jlr+owLQomaZQBk+Le9ENx5APPhIRB9Zj6k
	3Qfh+wBw4Zzzn2U/dfbiJAZVAT8L2ZgizIao+Q/auL2+0tTkUcol0cxA54n//95Tv1RvQC
	Doe1cDjx3wXXZB4zAOuUPqdEhJ4C8kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772810727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsB2TCDrL3VjreiID5Dmg1otW+nyqzxO42mbu6p0Nzg=;
	b=wwov2LW61Ele1iXshdztuQLPkzrnmdT+XthNwClIc8zjJH1nLesYU599PPSnEq2rVycqAl
	cHer8A94cQ6c5kCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49DF73EA75;
	Fri,  6 Mar 2026 15:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id foEDEufxqmlmewAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Mar 2026 15:25:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FFCAA09D8; Fri,  6 Mar 2026 16:25:27 +0100 (CET)
Date: Fri, 6 Mar 2026 16:25:27 +0100
From: Jan Kara <jack@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: jack@suse.cz, brauner@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5] ext4: avoid infinite loops caused by residual data
Message-ID: <wy5qg2737tfl4ctxkgxhsfzs2dbwohmbvkz7eagciq7tohjhir@ms3eqorvn4tu>
References: <agn2b2tn4h3whokr262gca5s6eoautng2u2vt6535w7myuyk6x@6kgv6h7pco5g>
 <tencent_43696283A68450B761D76866C6F360E36705@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_43696283A68450B761D76866C6F360E36705@qq.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 9450B223CD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79629-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,syzkaller.appspot.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.cz:dkim,suse.cz:email,qq.com:email,appspotmail.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[linux-fsdevel,1659aaaaa8d9d11265d7];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Fri 06-03-26 09:31:58, Edward Adam Davis wrote:
> On the mkdir/mknod path, when mapping logical blocks to physical blocks,
> if inserting a new extent into the extent tree fails (in this example,
> because the file system disabled the huge file feature when marking the
> inode as dirty), ext4_ext_map_blocks() only calls ext4_free_blocks() to
> reclaim the physical block without deleting the corresponding data in
> the extent tree. This causes subsequent mkdir operations to reference
> the previously reclaimed physical block number again, even though this
> physical block is already being used by the xattr block. Therefore, a
> situation arises where both the directory and xattr are using the same
> buffer head block in memory simultaneously.
> 
> The above causes ext4_xattr_block_set() to enter an infinite loop about
> "inserted" and cannot release the inode lock, ultimately leading to the
> 143s blocking problem mentioned in [1].
> 
> If the metadata is corrupted, then trying to remove some extent space
> can do even more harm. Also in case EXT4_GET_BLOCKS_DELALLOC_RESERVE
> was passed, remove space wrongly update quota information.
> Jan Kara suggests distinguishing between two cases:
> 
> 1) The error is ENOSPC or EDQUOT - in this case the filesystem is fully
> consistent and we must maintain its consistency including all the
> accounting. However these errors can happen only early before we've
> inserted the extent into the extent tree. So current code works correctly
> for this case.
> 
> 2) Some other error - this means metadata is corrupted. We should strive to
> do as few modifications as possible to limit damage. So I'd just skip
> freeing of allocated blocks.
> 
> [1]
> INFO: task syz.0.17:5995 blocked for more than 143 seconds.
> Call Trace:
>  inode_lock_nested include/linux/fs.h:1073 [inline]
>  __start_dirop fs/namei.c:2923 [inline]
>  start_dirop fs/namei.c:2934 [inline]
> 
> Reported-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1659aaaaa8d9d11265d7
> Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
> Reported-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=512459401510e2a9a39f
> Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Looks good to me! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
> v1 -> v2: fix ci reported issues
> v2 -> v3: new fix for removing residual data and update subject and coments
> v3 -> v4: filtering already allocated blocks and update comments
> v4 -> v5: don't touch corrupted data and update comments
> 
>  fs/ext4/extents.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index ae3804f36535..4779da94f816 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4457,9 +4457,13 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
>  	if (IS_ERR(path)) {
>  		err = PTR_ERR(path);
> -		if (allocated_clusters) {
> +		/*
> +		 * Gracefully handle out of space conditions. If the filesystem
> +		 * is inconsistent, we'll just leak allocated blocks to avoid
> +		 * causing even more damage.
> +		 */
> +		if (allocated_clusters && (err == -EDQUOT || err == -ENOSPC)) {
>  			int fb_flags = 0;
> -
>  			/*
>  			 * free data blocks we just allocated.
>  			 * not a good idea to call discard here directly,
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

