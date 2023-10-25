Return-Path: <linux-fsdevel+bounces-1191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C77D70E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89271C20E30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE612AB59;
	Wed, 25 Oct 2023 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ss8dRVgc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2V5Tjodm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A42D62F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 15:29:31 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EBC1FC4
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 08:29:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0EA821DC8;
	Wed, 25 Oct 2023 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698247754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fx3MA7y9QXfVIRmPFNf8zbF2tmyH8sxsHdieblGU8ag=;
	b=Ss8dRVgcglaVi6Fcix5wdfdjuFcocKQ8cVg/0yCD6BZzx6FQNuupxdvBMjwgiIMbaW6pgN
	AxDq0QWbpJikyJqpejjEVznHVkHXOzDT3zZH/+sbh0HBrc1ADMHTGvI7NP+En9TAMSBuXk
	tMPt+npBSFHqbTHB31cRY8PItIghkjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698247754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fx3MA7y9QXfVIRmPFNf8zbF2tmyH8sxsHdieblGU8ag=;
	b=2V5Tjodmub/c/K/xpVafXBfa8FYVQt3/NFOl8lvGYEJaIxuAgV87ckm5nMKa5wk132EpDv
	iPECwh5k6TwyevCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9224513524;
	Wed, 25 Oct 2023 15:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 31igI0o0OWVFOQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 15:29:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 226E2A0679; Wed, 25 Oct 2023 17:29:14 +0200 (CEST)
Date: Wed, 25 Oct 2023 17:29:14 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] fs: simplify setup_bdev_super() calls
Message-ID: <20231025152914.fin2hzzywox5ijtk@quack3>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
 <20231024-vfs-super-rework-v1-1-37a8aa697148@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-rework-v1-1-37a8aa697148@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%]

On Tue 24-10-23 16:53:39, Christian Brauner wrote:
> There's no need to drop s_umount anymore now that we removed all sources
> where s_umount is taken beneath open_mutex or bd_holder_lock.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Yay. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index b26b302f870d..4edde92d5e8f 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1613,15 +1613,7 @@ int get_tree_bdev(struct fs_context *fc,
>  			return -EBUSY;
>  		}
>  	} else {
> -		/*
> -		 * We drop s_umount here because we need to open the bdev and
> -		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
> -		 * bdev_mark_dead()). It is safe because we have active sb
> -		 * reference and SB_BORN is not set yet.
> -		 */
> -		super_unlock_excl(s);
>  		error = setup_bdev_super(s, fc->sb_flags, fc);
> -		__super_lock_excl(s);
>  		if (!error)
>  			error = fill_super(s, fc);
>  		if (error) {
> @@ -1665,15 +1657,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
>  			return ERR_PTR(-EBUSY);
>  		}
>  	} else {
> -		/*
> -		 * We drop s_umount here because we need to open the bdev and
> -		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
> -		 * bdev_mark_dead()). It is safe because we have active sb
> -		 * reference and SB_BORN is not set yet.
> -		 */
> -		super_unlock_excl(s);
>  		error = setup_bdev_super(s, flags, NULL);
> -		__super_lock_excl(s);
>  		if (!error)
>  			error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
>  		if (error) {
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

