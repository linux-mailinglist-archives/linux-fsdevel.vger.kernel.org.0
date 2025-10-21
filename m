Return-Path: <linux-fsdevel+bounces-64905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE84BF6561
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8911219A3075
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B52335068;
	Tue, 21 Oct 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p/+neJoD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sMxtdMZz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yu86RcU8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8ibScNkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF832E743
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047919; cv=none; b=DygvHiFhIHOhsdOQHKtMrKemt3gXHCK94XeyXTZoo4glCgoJBHLtDfaDX53QfoFDxYLLcQ3xgO4o5Fb4k3UEf8stMri+wMl5Yh/n+nRyMiiGLhIinvfyMMFXClUrEKffTX+jsS/9KHG22dACfx5hGBUHfq+2Wtmsm2Y84YbkPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047919; c=relaxed/simple;
	bh=1nBYvRE9AKRHSSQJNMNnWDmnB0Wsm798kXA55O+B8Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn6U+X7MWmN58YeX7OszmVV/VvUeX4AiwzkKWYbP+xs8MnsCUQjRQT5coLoTMb+NNMbMmT5hgEqMogciOjH15aRx9fe1ebzvl+NNl9T8bKFvAiQ3g1xgohAI8hm3kxsRV/AeRuJdiS7Sl2v0T3547vMBGYWpf8UF9R9RT7vOASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p/+neJoD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sMxtdMZz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yu86RcU8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8ibScNkF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE0231F80A;
	Tue, 21 Oct 2025 11:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761047911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEww2G9x0lKOM7ivqmlX5OtWAigQPdROrOD7TaZz5TA=;
	b=p/+neJoD7KoCtxs8pIRmXmFUD1fj6h56bLZid3spXVpwharkjHE+pbTk1OwZrd7H1EW5dO
	caNqMovRzswwIvdTut8ufB6+iRH5TV8hSWrk6frIlaJBzabC5Z6vh8bF5+wB8smCdy89LH
	DI6St98SPttCmxVqLiGVORnyjvOJhew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761047911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEww2G9x0lKOM7ivqmlX5OtWAigQPdROrOD7TaZz5TA=;
	b=sMxtdMZzRSuyEWY7c33DhYcPpK5f+LhGESlgz9TLbEe4F7dsF47dTrOaC3SijrcIZtpIRO
	Jb0MrFRBEe3VmKBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761047907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEww2G9x0lKOM7ivqmlX5OtWAigQPdROrOD7TaZz5TA=;
	b=Yu86RcU8X3HgjkfWtFKr+9wbl0XnSkqSIwowKYNi9zWWz/Dmk35DsVgpt1p3/2jvse1ovF
	Sy5fvFh1ln/L27ybVy///25Q17Zd8RIzm2F7+G5ereBrb21oERr5W28EC5XjX4FPUTykwT
	xQl1UEd2aKwIHIm5HQv6OkBogkdUkSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761047907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEww2G9x0lKOM7ivqmlX5OtWAigQPdROrOD7TaZz5TA=;
	b=8ibScNkF0lHsQyxTRT2H/t+/PKopVVGOYY12f/SBRnQqcNPipm4uHYTTd76Pohde/Pwjv0
	CwDAzU4drECX3wBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF61F139B1;
	Tue, 21 Oct 2025 11:58:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TQ7PKmN192ihWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 11:58:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6368FA0990; Tue, 21 Oct 2025 13:58:19 +0200 (CEST)
Date: Tue, 21 Oct 2025 13:58:19 +0200
From: Jan Kara <jack@suse.cz>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org, willy@infradead.org, 
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, amir73il@gmail.com, 
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org, 
	dave@stgolabs.net, wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-mm@kvack.org, gost.dev@samsung.com, anuj20.g@samsung.com, vishak.g@samsung.com, 
	joshi.k@samsung.com
Subject: Re: [PATCH v2 04/16] writeback: affine inode to a writeback ctx
 within a bdi
Message-ID: <p7mc3a7upsebbipxrredqhtazwt3tvyn4qt5jtsn3wb43orew2@6jzeodvk4tli>
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
 <CGME20251014121031epcas5p37b0c4e23a7ad2d623ba776498f795fb0@epcas5p3.samsung.com>
 <20251014120845.2361-5-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120845.2361-5-kundan.kumar@samsung.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLkd9wktknm683nrx6wbi4qz63)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,szeredi.hu,redhat.com,linux-foundation.org,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,lists.sourceforge.net,vger.kernel.org,lists.linux.dev,kvack.org,samsung.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,samsung.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Tue 14-10-25 17:38:33, Kundan Kumar wrote:
