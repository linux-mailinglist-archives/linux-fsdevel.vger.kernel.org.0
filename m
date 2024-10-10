Return-Path: <linux-fsdevel+bounces-31552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4700F998597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E291C241E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 12:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF21C3F2E;
	Thu, 10 Oct 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T5A5EIcS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rGm1tJ3a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T5A5EIcS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rGm1tJ3a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27B18FDBE;
	Thu, 10 Oct 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562073; cv=none; b=oPUp0uEcS2Y3XpFYW6Avwm5dQmMjSLP3gtGF77lcjxYsBPi5bDnNW2B0Hva59sEHJSh198aJrceXX+mk9FsgDKBM3f8AeceCWP3xtta5/vixHcb1aEWoJ32DgpTSgH6Lb8g/ntrOvntmnW1ube2zpeq7uNmWMsdl+dWEuxprnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562073; c=relaxed/simple;
	bh=b23DmUkPPVUh0RMHhNGyRZzyT51ZPU5TJeFOjzuuHA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFnHHVdquxI+rSDb9JqOKEX8zLms3Ful4sz2DXfZ9456NstV4u/QpLigeWmtpveHlyIkGQN/3Zuju0Ot+jEw/tVvsihMwZ8165sWX8bJ0HjzFpxNBnxW5B5LdvPw1OU3LVQ1NkErrDnLriB8PTewkqYONe2U8Qciv1CuXmal1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T5A5EIcS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rGm1tJ3a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T5A5EIcS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rGm1tJ3a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E39621DBF;
	Thu, 10 Oct 2024 12:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728562070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miOkYgLzd78hF3PRbfRfmms8PfuItF8zeCePsmZ6stI=;
	b=T5A5EIcSiNozLeib8tZqyP71dlnFJgh6RkT3+Hi5OlgOOZU2t7X0gRvTdCEGFMQXKQkCfE
	H4Coqn1dnmAL9D5QLQ1EHzE+JtR02QgyLShnnphz9QDfv5BwYBTSMqwX+sbZoh2oxIxeN1
	128w1/5SW/R9Q4I67UR2p6a8LrHGMJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728562070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miOkYgLzd78hF3PRbfRfmms8PfuItF8zeCePsmZ6stI=;
	b=rGm1tJ3a8pd0nIxCqJ1ZnEEPiyTGTlhErZA+lgCfuO/CN5pSIU5PgJH8ePEq5khQSwyKby
	0T3U8Ege0DemqpAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728562070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miOkYgLzd78hF3PRbfRfmms8PfuItF8zeCePsmZ6stI=;
	b=T5A5EIcSiNozLeib8tZqyP71dlnFJgh6RkT3+Hi5OlgOOZU2t7X0gRvTdCEGFMQXKQkCfE
	H4Coqn1dnmAL9D5QLQ1EHzE+JtR02QgyLShnnphz9QDfv5BwYBTSMqwX+sbZoh2oxIxeN1
	128w1/5SW/R9Q4I67UR2p6a8LrHGMJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728562070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miOkYgLzd78hF3PRbfRfmms8PfuItF8zeCePsmZ6stI=;
	b=rGm1tJ3a8pd0nIxCqJ1ZnEEPiyTGTlhErZA+lgCfuO/CN5pSIU5PgJH8ePEq5khQSwyKby
	0T3U8Ege0DemqpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 515861370C;
	Thu, 10 Oct 2024 12:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FK/UE5bDB2dNOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Oct 2024 12:07:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8DFCA08A2; Thu, 10 Oct 2024 14:07:49 +0200 (CEST)
Date: Thu, 10 Oct 2024 14:07:49 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yebin10@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 1/3] vfs: introduce shrink_icache_sb() helper
Message-ID: <20241010120749.7x5xdiodu3lwxg7j@quack3>
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
 <20241010112543.1609648-2-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010112543.1609648-2-yebin@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 10-10-24 19:25:41, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> This patch is prepare for support drop_caches for specify file system.
> shrink_icache_sb() helper walk the superblock inode LRU for freeable inodes
> and attempt to free them.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/inode.c    | 17 +++++++++++++++++
>  fs/internal.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 1939f711d2c9..2129b48571b4 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1045,6 +1045,23 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  	return freed;
>  }
>  
> +/*
> + * Walk the superblock inode LRU for freeable inodes and attempt to free them.
> + * Inodes to be freed are moved to a temporary list and then are freed outside
> + * inode_lock by dispose_list().
> + */
> +void shrink_icache_sb(struct super_block *sb)
> +{
> +	do {
> +		LIST_HEAD(dispose);
> +
> +		list_lru_walk(&sb->s_inode_lru, inode_lru_isolate,
> +			      &dispose, 1024);
> +		dispose_list(&dispose);
> +	} while (list_lru_count(&sb->s_inode_lru) > 0);
> +}
> +EXPORT_SYMBOL(shrink_icache_sb);

Hum, but this will livelock if we cannot remove all the inodes? Now I guess
inode_lru_isolate() usually removes busy inodes from the LRU so this should
not happen in practice but such behavior is not guaranteed (we can LRU_SKIP
inodes if i_lock is busy or LRU_RETRY if inode has page cache pages). So I
think we need some safety net here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

