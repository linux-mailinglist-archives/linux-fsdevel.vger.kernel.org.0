Return-Path: <linux-fsdevel+bounces-14033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AA4876DDD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 00:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7558228321C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 23:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F18A3FBA1;
	Fri,  8 Mar 2024 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e5qnlAhU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F9tT9r8Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e5qnlAhU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F9tT9r8Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3A3FBA0
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709940394; cv=none; b=IELfJ4ticg1juiKXiM9xJy/LYDaofHQoeUIoiF/KzV7dX6nkndcnPQnYcwhzFtDgoCgSZFAz01eTaOCMrjh4yGPdJRCNDz5vL9C/fnVrh695bW/83xAOYKsQzqZ/c60uzqUPESNw56/Qo5U0URvzaQmXzVK38VXCZk4ccdOa0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709940394; c=relaxed/simple;
	bh=gcC02suSXggbxKbxdikIS3FXnx7UEKTYvDDXeAsYy3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAsjOVgDTJo3IEyIII6e7HJOwPqGjzLE5K/IeRaDbou5pOUX8uxC/UDd+c1nMQ0nOpskqO4cvLQ3H7V/W1tfdkfQ4hKDGV70FwUxcswD97gEviewBqRRyV0sh+t4uUizsLDwjQKVCjODsLcSy9Ct5FBAHOiqtob3S2TmcTCfXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e5qnlAhU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F9tT9r8Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e5qnlAhU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F9tT9r8Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AC0B22690;
	Fri,  8 Mar 2024 23:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709940391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9bMIrVz+2vYWJ99zrEtbk6NoEWfS3YaLas98WSlYRY=;
	b=e5qnlAhU85TzmG8vhOwRJuNvemsvj2YN4APt2cfnEBz6FLAZOtQ0z5FeqJ1Lk6BGE9itxu
	vlJbNn3+saFKGZpFcLoxHLI0TvH5t+kyh/k9P+D8fv32abtFPJvuT35NCH/qij4X/7dmKI
	hbDQekOhWAqMZn/1/eiQpOXiSodLv+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709940391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9bMIrVz+2vYWJ99zrEtbk6NoEWfS3YaLas98WSlYRY=;
	b=F9tT9r8ZJN4msmncJGlghUC5a8g+RhErO4FB3gnvDhWZLU12EsUxTgpfm4rJ2uGRsNOMjH
	WSOrqmji8orP5KDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709940391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9bMIrVz+2vYWJ99zrEtbk6NoEWfS3YaLas98WSlYRY=;
	b=e5qnlAhU85TzmG8vhOwRJuNvemsvj2YN4APt2cfnEBz6FLAZOtQ0z5FeqJ1Lk6BGE9itxu
	vlJbNn3+saFKGZpFcLoxHLI0TvH5t+kyh/k9P+D8fv32abtFPJvuT35NCH/qij4X/7dmKI
	hbDQekOhWAqMZn/1/eiQpOXiSodLv+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709940391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9bMIrVz+2vYWJ99zrEtbk6NoEWfS3YaLas98WSlYRY=;
	b=F9tT9r8ZJN4msmncJGlghUC5a8g+RhErO4FB3gnvDhWZLU12EsUxTgpfm4rJ2uGRsNOMjH
	WSOrqmji8orP5KDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3D7F13310;
	Fri,  8 Mar 2024 23:26:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uLKCO6ae62XXVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 08 Mar 2024 23:26:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 984B2A0807; Sat,  9 Mar 2024 00:26:26 +0100 (CET)
Date: Sat, 9 Mar 2024 00:26:26 +0100
From: Jan Kara <jack@suse.cz>
To: cem@kernel.org
Cc: hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Fix race on handling dquot rbtree
Message-ID: <20240308232626.hlpleyydhh2awmit@quack3>
References: <20240307174226.627962-1-cem@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307174226.627962-1-cem@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email,ubisectech.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -2.60
X-Spam-Flag: NO

On Thu 07-03-24 18:42:10, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> A syzkaller reproducer found a race while attempting to remove dquot information
> from the rb tree.
> Fetching the rb_tree root node must also be protected by the dqopt->dqio_sem,
> otherwise, giving the right timing, shmem_release_dquot() will trigger a warning
> because it couldn't find a node in the tree, when the real reason was the root
> node changing before the search starts:
> 
> Thread 1				Thread 2
> - shmem_release_dquot()			- shmem_{acquire,release}_dquot()
> 
> - fetch ROOT				- Fetch ROOT
> 
> 					- acquire dqio_sem
> - wait dqio_sem
> 
> 					- do something, triger a tree rebalance
> 					- release dqio_sem
> 
> - acquire dqio_sem
> - start searching for the node, but
>   from the wrong location, missing
>   the node, and triggering a warning.
> 
> Fixes: eafc474e202978 ("shmem: prepare shmem quota infrastructure")
> Reported-by: Ubisectech Sirius <bugreport@ubisectech.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Ah, good catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> I had a chat with Aristeu Rozanski and Jan Kara about this issue, which made me
> stop pursuing the wrong direction and reach the root cause faster, thanks guys.
>  
>  mm/shmem_quota.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> index 062d1c1097ae3..ce514e700d2f6 100644
> --- a/mm/shmem_quota.c
> +++ b/mm/shmem_quota.c
> @@ -116,7 +116,7 @@ static int shmem_free_file_info(struct super_block *sb, int type)
>  static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
>  {
>  	struct mem_dqinfo *info = sb_dqinfo(sb, qid->type);
> -	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
> +	struct rb_node *node;
>  	qid_t id = from_kqid(&init_user_ns, *qid);
>  	struct quota_info *dqopt = sb_dqopt(sb);
>  	struct quota_id *entry = NULL;
> @@ -126,6 +126,7 @@ static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
>  		return -ESRCH;
>  
>  	down_read(&dqopt->dqio_sem);
> +	node = ((struct rb_root *)info->dqi_priv)->rb_node;
>  	while (node) {
>  		entry = rb_entry(node, struct quota_id, node);
>  
> @@ -165,7 +166,7 @@ static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
>  static int shmem_acquire_dquot(struct dquot *dquot)
>  {
>  	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> -	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
> +	struct rb_node **n;
>  	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
>  	struct rb_node *parent = NULL, *new_node = NULL;
>  	struct quota_id *new_entry, *entry;
> @@ -176,6 +177,8 @@ static int shmem_acquire_dquot(struct dquot *dquot)
>  	mutex_lock(&dquot->dq_lock);
>  
>  	down_write(&dqopt->dqio_sem);
> +	n = &((struct rb_root *)info->dqi_priv)->rb_node;
> +
>  	while (*n) {
>  		parent = *n;
>  		entry = rb_entry(parent, struct quota_id, node);
> @@ -264,7 +267,7 @@ static bool shmem_is_empty_dquot(struct dquot *dquot)
>  static int shmem_release_dquot(struct dquot *dquot)
>  {
>  	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> -	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
> +	struct rb_node *node;
>  	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
>  	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
>  	struct quota_id *entry = NULL;
> @@ -275,6 +278,7 @@ static int shmem_release_dquot(struct dquot *dquot)
>  		goto out_dqlock;
>  
>  	down_write(&dqopt->dqio_sem);
> +	node = ((struct rb_root *)info->dqi_priv)->rb_node;
>  	while (node) {
>  		entry = rb_entry(node, struct quota_id, node);
>  
> -- 
> 2.44.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

