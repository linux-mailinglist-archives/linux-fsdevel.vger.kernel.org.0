Return-Path: <linux-fsdevel+bounces-24707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC09435F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 20:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A142861A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D46E3BBCC;
	Wed, 31 Jul 2024 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xyz6Jvuj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yBcX3K7I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xyz6Jvuj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yBcX3K7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945C3EA7B;
	Wed, 31 Jul 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722452137; cv=none; b=Mrz9LWVwClVymKW+Wu3G3Oi/wf4UlDBLPqTtVy4cbEopy15QWWRNosUuIlN5XjjKRJfaBHCoNUOMahmvLEvzHhxwQM8UMH2pQ436rQjAKoSEZeGRCZMZadigiCusO31XFcMoLt9gddCchyG3knI89F2nfb8ezJCMm5dwvyGjs8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722452137; c=relaxed/simple;
	bh=qLpcPNc16mkmNZ6kSpRud/btM2MhXwutqHpT/kyYWlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiHyDBmdT6CNmFQOB1RV/8tRvpIXw2QyD2y767bjHFhjkT593nza1xB74Lz/bsH3wSsomPnhzXO0VF5s54RvJk4RxhdxvAdT8RyWuEQ9FBO/zWoY/3KtqaQOl9J4CgDP8gm7pXPNnXtJvh1AB8xgK0s7gqCTbcaKpiI9omQuBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xyz6Jvuj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yBcX3K7I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xyz6Jvuj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yBcX3K7I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E4FE1F7DD;
	Wed, 31 Jul 2024 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722452134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0IZ7ZUmb7INFT1/45ErVsk1h5z33WoNIioMosoZ9z9o=;
	b=xyz6Jvuji2yyJ4Hj741SRKuDfV/cYKqEL++M1+IRycV3rCiYyAW/qeNZL/YshGl7pvpn3t
	gmSwgD7TxgGrdjP1gkOGD2BgNc4PUg6jVfI2HuJf76KVdtV2as2n/7FBw6Pxyb/fGE8EcT
	9aqEfT3CObY+vKkULjxFtslmD1+81uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722452134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0IZ7ZUmb7INFT1/45ErVsk1h5z33WoNIioMosoZ9z9o=;
	b=yBcX3K7IR+BEIkm7jpjkMgcJonfi/4XRFqK+W/8GOy+q7pFuO6cFNFjVE/btwcU89AcAwC
	ADuvAhoXGK8SntBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722452134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0IZ7ZUmb7INFT1/45ErVsk1h5z33WoNIioMosoZ9z9o=;
	b=xyz6Jvuji2yyJ4Hj741SRKuDfV/cYKqEL++M1+IRycV3rCiYyAW/qeNZL/YshGl7pvpn3t
	gmSwgD7TxgGrdjP1gkOGD2BgNc4PUg6jVfI2HuJf76KVdtV2as2n/7FBw6Pxyb/fGE8EcT
	9aqEfT3CObY+vKkULjxFtslmD1+81uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722452134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0IZ7ZUmb7INFT1/45ErVsk1h5z33WoNIioMosoZ9z9o=;
	b=yBcX3K7IR+BEIkm7jpjkMgcJonfi/4XRFqK+W/8GOy+q7pFuO6cFNFjVE/btwcU89AcAwC
	ADuvAhoXGK8SntBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E50CB13297;
	Wed, 31 Jul 2024 18:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cn/mN6WIqmbwPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 31 Jul 2024 18:55:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 76FDDA0873; Wed, 31 Jul 2024 20:55:25 +0200 (CEST)
Date: Wed, 31 Jul 2024 20:55:25 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>,
	netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <20240731185525.gr3pgswzdvoqla2g@quack3>
References: <20240723104533.mznf3svde36w6izp@quack3>
 <2136178.1721725194@warthog.procyon.org.uk>
 <2147168.1721743066@warthog.procyon.org.uk>
 <20240724133009.6st3vmk5ondigbj7@quack3>
 <20240729-gespickt-negativ-c1ce987e3c07@brauner>
 <20240731181657.dprkkq5jxgatgx2v@quack3>
 <ZqqCH0wvHjpVrsQl@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqqCH0wvHjpVrsQl@casper.infradead.org>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Wed 31-07-24 19:27:43, Matthew Wilcox wrote:
> On Wed, Jul 31, 2024 at 08:16:57PM +0200, Jan Kara wrote:
> > To fix this, either we'd have to keep the lower cache filesystem private to
> > cachefiles (but I don't think that works with the usecases) or we have to
> > somehow untangle this mmap_lock knot. This "page fault does quite some fs
> > locking under mmap_lock" problem is not causing filesystems headaches for
> > the first time. I would *love* to be able to always drop mmap_lock in the
> > page fault handler, fill the data into the page cache and then retry the
> > fault (so that filemap_map_pages() would then handle the fault without
> > filesystem involvement). It would make many things in filesystem locking
> > simpler. As far as I'm checking there are now not that many places that
> > could not handle dropping of mmap_lock during fault (traditionally the
> > problem is with get_user_pages() / pin_user_pages() users). So maybe this
> > dream would be feasible after all.
> 
> The traditional problem was the array of VMAs which was removed in
> commit b2cac248191b -- if we dropped the mmap_lock, any previous
> entries in that array would become invalid.  Now that array is gone,
> do we have any remaining dependencies on the VMAs remaining valid?

So as far as I've checked the callers of get_user_pages() /
pin_user_pages() I didn't find any that fundamentally could not handle
dropping of mmap_lock. So at least for callers I've seen it was mostly
about teaching them to handle dropped mmap_lock, reacquire it and possibly
reestablish some state which could get invalidated after the mmap_lock got
dropped.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

