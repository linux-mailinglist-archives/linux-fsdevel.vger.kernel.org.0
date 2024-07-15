Return-Path: <linux-fsdevel+bounces-23708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B89931A5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516B2B22B8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6E97D07D;
	Mon, 15 Jul 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAQFezqM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A26134AB;
	Mon, 15 Jul 2024 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068332; cv=none; b=EPRbosleZ8iUGcCnUA48JrIowgcSERA3cKtvGfgz9T20m7/cGlcxAlQIR2E+Yz1lx4DqvJOUxd8eZPs9VmRnPyWy5MklXZ2Qra6niD1bDIHxuG0xtzfkHQdi4cYGcOqhEMB70UVfCAxB8NqDCuSwW6jT1q80SD5Lsh2uSTso25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068332; c=relaxed/simple;
	bh=ptmSNcvJ6w8YaJLfeSDUkalrnWlDNwljsvsfC+1nMSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtfnPB1ntDq7QOcKAbyvomZ5uLXwuw5gGrmekIvcVoesUZuUj8/82abMdaAzYbgVKq0CFuWlMzC/frF0ub9woUjy06+5N8kSEXWz72a3NiUy6QNWufYxj58k/FhPicy/m/hUGpr9cTkf1UiDxbnJvUlZWoEzFyC5ysG+O8e42Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAQFezqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBECC32782;
	Mon, 15 Jul 2024 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721068332;
	bh=ptmSNcvJ6w8YaJLfeSDUkalrnWlDNwljsvsfC+1nMSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAQFezqMEUEEB9I7Nxx8TIwu0q+VMSFhhWm+i036ArK6vufJmh/QUpF9e9G3BWl7U
	 /smXWql8lshx+RMf250RPupAJezpnZFl9Rb1dPjTpxZK/Z6v9BOqW+nZnJ+Rd2GiTU
	 OfFAzLWPkU707JHaY4a2rxxfupAAlo7SxhFI63/DwsAG4R3Z8UXG4ZQ5WUL9zu8p11
	 5q2uICvDIgcdda+498pCuOLLA44blyviEjZTinZ4Sg+F/i+WWvAn2Mm3ugb42O7G/d
	 VY5BS1XfeerBLeSjQZS7uOwQZkPYIvTq0qxeXY3FO4DWhaqtwwun6pM5/aMYzl7U+h
	 L9QpoRkhP7gXw==
Date: Mon, 15 Jul 2024 11:32:11 -0700
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
Subject: Re: [PATCH v6 3/9] fs: add percpu counters for significant
 multigrain timestamp events
Message-ID: <20240715183211.GD103014@frogsfrogsfrogs>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-3-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-mgtime-v6-3-48e5d34bd2ba@kernel.org>

On Mon, Jul 15, 2024 at 08:48:54AM -0400, Jeff Layton wrote:
> Four percpu counters for counting various stats around mgtimes, and a
> new debugfs file for displaying them:
> 
> - number of attempted ctime updates
> - number of successful i_ctime_nsec swaps
> - number of fine-grained timestamp fetches
> - number of floor value swaps
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 869994285e87..fff844345c35 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -21,6 +21,8 @@
>  #include <linux/list_lru.h>
>  #include <linux/iversion.h>
>  #include <linux/rw_hint.h>
> +#include <linux/seq_file.h>
> +#include <linux/debugfs.h>
>  #include <trace/events/writeback.h>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/timestamp.h>
> @@ -80,6 +82,10 @@ EXPORT_SYMBOL(empty_aops);
>  
>  static DEFINE_PER_CPU(unsigned long, nr_inodes);
>  static DEFINE_PER_CPU(unsigned long, nr_unused);
> +static DEFINE_PER_CPU(unsigned long, mg_ctime_updates);
> +static DEFINE_PER_CPU(unsigned long, mg_fine_stamps);
> +static DEFINE_PER_CPU(unsigned long, mg_floor_swaps);
> +static DEFINE_PER_CPU(unsigned long, mg_ctime_swaps);

