Return-Path: <linux-fsdevel+bounces-30662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C91C98CFDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 11:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFC01F21D26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E95198E79;
	Wed,  2 Oct 2024 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KVecqr+N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBYEfZoW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KVecqr+N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBYEfZoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842519752C;
	Wed,  2 Oct 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727860455; cv=none; b=qnqavttWXH8ESa47458m1Ua9CtA+d9S7Mh7D2849lw9AxMno7VDeGJT5zpg0DlgafA2l6sJucAqZuhukicdAUB7e6y6IWlf5ZJIfPaUVSnKWD+1b+ACihmUWOn6c9KkwhSCN0BbFw0UfrX0U1i6XBNQTcqI/sA8+xjCDIuN3Vu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727860455; c=relaxed/simple;
	bh=CrBCKdgiMa08UPFj6MZxE0JaOv9NlkupQgNyP+8YPHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvQ1gwix5LEVonisx8PYPUjv6rX+6KHit2BKYMz0dSISxGuUA5r0rTqxe+n2XG0WrW9DzSwFIoN7kO2iRtiejUdc2O+O5TDo/FhGFlGnhLvpRmoWIutOu5EqLIdh5vpNFBRe3wMUVl2ODHAggbhVetOImaZWJalqizUiVoUTh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KVecqr+N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBYEfZoW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KVecqr+N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBYEfZoW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3042721B70;
	Wed,  2 Oct 2024 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727860446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciY4s211AtNsmLMEFppWW09ynC9Vd3xoRhyo0YMhjdc=;
	b=KVecqr+NBI1yiYx1BRcvKKnoyXIivh15+piF+YZyiWfrDIRo6SsuQJrxd8RL6jhFpnJG3g
	bXyd/69TLuagh7zkintkdg6FnyOvc8kIouzsWt4Uad7lwiaHv6mwQM+0iwyXWjl4MXpXU1
	4xUac63Ufy/zn/WHxi5yMhRCoLEzkNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727860446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciY4s211AtNsmLMEFppWW09ynC9Vd3xoRhyo0YMhjdc=;
	b=vBYEfZoWDP05pmDCLOTbylMr+FqLkg7Ki23XcVZOBFd4msaAsoqBKQbkafeu2FG7KWktRV
	3NqfRi0Nn6eFECAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727860446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciY4s211AtNsmLMEFppWW09ynC9Vd3xoRhyo0YMhjdc=;
	b=KVecqr+NBI1yiYx1BRcvKKnoyXIivh15+piF+YZyiWfrDIRo6SsuQJrxd8RL6jhFpnJG3g
	bXyd/69TLuagh7zkintkdg6FnyOvc8kIouzsWt4Uad7lwiaHv6mwQM+0iwyXWjl4MXpXU1
	4xUac63Ufy/zn/WHxi5yMhRCoLEzkNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727860446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciY4s211AtNsmLMEFppWW09ynC9Vd3xoRhyo0YMhjdc=;
	b=vBYEfZoWDP05pmDCLOTbylMr+FqLkg7Ki23XcVZOBFd4msaAsoqBKQbkafeu2FG7KWktRV
	3NqfRi0Nn6eFECAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FA9613A6E;
	Wed,  2 Oct 2024 09:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4XuwB94O/WYUSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Oct 2024 09:14:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8280EA08CB; Wed,  2 Oct 2024 11:14:05 +0200 (CEST)
Date: Wed, 2 Oct 2024 11:14:05 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v8 02/12] fs: add infrastructure for multigrain timestamps
Message-ID: <20241002091405.7b2s4qvoaqrn3l4f@quack3>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
 <20241001-mgtime-v8-2-903343d91bc3@kernel.org>
 <20241001132027.ynzp4sahjek5umbb@quack3>
 <7761de29d15df87a29575de57554b56a91ae55a0.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7761de29d15df87a29575de57554b56a91ae55a0.camel@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLy4jt9zmnbk4oncb1qwahh5jo)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 01-10-24 09:34:18, Jeff Layton wrote:
> On Tue, 2024-10-01 at 15:20 +0200, Jan Kara wrote:
> > > diff --git a/fs/stat.c b/fs/stat.c
> > > index 41e598376d7e..381926fb405f 100644
> > > --- a/fs/stat.c
> > > +++ b/fs/stat.c
> > > @@ -26,6 +26,35 @@
> > >  #include "internal.h"
> > >  #include "mount.h"
> > >  
> > > +/**
> > > + * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
> > > + * @stat: where to store the resulting values
> > > + * @request_mask: STATX_* values requested
> > > + * @inode: inode from which to grab the c/mtime
> > > + *
> > > + * Given @inode, grab the ctime and mtime out if it and store the result
> > 						 ^^ of
> > 
> > > + * in @stat. When fetching the value, flag it as QUERIED (if not already)
> > > + * so the next write will record a distinct timestamp.
> > > + */
> > > +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
> > > +{
> > 
> > Given how things worked out in the end, it seems this function doesn't need
> > to handle mtime at all and we can move mtime handling back to shared generic
> > code?
> > 
> 
> I don't think we can. The mtime is effectively derived from the ctime.
> 
> If I query only the mtime, I think it's reasonable to expect that it
> will change if there is another write, even if I don't query the ctime.
> We won't get that unless we can also set the flag in the ctime when
> only the mtime is requested.

Aha, right. I already forgot about this :). Can you please add to the
comment the above explanation so that we remember next time somebody wants
to "clean this up" like me ;)? Thanks!

Also feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

