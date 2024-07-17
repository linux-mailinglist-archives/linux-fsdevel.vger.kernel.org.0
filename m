Return-Path: <linux-fsdevel+bounces-23816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03971933B5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 12:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B9928248D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A50F17F39B;
	Wed, 17 Jul 2024 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NXEoNWIr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D2s2Mus8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NXEoNWIr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D2s2Mus8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12FD1878;
	Wed, 17 Jul 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213134; cv=none; b=pctoTmTPVWPMcViJrsGZmUH4ucf/rec3QNMB4XNoR6tr97L/T94cHRSQpW4canGAo/DeDTIhb/7jeMOo4OeJYjSNJIfYAOtNo+krO2G+3azfnIDY1VdoCXFTwlEdda7+cNg84iC7Fbs9mGWNCpGL4rdofPK66KjHkmKNDab9zkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213134; c=relaxed/simple;
	bh=uV+fDQn88X3vnR+XxSw6byf2vCKZ+uDB8ZwLx44BKVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5RkzyWDnaIIL2QrX3mGCnoGJ0jmNpNBPMWLcFX1CG970DDsQQxdtfrX8HMkBtoBsT09RBsoG+TvSa0yE408w66PjB0ULLfrF0lmGG2rVKFBaXN0V5pTYkZyE72Fz8hrWP16QbcofbjpkieTzMpAp4Njm3oiZkDWV+vsi8WK0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NXEoNWIr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D2s2Mus8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NXEoNWIr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D2s2Mus8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC95C21AD9;
	Wed, 17 Jul 2024 10:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721213129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Adt/6cBqLwRHyr8UQVS3UnG6hzRhRyNq17HOAaUZaBI=;
	b=NXEoNWIr8RJn9ENN8tA+q+U4jDUQbtD6U5C8lZQAYPclxqaKnGMlAc43QDjZJOFBx3scJG
	gtop9XeixSUysfF4x1FulabpRQQH/QKKDiGVaTxZe4EqZSBsLFnvW19kH+DGetWN0d0IIn
	QPzPBgiT5mgwTp5q9CnlZXIblylU68c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721213129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Adt/6cBqLwRHyr8UQVS3UnG6hzRhRyNq17HOAaUZaBI=;
	b=D2s2Mus8uWJyer+c/zFjhkdFHl3yM3Ha3PQXE5bASzZExkNhY3xoZENUpRI0HFLblJJ0Wp
	gfzhUTvYU5xoq8Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NXEoNWIr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D2s2Mus8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721213129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Adt/6cBqLwRHyr8UQVS3UnG6hzRhRyNq17HOAaUZaBI=;
	b=NXEoNWIr8RJn9ENN8tA+q+U4jDUQbtD6U5C8lZQAYPclxqaKnGMlAc43QDjZJOFBx3scJG
	gtop9XeixSUysfF4x1FulabpRQQH/QKKDiGVaTxZe4EqZSBsLFnvW19kH+DGetWN0d0IIn
	QPzPBgiT5mgwTp5q9CnlZXIblylU68c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721213129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Adt/6cBqLwRHyr8UQVS3UnG6hzRhRyNq17HOAaUZaBI=;
	b=D2s2Mus8uWJyer+c/zFjhkdFHl3yM3Ha3PQXE5bASzZExkNhY3xoZENUpRI0HFLblJJ0Wp
	gfzhUTvYU5xoq8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB2181368F;
	Wed, 17 Jul 2024 10:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZULCKcmgl2YdPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 10:45:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 091B0A0987; Wed, 17 Jul 2024 12:45:25 +0200 (CEST)
Date: Wed, 17 Jul 2024 12:45:24 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
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
Subject: Re: [PATCH v6 3/9] fs: add percpu counters for significant
 multigrain timestamp events
Message-ID: <20240717104524.tqlz63tsrdfixmxh@quack3>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-3-48e5d34bd2ba@kernel.org>
 <20240715183211.GD103014@frogsfrogsfrogs>
 <7bb897f31fded59aae8d62a6796dd21feebd0642.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bb897f31fded59aae8d62a6796dd21feebd0642.camel@kernel.org>
X-Rspamd-Queue-Id: BC95C21AD9
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,goodmis.org,efficios.com,oracle.com,mit.edu,dilger.ca,fb.com,toxicpanda.com,suse.com,google.com,linux-foundation.org,lwn.net,fromorbit.com,linux.intel.com,infradead.org,gmail.com,linux.dev,arndb.de,vger.kernel.org,kvack.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Mon 15-07-24 15:53:42, Jeff Layton wrote:
> On Mon, 2024-07-15 at 11:32 -0700, Darrick J. Wong wrote:
> > On Mon, Jul 15, 2024 at 08:48:54AM -0400, Jeff Layton wrote:
> > > Four percpu counters for counting various stats around mgtimes, and
> > > a
> > > new debugfs file for displaying them:
> > > 
> > > - number of attempted ctime updates
> > > - number of successful i_ctime_nsec swaps
> > > - number of fine-grained timestamp fetches
> > > - number of floor value swaps
> > > 
> > > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/inode.c | 70
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 69 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index 869994285e87..fff844345c35 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -21,6 +21,8 @@
> > >  #include <linux/list_lru.h>
> > >  #include <linux/iversion.h>
> > >  #include <linux/rw_hint.h>
> > > +#include <linux/seq_file.h>
> > > +#include <linux/debugfs.h>
> > >  #include <trace/events/writeback.h>
> > >  #define CREATE_TRACE_POINTS
> > >  #include <trace/events/timestamp.h>
> > > @@ -80,6 +82,10 @@ EXPORT_SYMBOL(empty_aops);
> > >  
> > >  static DEFINE_PER_CPU(unsigned long, nr_inodes);
> > >  static DEFINE_PER_CPU(unsigned long, nr_unused);
> > > +static DEFINE_PER_CPU(unsigned long, mg_ctime_updates);
> > > +static DEFINE_PER_CPU(unsigned long, mg_fine_stamps);
> > > +static DEFINE_PER_CPU(unsigned long, mg_floor_swaps);
> > > +static DEFINE_PER_CPU(unsigned long, mg_ctime_swaps);
> > 
> > Should this all get switched off if CONFIG_DEBUG_FS=n?
> > 
> > --D
> > 
> 
> Sure, why not. That's simple enough to do.
> 
> I pushed an updated mgtime branch to my git tree. Here's the updated
> patch that's the only difference:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?h=mgtime&id=ee7fe6e9c0598754861c8620230f15f3de538ca5
> 
> Seems to build OK both with and without CONFIG_DEBUG_FS.

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

