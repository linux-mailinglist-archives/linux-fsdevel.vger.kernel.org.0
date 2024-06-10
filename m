Return-Path: <linux-fsdevel+bounces-21306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA4E9019C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 06:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9259C281429
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 04:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2F6B665;
	Mon, 10 Jun 2024 04:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z77PfkTK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h9nOCcky";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z77PfkTK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h9nOCcky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2689D6FB6;
	Mon, 10 Jun 2024 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717993939; cv=none; b=DgJvFxdTiYSQpmjn+XCnvDJHfNmwfM787zugqSMgax0UjN4PzXXaGE6PPItqFx/7Tv0cxGu0g4+KDijnMM3v3g8HqNMi/sKVCdEP2YRXbYjUa3hJcc+rGInWd3n9++XOkb/k5m6Zc53lFD7dZTiuAqcQ1MpXsPN/c5lpxUnwlmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717993939; c=relaxed/simple;
	bh=sq2DGq4Des/nb/60pZroDK3wA2sOgpclexWHL4QKEl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgLRphUSgPBqEgT5EeldDwj3P7FpJ2864MmFE7BSAXn7S82Uf5fdlGTjIINh4azcwmtzHZq/Pjp0/9NCjZctdut/MDFs4uI+hNvrSu7xySvr0YVMBtOPgzuWWgUo4AmZa4B7ATNQYevnHtJvSNGN6hg/louCzuPA2fQSrBNX+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z77PfkTK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h9nOCcky; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z77PfkTK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h9nOCcky; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F89321A28;
	Mon, 10 Jun 2024 04:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717993935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IND2MoD5+fzd4/enaZpt+uNExFlFrO8ngLetTeSMsF8=;
	b=z77PfkTKm4EluD1EW77pRW/2jHupe+DZKwP4g5DBI1lB7Ns2vZ4yZHHlG7dry/MDNboApa
	pbxd6gUDocDxl2/9vbwgRMcOdkcnGcE3uaC2lS4rN13Prx5i3+6l8J6mKg7rlulexG+fb/
	KbTvi/KM7nmIjJbybulnIj3luewEv7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717993935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IND2MoD5+fzd4/enaZpt+uNExFlFrO8ngLetTeSMsF8=;
	b=h9nOCckyVqEiOGqdbdzc+P0c2skzkfoHu3XOh2WdwQ47UJJekByPQZaQ7W8Yv6T8w33Iju
	8OzDSb6XQJA3koDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z77PfkTK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=h9nOCcky
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717993935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IND2MoD5+fzd4/enaZpt+uNExFlFrO8ngLetTeSMsF8=;
	b=z77PfkTKm4EluD1EW77pRW/2jHupe+DZKwP4g5DBI1lB7Ns2vZ4yZHHlG7dry/MDNboApa
	pbxd6gUDocDxl2/9vbwgRMcOdkcnGcE3uaC2lS4rN13Prx5i3+6l8J6mKg7rlulexG+fb/
	KbTvi/KM7nmIjJbybulnIj3luewEv7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717993935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IND2MoD5+fzd4/enaZpt+uNExFlFrO8ngLetTeSMsF8=;
	b=h9nOCckyVqEiOGqdbdzc+P0c2skzkfoHu3XOh2WdwQ47UJJekByPQZaQ7W8Yv6T8w33Iju
	8OzDSb6XQJA3koDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD19413A7F;
	Mon, 10 Jun 2024 04:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XjxOK86BZmbfGAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 10 Jun 2024 04:32:14 +0000
Date: Mon, 10 Jun 2024 06:32:09 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 1/6] fs/proc/task_mmu: indicate PM_FILE for PMD-mapped
 file THP
Message-ID: <ZmaBycvnd0pQswET@localhost.localdomain>
References: <20240607122357.115423-1-david@redhat.com>
 <20240607122357.115423-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607122357.115423-2-david@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3F89321A28
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]

On Fri, Jun 07, 2024 at 02:23:52PM +0200, David Hildenbrand wrote:
> Looks like we never taught pagemap_pmd_range() about the existence of
> PMD-mapped file THPs. Seems to date back to the times when we first added
> support for non-anon THPs in the form of shmem THP.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  fs/proc/task_mmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5aceb3db7565e..08465b904ced5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1522,6 +1522,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		}
>  #endif
>  
> +		if (page && !PageAnon(page))
> +			flags |= PM_FILE;
>  		if (page && !migration && page_mapcount(page) == 1)
>  			flags |= PM_MMAP_EXCLUSIVE;
>  
> -- 
> 2.45.2
> 
> 

-- 
Oscar Salvador
SUSE Labs

