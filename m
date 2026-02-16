Return-Path: <linux-fsdevel+bounces-77290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAEoCqEdk2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:37:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE298143E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2454E30078A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453630CD91;
	Mon, 16 Feb 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/wq1wNd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cdWcXIJ7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/wq1wNd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cdWcXIJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176322C08AC
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249045; cv=none; b=IcSzBiMEPtB1/pHJH5+yCzosi5hyNYnVDNHbBGzkyOpatS0TGXuFErvrfxD7Oo3FFaB8trsL7cvKpK2kOaCVI5SfwL7POJ71xCQzDEM5kYqMDjS6XwiEqz4AvaDl2V8zEKb4WgwfzJSWgebqMZHuuAQVlUDJJks+c8vlzUQ+buI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249045; c=relaxed/simple;
	bh=X1w+v4aJAiJzqGszQVZcLaZtYrxZrCcZ4gUshM7fUaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ0TWc6m+pBRvOXjoCJM35AOla8Pf/SLVPdk4PuDIpKyoqmEOV33pvJFjXQP84d3lLK8USnFCa8+vgGTF89fFKsC/eWJ2QXQwm3Wj8DS3aD4KhYMc/aYmcZDgzbK4qyFPzY+BNJhqcRRNvY23LE63sgcJvF9NZO9+kDDnOv8P5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/wq1wNd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cdWcXIJ7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/wq1wNd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cdWcXIJ7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 42A5F5BE4A;
	Mon, 16 Feb 2026 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771249042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTQLcEA8i2i1Zao2fd+M0RVPTF0Ur8xUDvwwPhrhJXE=;
	b=c/wq1wNdTKCbkZquJXkmLMiBdkW40uMmQOWGOpgUrosi7Ao3RKMMg+ojKFUGf1Iz2kCCdt
	20XeTIJ2i8sliBL86AfbZIc4IZZU2p6bYlwWAU/RrvAqczUzvj5/sV1IqrkCURzq8N9XhH
	wq668Azxqxx6pGWS/3uhaRAhKJYlgpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771249042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTQLcEA8i2i1Zao2fd+M0RVPTF0Ur8xUDvwwPhrhJXE=;
	b=cdWcXIJ7U52cSVfbcKeaA7cu+LkESZ6TIQtcCh/BW4vsYcA0cXcDDYvkTYX7tWqqchyE3h
	myscfGDbf0LJyzAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="c/wq1wNd";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cdWcXIJ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771249042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTQLcEA8i2i1Zao2fd+M0RVPTF0Ur8xUDvwwPhrhJXE=;
	b=c/wq1wNdTKCbkZquJXkmLMiBdkW40uMmQOWGOpgUrosi7Ao3RKMMg+ojKFUGf1Iz2kCCdt
	20XeTIJ2i8sliBL86AfbZIc4IZZU2p6bYlwWAU/RrvAqczUzvj5/sV1IqrkCURzq8N9XhH
	wq668Azxqxx6pGWS/3uhaRAhKJYlgpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771249042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTQLcEA8i2i1Zao2fd+M0RVPTF0Ur8xUDvwwPhrhJXE=;
	b=cdWcXIJ7U52cSVfbcKeaA7cu+LkESZ6TIQtcCh/BW4vsYcA0cXcDDYvkTYX7tWqqchyE3h
	myscfGDbf0LJyzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 204C93EA62;
	Mon, 16 Feb 2026 13:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i/QFCZIdk2kgdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Feb 2026 13:37:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 83BD2A0AA5; Mon, 16 Feb 2026 14:37:15 +0100 (CET)
Date: Mon, 16 Feb 2026 14:37:15 +0100
From: Jan Kara <jack@suse.cz>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: inotify: pass mark connector to
 fsnotify_recalc_mask()
Message-ID: <q3m6dhl767csp34kjnb44zgdbxwn262qfbtporetuedo6esamm@givx7oa7l4op>
References: <20260214051217.1381363-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214051217.1381363-1-sun.jian.kdev@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77290-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE298143E4B
X-Rspamd-Action: no action

On Sat 14-02-26 13:12:17, Sun Jian wrote:
> fsnotify_recalc_mask() expects a plain struct fsnotify_mark_connector *,
> but inode->i_fsnotify_marks is an __rcu pointer.  Use fsn_mark->connector
> instead to avoid sparse "different address spaces" warnings.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

Thanks. The patch looks good to me. I'll queue it in my tree once the merge
window closes.

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index b372fb2c56bd..9a5f2af94659 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -573,7 +573,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
>  
>  		/* update the inode with this new fsn_mark */
>  		if (dropped || do_inode)
> -			fsnotify_recalc_mask(inode->i_fsnotify_marks);
> +			fsnotify_recalc_mask(fsn_mark->connector);
>  
>  	}
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

