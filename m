Return-Path: <linux-fsdevel+bounces-36435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E729E3A28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05911286256
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2BF1B87CE;
	Wed,  4 Dec 2024 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k+DknTTz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7A0CIIJp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PZxhj7+w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xZgndtK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C01AA1DF;
	Wed,  4 Dec 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316151; cv=none; b=fPo+jaqUja/j5izpEeq/EzqBxFmAxlCGYu8kZP2lfn10pY4RON+zJ45GxW+hdajrFROwCnQ9CwVBGKMhrm6y3lNxcLoXARDd1mm6W0+XpqPsfzjTZgxj+7c53QNMllzfkRwx5jHjYQoRMPvtIUmVGfXDj8qXN/3CrS5Gmp+b6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316151; c=relaxed/simple;
	bh=LYBJwVUXpOaEEyMNfJ4n9WMpNehDHZThlwaTV5210wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL03Ivnlc6vsD5yItdC7PfkbXUB7KtvPDiFlO4SIKY0xFlMWd8lFyrkoXMxW3FGZGThH9m2ffXJrO/q+UVZxn0+iklI+nNku6TAdmUsO6fA/UD2EpvwMTgMEdSMyTedc634me9XmGlUvSf230KYHlHnlLLptEIiZh+L6O1FD4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k+DknTTz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7A0CIIJp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PZxhj7+w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xZgndtK8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E04521F365;
	Wed,  4 Dec 2024 12:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733316142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kftMZSeF24IaWBZLj8nw9t8dG+WWN+bQMGIcgfZY+2Q=;
	b=k+DknTTzHoZFasX5fqFtAYqYyRJXn2G1xVZKCROZZW+q+236hpYC8VMysfgRvJYUvFI65z
	sGm0ffMXziAH70O6yKSkCL8JnU7j/xwbAYVdzZJbW59jJvdXLtB1mhw/fRNuN5S0a9GYor
	7g0RImu/mAaG1WUIHBUF69XHgiM4duA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733316142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kftMZSeF24IaWBZLj8nw9t8dG+WWN+bQMGIcgfZY+2Q=;
	b=7A0CIIJp3zXDOgMXJIODQVfyN4i3xYPtNxdD/+O1wSx1J/i+sCWl3Q8GH3TT4A8CsrKOZd
	A1yFtvxmObsTQtBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PZxhj7+w;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xZgndtK8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733316141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kftMZSeF24IaWBZLj8nw9t8dG+WWN+bQMGIcgfZY+2Q=;
	b=PZxhj7+w2AMHFzzVwXU+nIfb2mVQs6Xp+AXflCLDHZd19TUK4o9i7vFTvg+s+K8Dlu/spr
	0ssaF30qtxBu2QJPGql9PFcV7wbr0+3xfbGND953XmhnEEwNqEcotz6ymXEjuvk7HZsr24
	PrxRNtRs+8qat5eI7sLQUHOkYd2IS1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733316141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kftMZSeF24IaWBZLj8nw9t8dG+WWN+bQMGIcgfZY+2Q=;
	b=xZgndtK8EZm6Vv+Gb67JcJk5C6KPMxgeW7tCbTbZpi5chNrCDUakKtz2e9f65Jii+Ciapf
	4GmBbaLPFSdniNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4CAA1396E;
	Wed,  4 Dec 2024 12:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id odADMC1OUGcoKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 12:42:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7B509A0918; Wed,  4 Dec 2024 13:42:21 +0100 (CET)
Date: Wed, 4 Dec 2024 13:42:21 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 12/27] ext4: introduce seq counter for the extent status
 entry
Message-ID: <20241204124221.aix7qxjl2n4ya3b7@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-13-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-13-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: E04521F365
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 22-10-24 19:10:43, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In the iomap_write_iter(), the iomap buffered write frame does not hold
> any locks between querying the inode extent mapping info and performing
> page cache writes. As a result, the extent mapping can be changed due to
> concurrent I/O in flight. Similarly, in the iomap_writepage_map(), the
> write-back process faces a similar problem: concurrent changes can
> invalidate the extent mapping before the I/O is submitted.
> 
> Therefore, both of these processes must recheck the mapping info after
> acquiring the folio lock. To address this, similar to XFS, we propose
> introducing an extent sequence number to serve as a validity cookie for
> the extent. We will increment this number whenever the extent status
> tree changes, thereby preparing for the buffered write iomap conversion.
> Besides, it also changes the trace code style to make checkpatch.pl
> happy.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Overall using some sequence counter makes sense.

> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index c786691dabd3..bea4f87db502 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -204,6 +204,13 @@ static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
>  	return es->es_lblk + es->es_len - 1;
>  }
>  
> +static inline void ext4_es_inc_seq(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	WRITE_ONCE(ei->i_es_seq, READ_ONCE(ei->i_es_seq) + 1);
> +}

This looks potentially dangerous because we can loose i_es_seq updates this
way. Like

CPU1					CPU2
x = READ_ONCE(ei->i_es_seq)
					x = READ_ONCE(ei->i_es_seq)
					WRITE_ONCE(ei->i_es_seq, x + 1)
					...
					potentially many times
WRITE_ONCE(ei->i_es_seq, x + 1)
  -> the counter goes back leading to possibly false equality checks

I think you'll need to use atomic_t and appropriate functions here.

> @@ -872,6 +879,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	BUG_ON(end < lblk);
>  	WARN_ON_ONCE(status & EXTENT_STATUS_DELAYED);
>  
> +	ext4_es_inc_seq(inode);

I'm somewhat wondering: Are extent status tree modifications the right
place to advance the sequence counter? The counter needs to advance
whenever the mapping information changes. This means that we'd be
needlessly advancing the counter (and thus possibly forcing retries) when
we are just adding new information from ordinary extent tree into cache.
Also someone can be doing extent tree manipulations without touching extent
status tree (if the information was already pruned from there). So I think
needs some very good documentation what are the expectations from the
sequence counter and explanations why they are satisfied so that we don't
break this in the future.

								Honza
 

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

