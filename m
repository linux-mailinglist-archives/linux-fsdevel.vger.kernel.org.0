Return-Path: <linux-fsdevel+bounces-79510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLZVJIKyqWkZCwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:42:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8650215863
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12219303989F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB253C6A59;
	Thu,  5 Mar 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jGUo2hFU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BL+0lglh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jGUo2hFU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BL+0lglh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74C3D34BC
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728950; cv=none; b=hD6tc76L7Aw8k4tw+owa/8IarLvT7MCaAiqbwZVKrwLOdR1RXim1wkQgYh4SLn1fsi7wQljsgUA1mq6smf2XSyW88MFvBdOtJai/9HUdcKA7tRUuZtbQetJdt9zSlQ6UORDljgQHOjCusijGfr39F5EJRHH7qH2yFsRve1PAE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728950; c=relaxed/simple;
	bh=ANkgvc8lf4yFtN8MXK8KRdQcBG4rQJdQjXbNAKQnIuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPWhx1vcz4XfGO5cXYjwGKxvIGIeSiaQVhGapPE4gDHzmXgwzkXSegQslKOrtf4jqFmfUEVbUErEvpGwZkqVYKYgYIraohZXMRW/F1q/MGu37U3k6AZB8PaA6IxjdihAOb13jbQHRFt2Jg3lSaqg+P2/UJUnRsdv/1dT5PXxXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jGUo2hFU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BL+0lglh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jGUo2hFU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BL+0lglh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 988553E700;
	Thu,  5 Mar 2026 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772728946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB9x8XN+Y+qd6tYArq0nO9pyPGgcxxO2MoQ2Szi1vEw=;
	b=jGUo2hFUI8OmozNrFFkgC3iFPeYfTnB7NnJosv2txPSzBCHDo7yShBYMkbyjjQKK65Lw8m
	nWKUtgTqcLAYrBhBrU3N0y9qupZj79fK4f+a/jv4WzuLo9r++aVRQyoU2okvmCx+DT4i2n
	gclejavcsWz4tQ2xMMidFy3fTUC0YWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772728946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB9x8XN+Y+qd6tYArq0nO9pyPGgcxxO2MoQ2Szi1vEw=;
	b=BL+0lglhRwEZwDaevlbFSFxI04tbXmtWnzkMwU3TKDoGGdpCdlBOEUKqxIAggT0ns2Z2mP
	pLE3YJ5XCcQUGCDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772728946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB9x8XN+Y+qd6tYArq0nO9pyPGgcxxO2MoQ2Szi1vEw=;
	b=jGUo2hFUI8OmozNrFFkgC3iFPeYfTnB7NnJosv2txPSzBCHDo7yShBYMkbyjjQKK65Lw8m
	nWKUtgTqcLAYrBhBrU3N0y9qupZj79fK4f+a/jv4WzuLo9r++aVRQyoU2okvmCx+DT4i2n
	gclejavcsWz4tQ2xMMidFy3fTUC0YWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772728946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB9x8XN+Y+qd6tYArq0nO9pyPGgcxxO2MoQ2Szi1vEw=;
	b=BL+0lglhRwEZwDaevlbFSFxI04tbXmtWnzkMwU3TKDoGGdpCdlBOEUKqxIAggT0ns2Z2mP
	pLE3YJ5XCcQUGCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B5723EA68;
	Thu,  5 Mar 2026 16:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oo3+IXKyqWm5AwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 16:42:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 426C5A0A8D; Thu,  5 Mar 2026 17:42:26 +0100 (CET)
Date: Thu, 5 Mar 2026 17:42:26 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	David Sterba <dsterba@suse.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-aio@kvack.org, 
	Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH 17/32] fs: Move metadata bhs tracking to a separate struct
Message-ID: <2humtq6dr6dsoovz63xqwql5wk7ntoz4xtwlyohavl3vym4xxs@l3rivwrbxmy7>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-49-jack@suse.cz>
 <aag1vDoCVwAlIKPq@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aag1vDoCVwAlIKPq@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Queue-Id: E8650215863
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79510-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed 04-03-26 05:38:04, Christoph Hellwig wrote:
> Maybe just call the structure buffer_head_list at it really just is a
> totall generic list of buffer heads with a lock?

Well, since we'll be adding pointer to address_space there and eventually I
need to add a pointer to the buffer_head containing the inode to fix a bug
that fsync(2) now doesn't properly persist the inode metadata for all these
filesystems (but I didn't want to clutter this series with that fix), I
think a special name is warranted.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

