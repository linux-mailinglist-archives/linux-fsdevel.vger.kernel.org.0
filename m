Return-Path: <linux-fsdevel+bounces-50714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7453ACEBB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29431753CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E8205AB6;
	Thu,  5 Jun 2025 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BEWZJPWx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aEvM2aGh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yVNNQfCG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FhIH3GPO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FD20012C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111751; cv=none; b=ZZ1Btkb4n/AQgsiELPqZI/6AuM8TdVEHRxPMG6XUdzdKHN+6fyCYtMqba78DPzH8RfxzZKBelFI6aUxEQhEUMe30oPs3FLGUGe1yhxVRzddomzmV2s1RuLSVf8hSsNLcrtiRL7K5JfkzC91aSQKp5+1MyiFkPqIkHnbEmXG3iGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111751; c=relaxed/simple;
	bh=BS5ErSQFZKq+7kg9upVNEdfD3Awdd/h9z4xDcxD/XfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLp5WluxODEp/A0WXeG6AfJUhZh4dxBJXUyCnt92Bz8FD2g1H8rvVlvuqlAXWZsv+06RX0/dlJ8aq4x3iSHjW2PF3cgNHob4udrivE1iQpFU640Hu3+p1X6KaPKWfdZp7SVtordIH0YwtLm2xq+ROxUq+vFJjzwcaAY/3bcOtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BEWZJPWx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aEvM2aGh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yVNNQfCG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FhIH3GPO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED4FE5BF44;
	Thu,  5 Jun 2025 08:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749111748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mG4VCh9tlRxGqy5O4mxRiy9A5IFEM35DxvBHVeN1js4=;
	b=BEWZJPWxFehhiwfcyh967XUrO5y9JmHZHR+l0vqVXUP/3PlPzEvXXlwD/Vwe5tLknpnNv0
	fw1KAr/uiFR6HK+PWbjSpe7ng//GzkmJkwB4IqwKIXO/73iwVq/THBV4RLT0M7Z6uosTz3
	i1LBW30eUfq5Be8lK3Ar4qFu+IZ1b4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749111748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mG4VCh9tlRxGqy5O4mxRiy9A5IFEM35DxvBHVeN1js4=;
	b=aEvM2aGhxDaJO4xwhCHRD59KhUq8kx3S89zh7LY7WjJTPGjDNQQZhEEj2zbrzMLlbsQA0L
	cjXn/ECyMGRcVWDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yVNNQfCG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FhIH3GPO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749111747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mG4VCh9tlRxGqy5O4mxRiy9A5IFEM35DxvBHVeN1js4=;
	b=yVNNQfCGuVN7Yt1fN4BbWOG2aui2spn406vLnVPtFRABhdOQ4Z6ujq0I9Gcs4F1ibaSqbR
	Gv4aieEAJIwJOIuQa8VsJ471ZhW7Lb44NNtUksMwlhK297aFoTlpCrPvu91wppWqy2zBYe
	kNFEhs6G9MxGrIMweDA7r3TF+E15FUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749111747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mG4VCh9tlRxGqy5O4mxRiy9A5IFEM35DxvBHVeN1js4=;
	b=FhIH3GPOi8w7eWR8e/597X4ZXPYFG9QlazlnrGlWbe7Jz9ZJMJyXf7z5f+fL6mdeiXW6B1
	zl8EHailOBGsDOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D8B137FE;
	Thu,  5 Jun 2025 08:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id foodN8NTQWj6QQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Jun 2025 08:22:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A09BA0951; Thu,  5 Jun 2025 10:22:23 +0200 (CEST)
Date: Thu, 5 Jun 2025 10:22:23 +0200
From: Jan Kara <jack@suse.cz>
To: Chi Zhiling <chizhiling@163.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, josef@toxicpanda.com, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] readahead: fix return value of page_cache_next_miss()
 when no hole is found
Message-ID: <qbuhdfdvbyida5y7g34o4rf5s5ntx462ffy3wso3pb5f3t4pev@3hqnswkp7of6>
References: <20250605054935.2323451-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605054935.2323451-1-chizhiling@163.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: ED4FE5BF44
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Thu 05-06-25 13:49:35, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> max_scan in page_cache_next_miss always decreases to zero when no hole
> is found, causing the return value to be index + 0.
> 
> Fix this by preserving the max_scan value throughout the loop.
> 
> Fixes: 901a269ff3d5 ("filemap: fix page_cache_next_miss() when no hole found")
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>

Indeed. Thanks for catching this. Don't know how I missed that. Feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b5e784f34d98..148be65be1cd 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1767,8 +1767,9 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
>  			     pgoff_t index, unsigned long max_scan)
>  {
>  	XA_STATE(xas, &mapping->i_pages, index);
> +	unsigned long nr = max_scan;
>  
> -	while (max_scan--) {
> +	while (nr--) {
>  		void *entry = xas_next(&xas);
>  		if (!entry || xa_is_value(entry))
>  			return xas.xa_index;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

