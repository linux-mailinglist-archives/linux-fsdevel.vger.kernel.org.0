Return-Path: <linux-fsdevel+bounces-14466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CFE87CF2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1551F234C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B23A1C3;
	Fri, 15 Mar 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SabnGXP6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hpLkyOgr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SabnGXP6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hpLkyOgr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259D38380;
	Fri, 15 Mar 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513854; cv=none; b=sqyuVb83GeggyZd8XVZseceggq5sUiUXt/APISxAp5Xsb91z7mVxMfS25C9k6BtpN2So4HSbp7IqSBRRt1YKSudYdtTYGbb7CfDY/UWTbA37hJf8YlanxpbEF+Q48QKbqcsJ/Wbze4hR2la0MkLUAqK7QgFh+MmLZ1KNoPQ68PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513854; c=relaxed/simple;
	bh=MOfKPd489FJlCZknC+WGeEi1/YY+OGGSBZlmKEWD/Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPu6gdC/wcfopB1qSXLez7X0Gsm0K+h6sOakG2r2GQ/2h6+OeziZ8yKSkRZYvHGxJPaC7RijUPtQYbzSN9ktH8HXX7GSpuwn1VaeNmtJR7hqksyXM0PjX79WfMQ35nePsrT/ecMqEe3VmOXYuiKeTHcwswMnsaIa4bZzWkeEX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SabnGXP6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hpLkyOgr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SabnGXP6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hpLkyOgr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 404031FB67;
	Fri, 15 Mar 2024 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOvQhkPqyOvtsLRYtkbmB+sMSA1Niv8T2LWVCt4lP18=;
	b=SabnGXP6tSla+RTZD6Aok1K15JZugaK5LqswkT8skUXvqDHfUdjavgLXeCyHgJFShFKHF0
	Lik4X6c34+DCgfSLUX2zTMUL4w9yjNeBxS71iEBGLgn1jC8alT3UK8hkpYiX2veW6ABWT0
	EdnOFezqnlIZjPSEigPukrSSgmBZ5p4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOvQhkPqyOvtsLRYtkbmB+sMSA1Niv8T2LWVCt4lP18=;
	b=hpLkyOgrHkFnOot52O8VUVBoqS2qXgX7DXGFETeky6HC9EjiUc461/QrO4ci/Nw0mhzjMy
	WjY/BV0Cvoll+zBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOvQhkPqyOvtsLRYtkbmB+sMSA1Niv8T2LWVCt4lP18=;
	b=SabnGXP6tSla+RTZD6Aok1K15JZugaK5LqswkT8skUXvqDHfUdjavgLXeCyHgJFShFKHF0
	Lik4X6c34+DCgfSLUX2zTMUL4w9yjNeBxS71iEBGLgn1jC8alT3UK8hkpYiX2veW6ABWT0
	EdnOFezqnlIZjPSEigPukrSSgmBZ5p4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOvQhkPqyOvtsLRYtkbmB+sMSA1Niv8T2LWVCt4lP18=;
	b=hpLkyOgrHkFnOot52O8VUVBoqS2qXgX7DXGFETeky6HC9EjiUc461/QrO4ci/Nw0mhzjMy
	WjY/BV0Cvoll+zBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 341FF1368C;
	Fri, 15 Mar 2024 14:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mse4DLpe9GVbRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:44:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD50EA07D9; Fri, 15 Mar 2024 15:44:05 +0100 (CET)
Date: Fri, 15 Mar 2024 15:44:05 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 06/19] cramfs: prevent direct access of
 bd_inode
Message-ID: <20240315144405.oylsuv4i2gtbtwql@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-7-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-7-yukuai1@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.16
X-Spamd-Result: default: False [-2.16 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.36)[90.57%]
X-Spam-Flag: NO

On Thu 22-02-24 20:45:42, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all filesystems stash the bdev file, it's ok to get bdev mapping
> from the file directly.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/cramfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 39e75131fd5a..1df4dd89350e 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -183,7 +183,7 @@ static int next_buffer;
>  static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  				unsigned int len)
>  {
> -	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
> +	struct address_space *mapping = sb->s_bdev_file->f_mapping;
>  	struct file_ra_state ra = {};
>  	struct page *pages[BLKS_PER_BUF];
>  	unsigned i, blocknr, buffer;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

