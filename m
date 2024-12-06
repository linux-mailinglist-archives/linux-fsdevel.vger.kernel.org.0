Return-Path: <linux-fsdevel+bounces-36653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E6E9E75D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D11A188B100
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01120E6E1;
	Fri,  6 Dec 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gdin9ueQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PHEDuXuL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gdin9ueQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PHEDuXuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBD20E33F;
	Fri,  6 Dec 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502075; cv=none; b=Cdzgu5WkVOIPS+mbwQNP2fIWRICHFi6jJgbqTdKYoLldLP3EeobhboXcjvAG/J1xQOl/6d4LWPM+ToguWZYtfkQKX5MA443xngeczQk4NGw9EqAwWwIsbsgjZr3puQ9sYhcwnSRzKgfHx4C7fMiKfbe51vJ8FPYY++O22Ae1bNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502075; c=relaxed/simple;
	bh=ac4pgcLjtxPRBQcq/XNT/VonCW8Bc+VLmRkWv+2y7C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQhX4NI0PB72Clzu4XK7qS6BWY2NlldH0r6e1dXGIM49OTQbgK/Iqcdz/Qpc07e44gy6ZUHL41xh3mgP/NTjLpe5ZUpCvfcGaNGJyyfn+h5tsUQuQ9UkI/wh1D2QI6yRXTtOV3GU7IF0E40TCy+p5QYNwHaBWkYF+3wjeY1qDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gdin9ueQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PHEDuXuL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gdin9ueQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PHEDuXuL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C740721151;
	Fri,  6 Dec 2024 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733502071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S3hzM6cCpaVd6QqTH/MfEYNophFjHylvkgtDiG7Kv2s=;
	b=Gdin9ueQ6Ip3/+5Yi0YrcbzUjHk0tA6o/FTam9lpBH8wdOJvXUxR3XKOsy1rLmjMAkd34G
	6lm1xiGXABUg44MpHB4A6NKmCHUCrX5dnOg2ij2h3tMiP7FiV0wpgDQCgjgxddQTNIeM4K
	e+57pxbz5yS0SkDLJmCZRExcdIUkzF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733502071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S3hzM6cCpaVd6QqTH/MfEYNophFjHylvkgtDiG7Kv2s=;
	b=PHEDuXuL2rODIjvYMfk/az+g55ImIx/wQ7m445IrxyrOgEVV+99IHx0BGQsFnji21jRIIt
	ZLWgWxvt6WxXBxDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733502071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S3hzM6cCpaVd6QqTH/MfEYNophFjHylvkgtDiG7Kv2s=;
	b=Gdin9ueQ6Ip3/+5Yi0YrcbzUjHk0tA6o/FTam9lpBH8wdOJvXUxR3XKOsy1rLmjMAkd34G
	6lm1xiGXABUg44MpHB4A6NKmCHUCrX5dnOg2ij2h3tMiP7FiV0wpgDQCgjgxddQTNIeM4K
	e+57pxbz5yS0SkDLJmCZRExcdIUkzF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733502071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S3hzM6cCpaVd6QqTH/MfEYNophFjHylvkgtDiG7Kv2s=;
	b=PHEDuXuL2rODIjvYMfk/az+g55ImIx/wQ7m445IrxyrOgEVV+99IHx0BGQsFnji21jRIIt
	ZLWgWxvt6WxXBxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A46B8138A7;
	Fri,  6 Dec 2024 16:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H7keKHckU2eICwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Dec 2024 16:21:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79EB7A08CD; Fri,  6 Dec 2024 17:21:02 +0100 (CET)
Date: Fri, 6 Dec 2024 17:21:02 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 12/27] ext4: introduce seq counter for the extent status
 entry
Message-ID: <20241206162102.w4hw35ims5sdf4ik@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-13-yi.zhang@huaweicloud.com>
 <20241204124221.aix7qxjl2n4ya3b7@quack3>
 <c831732e-38c5-4a82-ab30-de17cff29584@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c831732e-38c5-4a82-ab30-de17cff29584@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 06-12-24 16:55:01, Zhang Yi wrote:
