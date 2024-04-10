Return-Path: <linux-fsdevel+bounces-16616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF0B89FF03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 19:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221CD287753
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497F1A0AF1;
	Wed, 10 Apr 2024 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yBxxYVQ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wcXOFf+8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hTuKFvG7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="elXsFP10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F42F194C9B;
	Wed, 10 Apr 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771109; cv=none; b=CKn3fOrCNwA6YWy7+Q9pMhEzHj6uEK8qH7pVEi3VdGuJo7yqt/GtsTz7KxzumxiS5rD7QYyO44jNpJPbCFLKBiA7JW9+uETRG1c23McDsU38hJA4wDIc5b9COKWYEKL0aM8rHYfYFsLzufvTRz5KRnYGWeI5nR/i9h5nHHPvoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771109; c=relaxed/simple;
	bh=FfbM6dBK2mr783lz2Tf1oTCDjUnulOUEAmCPb7EW5VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVhfzyIvjTg3zPUrTr2bhwuR+ZjNqdJ2+0Gk2xyvaXckh7VbS7Nzv8guE70sN231L64WPu1ypVkzatK/MmqsBlA3tvicCUyZ0g9bEp3KyfKf2Qlwbg2sJlm4ECsLVBviyf0klnDLOOcuM8B/caDmtBWtiYeMglUhdqg/hcE65E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yBxxYVQ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wcXOFf+8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hTuKFvG7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=elXsFP10; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2696205D3;
	Wed, 10 Apr 2024 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712771105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaFrwClPngI9/zE0tUKh4ZF3uG/AFy0qWp2ynKlaVw4=;
	b=yBxxYVQ5qlkPxthan7rOZuqjvdWMlGiSEckUBrhGCntgkxyBe3cH6Ca8fevLcFoHomITZe
	GDShA6eK07x/fuR/cCKQCz9o1H2C4pSgFxoHQfFbh6Ty4vOurIPSuL+JlC00mbz+3ABl9L
	/Rto2067OhB/bbb+TJMGwpWTA9UqGSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712771105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaFrwClPngI9/zE0tUKh4ZF3uG/AFy0qWp2ynKlaVw4=;
	b=wcXOFf+8TTqZkLO7ZAhXTaXf3LTZxdBgkYcJdIsbyfKZFrJ17TDcW2kx+A7ppzhqACHlAU
	PPHEyqM26cUBTBDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712771103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaFrwClPngI9/zE0tUKh4ZF3uG/AFy0qWp2ynKlaVw4=;
	b=hTuKFvG7HdUAjobTA8wbNFYw60I0pmphQSN0CmvsMdtMGMFYFXdR0htXCBrBVrI4cFBFkw
	S8vHT8ZXd/VMO5YXqB8Q+5TknHMO3o+n3q080BriaRpBvbFfQAQeuYpN89CAkxmovsePsW
	TbuHCdx83Zr++KxAycUsj31w5E8JkAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712771103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaFrwClPngI9/zE0tUKh4ZF3uG/AFy0qWp2ynKlaVw4=;
	b=elXsFP10Kw0MWNWMmYdgHRNgO7EAK34dkQ60DZwM9dLMUhg3O251X/W6J7IptLR/IlRGjv
	goedGCkJGw7ylaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D458E13691;
	Wed, 10 Apr 2024 17:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s0yPMx/QFmYTXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Apr 2024 17:45:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 73BD9A0681; Wed, 10 Apr 2024 19:45:03 +0200 (CEST)
Date: Wed, 10 Apr 2024 19:45:03 +0200
From: Jan Kara <jack@suse.cz>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs/direct-io: remove redundant assignment to
 variable retval
Message-ID: <20240410174503.wycdhqsglx4pms4q@quack3>
References: <20240410162221.292485-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410162221.292485-1-colin.i.king@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.65 / 50.00];
	BAYES_HAM(-2.35)[96.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email]
X-Spam-Score: -1.65
X-Spam-Flag: NO

On Wed 10-04-24 17:22:21, Colin Ian King wrote:
> The variable retval is being assigned a value that is not being read,
> it is being re-assigned later on in the function. The assignment
> is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> fs/direct-io.c:1220:2: warning: Value stored to 'retval' is never
> read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Indeed it's assigned a few lines below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/direct-io.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 62c97ff9e852..b0aafe640fa4 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1217,7 +1217,6 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	 */
>  	inode_dio_begin(inode);
>  
> -	retval = 0;
>  	sdio.blkbits = blkbits;
>  	sdio.blkfactor = i_blkbits - blkbits;
>  	sdio.block_in_file = offset >> blkbits;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

