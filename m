Return-Path: <linux-fsdevel+bounces-52241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12D5AE0A18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96BE1C226AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E628B4FE;
	Thu, 19 Jun 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ou8aj/7h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QwBgeA2p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ou8aj/7h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QwBgeA2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E481D63F5
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345712; cv=none; b=nJyd1ldohlCQ+isP+M/fqJmpQl8VuY6XXrONlAgueDAoDPLcUgsI4bgm+9RM6uNt0q0MesDFjAltXrCUaZu4UtYQaA6oOTL8+C4UPyDgWZKQpH4IGaAnrehxFuGqL70QwLa6/g87qzV3UvucNRmBggiJU2F8aczGcb9lpSCZu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345712; c=relaxed/simple;
	bh=2hA+4Ww9WHgKBd3PAkWYifAGMPeE03To9URJw6OxWh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJZtBo7c8TMnJLhXKj6dzk9I/zVEaSQm53Q5iwaMBfOKAVb0QrQU00qO7lYiNPkdBIJPdq5hggvkhBa3MIInZNFSBk8nouL5Dm8SJisaB2+Z4gDXROD4pE2/rZOK3oTuXlMA7A78obZW5gJ7SOqEc7MXVqvM5FCT2PWK0VKFJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ou8aj/7h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QwBgeA2p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ou8aj/7h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QwBgeA2p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2103F1F38D;
	Thu, 19 Jun 2025 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750345708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiUTW8EKY7uMeaNwhNHLl9fk6YHAExHTnlrG63mJjvE=;
	b=Ou8aj/7hAFdlRW+0kqnCds/mpIiL/61CmacQx9NsZmyybmTUEl3grUJct5zfAWUnQbc62G
	DFLdVoQv+ySvM0DpgNF4Isa0nhViWKMX/EBuvlWZ0Gz9VOfS5ev2jbtj+cQPMGdfrHCZ8B
	4bN6DedyLB1cxV3nu5xhF09wJHbJ2vU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750345708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiUTW8EKY7uMeaNwhNHLl9fk6YHAExHTnlrG63mJjvE=;
	b=QwBgeA2pUvtbjwCnKLV8uQTAgW/gxs1i26+nXyMits9vJ6xLwnm6GXfHaKfAaGrEUJ6fUK
	TU8cN1Tsao+TFLBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750345708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiUTW8EKY7uMeaNwhNHLl9fk6YHAExHTnlrG63mJjvE=;
	b=Ou8aj/7hAFdlRW+0kqnCds/mpIiL/61CmacQx9NsZmyybmTUEl3grUJct5zfAWUnQbc62G
	DFLdVoQv+ySvM0DpgNF4Isa0nhViWKMX/EBuvlWZ0Gz9VOfS5ev2jbtj+cQPMGdfrHCZ8B
	4bN6DedyLB1cxV3nu5xhF09wJHbJ2vU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750345708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiUTW8EKY7uMeaNwhNHLl9fk6YHAExHTnlrG63mJjvE=;
	b=QwBgeA2pUvtbjwCnKLV8uQTAgW/gxs1i26+nXyMits9vJ6xLwnm6GXfHaKfAaGrEUJ6fUK
	TU8cN1Tsao+TFLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3E5813721;
	Thu, 19 Jun 2025 15:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BbCZN+snVGjhLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Jun 2025 15:08:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 70A8DA29FA; Thu, 19 Jun 2025 17:08:27 +0200 (CEST)
Date: Thu, 19 Jun 2025 17:08:27 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 1/6] ext4: move the calculation of wbc->nr_to_write to
 mpage_folio_done()
Message-ID: <mvfcwyv5vkmsv52jh2gq4u7vjzqiyfal4pu2yawzunjjqv44vt@qgvepto6vr4j>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611111625.1668035-2-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 11-06-25 19:16:20, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> mpage_folio_done() should be a more appropriate place than
> mpage_submit_folio() for updating the wbc->nr_to_write after we have
> submitted a fully mapped folio. Preparing to make mpage_submit_folio()
> allows to submit partially mapped folio that is still under processing.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Indeed. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index be9a4cba35fd..3a086fee7989 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2024,7 +2024,10 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
>  
>  static void mpage_folio_done(struct mpage_da_data *mpd, struct folio *folio)
>  {
> -	mpd->first_page += folio_nr_pages(folio);
> +	unsigned long nr_pages = folio_nr_pages(folio);
> +
> +	mpd->first_page += nr_pages;
> +	mpd->wbc->nr_to_write -= nr_pages;
>  	folio_unlock(folio);
>  }
>  
> @@ -2055,8 +2058,6 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
>  	    !ext4_verity_in_progress(mpd->inode))
>  		len = size & (len - 1);
>  	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
> -	if (!err)
> -		mpd->wbc->nr_to_write -= folio_nr_pages(folio);
>  
>  	return err;
>  }
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

