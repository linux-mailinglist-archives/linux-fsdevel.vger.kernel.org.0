Return-Path: <linux-fsdevel+bounces-36424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A59E396C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849E616939C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8251B6CE0;
	Wed,  4 Dec 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nlKZkOoA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f9ttA8yz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pcU2v5Gl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6TFV7QGk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524D19E979;
	Wed,  4 Dec 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313749; cv=none; b=Wfw9zKy2NighuFWSUAHkxwb+H/VEpmz8iSFpKjl2BCZzH3fzTGMJyAOpWTwOFbFsY+yDXM84SX9RcB/Lmo+2LNmWD83x2JSqBm/4qILYRrbXC/8FvH9/zpi6TFxYldQWzBCVVE16oiZIx8qzKPZ5lGmO6P2CMNrPOI+8wlk2usE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313749; c=relaxed/simple;
	bh=+rADbuvjJ68ffAHIZ1Mc1HfceqzenUu1Ycb6pyYiKMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyYfLFMmcwFAtylVpvyDqQt4QYTN0+8TeduUGJC0B/YkToqO2WGmW4L9VteLbgJitY2H5+EI6PYeyhV+NY5+829jO9cgUCl00pIvBpLk6ft5/zcl0uElK0yZ00HR9FzqLsFDJ8WKpQ6jHYhzFQddux1kBgJGKafrtYCPmpW3hMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nlKZkOoA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f9ttA8yz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pcU2v5Gl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6TFV7QGk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3611F1F38E;
	Wed,  4 Dec 2024 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733313746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHKMrJE5zinvwAsvq+/bwnV8+hOiGqTnJJUDyoC/OCQ=;
	b=nlKZkOoAFakB/fP43CuNnRbGXYKUbvDj6PewrkHtS08u8Y6KoDkl7iQuDy6FNW3zEcOMmG
	osHc2oJmxbKZGBd4yM2rlZlpc7D0H2xDCiPy1hSuWBBVvrDGiZiqN6gNwMp7HLwEMHuMWR
	0i+Z1pyZ7doggVVaOuDkT0WcRatBeAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733313746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHKMrJE5zinvwAsvq+/bwnV8+hOiGqTnJJUDyoC/OCQ=;
	b=f9ttA8yzG6Zn0NxyhhxnyY2gdljVx9PJa4vl0vlFAsnT0UCvtlidH9Xuk7XspBwvMhFOrD
	XlRg9UjSUbKPIWDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pcU2v5Gl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6TFV7QGk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733313745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHKMrJE5zinvwAsvq+/bwnV8+hOiGqTnJJUDyoC/OCQ=;
	b=pcU2v5GlNoQNjf10UCVwEgrwEHHsf6TadcwTG76IcqwSpigAA0KYh9r+5APad0YJrWZixz
	dYeiB6t+OwLygzLKTFQQJcd62pEpdapi35pD8qTvJ3qX2qriRF10mow0soNL2QRjYRbei6
	7wGmjsnLfEMcYQMwdGyMLyfBQ6LnAAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733313745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHKMrJE5zinvwAsvq+/bwnV8+hOiGqTnJJUDyoC/OCQ=;
	b=6TFV7QGkW8sTIXjocbT2gk4RfydoS+EeDUmKK2dqaS30x2DFfQLuXBkU5IGxhjCEnhBW8O
	j3T1txDmvRrxw4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 266B91396E;
	Wed,  4 Dec 2024 12:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yfBYCdFEUGd3HgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 12:02:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D69AFA0918; Wed,  4 Dec 2024 13:02:24 +0100 (CET)
Date: Wed, 4 Dec 2024 13:02:24 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 07/27] ext4: refactor ext4_insert_range()
Message-ID: <20241204120224.c6qfexo2sea2qk5s@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-8-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 3611F1F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue 22-10-24 19:10:38, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Simplify ext4_insert_range() and align its code style with that of
> ext4_collapse_range(). Refactor it by: a) renaming variables, b)
> removing redundant input parameter checks and moving the remaining
> checks under i_rwsem in preparation for future refactoring, and c)
> renaming the three stale error tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Same nit as in the previous patch:

> -out_stop:
> +out_handle:
>  	ext4_journal_stop(handle);
> -out_mmap:
> +out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out_mutex:
> +out:
>  	inode_unlock(inode);
>  	return ret;
>  }

I think 'out_inode_lock' is better than plain 'out'.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

