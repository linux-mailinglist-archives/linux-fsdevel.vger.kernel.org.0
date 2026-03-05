Return-Path: <linux-fsdevel+bounces-79473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPagGG9dqWkL6AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:39:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A625E20FCD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55F9E3039EF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887D378D77;
	Thu,  5 Mar 2026 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T4U8lXHa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2uBYj8KJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T4U8lXHa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2uBYj8KJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967529B799
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707083; cv=none; b=m451tXHRc2Fyj9afzrg0qCjuycJCK+QmJ8fc2lmFPhCBTaqNmJ3zL/QhZNSDp/wz0sgwIzTY6mjXV5BAOfXt9AtT6/odl54fN8lo4+Goxrgo0vEWOvwBmnCUwmwtwnVR2T5XNrkRnvuuE1EnFaFUe4BGDMP4vdwmMxHL1K5X5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707083; c=relaxed/simple;
	bh=VigSnPVm/okTMSqMzhaj46e+75281h7Jzob4La0gaxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gen90uvXTgDSGEbQ+vcZjEHcZVFYPr2OBYdsupsCx9b9Pe/j3ccxZ1r3poTdIFBmf8c7qNAPuJ3sgn7nuhH3LZbVQSzKpM3/cz2tEzsHBcn2XNOkBsrbfaL8f7sHm0VSyYUlTa+yAimmQG5t5KosBSPzYxvD7lXmOYsk8oMQcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T4U8lXHa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2uBYj8KJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T4U8lXHa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2uBYj8KJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96A7E3F881;
	Thu,  5 Mar 2026 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772707080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sKiKcuS9WLvU+XvNNfUoARrCbK1SOIwG1zdBgYVHWrQ=;
	b=T4U8lXHakbq9U0MrYtrLFTf+giSJQZwDi3CrrvT/trb3FSK85wyBCxGiYfg71rfKCaglB1
	dAo/rkhDoRKJ8z1U+1Va2hR9xr+xGzbrtOrZNw4qlMkhrf3ui+nraqYxDgxsuZtERy/hUa
	ifw+fj3XsfGjcddoen6OPwLQGN5VmeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772707080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sKiKcuS9WLvU+XvNNfUoARrCbK1SOIwG1zdBgYVHWrQ=;
	b=2uBYj8KJXEJPqd1UyXdIgo6yTnb/cyxcrxATqTa6mdBP9sp0W44cw2wDAUArlWiWX4JO8V
	OtjXRe/ZAGCbsqAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772707080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sKiKcuS9WLvU+XvNNfUoARrCbK1SOIwG1zdBgYVHWrQ=;
	b=T4U8lXHakbq9U0MrYtrLFTf+giSJQZwDi3CrrvT/trb3FSK85wyBCxGiYfg71rfKCaglB1
	dAo/rkhDoRKJ8z1U+1Va2hR9xr+xGzbrtOrZNw4qlMkhrf3ui+nraqYxDgxsuZtERy/hUa
	ifw+fj3XsfGjcddoen6OPwLQGN5VmeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772707080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sKiKcuS9WLvU+XvNNfUoARrCbK1SOIwG1zdBgYVHWrQ=;
	b=2uBYj8KJXEJPqd1UyXdIgo6yTnb/cyxcrxATqTa6mdBP9sp0W44cw2wDAUArlWiWX4JO8V
	OtjXRe/ZAGCbsqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 733C33EA68;
	Thu,  5 Mar 2026 10:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HyMcHAhdqWnEeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 10:38:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3760DA0AB1; Thu,  5 Mar 2026 11:38:00 +0100 (CET)
Date: Thu, 5 Mar 2026 11:38:00 +0100
From: Jan Kara <jack@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: jack@suse.cz, brauner@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] ext4: avoid infinite loops caused by residual data
Message-ID: <uweckkartekmwpzpt2kt34bbjyn3a2a4tc3lw7qyyghkxhfl5l@st7yfcuu73f4>
References: <4x3xixojbclwq45cpitmylbhis4ya4g3sugtnmj2yzv6avngqb@5xkwu6l467rm>
 <tencent_722F916D689510E89EEE92CD8C78226D480A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_722F916D689510E89EEE92CD8C78226D480A@qq.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Queue-Id: A625E20FCD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79473-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,appspotmail.com:email,qq.com:email,syzkaller.appspot.com:url,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel,1659aaaaa8d9d11265d7];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu 05-03-26 15:25:46, Edward Adam Davis wrote:
> On the mkdir/mknod path, when mapping logical blocks to physical blocks,
> if inserting a new extent into the extent tree fails (in this example,
> because the file system disabled the huge file feature when marking the
> inode as dirty),

I don't quite understand what you mean here but I think you say that
ext4_ext_dirty() -> ext4_mark_inode_dirty() returns error due to whatever
corruption it has hit.

> ext4_ext_map_blocks() only calls ext4_free_blocks() to
> reclaim the physical block without deleting the corresponding data in
> the extent tree. This causes subsequent mkdir operations to reference
> the previously reclaimed physical block number again, even though this
> physical block is already being used by the xattr block. Therefore, a
> situation arises where both the directory and xattr are using the same
> buffer head block in memory simultaneously.

OK, this indeed looks like "not so great" error handling. Thanks for
digging into this.

> The above causes ext4_xattr_block_set() to enter an infinite loop about
> "inserted" and cannot release the inode lock, ultimately leading to the
> 143s blocking problem mentioned in [1].
> 
> By using ext4_ext_remove_space() to delete the inserted logical block
> and reclaim the physical block when inserting a new extent fails during
> extent block mapping, residual extent data can be prevented from affecting
> subsequent logical block physical mappings. 
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
> ---
...
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index ae3804f36535..0bed3379f2d2 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4458,19 +4458,13 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	if (IS_ERR(path)) {
>  		err = PTR_ERR(path);
>  		if (allocated_clusters) {
> -			int fb_flags = 0;
> -
>  			/*
>  			 * free data blocks we just allocated.
>  			 * not a good idea to call discard here directly,
>  			 * but otherwise we'd need to call it every free().
>  			 */
>  			ext4_discard_preallocations(inode);
> -			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
> -				fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
> -			ext4_free_blocks(handle, inode, NULL, newblock,
> -					 EXT4_C2B(sbi, allocated_clusters),
> -					 fb_flags);
> +			ext4_ext_remove_space(inode, newex.ee_block, newex.ee_block);

So I'm concerned that if the metadata is corrupted, then trying to remove
some extent space can do even more harm. Also in case
EXT4_GET_BLOCKS_DELALLOC_RESERVE was passed, we now wrongly update quota
information. So this definitely isn't a correct fix. What I'd do instead
would be distinguishing two cases:

1) The error is ENOSPC or EDQUOT - in this case the filesystem is fully
consistent and we must maintain its consistency including all the
accounting. However these errors can happen only early before we've
inserted the extent into the extent tree. So current code works correctly
for this case.

2) Some other error - this means metadata is corrupted. We should strive to
do as few modifications as possible to limit damage. So I'd just skip
freeing of allocated blocks.

Long story short I think we should just modify the above condition:

	if (allocated_clusters)

to

	/*
	 * Gracefully handle out of space conditions. If the filesystem is
	 * inconsistent, we'll just leak allocated blocks to avoid causing
	 * even more damage.
	 */
	if (allocated_clusters && (err == -EDQUOT || err == -ENOSPC))

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

