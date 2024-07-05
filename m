Return-Path: <linux-fsdevel+bounces-23242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B036928D50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F9B1C20FF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294DF16DEB8;
	Fri,  5 Jul 2024 18:07:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F061B963;
	Fri,  5 Jul 2024 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202828; cv=none; b=JROGI2Pe4oMYwoNCj/SykV701vLEpTTxR5XtjB1xtnfTF5L67cDiBj5Pj0lrBwYF/wtEKYAiTy+85yJtosnBAQf8AbJQHR5pyWLQhAGsPoH0wQ1hyng3e2IagiNBzPcD9J/C4DZz3VaFrIILMwFzQ0bV8wxiPc3tnjLhTLKly2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202828; c=relaxed/simple;
	bh=Oc/jgpqXPZQsOpR4owl6eghnOaQJB98ynfgwFW5b0+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTqHljNtLRF6VoNHGsCtDo4voDsfq3KjLgt8KIRCYumG7D5bARuhjj7K/oDkMXzsp+jWBf4fq/br5Wv43TE3EwR5FfFnabPUd/U+Ca2H6rnUWXx9Bc5lfGwAfIengT0c2BUS5CUSbivDAXfcXZfGXZhhldPYOFuXo2EvUhLx+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1470CC116B1;
	Fri,  5 Jul 2024 18:07:05 +0000 (UTC)
Date: Fri, 5 Jul 2024 14:07:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Jonathan
 Corbet <corbet@lwn.net>, Dave Chinner <david@fromorbit.com>, Andi Kleen
 <ak@linux.intel.com>, Christoph Hellwig <hch@infradead.org>,
 kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/9] fs: tracepoints around multigrain timestamp
 events
Message-ID: <20240705140703.711d816b@rorschach.local.home>
In-Reply-To: <20240705-mgtime-v3-2-85b2daa9b335@kernel.org>
References: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
	<20240705-mgtime-v3-2-85b2daa9b335@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Jul 2024 13:02:36 -0400
Jeff Layton <jlayton@kernel.org> wrote:

> diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
> new file mode 100644
> index 000000000000..a004e5572673
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
> +		__field(u32,			gen)

It's best to keep the above 4 byte word below 8 byte words, otherwise,
it will likely create a 4 byte hole in between.

> +		__field(time64_t,		ctime_s)
> +		__field(u32,			ctime_ns)
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
> +		__field(u32,			gen)

Same here.

-- Steve

> +		__field(time64_t,		ctime_s)
> +		__field(time64_t,		mtime_s)
> +		__field(u32,			ctime_ns)
> +		__field(u32,			mtime_ns)
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


