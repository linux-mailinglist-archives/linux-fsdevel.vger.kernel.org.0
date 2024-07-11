Return-Path: <linux-fsdevel+bounces-23584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6364A92ED11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 18:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870231C20F8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F616DC1D;
	Thu, 11 Jul 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv/+KMwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF116D9C5;
	Thu, 11 Jul 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716592; cv=none; b=WpTGg/QKVGptVq4gepESPT5uyDueFCOZX0F1KCFWEObHmp3wPmyPowSn73buovYNDd8PfExrVWoWZ7qQJSyQ3LU0g4e6kJc2o7C9RgCBDR7Gstp/4kFizDo9pOl1XopAR0eZLJe743XHA89NKZTz6Hq+TQXAgLzBi6t/iAQL2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716592; c=relaxed/simple;
	bh=nWhL6EXYhTkVqK9dFWpYTLeNOOo5aCjD/1lHMwkWh+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o54ZPrzf/UuciTCP8OftC5zCBONs9KYLsSjl5lkWa9eymBl6FMBq6//NXOP6wn6yiQNe88AbZcjREI55YV3QSA212YI9aw8LXFZvuzLzA77idGWSeKf9etS9D6l4Pl64zGwDbgQXEm7MpYCcBPr94P8AuP0VHeA+66a7r/qPULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vv/+KMwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C392C32786;
	Thu, 11 Jul 2024 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720716591;
	bh=nWhL6EXYhTkVqK9dFWpYTLeNOOo5aCjD/1lHMwkWh+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vv/+KMwm3A+1L8H7wRVjO0quMqAC2RPxeHrKzqk3F5O1xzjrykIITxwF0c5BBIRlV
	 +nsO+MOsO3n9Vxcy2Oib9socUnIGKDGe5CAwEtasHiPMPnBC/s6IY1Xg2WrZYpZxAd
	 iTjSAD09XwaDN9wCiSuzt1IsSnKhplzvF01rPA1/06sT/m2oPn59VtnH39Ei5t/hoU
	 00auPqDi1rNPJQP6LDhgb8eLR5JrP2dAFFj6A4NEptuoAReMTXqQysBu6EwyIAp4DJ
	 6kdMqU1jfBJgrnBsuSPirRgGTikbMcFL4F05wbr/iLvgI88NlKqWoP1OVWd4b8CATV
	 anlgPNgJXHwFQ==
Date: Thu, 11 Jul 2024 09:49:50 -0700
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
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/9] fs: tracepoints around multigrain timestamp events
Message-ID: <20240711164950.GO612460@frogsfrogsfrogs>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
 <20240711-mgtime-v5-2-37bb5b465feb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-mgtime-v5-2-37bb5b465feb@kernel.org>

On Thu, Jul 11, 2024 at 07:08:06AM -0400, Jeff Layton wrote:
> Add some tracepoints around various multigrain timestamp events.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c                       |   5 ++
>  fs/stat.c                        |   3 ++
>  include/trace/events/timestamp.h | 109 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 2b5889ff7b36..81b45e0a95a6 100644
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
> @@ -2571,6 +2574,7 @@ struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 t
>  {
>  	inode->i_ctime_sec = ts.tv_sec;
>  	inode->i_ctime_nsec = ts.tv_nsec & ~I_CTIME_QUERIED;
> +	trace_inode_set_ctime_to_ts(inode, &ts);
>  	return ts;
>  }
>  EXPORT_SYMBOL(inode_set_ctime_to_ts);
> @@ -2670,6 +2674,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
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
> index 000000000000..3a603190b46c
> --- /dev/null
> +++ b/include/trace/events/timestamp.h
> @@ -0,0 +1,109 @@
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
> +TRACE_EVENT(inode_set_ctime_to_ts,
> +	TP_PROTO(struct inode *inode,
> +		 struct timespec64 *ctime),
> +
> +	TP_ARGS(inode, ctime),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,			dev)
> +		__field(ino_t,			ino)
> +		__field(time64_t,		ctime_s)
> +		__field(u32,			ctime_ns)
> +		__field(u32,			gen)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= inode->i_sb->s_dev;

