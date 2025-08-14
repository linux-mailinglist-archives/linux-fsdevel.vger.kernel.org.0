Return-Path: <linux-fsdevel+bounces-57880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3284FB2658C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9838EA21BC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD2A2FD1A1;
	Thu, 14 Aug 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IO2+X+fO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="verwky+j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IO2+X+fO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="verwky+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FB325C706
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175209; cv=none; b=Utlf/dls9wBmRfz4YCBrUwS0Ez+FbU9wcOiE8ITSjOglIUXr/1/G8T4I0eMrWyRcYSoG4wLWMZVTjocDn30xH0VTxurDzd3BkDNPRlPL7hXCgynHS5oxPPBMF4NgdSnK/Y+l5ipEO87kB8qWmwkYmOYPEsDi4oXK1sTSOEac4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175209; c=relaxed/simple;
	bh=bvIYxx2YnZURmLbZ57AdTUMsaAWFoYf3aT1tqZXFWrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWqb8k4+wdywpTbpFJ+Bvr5Bsm5uhLo3OXatzq/6f/Tzaxta4ilxPe3WKxikVzBekTehSu4rDUe1+FgGIiOwFmpWTN2uVfSH0XWvF17wcQmxKTBOLFOIDpBbgbhB5UFmdPkY/Urhtf9RoR9iLffgx68NCT6AlbUrP8+0g3ICuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IO2+X+fO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=verwky+j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IO2+X+fO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=verwky+j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00BD821A33;
	Thu, 14 Aug 2025 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755175206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wJyZnSiEeD2NkKQdbPdW3SaUij8cotXfvT/YrHlHLo=;
	b=IO2+X+fOpwHjsiR8WpWeIpfuO2AhSBB2229uKhqrR7ya+Ml+LdKM6tr6WH8eSL1yIE6BeX
	eDZkPk0nHd0wj3kSrdNvxCdKdjsllavt5VJT6E6WIhQU+J+iX5/ESgkzHqhn/gb1t6+1ej
	OyH/bx+/RwHEchhRrXIZbOkWaiMxsfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755175206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wJyZnSiEeD2NkKQdbPdW3SaUij8cotXfvT/YrHlHLo=;
	b=verwky+jL1qngsaV9F+rTlETM3ggKh3lxHqZNArRbaGbgUkvprGYy1mM8ENxiwz0X5zoj/
	M+WKkE58MDDe5YBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IO2+X+fO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=verwky+j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755175206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wJyZnSiEeD2NkKQdbPdW3SaUij8cotXfvT/YrHlHLo=;
	b=IO2+X+fOpwHjsiR8WpWeIpfuO2AhSBB2229uKhqrR7ya+Ml+LdKM6tr6WH8eSL1yIE6BeX
	eDZkPk0nHd0wj3kSrdNvxCdKdjsllavt5VJT6E6WIhQU+J+iX5/ESgkzHqhn/gb1t6+1ej
	OyH/bx+/RwHEchhRrXIZbOkWaiMxsfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755175206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wJyZnSiEeD2NkKQdbPdW3SaUij8cotXfvT/YrHlHLo=;
	b=verwky+jL1qngsaV9F+rTlETM3ggKh3lxHqZNArRbaGbgUkvprGYy1mM8ENxiwz0X5zoj/
	M+WKkE58MDDe5YBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 478C11368C;
	Thu, 14 Aug 2025 12:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XslHDiXZnWgbWgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 14 Aug 2025 12:40:05 +0000
Date: Thu, 14 Aug 2025 13:40:03 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] testing/radix-tree/maple: hack around kfree_rcu not
 existing
Message-ID: <kq3y4okddkjpl3yk3ginadnynysukiuxx3wlxk63yhudeuidcc@pu5gysfsrgrb>
References: <20250814064927.27345-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814064927.27345-1-lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 00BD821A33
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu, Aug 14, 2025 at 07:49:27AM +0100, Lorenzo Stoakes wrote:
> From: Pedro Falcato <pfalcato@suse.de>
> 
> liburcu doesn't have kfree_rcu (or anything similar). Despite that, we can
> hack around it in a trivial fashion, by adding a wrapper.
> 
> This wrapper only works for maple_nodes, and not anything else (due to us
> not being able to know rcu_head offsets in any way), and thus we take
> advantage of the type checking to avoid future silent breakage.
> 
> This fixes the build for the VMA userland tests.
> 
> Additionally remove the existing implementation in maple.c, and have
> maple.c include the maple-shared.c header.
> 
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
> 
> Andrew - please attribute this as Pedro's patch (Pedro - please mail to
> confirm), as this is simply an updated version of [0], pulled out to fix the
> VMA tests which remain broken.
>

ACK, this is fine. The future of the series is still unclear, so if this fixes
the build then all good from my end :)

-- 
Pedro