Should this all get switched off if CONFIG_DEBUG_FS=n?

--D

>  
>  static struct kmem_cache *inode_cachep __ro_after_init;
>  
> @@ -101,6 +107,42 @@ static inline long get_nr_inodes_unused(void)
>  	return sum < 0 ? 0 : sum;
>  }
>  
> +static long get_mg_ctime_updates(void)
> +{
> +	int i;
> +	long sum = 0;
> +	for_each_possible_cpu(i)
> +		sum += per_cpu(mg_ctime_updates, i);
> +	return sum < 0 ? 0 : sum;
> +}
> +
> +static long get_mg_fine_stamps(void)
> +{
> +	int i;
> +	long sum = 0;
> +	for_each_possible_cpu(i)
> +		sum += per_cpu(mg_fine_stamps, i);
> +	return sum < 0 ? 0 : sum;
> +}
> +
> +static long get_mg_floor_swaps(void)
> +{
> +	int i;
> +	long sum = 0;
> +	for_each_possible_cpu(i)
> +		sum += per_cpu(mg_floor_swaps, i);
> +	return sum < 0 ? 0 : sum;
> +}
> +
> +static long get_mg_ctime_swaps(void)
> +{
> +	int i;
> +	long sum = 0;
> +	for_each_possible_cpu(i)
> +		sum += per_cpu(mg_ctime_swaps, i);
> +	return sum < 0 ? 0 : sum;
> +}
> +
>  long get_nr_dirty_inodes(void)
>  {
>  	/* not actually dirty inodes, but a wild approximation */
> @@ -2655,6 +2697,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
>  
>  			/* Get a fine-grained time */
>  			fine = ktime_get();
> +			this_cpu_inc(mg_fine_stamps);
>  
>  			/*
>  			 * If the cmpxchg works, we take the new floor value. If
> @@ -2663,11 +2706,14 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
>  			 * as good, so keep it.
>  			 */
>  			old = floor;
> -			if (!atomic64_try_cmpxchg(&ctime_floor, &old, fine))
> +			if (atomic64_try_cmpxchg(&ctime_floor, &old, fine))
> +				this_cpu_inc(mg_floor_swaps);
> +			else
>  				fine = old;
>  			now = ktime_mono_to_real(fine);
>  		}
>  	}
> +	this_cpu_inc(mg_ctime_updates);
>  	now_ts = timestamp_truncate(ktime_to_timespec64(now), inode);
>  	cur = cns;
>  
> @@ -2682,6 +2728,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
>  		/* If swap occurred, then we're (mostly) done */
>  		inode->i_ctime_sec = now_ts.tv_sec;
>  		trace_ctime_ns_xchg(inode, cns, now_ts.tv_nsec, cur);
> +		this_cpu_inc(mg_ctime_swaps);
>  	} else {
>  		/*
>  		 * Was the change due to someone marking the old ctime QUERIED?
> @@ -2751,3 +2798,24 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
>  	return mode & ~S_ISGID;
>  }
>  EXPORT_SYMBOL(mode_strip_sgid);
> +
> +static int mgts_show(struct seq_file *s, void *p)
> +{
> +	long ctime_updates = get_mg_ctime_updates();
> +	long ctime_swaps = get_mg_ctime_swaps();
> +	long fine_stamps = get_mg_fine_stamps();
> +	long floor_swaps = get_mg_floor_swaps();
> +
> +	seq_printf(s, "%lu %lu %lu %lu\n",
> +		   ctime_updates, ctime_swaps, fine_stamps, floor_swaps);
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(mgts);
> +
> +static int __init mg_debugfs_init(void)
> +{
> +	debugfs_create_file("multigrain_timestamps", S_IFREG | S_IRUGO, NULL, NULL, &mgts_fops);
> +	return 0;
> +}
> +late_initcall(mg_debugfs_init);
> 
> -- 
> 2.45.2
> 
> 

