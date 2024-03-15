Return-Path: <linux-fsdevel+bounces-14473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB287CF8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AFA1F2374D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46263D56A;
	Fri, 15 Mar 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FPpVckeb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rOPq8FNb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FPpVckeb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rOPq8FNb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC73D0CA;
	Fri, 15 Mar 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514557; cv=none; b=SquX269zJgUIFmoz+UhMv33LT2Bi7uudCT9cFiXxGHWQR715AXNpRAWi7yXIgD7dU/QFKOTfAGjs4HUxgi3+fWbZqN4YA/92yohYc9FeGWPrA4NQYjQe7SWpEXCWHvOSVwA5Xoc/h9W4Qk8jv7aLe2D1ydNAKmprnyYDtd1nrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514557; c=relaxed/simple;
	bh=enofTFwnjR+aa6qHW/SPB3ISG0jL+mRx8dGHiEDEKmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTsf2WL9GQpIssqWODHknGKwI3B2RqV3DqDSJrtEl67fbHo1oXn+ptAPGX19CPGvv/a/BSWHe470UJtvn//Rrg8VZlGNLx+D/dfktzjJDmkWS2Id/Qj49ysZPcxRKoRx4xTmuGGeK8vM4AhItujX6Kj04aTUc9aod4oTw4+JRtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FPpVckeb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rOPq8FNb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FPpVckeb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rOPq8FNb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77E391FB67;
	Fri, 15 Mar 2024 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710514553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBFNBvzkbOK62iGUGohXueVpIKRj8CLhJwZk7KSN2/I=;
	b=FPpVckebz+dFydI48Fu4xmr4eKeG/dAkCB33wNamY1SoVQChVOjc2ZARlYYYDgNBaK0SbE
	8j4/IbLHN1CvLEATzBTHhbnIQ9N1FaUv9Vh+SSLB7eaTKHKhn4T8fQLFNXUuaEEHY9bEJa
	J3gxh3bpAjUalfqvT7whjzJ3vlC67gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710514553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBFNBvzkbOK62iGUGohXueVpIKRj8CLhJwZk7KSN2/I=;
	b=rOPq8FNbVKphOPajs3RuklgJNe0F8QkaJzYQgVSq84Y/HIh2T3M3Gu7gNe1VyuHPrCSFcP
	3/SQuyi3qmxlCRAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710514553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBFNBvzkbOK62iGUGohXueVpIKRj8CLhJwZk7KSN2/I=;
	b=FPpVckebz+dFydI48Fu4xmr4eKeG/dAkCB33wNamY1SoVQChVOjc2ZARlYYYDgNBaK0SbE
	8j4/IbLHN1CvLEATzBTHhbnIQ9N1FaUv9Vh+SSLB7eaTKHKhn4T8fQLFNXUuaEEHY9bEJa
	J3gxh3bpAjUalfqvT7whjzJ3vlC67gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710514553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBFNBvzkbOK62iGUGohXueVpIKRj8CLhJwZk7KSN2/I=;
	b=rOPq8FNbVKphOPajs3RuklgJNe0F8QkaJzYQgVSq84Y/HIh2T3M3Gu7gNe1VyuHPrCSFcP
	3/SQuyi3qmxlCRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D2D11368C;
	Fri, 15 Mar 2024 14:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IQClGnlh9GVQSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:55:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 133D8A07D9; Fri, 15 Mar 2024 15:55:53 +0100 (CET)
Date: Fri, 15 Mar 2024 15:55:53 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 10/19] s390/dasd: use bdev api in
 dasd_format()
Message-ID: <20240315145553.tqacsrgoy4s5esc7@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-11-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-11-yukuai1@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Thu 22-02-24 20:45:46, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Avoid to access bd_inode directly, prepare to remove bd_inode from
> block_devcie.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/s390/block/dasd_ioctl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index 7e0ed7032f76..c1201590f343 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -215,8 +215,9 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
>  	 * enabling the device later.
>  	 */
>  	if (fdata->start_unit == 0) {
> -		block->gdp->part0->bd_inode->i_blkbits =
> -			blksize_bits(fdata->blksize);
> +		rc = set_blocksize(block->gdp->part0, fdata->blksize);
> +		if (rc)
> +			return rc;
>  	}
>  
>  	rc = base->discipline->format_device(base, fdata, 1);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

