Return-Path: <linux-fsdevel+bounces-60482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 134FFB488AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5D9188E045
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC927F4F5;
	Mon,  8 Sep 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B7Lw6Tli";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MoPFdUyH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kg+Wor1f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WVCHrk1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAD2E7F30
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324317; cv=none; b=Qzbb4QuxdKHP4dyB4TyAaujNZCtZcqtJElvShnc4mRc+YUnpoT3PQzC3T25zlZIMzE0Mmqxz3hEZssICcuFz453h/vypKrD3NrYE1UYCE+OJcmqvb9u+6L5WNSW+RIfvIgdVKX6QxBrG+VvUW9ujfFshjzpFkoBoY0joWRvZPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324317; c=relaxed/simple;
	bh=1YLj3r4R201AjvVcdU1Z5tn466aiJcU5QbXqwGwYquk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwfGIKuqjDCtwrjRghCEtkyXXlHgTe88Lu4IBFXcZXMBzTX5RCltVbb9k8VhK0cFusIFMb5ey8ivh9Pn0sk7t6yjLnLjBP31FAoWaETKfoTWbNkFWdBU+FvAA2NzV5wlZUWoQJEtHI7pQbNF34cDGgw50DsRMEfeyytwpg/tQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B7Lw6Tli; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MoPFdUyH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kg+Wor1f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WVCHrk1R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC6BB24A8E;
	Mon,  8 Sep 2025 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDpAKXucf4dbnAKr0oIJVQVjWitARPDmONq3+RH9x0o=;
	b=B7Lw6TliYou5dL/Q5kMplPmDBaHJK8Nu3CZiK68Nx3VyKgm06RMQdaXkFSQ0S+QtCQMQ4f
	S1or14WyaFB0k5/wWj81MWKw6I+O21Joda/ztm249mGynYuAr0FQotharC51Jof+BcjqPI
	lGRUGISkzXk0fwKyU93XPzu6Faf8omE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDpAKXucf4dbnAKr0oIJVQVjWitARPDmONq3+RH9x0o=;
	b=MoPFdUyH34CNV0fDeX/Y9h7RT6aEnCOtD7n4QxHVsk34TAXK75cyYwqh+VSHRvitnh8Oc3
	2L9F8K05bLqBhCBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kg+Wor1f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WVCHrk1R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDpAKXucf4dbnAKr0oIJVQVjWitARPDmONq3+RH9x0o=;
	b=kg+Wor1fGCLQm9+EUH3iaoYlpW2GKavbRBMhNRx4oxdAOWAHuOv3vTe2jyBk8n6jsYMgNS
	aCixjRnbcwhii5LrhVgzavu9IJMdSQwqfZ1W4fI4K/EE6Z66jrlr2ukr4xFXww/7QKwGJM
	UObwtGp0GbDaktYxc5nDoweH/7zAHWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDpAKXucf4dbnAKr0oIJVQVjWitARPDmONq3+RH9x0o=;
	b=WVCHrk1RfxBjStWOVlWMAa7peROmz2P9uLrzRn6ZVr8veBSEzneP/+zh8CUd3ljSiA5qZp
	HDsoQYjg6u1s3vBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3C4D13869;
	Mon,  8 Sep 2025 09:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vu7vJxekvmhGbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:38:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4F0C1A0A2D; Mon,  8 Sep 2025 11:38:27 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:38:27 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 02/21] constify path argument of vfs_statx_path()
Message-ID: <bggsanduwjjla5qi4tkdyhat4hfbrwlecb5zxn3aip2szowvzm@sy3dexokz66g>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-2-viro@zeniv.linux.org.uk>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,linux-foundation.org,gmail.com,oracle.com,apparmor.net];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: BC6BB24A8E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Sat 06-09-25 10:11:18, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index f95c1dc3eaa4..6c79661e1b96 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -293,7 +293,7 @@ static int statx_lookup_flags(int flags)
>  	return lookup_flags;
>  }
>  
> -static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
> +static int vfs_statx_path(const struct path *path, int flags, struct kstat *stat,
>  			  u32 request_mask)
>  {
>  	int error = vfs_getattr(path, stat, request_mask, flags);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

