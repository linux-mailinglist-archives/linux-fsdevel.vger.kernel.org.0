Return-Path: <linux-fsdevel+bounces-1159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A4F7D6CDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0820281CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4127EFB;
	Wed, 25 Oct 2023 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="epGQ+73y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5hLiBJRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738EC1CAB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 13:15:30 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C8312F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 06:15:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 017B021B19;
	Wed, 25 Oct 2023 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698239727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7S3NZUd9Id4GdZju7Yi2l3epkSfPOcBzfVR/Bm6hOMk=;
	b=epGQ+73yrmLSIGT5aZbbQf3TKDlWTZEsjpm65sIfnrtee6W2cqLpscrUoIPNy6nVAP49qp
	t8a9onZTbLWrHHeuRhdv1YW7uf6LkzAnxtjNODkC0CleTUVrGfBxs+ssZUpge0cNUVL42F
	D2RmsLUQckRwbKCHGsylHKaNsLJHkXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698239727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7S3NZUd9Id4GdZju7Yi2l3epkSfPOcBzfVR/Bm6hOMk=;
	b=5hLiBJRQgmmLuWSHSIVhKsP60dc5a9VNxKM8jkuP0ismuCTamCTty+j7+K08ba4t77MOlR
	JQ0MoBkTPxMVJoCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCCCF13524;
	Wed, 25 Oct 2023 13:15:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Bv7SNe4UOWVRdAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 13:15:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41353A06E5; Wed, 25 Oct 2023 14:36:35 +0200 (CEST)
Date: Wed, 25 Oct 2023 14:36:35 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] bdev: surface the error from sync_blockdev()
Message-ID: <20231025123635.twu7ynspjlvnjhvq@quack3>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-3-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-3-599c19f4faac@kernel.org>
Authentication-Results: smtp-out1.suse.de;
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
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]

On Tue 24-10-23 15:01:09, Christian Brauner wrote:
> When freeze_super() is called, sync_filesystem() will be called which
> calls sync_blockdev() and already surfaces any errors. Do the same for
> block devices that aren't owned by a superblock and also for filesystems
> that don't call sync_blockdev() internally but implicitly rely on
> bdev_freeze() to do it.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>
								Honza

> ---
>  block/bdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index d674ad381c52..a3e2af580a73 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -245,7 +245,7 @@ int bdev_freeze(struct block_device *bdev)
>  	bdev->bd_fsfreeze_sb = sb;
>  
>  sync:
> -	sync_blockdev(bdev);
> +	error = sync_blockdev(bdev);
>  done:
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

