Return-Path: <linux-fsdevel+bounces-12576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC5586133C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE5B1C21198
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CC680058;
	Fri, 23 Feb 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpvZQopB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dltkzz6g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpvZQopB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dltkzz6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C67F460;
	Fri, 23 Feb 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696159; cv=none; b=u+v6jIGCiTTQQBMlul280iRbbW6u3pBlp66RBNXSfLAAnshnHYHiqVJHn/1oCRySXxaOzL4Ky54WnnMYi/DALr8rvADw2WcjkjhXa/fGTS3JMDYXp0l8ntdURQLhrYOVl+vS8qKqKz7Pm5MV8258wBrxZrrzXxgJ1aXDuz1ADRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696159; c=relaxed/simple;
	bh=gKUBK0CoPjpYUTQslOTw1FVWTkhJy5XxJn5pEs1c0NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2HW71B7xprLiA2NPR9BqESIT9iFxdheImxELBrvspew7+XIbXpmUxhs3+oXZNKrC/mavvF3ITBKo7JatvX3+sn7O9/LdL8abwz63TC8lU95whySjf/r1AQ7hlKVZfgcrpKyHZY0IQNiHKGTTdgfiCBURikouTpRCFcX5hLExwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpvZQopB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dltkzz6g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpvZQopB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dltkzz6g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BCC91F7AF;
	Fri, 23 Feb 2024 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708696156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJwrLAcdRzg/8Vh7S2MSUyEvRQx5UjdTY7fI/KTU2o=;
	b=mpvZQopB6Qr+3TwfWrrAnpgYCt8ceDOYg2Hl2WYSA8wfJNxU2VMxe3fpPP2DRxiINhSaw1
	ZjRWs73LLrQb9wyLVQ6zMLT92X0yQcgPS9t3blg9SeUJDS3wzSsk3k7Xift98breYvRPCu
	dwETyTgMXq/Du9RKVri7VvyL8SERw3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708696156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJwrLAcdRzg/8Vh7S2MSUyEvRQx5UjdTY7fI/KTU2o=;
	b=dltkzz6gsPyzRt7AjH9w3SA1JsZF+n038FJuoRRaQi+u5x8CWW/dY91Fbh8mgD2LMLRaP+
	UFJeICa74JEfPrAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708696156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJwrLAcdRzg/8Vh7S2MSUyEvRQx5UjdTY7fI/KTU2o=;
	b=mpvZQopB6Qr+3TwfWrrAnpgYCt8ceDOYg2Hl2WYSA8wfJNxU2VMxe3fpPP2DRxiINhSaw1
	ZjRWs73LLrQb9wyLVQ6zMLT92X0yQcgPS9t3blg9SeUJDS3wzSsk3k7Xift98breYvRPCu
	dwETyTgMXq/Du9RKVri7VvyL8SERw3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708696156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0YJwrLAcdRzg/8Vh7S2MSUyEvRQx5UjdTY7fI/KTU2o=;
	b=dltkzz6gsPyzRt7AjH9w3SA1JsZF+n038FJuoRRaQi+u5x8CWW/dY91Fbh8mgD2LMLRaP+
	UFJeICa74JEfPrAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C56E13776;
	Fri, 23 Feb 2024 13:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +omvAlyi2GU+fAAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 23 Feb 2024 13:49:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A547EA07D1; Fri, 23 Feb 2024 14:49:15 +0100 (CET)
Date: Fri, 23 Feb 2024 14:49:15 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] fs/writeback: bail out if there is no more inodes
 for IO and queued once
Message-ID: <20240223134915.rfgsrtemvhqfmt2t@quack3>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208172024.23625-3-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Fri 09-02-24 01:20:19, Kemeng Shi wrote:
> For case there is no more inodes for IO in io list from last wb_writeback,
> We may bail out early even there is inode in dirty list should be written
> back. Only bail out when we queued once to avoid missing dirtied inode.
> 
> This is from code reading...
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a9a918972719..edb0cff51673 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2086,6 +2086,7 @@ static long wb_writeback(struct bdi_writeback *wb,
>  	struct inode *inode;
>  	long progress;
>  	struct blk_plug plug;
> +	bool queued = false;
>  
>  	if (work->for_kupdate)
>  		filter_expired_io(wb);
> @@ -2131,8 +2132,10 @@ static long wb_writeback(struct bdi_writeback *wb,
>  			dirtied_before = jiffies;
>  
>  		trace_writeback_start(wb, work);
> -		if (list_empty(&wb->b_io))
> +		if (list_empty(&wb->b_io)) {
>  			queue_io(wb, work, dirtied_before);
> +			queued = true;
> +		}
>  		if (work->sb)
>  			progress = writeback_sb_inodes(work->sb, wb, work);
>  		else
> @@ -2155,7 +2158,7 @@ static long wb_writeback(struct bdi_writeback *wb,
>  		/*
>  		 * No more inodes for IO, bail
>  		 */
> -		if (list_empty(&wb->b_more_io)) {
> +		if (list_empty(&wb->b_more_io) && queued) {
>  			spin_unlock(&wb->list_lock);
>  			break;
>  		}
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

