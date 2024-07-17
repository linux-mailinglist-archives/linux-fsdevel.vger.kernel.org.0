Return-Path: <linux-fsdevel+bounces-23815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1075933B4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 12:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E172282D2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5849417F399;
	Wed, 17 Jul 2024 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oTKHx2L8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pfGB4npr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oTKHx2L8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pfGB4npr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E809374C2;
	Wed, 17 Jul 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212883; cv=none; b=PgkKPOqmNYbA35Yd2PxYC5cWbdpiwGtjJjzsDdx63l+sinfIlO/wuYQ9rU4MHcdPSOAZID5EknLyUJi4Bsuldj7CBpiPj/h6pvOJ7HmeYlULD4fFtr7GOoJWnDbcJiW7G1v8g6XtU6cUS2O3MpqqlgQO8cNsG7Mrixm0VH6rvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212883; c=relaxed/simple;
	bh=l2ppxymtiEhVJbXhIuwQJz3aAYnS6gqFa8AVKm0WuZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaRmNCvBnDAyHHC1C3yW5iqFtHzCur4+GE6woLwFLP+pEEF7e1opmrTgp7o1tTVKDxDsKvk/wyMrSn0oH1u5fQuo2+NYW+I0j+m7gTIP6oD/0Hu/mpveOFxXwFi6eA0eulRJ63kE8Gh3gVZSu4fBtRdM0CIwBH8wMdg6+/SQgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oTKHx2L8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pfGB4npr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oTKHx2L8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pfGB4npr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89D1A21A9E;
	Wed, 17 Jul 2024 10:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721212879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2ui/vrqRVAs0oMeUTqmjYepPx593ly2bAOb8JPcJug=;
	b=oTKHx2L8y1hRRlptUqoJ3I9Bacyr9uK8yy4Q92EVVXnp30jE6nurIE7D8Sh8jUVc5scBXu
	UMEjTsFh31W2w4L/77g+vAiIvzRL5HBJQ0bNGArj8jlwFCXcDOuuZ5wXYSMtku07ccMND2
	erlnboNb+63wfgkUxV5PhU63yXhKV5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721212879;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2ui/vrqRVAs0oMeUTqmjYepPx593ly2bAOb8JPcJug=;
	b=pfGB4npreHfAnms5QFcoauLHwzcPj3Itpb5vclITu0+eewCtmiuKjgiL1QKd8GhDnLA4pL
	Fq1kn1woIGFCuKBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oTKHx2L8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pfGB4npr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721212879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2ui/vrqRVAs0oMeUTqmjYepPx593ly2bAOb8JPcJug=;
	b=oTKHx2L8y1hRRlptUqoJ3I9Bacyr9uK8yy4Q92EVVXnp30jE6nurIE7D8Sh8jUVc5scBXu
	UMEjTsFh31W2w4L/77g+vAiIvzRL5HBJQ0bNGArj8jlwFCXcDOuuZ5wXYSMtku07ccMND2
	erlnboNb+63wfgkUxV5PhU63yXhKV5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721212879;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2ui/vrqRVAs0oMeUTqmjYepPx593ly2bAOb8JPcJug=;
	b=pfGB4npreHfAnms5QFcoauLHwzcPj3Itpb5vclITu0+eewCtmiuKjgiL1QKd8GhDnLA4pL
	Fq1kn1woIGFCuKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 756D81368F;
	Wed, 17 Jul 2024 10:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V0aqHM+fl2byPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 10:41:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 232CEA0987; Wed, 17 Jul 2024 12:41:19 +0200 (CEST)
Date: Wed, 17 Jul 2024 12:41:19 +0200
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
Subject: Re: [PATCH v6 2/9] fs: tracepoints around multigrain timestamp events
Message-ID: <20240717104119.qoatft3q3d2qu6mh@quack3>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-2-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-mgtime-v6-2-48e5d34bd2ba@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLm8ftxcjxomczyd9jc9seq4h9)];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,oracle.com,mit.edu,dilger.ca,fb.com,toxicpanda.com,suse.com,google.com,linux-foundation.org,lwn.net,fromorbit.com,linux.intel.com,infradead.org,gmail.com,linux.dev,arndb.de,vger.kernel.org,kvack.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,toxicpanda.com:email,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 89D1A21A9E

