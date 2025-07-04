Return-Path: <linux-fsdevel+bounces-53902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DAEAF8BC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2729EB44FD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC93196AA;
	Fri,  4 Jul 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LgzJe13Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="42H/Z7jv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LgzJe13Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="42H/Z7jv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E0283FD6
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617142; cv=none; b=rljTFoFCbpoGMwOlwKqEmMYkWpDfdbu0+c1h4cJT5wutKBiTdhbvQ0iAQRY0drzIu1xv5jyx0FPp/PU8YYZRXNkGbTG9WcgHHTKjOE6bDDuA+5yn9xZ7nIDqhQDLWtCGx2Lkar/iHxhDjwNg5YG40IpgIpjQBDNzAhIo/gMUW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617142; c=relaxed/simple;
	bh=P7yLgPJNlBMj21AI8RI7eojWFQsYmlMVychtbIbI/5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGLcr/+Y0zhQaRep3cG/w+h/dplJn+O9Eo6BPHng8E/nnb0Ez9a0c20Z7Bs6i6ieXdo0zcxKinMmoiHl4lrLbu6PHAHfhQvVJOynjzDJRPCdKFRDFQQiWTS9w4VUEyjFJI06FS0+AxwW25QmmZlLT48UW05nhTT8dEy6/lbHXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LgzJe13Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=42H/Z7jv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LgzJe13Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=42H/Z7jv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CB8C21189;
	Fri,  4 Jul 2025 08:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751617137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSyS+GilUNJCsoFZxlRDs2Pb00v1l/BsjS8N0kiKooo=;
	b=LgzJe13QM7+5M7QEQcVCUQrrJ0eztjJ/4IVhm0PIXcLZBihHD8hrgC89C76E7YIsETLnXI
	2HBAnJt2AZNArE8fn8frsJEqk8Q4WUHG4e03aIgkSenOeCcCSPZUhwYz9rGzTShVHaDk2h
	0WzJ+UMccFMdMdsDaFaWeeEAoVnnpQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751617137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSyS+GilUNJCsoFZxlRDs2Pb00v1l/BsjS8N0kiKooo=;
	b=42H/Z7jvA0vSM0oH49QvD/Ks7lMDBO9PWfBWaGoXqrJ1muXP9dS8xR6YoBUO5IJNdEKkD9
	zGcXyQlR8NckHKCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LgzJe13Q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="42H/Z7jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751617137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSyS+GilUNJCsoFZxlRDs2Pb00v1l/BsjS8N0kiKooo=;
	b=LgzJe13QM7+5M7QEQcVCUQrrJ0eztjJ/4IVhm0PIXcLZBihHD8hrgC89C76E7YIsETLnXI
	2HBAnJt2AZNArE8fn8frsJEqk8Q4WUHG4e03aIgkSenOeCcCSPZUhwYz9rGzTShVHaDk2h
	0WzJ+UMccFMdMdsDaFaWeeEAoVnnpQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751617137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSyS+GilUNJCsoFZxlRDs2Pb00v1l/BsjS8N0kiKooo=;
	b=42H/Z7jvA0vSM0oH49QvD/Ks7lMDBO9PWfBWaGoXqrJ1muXP9dS8xR6YoBUO5IJNdEKkD9
	zGcXyQlR8NckHKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 488E413A71;
	Fri,  4 Jul 2025 08:18:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XPCvEXGOZ2j7DwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Jul 2025 08:18:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DEAD2A0A31; Fri,  4 Jul 2025 10:18:56 +0200 (CEST)
Date: Fri, 4 Jul 2025 10:18:56 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com, 
	libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 05/10] ext4: restart handle if credits are
 insufficient during allocating blocks
Message-ID: <mk5f4g4rwp37ob6qmd7asocumeepjcnufqzjvazr3yukbyzq3y@6gp6x6zvxf7r>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-6-yi.zhang@huaweicloud.com>
 <i7lzmvk5prgnw2zri46adshfjhfq63r7le5w5sv67wmkiimbhc@a24oub5o6xtg>
 <ceb8c9c1-f426-4cd0-b7d8-841190631a90@huaweicloud.com>
 <zqrcmug26tnhhjombztjjqwcorbnk4elqg2dqayhtfo2gkx3e3@wvzykthigny6>
 <f73b6973-3f7c-4e0e-9908-3a3f151715b5@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73b6973-3f7c-4e0e-9908-3a3f151715b5@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6CB8C21189
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Fri 04-07-25 09:40:23, Zhang Yi wrote:
> On 2025/7/4 0:27, Jan Kara wrote:
> > On Thu 03-07-25 10:13:07, Zhang Yi wrote:
> >> On 2025/7/2 22:18, Jan Kara wrote:
> >>> On Tue 01-07-25 21:06:30, Zhang Yi wrote:
> >>>> From: Zhang Yi <yi.zhang@huawei.com>
> >>>>
> >>>> After large folios are supported on ext4, writing back a sufficiently
> >>>> large and discontinuous folio may consume a significant number of
> >>>> journal credits, placing considerable strain on the journal. For
> >>>> example, in a 20GB filesystem with 1K block size and 1MB journal size,
> >>>> writing back a 2MB folio could require thousands of credits in the
> >>>> worst-case scenario (when each block is discontinuous and distributed
> >>>> across different block groups), potentially exceeding the journal size.
> >>>> This issue can also occur in ext4_write_begin() and ext4_page_mkwrite()
> >>>> when delalloc is not enabled.
> >>>>
> >>>> Fix this by ensuring that there are sufficient journal credits before
> >>>> allocating an extent in mpage_map_one_extent() and
> >>>> ext4_block_write_begin(). If there are not enough credits, return
> >>>> -EAGAIN, exit the current mapping loop, restart a new handle and a new
> >>>> transaction, and allocating blocks on this folio again in the next
> >>>> iteration.
> >>>>
> >>>> Suggested-by: Jan Kara <jack@suse.cz>
> >>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >>>
> >>> Very nice. Feel free to add:
> >>>
> >>> Reviewed-by: Jan Kara <jack@suse.cz>
> >>>
> >>> One small comment below:
> >>>
> >>>> +/*
> >>>> + * Make sure that the current journal transaction has enough credits to map
> >>>> + * one extent. Return -EAGAIN if it cannot extend the current running
> >>>> + * transaction.
> >>>> + */
> >>>> +static inline int ext4_journal_ensure_extent_credits(handle_t *handle,
> >>>> +						     struct inode *inode)
> >>>> +{
> >>>> +	int credits;
> >>>> +	int ret;
> >>>> +
> >>>> +	if (!handle)
> >>>
> >>> Shouldn't this rather be ext4_handle_valid(handle) to catch nojournal mode
> >>> properly?
> >>>
> >> __ext4_journal_ensure_credits() already calls ext4_handle_valid() to handle
> >> nojournal mode, and the '!handle' check here is to handle the case where
> >> ext4_block_write_begin() passes in a NULL 'handle'.
> > 
> > Ah, right. But then you don't need the test at all, do you? Anyway,
> > whatever you decide to do with this (or nothing) is fine by me.
> > 
> 
> Yeah, remove this test is fine with me. I added this one is because the
> comments in ext4_handle_valid() said "Do not use this for NULL handles."
> I think it is best to follow this rule. :)

Right, I didn't read that comment :) So maybe the best fix will be just
adding a comment before the test like:

	/* Called from ext4_da_write_begin() which has no handle started? */
	if (!handle)
		return 0;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

