Return-Path: <linux-fsdevel+bounces-23713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BEC931B44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 21:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13341282758
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 19:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF813A896;
	Mon, 15 Jul 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/RPKvYT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC01813959D;
	Mon, 15 Jul 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073226; cv=none; b=ZgUsmaClMVjdrU/MikTUouRXybhbytyblRU9JBZXTX8mVExSZSOsWUqxgmtYeufhL5LbIBe2brT9GH3SuHDJBbiz7q4Q7Ecrcja9ULSFWhc2KZZOgBYd8ut4UNuELVmMblfMmTmxgd3G0U0Jrhfo3Ao9Jfexb0uXnkGi4MBTLQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073226; c=relaxed/simple;
	bh=yli0LWXpH5CVRAJkf/HBclTwQ2A3btlIJ24aQWTuFvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mCmUz9XCqMSFuhI0h3Sydyzo39+viBwNy1Ea2m1YGhtoHQBctnopN4FCUbOo1b1UPckRzBkQHiE1zyHfi6nWrmVdwUuW2Rm/7PvREfgneQLeluMfbU91EpJMw1T8NQ7eyq7nkMQXkL28sIC8eBts1tFnNZhnvaT7Flv2i228Myk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/RPKvYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747CFC32782;
	Mon, 15 Jul 2024 19:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721073226;
	bh=yli0LWXpH5CVRAJkf/HBclTwQ2A3btlIJ24aQWTuFvM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O/RPKvYTzLamtAGuM97RkutzNp/xIwEXzluX8j43FEJJiOQTQEgBlNDA5SixNP19s
	 uWTHGe0vQ17ZtZR2/9jvEp1GD6El8gciPxwZitIaTz/dy8BVVryOsdHZSkFtoDeRjs
	 vach9xfj9ATrdpyxADoGXSjODYPK93hieFRuSWK/7Tb3oSa27c95S9bsBF0d0w/ciB
	 yeM74Sy+Hs9A2XOFrWqywT/Pku0pXkrA2kVCqXfJeUeK4gybj4jC8HtrIi1Ah8EvWg
	 SD9COo76Hvd4UceLOV921b9L3dvLR+iie/4A2rqSViEDcWLB/m3qcCJ7HEydTL3Zp6
	 1Na2AN0g5tAhg==
Message-ID: <7bb897f31fded59aae8d62a6796dd21feebd0642.camel@kernel.org>
Subject: Re: [PATCH v6 3/9] fs: add percpu counters for significant
 multigrain timestamp events
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
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org,  linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org
Date: Mon, 15 Jul 2024 15:53:42 -0400
In-Reply-To: <20240715183211.GD103014@frogsfrogsfrogs>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
	 <20240715-mgtime-v6-3-48e5d34bd2ba@kernel.org>
	 <20240715183211.GD103014@frogsfrogsfrogs>
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

On Mon, 2024-07-15 at 11:32 -0700, Darrick J. Wong wrote:
> On Mon, Jul 15, 2024 at 08:48:54AM -0400, Jeff Layton wrote:
> > Four percpu counters for counting various stats around mgtimes, and
> > a
> > new debugfs file for displaying them:
> >=20
> > - number of attempted ctime updates
> > - number of successful i_ctime_nsec swaps
> > - number of fine-grained timestamp fetches
> > - number of floor value swaps
> >=20
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =C2=A0fs/inode.c | 70
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > =C2=A01 file changed, 69 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 869994285e87..fff844345c35 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -21,6 +21,8 @@
> > =C2=A0#include <linux/list_lru.h>
> > =C2=A0#include <linux/iversion.h>
> > =C2=A0#include <linux/rw_hint.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/debugfs.h>
> > =C2=A0#include <trace/events/writeback.h>
> > =C2=A0#define CREATE_TRACE_POINTS
> > =C2=A0#include <trace/events/timestamp.h>
> > @@ -80,6 +82,10 @@ EXPORT_SYMBOL(empty_aops);
> > =C2=A0
> > =C2=A0static DEFINE_PER_CPU(unsigned long, nr_inodes);
> > =C2=A0static DEFINE_PER_CPU(unsigned long, nr_unused);
> > +static DEFINE_PER_CPU(unsigned long, mg_ctime_updates);
> > +static DEFINE_PER_CPU(unsigned long, mg_fine_stamps);
> > +static DEFINE_PER_CPU(unsigned long, mg_floor_swaps);
> > +static DEFINE_PER_CPU(unsigned long, mg_ctime_swaps);
>=20
> Should this all get switched off if CONFIG_DEBUG_FS=3Dn?
>=20
> --D
>=20

Sure, why not. That's simple enough to do.

I pushed an updated mgtime branch to my git tree. Here's the updated
patch that's the only difference:

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commi=
t/?h=3Dmgtime&id=3Dee7fe6e9c0598754861c8620230f15f3de538ca5

