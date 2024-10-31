Return-Path: <linux-fsdevel+bounces-33359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C489B7EC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 16:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385D0B213F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F7B1A38C2;
	Thu, 31 Oct 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DHxDqkNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UCrJBWAr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DHxDqkNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UCrJBWAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3D13342F;
	Thu, 31 Oct 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389404; cv=none; b=n25ai6LxaoripCHQodr7rt/wXlmZzOcK5KnB//hXleqDoSQ1FtshBEVEDSzbF5p7JFs6wpoFTm8KEGMqw1sY3JmVyvWB3KijB9QRC9hTlyeVpXJA3DJAfSbbn4mlCbBiR0lIu8izXNYbQt5vy/Z3gY5221aMeHtKtbDpNJjdKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389404; c=relaxed/simple;
	bh=QIb+KiWW445jTY1jXtXhMes2+kcSRYXHrtlb1c57A/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aq7shM8R6l1SII4bH19EJ1+coBL0G9+NbGmlhDCYS0PsJzCNrbfuyCXmNrWxTZbzJnUexDtwzmjizhJjuW4fTBmv1JzF6cmQbYSxilUduyxWAHilM2K/iCU6/yjPxQ3ybNdKW/k7RT3FpH9Tj8J+hh1Vp8K54nPoxdLySPsLGJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DHxDqkNb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UCrJBWAr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DHxDqkNb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UCrJBWAr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 153B11FC05;
	Thu, 31 Oct 2024 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730389399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=92Eib5T2+d4XUT2lN7mLZGH4pQN0PW78HSp3DubOHa0=;
	b=DHxDqkNbHxL8nFIB458dOVAhK40c8/5lPlJ9cMLv7Gh2/gfVxUeOo+n7ltlwM/waCPhAaG
	trX5tptLZ9JKdwNzdNKM0ixt8sqf2UMW7VbOngH88q68/w2c2AzMDzBZVhGWWL4T7d0zEU
	wEDFQZ5L8B6eTgwUHw8AXu0i23k+jjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730389399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=92Eib5T2+d4XUT2lN7mLZGH4pQN0PW78HSp3DubOHa0=;
	b=UCrJBWAr6RyYmQCmVFq25CHGbrmwwMLPwBfZ8OWYcAlfAT+5WST/GnMLR8xIVynsQ31fYX
	ED4OEW+BMLkC13CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730389399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=92Eib5T2+d4XUT2lN7mLZGH4pQN0PW78HSp3DubOHa0=;
	b=DHxDqkNbHxL8nFIB458dOVAhK40c8/5lPlJ9cMLv7Gh2/gfVxUeOo+n7ltlwM/waCPhAaG
	trX5tptLZ9JKdwNzdNKM0ixt8sqf2UMW7VbOngH88q68/w2c2AzMDzBZVhGWWL4T7d0zEU
	wEDFQZ5L8B6eTgwUHw8AXu0i23k+jjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730389399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=92Eib5T2+d4XUT2lN7mLZGH4pQN0PW78HSp3DubOHa0=;
	b=UCrJBWAr6RyYmQCmVFq25CHGbrmwwMLPwBfZ8OWYcAlfAT+5WST/GnMLR8xIVynsQ31fYX
	ED4OEW+BMLkC13CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 069FD13A53;
	Thu, 31 Oct 2024 15:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LbKXAZelI2fjJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 31 Oct 2024 15:43:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2E57A086F; Thu, 31 Oct 2024 16:43:14 +0100 (CET)
Date: Thu, 31 Oct 2024 16:43:14 +0100
From: Jan Kara <jack@suse.cz>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] xattr: remove redundant check on variable err
Message-ID: <20241031154314.576ksnwaruuqqwq2@quack3>
References: <20241030180140.3103156-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030180140.3103156-1-colin.i.king@gmail.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.978];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 30-10-24 18:01:40, Colin Ian King wrote:
> Curretly in function generic_listxattr the for_each_xattr_handler loop
> checks err and will return out of the function if err is non-zero.
> It's impossible for err to be non-zero at the end of the function where
> err is checked again for a non-zero value. The final non-zero check is
> therefore redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Yeah, makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 05ec7e7d9e87..21beb82ab5dc 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1015,7 +1015,7 @@ generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>  			return err;
>  	}
>  
> -	return err ? err : buffer_size - remaining_size;
> +	return buffer_size - remaining_size;
>  }
>  EXPORT_SYMBOL(generic_listxattr);
>  
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

