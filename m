Return-Path: <linux-fsdevel+bounces-59625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5040B3B775
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4201887392
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA492F0C5E;
	Fri, 29 Aug 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHCy7lk3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G84P3RpO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHCy7lk3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G84P3RpO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FABA2EFDAE
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459636; cv=none; b=m7vrqb2REEbZkEBrDUA3TFFTfDxipLKgd/n6UmtZdrE7SF3/MGa88vJ+Z50xB/NjhIXOC+UF4+jYhnAPo5/KnEvmzbr+n4LRWHhnhGWaPBgWBGlQ+KM0VTXVOS4Oa0B+cHqHKipWqqBnpFFGxMvP+5ekYhFrpjCgnt5W/4jpDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459636; c=relaxed/simple;
	bh=kxhXbEWEmhBcd+QpJMTnmcE1P7rphBjRmfsCZBjC5n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlYqs1dIDqd4selqQPHxknXBsIccAO6SikxNkjK9H7IPs6nSgUF96MfYRGlidA7agW56WT97hi4ynk0GzqzIj/MKZDSj6Sb8SCFtOOAPvuC7h3ALJ4xabtQxR8ctxFIXft1sP+veyeqY0R67RqsudrpxVEGqpXNWg0vEvbGk03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHCy7lk3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G84P3RpO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHCy7lk3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G84P3RpO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17EFB207CD;
	Fri, 29 Aug 2025 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756459628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMNvp6aJZPRO/eumDR8IUAtr0y7CCMCS5RSfKCzLGko=;
	b=xHCy7lk3SW0Fk7PWWPZv+/NHhfB1bbGCNVc746sg/Ise8q+ULwN8trwuLr5DI7nW5XiMt6
	Im70+H2cMUQx3B0YzqeCoMEKXMAKVdtxWySV0o0izoEJqOMnKea85nv8tj6E9SMtZ77lbp
	T9WAnRdW6znNoTeGD7YLtA8Zdm/dqXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756459628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMNvp6aJZPRO/eumDR8IUAtr0y7CCMCS5RSfKCzLGko=;
	b=G84P3RpO/VmKz82Vve+fYtkgJePq86E7JHYq0+4ARLzCFbCQVS2X8xXXGz6+sxHb+nmhuY
	sJG7+evDjuoF3KBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xHCy7lk3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=G84P3RpO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756459628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMNvp6aJZPRO/eumDR8IUAtr0y7CCMCS5RSfKCzLGko=;
	b=xHCy7lk3SW0Fk7PWWPZv+/NHhfB1bbGCNVc746sg/Ise8q+ULwN8trwuLr5DI7nW5XiMt6
	Im70+H2cMUQx3B0YzqeCoMEKXMAKVdtxWySV0o0izoEJqOMnKea85nv8tj6E9SMtZ77lbp
	T9WAnRdW6znNoTeGD7YLtA8Zdm/dqXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756459628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMNvp6aJZPRO/eumDR8IUAtr0y7CCMCS5RSfKCzLGko=;
	b=G84P3RpO/VmKz82Vve+fYtkgJePq86E7JHYq0+4ARLzCFbCQVS2X8xXXGz6+sxHb+nmhuY
	sJG7+evDjuoF3KBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 076CD13326;
	Fri, 29 Aug 2025 09:27:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w43IAWxysWgINAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 29 Aug 2025 09:27:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 25564A099C; Fri, 29 Aug 2025 11:27:03 +0200 (CEST)
Date: Fri, 29 Aug 2025 11:27:03 +0200
From: Jan Kara <jack@suse.cz>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, mic@digikod.net, 
	jack@suse.cz, gnoack@google.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Replace offsetof() with struct_size() in
 ioctl_file_dedupe_range()
Message-ID: <65m5gqzejxjjeso2kxsu2pojdaylvv3z6nbl5lqimbxkz464ic@kc2nasscngeo>
References: <20250829091510.597858-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829091510.597858-1-zhao.xichao@vivo.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 17EFB207CD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Fri 29-08-25 17:15:10, Xichao Zhao wrote:
> When dealing with structures containing flexible arrays, struct_size()
> provides additional compile-time checks compared to offsetof(). This
> enhances code robustness and reduces the risk of potential errors.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Indeed. Also with struct_size() it is more obvious what was the intention.
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 0248cb8db2d3..83d07218b6cd 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -426,7 +426,7 @@ static int ioctl_file_dedupe_range(struct file *file,
>  		goto out;
>  	}
>  
> -	size = offsetof(struct file_dedupe_range, info[count]);
> +	size = struct_size(same, info, count);
>  	if (size > PAGE_SIZE) {
>  		ret = -ENOMEM;
>  		goto out;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

