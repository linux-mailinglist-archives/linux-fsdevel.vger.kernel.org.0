Return-Path: <linux-fsdevel+bounces-23587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D992EDD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7A41F230EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B566F16EB56;
	Thu, 11 Jul 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyPt/Hhu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CE16DC24;
	Thu, 11 Jul 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718933; cv=none; b=MLIOcz2CcjW+b+YvlYaEpDEVT/aI6khEPZdaviWgMi7mm0ojLpotXTKn3UMS4Ms/iURuiD/9nQG0xBsznfPHxF3lt/Hw5Qf5U4gNQGsQt4MG8u8+XBw2/mhp+4913/b0ZLIMksoKLMVQQNqjxS0MLqSoLATsFhg70y04eNwk7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718933; c=relaxed/simple;
	bh=ec3cDaXtRVujypARvqbg7o31Xt25d2K5x/3vnI52u/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NlTtwbnVg1bKQqlOoBQMIhkQ0+iuSdnSQXS3d0MBif+Ea4jWBdSZ25T04oZY5UCMplFAPQ7iq2pFxtQFt12cIGU1rc7SdV08SUmcBrkUU4EDGMuwXAQiUENrHJn4ANgb4Zd+fWQAUGGEqKaiTYq/l+w6UVc4pnMm3RxYapPZZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyPt/Hhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08162C116B1;
	Thu, 11 Jul 2024 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720718932;
	bh=ec3cDaXtRVujypARvqbg7o31Xt25d2K5x/3vnI52u/I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XyPt/HhuWXbLLDT9NqSf10X0ZEtEpQuV8aS19+pEMKjfeoWv+T1dgyJfFQs5gJAzP
	 HH2Sgdz2MW1rnBUkX/3Sn07v4J9xTG6Q4p4wkyYiZ96QuRt9CgiaHbV6FFgSD8W/0q
	 e0xB9oQpd0qUNKeRzWqBb7hnhTrUA9g9BagSD8wI4todQ6JLlUh3WSpvlRVRhL+TCq
	 5gmEp1469tGrCq1+fU96neMmHW/WCB2NeWOgvEcWh+XNSKSXq7bq+OKHSoWT/L3jJ6
	 ErzpnHhxgxWHFk/uL1bqEz9MuHqv9fAZrB+6o6y+XQSyUYStlyW/d2nfEqeSxpJAAY
	 A3TgdaKPcNuFw==
Message-ID: <52659b4f2bf3334de824f480fac25c6e028814d2.camel@kernel.org>
Subject: Re: [PATCH v5 2/9] fs: tracepoints around multigrain timestamp
 events
From: Jeff Layton <jlayton@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Chandan Babu R
 <chandan.babu@oracle.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,  Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Jonathan
 Corbet <corbet@lwn.net>,  Dave Chinner <david@fromorbit.com>, Andi Kleen
 <ak@linux.intel.com>, Christoph Hellwig <hch@infradead.org>,  Uros Bizjak
 <ubizjak@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, Arnd
 Bergmann <arnd@arndb.de>,  Randy Dunlap <rdunlap@infradead.org>,
 kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org,
  linux-doc@vger.kernel.org
Date: Thu, 11 Jul 2024 13:28:48 -0400
In-Reply-To: <20240711164950.GO612460@frogsfrogsfrogs>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
	 <20240711-mgtime-v5-2-37bb5b465feb@kernel.org>
	 <20240711164950.GO612460@frogsfrogsfrogs>
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

