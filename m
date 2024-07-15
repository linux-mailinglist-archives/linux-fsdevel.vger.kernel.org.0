Return-Path: <linux-fsdevel+bounces-23707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E3C931A46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6770B1C213AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AE1763E7;
	Mon, 15 Jul 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW8iEsT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EEC18B1A;
	Mon, 15 Jul 2024 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068149; cv=none; b=RWA4GzLrsoGBVzw8ivPnTuc7AxOpeh4zvy8X9U/oegLCYakTo9eK23aLrEY8u7OnyzPWMASuup7HvsN8ogsFvrXyW4UytgmqoEsn3p+qRKBzDe/IIJQR5KWVLKnkIr5GVyRu2KrB0bd+enPvNrl8/U6RUbVt70H44ckOCHaJ6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068149; c=relaxed/simple;
	bh=fTKTqXvODxiH14W2JlEV67Ic+f/odwUbY+RedfTGRAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc6nXXmvpDfxpPvqfQxPxU7giIyy7TeW/SQkE01TKDSN71xbRrBokSfBPW6ff0No7o4P9GXCt54Y4Az6hd5C+a94hZ93MvFTV4uqk9MZL7JFj7JZH71uUEplIv+AagH8XPzi+279c/AMtYSYxnnB7e2S6rJuamBLt5o2JEioc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW8iEsT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A1BC32782;
	Mon, 15 Jul 2024 18:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721068148;
	bh=fTKTqXvODxiH14W2JlEV67Ic+f/odwUbY+RedfTGRAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WW8iEsT27XWeAdUScm3j2X4Bh2cAg1X9i4WUdmMLYvtm9ybgPYTx6KiTuSgH7N6+N
	 uRRGguxn96doXRGES6t/+aL41zanbegNtxTe94PzaUzvk+MsN282U/5p/QrJdVZCud
	 e98mU4p6E/jmED8DQEMCu9sCfzUTGJ9eqdeBG8JHrq8y+WNOFEhOafoksGPn57SnkG
	 GQkGHC+LBsDIQt6i3/aaZrSBWGcfQKufk+E0zF75Zh8CGEBuW2p8EMiguxrSEIjM4n
	 zRzyhz/pyivD45aZtoqITSSGNIT32RoCiEoODnkQhVT4//xeBMEGcaLlcXpbe9IujP
	 XljTMyyAvBiVg==
Date: Mon, 15 Jul 2024 11:29:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH v6 2/9] fs: tracepoints around multigrain timestamp events
Message-ID: <20240715182908.GC103014@frogsfrogsfrogs>
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

On Mon, Jul 15, 2024 at 08:48:53AM -0400, Jeff Layton wrote:
> Add some tracepoints around various multigrain timestamp events.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Woot!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

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
> 

