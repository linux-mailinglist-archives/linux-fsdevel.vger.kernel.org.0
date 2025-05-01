Return-Path: <linux-fsdevel+bounces-47821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5394AA5DB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 13:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D099C5B70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB1222570;
	Thu,  1 May 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dXfUnF0Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iyfX+hyD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dXfUnF0Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iyfX+hyD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B114EC5
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 May 2025 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746098358; cv=none; b=hCz15zjMlhZwm4qZeHoB2ZNX6wdGXQ51SxRgntzI44qNqSBRBd5OreDO3QFGRtRWkQxfnW90vdfpgud+eZkElDf6UMrHtYdYjVKTacWIv3wQIpAlFICXIf+L1t8uJfbXzAKIHNdu1u9doQxL0y96MRLCi4vU2yNniDZilc9IGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746098358; c=relaxed/simple;
	bh=V1hbDxY+Xl0TX989SzsmUJCW2KJudQ05NUJwcgVc9i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/oEfdkRYkFR+em70LcXjrMP0VqQvAIDMbj9D6B7qsmrPNWfIQvufPHRoxyAKXOAOQm85JD4vhQHaKHHtysRVYOYXgwlCYr8D/3KVeFwCWLm0ITa5e9EHqd20cRjygfPVz2zMz39ikuTObzBg3sFmOwhvAw19aE+eoJwFrW3PYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dXfUnF0Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iyfX+hyD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dXfUnF0Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iyfX+hyD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FEC41F76B;
	Thu,  1 May 2025 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746098354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5BePWJyYsVW7m8KObraTr4ogH1NSnvnLdbstl56ihI=;
	b=dXfUnF0Y68Yhu7N6AyGbQvEybOZ/TYRz4s7eRqMneYVdky/AtTvG8PG0G3dsNykkjLVjC4
	AWvyqZ4CYEyfJ7jiWJcFVQgTptptHZAspRMnkxv7T61UpGHOscdZS7u5tccIQaU/gn6E+y
	SRPd12quug8SzTVpo9mcsbFkX0BOLyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746098354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5BePWJyYsVW7m8KObraTr4ogH1NSnvnLdbstl56ihI=;
	b=iyfX+hyDKxq8EWH6DyyJq+clWQMmCnRbaEaO3bxj8Ox2F7zaoLm9+fb8lnG5Xn4PWyGoT2
	lOH1Y3apuokJCQCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dXfUnF0Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iyfX+hyD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746098354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5BePWJyYsVW7m8KObraTr4ogH1NSnvnLdbstl56ihI=;
	b=dXfUnF0Y68Yhu7N6AyGbQvEybOZ/TYRz4s7eRqMneYVdky/AtTvG8PG0G3dsNykkjLVjC4
	AWvyqZ4CYEyfJ7jiWJcFVQgTptptHZAspRMnkxv7T61UpGHOscdZS7u5tccIQaU/gn6E+y
	SRPd12quug8SzTVpo9mcsbFkX0BOLyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746098354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5BePWJyYsVW7m8KObraTr4ogH1NSnvnLdbstl56ihI=;
	b=iyfX+hyDKxq8EWH6DyyJq+clWQMmCnRbaEaO3bxj8Ox2F7zaoLm9+fb8lnG5Xn4PWyGoT2
	lOH1Y3apuokJCQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51618139E7;
	Thu,  1 May 2025 11:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CjWVE7JYE2hTMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 May 2025 11:19:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D333AA0AF0; Thu,  1 May 2025 13:19:13 +0200 (CEST)
Date: Thu, 1 May 2025 13:19:13 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Zhang Yi <yi.zhang@huawei.com>, Liebes Wang <wanghaichi0403@gmail.com>, 
	Jan Kara <jack@suse.cz>, ojaswin@linux.ibm.com, Theodore Ts'o <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, syzkaller@googlegroups.com, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: kernel BUG in zero_user_segments
Message-ID: <znfg4s5ysxqvrzeevkmtgixj5vztcyqbuny7waqkugnzkpg2zx@2vxwh57flvva>
References: <CADCV8spm=TtW_Lu6p-5q-jdHv1ryLcx45mNBEcYdELbHv_4TnQ@mail.gmail.com>
 <uxweupjmz7pzbj77cciiuxduxnbuk33mx75bimynzcjmq664zo@xqrdf6ouf5v6>
 <ac3a58f6-e686-488b-a9ee-fc041024e43d@huawei.com>
 <aBGVmIin8YxRyFDp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBGVmIin8YxRyFDp@casper.infradead.org>
X-Rspamd-Queue-Id: 5FEC41F76B
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,suse.cz,linux.ibm.com,mit.edu,vger.kernel.org,googlegroups.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 30-04-25 04:14:32, Matthew Wilcox wrote:
> On Tue, Apr 29, 2025 at 03:55:18PM +0800, Zhang Yi wrote:
> > After debugging, I found that this problem is caused by punching a hole
> > with an offset variable larger than max_end on a corrupted ext4 inode,
> > whose i_size is larger than maxbyte. It will result in a negative length
> > in the truncate_inode_partial_folio(), which will trigger this problem.
> 
> It seems to me like we're asking for trouble when we allow an inode with
> an i_size larger than max_end to be instantiated.  There are probably
> other places which assume it is smaller than max_end.  We should probably
> decline to create the bad inode in the first place?

Indeed somewhat less quirky fix could be to make ext4_max_bitmap_size()
return one block smaller limit. Something like:

        /* Compute how many blocks we can address by block tree */
        res += ppb;
        res += ppb * ppb;
        res += ((loff_t)ppb) * ppb * ppb;
+	/*
+	 * Hole punching assumes it can map the block past end of hole to
+	 * tree offsets
+	 */
+	res -= 1;
        /* Compute how many metadata blocks are needed */
        meta_blocks = 1;
        meta_blocks += 1 + ppb;

The slight caveat is that in theory there could be filesystems out there
with so large files and then we'd stop allowing access to such files. But I
guess the chances are so low that it's probably worth trying.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

