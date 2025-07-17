Return-Path: <linux-fsdevel+bounces-55259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D93B08DA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265525619EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913A2D4B7E;
	Thu, 17 Jul 2025 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QE96Zpia";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/cbGAj+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QE96Zpia";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/cbGAj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524A2BEC28
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757025; cv=none; b=oL+vuPVfnGi/MDy779l0q1Q6IA8d68aShYwXVUEg0jV2kyx8C+Xe1NYlmbgDS3GIF34s0PDonYl/mnU+T5CRUCYCT97yLBz3J+9l1D1uCB2Tdux60oWmMOaiSfMC4XuKpE6S3L/kS0/fmAIdp5W1NRUmmXJ7unpDWwqWKxjJAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757025; c=relaxed/simple;
	bh=HCgJDY111WNDMGYYtRDds+6fMFnjrrKDEbxOrxF0goo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUicWoJFh5sArkpzl02sikiLFFSpTMt20NRNkiNCG92YOXNlLS5tHiCfL3JjWtFepzYy9LCvlEY30lTvC7hT6FNwP47XE33ZX5GN2Uczuv2OWZ9cpDqBgfhBMKiXOGvdBlVWWYPmtQjocNML9AOy+PPeelDk6B0hRBMk9ZCqWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QE96Zpia; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/cbGAj+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QE96Zpia; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/cbGAj+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 754AE1F7E8;
	Thu, 17 Jul 2025 12:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752757022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hr8vdaO+uQO3us5ByS989Kf8UCSfW017aFQgYDrzh/w=;
	b=QE96ZpiaozFKqxjj4L5tnloimvYCJOHEpTXiK/Ig1Y5x1lDCF/Oc809mu+r+VuOymtwRZE
	YOhwQJvx4+mVUn9BVip5b7Qb1PsGl1eX8qddb+NhVLsUpg3NurL1UG0KMErjxNLJj1qL/U
	6oEXGVnsX4/ooUy69fIN41EhrpQpLQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752757022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hr8vdaO+uQO3us5ByS989Kf8UCSfW017aFQgYDrzh/w=;
	b=V/cbGAj++QoEtz1j1LLiXvZO+W997qI5HCB16eGh9l/p4p534U01iRWQeHLclhZCTLKire
	128kMeIMurwfyIDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752757022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hr8vdaO+uQO3us5ByS989Kf8UCSfW017aFQgYDrzh/w=;
	b=QE96ZpiaozFKqxjj4L5tnloimvYCJOHEpTXiK/Ig1Y5x1lDCF/Oc809mu+r+VuOymtwRZE
	YOhwQJvx4+mVUn9BVip5b7Qb1PsGl1eX8qddb+NhVLsUpg3NurL1UG0KMErjxNLJj1qL/U
	6oEXGVnsX4/ooUy69fIN41EhrpQpLQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752757022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hr8vdaO+uQO3us5ByS989Kf8UCSfW017aFQgYDrzh/w=;
	b=V/cbGAj++QoEtz1j1LLiXvZO+W997qI5HCB16eGh9l/p4p534U01iRWQeHLclhZCTLKire
	128kMeIMurwfyIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A37A1392A;
	Thu, 17 Jul 2025 12:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MS/lGR7zeGgsFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 17 Jul 2025 12:57:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14DA1A0993; Thu, 17 Jul 2025 14:57:02 +0200 (CEST)
Date: Thu, 17 Jul 2025 14:57:02 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <q4uhf6gprnmhbinn7z6bxpjmdgjod5o7utij7hmn6hcvagmyzj@v5nhnkgrwfm5>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250716112149.GA29673@lst.de>
 <20250716-unwahr-dumpf-835be7215e4c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-unwahr-dumpf-835be7215e4c@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 16-07-25 14:19:57, Christian Brauner wrote:
> On Wed, Jul 16, 2025 at 01:21:49PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 15, 2025 at 04:35:24PM +0200, Christian Brauner wrote:
> > > Unless there are severe performance penalties for the extra pointer
> > > dereferences getting our hands on 16 bytes is a good reason to at least
> > > consider doing this.
> > > 
> > > I've drafted one way of doing this using ext4 as my victim^wexample. I'd
> > > like to hear some early feedback whether this is something we would want
> > > to pursue.
> > 
> > I like getting rid of the fields.  But adding all these indirect calls
> > is a bit nasty.
> > 
> > Given that all these fields should be in the file system specific inode
> > that also embeddeds the vfs struct inode, what about just putting the
> > relative offset into struct inode_operations.
> > 
> > e.g. something like
> > 
> > 	struct inode_operations {
> > 		...
> > 		ptrdiff_t		i_crypto_offset;
> > 	}
> > 
> > struct inode_operations foofs_iops {
> > 	...
> > 
> > 	.i_crypto_offset = offsetoff(struct foofs_inode), vfs_inode) -
> > 		offsetoff(struct foofs_inode, crypt_info);
> > }
> > 
> > static inline struct fscrypt_inode_info CRYPT_I(struct inode *inode)
> > {
> > 	return ((void *)inode) - inode->i_op->i_cryto_offset;
> > }
> 
> Sheesh, ugly in a different way imho. I could live with it. I'll let
> @Jan be the tie-breaker.

Heh, I feel biased because about 10 years ago I proposed something like
this and it got shot down as being too ugly to be worth the memory. But
times are changing :). I think hooks to return pointer are cleaner but this
is clearly going to be faster. I think since this would be fully
encapsulated in the few inline helpers the offset solution is (still) OK.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

