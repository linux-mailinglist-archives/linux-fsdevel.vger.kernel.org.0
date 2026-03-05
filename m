Return-Path: <linux-fsdevel+bounces-79503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL/bLXioqWlSBwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 16:59:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B3D215095
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23DE9301E994
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF543C6A2E;
	Thu,  5 Mar 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JkhDxXPl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KsPUrOhx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wrtCN3PO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sfQacGrl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19EB30DECC
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726331; cv=none; b=jSgdDQk6WIXgnFyRFUi5iFKQOn5n5/gOH21OkatzXpUi2D4hs278IIA/wd36q82TsWIs4CbiiJQPVS2NO5jmc0HwaL8PbmUUiYFQGmLGV0rcbdjM+AaYHNccFBWdGBxgSEee5q4prStVM8O6hV5eLOqVKWOVe9d3n5fpYZNlpXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726331; c=relaxed/simple;
	bh=nQQoM+pLKRM1yoqvBEjVxRN+KT7V9jlu3ZYgBX3vTU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJBIjgElm74DNZMrGHzUX4l4Q8uXgS7dkRUHLKa66XxZ9EZBLZiHVdDZxbrdcpWQTb3xul0fA+7uMJBDz7lkVIo6+u3sjZqdHDBqFxLN+Mt4QrzgmVVms6X7uEdC3RPNoz2ZOKzas5gCZ6FVslImxA8oMx+Fc54kNWoBkrpMxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JkhDxXPl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KsPUrOhx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wrtCN3PO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sfQacGrl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9DB83F839;
	Thu,  5 Mar 2026 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772726328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJXg+vftnw5Mo5x2ZpT2g9xazC6UHz2LjL0K5+lD4wM=;
	b=JkhDxXPlgQjJmb0E2pzqpJk+LHkOYZTnOY1hzyRJ7q6s6cGnoJndBVbHPfFrBh4zgQHmkH
	08a/tBUE881S8g7p8TvuJB21fz7aIgIStdkUbtpCr/Qb6Jo3fkErL75cxLXy8q2YuPuDDu
	t2medxKN0PnV0HFATuWgmEBJplIRG0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772726328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJXg+vftnw5Mo5x2ZpT2g9xazC6UHz2LjL0K5+lD4wM=;
	b=KsPUrOhxtzKsyW0tgrmp3p/QJhaca7rZZ2nW3xXIwr3dOnsHDa3RlbuyiCxrhxMOVO/wq6
	enNiu4fOyq+cjyBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772726327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJXg+vftnw5Mo5x2ZpT2g9xazC6UHz2LjL0K5+lD4wM=;
	b=wrtCN3POPAThilnI14sAsV64KYlG2/pD/S3/5Dh3i6d80z2PpcBZQs51MWzSbKrRldd2Q0
	+UmwndBhAOUeg5kQHyxDI9pZptVHxTIoRuxf3eibQRzfICnXUnDWDHct8VqMmla3zSpzSf
	/ix3bOcU1sUfD2huBx0xELUm2R5Ebzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772726327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJXg+vftnw5Mo5x2ZpT2g9xazC6UHz2LjL0K5+lD4wM=;
	b=sfQacGrlCFPc/m/Qg1FzPsVgjbVlfWlphyvQ3s408m5HYKbVLdItQ9XGqpD3Bwy0gKcnNk
	pA16lG787FEUv8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF59C3EA68;
	Thu,  5 Mar 2026 15:58:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PAd6NjeoqWnwVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 15:58:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A1CC7A0A8D; Thu,  5 Mar 2026 16:58:39 +0100 (CET)
Date: Thu, 5 Mar 2026 16:58:39 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 21/32] bdev: Drop pointless invalidate_mapping_buffers()
 call
Message-ID: <b62rxpzd723jve3pqbjbmuzuetkebbzppelsuccdw7r2rmcblt@uea3ktei5jzw>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-53-jack@suse.cz>
 <20260304-dachboden-minibar-620c6f7d69fc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-dachboden-minibar-620c6f7d69fc@brauner>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A5B3D215095
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79503-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email,kernel.dk:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kernel.org,kvack.org,kernel.dk];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed 04-03-26 14:39:54, Christian Brauner wrote:
> On Tue, Mar 03, 2026 at 11:34:10AM +0100, Jan Kara wrote:
> > Nobody is calling mark_buffer_dirty_inode() with internal bdev inode and
> > it doesn't make sense for internal bdev inode to have any metadata
> > buffer heads. Just drop the pointless invalidate_mapping_buffers() call.
> 
> s/invalidate_mapping_buffers/invalidate_inode_buffers/g?

Thanks. Fixed.

								Honza

> 
> > 
> > CC: Jens Axboe <axboe@kernel.dk>
> > CC: linux-block@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  block/bdev.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/block/bdev.c b/block/bdev.c
> > index ed022f8c48c7..ad1660b6b324 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -420,7 +420,6 @@ static void init_once(void *data)
> >  static void bdev_evict_inode(struct inode *inode)
> >  {
> >  	truncate_inode_pages_final(&inode->i_data);
> > -	invalidate_inode_buffers(inode); /* is it needed here? */
> >  	clear_inode(inode);
> >  }
> >  
> > -- 
> > 2.51.0
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

