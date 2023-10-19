Return-Path: <linux-fsdevel+bounces-727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ECC7CF312
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 10:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7C5281F4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 08:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF615ADF;
	Thu, 19 Oct 2023 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T6yWSTbL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xF7rD5Rn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98105FC15
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:43:41 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590DB1BCA;
	Thu, 19 Oct 2023 01:43:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03F8B1FD8C;
	Thu, 19 Oct 2023 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697705019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYET0BJw7ocS3OlFzKj/k4LkNiu6Z0iSBZYVxMidfVw=;
	b=T6yWSTbLeqFDDITYvRVkOtphzBo+NYyQiEpiduILNwk8u3sfcE9vtHNiuLChqlYot8ha6t
	cTldsHYzFX5k50r9otD84EKG/qsYidbQ7E6CLdOqMpMdCFcd8IIMB58VcdAmbY36LLhOBh
	grSPKAVhL1jkpqztTBUe8SwNF2le104=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697705019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYET0BJw7ocS3OlFzKj/k4LkNiu6Z0iSBZYVxMidfVw=;
	b=xF7rD5RnrQUerfjluvjdEUSNbaBeOKdZu/v3JpN/DFDnFjexRQOj+8RPLrEaMC8Q6zCBho
	L6wPXB/2A9c49rDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E85181357F;
	Thu, 19 Oct 2023 08:43:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RGa1ODrsMGUyQwAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 08:43:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 94D1FA06B0; Thu, 19 Oct 2023 10:43:38 +0200 (CEST)
Date: Thu, 19 Oct 2023 10:43:38 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: assert that open_mutex isn't held over holder ops
Message-ID: <20231019084338.xu4ppzz3nx24saj4@quack3>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-6-hch@lst.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]

On Tue 17-10-23 20:48:23, Christoph Hellwig wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> With recent block level changes we should never be in a situation where
> we hold disk->open_mutex when calling into these helpers. So assert that
> in the code.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 26b96191e9b3ca..ce54cfcecaa156 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1443,6 +1443,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  
>  	/* bd_holder_lock ensures that the sb isn't freed */
>  	lockdep_assert_held(&bdev->bd_holder_lock);
> +	lockdep_assert_not_held(&bdev->bd_disk->open_mutex);
>  
>  	if (!super_lock_shared_active(sb))
>  		return;
> @@ -1462,6 +1463,7 @@ static void fs_bdev_sync(struct block_device *bdev)
>  	struct super_block *sb = bdev->bd_holder;
>  
>  	lockdep_assert_held(&bdev->bd_holder_lock);
> +	lockdep_assert_not_held(&bdev->bd_disk->open_mutex);
>  
>  	if (!super_lock_shared_active(sb))
>  		return;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

