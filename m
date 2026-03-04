Return-Path: <linux-fsdevel+bounces-79365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GXBHt82qGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:42:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1C200993
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1009B307C48D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7B437F73A;
	Wed,  4 Mar 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YXBdusYh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G5B6X/oe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YXBdusYh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G5B6X/oe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA51DF751
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631524; cv=none; b=U4BsDL8d9aRJ0ZUPwNiDtyX5zXifcZZKLAOQQjS6T9fH5KugHB4eYKt70Xh9rrRj6hD/tlvhXKoALg7URDaNHAHg2L3RbaX/i1KAcjjFbYjc2kedYqxZcWi1T358ISbQcYRaYjUVTXGMZ3xRDpJYfdBxRpN3igBfPz8yeo3JXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631524; c=relaxed/simple;
	bh=wdRH+wfb7ll6uDSXah+gvva7AdcPM3UpjVMmb5UMFU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX47jUl1MJzjoATfsCU1CE8zTHFh758Dc/Lsq9gnCTqamR8E5HDovDhJFsZSFkzvE7lCRLEcdt1+5Te6Direb5hDwJ/7H6XHX4jSCPu6OTm0QFPV7CDNEGDBQj625z1hSTcuugwm6SSXt5xLdWT33JU0DmHaFwUsG4U5KGxjNuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YXBdusYh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G5B6X/oe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YXBdusYh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G5B6X/oe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E2915BDF8;
	Wed,  4 Mar 2026 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772631521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Htf16GFqRL+ZQDdkzons7SZg5zvlwxDcC+pn7DlQzPs=;
	b=YXBdusYhDCVl7yyvEyjdr5j5bDvYTuTVIsZP4koIeDM4IZcNQfjeTS7pp0D/C1zhTRrgO6
	JQgHUBxJJe32FzyahUwyj/Y6uNrmW4h7MFyCSUfyDWq0MaqZipaCF/5GpHWuwjGBHH8dU2
	yE1PHgGsenZXHnJj1ir3exLg7qc18z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772631521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Htf16GFqRL+ZQDdkzons7SZg5zvlwxDcC+pn7DlQzPs=;
	b=G5B6X/oeQ2T7M3AbyuuwHb+mdgYrzVfR7GKx9l7WtxMlVk+uvrAoUeqllKpnvStM1w97y9
	nFuH7oVdlBVIw8Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YXBdusYh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="G5B6X/oe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772631521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Htf16GFqRL+ZQDdkzons7SZg5zvlwxDcC+pn7DlQzPs=;
	b=YXBdusYhDCVl7yyvEyjdr5j5bDvYTuTVIsZP4koIeDM4IZcNQfjeTS7pp0D/C1zhTRrgO6
	JQgHUBxJJe32FzyahUwyj/Y6uNrmW4h7MFyCSUfyDWq0MaqZipaCF/5GpHWuwjGBHH8dU2
	yE1PHgGsenZXHnJj1ir3exLg7qc18z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772631521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Htf16GFqRL+ZQDdkzons7SZg5zvlwxDcC+pn7DlQzPs=;
	b=G5B6X/oeQ2T7M3AbyuuwHb+mdgYrzVfR7GKx9l7WtxMlVk+uvrAoUeqllKpnvStM1w97y9
	nFuH7oVdlBVIw8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 636013EA69;
	Wed,  4 Mar 2026 13:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lDo9GOE1qGmpWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Mar 2026 13:38:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1FE0FA0A1B; Wed,  4 Mar 2026 14:38:41 +0100 (CET)
Date: Wed, 4 Mar 2026 14:38:41 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	David Sterba <dsterba@suse.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-aio@kvack.org, 
	Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH 18/32] fs: Provide operation for fetching
 mapping_metadata_bhs
Message-ID: <4ji4ihp7tzhxr35t2vgnswfskrjnsuo4eys4klblnor2b663pp@x3khuzh7cxhv>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-50-jack@suse.cz>
 <aagxU5f1AI3y0wrw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aagxU5f1AI3y0wrw@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 24E1C200993
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
	TAGGED_FROM(0.00)[bounces-79365-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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

On Wed 04-03-26 05:19:15, Christoph Hellwig wrote:
> On Tue, Mar 03, 2026 at 11:34:07AM +0100, Jan Kara wrote:
> > When we move mapping_metadata_bhs to fs-private part of an inode the
> > generic code will need a way to get to this struct from general struct
> > inode. Add inode operation for this similarly to operation for grabbing
> > offset_ctx.
> 
> Do we even need this?  With your previous cleanups almost all of the
> places that need the buffers list are called more or less directly
> from the file systems.  Can we take it all the way and just pass the
> mapping_metadata_bhs to those functions?

I was looking into that. Passing these to sync_mapping_buffers(),
invalidate_inode_buffers() is easy. Passing to mark_buffer_dirty_inode() is
relatively tedious but doable. Where it gets difficult are calls like
bforget() and most importantly try_to_free_buffers() on bdev mapping where
you currently have no way to get to the mmb struct... We do have
b_assoc_map pointer in buffer_head which we could switch to point to mmb
instead but IO error handling on bhs needs to get to the mapping from bh so
we'd then have to add address_space pointer to mmb for these uses. All in
all it's doable but I've decided it isn't really worth it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