On Mon 15-07-24 08:48:53, Jeff Layton wrote:
> Add some tracepoints around various multigrain timestamp events.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c                       |   9 ++-
>  fs/stat.c                        |   3 +
>  include/trace/events/timestamp.h | 124 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 417acbeabef3..869994285e87 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -22,6 +22,9 @@
>  #include <linux/iversion.h>
>  #include <linux/rw_hint.h>
>  #include <trace/events/writeback.h>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/timestamp.h>
> +
>  #include "internal.h"
>  
>  /*
> @@ -2569,6 +2572,7 @@ EXPORT_SYMBOL(inode_nohighmem);
>  
>  struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
>  {
> +	trace_inode_set_ctime_to_ts(inode, &ts);
>  	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
>  	inode->i_ctime_sec = ts.tv_sec;
>  	inode->i_ctime_nsec = ts.tv_nsec;
> @@ -2668,13 +2672,16 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
>  	cur = cns;
>  
>  	/* No need to cmpxchg if it's exactly the same */
> -	if (cns == now_ts.tv_nsec && inode->i_ctime_sec == now_ts.tv_sec)
> +	if (cns == now_ts.tv_nsec && inode->i_ctime_sec == now_ts.tv_sec) {
> +		trace_ctime_xchg_skip(inode, &now_ts);
>  		goto out;
> +	}
>  retry:
>  	/* Try to swap the nsec value into place. */
>  	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now_ts.tv_nsec)) {
>  		/* If swap occurred, then we're (mostly) done */
>  		inode->i_ctime_sec = now_ts.tv_sec;
> +		trace_ctime_ns_xchg(inode, cns, now_ts.tv_nsec, cur);
>  	} else {
>  		/*
>  		 * Was the change due to someone marking the old ctime QUERIED?
> diff --git a/fs/stat.c b/fs/stat.c
> index df7fdd3afed9..552dfd67688b 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -23,6 +23,8 @@
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
>  
> +#include <trace/events/timestamp.h>
> +
>  #include "internal.h"
>  #include "mount.h"
>  
> @@ -49,6 +51,7 @@ void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
>  	stat->mtime = inode_get_mtime(inode);
>  	stat->ctime.tv_sec = inode->i_ctime_sec;
>  	stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn)) & ~I_CTIME_QUERIED;
> +	trace_fill_mg_cmtime(inode, &stat->ctime, &stat->mtime);
>  }
>  EXPORT_SYMBOL(fill_mg_cmtime);
>  
> diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
> new file mode 100644
> index 000000000000..c9e5ec930054
> --- /dev/null
> +++ b/include/trace/events/timestamp.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM timestamp
> +
> +#if !defined(_TRACE_TIMESTAMP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_TIMESTAMP_H
> +
> +#include <linux/tracepoint.h>
> +#include <linux/fs.h>
> +
> +#define CTIME_QUERIED_FLAGS \
> +	{ I_CTIME_QUERIED, "Q" }
> +
> +DECLARE_EVENT_CLASS(ctime,
> +	TP_PROTO(struct inode *inode,
> +		 struct timespec64 *ctime),
> +
> +	TP_ARGS(inode, ctime),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,		dev)
> +		__field(ino_t,		ino)
> +		__field(time64_t,	ctime_s)
> +		__field(u32,		ctime_ns)
> +		__field(u32,		gen)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= inode->i_sb->s_dev;
> +		__entry->ino		= inode->i_ino;
> +		__entry->gen		= inode->i_generation;
> +		__entry->ctime_s	= ctime->tv_sec;
> +		__entry->ctime_ns	= ctime->tv_nsec;
> +	),
> +
> +	TP_printk("ino=%d:%d:%ld:%u ctime=%lld.%u",
> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
> +		__entry->ctime_s, __entry->ctime_ns
> +	)
> +);
> +
> +DEFINE_EVENT(ctime, inode_set_ctime_to_ts,
> +		TP_PROTO(struct inode *inode,
> +			 struct timespec64 *ctime),
> +		TP_ARGS(inode, ctime));
> +
> +DEFINE_EVENT(ctime, ctime_xchg_skip,
> +		TP_PROTO(struct inode *inode,
> +			 struct timespec64 *ctime),
> +		TP_ARGS(inode, ctime));
> +
> +TRACE_EVENT(ctime_ns_xchg,
> +	TP_PROTO(struct inode *inode,
> +		 u32 old,
> +		 u32 new,
> +		 u32 cur),
> +
> +	TP_ARGS(inode, old, new, cur),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,		dev)
> +		__field(ino_t,		ino)
> +		__field(u32,		gen)
> +		__field(u32,		old)
> +		__field(u32,		new)
> +		__field(u32,		cur)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= inode->i_sb->s_dev;
> +		__entry->ino		= inode->i_ino;
> +		__entry->gen		= inode->i_generation;
> +		__entry->old		= old;
> +		__entry->new		= new;
> +		__entry->cur		= cur;
> +	),
> +
> +	TP_printk("ino=%d:%d:%ld:%u old=%u:%s new=%u cur=%u:%s",
> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
> +		__entry->old & ~I_CTIME_QUERIED,
> +		__print_flags(__entry->old & I_CTIME_QUERIED, "|", CTIME_QUERIED_FLAGS),
> +		__entry->new,
> +		__entry->cur & ~I_CTIME_QUERIED,
> +		__print_flags(__entry->cur & I_CTIME_QUERIED, "|", CTIME_QUERIED_FLAGS)
> +	)
> +);
> +
> +TRACE_EVENT(fill_mg_cmtime,
> +	TP_PROTO(struct inode *inode,
> +		 struct timespec64 *ctime,
> +		 struct timespec64 *mtime),
> +
> +	TP_ARGS(inode, ctime, mtime),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,		dev)
> +		__field(ino_t,		ino)
> +		__field(time64_t,	ctime_s)
> +		__field(time64_t,	mtime_s)
> +		__field(u32,		ctime_ns)
> +		__field(u32,		mtime_ns)
> +		__field(u32,		gen)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= inode->i_sb->s_dev;
> +		__entry->ino		= inode->i_ino;
> +		__entry->gen		= inode->i_generation;
> +		__entry->ctime_s	= ctime->tv_sec;
> +		__entry->mtime_s	= mtime->tv_sec;
> +		__entry->ctime_ns	= ctime->tv_nsec;
> +		__entry->mtime_ns	= mtime->tv_nsec;
> +	),
> +
> +	TP_printk("ino=%d:%d:%ld:%u ctime=%lld.%u mtime=%lld.%u",
> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
> +		__entry->ctime_s, __entry->ctime_ns,
> +		__entry->mtime_s, __entry->mtime_ns
> +	)
> +);
> +#endif /* _TRACE_TIMESTAMP_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

