Return-Path: <linux-fsdevel+bounces-12581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3029861374
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 15:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22127B23C80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77E380615;
	Fri, 23 Feb 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZ3Mrm2k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fwLuUbpH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZ3Mrm2k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fwLuUbpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFE80BE3;
	Fri, 23 Feb 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696797; cv=none; b=sYcvYWvyB3oicesM8BUUliRz2iNtm1wp2CmzDrJdYCXo4NDoV4QTR9XByzseYSQdmKZvBM+UjTb07eG7rg4qe8yfgF1Gey3srRGFb1siCNFxbCdE9Z7blUbPWlt1k7bN6UnT34NB5x+NGmRmQQfSCls7HxWMJ+CYWbwInH2ocVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696797; c=relaxed/simple;
	bh=WH00J42XRSLOx+AYd4eDGdtsAI7y6ZtzqylvJFYY4z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3xvasnjMY4u8LZtJcUg4u1CKC/j9laxEvlBKoZf/j4yqPxRTOm68H2r1wRx+x2Qtxd9D1MRs4R2yHjnHmDU9GV9fhapceTqJUj50Xce5gzLcsIGzAWeb6EDqXjUaIwHUR1dCULVQRx3nYLJPdjWA/GuB+Fj8O69N+7bgT0MoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZ3Mrm2k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fwLuUbpH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZ3Mrm2k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fwLuUbpH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6157021228;
	Fri, 23 Feb 2024 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708696779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5I5JLIOt6cWg7cHecCMNbeuLIZxzsx9ULi7w8Ob25k=;
	b=bZ3Mrm2k2f8asnJGUairFgzsX61UmeXmfZANe8xoomAgt+CyDDoRF8r3wDWypucksBH2iP
	v5jACxDlaYMOKliZuHxkknuPvf+H6xsRJnVy5lBBjCsPxKOg4KxQ+K8KdVuxm7vv3ZnD7W
	2ZWJgavfsDR/vkvR3N9JVRTnBgaJ94M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708696779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5I5JLIOt6cWg7cHecCMNbeuLIZxzsx9ULi7w8Ob25k=;
	b=fwLuUbpHNRaOeE4s8d7WpY7t5c5Znn4EjJtrCGtEQWt60gZb90naQDRFQeEtIFMuQCWzVH
	/5GRfVHPBc6VoNBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708696779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5I5JLIOt6cWg7cHecCMNbeuLIZxzsx9ULi7w8Ob25k=;
	b=bZ3Mrm2k2f8asnJGUairFgzsX61UmeXmfZANe8xoomAgt+CyDDoRF8r3wDWypucksBH2iP
	v5jACxDlaYMOKliZuHxkknuPvf+H6xsRJnVy5lBBjCsPxKOg4KxQ+K8KdVuxm7vv3ZnD7W
	2ZWJgavfsDR/vkvR3N9JVRTnBgaJ94M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708696779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5I5JLIOt6cWg7cHecCMNbeuLIZxzsx9ULi7w8Ob25k=;
	b=fwLuUbpHNRaOeE4s8d7WpY7t5c5Znn4EjJtrCGtEQWt60gZb90naQDRFQeEtIFMuQCWzVH
	/5GRfVHPBc6VoNBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5610413419;
	Fri, 23 Feb 2024 13:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EVr9FMuk2GWBfgAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 23 Feb 2024 13:59:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 16937A07D1; Fri, 23 Feb 2024 14:59:39 +0100 (CET)
Date: Fri, 23 Feb 2024 14:59:39 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] fs/writeback: remove unnecessary return in
 writeback_inodes_sb
Message-ID: <20240223135939.5wxt6vuifkauuksv@quack3>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-8-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208172024.23625-8-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bZ3Mrm2k;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fwLuUbpH
X-Spamd-Result: default: False [-1.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.90)[94.47%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6157021228
X-Spam-Level: 
X-Spam-Score: -1.71
X-Spam-Flag: NO

On Fri 09-02-24 01:20:24, Kemeng Shi wrote:
> writeback_inodes_sb doesn't have return value, just remove unnecessary
> return in it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 816505d74b2f..eb62196777dd 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2748,7 +2748,7 @@ EXPORT_SYMBOL(writeback_inodes_sb_nr);
>   */
>  void writeback_inodes_sb(struct super_block *sb, enum wb_reason reason)
>  {
> -	return writeback_inodes_sb_nr(sb, get_nr_dirty_pages(), reason);
> +	writeback_inodes_sb_nr(sb, get_nr_dirty_pages(), reason);
>  }
>  EXPORT_SYMBOL(writeback_inodes_sb);
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

