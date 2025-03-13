Return-Path: <linux-fsdevel+bounces-43940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6458DA60160
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 20:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA293BDC96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 19:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF471F180F;
	Thu, 13 Mar 2025 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aqn7Wia5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xad97b2T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePbZHaT9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ngZET5/w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4017E
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894767; cv=none; b=raiLzx5bkm2pf4x9jx4ChyqO3bzJ6SkMJp7OqdkloisNwpZVt9wY63/0Cj3PKRxAsC6aKpdvXP72ZMU2+qYrFSYmB5DfY6mPvY9d1dNMfL6lcrJYIcx6WZ4Oe/C39mUR+3ZJ5hY63JPjc+etJiqxGRETHAfqjTaB9c29nxYBVVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894767; c=relaxed/simple;
	bh=W5rqcBUU4A1GxojTCKfuA2CDXxVz5Eb40FIjXZS7e7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p45th7p3QKJvoUcZ/u5sHGqO32TKPpQJQdiW81VTr3kO4+nzCF5uW09G8/6yh4T+mDgQ0cMD6SNN1379kP0+DTzBoqlXYn/cd/eB5SZLZiC6HJG607kANsZ8JBQuQDqSBoaFgmIWE8Ye2Sc2Z40UdbeTEKGF9X87UkUOo4Mf49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aqn7Wia5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xad97b2T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePbZHaT9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ngZET5/w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBA651F452;
	Thu, 13 Mar 2025 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741894764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3g4m4zOVwiEvi4EmgmPX97xtAJuoXPNo9SqpSIXoirI=;
	b=aqn7Wia5Ke1hJRpNUq45DR8AGlrvnEFyBsRcqx1qpa1MsJCZVWYv1e9tamfp6Y6AJTtpdd
	Av5y4W9SKxpBLx5EjmliLE23ulFBaAeWLY/3nZq6Dj1IPVNLiWfGZwtuX4QPkD546aq2fX
	Fj2rJLaqk5ot1ajScBGMYUnjPe3VBw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741894764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3g4m4zOVwiEvi4EmgmPX97xtAJuoXPNo9SqpSIXoirI=;
	b=xad97b2THzYHu4VLp/2Jh0qES0Z6GqxUqaiXvG/C7A4j+GPjSrE6Vh9mbHX9m3KDDz4/wz
	uRKQtcjfrFcecMDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741894762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3g4m4zOVwiEvi4EmgmPX97xtAJuoXPNo9SqpSIXoirI=;
	b=ePbZHaT9EtA4gKg6WXRs/EP9PmB+vB/dh94i7uiT23QdM/lLJjnUP2aDdV1IXyvCgn37+9
	gbLojKl90/vzIGGi09dUbmqn71fC2ESGJSBcpEuSm1nIK1lvtzSPEvM13RjA7NDcluzVwJ
	gSkLyG2jdotMdJ+BAAowTf/qje8uELs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741894762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3g4m4zOVwiEvi4EmgmPX97xtAJuoXPNo9SqpSIXoirI=;
	b=ngZET5/wiQbhlnxLPPbFWOGpCzW3AJrADOFXOz77+M25JbkqxfkvsYmUMRghfboLAhTGwt
	FgEglODxukLJhYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C17CC137BA;
	Thu, 13 Mar 2025 19:39:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R+7uLmo002fLZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Mar 2025 19:39:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72FB1A0908; Thu, 13 Mar 2025 20:39:22 +0100 (CET)
Date: Thu, 13 Mar 2025 20:39:22 +0100
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, David Bueso <dave@stgolabs.net>, 
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Kundan Kumar <kundan.kumar@samsung.com>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	anuj20.g@samsung.com, joshi.k@samsung.com, axboe@kernel.dk, clm@meta.com, 
	willy@infradead.org, gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <xghvunpvjoizxpwskv3oidfif7cyvfgmt252cjm6jco6rhgas6@ou44xipkevfh>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
 <Z6GAYFN3foyBlUxK@dread.disaster.area>
 <20250204050642.GF28103@lst.de>
 <s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
 <Z6qkLjSj1K047yPt@dread.disaster.area>
 <Z9HIoJZmuVsyXdh9@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9HIoJZmuVsyXdh9@bombadil.infradead.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 12-03-25 10:47:12, Luis Chamberlain wrote:
> On Tue, Feb 11, 2025 at 12:13:18PM +1100, Dave Chinner wrote:
> > Should we be looking towards using a subset of the existing list_lru
> > functionality for writeback contexts here? i.e. create a list_lru
> > object with N-way scalability, allow the fs to provide an
> > inode-number-to-list mapping function, and use the list_lru
> > interfaces to abstract away everything physical and cgroup related
> > for tracking dirty inodes?
> > 
> > Then selecting inodes for writeback becomes a list_lru_walk()
> > variant depending on what needs to be written back (e.g. physical
> > node, memcg, both, everything that is dirty everywhere, etc).
> 
> I *suspect* you're referring to abstracting or sharing the sharding
> to numa node functionality of list_lru so we can, divide objects
> to numa nodes in similar ways for different use cases?
> 
> Because list_lru is about reclaim, not writeback, but from my reading
> the list_lru sharding to numa nodes was the golden nugget to focus on.

Dave was speaking of list_lru mostly as an example how we have a structure
that is both memcg aware and has N-way parallelism built in it (for NUMA
nodes). For writeback we need something similar - we already have cgroup
awareness and now you want to add N-way parallelism. So the idea was that
we could possibly create a generic structure supporting this usable for
both. But details matter here for what ends up being practical...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

