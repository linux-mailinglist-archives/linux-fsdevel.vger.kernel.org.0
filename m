Return-Path: <linux-fsdevel+bounces-49572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7826ABF1A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 12:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E238B3A43DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6012625F7A5;
	Wed, 21 May 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UZUp6Q1B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="88UvvMY6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UZUp6Q1B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="88UvvMY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7E253F06
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823488; cv=none; b=iV7851Z3UDZH9OUI5S3XX5M81IBZzyi+q7yEO+6XYVPTi+UaulmDZXEN0y4RLZBx46GDo2LMK0p7t5QCDDMOulGg/ZC0XUchR+i2MPht2Ii7kGRH+IEh1rljr/RKj/ihdb7t2DZwJK4bOP+3+yuBj3gOO/x5xHri1xghljsd5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823488; c=relaxed/simple;
	bh=Y7wXlYBKilElGrxPOEAxIoQfkr3dVOykIBsfU9jq/wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC2rs4gN7uJ1l5gA9mQVBdjATkdQORzxtk6QP0Icl8/37pEnKFLLioyXiq1ju6tp7Xz9D+aAIo0PkzrDqOeunCrfjhDL+5s6thr0IAJ2ZTjISgb0nf+Zxp9omgsQI+D2EpCK821oyiJYBuftpRTGixLaTv3/ESs2Si5Idx1vQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UZUp6Q1B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=88UvvMY6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UZUp6Q1B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=88UvvMY6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4172D227B7;
	Wed, 21 May 2025 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747823485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=srn8jSg9ullgOYE/RnvBqPHnTl5WzflJDekRT3jm408=;
	b=UZUp6Q1BQLkNUzill/lJmwow6+3+1BiWPkXK71uOYYfRhcbR+LdEEdk9QHoeCQoJ6DiABB
	YAjJeWJ82z5HZxJrHc8lCHliFIxBlcKv2onaCShh3E4uARF3t/npb24Cl8n0tSpzW9Gsys
	icDH7BE8AcEyC8TDU2iku3m8WNRxhCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747823485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=srn8jSg9ullgOYE/RnvBqPHnTl5WzflJDekRT3jm408=;
	b=88UvvMY68Zj3/4E4p2tt96dqM7UF13R1CY+bxb4X+e/l1dz8YUFcitpJHsD0cU2dOKXd86
	2A/QVBE500xW27Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UZUp6Q1B;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=88UvvMY6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747823485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=srn8jSg9ullgOYE/RnvBqPHnTl5WzflJDekRT3jm408=;
	b=UZUp6Q1BQLkNUzill/lJmwow6+3+1BiWPkXK71uOYYfRhcbR+LdEEdk9QHoeCQoJ6DiABB
	YAjJeWJ82z5HZxJrHc8lCHliFIxBlcKv2onaCShh3E4uARF3t/npb24Cl8n0tSpzW9Gsys
	icDH7BE8AcEyC8TDU2iku3m8WNRxhCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747823485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=srn8jSg9ullgOYE/RnvBqPHnTl5WzflJDekRT3jm408=;
	b=88UvvMY68Zj3/4E4p2tt96dqM7UF13R1CY+bxb4X+e/l1dz8YUFcitpJHsD0cU2dOKXd86
	2A/QVBE500xW27Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FF1313AA0;
	Wed, 21 May 2025 10:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0zBtC32rLWiVUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 May 2025 10:31:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C16DDA0870; Wed, 21 May 2025 12:31:16 +0200 (CEST)
Date: Wed, 21 May 2025 12:31:16 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 4/8] ext4/jbd2: convert jbd2_journal_blocks_per_page()
 to support large folio
Message-ID: <l2sm2sxycp2u2mqve6vx3rdwitsth55z657iw5qlsz2ko2eskr@7nko44yniymo>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-5-yi.zhang@huaweicloud.com>
 <ht54j6bvjmiqt62xmcveqlo7bmrunqs4ji7wikfteftdjijzek@7tz5gpejaoen>
 <924cfe2c-318c-493f-89a5-10849bfc7a00@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924cfe2c-318c-493f-89a5-10849bfc7a00@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 4172D227B7
X-Spam-Level: 
X-Spam-Flag: NO

On Tue 20-05-25 20:46:51, Zhang Yi wrote:
> On 2025/5/20 4:16, Jan Kara wrote:
> > On Mon 12-05-25 14:33:15, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> jbd2_journal_blocks_per_page() returns the number of blocks in a single
> >> page. Rename it to jbd2_journal_blocks_per_folio() and make it returns
> >> the number of blocks in the largest folio, preparing for the calculation
> >> of journal credits blocks when allocating blocks within a large folio in
> >> the writeback path.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > ...
> >> @@ -2657,9 +2657,10 @@ void jbd2_journal_ack_err(journal_t *journal)
> >>  	write_unlock(&journal->j_state_lock);
> >>  }
> >>  
> >> -int jbd2_journal_blocks_per_page(struct inode *inode)
> >> +int jbd2_journal_blocks_per_folio(struct inode *inode)
> >>  {
> >> -	return 1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
> >> +	return 1 << (PAGE_SHIFT + mapping_max_folio_order(inode->i_mapping) -
> >> +		     inode->i_sb->s_blocksize_bits);
> >>  }
> > 
> > FWIW this will result in us reserving some 10k transaction credits for 1k
> > blocksize with maximum 2M folio size. That is going to create serious
> > pressure on the journalling machinery. For now I guess we are fine
> 
> Oooh, indeed, you are right, thanks a lot for pointing this out. As you
> mentioned in patch 5, the credits calculation I proposed was incorrect,
> I thought it wouldn't require too many credits.
> 
> I believe it is risky to mount a filesystem with a small journal space
> and a large number of block groups. For example, if we build an image
> with a 1K block size and a 1MB journal on a 20GB disk (which contains
> 2,540 groups), it will require 2,263 credits, exceeding the available
> journal space.
> 
> For now, I'm going to disable large folio support on the filesystem with
> limited journal space. i.e., when the return value of
> ext4_writepage_trans_blocks() is greater than
> jbd2_max_user_trans_buffers(journal) / 2, ext4_should_enable_large_folio()
> return false, thoughts?

Yep, looks like a good stopgap solution for now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