Seems to build OK both with and without CONFIG_DEBUG_FS.
=20
> > =C2=A0
> > =C2=A0static struct kmem_cache *inode_cachep __ro_after_init;
> > =C2=A0
> > @@ -101,6 +107,42 @@ static inline long get_nr_inodes_unused(void)
> > =C2=A0	return sum < 0 ? 0 : sum;
> > =C2=A0}
> > =C2=A0
> > +static long get_mg_ctime_updates(void)
> > +{
> > +	int i;
> > +	long sum =3D 0;
> > +	for_each_possible_cpu(i)
> > +		sum +=3D per_cpu(mg_ctime_updates, i);
> > +	return sum < 0 ? 0 : sum;
> > +}
> > +
> > +static long get_mg_fine_stamps(void)
> > +{
> > +	int i;
> > +	long sum =3D 0;
> > +	for_each_possible_cpu(i)
> > +		sum +=3D per_cpu(mg_fine_stamps, i);
> > +	return sum < 0 ? 0 : sum;
> > +}
> > +
> > +static long get_mg_floor_swaps(void)
> > +{
> > +	int i;
> > +	long sum =3D 0;
> > +	for_each_possible_cpu(i)
> > +		sum +=3D per_cpu(mg_floor_swaps, i);
> > +	return sum < 0 ? 0 : sum;
> > +}
> > +
> > +static long get_mg_ctime_swaps(void)
> > +{
> > +	int i;
> > +	long sum =3D 0;
> > +	for_each_possible_cpu(i)
> > +		sum +=3D per_cpu(mg_ctime_swaps, i);
> > +	return sum < 0 ? 0 : sum;
> > +}
> > +
> > =C2=A0long get_nr_dirty_inodes(void)
> > =C2=A0{
> > =C2=A0	/* not actually dirty inodes, but a wild approximation */
> > @@ -2655,6 +2697,7 @@ struct timespec64
> > inode_set_ctime_current(struct inode *inode)
> > =C2=A0
> > =C2=A0			/* Get a fine-grained time */
> > =C2=A0			fine =3D ktime_get();
> > +			this_cpu_inc(mg_fine_stamps);
> > =C2=A0
> > =C2=A0			/*
> > =C2=A0			 * If the cmpxchg works, we take the new
> > floor value. If
> > @@ -2663,11 +2706,14 @@ struct timespec64
> > inode_set_ctime_current(struct inode *inode)
> > =C2=A0			 * as good, so keep it.
> > =C2=A0			 */
> > =C2=A0			old =3D floor;
> > -			if (!atomic64_try_cmpxchg(&ctime_floor,
> > &old, fine))
> > +			if (atomic64_try_cmpxchg(&ctime_floor,
> > &old, fine))
> > +				this_cpu_inc(mg_floor_swaps);
> > +			else
> > =C2=A0				fine =3D old;
> > =C2=A0			now =3D ktime_mono_to_real(fine);
> > =C2=A0		}
> > =C2=A0	}
> > +	this_cpu_inc(mg_ctime_updates);
> > =C2=A0	now_ts =3D timestamp_truncate(ktime_to_timespec64(now),
> > inode);
> > =C2=A0	cur =3D cns;
> > =C2=A0
> > @@ -2682,6 +2728,7 @@ struct timespec64
> > inode_set_ctime_current(struct inode *inode)
> > =C2=A0		/* If swap occurred, then we're (mostly) done */
> > =C2=A0		inode->i_ctime_sec =3D now_ts.tv_sec;
> > =C2=A0		trace_ctime_ns_xchg(inode, cns, now_ts.tv_nsec,
> > cur);
> > +		this_cpu_inc(mg_ctime_swaps);
> > =C2=A0	} else {
> > =C2=A0		/*
> > =C2=A0		 * Was the change due to someone marking the old
> > ctime QUERIED?
> > @@ -2751,3 +2798,24 @@ umode_t mode_strip_sgid(struct mnt_idmap
> > *idmap,
> > =C2=A0	return mode & ~S_ISGID;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(mode_strip_sgid);
> > +
> > +static int mgts_show(struct seq_file *s, void *p)
> > +{
> > +	long ctime_updates =3D get_mg_ctime_updates();
> > +	long ctime_swaps =3D get_mg_ctime_swaps();
> > +	long fine_stamps =3D get_mg_fine_stamps();
> > +	long floor_swaps =3D get_mg_floor_swaps();
> > +
> > +	seq_printf(s, "%lu %lu %lu %lu\n",
> > +		=C2=A0=C2=A0 ctime_updates, ctime_swaps, fine_stamps,
> > floor_swaps);
> > +	return 0;
> > +}
> > +
> > +DEFINE_SHOW_ATTRIBUTE(mgts);
> > +
> > +static int __init mg_debugfs_init(void)
> > +{
> > +	debugfs_create_file("multigrain_timestamps", S_IFREG |
> > S_IRUGO, NULL, NULL, &mgts_fops);
> > +	return 0;
> > +}
> > +late_initcall(mg_debugfs_init);
> >=20
> > --=20
> > 2.45.2
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

