Return-Path: <linux-fsdevel+bounces-28556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3968896BFB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18792829B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27821DA311;
	Wed,  4 Sep 2024 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ik+F1Hue";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rfphfVH6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ik+F1Hue";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rfphfVH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061B1CCEFC
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458956; cv=none; b=rdk2oh4PDtdCJ5dyXezY+7Jz4b41ZzCd/LsRtpsOV8Q8GQkswO3bux0HU59rUw7Bhwegt9jsepAvWTcuu8x0lYKPxqdgOJLCVH1yNb09iyZsFZtUYp0C0X0vR7zn9m0tb11K6atlKlEEWzQIMG5uYvzh9d2u36E3OuL6yKwRMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458956; c=relaxed/simple;
	bh=+Of4v0Bnk2cbb+TlYhn8x4fH7sXMv9fbhd7i7mDgiKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQvQirl8vx/LMrYRBB9a8LuvpIhTzK4QPn6M45O0rfN6z4H5QoZh5AN2teOr8BS4TsXyG1mSJKYmki0huoZrCG81nixWrlbaB79Qa5pQOpQzxj2NDoca3sEVxyOvdCREVi9cHV7Pso5drmJvM8QCqGuMYfKKO115Fy0g62d1Px8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ik+F1Hue; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rfphfVH6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ik+F1Hue; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rfphfVH6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64FAB21A0E;
	Wed,  4 Sep 2024 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725458952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPXNUzBL6vZi7R7k5lsFn7zJ0k7svHKgFftGzestuDE=;
	b=ik+F1HuegdjhcVrsqdOWKwtMfvb5b/92IE7oJjDgfV6YV28Qmb6oNIKqbAWnNM8CEOv0CD
	5cYKEFxWm1fTwQd2a0ZMiF++wqGy8irD9fBIc6ILV5cxrz4XE8VGlZAh8lTz+ZrDOuJjvj
	t4pQ3ivmBb/bThGKa7J6woCFHWSXEAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725458952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPXNUzBL6vZi7R7k5lsFn7zJ0k7svHKgFftGzestuDE=;
	b=rfphfVH6Iq8w1vlZr6L9U63q85V+mbR9PgCiggMiCY1z/eIwF2CnA6IrbcQXIT3VijZnaY
	ypZMzYi0Anre0fCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725458952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPXNUzBL6vZi7R7k5lsFn7zJ0k7svHKgFftGzestuDE=;
	b=ik+F1HuegdjhcVrsqdOWKwtMfvb5b/92IE7oJjDgfV6YV28Qmb6oNIKqbAWnNM8CEOv0CD
	5cYKEFxWm1fTwQd2a0ZMiF++wqGy8irD9fBIc6ILV5cxrz4XE8VGlZAh8lTz+ZrDOuJjvj
	t4pQ3ivmBb/bThGKa7J6woCFHWSXEAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725458952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPXNUzBL6vZi7R7k5lsFn7zJ0k7svHKgFftGzestuDE=;
	b=rfphfVH6Iq8w1vlZr6L9U63q85V+mbR9PgCiggMiCY1z/eIwF2CnA6IrbcQXIT3VijZnaY
	ypZMzYi0Anre0fCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AABF139D2;
	Wed,  4 Sep 2024 14:09:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4gIeFghq2GaecAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 14:09:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9F75A0968; Wed,  4 Sep 2024 16:08:56 +0200 (CEST)
Date: Wed, 4 Sep 2024 16:08:56 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 18/20] fs: add f_pipe
Message-ID: <20240904140856.xjtxavhicq4yjsme@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-18-6d3e4816aa7b@kernel.org>
 <20240903135055.jhcusfiopheb2jej@quack3>
 <20240903-ernst-besiedeln-e6c9e3f47ef6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-ernst-besiedeln-e6c9e3f47ef6@brauner>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 03-09-24 16:31:28, Christian Brauner wrote:
> On Tue, Sep 03, 2024 at 03:50:55PM GMT, Jan Kara wrote:
> > On Fri 30-08-24 15:04:59, Christian Brauner wrote:
> > > Only regular files with FMODE_ATOMIC_POS and directories need
> > > f_pos_lock. Place a new f_pipe member in a union with f_pos_lock
> > > that they can use and make them stop abusing f_version in follow-up
> > > patches.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > What makes me a bit uneasy is that we do mutex_init() on the space in
> > struct file and then pipe_open() will clobber it. And then we eventually
> > call mutex_destroy() on the clobbered mutex. I think so far this does no
> 
> We don't call mutex_destroy() on it and don't need to.

Ah, right, we don't bother with that for f_pos_lock.

> And calling mutex_init() is fine precisely because pipes do use it. It
> would be really ugly do ensure that mutex_init() isn't called for pipes.
> But I'll add a comment.

I'm not sure I understand what do you mean by "calling mutex_init() is fine
precisely because pipes do use it." Perhaps you meant "don't use it"?
Otherwise after looking at it for a while I agree the cure would be likely
worse than the disease so a comment is as good as it gets I guess.

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

