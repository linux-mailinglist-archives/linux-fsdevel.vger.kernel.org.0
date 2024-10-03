Return-Path: <linux-fsdevel+bounces-30871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF4198EF9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A01C212B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42241187328;
	Thu,  3 Oct 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S2pbBl2f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="73ruBQXY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S2pbBl2f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="73ruBQXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0F1E49B;
	Thu,  3 Oct 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959584; cv=none; b=cmpyNGyE11nJBMxOvdEPIPzEMBJ9StXKIwbV7mI6oqax/R2JnkBH8LD7svGhunSXhdM95e6BUrfxR7BSc2JczyRWGr9301ohfw6rFlIufxuBq5L7VhBWiYPOXZFtgO5VJyVBrDku+FIbKKEvHsDWZ/JJZjmk9OhdMLaObAtK5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959584; c=relaxed/simple;
	bh=diNN3+BTex0PZzvfNw6DP2nN8r5isx0QAbixk2TVPjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A41wKqSl8VcLA6zDyIRFaZG1RWS8tSbtzKoc/g3VIOZfB6Bq8xY2EWQP45gNrJVm3e6WFdguof/TmFtUv6h5KpENNQZNOt2TZI7I38BExoCGWRPPtJb/HrdOe/fZ2lb/V9PG1dgNHD555OmKr3/QYYRHHa8ijcPPPqlZK9LJhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S2pbBl2f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=73ruBQXY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S2pbBl2f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=73ruBQXY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49C721FBB9;
	Thu,  3 Oct 2024 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727959580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3jkwMlW4Nzu9ZOQ1CrOnsF8aordmiDmFPu97oWZxp4=;
	b=S2pbBl2fwCE3ouKitZ+yIr33Bn6iJtMogB+ehHYN6zKXbzRZBQaKiLiZORhM/juwbtJN2y
	gRy6jjJA+MpuAzBz20/WPxaf30Qy2FKXJcydQVoGfMFnjBx7V2ZnApeED5JQtJ3dRr4vTX
	Rsa59yG7poNk9F0T3acFARvC2KPTcpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727959580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3jkwMlW4Nzu9ZOQ1CrOnsF8aordmiDmFPu97oWZxp4=;
	b=73ruBQXYYTucM3oUn1lk8UfvQyK/ChocKJVSDmWgNNTJjbENalxCyMx4HQglKaAVbM9bOJ
	sa2ENYHSOcZ2QUBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=S2pbBl2f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=73ruBQXY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727959580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3jkwMlW4Nzu9ZOQ1CrOnsF8aordmiDmFPu97oWZxp4=;
	b=S2pbBl2fwCE3ouKitZ+yIr33Bn6iJtMogB+ehHYN6zKXbzRZBQaKiLiZORhM/juwbtJN2y
	gRy6jjJA+MpuAzBz20/WPxaf30Qy2FKXJcydQVoGfMFnjBx7V2ZnApeED5JQtJ3dRr4vTX
	Rsa59yG7poNk9F0T3acFARvC2KPTcpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727959580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3jkwMlW4Nzu9ZOQ1CrOnsF8aordmiDmFPu97oWZxp4=;
	b=73ruBQXYYTucM3oUn1lk8UfvQyK/ChocKJVSDmWgNNTJjbENalxCyMx4HQglKaAVbM9bOJ
	sa2ENYHSOcZ2QUBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D8B813882;
	Thu,  3 Oct 2024 12:46:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N3HQChyS/maHLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 12:46:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CA600A086F; Thu,  3 Oct 2024 14:46:19 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:46:19 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <20241003124619.wfgozqj4yoyl4xbu@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241003114555.bl34fkqsja4s5tok@quack3>
 <Zv6Llgzj7_Se1m7H@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6Llgzj7_Se1m7H@infradead.org>
X-Rspamd-Queue-Id: 49C721FBB9
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 03-10-24 05:18:30, Christoph Hellwig wrote:
> On Thu, Oct 03, 2024 at 01:45:55PM +0200, Jan Kara wrote:
> > /* Find next inode on the inode list eligible for processing */
> > #define sb_inode_iter_next(sb, inode, old_inode, inode_eligible) 	\
> > ({									\
> > 	struct inode *ret = NULL;					\
> 
> <snip>
> 
> > 	ret;								\
> > })
> 
> How is this going to interact with calling into the file system
> to do the interaction, which is kinda the point of this series?

Yeah, I was concentrated on the VFS bits and forgot why Dave wrote this
series in the first place. So this style of iterator isn't useful for what
Dave wants to achieve. Sorry for the noise. Still the possibility to have a
callback under inode->i_lock being able to do stuff and decide whether we
should grab a reference or continue would be useful (and would allow us to
combine the three iterations on unmount into one without too much hassle).

> > #define for_each_sb_inode(sb, inode, inode_eligible)			\
> > 	for (DEFINE_FREE(old_inode, struct inode *, if (_T) iput(_T)),	\
> > 	     inode = NULL;						\
> > 	     inode = sb_inode_iter_next((sb), inode, &old_inode,	\
> > 					 inode_eligible);		\
> > 	    )
> 
> And while I liked:
> 
> 	obj = NULL;
> 
> 	while ((obj = get_next_object(foo, obj))) {
> 	}
> 
> style iterators, magic for_each macros that do magic cleanup are just
> a nightmare to read.  Keep it simple and optimize for someone actually
> having to read and understand the code, and not for saving a few lines
> of code.

Well, I agree the above is hard to read but I don't know how to write it in
a more readable way while keeping the properties of the iterator (like
auto-cleanup when you break out of the loop - which is IMO a must for a
sane iterator). Anyway, this is now mostly academic since I agree this
iterator isn't really useful for the situation here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