>  
> > >  
> > >  static struct kmem_cache *inode_cachep __ro_after_init;
> > >  
> > > @@ -101,6 +107,42 @@ static inline long get_nr_inodes_unused(void)
> > >  	return sum < 0 ? 0 : sum;
> > >  }
> > >  
> > > +static long get_mg_ctime_updates(void)
> > > +{
> > > +	int i;
> > > +	long sum = 0;
> > > +	for_each_possible_cpu(i)
> > > +		sum += per_cpu(mg_ctime_updates, i);
> > > +	return sum < 0 ? 0 : sum;
> > > +}
> > > +
> > > +static long get_mg_fine_stamps(void)
> > > +{
> > > +	int i;
> > > +	long sum = 0;
> > > +	for_each_possible_cpu(i)
> > > +		sum += per_cpu(mg_fine_stamps, i);
> > > +	return sum < 0 ? 0 : sum;
> > > +}
> > > +
> > > +static long get_mg_floor_swaps(void)
> > > +{
> > > +	int i;
> > > +	long sum = 0;
> > > +	for_each_possible_cpu(i)
> > > +		sum += per_cpu(mg_floor_swaps, i);
> > > +	return sum < 0 ? 0 : sum;
> > > +}
> > > +
> > > +static long get_mg_ctime_swaps(void)
> > > +{
> > > +	int i;
> > > +	long sum = 0;
> > > +	for_each_possible_cpu(i)
> > > +		sum += per_cpu(mg_ctime_swaps, i);
> > > +	return sum < 0 ? 0 : sum;
> > > +}
> > > +
> > >  long get_nr_dirty_inodes(void)
> > >  {
> > >  	/* not actually dirty inodes, but a wild approximation */
> > > @@ -2655,6 +2697,7 @@ struct timespec64
> > > inode_set_ctime_current(struct inode *inode)
> > >  
> > >  			/* Get a fine-grained time */
> > >  			fine = ktime_get();
> > > +			this_cpu_inc(mg_fine_stamps);
> > >  
> > >  			/*
> > >  			 * If the cmpxchg works, we take the new
> > > floor value. If
> > > @@ -2663,11 +2706,14 @@ struct timespec64
> > > inode_set_ctime_current(struct inode *inode)
> > >  			 * as good, so keep it.
> > >  			 */
> > >  			old = floor;
> > > -			if (!atomic64_try_cmpxchg(&ctime_floor,
> > > &old, fine))
> > > +			if (atomic64_try_cmpxchg(&ctime_floor,
> > > &old, fine))
> > > +				this_cpu_inc(mg_floor_swaps);
> > > +			else
> > >  				fine = old;
> > >  			now = ktime_mono_to_real(fine);
> > >  		}
> > >  	}
> > > +	this_cpu_inc(mg_ctime_updates);
> > >  	now_ts = timestamp_truncate(ktime_to_timespec64(now),
> > > inode);
> > >  	cur = cns;
> > >  
> > > @@ -2682,6 +2728,7 @@ struct timespec64
> > > inode_set_ctime_current(struct inode *inode)
> > >  		/* If swap occurred, then we're (mostly) done */
> > >  		inode->i_ctime_sec = now_ts.tv_sec;
> > >  		trace_ctime_ns_xchg(inode, cns, now_ts.tv_nsec,
> > > cur);
> > > +		this_cpu_inc(mg_ctime_swaps);
> > >  	} else {
> > >  		/*
> > >  		 * Was the change due to someone marking the old
> > > ctime QUERIED?
> > > @@ -2751,3 +2798,24 @@ umode_t mode_strip_sgid(struct mnt_idmap
> > > *idmap,
> > >  	return mode & ~S_ISGID;
> > >  }
> > >  EXPORT_SYMBOL(mode_strip_sgid);
> > > +
> > > +static int mgts_show(struct seq_file *s, void *p)
> > > +{
> > > +	long ctime_updates = get_mg_ctime_updates();
> > > +	long ctime_swaps = get_mg_ctime_swaps();
> > > +	long fine_stamps = get_mg_fine_stamps();
> > > +	long floor_swaps = get_mg_floor_swaps();
> > > +
> > > +	seq_printf(s, "%lu %lu %lu %lu\n",
> > > +		   ctime_updates, ctime_swaps, fine_stamps,
> > > floor_swaps);
> > > +	return 0;
> > > +}
> > > +
> > > +DEFINE_SHOW_ATTRIBUTE(mgts);
> > > +
> > > +static int __init mg_debugfs_init(void)
> > > +{
> > > +	debugfs_create_file("multigrain_timestamps", S_IFREG |
> > > S_IRUGO, NULL, NULL, &mgts_fops);
> > > +	return 0;
> > > +}
> > > +late_initcall(mg_debugfs_init);
> > > 
> > > -- 
> > > 2.45.2
> > > 
> > > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

