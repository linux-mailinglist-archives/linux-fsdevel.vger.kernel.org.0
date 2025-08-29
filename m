Return-Path: <linux-fsdevel+bounces-59643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A57BB3B932
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 12:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879CF1B25886
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B1930F952;
	Fri, 29 Aug 2025 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lrpGuD7t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tWsmsf+j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="269duIiD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AKUBOPUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8430F936
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464652; cv=none; b=JQ0sbHpUmL//aJEXDqUD9I5cEwgS3SqB4f0ZLfPmdjYCA7pdRytkAiiWk8BOckTrjnbaoFx1+4pFRimJYc7MycGWtt7u1UznyW97GL89xwmxl0kdoohk7J9Qy3wa4Agp7ecL/rAsK61DG9zhcwN/jH3flkK8JfbRR03B+rb2P1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464652; c=relaxed/simple;
	bh=Tz3cL+bKvDCQOoip8t8mjgh8A1M5usS+Byhfwta/3js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjMBYyVU35jXwcPpLGCIUAZzwSXwnOk/46w8zlVEOyCohPUL7LZvOezK1m9VkhHNCUZk6dBDr15U4FEgN2MLDTsTWVgSew8BM/+zaHlIJb16nQfhqKpT5AcBWnOTxxbtau6ygdrlMVSYbSfz6ajY4IuOi/2TH63vtJlUYdeRio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lrpGuD7t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tWsmsf+j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=269duIiD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AKUBOPUW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA6D733D62;
	Fri, 29 Aug 2025 10:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756464649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UPiUgeuCk/a7HfFDE6hU8Nbqz85sIpnnrPgWbHkfAs=;
	b=lrpGuD7t38UgBSFBACDfyq1jKuQDJ5EUf0XIgYrQE7xbGRA2um6Vryf6lcetov86WT3kut
	hrS+RLkJI1QVIm4QGl8atJ9ifQLr6Xxdyala4b258CI7nEXBccyxykBQ2ZTWj+Mpq61C0x
	MkK0Ap+vsLtaN2NLnRNS32BjejKHa1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756464649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UPiUgeuCk/a7HfFDE6hU8Nbqz85sIpnnrPgWbHkfAs=;
	b=tWsmsf+jQinRrEX9R8Ox/O95kW8KVz46QlQYo/VfMqOY6KfA2oZQkwiClZ3TJh1p6pcPgN
	TVXfVkiVB8FymrBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=269duIiD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AKUBOPUW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756464648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UPiUgeuCk/a7HfFDE6hU8Nbqz85sIpnnrPgWbHkfAs=;
	b=269duIiDNiwbzX90NLkd8skPtJNtmNCc/otO0eirDnO1sr+Fxee/58DKAwmFVCLRZg3FxQ
	JqU/9/7yV+plS7wd4yBuEvKPJ0BWDW9CnwsKri6tk0cgJGqkrEQdfLVDWU2IZQIXTTidCE
	UQxQRNgTRpNlYWoxJO96njXk5pN75P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756464648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UPiUgeuCk/a7HfFDE6hU8Nbqz85sIpnnrPgWbHkfAs=;
	b=AKUBOPUWXiGL4wIm1Jw/4D8XwfsPokxqDEFjXGrZmVW8xHwI8nVkQ1AF4TLJAl/t2Oke2t
	+q8QzNPe5hauhTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA78213AF6;
	Fri, 29 Aug 2025 10:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Qh/LQiGsWiBTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 29 Aug 2025 10:50:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28BF7A099C; Fri, 29 Aug 2025 12:50:48 +0200 (CEST)
Date: Fri, 29 Aug 2025 12:50:48 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fhandle: use more consistent rules for decoding file
 handle from userns
Message-ID: <xdvs4ljulkgkpdyuum2hwzhpy2jxb7g55lcup7jvlf6rfwjsjt@s63vk6mpyp5e>
References: <20250827194309.1259650-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827194309.1259650-1-amir73il@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CA6D733D62
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Wed 27-08-25 21:43:09, Amir Goldstein wrote:
> Commit 620c266f39493 ("fhandle: relax open_by_handle_at() permission
> checks") relaxed the coditions for decoding a file handle from non init
> userns.
> 
> The conditions are that that decoded dentry is accessible from the user
> provided mountfd (or to fs root) and that all the ancestors along the
> path have a valid id mapping in the userns.
> 
> These conditions are intentionally more strict than the condition that
> the decoded dentry should be "lookable" by path from the mountfd.
> 
> For example, the path /home/amir/dir/subdir is lookable by path from
> unpriv userns of user amir, because /home perms is 755, but the owner of
> /home does not have a valid id mapping in unpriv userns of user amir.
> 
> The current code did not check that the decoded dentry itself has a
> valid id mapping in the userns.  There is no security risk in that,
> because that final open still performs the needed permission checks,
> but this is inconsistent with the checks performed on the ancestors,
> so the behavior can be a bit confusing.
> 
> Add the check for the decoded dentry itself, so that the entire path,
> including the last component has a valid id mapping in the userns.
> 
> Fixes: 620c266f39493 ("fhandle: relax open_by_handle_at() permission checks")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Yeah, probably it's less surprising this way. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 68a7d2861c58f..a907ddfac4d51 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -207,6 +207,14 @@ static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
>  	if (!ctx->flags)
>  		return 1;
>  
> +	/*
> +	 * Verify that the decoded dentry itself has a valid id mapping.
> +	 * In case the decoded dentry is the mountfd root itself, this
> +	 * verifies that the mountfd inode itself has a valid id mapping.
> +	 */
> +	if (!privileged_wrt_inode_uidgid(user_ns, idmap, d_inode(dentry)))
> +		return 0;
> +
>  	/*
>  	 * It's racy as we're not taking rename_lock but we're able to ignore
>  	 * permissions and we just need an approximation whether we were able
> -- 
> 2.50.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

