Return-Path: <linux-fsdevel+bounces-36422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA12F9E395D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B1E168EDB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5511B4F02;
	Wed,  4 Dec 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RcMeFKnZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hp82bWE4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G9dMZVQS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5hkzPGud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F81ADFE3;
	Wed,  4 Dec 2024 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313499; cv=none; b=IZM/Dp6nEJeLhWyE5NGjzFUpGdCaRx7of1d1WhcjEnkT3+D8oBkkXh0F98T1WCKW8GQZM9BWM1fhfGLZ3BAOH7zaTgNTY1xRfS31d8qVkGqaI8eQPpUrl/RUuRRBh0VKRfgjqMUpkQLUFEJ5Uh/i3nYI2Uvt8Q5872l61LYEdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313499; c=relaxed/simple;
	bh=Fqh9zlEm/D4e/66lmT4eQS04SrHg3TY71jHBmz92b70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMwndISE3vwT/JF0Pex/OZLGZc5ZI5C+CfcN1aasJl23h5Gvtau9fiGGSgdcPLCFk7xJCwwlgvkwuv2Az4tTsDvPSv2NQARgYHMIxKOW1ZkJ6fBkeBDHy194mh3KiFTl3s5iKRODopet5HYI/LDe+pKGrl4bokDBKttmDGyfzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RcMeFKnZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hp82bWE4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G9dMZVQS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5hkzPGud; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACBF821184;
	Wed,  4 Dec 2024 11:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733313495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4NnXQPjf7rhAc2hNxC/j5jTlUW8gxPaB93QnpPiHPI=;
	b=RcMeFKnZnN/AYDMmaTW1S4lk2/K1OKT2fX+Szd3s7uRlE0HwWZdOX8Psftk7W7OIKKUHsl
	0e/4y9WVt+PUN5+dLs/VKztWKBMtp/+Vd4mITvKBVdEF41JfkH/b3G4pfeyZWMcrj0mrVW
	HjRUvomGxxnapZRsIJ21vf3INWQf8kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733313495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4NnXQPjf7rhAc2hNxC/j5jTlUW8gxPaB93QnpPiHPI=;
	b=Hp82bWE4cQ2LFMpsCefeBDjJ3KLYCtk7U+yPdvR/E3ZL5ESea7VmJGoJRvbMBCSs+1WK5b
	80+1MPu6EUkPkVBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G9dMZVQS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5hkzPGud
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733313494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4NnXQPjf7rhAc2hNxC/j5jTlUW8gxPaB93QnpPiHPI=;
	b=G9dMZVQSDhjkZqzh0fQGQ0q5IdR3xmCaOoS5DVheAaOIuZA5u3wfPE5lojfNy6CdIemuhI
	xWj2bJB2FECgnWTOrOnMWbY2AgakolLTpNNxxnfprgrr2N/868gFKpz83cde6/8o1VwZye
	ahL7HOMuR6W+xe7yvFjKpHY+vbY2h6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733313494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4NnXQPjf7rhAc2hNxC/j5jTlUW8gxPaB93QnpPiHPI=;
	b=5hkzPGudWza5ExgCkE2t98o5M47d9M2/TUNNgjv8NgHuB+tv3+5VKisHvaUgVSdPn9a3dS
	fXQssEzeJur5tIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94B421396E;
	Wed,  4 Dec 2024 11:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oIxTJNZDUGf7HAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 11:58:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 58102A0918; Wed,  4 Dec 2024 12:58:14 +0100 (CET)
Date: Wed, 4 Dec 2024 12:58:14 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 06/27] ext4: refactor ext4_collapse_range()
Message-ID: <20241204115814.5yqjont7ugtovc5g@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-7-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: ACBF821184
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue 22-10-24 19:10:37, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Simplify ext4_collapse_range() and align its code style with that of
> ext4_zero_range() and ext4_punch_hole(). Refactor it by: a) renaming
> variables, b) removing redundant input parameter checks and moving
> the remaining checks under i_rwsem in preparation for future
> refactoring, and c) renaming the three stale error tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one nit below:

> -out_stop:
> +out_handle:
>  	ext4_journal_stop(handle);
> -out_mmap:
> +out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out_mutex:
> +out:
>  	inode_unlock(inode);
>  	return ret;
>  }

Again, I think "out_inode_lock" would be a better name than just "out".

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

