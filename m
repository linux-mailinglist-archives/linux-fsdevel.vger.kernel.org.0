Return-Path: <linux-fsdevel+bounces-53816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D19DAF7DE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CD9544E4D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7D258CEC;
	Thu,  3 Jul 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AadFsHcS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S3IjBH4v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AadFsHcS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S3IjBH4v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC924EF76
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560050; cv=none; b=GbPuD3/BD/NNDooJC2J8axlQIwZoCpoFfQuMUNRv5gbd3r5IEz9lcyyefMB1VMpyq7UKdN8Ano+DavdJYZMAJEeIXDFMdQ15U9Xi3caWCijtyM+TzlrrryPOlH8aylx13pIljmhil0f2k//NsfcXUS1Eo1eDIRw1eugFQhxGnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560050; c=relaxed/simple;
	bh=+YEmb/aAuUbKEa+H7axk+n5A0WbJP7KHeWZJ7YEfRH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpicSIgoV6TU8I5z9IuId3Aa+2lp8K0U1zWuk7qdiFmSRMvVv6odRausoSRUd20xDx3IVh/iicliym8/nmwDoG5o6BhiqsZv9zkNX40utuZZw56mSdntlBVYHqWbHVGFU7sqFu/8RUzB4T5M56E7XIAEekZmeSU8h8UBU/+elFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AadFsHcS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S3IjBH4v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AadFsHcS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S3IjBH4v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0ECA1F387;
	Thu,  3 Jul 2025 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751560046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3bdd++N6TfAFi91n85bZ1CQ92T+rDnQ3Zr/2gbtk2s=;
	b=AadFsHcSnAbH7g5k9OntraPjT4LtB7Loz/AD8NsEL2hN7/KTVHdAAnN7HyVJBFELdt95RR
	2p6pOS9c0DJpFEO+Gpa4k6RNAPtyBD7D2l0+LLgh3R8V5NzREunwc02g+r3fzs6Lgiv/4j
	h9Gt/wGcvlnE83SKP/KFPgTHNW5Jjqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751560046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3bdd++N6TfAFi91n85bZ1CQ92T+rDnQ3Zr/2gbtk2s=;
	b=S3IjBH4vMMUBRvrCdcn9b80+ok9XO5ZqSFQGyRsM6NcBBcW1fc3mOqo0KtqpoVmhvZDat+
	Z8+OgbKzAwX+2vBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751560046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3bdd++N6TfAFi91n85bZ1CQ92T+rDnQ3Zr/2gbtk2s=;
	b=AadFsHcSnAbH7g5k9OntraPjT4LtB7Loz/AD8NsEL2hN7/KTVHdAAnN7HyVJBFELdt95RR
	2p6pOS9c0DJpFEO+Gpa4k6RNAPtyBD7D2l0+LLgh3R8V5NzREunwc02g+r3fzs6Lgiv/4j
	h9Gt/wGcvlnE83SKP/KFPgTHNW5Jjqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751560046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3bdd++N6TfAFi91n85bZ1CQ92T+rDnQ3Zr/2gbtk2s=;
	b=S3IjBH4vMMUBRvrCdcn9b80+ok9XO5ZqSFQGyRsM6NcBBcW1fc3mOqo0KtqpoVmhvZDat+
	Z8+OgbKzAwX+2vBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B232F1368E;
	Thu,  3 Jul 2025 16:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 73J3K26vZmiHCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Jul 2025 16:27:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E81FA0A48; Thu,  3 Jul 2025 18:27:26 +0200 (CEST)
Date: Thu, 3 Jul 2025 18:27:26 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com, 
	libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 05/10] ext4: restart handle if credits are
 insufficient during allocating blocks
Message-ID: <zqrcmug26tnhhjombztjjqwcorbnk4elqg2dqayhtfo2gkx3e3@wvzykthigny6>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-6-yi.zhang@huaweicloud.com>
 <i7lzmvk5prgnw2zri46adshfjhfq63r7le5w5sv67wmkiimbhc@a24oub5o6xtg>
 <ceb8c9c1-f426-4cd0-b7d8-841190631a90@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb8c9c1-f426-4cd0-b7d8-841190631a90@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 03-07-25 10:13:07, Zhang Yi wrote:
> On 2025/7/2 22:18, Jan Kara wrote:
> > On Tue 01-07-25 21:06:30, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> After large folios are supported on ext4, writing back a sufficiently
> >> large and discontinuous folio may consume a significant number of
> >> journal credits, placing considerable strain on the journal. For
> >> example, in a 20GB filesystem with 1K block size and 1MB journal size,
> >> writing back a 2MB folio could require thousands of credits in the
> >> worst-case scenario (when each block is discontinuous and distributed
> >> across different block groups), potentially exceeding the journal size.
> >> This issue can also occur in ext4_write_begin() and ext4_page_mkwrite()
> >> when delalloc is not enabled.
> >>
> >> Fix this by ensuring that there are sufficient journal credits before
> >> allocating an extent in mpage_map_one_extent() and
> >> ext4_block_write_begin(). If there are not enough credits, return
> >> -EAGAIN, exit the current mapping loop, restart a new handle and a new
> >> transaction, and allocating blocks on this folio again in the next
> >> iteration.
> >>
> >> Suggested-by: Jan Kara <jack@suse.cz>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Very nice. Feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > One small comment below:
> > 
> >> +/*
> >> + * Make sure that the current journal transaction has enough credits to map
> >> + * one extent. Return -EAGAIN if it cannot extend the current running
> >> + * transaction.
> >> + */
> >> +static inline int ext4_journal_ensure_extent_credits(handle_t *handle,
> >> +						     struct inode *inode)
> >> +{
> >> +	int credits;
> >> +	int ret;
> >> +
> >> +	if (!handle)
> > 
> > Shouldn't this rather be ext4_handle_valid(handle) to catch nojournal mode
> > properly?
> > 
> __ext4_journal_ensure_credits() already calls ext4_handle_valid() to handle
> nojournal mode, and the '!handle' check here is to handle the case where
> ext4_block_write_begin() passes in a NULL 'handle'.

Ah, right. But then you don't need the test at all, do you? Anyway,
whatever you decide to do with this (or nothing) is fine by me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

