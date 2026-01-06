Return-Path: <linux-fsdevel+bounces-72464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D5BCF7929
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 10:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 992D830CCF09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F62DCC1F;
	Tue,  6 Jan 2026 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cf+rn6jm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B7fPsCqp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cf+rn6jm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B7fPsCqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70AC2D94B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692046; cv=none; b=odPK89TOJZxMpqUWqCQOFHgiVIihAD6V/P7jUn7kwqKDJr01Ea37Y1tfuVc1KK0nu6zfG29xjJR9hpSJu6k4LJJS9+dmh6Vc+15NnimzPVio9+mbZDrW/VpUKDC2mXyZrf5IIdTPoBXUFuF1msrYW9RMFdxcHvY6mxS9dW2xG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692046; c=relaxed/simple;
	bh=x22C9kRJ8QdKHuC3iS4kgz2ZCrh3YxlscR29pVosQCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjMaekS9ME4QWiQIoL8ExkHmGDgiIjmQwUUYwGeR8kc6MSAEhTR2R1T0iUDxIHZl7wUxy6N+VQVd8ubx9qdKdtS5DcP6BOryb91Fj+jNYXTI9qtORN2pIIISXshnpxpZm0psB/wFN9rk4m0l56SFOyjiBX4O+RreoP5f6A9kPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cf+rn6jm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B7fPsCqp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cf+rn6jm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B7fPsCqp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A71EA339D0;
	Tue,  6 Jan 2026 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767692041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lD+gb9iTwtAOL0+AaRfPVu6+0szSFg5PvynsVOPibio=;
	b=Cf+rn6jmcX1v54zQheY+lMcF2mDy52EZG8pxdJNAgv3Sty7rG6uOyfZH87D7kwM/k3uYed
	PMKnfzXhO2fEVVujHEr51L9H7fIKgAkdaTCkRh3aLvQgM/rw2xFJOGnEUkMvyJYcpj+eY5
	8ntv+S3ziU8MrsupBMynI7igz1+oH+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767692041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lD+gb9iTwtAOL0+AaRfPVu6+0szSFg5PvynsVOPibio=;
	b=B7fPsCqpcP3/aj1MkEzq4rt0LvLey0WxaVyG6EXbTwzmpxh2CVUnDs6k001S1FozzVWju0
	9AMdTMS4ZsmCmUAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Cf+rn6jm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B7fPsCqp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767692041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lD+gb9iTwtAOL0+AaRfPVu6+0szSFg5PvynsVOPibio=;
	b=Cf+rn6jmcX1v54zQheY+lMcF2mDy52EZG8pxdJNAgv3Sty7rG6uOyfZH87D7kwM/k3uYed
	PMKnfzXhO2fEVVujHEr51L9H7fIKgAkdaTCkRh3aLvQgM/rw2xFJOGnEUkMvyJYcpj+eY5
	8ntv+S3ziU8MrsupBMynI7igz1+oH+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767692041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lD+gb9iTwtAOL0+AaRfPVu6+0szSFg5PvynsVOPibio=;
	b=B7fPsCqpcP3/aj1MkEzq4rt0LvLey0WxaVyG6EXbTwzmpxh2CVUnDs6k001S1FozzVWju0
	9AMdTMS4ZsmCmUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DD613EA63;
	Tue,  6 Jan 2026 09:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YxCHJgnXXGkxbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 09:34:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5EE5FA08E3; Tue,  6 Jan 2026 10:33:46 +0100 (CET)
Date: Tue, 6 Jan 2026 10:33:46 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, miklos@szeredi.hu, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
Message-ID: <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251215030043.1431306-2-joannelkoong@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: A71EA339D0
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
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net,protonmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,szeredi.hu,kvack.org,protonmail.com,gmx.net,debian.org,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

[Thanks to Andrew for CCing me on patch commit]

On Sun 14-12-25 19:00:43, Joanne Koong wrote:
> Skip waiting on writeback for inodes that belong to mappings that do not
> have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
> mapping flag).
> 
> This restores fuse back to prior behavior where syncs are no-ops. This
> is needed because otherwise, if a system is running a faulty fuse
> server that does not reply to issued write requests, this will cause
> wait_sb_inodes() to wait forever.
> 
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> Reported-by: J. Neuschäfer <j.neuschaefer@gmx.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

OK, but the difference 0c58a97f919c introduced goes much further than just
wait_sb_inodes(). Before 0c58a97f919c also filemap_fdatawait() (and all the
other variants waiting for folio_writeback() to clear) returned immediately
because folio writeback was done as soon as we've copied the content into
the temporary page. Now they will block waiting for the server to finish
the IO. So e.g. fsync() will block waiting for the server in
file_write_and_wait_range() now, instead of blocking in fuse_fsync_common()
-> fuse_simple_request(). Similarly e.g. truncate(2) will now block waiting
for the server so that folio_writeback can be cleared.

So I understand your patch fixes the regression with suspend blocking but I
don't have a high confidence we are not just starting a whack-a-mole game
catching all the places that previously hiddenly depended on
folio_writeback getting cleared without any involvement of untrusted fuse
server and now this changed. So do we have some higher-level idea what is /
is not guaranteed with stuck fuse server?

								Honza

> ---
>  fs/fs-writeback.c       |  3 ++-
>  fs/fuse/file.c          |  4 +++-
>  include/linux/pagemap.h | 11 +++++++++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 6800886c4d10..ab2e279ed3c2 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *sb)
>  		 * do not have the mapping lock. Skip it here, wb completion
>  		 * will remove it.
>  		 */
> -		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> +		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> +		    mapping_no_data_integrity(mapping))
>  			continue;
>  
>  		spin_unlock_irq(&sb->s_inode_wblist_lock);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..3b2a171e652f 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3200,8 +3200,10 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
>  
>  	inode->i_fop = &fuse_file_operations;
>  	inode->i_data.a_ops = &fuse_file_aops;
> -	if (fc->writeback_cache)
> +	if (fc->writeback_cache) {
>  		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
> +		mapping_set_no_data_integrity(&inode->i_data);
> +	}
>  
>  	INIT_LIST_HEAD(&fi->write_files);
>  	INIT_LIST_HEAD(&fi->queued_writes);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 31a848485ad9..ec442af3f886 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>  	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
>  	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
>  				   account usage to user cgroups */
> +	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
>  	/* Bits 16-25 are used for FOLIO_ORDER */
>  	AS_FOLIO_ORDER_BITS = 5,
>  	AS_FOLIO_ORDER_MIN = 16,
> @@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
>  	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>  }
>  
> +static inline void mapping_set_no_data_integrity(struct address_space *mapping)
> +{
> +	set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> +}
> +
> +static inline bool mapping_no_data_integrity(const struct address_space *mapping)
> +{
> +	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
>  {
>  	return mapping->gfp_mask;
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

