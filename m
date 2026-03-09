Return-Path: <linux-fsdevel+bounces-79769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDKGAam8rmn6IQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 13:27:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D332238CE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 13:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DF8E301DF5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 12:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4004B3A63F0;
	Mon,  9 Mar 2026 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gWxuu0S3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Xhg4LrP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gWxuu0S3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Xhg4LrP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AAD3A7F60
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059224; cv=none; b=ULQe1L+AcI2xa8/VQvzyNO8uRyW/1Y6AVdvF25X89ZiRZy5xwSTL839vbGCpMU8fVibhBbyR8WWh2tlihEC0a/SPypEPgV7utA9BC8aNqQg5NoAVxmAhGNFxjU59W0uQF2qTflucjwqHSvLyV18STND3jWPzF1gY1ZBuM33r9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059224; c=relaxed/simple;
	bh=06bjoX2PvuM9KXpydZc39nG19eXRgSkYsoJjG+9s5R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFzJrhvRmV+uOoyk4X7WDm8qY4kUgEELiRHSu63uVyE91jxfpgN2Zz8BEy5eJDLdpAGqhzqs7CDa7luv0+i6UAi37zjld9e//HTnRpXksu3x3WCk+yilg7BVCFy85oA8Ga4E/g7E/AfZj/dbYag+gEUSAIX9uQAzdEkvrHMyuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gWxuu0S3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Xhg4LrP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gWxuu0S3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Xhg4LrP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B5945BDC1;
	Mon,  9 Mar 2026 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773059220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9N21yrEmTtdKgim7zB9SmEQiaSUFN0OQ3SFiaS92Qc=;
	b=gWxuu0S3OahP6eCmsYtlcNUxWLMTTRR5YopZLyGo0JWiVpc0dXcXuesglPMOFf+ruWeu7d
	vfYZFkvlB/EPxiXnlxENT3DUvdRZgjCuosuIio3s8L5bTOFX6EDwGWG2BWbcLMq2Rj0PmW
	EKvZ0QcpqAbW641HAKlOnwjWAgeFsyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773059220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9N21yrEmTtdKgim7zB9SmEQiaSUFN0OQ3SFiaS92Qc=;
	b=5Xhg4LrPB7DMvqxXutvlrGFu4F/DOzGFQelp+u/tqfbBTeTBH1XO3Ay0ATYxBm7Lsc6uBj
	k868bgPwL2AW/pBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gWxuu0S3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5Xhg4LrP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773059220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9N21yrEmTtdKgim7zB9SmEQiaSUFN0OQ3SFiaS92Qc=;
	b=gWxuu0S3OahP6eCmsYtlcNUxWLMTTRR5YopZLyGo0JWiVpc0dXcXuesglPMOFf+ruWeu7d
	vfYZFkvlB/EPxiXnlxENT3DUvdRZgjCuosuIio3s8L5bTOFX6EDwGWG2BWbcLMq2Rj0PmW
	EKvZ0QcpqAbW641HAKlOnwjWAgeFsyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773059220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9N21yrEmTtdKgim7zB9SmEQiaSUFN0OQ3SFiaS92Qc=;
	b=5Xhg4LrPB7DMvqxXutvlrGFu4F/DOzGFQelp+u/tqfbBTeTBH1XO3Ay0ATYxBm7Lsc6uBj
	k868bgPwL2AW/pBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 811193EECB;
	Mon,  9 Mar 2026 12:27:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hgt1H5S8rmkXRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Mar 2026 12:27:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 374F0A09A4; Mon,  9 Mar 2026 13:27:00 +0100 (CET)
Date: Mon, 9 Mar 2026 13:27:00 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: remove externs from fs.h on functions modified
 by i_ino widening
Message-ID: <wlwvnfrhpw4yyzdnxte73nv6rs5lh2jilvnfd2mtocyct4jyel@4l4km3lehq2c>
References: <20260307-iino-u64-v2-1-a1a1696e0653@kernel.org>
 <urwtj2zfmxfhksormxkzb2z26a7nt5vesbkuwtow47fflf4u2l@x7cbae5dv7tr>
 <c73452245cd85a75bbfc12b31b940641352fb979.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c73452245cd85a75bbfc12b31b940641352fb979.camel@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 9D332238CE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-79769-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.936];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 09-03-26 07:53:51, Jeff Layton wrote:
> On Mon, 2026-03-09 at 11:02 +0100, Jan Kara wrote:
> > On Sat 07-03-26 14:54:31, Jeff Layton wrote:
> > > Christoph says, in response to one of the patches in the i_ino widening
> > > series, which changes the prototype of several functions in fs.h:
> > > 
> > >     "Can you please drop all these pointless externs while you're at it?"
> > > 
> > > Remove extern keyword from functions touched by that patch (and a few
> > > that happened to be nearby). Also add missing argument names to
> > > declarations that lacked them.
> > > 
> > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ...
> > > -extern void inode_init_once(struct inode *);
> > > -extern void address_space_init_once(struct address_space *mapping);
> > > -extern struct inode * igrab(struct inode *);
> > > -extern ino_t iunique(struct super_block *, ino_t);
> > > -extern int inode_needs_sync(struct inode *inode);
> > > -extern int inode_just_drop(struct inode *inode);
> > > +void inode_init_once(struct inode *inode);
> > > +void address_space_init_once(struct address_space *mapping);
> > > +struct inode *igrab(struct inode *inode);
> > > +ino_t iunique(struct super_block *sb, ino_t max_reserved);
> > 
> > I've just noticed that we probably forgot to convert iunique() to use u64
> > for inode numbers... Although the iunique() number allocator might prefer
> > to stay within 32 bits, the interfaces should IMO still use u64 for
> > consistency.
> > 
> 
> I went back and forth on that one, but I left iunique() changes off
> since they weren't strictly required. Most filesystems that use it
> won't have more than 2^32 inodes anyway.
> 
> If they worked before with iunique() limited to 32-bit values, they
> should still after this. After the i_ino widening we could certainly
> change it to return a u64 though.

Yes, it won't change anything wrt functionality. I just think that if we go
for "ino_t is the userspace API type and kernel-internal inode numbers
(i.e.  what gets stored in inode->i_ino) are passed as u64", then this
place should logically have u64...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

