Return-Path: <linux-fsdevel+bounces-1192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB117D70EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 17:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96872281CAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D72AB58;
	Wed, 25 Oct 2023 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l2fbk9nj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MwMxSL0Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498527EEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 15:30:10 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05921713
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 08:30:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AF7921DC8;
	Wed, 25 Oct 2023 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698247807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tsyiau4ZUpovXwVZHseqcbfnIFrZYymN1S9ffOO8f6Y=;
	b=l2fbk9njiaF+PKY9dvn5fL26DvgWqJyasTTVrANAdzC8hBs7gr+aWbc5CWW+0T47eky8aH
	Hpa1TE7x5FQcTlC3OOcC9iaekzdiG+WXzgCBYMvlUv2n8nUmoy+hZ4mwOoyRIrr+uiWQyj
	HRSCcbtcFfOEkskelsRiWhqZfoKnJRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698247807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tsyiau4ZUpovXwVZHseqcbfnIFrZYymN1S9ffOO8f6Y=;
	b=MwMxSL0ZATgR6TYARfh5cKaVFu4SebNmqFllE1THAnz+XK4fHbHNYopWGk7OWYeBg6gh04
	48KqAuJTfrMjEtDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DC2313524;
	Wed, 25 Oct 2023 15:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id H5zCGn80OWX0OQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 15:30:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0ADB7A0679; Wed, 25 Oct 2023 17:30:07 +0200 (CEST)
Date: Wed, 25 Oct 2023 17:30:07 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] xfs: simplify device handling
Message-ID: <20231025153007.pmp4gx2gnsvtn7gk@quack3>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
 <20231024-vfs-super-rework-v1-2-37a8aa697148@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-rework-v1-2-37a8aa697148@kernel.org>
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

On Tue 24-10-23 16:53:40, Christian Brauner wrote:
> We removed all codepaths where s_umount is taken beneath open_mutex and
> bd_holder_lock so don't make things more complicated than they need to
> be and hold s_umount over block device opening.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xfs/xfs_super.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index f0ae07828153..84107d162e41 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -437,19 +437,13 @@ xfs_open_devices(
>  	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
>  	int			error;
>  
> -	/*
> -	 * blkdev_put() can't be called under s_umount, see the comment
> -	 * in get_tree_bdev() for more details
> -	 */
> -	up_write(&sb->s_umount);
> -
>  	/*
>  	 * Open real time and log devices - order is important.
>  	 */
>  	if (mp->m_logname) {
>  		error = xfs_blkdev_get(mp, mp->m_logname, &logdev_handle);
>  		if (error)
> -			goto out_relock;
> +			return error;
>  	}
>  
>  	if (mp->m_rtname) {
> @@ -492,10 +486,7 @@ xfs_open_devices(
>  			bdev_release(logdev_handle);
>  	}
>  
> -	error = 0;
> -out_relock:
> -	down_write(&sb->s_umount);
> -	return error;
> +	return 0;
>  
>   out_free_rtdev_targ:
>  	if (mp->m_rtdev_targp)
> @@ -508,7 +499,7 @@ xfs_open_devices(
>   out_close_logdev:
>  	if (logdev_handle)
>  		bdev_release(logdev_handle);
> -	goto out_relock;
> +	return error;
>  }
>  
>  /*
> @@ -758,10 +749,6 @@ static void
>  xfs_mount_free(
>  	struct xfs_mount	*mp)
>  {
> -	/*
> -	 * Free the buftargs here because blkdev_put needs to be called outside
> -	 * of sb->s_umount, which is held around the call to ->put_super.
> -	 */
>  	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
>  		xfs_free_buftarg(mp->m_logdev_targp);
>  	if (mp->m_rtdev_targp)
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

