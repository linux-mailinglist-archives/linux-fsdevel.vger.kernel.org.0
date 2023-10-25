Return-Path: <linux-fsdevel+bounces-1193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4A7D70EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 17:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9851C20C57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ECA2AB58;
	Wed, 25 Oct 2023 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dpMHjkFn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iInuhqTQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851527EEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 15:30:32 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8C6D50
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 08:30:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7706B21DE7;
	Wed, 25 Oct 2023 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698247827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60yWO+33AuOm/v6Zp8gx+mXd5y/Jl59PR1ndMDMNsj4=;
	b=dpMHjkFnXlXFDPG0PkRD2dHyGeAc1b+eof/L43vG38JXmERyWpd8oe4ydWBqtQCcRoilm5
	bf9tu//529rP9ZsGN3OzZlJd1Uzv+qxhQYdQU1Gg1k3aGetFqG5dr9P2vCytk8FPL3e8ZZ
	/0ioz9NS8O5bekXVupoW33qcVqVuB3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698247827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60yWO+33AuOm/v6Zp8gx+mXd5y/Jl59PR1ndMDMNsj4=;
	b=iInuhqTQ4GgoESB7UmqNTC4ms0W9YwxPN2R2woecwnuuhC1cIG6H1QR+5ljBzPojO4Wbtb
	YAEjb3XiiI/0x2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67DF613524;
	Wed, 25 Oct 2023 15:30:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id AVhUGZM0OWUaOgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 15:30:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 126D4A0679; Wed, 25 Oct 2023 17:30:27 +0200 (CEST)
Date: Wed, 25 Oct 2023 17:30:27 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 3/6] ext4: simplify device handling
Message-ID: <20231025153027.7lt4stuiwpgacr4m@quack3>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
 <20231024-vfs-super-rework-v1-3-37a8aa697148@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-rework-v1-3-37a8aa697148@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.58
X-Spamd-Result: default: False [-6.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.98)[99.89%]

On Tue 24-10-23 16:53:41, Christian Brauner wrote:
> We removed all codepaths where s_umount is taken beneath open_mutex and
> bd_holder_lock so don't make things more complicated than they need to
> be and hold s_umount over block device opening.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d43f8324242a..e94df97ea440 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5855,11 +5855,8 @@ static struct bdev_handle *ext4_get_journal_blkdev(struct super_block *sb,
>  	struct ext4_super_block *es;
>  	int errno;
>  
> -	/* see get_tree_bdev why this is needed and safe */
> -	up_write(&sb->s_umount);
>  	bdev_handle = bdev_open_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
>  				       sb, &fs_holder_ops);
> -	down_write(&sb->s_umount);
>  	if (IS_ERR(bdev_handle)) {
>  		ext4_msg(sb, KERN_ERR,
>  			 "failed to open journal device unknown-block(%u,%u) %ld",
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