> On 2024/12/4 20:42, Jan Kara wrote:
> > On Tue 22-10-24 19:10:43, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> In the iomap_write_iter(), the iomap buffered write frame does not hold
> >> any locks between querying the inode extent mapping info and performing
> >> page cache writes. As a result, the extent mapping can be changed due to
> >> concurrent I/O in flight. Similarly, in the iomap_writepage_map(), the
> >> write-back process faces a similar problem: concurrent changes can
> >> invalidate the extent mapping before the I/O is submitted.
> >>
> >> Therefore, both of these processes must recheck the mapping info after
> >> acquiring the folio lock. To address this, similar to XFS, we propose
> >> introducing an extent sequence number to serve as a validity cookie for
> >> the extent. We will increment this number whenever the extent status
> >> tree changes, thereby preparing for the buffered write iomap conversion.
> >> Besides, it also changes the trace code style to make checkpatch.pl
> >> happy.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Overall using some sequence counter makes sense.
> > 
> >> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> >> index c786691dabd3..bea4f87db502 100644
> >> --- a/fs/ext4/extents_status.c
> >> +++ b/fs/ext4/extents_status.c
> >> @@ -204,6 +204,13 @@ static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
> >>  	return es->es_lblk + es->es_len - 1;
> >>  }
> >>  
> >> +static inline void ext4_es_inc_seq(struct inode *inode)
> >> +{
> >> +	struct ext4_inode_info *ei = EXT4_I(inode);
> >> +
> >> +	WRITE_ONCE(ei->i_es_seq, READ_ONCE(ei->i_es_seq) + 1);
> >> +}
> > 
> > This looks potentially dangerous because we can loose i_es_seq updates this
> > way. Like
> > 
> > CPU1					CPU2
> > x = READ_ONCE(ei->i_es_seq)
> > 					x = READ_ONCE(ei->i_es_seq)
> > 					WRITE_ONCE(ei->i_es_seq, x + 1)
> > 					...
> > 					potentially many times
> > WRITE_ONCE(ei->i_es_seq, x + 1)
> >   -> the counter goes back leading to possibly false equality checks
> > 
> 
> In my current implementation, I don't think this race condition can
> happen since all ext4_es_inc_seq() invocations are under
> EXT4_I(inode)->i_es_lock. So I think it works fine now, or was I
> missed something?

Hum, as far as I've checked, at least the place in ext4_es_insert_extent()
where you call ext4_es_inc_seq() doesn't hold i_es_lock (yet). If you meant
to protect the updates by i_es_lock, then move the call sites and please
add a comment about it. Also it should be enough to do:

WRITE_ONCE(ei->i_es_seq, ei->i_es_seq + 1);

since we cannot be really racing with other writers.

> > I think you'll need to use atomic_t and appropriate functions here.
> > 
> >> @@ -872,6 +879,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
> >>  	BUG_ON(end < lblk);
> >>  	WARN_ON_ONCE(status & EXTENT_STATUS_DELAYED);
> >>  
> >> +	ext4_es_inc_seq(inode);
> > 
> > I'm somewhat wondering: Are extent status tree modifications the right
> > place to advance the sequence counter? The counter needs to advance
> > whenever the mapping information changes. This means that we'd be
> > needlessly advancing the counter (and thus possibly forcing retries) when
> > we are just adding new information from ordinary extent tree into cache.
> > Also someone can be doing extent tree manipulations without touching extent
> > status tree (if the information was already pruned from there). 
> 
> Sorry, I don't quite understand here. IIUC, we can't modify the extent
> tree without also touching extent status tree; otherwise, the extent
> status tree will become stale, potentially leading to undesirable and
> unexpected outcomes later on, as the extent lookup paths rely on and
> always trust the status tree. If this situation happens, would it be
> considered a bug? Additionally, I have checked the code but didn't find
> any concrete cases where this could happen. Was I overlooked something?

What I'm worried about is that this seems a bit fragile because e.g. in
ext4_collapse_range() we do:

ext4_es_remove_extent(inode, start, EXT_MAX_BLOCKS - start)
<now go and manipulate the extent tree>

So if somebody managed to sneak in between ext4_es_remove_extent() and
the extent tree manipulation, he could get a block mapping which is shortly
after invalidated by the extent tree changes. And as I'm checking now,
writeback code *can* sneak in there because during extent tree
manipulations we call ext4_datasem_ensure_credits() which can drop
i_data_sem to restart a transaction.

Now we do writeout & invalidate page cache before we start to do these
extent tree dances so I don't see how this could lead to *actual* use
after free issues but it makes me somewhat nervous. So that's why I'd like
to have some clear rules from which it is obvious that the counter makes
sure we do not use stale mappings.

> > So I think
> > needs some very good documentation what are the expectations from the
> > sequence counter and explanations why they are satisfied so that we don't
> > break this in the future.
> 
> Yeah, it's a good suggestion, where do you suggest putting this
> documentation, how about in the front of extents_status.c?

I think at the function incrementing the counter would be fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