> Affine inode to a writeback context. This helps in minimizing the
> filesytem fragmentation due to inode being processed by different
> threads.
> 
> To support parallel writeback, wire up a new superblock operation
> get_inode_wb_ctx(). Filesystems can override this callback and select
> desired writeback context for a inode. FS can use the wb context based
> on its geometry and also use 64 bit inode numbers.
> 
> If a filesystem doesn't implement this callback, it defaults to
> DEFALT_WB_CTX = 0, maintaining its original behavior.
> 
> An example implementation for XFS is provided, where XFS selects the
> writeback context based on its Allocation Group number.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>

As Christoph asked in other patch. Please introduce generic writeback
changes in one patch and then provide xfs implementation of
xfs_get_inode_wb_ctx() in another patch. Thanks.

								Honza

> ---
>  fs/fs-writeback.c           |  3 ++-
>  fs/xfs/xfs_super.c          | 13 +++++++++++++
>  include/linux/backing-dev.h |  5 ++++-
>  include/linux/fs.h          |  1 +
>  4 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 0715a7617391..56c048e22f72 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -265,7 +265,8 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
>  {
>  	struct backing_dev_info *bdi = inode_to_bdi(inode);
>  	struct bdi_writeback *wb = NULL;
> -	struct bdi_writeback_ctx *bdi_writeback_ctx = bdi->wb_ctx[0];
> +	struct bdi_writeback_ctx *bdi_writeback_ctx =
> +						fetch_bdi_writeback_ctx(inode);
>  
>  	if (inode_cgwb_enabled(inode)) {
>  		struct cgroup_subsys_state *memcg_css;
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index bb0a82635a77..b3ec9141d902 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -53,6 +53,7 @@
>  #include <linux/magic.h>
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
> +#include <linux/backing-dev.h>
>  
>  static const struct super_operations xfs_super_operations;
>  
> @@ -1294,6 +1295,17 @@ xfs_fs_show_stats(
>  	return 0;
>  }
>  
> +static struct bdi_writeback_ctx *
> +xfs_get_inode_wb_ctx(
> +	struct inode		*inode)
> +{
> +	struct xfs_inode *ip = XFS_I(inode);
> +	struct backing_dev_info *bdi = inode_to_bdi(inode);
> +	xfs_agino_t agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
> +
> +	return bdi->wb_ctx[agno % bdi->nr_wb_ctx];
> +}
> +
>  static const struct super_operations xfs_super_operations = {
>  	.alloc_inode		= xfs_fs_alloc_inode,
>  	.destroy_inode		= xfs_fs_destroy_inode,
> @@ -1310,6 +1322,7 @@ static const struct super_operations xfs_super_operations = {
>  	.free_cached_objects	= xfs_fs_free_cached_objects,
>  	.shutdown		= xfs_fs_shutdown,
>  	.show_stats		= xfs_fs_show_stats,
> +	.get_inode_wb_ctx       = xfs_get_inode_wb_ctx,
>  };
>  
>  static int
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 951ab5497500..59bbb69d300c 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -148,6 +148,7 @@ static inline bool mapping_can_writeback(struct address_space *mapping)
>  	return inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK;
>  }
>  
> +#define DEFAULT_WB_CTX 0
>  #define for_each_bdi_wb_ctx(bdi, wbctx) \
>  	for (int __i = 0; __i < (bdi)->nr_wb_ctx \
>  		&& ((wbctx) = (bdi)->wb_ctx[__i]) != NULL; __i++)
> @@ -157,7 +158,9 @@ fetch_bdi_writeback_ctx(struct inode *inode)
>  {
>  	struct backing_dev_info *bdi = inode_to_bdi(inode);
>  
> -	return bdi->wb_ctx[0];
> +	if (inode->i_sb->s_op->get_inode_wb_ctx)
> +		return inode->i_sb->s_op->get_inode_wb_ctx(inode);
> +	return bdi->wb_ctx[DEFAULT_WB_CTX];
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 754fec84f350..5199b0d49fa5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2379,6 +2379,7 @@ struct super_operations {
>  	 */
>  	int (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
>  	void (*shutdown)(struct super_block *sb);
> +	struct bdi_writeback_ctx *(*get_inode_wb_ctx)(struct inode *inode);
>  };
>  
>  /*
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

