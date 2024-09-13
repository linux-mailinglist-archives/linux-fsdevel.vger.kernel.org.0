Return-Path: <linux-fsdevel+bounces-29330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75D978227
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 16:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B301F26AC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE461DC18D;
	Fri, 13 Sep 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYkIZXRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F01DB95A;
	Fri, 13 Sep 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236157; cv=none; b=Y6JfOYpwScAfAH/8YOjMwxcS8MTH3v5PXt17px21ZNYUTE2WuZOnjHpRr4rgxi5wPPIs0KhlZHU2WV5l/YlJtkQbowhOXpbBOr5LPFRAaWkzqhZjliIiqaZymspj0jh52mewWWWdPQokXDq6prKKwdD0+TuRKEXGMofQfNrago4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236157; c=relaxed/simple;
	bh=t2Ui/SX4AxPA+ilhCL7nQu41U9EfcHzmNFaUUk1q8Is=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qdApsv+OKDuOuHYlu46rao/5Wkq2pCp2LVAp9KDYbnCNrPkhX0dNpuSpyicSkUYzSZNvHVCviqKDWkA2RfxgYP/HbxUTX1wGKpq5DVf/QfC2lhdFpyhY4KqddYzF6yZ+y9yRjwE5T/5BMBx3svlVl2sQ0Ap+KIfnWHZAIRexLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYkIZXRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167E9C4CEC0;
	Fri, 13 Sep 2024 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726236156;
	bh=t2Ui/SX4AxPA+ilhCL7nQu41U9EfcHzmNFaUUk1q8Is=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OYkIZXRTi49O5Zq64sitpXZgQwX0h94kLimMQ8lorTxH+cTU0HEeN5ghRmpBLz8hM
	 ukRc7I+HdO+g0dPxSxCnkqO1kHJoPgQ66Brl4Djx8cZuj0bC1PmFW+pl//7g6iDAB+
	 KxnIlS+wEfr745xM44VQRFH2YsExJezUgMiMwuqYALSNjuOoqfjKuX1+7V/kcT6JU0
	 AjGJ91nkgLsnmzOcNJVYpQg59SkOHukaylhRRhDdDpTJY/0U4bIkPvSs8uF5jQDSEy
	 4LPMCJ8oI0wal4EUN2fpwMlwL4TdJJIGPE7DlHKqtejXGy1WSeqrD21LX1WxJLLZUA
	 D/irB37RwbSQg==
Message-ID: <de5a3a21ceb5fa59de64443807e3bafa1a003a13.camel@kernel.org>
Subject: Re: [PATCH v7 05/11] fs: tracepoints around multigrain timestamp
 events
From: Jeff Layton <jlayton@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,  Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Chuck Lever
 <chuck.lever@oracle.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date: Fri, 13 Sep 2024 10:02:32 -0400
In-Reply-To: <20240913-mgtime-v7-5-92d4020e3b00@kernel.org>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
	 <20240913-mgtime-v7-5-92d4020e3b00@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-13 at 09:54 -0400, Jeff Layton wrote:
> Add some tracepoints around various multigrain timestamp events.
>=20
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c                       |   6 ++
>  fs/stat.c                        |   3 +
>  include/trace/events/timestamp.h | 124 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 133 insertions(+)
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index 260a8a1c1096..d19f70422a5d 100644
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
> =20
>  /*
> @@ -2598,6 +2601,7 @@ EXPORT_SYMBOL(inode_nohighmem);
> =20
>  struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct time=
spec64 ts)
>  {
> +	trace_inode_set_ctime_to_ts(inode, &ts);
>  	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
>  	inode->i_ctime_sec =3D ts.tv_sec;
>  	inode->i_ctime_nsec =3D ts.tv_nsec;
> @@ -2683,6 +2687,7 @@ struct timespec64 inode_set_ctime_current(struct in=
ode *inode)
> =20
>  	/* No need to cmpxchg if it's exactly the same */
>  	if (cns =3D=3D now.tv_nsec && inode->i_ctime_sec =3D=3D now.tv_sec)
> +		trace_ctime_xchg_skip(inode, &now);
>  		goto out;

