Return-Path: <linux-fsdevel+bounces-37070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48979ED0A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 17:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604591670DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233101D9350;
	Wed, 11 Dec 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nl3IYdP9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7YEGTHuy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2JoZmzDk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9tNWk36n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94224633F;
	Wed, 11 Dec 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932857; cv=none; b=DZX+zszmRBxx/7T8LT1+Nca+897HzMzJW0DzgvyPNigrj38MvQC2xRL99gKlXz+tRCRLhkuW3f0tXKfWbEd7xML+kRD9n/GfNbmOvHElvgfBAYoZKcju5+ZQFCypAvhB1awHwVHf/nQ2kGyix1TinkcPlu8p5XKKLHoujylKxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932857; c=relaxed/simple;
	bh=8GHXoD+9xfEHdR94tL0AaSvEhf64ATMm3fcNzSQfgNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9gWLQCttlE4y/3gJGQ2kEd/JYcm/s6fuOB8NRGVSJ1SpIFHG88KNUxF5eQwZXqrEPgPTY5+NEHSSiJYiTOBg6Nla29+g+7DbkN/SgodvwYlGuMxqrYYpImjqU7Dizk+AGi6Ef8X9qQrWVcSGTB/E+9bGEOy4orZIgB3zdJS6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nl3IYdP9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7YEGTHuy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2JoZmzDk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9tNWk36n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBAA61F38C;
	Wed, 11 Dec 2024 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733932848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khi9hf2cpTmd/YUgYCLnJo8tGx85omoRBEcei6rvcdg=;
	b=Nl3IYdP9RH6yO7gsl3EvV5Xux+bZHvEWymRk3yqKYG+u3+InWS377Qlv8eaH+lRvo0CFUe
	2C0iPHvibERsY2gGF6xc81Z7yr+fKYERaHhK8Kh5Kysl+MRLz//lrVkX6HqxN/Jkrs1qY/
	ra3rP8PdcvzKgB38ZIo4u/eqazL40zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733932848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khi9hf2cpTmd/YUgYCLnJo8tGx85omoRBEcei6rvcdg=;
	b=7YEGTHuy0dvcJkwZwuFM2Y/yaxoyrkaut5Zb34OSo/I8ISr+Picx5J06V3+L1jcNU81/MH
	JDxolbdWjoNahoCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2JoZmzDk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9tNWk36n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733932847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khi9hf2cpTmd/YUgYCLnJo8tGx85omoRBEcei6rvcdg=;
	b=2JoZmzDkBHRCPtAEqiPSLJoTtCdgUcdLQZxrraYeru61eDc9sSd0aUIA0oBp2+XFGBnKTi
	RbCcu9av9ii4kZtPZjpOPx9a6TSaDiWbSzUc99CXvMvmLe/sG8xXtqFrtlQbBo4M2sDhPf
	gsFo24ZRihFmv5LAxm9q0STBaEvjeUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733932847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khi9hf2cpTmd/YUgYCLnJo8tGx85omoRBEcei6rvcdg=;
	b=9tNWk36nVHykbG0fvWU6HAL8UYvL8CgnsuxUZNWBSLXHYc/vCHX9diovtkshoZc+MCOSIY
	PrOwGToC9SBDEnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC61D13983;
	Wed, 11 Dec 2024 16:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EVf8LS+3WWfJTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Dec 2024 16:00:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 44E6EA0894; Wed, 11 Dec 2024 17:00:47 +0100 (CET)
Date: Wed, 11 Dec 2024 17:00:47 +0100
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
Message-ID: <20241211160047.qnxvodmbzngo3jtr@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-13-yi.zhang@huaweicloud.com>
 <20241204124221.aix7qxjl2n4ya3b7@quack3>
 <c831732e-38c5-4a82-ab30-de17cff29584@huaweicloud.com>
 <20241206162102.w4hw35ims5sdf4ik@quack3>
 <5049c794-9a92-462c-a455-2bdf94cdebef@huaweicloud.com>
 <20241210125726.gzcx6mpuecifqdwe@quack3>
 <95c631d7-84da-412b-b7dc-f4785739f41a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95c631d7-84da-412b-b7dc-f4785739f41a@huaweicloud.com>
X-Rspamd-Queue-Id: CBAA61F38C
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Wed 11-12-24 15:59:51, Zhang Yi wrote:
> On 2024/12/10 20:57, Jan Kara wrote:
> > On Mon 09-12-24 16:32:41, Zhang Yi wrote:
> > b) evict all page cache in the affected range -> should stop writeback -
> >    *but* currently there's one case which could be problematic. Assume we
> >    do punch hole 0..N and the page at N+1 is dirty. Punch hole does all of
> >    the above and starts removing blocks, needs to restart transaction so it
> >    drops i_data_sem. Writeback starts for page N+1, needs to load extent
> >    block into memory, ext4_cache_extents() now loads back some extents
> >    covering range 0..N into extent status tree. 
> 
> This completely confuses me. Do you mention the case below,
> 
> There are many extent entries in the page range 0..N+1, for example,
> 
>    0                                  N N+1
>    |                                  |/
>   [www][wwwwww][wwwwwwww]...[wwwww][wwww]...
>                 |      |
>                 N-a    N-b
> 
> Punch hole is removing each extent entries from N..0
> (ext4_ext_remove_space() removes blocks from end to start), and could
> drop i_data_sem just after manipulating(removing) the extent entry
> [N-a,N-b], At the same time, a concurrent writeback start write back
> page N+1 since the writeback only hold page lock, doesn't hold i_rwsem
> and invalidate_lock. It may load back the extents 0..N-a into the
> extent status tree again while finding extent that contains N+1?

Yes, because when we load extents from extent tree, we insert all extents
from the leaf of the extent tree into extent status tree. That's what
ext4_cache_extents() call does.

> Finally it may left some stale extent status entries after punch hole
> is done?

Yes, there may be stale extents in the extent status tree when
ext4_ext_remove_space() returns. But punch hole in particular then does:

ext4_es_insert_extent(inode, first_block, hole_len, ~0,
                                      EXTENT_STATUS_HOLE, 0);

which overwrites these stale extents with appropriate information.

> If my understanding is correct, isn't that a problem that exists now?
> I mean without this patch series.

Yes, the situation isn't really related to your patches. But with your
patches we are starting to rely even more on extent status tree vs extent
tree consistecy. So I wanted to spell out this situation to verify new
problem isn't introduced and so that we create rules that handle this
situation well.

> >    So the only protection
> >    against using freed blocks is that nobody should be mapping anything in
> >    the range 0..N because we hold those locks & have evicted page cache.
> > 
> > So I think we need to also document, that anybody mapping blocks needs to
> > hold i_rwsem or invalidate_lock or a page lock, ideally asserting that in
> > ext4_map_blocks() to catch cases we missed. Asserting for page lock will
> > not be really doable but luckily only page writeback needs that so that can
> > get some extemption from the assert.
> 
> In the case above, it seems that merely holding a page lock is
> insufficient?

Well, holding page lock(s) for the range you are operating on is enough to
make sure there cannot be parallel operations on that range like truncate,
punch hole or similar, because they always remove the page cache before
starting their work and because they hold invalidate_lock, new pages cannot
be created while they are working.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