On Thu, 2024-07-11 at 09:49 -0700, Darrick J. Wong wrote:
> On Thu, Jul 11, 2024 at 07:08:06AM -0400, Jeff Layton wrote:
> > Add some tracepoints around various multigrain timestamp events.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =C2=A0fs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 5 ++
> > =C2=A0fs/stat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 3 ++
> > =C2=A0include/trace/events/timestamp.h | 109
> > +++++++++++++++++++++++++++++++++++++++
> > =C2=A03 files changed, 117 insertions(+)
> >=20
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 2b5889ff7b36..81b45e0a95a6 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -22,6 +22,9 @@
> > =C2=A0#include <linux/iversion.h>
> > =C2=A0#include <linux/rw_hint.h>
> > =C2=A0#include <trace/events/writeback.h>
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/timestamp.h>
> > +
> > =C2=A0#include "internal.h"
> > =C2=A0
> > =C2=A0/*
> > @@ -2571,6 +2574,7 @@ struct timespec64
> > inode_set_ctime_to_ts(struct inode *inode, struct timespec64 t
> > =C2=A0{
> > =C2=A0	inode->i_ctime_sec =3D ts.tv_sec;
> > =C2=A0	inode->i_ctime_nsec =3D ts.tv_nsec & ~I_CTIME_QUERIED;
> > +	trace_inode_set_ctime_to_ts(inode, &ts);
> > =C2=A0	return ts;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(inode_set_ctime_to_ts);
> > @@ -2670,6 +2674,7 @@ struct timespec64
> > inode_set_ctime_current(struct inode *inode)
> > =C2=A0	if (try_cmpxchg(&inode->i_ctime_nsec, &cur,
> > now_ts.tv_nsec)) {
> > =C2=A0		/* If swap occurred, then we're (mostly) done */
> > =C2=A0		inode->i_ctime_sec =3D now_ts.tv_sec;
> > +		trace_ctime_ns_xchg(inode, cns, now_ts.tv_nsec,
> > cur);
> > =C2=A0	} else {
> > =C2=A0		/*
> > =C2=A0		 * Was the change due to someone marking the old
> > ctime QUERIED?
> > diff --git a/fs/stat.c b/fs/stat.c
> > index df7fdd3afed9..552dfd67688b 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -23,6 +23,8 @@
> > =C2=A0#include <linux/uaccess.h>
> > =C2=A0#include <asm/unistd.h>
> > =C2=A0
> > +#include <trace/events/timestamp.h>
> > +
> > =C2=A0#include "internal.h"
> > =C2=A0#include "mount.h"
> > =C2=A0
> > @@ -49,6 +51,7 @@ void fill_mg_cmtime(struct kstat *stat, u32
> > request_mask, struct inode *inode)
> > =C2=A0	stat->mtime =3D inode_get_mtime(inode);
> > =C2=A0	stat->ctime.tv_sec =3D inode->i_ctime_sec;
> > =C2=A0	stat->ctime.tv_nsec =3D
> > ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn)) & ~I_CTIME_QUERIED;
> > +	trace_fill_mg_cmtime(inode, &stat->ctime, &stat->mtime);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(fill_mg_cmtime);
> > =C2=A0
> > diff --git a/include/trace/events/timestamp.h
> > b/include/trace/events/timestamp.h
> > new file mode 100644
> > index 000000000000..3a603190b46c
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
> > +		__field(time64_t,		ctime_s)
> > +		__field(u32,			ctime_ns)
> > +		__field(u32,			gen)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		=3D inode->i_sb->s_dev;
>=20
> Odd indenting of the second columns between the struct definition
> above
> and the assignment code here.
>=20
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
>=20
> This /might/ be overkill for a single flag, but anything you put in
> the
> TP_printk seems to end up in the format file:
>=20
> # cat
> /sys/kernel/debug/tracing/events/xfs/xfbtree_create_root_buf/format
> name: xfbtree_create_root_buf
> ID: 1644
> format:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:unsigned short common_ty=
pe;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset:0;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> size:2; signed:0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:unsigned char common_fla=
gs;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset:2;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> size:1; signed:0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:unsigned char common_pre=
empt_count;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> offset:3;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size:1; signed:0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:int common_pid;=C2=A0=C2=
=A0 offset:4;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size:4; signed:1;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:unsigned long xfino;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset:8;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ize:8;
> signed:0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:xfs_daddr_t bno;=C2=A0 o=
ffset:16;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size:8; signed:1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:int nblks;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset:24;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 siz=
e:4; signed:1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:int hold; offset:28;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 size:4; signed:1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:int pincount;=C2=A0=C2=
=A0=C2=A0=C2=A0 offset:32;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size:4; signed:1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:unsigned int lockval;=C2=
=A0=C2=A0=C2=A0=C2=A0 offset:36;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size:4;
> signed:0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field:unsigned int flags;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset:40;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
size:4;
> signed:0;
>=20
> print fmt: "xfino 0x%lx daddr 0x%llx bbcount 0x%x hold %d pincount %d
> lock %d flags %s", REC->xfino, (unsigned long long)REC->bno, REC-
> >nblks, REC->hold, REC->pincount, REC->lockval, __print_flags(REC-
> >flags, "|", { (1u << 0), "READ" }, { (1u << 1), "WRITE" }, { (1u <<
> 2), "READ_AHEAD" }, { (1u << 3), "NO_IOACCT" }, { (1u << 4), "ASYNC"
> }, { (1u << 5), "DONE" }, { (1u << 6), "STALE" }, { (1u << 7),
> "WRITE_FAIL" }, { (1u << 16), "INODES" }, { (1u << 17), "DQUOTS" }, {
> (1u << 18), "LOG_RECOVERY" }, { (1u << 20), "PAGES" }, { (1u << 21),
> "KMEM" }, { (1u << 22), "DELWRI_Q" }, { (1u << 28), "LIVESCAN" }, {
> (1u << 29), "INCORE" }, { (1u << 30), "TRYLOCK" }, { (1u << 31),
> "UNMAPPED" })
>=20
> I /think/ all that code gets compiled (interpreted?) as if it were C
> code, but a more compact format might be:
>=20
> #define CTIME_QUERIED_FLAGS \
> 	{ I_CTIME_QUERIED, "queried" }
>=20
> 	TP_printk("ino=3D%d:%d:%ld:%u old=3D%u:%s new=3D%u cur=3D%u:%c",
> 		MAJOR(__entry->dev), MINOR(__entry->dev), __entry-
> >ino, __entry->gen,
> 		__entry->old & ~I_CTIME_QUERIED,
> 		__print_flags(__entry->old & I_CTIME_QUERIED, "|",
> 			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CTIME_QUERIED_FLAGS),
> 		...
>=20
> But, again, that could be overkill for a single flag.=C2=A0 Aside from my
> minor bikeshedding, this all looks good, and I like that we can now
> monitor what's going on wrt ctime. :)
>=20

That seems reasonable. I hadn't looked at the unrolled format
monstrosity, but making it more compact is good. I'll make that change
and see how it looks.

Thanks for the reviews so far!

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
> > +		__field(time64_t,		ctime_s)
> > +		__field(time64_t,		mtime_s)
> > +		__field(u32,			ctime_ns)
> > +		__field(u32,			mtime_ns)
> > +		__field(u32,			gen)
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
> > --=20
> > 2.45.2
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