I just realized I sent out an earlier version that has the above bug in
it (missing curly braces). The version I tested, and the version in my
public tree have this bug fixed.

>  	cur =3D cns;
>  retry:
> @@ -2690,6 +2695,7 @@ struct timespec64 inode_set_ctime_current(struct in=
ode *inode)
>  	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now.tv_nsec)) {
>  		/* If swap occurred, then we're (mostly) done */
>  		inode->i_ctime_sec =3D now.tv_sec;
> +		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
>  	} else {
>  		/*
>  		 * Was the change due to someone marking the old ctime QUERIED?
> diff --git a/fs/stat.c b/fs/stat.c
> index a449626fd460..9eb6d9b2d010 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -23,6 +23,8 @@
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
> =20
> +#include <trace/events/timestamp.h>
> +
>  #include "internal.h"
>  #include "mount.h"
> =20
> @@ -52,6 +54,7 @@ void fill_mg_cmtime(struct kstat *stat, u32 request_mas=
k, struct inode *inode)
>  	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
>  		stat->ctime.tv_nsec =3D ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
>  	stat->ctime.tv_nsec &=3D ~I_CTIME_QUERIED;
> +	trace_fill_mg_cmtime(inode, &stat->ctime, &stat->mtime);
>  }
>  EXPORT_SYMBOL(fill_mg_cmtime);
> =20
> diff --git a/include/trace/events/timestamp.h b/include/trace/events/time=
stamp.h
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
> +		__entry->dev		=3D inode->i_sb->s_dev;
> +		__entry->ino		=3D inode->i_ino;
> +		__entry->gen		=3D inode->i_generation;
> +		__entry->ctime_s	=3D ctime->tv_sec;
> +		__entry->ctime_ns	=3D ctime->tv_nsec;
> +	),
> +
> +	TP_printk("ino=3D%d:%d:%ld:%u ctime=3D%lld.%u",
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
> +		__entry->dev		=3D inode->i_sb->s_dev;
> +		__entry->ino		=3D inode->i_ino;
> +		__entry->gen		=3D inode->i_generation;
> +		__entry->old		=3D old;
> +		__entry->new		=3D new;
> +		__entry->cur		=3D cur;
> +	),
> +
> +	TP_printk("ino=3D%d:%d:%ld:%u old=3D%u:%s new=3D%u cur=3D%u:%s",
> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
> +		__entry->old & ~I_CTIME_QUERIED,
> +		__print_flags(__entry->old & I_CTIME_QUERIED, "|", CTIME_QUERIED_FLAGS=
),
> +		__entry->new,
> +		__entry->cur & ~I_CTIME_QUERIED,
> +		__print_flags(__entry->cur & I_CTIME_QUERIED, "|", CTIME_QUERIED_FLAGS=
)
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
> +		__entry->dev		=3D inode->i_sb->s_dev;
> +		__entry->ino		=3D inode->i_ino;
> +		__entry->gen		=3D inode->i_generation;
> +		__entry->ctime_s	=3D ctime->tv_sec;
> +		__entry->mtime_s	=3D mtime->tv_sec;
> +		__entry->ctime_ns	=3D ctime->tv_nsec;
> +		__entry->mtime_ns	=3D mtime->tv_nsec;
> +	),
> +
> +	TP_printk("ino=3D%d:%d:%ld:%u ctime=3D%lld.%u mtime=3D%lld.%u",
> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
> +		__entry->ctime_s, __entry->ctime_ns,
> +		__entry->mtime_s, __entry->mtime_ns
> +	)
> +);
> +#endif /* _TRACE_TIMESTAMP_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
>=20

--=20
Jeff Layton <jlayton@kernel.org>

