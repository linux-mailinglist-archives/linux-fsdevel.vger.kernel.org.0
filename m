Return-Path: <linux-fsdevel+bounces-35332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A79D3EEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787E5283CBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451521AA78C;
	Wed, 20 Nov 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vXvMKbuJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HdAhwtR9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0b3zeo0j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B4SowmnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395CAD58;
	Wed, 20 Nov 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116229; cv=none; b=OK72m2IJjE1TEU0OWtCxPdq/qGjQXOHFHHRrG2OuT31nXQpD79LPTc7ZvnArigUu3isJC6nN9oxkj2LyDvXw1NQPVd0YOotM/O//htGzkvQlNfWKUKJm2IiyKt9k/nMaV+eXqx/8fHoWRjGdmMhWBuOWRMOjcam1MXeXk1a5Yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116229; c=relaxed/simple;
	bh=yM3fdwupjvWIi5QCB60oGdhLi9PZdzHDr5blBMfmfts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N662jDtu+sIya0M/7zmSh7be0psPcAU2cWK5cZohO0ZBjI4yadpSvXzqI9kIWsGYT9bpj2lNFkz1LtMStAEjqJbwx9m0HOSvI1qOqsqUdl2GKqM89t0Rydo9HaPU/F+7SmUssxF++xB8BBBfsj6WdYfw4T7xrZ+mp6GSQkQXVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vXvMKbuJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HdAhwtR9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0b3zeo0j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B4SowmnV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F66B1F79B;
	Wed, 20 Nov 2024 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732116226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rbLMuMC2yYdzj3nG2I+d54+tseu9D8HIg5szJY41NA4=;
	b=vXvMKbuJ8/tKiFmOFejVn6aU5sqs95QkUwnPnUMV3Z4UZBsxxPYAoJrIrt56XH/efZHl3h
	jI545fB+xBCTJC//WtokwslS4wBZMDfYEnO+u1hmrHDfr+QkavHbd9pbWlLwrzeUHB0Y0v
	nvB28liZ6VQrUXH0fW8+daCwskjVcuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732116226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rbLMuMC2yYdzj3nG2I+d54+tseu9D8HIg5szJY41NA4=;
	b=HdAhwtR9MU3lDSTEQRB2OMAGN7JgHjx2Abe/4h/txkI83A6JxEtlfXQH8ZMOI+IWeeMt3b
	VZ6zBdLye5p+ciDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732116225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rbLMuMC2yYdzj3nG2I+d54+tseu9D8HIg5szJY41NA4=;
	b=0b3zeo0j+VtafXLc0T225LA1IjNvqKTPZ/CRcJikFUHJ5iu3wAjsEAc/P5ZDgC+9ahd9B5
	/D+4aYmI3snW2tlMNaAV9xjJJjneYf1nz+lpItqQAHsE1/K+CXkRwKxfXzdEDovsGV74Qg
	ku/qH818rb5j37Zp7MosU5oIZ1guFSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732116225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rbLMuMC2yYdzj3nG2I+d54+tseu9D8HIg5szJY41NA4=;
	b=B4SowmnVqbIass1asF76dEX9d8zqNh3zp6d6fd6iTT36FOV6OlKGA/cqGiiD3+t+32YUJ7
	eIjeek0E4JGTxWBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FA5213297;
	Wed, 20 Nov 2024 15:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id js5nEwH/PWfzQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Nov 2024 15:23:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5D1AA08A2; Wed, 20 Nov 2024 16:23:40 +0100 (CET)
Date: Wed, 20 Nov 2024 16:23:40 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 09/19] fsnotify: generate pre-content permission event
 on truncate
Message-ID: <20241120152340.gu7edmtm2j3lmxoy@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <23af8201db6ac2efdea94f09ab067d81ba5de7a7.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23af8201db6ac2efdea94f09ab067d81ba5de7a7.1731684329.git.josef@toxicpanda.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 15-11-24 10:30:22, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Generate FS_PRE_ACCESS event before truncate, without sb_writers held.
> 
> Move the security hooks also before sb_start_write() to conform with
> other security hooks (e.g. in write, fallocate).
> 
> The event will have a range info of the page surrounding the new size
> to provide an opportunity to fill the conetnt at the end of file before
> truncating to non-page aligned size.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I was thinking about this. One small issue is that similarly as the
filesystems may do RMW of tail page during truncate, they will do RMW of
head & tail pages on hole punch or zero range so we should have some
strategically sprinkled fsnotify_truncate_perm() calls there as well.
That's easy enough to fix.

But there's another problem which I'm more worried about: If we have
a file 64k large, user punches 12k..20k and then does read for 0..64k, then
how does HSM daemon in userspace know what data to fill in? When we'll have
modify pre-content event, daemon can watch it and since punch will send modify
for 12k-20k, the daemon knows the local (empty) page cache is the source of
truth. But without modify event this is just a recipe for data corruption
AFAICT.

So it seems the current setting with access pre-content event has only chance
to work reliably in read-only mode? So we should probably refuse writeable
open if file is being watched for pre-content events and similarly refuse
truncate?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

