Return-Path: <linux-fsdevel+bounces-61959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC10B80FB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7117E188A6BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA6A28E5F3;
	Wed, 17 Sep 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HC6D3Red";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s43KVGfF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HC6D3Red";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s43KVGfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36F34BA3C
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126364; cv=none; b=CmWnRzHJMcWbD/Ih9MHLiy2MMtEqlImJThGNnUBgnUjg9eD004pTI8bIQbN52OKrjRxuYRFs+mMV3sXNEsFdPsGUXxT6EQJfB3dnqX8pp2FWV7OhXMf7JPOjIC8NvIc0yM6Abb4sYvJTLfGL1/DulXpY92899ze1Qg99wh9hvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126364; c=relaxed/simple;
	bh=NuedsL0u0jTMe5e963phUNbN5qwo3sq686mjG/Qm3ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOWFdvZYpU2qPLtwjs2lY96E2CFXftF7qi/zWI43hKBKPVfEKACL/YGMOxZ1vLYfFGDcu8nd3M5IuS4cJQRlqL/ghFO65JS/R1fCB0VdtZ6zESt9CPwxcZBLu9HJjR8imDvagW9WsO9cQZod5cWdrUft4jIqPKrDXcBllFv5e7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HC6D3Red; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s43KVGfF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HC6D3Red; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s43KVGfF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA230218F1;
	Wed, 17 Sep 2025 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbajwTHpfXlHk5TsPesY8nKzZeFUWj6k4n1keKE4AFQ=;
	b=HC6D3Red6ZMCagXz6VhZuw2776xmW9QjS9PRYQXyx4/imvzewtef8k/CWoZZ2dvzX3UKeW
	41ciJw33CQrcMWLar1CCl58cyXhwVWKI13YIfY9viND9OnILeKB47Mi218N1hYydkC9wd0
	lEJRdFYGM2NVX5HJVD0HkUq936aCQv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbajwTHpfXlHk5TsPesY8nKzZeFUWj6k4n1keKE4AFQ=;
	b=s43KVGfF3mcyEVqWiHDE87iRXJGMrhPq7n8S4Wod7psNXyKCL2H3TvgCE6yXiB8lNFMzHC
	yu4fzvL2IdqPCiBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HC6D3Red;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=s43KVGfF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbajwTHpfXlHk5TsPesY8nKzZeFUWj6k4n1keKE4AFQ=;
	b=HC6D3Red6ZMCagXz6VhZuw2776xmW9QjS9PRYQXyx4/imvzewtef8k/CWoZZ2dvzX3UKeW
	41ciJw33CQrcMWLar1CCl58cyXhwVWKI13YIfY9viND9OnILeKB47Mi218N1hYydkC9wd0
	lEJRdFYGM2NVX5HJVD0HkUq936aCQv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbajwTHpfXlHk5TsPesY8nKzZeFUWj6k4n1keKE4AFQ=;
	b=s43KVGfF3mcyEVqWiHDE87iRXJGMrhPq7n8S4Wod7psNXyKCL2H3TvgCE6yXiB8lNFMzHC
	yu4fzvL2IdqPCiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4A701368D;
	Wed, 17 Sep 2025 16:26:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A5qkLxjhymhKMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 16:26:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C9A2A083B; Wed, 17 Sep 2025 18:26:00 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:26:00 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] fs: add might_sleep() annotation to iput() and more
Message-ID: <4hczbhmpigwkkeeqaq2kgw4wumsbrlgis4ld7jz5lq2wdjsnzb@oolwamox5glq>
References: <20250917153632.2228828-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917153632.2228828-1-max.kellermann@ionos.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EA230218F1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.01

On Wed 17-09-25 17:36:31, Max Kellermann wrote:
> When iput() drops the reference counter to zero, it may sleep via
> inode_wait_for_writeback().  This happens rarely because it's usually
> the dcache which evicts inodes, but really iput() should only ever be
> called in contexts where sleeping is allowed.  This annotation allows
> finding buggy callers.
> 
> Additionally, this patch annotates a few low-level functions that can
> call iput() conditionally.
> 
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> For discussion of a loosely-related Ceph deadlock bug, see:
>  https://lore.kernel.org/ceph-devel/CAKPOu+-xr+nQuzfjtQCgZCqPtec=8uQiz29H5+5AeFzTbp=1rw@mail.gmail.com/T/
>  https://lore.kernel.org/ceph-devel/CAGudoHF0+JfqxB_fQxeo7Pbadjq7UA1JFH4QmfFS1hDHunNmtw@mail.gmail.com/T/
> ---
>  fs/inode.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index fc2edb5a4dbe..ec9339024ac3 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1279,6 +1279,8 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
>  	struct inode *old;
>  
> +	might_sleep();
> +
>  again:
>  	spin_lock(&inode_hash_lock);
>  	old = find_inode(inode->i_sb, head, test, data, true);
> @@ -1382,6 +1384,8 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
>  	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
>  	struct inode *inode, *new;
>  
> +	might_sleep();
> +
>  again:
>  	inode = find_inode(sb, head, test, data, false);
>  	if (inode) {
> @@ -1422,6 +1426,9 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  {
>  	struct hlist_head *head = inode_hashtable + hash(sb, ino);
>  	struct inode *inode;
> +
> +	might_sleep();
> +
>  again:
>  	inode = find_inode_fast(sb, head, ino, false);
>  	if (inode) {
> @@ -1605,6 +1612,9 @@ struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
>  		int (*test)(struct inode *, void *), void *data)
>  {
>  	struct inode *inode;
> +
> +	might_sleep();
> +
>  again:
>  	inode = ilookup5_nowait(sb, hashval, test, data);
>  	if (inode) {
> @@ -1630,6 +1640,9 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
>  {
>  	struct hlist_head *head = inode_hashtable + hash(sb, ino);
>  	struct inode *inode;
> +
> +	might_sleep();
> +
>  again:
>  	inode = find_inode_fast(sb, head, ino, false);
>  
> @@ -1780,6 +1793,8 @@ int insert_inode_locked(struct inode *inode)
>  	ino_t ino = inode->i_ino;
>  	struct hlist_head *head = inode_hashtable + hash(sb, ino);
>  
> +	might_sleep();
> +
>  	while (1) {
>  		struct inode *old = NULL;
>  		spin_lock(&inode_hash_lock);
> @@ -1826,6 +1841,8 @@ int insert_inode_locked4(struct inode *inode, unsigned long hashval,
>  {
>  	struct inode *old;
>  
> +	might_sleep();
> +
>  	inode->i_state |= I_CREATING;
>  	old = inode_insert5(inode, hashval, test, NULL, data);
>  
> @@ -1908,6 +1925,7 @@ static void iput_final(struct inode *inode)
>   */
>  void iput(struct inode *inode)
>  {
> +	might_sleep();
>  	if (unlikely(!inode))
>  		return;
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

