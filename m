Return-Path: <linux-fsdevel+bounces-59653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4016B3BD14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCA81C87111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0409531E0E2;
	Fri, 29 Aug 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qpBy2cT9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vs1Ao6hH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qpBy2cT9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vs1Ao6hH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1D31DDAC
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476176; cv=none; b=NC+bDG4OXimpUiNMj9oQaEtf7Nv6HDwYJIUGcNgjiMsmgwp5tK2ArLyr1cdHRG4aHmP6KgotlDwlkkQjhlzzK5FL0RXoxT9qsGqHYTNFIBnsHVYTL4gaDqlhZA/w2KmW9WX5dCeFikqvmpUsgA2v8+2S/lWRbiqZibYXwHH82nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476176; c=relaxed/simple;
	bh=O/P3Y6x+fwDSwTIRg7CVfYOSwCRPvQ4Or8YJ56ji69U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmY9w92HUEGyov22FcrNtY7uwXXu2zCcGIeWR7jwzXBzKtYgFjUN1hHmkPtC7rSnIqgS51YPmEhjeGxL02utNpqrpEp08igQZ+UVfrVh9/sbdRpGLcnkIUjLh3kKlcAzdo6VIDh9QZrgy4aTVoh8uZEHNApp1zdRwh+HXCQeM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qpBy2cT9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vs1Ao6hH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qpBy2cT9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vs1Ao6hH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12F7C33EA5;
	Fri, 29 Aug 2025 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756476173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25KwhLTVgnlDPGtEA39iYvvgByiLDv4XbDT0g4bQ8dM=;
	b=qpBy2cT9WYM04TiwM6xJn7XUHzeZUsuzcwFjxv775SW6i7wl/IfrIuMXLu7pffzEhHz8Mo
	yIS0S0cWRINr7eq4sxwcRbTS6naS/sfFR48rEkb197DxSfxzIG0BTlEfgje5Ckbppwdmnx
	Np2qgzXafD4DE43NpeeP+md+31RXEfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756476173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25KwhLTVgnlDPGtEA39iYvvgByiLDv4XbDT0g4bQ8dM=;
	b=vs1Ao6hHnS8baKmc7v5u9G/CjU5ZQoMS8n4htU+RerXf/iMihlN+noohyzkHY65T+lg6ko
	yy3FVRea31gk5oCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756476173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25KwhLTVgnlDPGtEA39iYvvgByiLDv4XbDT0g4bQ8dM=;
	b=qpBy2cT9WYM04TiwM6xJn7XUHzeZUsuzcwFjxv775SW6i7wl/IfrIuMXLu7pffzEhHz8Mo
	yIS0S0cWRINr7eq4sxwcRbTS6naS/sfFR48rEkb197DxSfxzIG0BTlEfgje5Ckbppwdmnx
	Np2qgzXafD4DE43NpeeP+md+31RXEfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756476173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25KwhLTVgnlDPGtEA39iYvvgByiLDv4XbDT0g4bQ8dM=;
	b=vs1Ao6hHnS8baKmc7v5u9G/CjU5ZQoMS8n4htU+RerXf/iMihlN+noohyzkHY65T+lg6ko
	yy3FVRea31gk5oCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0574113A3E;
	Fri, 29 Aug 2025 14:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g+pPAQ2zsWgADAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 29 Aug 2025 14:02:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B8F6A099C; Fri, 29 Aug 2025 16:02:52 +0200 (CEST)
Date: Fri, 29 Aug 2025 16:02:52 +0200
From: Jan Kara <jack@suse.cz>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <fkq7gvtjqx4jilgu75nbmckmwdndl7d7fzljuycqfzmvumdft2@jiycade6gzgo>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <5a4513fe-6eae-9269-c235-c8b0bc1ae05b@ispras.ru>
 <20250829-diskette-landbrot-aa01bc844435@brauner>
 <e7110cd2-289a-127e-a8c1-f191e346d38d@ispras.ru>
 <20250829-therapieren-datteln-13c31741c856@brauner>
 <9d492620-1a58-68c0-2b47-c8b16c99b113@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d492620-1a58-68c0-2b47-c8b16c99b113@ispras.ru>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

Hello!

On Fri 29-08-25 14:45:57, Alexander Monakov wrote:
> On Fri, 29 Aug 2025, Christian Brauner wrote:
> 
> > > > Even if we fix this there's no guarantee that the kernel will give that
> > > > letting the close() of a writably opened file race against a concurrent
> > > > exec of the same file will not result in EBUSY in some arcane way
> > > > currently or in the future.
> > > 
> > > Forget Go and execve. Take the two-process scenario from my last email.
> > > The program waiting on flock shouldn't be able to observe elevated
> > > refcounts on the file after the lock is released. It matters not only
> > > for execve, but also for unmounting the underlying filesystem, right?
> > 
> > What? No. How?: with details, please.
> 
> Apologies if there's a misunderstanding on my side, but put_file_access
> does file_put_write_access, which in turn does
> 
>   mnt_put_write_access(file->f_path.mnt);
> 
> and I think elevated refcount on mnt will cause -EBUSY from mnt_hold_writers.
> Which is then checked in mnt_make_readonly. I expect it affects unmount too,
> just don't see exactly where.

Umount (may_umount_tree()) looks at mnt->mnt_count which is decremented by
mntput() completely at the end of __fput(). I tend to agree with Christian
here: We've never promised that all effects of open fd are cleaned up
before the flock is released and as Christian explained it will be actually
pretty hard to implement such behavior. So attempts to wait for fd to close
by waiting for its flock are racy...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