Odd indenting of the second columns between the struct definition above
and the assignment code here.

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
> +TRACE_EVENT(ctime_ns_xchg,
> +	TP_PROTO(struct inode *inode,
> +		 u32 old,
> +		 u32 new,
> +		 u32 cur),
> +
> +	TP_ARGS(inode, old, new, cur),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,				dev)
> +		__field(ino_t,				ino)
> +		__field(u32,				gen)
> +		__field(u32,				old)
> +		__field(u32,				new)
> +		__field(u32,				cur)
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
> +	TP_printk("ino=%d:%d:%ld:%u old=%u:%c new=%u cur=%u:%c",
> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
> +		__entry->old & ~I_CTIME_QUERIED, __entry->old & I_CTIME_QUERIED ? 'Q' : '-',
> +		__entry->new,
> +		__entry->cur & ~I_CTIME_QUERIED, __entry->cur & I_CTIME_QUERIED ? 'Q' : '-'

This /might/ be overkill for a single flag, but anything you put in the
TP_printk seems to end up in the format file:

# cat /sys/kernel/debug/tracing/events/xfs/xfbtree_create_root_buf/format
name: xfbtree_create_root_buf
ID: 1644
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:unsigned long xfino;      offset:8;       size:8; signed:0;
        field:xfs_daddr_t bno;  offset:16;      size:8; signed:1;
        field:int nblks;        offset:24;      size:4; signed:1;
        field:int hold; offset:28;      size:4; signed:1;
        field:int pincount;     offset:32;      size:4; signed:1;
        field:unsigned int lockval;     offset:36;      size:4; signed:0;
        field:unsigned int flags;       offset:40;      size:4; signed:0;

print fmt: "xfino 0x%lx daddr 0x%llx bbcount 0x%x hold %d pincount %d lock %d flags %s", REC->xfino, (unsigned long long)REC->bno, REC->nblks, REC->hold, REC->pincount, REC->lockval, __print_flags(REC->flags, "|", { (1u << 0), "READ" }, { (1u << 1), "WRITE" }, { (1u << 2), "READ_AHEAD" }, { (1u << 3), "NO_IOACCT" }, { (1u << 4), "ASYNC" }, { (1u << 5), "DONE" }, { (1u << 6), "STALE" }, { (1u << 7), "WRITE_FAIL" }, { (1u << 16), "INODES" }, { (1u << 17), "DQUOTS" }, { (1u << 18), "LOG_RECOVERY" }, { (1u << 20), "PAGES" }, { (1u << 21), "KMEM" }, { (1u << 22), "DELWRI_Q" }, { (1u << 28), "LIVESCAN" }, { (1u << 29), "INCORE" }, { (1u << 30), "TRYLOCK" }, { (1u << 31), "UNMAPPED" })

I /think/ all that code gets compiled (interpreted?) as if it were C
code, but a more compact format might be:

#define CTIME_QUERIED_FLAGS \
	{ I_CTIME_QUERIED, "queried" }

	TP_printk("ino=%d:%d:%ld:%u old=%u:%s new=%u cur=%u:%c",
		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
		__entry->old & ~I_CTIME_QUERIED,
		__print_flags(__entry->old & I_CTIME_QUERIED, "|",
			      CTIME_QUERIED_FLAGS),
		...

But, again, that could be overkill for a single flag.  Aside from my
minor bikeshedding, this all looks good, and I like that we can now
monitor what's going on wrt ctime. :)

--D

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
> +		__field(dev_t,			dev)
> +		__field(ino_t,			ino)
> +		__field(time64_t,		ctime_s)
> +		__field(time64_t,		mtime_s)
> +		__field(u32,			ctime_ns)
> +		__field(u32,			mtime_ns)
> +		__field(u32,			gen)
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

