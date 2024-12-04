Return-Path: <linux-fsdevel+bounces-36451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8CB9E3AB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09871688DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843D61BD4E5;
	Wed,  4 Dec 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vHvPgaq+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OYHpGnkc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vHvPgaq+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OYHpGnkc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC42C181;
	Wed,  4 Dec 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317004; cv=none; b=nOGy0CAy6rSlO4pe646GKdSOByafUtQj3exnG0JqRNvJI6NYJWB12G76fi0YqYq1mgU/g0wnNMbgvLwAmIC5uhh8Rf70f/dUQ4c3eIvzeKLgfATs9J83CLRQSuVJlxMqshbORX4tLWnaUkJQJr0xNn3VeG6lioS0fO1dyseqt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317004; c=relaxed/simple;
	bh=bg1XKp8J4Yi8n+Xpa4k72gV+en8sJbkXKwjLRQ0Icow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLN23luVYYVfNVE8LaEZ0JxurbSclpzgG5kynXF2ONzk+lJ1aGY96i3iUMXyv92wgBmCQvyAxOyaNaPdGcZFwUHWpZZuizExtgHDASJf2kuIKq6gIPI/I/KARk424bgKIRyTioNf+Jqy3NDr6YWxgdaev+cWRfqFKSrlrRdXvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vHvPgaq+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OYHpGnkc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vHvPgaq+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OYHpGnkc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 633131F365;
	Wed,  4 Dec 2024 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733317000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4UBslpBMR/mIOrrjL3exyxu/5ND2e7QWSXkL/mOFrM=;
	b=vHvPgaq+hYQZtFjGrY6V+1OloVYXAj3iy0aLKQUTYQvUeDRaGd4iwWFwY/68xlLtrFwALP
	vGbEsr7eSFG8fOB449uPii2y6uRPyeIXFortPBuQX4Xidza7aUQAwE/XgFfIZECkqQu0ub
	Q7lvoN7hFnfxAT9rokQgNlV8hM/kpwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733317000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4UBslpBMR/mIOrrjL3exyxu/5ND2e7QWSXkL/mOFrM=;
	b=OYHpGnkcqCeZMUjvKBMda16cgH2cXkNkAk4Lax6eIlr/QaG7uFzZB5lSRdOL2nIPTXf4be
	FuVpcSynFQ9zFgAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vHvPgaq+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OYHpGnkc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733317000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4UBslpBMR/mIOrrjL3exyxu/5ND2e7QWSXkL/mOFrM=;
	b=vHvPgaq+hYQZtFjGrY6V+1OloVYXAj3iy0aLKQUTYQvUeDRaGd4iwWFwY/68xlLtrFwALP
	vGbEsr7eSFG8fOB449uPii2y6uRPyeIXFortPBuQX4Xidza7aUQAwE/XgFfIZECkqQu0ub
	Q7lvoN7hFnfxAT9rokQgNlV8hM/kpwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733317000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4UBslpBMR/mIOrrjL3exyxu/5ND2e7QWSXkL/mOFrM=;
	b=OYHpGnkcqCeZMUjvKBMda16cgH2cXkNkAk4Lax6eIlr/QaG7uFzZB5lSRdOL2nIPTXf4be
	FuVpcSynFQ9zFgAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 571DA139C2;
	Wed,  4 Dec 2024 12:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hEQ7FYhRUGeVLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 12:56:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 09319A0918; Wed,  4 Dec 2024 13:56:32 +0100 (CET)
Date: Wed, 4 Dec 2024 13:56:31 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH 0/2] jbd2: two straightforward fixes
Message-ID: <20241204125631.au6ggazqdnq5xey2@quack3>
References: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
 <20241204-landen-umwirbt-06fd455b45d2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-landen-umwirbt-06fd455b45d2@brauner>
X-Rspamd-Queue-Id: 633131F365
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-12-24 12:00:55, Christian Brauner wrote:
> On Tue, 03 Dec 2024 09:44:05 +0800, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Zhang Yi (2):
> >   jbd2: increase IO priority for writing revoke records
> >   jbd2: flush filesystem device before updating tail sequence
> > 
> > fs/jbd2/commit.c | 4 ++--
> >  fs/jbd2/revoke.c | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > [...]
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.

Traditionally, Ted takes jbd2 patches through his tree. For these two
patches, chances for conflicts or unexpected effects are pretty low so I
don't really care but I wanted to point that out :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

