Return-Path: <linux-fsdevel+bounces-63951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC7EBD2DDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24EBF4ECDA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 11:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3962118E20;
	Mon, 13 Oct 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LHzybpyB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qgh3oEVH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ME29yvbc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+GQ6nB/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9E25A343
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356703; cv=none; b=S1eqQt9gsh6Gp3CK6jf02lVELX8ATIiVwvXe7Cmmr69m++QQVTdURvCrUGi/fk3KBtx+mcAaj8n0kiRcgFfJAvwjKX9G+T3mSdZGjT+OPOLTZuWPKnlh/63S8tzJIeJPjqwQqh3u8ItntoWFWetUJgthxsIWkpyMoWhPSiSDQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356703; c=relaxed/simple;
	bh=1/voeyOH+3bfRyIpXxZZWKU2x+V7cyuKOmi/1F1Wyzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHPgcYyCIFxY6sai0BCxAvPrcWEg80DaUHI+QMkP+mEZ1wXSvU5pilr6VpP8BYZvGM/MNK8eYm+gpVYLDaTs+zBf7zoEeYMZ1awI+QCIn3Ybmw0O9DT3FgKGRMdDlAs9R8tR5shxY9aeWquYz8iB7i1rp+eXntuDMjGtgsM7ZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LHzybpyB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qgh3oEVH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ME29yvbc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+GQ6nB/u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D99E2219AB;
	Mon, 13 Oct 2025 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760356700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPZNntVP7wQ8uxjyDhXSga5p6bLX+QQQQkULf/eXU6Q=;
	b=LHzybpyB0GLJakHDKi3v7mSUdW9sAkVSckJjEIYU7uionamZ8B8jl1KTbGeKT00iy1lEuI
	WKI43I0cicxVj/CLUtuUgnH8+OkMsKb5FLUoSmCTkm7TMt+dSjcvbp5TsWFGzuPh567c2G
	38FD0LDh/nHQBeFHEXPf32xy4RS8GrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760356700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPZNntVP7wQ8uxjyDhXSga5p6bLX+QQQQkULf/eXU6Q=;
	b=Qgh3oEVHWWIesaXhtgPESImlj3Mbme3RyXo8inUKxZESl8DLVG9QTAg2Lti/jFyfIiiau9
	B2fY66kOepwpv7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760356699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPZNntVP7wQ8uxjyDhXSga5p6bLX+QQQQkULf/eXU6Q=;
	b=ME29yvbcQ/MbJF53rFA6iT5e32yP3OhIHjaDcaOMTyWZug0IIw6GrktxYOOzwhwmM5fvV3
	nd3sCEW/6Ew1uGaomnCVpxSwK+mYoJmrdqoxHaAiBwEyOjz7ZRKy2dyNZh1KXf3D8oSUzU
	zLvv73wixItoXsvggoNyAvHt5BKHaDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760356699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPZNntVP7wQ8uxjyDhXSga5p6bLX+QQQQkULf/eXU6Q=;
	b=+GQ6nB/uGXVIcxmT+F8khHkzFYthRB5g+YdjO+rW4+iS7ALtG00KT8SsjWel7sDbDJ1Yih
	7Mnz5AnHeYOb11Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6F3213874;
	Mon, 13 Oct 2025 11:58:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zHCMMFvp7GgCAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Oct 2025 11:58:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72419A0A58; Mon, 13 Oct 2025 13:58:15 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:58:15 +0200
From: Jan Kara <jack@suse.cz>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, 
	linux-block@vger.kernel.org, v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 06/10] mm,btrfs: add a filemap_fdatawrite_kick_nr helper
Message-ID: <4bcpiwrhbrraau7nlp6mxbffprtnlv3piqyn7xkm7j2txxqlmn@3knyilc526ts>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-7-hch@lst.de>
 <74593bac-929b-4496-80e0-43d0f54d6b4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74593bac-929b-4496-80e0-43d0f54d6b4c@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,lst.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 13-10-25 17:01:01, Damien Le Moal wrote:
> On 2025/10/13 11:58, Christoph Hellwig wrote:
> > Abstract out the btrfs-specific behavior of kicking off I/O on a number
> > of pages on an address_space into a well-defined helper.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> One nit below.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> 
> > +/*
> > + * Start writeback on @nr_to_write pages from @mapping.  No one but the existing
> > + * btrfs caller should be using this.  Talk to linux-mm if you think adding a
> > + * new caller is a good idea.
> > + */
> > +int filemap_fdatawrite_kick_nr(struct address_space *mapping, long *nr_to_write)
> 
> Not a huge fan of this name. Maybe filemap_fdatawrite_nrpages() ?

I don't love filemap_fdatawrite_kick_nr() either. Your
filemap_fdatawrite_nrpages() is better but so far we had the distinction
that filemap_fdatawrite* is for data integrity writeback and filemap_flush
is for memory cleaning writeback. And in some places this is important
distinction which I'd like to keep obvious in the naming. So I'd prefer
something like filemap_flush_nrpages() (to stay consistent with previous
naming) or if Christoph doesn't like flush (as that's kind of overloaded
word) we could have filemap_writeback_nrpages().

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

