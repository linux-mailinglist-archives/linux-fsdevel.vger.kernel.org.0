Return-Path: <linux-fsdevel+bounces-23243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 623A4928D70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 20:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C99B24782
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAC216E888;
	Fri,  5 Jul 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLPsR7qd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969C262A8;
	Fri,  5 Jul 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203400; cv=none; b=k8TlCyQHl1WLpdhknTg095cw5SbqyvHgZ/fEppTK5aMZbMQRbJIsGQnM6WODetVTAxZeQgVgun4j3uNT2Y40xN6iG5IfqVNaEu3U2z9s29zrv+UNxPCuowGFviwdBSAVxTy0qzQDtNr40eNefCdtKkrzKr+2xknlRNih+A3k/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203400; c=relaxed/simple;
	bh=Bb5YnOqTQcdobdzl7rj7W0NcvDf4NfDGtBSkHIO+W6w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/PtC3bGEzlS3wzTLmPRAEEnS1PllDTTCYaBbCdBhiDxAHNC7TEehpOP7YpBHZzvO5n1PHfpqTB2B+NatMwnA772gSToh3NZ0kE4yc3rAotK/hoH/Tx6IahePoOguPu5gqOI2pjlSbe8h91xoNiN3yL/wEFTr47ATOzSu42REEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLPsR7qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102CCC116B1;
	Fri,  5 Jul 2024 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720203399;
	bh=Bb5YnOqTQcdobdzl7rj7W0NcvDf4NfDGtBSkHIO+W6w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aLPsR7qd6mwWpjFUGCb0nwvuwTVkmMS20f5hAZiWMd4QCcYinMZ/r1W5ELsmgp5vx
	 emKp/PejOwirkxKuck8UVQJyPxiHu/dET4c/vCdeUoiOiPC0ysq5uD5iQtqtzA8hrT
	 dmoikSOL1gvXvanXIVqgdBW55KxEBUt4XzW3j19rNE0B1Bbz8wFjGiylVmHqoXkzwj
	 bLlbfn0k2uv3rProwmqRKgAIt1str9zBcQUCKtkHPd1lNK0wFTwYzuJnKpjyGRFZS5
	 aig1U5Ej04DkG7JgGz7pADhdvyvewTZNU+zUFeHnLrUwSfnh5xED4ldUdIdw0IRb8X
	 JXn4dr/pltKUg==
Message-ID: <89658a8eb54acf4dc46da6dbb05c2007c5b8179a.camel@kernel.org>
Subject: Re: [PATCH v3 2/9] fs: tracepoints around multigrain timestamp
 events
From: Jeff Layton <jlayton@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger
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
Date: Fri, 05 Jul 2024 14:16:35 -0400
In-Reply-To: <20240705140703.711d816b@rorschach.local.home>
References: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
	 <20240705-mgtime-v3-2-85b2daa9b335@kernel.org>
	 <20240705140703.711d816b@rorschach.local.home>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-05 at 14:07 -0400, Steven Rostedt wrote:
> On Fri, 05 Jul 2024 13:02:36 -0400
> Jeff Layton <jlayton@kernel.org> wrote:
>=20
> > diff --git a/include/trace/events/timestamp.h
> > b/include/trace/events/timestamp.h
> > new file mode 100644
> > index 000000000000..a004e5572673
> > --- /dev/null
> > +++ b/include/trace/events/timestamp.h
> > @@ -0,0 +1,109 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM timestamp
> > +
> > +#if !defined(_TRACE_TIMESTAMP_H) ||
> > defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_TIMESTAMP_H
> > +
> > +#include <linux/tracepoint.h>
> > +#include <linux/fs.h>
> > +
> > +TRACE_EVENT(inode_set_ctime_to_ts,
> > +	TP_PROTO(struct inode *inode,
> > +		 struct timespec64 *ctime),
> > +
> > +	TP_ARGS(inode, ctime),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t,			dev)
> > +		__field(ino_t,			ino)
> > +		__field(u32,			gen)
>=20
> It's best to keep the above 4 byte word below 8 byte words,
> otherwise,
> it will likely create a 4 byte hole in between.
>=20

Thanks, I'll fix up both!

> > +		__field(time64_t,		ctime_s)
> > +		__field(u32,			ctime_ns)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		=3D inode->i_sb->s_dev;
> > +		__entry->ino		=3D inode->i_ino;
> > +		__entry->gen		=3D inode->i_generation;
> > +		__entry->ctime_s	=3D ctime->tv_sec;
> > +		__entry->ctime_ns	=3D ctime->tv_nsec;
> > +	),
> > +
> > +	TP_printk("ino=3D%d:%d:%ld:%u ctime=3D%lld.%u",
> > +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry-
> > >ino, __entry->gen,
> > +		__entry->ctime_s, __entry->ctime_ns
> > +	)
> > +);
> > +
> > +TRACE_EVENT(ctime_ns_xchg,
> > +	TP_PROTO(struct inode *inode,
> > +		 u32 old,
> > +		 u32 new,
> > +		 u32 cur),
> > +
> > +	TP_ARGS(inode, old, new, cur),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t,				dev)
> > +		__field(ino_t,				ino)
> > +		__field(u32,				gen)
> > +		__field(u32,				old)
> > +		__field(u32,				new)
> > +		__field(u32,				cur)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		=3D inode->i_sb->s_dev;
> > +		__entry->ino		=3D inode->i_ino;
> > +		__entry->gen		=3D inode->i_generation;
> > +		__entry->old		=3D old;
> > +		__entry->new		=3D new;
> > +		__entry->cur		=3D cur;
> > +	),
> > +
> > +	TP_printk("ino=3D%d:%d:%ld:%u old=3D%u:%c new=3D%u cur=3D%u:%c",
> > +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry-
> > >ino, __entry->gen,
> > +		__entry->old & ~I_CTIME_QUERIED, __entry->old &
> > I_CTIME_QUERIED ? 'Q' : '-',
> > +		__entry->new,
> > +		__entry->cur & ~I_CTIME_QUERIED, __entry->cur &
> > I_CTIME_QUERIED ? 'Q' : '-'
> > +	)
> > +);
> > +
> > +TRACE_EVENT(fill_mg_cmtime,
> > +	TP_PROTO(struct inode *inode,
> > +		 struct timespec64 *ctime,
> > +		 struct timespec64 *mtime),
> > +
> > +	TP_ARGS(inode, ctime, mtime),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t,			dev)
> > +		__field(ino_t,			ino)
> > +		__field(u32,			gen)
>=20
> Same here.
>=20
> -- Steve
>=20
> > +		__field(time64_t,		ctime_s)
> > +		__field(time64_t,		mtime_s)
> > +		__field(u32,			ctime_ns)
> > +		__field(u32,			mtime_ns)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		=3D inode->i_sb->s_dev;
> > +		__entry->ino		=3D inode->i_ino;
> > +		__entry->gen		=3D inode->i_generation;
> > +		__entry->ctime_s	=3D ctime->tv_sec;
> > +		__entry->mtime_s	=3D mtime->tv_sec;
> > +		__entry->ctime_ns	=3D ctime->tv_nsec;
> > +		__entry->mtime_ns	=3D mtime->tv_nsec;
> > +	),
> > +
> > +	TP_printk("ino=3D%d:%d:%ld:%u ctime=3D%lld.%u mtime=3D%lld.%u",
> > +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry-
> > >ino, __entry->gen,
> > +		__entry->ctime_s, __entry->ctime_ns,
> > +		__entry->mtime_s, __entry->mtime_ns
> > +	)
> > +);
> > +#endif /* _TRACE_TIMESTAMP_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

