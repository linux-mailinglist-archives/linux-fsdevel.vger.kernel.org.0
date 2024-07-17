Return-Path: <linux-fsdevel+bounces-23819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB3933C54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 13:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0D5283069
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB4117F50A;
	Wed, 17 Jul 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rykqp0CY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQV+/WdD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rykqp0CY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQV+/WdD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355812E48;
	Wed, 17 Jul 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215900; cv=none; b=LeucVaHtcJl444bdCJWsUwL4hoAcGZ9CcY7Q34Pzesb75XtAZ5c9QWmln1LTrg9m127Tdi2WZziT5FQrRYlTbj0iJF3RVJrsRLwWcbLonKNVRhwArOPUqhFbnj787RwX5I27MNUZ472CSLZBbs7E1x+R76rOn9ySkBq/T8s1Yhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215900; c=relaxed/simple;
	bh=C09a0DDosOVNcklWN3W/ZdaKgvfbgXSiHfyoidPujm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XahlvW5hk2aEJJ3OFGXlPwYeVHqoRQubMCFXJNjI95nupNZvp3FLVjqT/VlmQbsbdf3tW4sbQ3Wn+rLGi3mxlqu80szY5lERu05KYHpfn6MMW3yLu2mfWJyy7blLNGK8xb03uCqI/BkMywKwcirmnMtgq2bVL7+kMzEnaGtGZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rykqp0CY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQV+/WdD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rykqp0CY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQV+/WdD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21DB321A8E;
	Wed, 17 Jul 2024 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721215897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pw5IFteg62fADv1t8c9j1uoPtsRwzO5/xi3gHqXwEVA=;
	b=Rykqp0CYm0hFK3gJ1goLxjFMrOjs+3P+N+YdNngEw3rvNGXmZW5O8enAii/Et6SAyjUNz1
	BBy3VCfbtg+A9r48c9EqAyKM3pt9BX6I2EtTQWQS2hQaEERp30v5EsF6mspRCNdyWJtgXH
	/4FnemB4Tv336YPKjbj+C68/MGnjBTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721215897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pw5IFteg62fADv1t8c9j1uoPtsRwzO5/xi3gHqXwEVA=;
	b=WQV+/WdDh8I/zwwwpRq/2aYepPcMfGhbrdMTUHCYiHV9Z+sJ/Q6ftIuEgAfnhQTlaVKGFy
	Tq6+pHrlKiUsXNBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721215897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pw5IFteg62fADv1t8c9j1uoPtsRwzO5/xi3gHqXwEVA=;
	b=Rykqp0CYm0hFK3gJ1goLxjFMrOjs+3P+N+YdNngEw3rvNGXmZW5O8enAii/Et6SAyjUNz1
	BBy3VCfbtg+A9r48c9EqAyKM3pt9BX6I2EtTQWQS2hQaEERp30v5EsF6mspRCNdyWJtgXH
	/4FnemB4Tv336YPKjbj+C68/MGnjBTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721215897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pw5IFteg62fADv1t8c9j1uoPtsRwzO5/xi3gHqXwEVA=;
	b=WQV+/WdDh8I/zwwwpRq/2aYepPcMfGhbrdMTUHCYiHV9Z+sJ/Q6ftIuEgAfnhQTlaVKGFy
	Tq6+pHrlKiUsXNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14191136E5;
	Wed, 17 Jul 2024 11:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gw7gBJmrl2YPTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 11:31:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8636A0987; Wed, 17 Jul 2024 13:31:32 +0200 (CEST)
Date: Wed, 17 Jul 2024 13:31:32 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 5/9] Documentation: add a new file documenting
 multigrain timestamps
Message-ID: <20240717113132.dvzsczxjr67224bx@quack3>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-5-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-mgtime-v6-5-48e5d34bd2ba@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,oracle.com,mit.edu,dilger.ca,fb.com,toxicpanda.com,suse.com,google.com,linux-foundation.org,lwn.net,fromorbit.com,linux.intel.com,infradead.org,gmail.com,linux.dev,arndb.de,vger.kernel.org,kvack.org];
	R_RATELIMIT(0.00)[to_ip_from(RLj8qd95s75qu36yfn9qkwxfo3)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 15-07-24 08:48:56, Jeff Layton wrote:
> Add a high-level document that describes how multigrain timestamps work,
> rationale for them, and some info about implementation and tradeoffs.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

One comment below. With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +Implementation Notes
> +====================
> +Multigrain timestamps are intended for use by local filesystems that get
> +ctime values from the local clock. This is in contrast to network filesystems
> +and the like that just mirror timestamp values from a server.
> +
> +For most filesystems, it's sufficient to just set the FS_MGTIME flag in the
> +fstype->fs_flags in order to opt-in, providing the ctime is only ever set via
> +inode_set_ctime_current(). If the filesystem has a ->getattr routine that
> +doesn't call generic_fillattr, then you should have it call fill_mg_cmtime to
> +fill those values.

I think you should explicitely mention that ->setattr() implementation
needs to use setattr_copy() or otherwise mimic its behavior...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

