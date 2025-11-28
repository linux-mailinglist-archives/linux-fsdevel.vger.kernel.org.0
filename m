Return-Path: <linux-fsdevel+bounces-70130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB5FC91BCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 11:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7082C4E369E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 10:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6AA30CDBE;
	Fri, 28 Nov 2025 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X8XMEsbO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K4Op5za9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UcrnwgZc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CfCpXfUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0D2DEA95
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764327534; cv=none; b=tjMS6O087MaOrtHkWLTHhq/4uvYrDgRc7SS45D/wpdc43ITnQ+r6LnilZjF4s92KVwyTglCNu0wGHGb6JWWNEX6Y/aZxU7h3zv2YLMEPeZnng/I1ok16p2j/N93/TDy4k8mYeiYEoKI46wkoAmqo+vx44sMs6TbClEvgLlhCoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764327534; c=relaxed/simple;
	bh=SvnK5XQnMGY/Xm+9kDL5K2+BVNhGugSE82rzNQ/7pNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJD1bRXvujDho59XG+O45/5i+652rYoi0yENJ72ojP7RLFxcVpobjy2uPlJFx4w6vCdPMWubJIQQqyUZDj2zaGArhyC1UnisgT5ygu0YS0F/msH7zeHJsQNeTX6y+gzsa9r4ZpXZzmOGnQkW7cgJ4tfQxYUflnZf2NZAvdSBprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X8XMEsbO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K4Op5za9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UcrnwgZc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CfCpXfUn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 585CF221D3;
	Fri, 28 Nov 2025 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764327529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orTQmRLZwcrDEvwB9Xx8RqsI9hVqZBrpkc5wch7XSFo=;
	b=X8XMEsbOn8pZbWVsi0MLN1vNosdh3FW5JQMURp9k8alaeDHkhFMWrjPmVw4K/78+dR2zn6
	rI3wBIIyan/+lrqeq80ZJIVe5K9IUwOpi9dMwtSWj5h4OJQT3gavp2Awj8ClmGOwtl72+A
	Q5KytCKZQ+geDoZu/4Vg0qyUa+gIzbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764327529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orTQmRLZwcrDEvwB9Xx8RqsI9hVqZBrpkc5wch7XSFo=;
	b=K4Op5za9rhyheViAteLiWl6DoI7/+iADSDn0AZ8hBp6ruuZwH9iFr/ad4NLJbFLqNAVgHI
	yvwqh05aAc/txFAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UcrnwgZc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CfCpXfUn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764327528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orTQmRLZwcrDEvwB9Xx8RqsI9hVqZBrpkc5wch7XSFo=;
	b=UcrnwgZcRbLM3WcRHizVj2Q8nUpM95ZSbhImYqbuhe9lrIOHsOyN9nOvKee0zE3ZIcZ2NW
	Dn8KJUdoWBO7KO+sZeYNGmNsv/NoIHIwoU6qJTDkx6ZRW4PRBB/4junxaeKIxjntYqDmCk
	NTb252o7tO1nDQjADcBP03u8QtEB93k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764327528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orTQmRLZwcrDEvwB9Xx8RqsI9hVqZBrpkc5wch7XSFo=;
	b=CfCpXfUnocWJnBQ8TxZDl/yyWC0wEyF1SLXhLxmKGkQLmGYz1uvxkHn12Ka4/otMC4IXNC
	NUFC0thk7ZPyvyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 472063EA63;
	Fri, 28 Nov 2025 10:58:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PEf9EGiAKWnUFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Nov 2025 10:58:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E53FDA08F1; Fri, 28 Nov 2025 11:58:47 +0100 (CET)
Date: Fri, 28 Nov 2025 11:58:47 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 03/13] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1
Message-ID: <ihvyl3ayookm5b2tcjz63tfhdobn64lbzudiv7w3hezs6ykzyd@p2euigrkhmxm>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
 <yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq>
 <2713db6e-ff43-4583-b328-412e38f3d7bf@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2713db6e-ff43-4583-b328-412e38f3d7bf@huaweicloud.com>
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
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,huawei.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Score: -4.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 585CF221D3
X-Rspamd-Action: no action
X-Spam-Flag: NO

On Fri 28-11-25 11:45:51, Zhang Yi wrote:
> On 11/27/2025 9:41 PM, Jan Kara wrote:
> > I think the code would be much clearer
> > if we just centralized all the zeroing in ext4_split_extent(). At that
> > place the situation is actually pretty simple:
> 
> Thank you for your suggestion!
> 
> > 
> > 1) 'ex' is unwritten, 'map' describes part with already written data which
> > we want to convert to initialized (generally IO completion situation) => we
> > can zero out boundaries if they are smaller than max_zeroout or if extent
> > split fails.
> > 
> 
> Yes. Agree.
> 
> > 2) 'ex' is unwritten, 'map' describes part we are preparing for write (IO
> > submission) => the split is opportunistic here, if we cannot split due to
> > ENOSPC, just go on and deal with it at IO completion time. No zeroing
> > needed.
> 
> Yes. At the same time, if we can indeed move the entire split unwritten
> operation to be handled after I/O completion in the future, it would also be
> more convenient to remove this segment of logic.

Yes.

> > 3) 'ex' is written, 'map' describes part that should be converted to
> > unwritten => we can zero out the 'map' part if smaller than max_zeroout or
> > if extent split fails.
> 
> This makes sense to me! This case it originates from the fallocate with Zero
> Range operation. Currently, the zero-out operation will not be performed if
> the split operation fails, instead, it immediately returns a failure.
> 
> I agree with you that we can do zero out if the 'map' part smaller than
> max_zeroout instead of split extents. However, if the 'map' part is bigger
> than max_zeroout and if extent split fails, I don't think zero out is a good
> idea, Because it might cause zero-range calls to take a long time to execute.
> Although fallocate doesn't explicitly specify how ZERO_RANGE should be
> implemented, users expect it to be very fast. Therefore, in this case, if the
> split fails, it would be better to simply return an error, leave things as
> they are. What do you think?

True. Just returning the error is a good option in this case.

> > This should all result in a relatively straightforward code where we can
> > distinguish the three cases based on 'ex' and passed flags, we should be
> > able to drop the 'EXT4_EXT_DATA_VALID*' flags and logic (possibly we could
> > drop the 'split_flag' argument of ext4_split_extent() altogether), and fix
> > the data exposure issues at the same time. What do you think? Am I missing
> > some case?
> 
> Indeed, I think the overall solution is a nice cleanup idea. :-)
> But this would involve a significant amount of refactoring and logical changes.
> Could we first merge the current set of patches(it could be more easier to
> backport to the early LTS version), and then I can start a new series to
> address this optimization?

I agree the changes are rather intrusive and the code is complex. Since you
have direct fixes already written, let's merge them first and cleanup
afterwards as you suggest.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

