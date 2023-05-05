Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1005F6F79FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 02:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjEEAKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 20:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjEEAKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 20:10:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD121328B
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 17:10:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5191796a483so785825a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 May 2023 17:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683245444; x=1685837444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8O5/MWGnrN/HKZ6iCIcOlLCZpNsEHpNrNhu83CyTnE=;
        b=Ji0/fNIKPzOGoEPnZErf7BsAxIz54Y4D47kCHJLPzmtZqvf8AfVu6fE0O/57tqhlG/
         BpsA3MHBhVH04xTSyCanoshSHk1Vd4eNpQPqZ/dPBlYV80MsDo1PwwLuHQMWvtxYzbSK
         TlBXBBXG0XjNR1NRTD7KzZbuYQZKvHufoe8GFNm9kDK/OfDYSYEu1V3okXJUjLyfPQn+
         r7jmPxFU8Pm/PKD+2KI/i00U4MK9EE1TFifAJOvJBUHAarimzoFLLS4tiDYL2OzvfWfk
         SsW75ymP/FxB9G2PZ/zKz0oltBaflFNieleClDbHQZLFVQwcH2hYizVOZdP35Ispkxkr
         JqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683245444; x=1685837444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8O5/MWGnrN/HKZ6iCIcOlLCZpNsEHpNrNhu83CyTnE=;
        b=ec+bBJYykwR5krZ8Al7yiIh9eUxolfcs4LwATMsJkFSRC/2yQ6Ai6lh/FnI6ulhBjZ
         6y2Fx22ljNYHTSmfZFfBWMZ4K24j5odgVnBgW/vlw7kD6h633Yh1dPSfiZOOFGCnp7/6
         npzGk9Hk9qPSumrlijAUbIeaxa0O6M3mWBhedPiv7kZqWXYQ4dHzVtQLsTewx5HV8OEr
         HaQ4hmVjbJx1wnyPtAhM5jT+G2ZfA5pbU4tZ6q2tYtxuqcc+JhPizpW0k6H3wkgnbOTG
         trC9051FP2Rm21YcsQ5ctjbl8HZvQM4m5v1pWQl7K7SoVXSSQ3Z6WZTcAqCU2IpZmgk+
         J58w==
X-Gm-Message-State: AC+VfDwS7mgx8JjOVMMHpcsEHQSi9wjiIUJhGIVzeIypufDC8/71ecxz
        moQgeMsuxTPTHA7xl7ZO0EPqTQ==
X-Google-Smtp-Source: ACHHUZ7z+JA9nzv+3mJ3KYYHotTw7V86SXzf1wg9+Gu98bWmRaKAr2pIwEoeGjWXhWiIrAH+cIxkxg==
X-Received: by 2002:a17:902:f691:b0:1ac:2cc6:296d with SMTP id l17-20020a170902f69100b001ac2cc6296dmr4284993plg.34.1683245444236;
        Thu, 04 May 2023 17:10:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b001a19f3a661esm147731plg.138.2023.05.04.17.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 17:10:43 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1puj20-00BROo-FR; Fri, 05 May 2023 10:10:40 +1000
Date:   Fri, 5 May 2023 10:10:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 1/6] fs: add infrastructure for multigrain inode
 i_m/ctime
Message-ID: <20230505001040.GL3223426@dread.disaster.area>
References: <20230503142037.153531-1-jlayton@kernel.org>
 <20230503142037.153531-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503142037.153531-2-jlayton@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 10:20:32AM -0400, Jeff Layton wrote:
> The VFS always uses coarse-grained timestamp updates for filling out the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away a lot metadata updates, down to around 1
> per jiffy, even when a file is under heavy writes.
> 
> Unfortunately, this has always been an issue when we're exporting via
> NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
> lot of exported filesystems don't properly support a change attribute
> and are subject to the same problems with timestamp granularity. Other
> applications have similar issues (e.g backup applications).
> 
> Switching to always using fine-grained timestamps would improve the
> situation, but that becomes rather expensive, as the underlying
> filesystem will have to log a lot more metadata updates.
> 
> What we need is a way to only use fine-grained timestamps when they are
> being actively queried.
> 
> The kernel always stores normalized ctime values, so only the first 30
> bits of the tv_nsec field are ever used. Whenever the mtime changes, the
> ctime must also change.
> 
> Use the 31st bit of the tv_nsec field to indicate that something has
> queried the inode for the i_mtime or i_ctime. When this flag is set, on
> the next timestamp update, the kernel can fetch a fine-grained timestamp
> instead of the usual coarse-grained one.
> 
> This patch adds the infrastructure this scheme. Filesytems can opt
> into it by setting the FS_MULTIGRAIN_TS flag in the fstype.
> 
> Later patches will convert individual filesystems over to use it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c         | 52 ++++++++++++++++++++++++++++++++++++---
>  fs/stat.c          | 32 ++++++++++++++++++++++++
>  include/linux/fs.h | 61 +++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 141 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 4558dc2f1355..7f6189961d6a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2030,6 +2030,7 @@ EXPORT_SYMBOL(file_remove_privs);
>  static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
>  {
>  	int sync_it = 0;
> +	struct timespec64 ctime;
>  
>  	/* First try to exhaust all avenues to not sync */
>  	if (IS_NOCMTIME(inode))
> @@ -2038,7 +2039,8 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
>  	if (!timespec64_equal(&inode->i_mtime, now))
>  		sync_it = S_MTIME;
>  
> -	if (!timespec64_equal(&inode->i_ctime, now))
> +	ctime = ctime_peek(inode);
> +	if (!timespec64_equal(&ctime, now))
>  		sync_it |= S_CTIME;
>  
>  	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
> @@ -2062,6 +2064,50 @@ static int __file_update_time(struct file *file, struct timespec64 *now,
>  	return ret;
>  }
>  
> +/**
> + * current_ctime - Return FS time (possibly fine-grained)
> + * @inode: inode.
> + *
> + * Return the current time truncated to the time granularity supported by
> + * the fs, as suitable for a ctime/mtime change.
> + *
> + * For a multigrain timestamp, if the ctime is flagged as having been
> + * QUERIED, get a fine-grained timestamp.
> + */
> +struct timespec64 current_ctime(struct inode *inode)
> +{
> +	bool multigrain = is_multigrain_ts(inode);
> +	struct timespec64 now;
> +	long nsec = 0;
> +
> +	if (multigrain) {
> +		atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
> +
> +		nsec = atomic_long_fetch_andnot(I_CTIME_QUERIED, pnsec);
> +	}
> +
> +	if (nsec & I_CTIME_QUERIED) {
> +		ktime_get_real_ts64(&now);
> +	} else {
> +		ktime_get_coarse_real_ts64(&now);
> +
> +		if (multigrain) {
> +			/*
> +			 * If we've recently fetched a fine-grained timestamp
> +			 * then the coarse-grained one may be earlier than the
> +			 * existing one. Just keep the existing ctime if so.
> +			 */
> +			struct timespec64 ctime = ctime_peek(inode);
> +
> +			if (timespec64_compare(&ctime, &now) > 0)
> +				now = ctime;
> +		}
> +	}
> +
> +	return timestamp_truncate(now, inode);
> +}
> +EXPORT_SYMBOL(current_ctime);

I can't help but think this is easier to read/follow when structured
to separate multigrain vs coarse logic completely like so:

struct timespec64 current_ctime(struct inode *inode)
{
	struct timespec64 now, ctime;
	long nsec;

	if (!is_multigrain_ts(inode)) {
		ktime_get_coarse_real_ts64(&now);
		goto out_truncate;
	}

	nsec = atomic_long_fetch_andnot(I_CTIME_QUERIED,
			(atomic_long_t *)&inode->i_ctime.tv_nsec);

	if (nsec & I_CTIME_QUERIED) {
		ktime_get_real_ts64(&now);
		goto out_truncate;
	}

	/*
	 * If we've recently fetched a fine-grained timestamp then
	 * the coarse-grained one may be earlier than the existing
	 * one. Just keep the existing ctime if so.
	 */
	ktime_get_coarse_real_ts64(&now);
	ctime = ctime_peek(inode);
	if (timespec64_compare(&ctime, &now) > 0)
		now = ctime;

out_truncate:
	return timestamp_truncate(now, inode);
}

> diff --git a/fs/stat.c b/fs/stat.c
> index 7c238da22ef0..11a7e277f53e 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -26,6 +26,38 @@
>  #include "internal.h"
>  #include "mount.h"
>  
> +/**
> + * generic_fill_multigrain_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
> + * @request_mask: STATX_* values requested
> + * @inode: inode from which to grab the c/mtime
> + * @stat: where to store the resulting values
> + *
> + * Given @inode, grab the ctime and mtime out if it and store the result
> + * in @stat. When fetching the value, flag it as queried so the next write
> + * will use a fine-grained timestamp.
> + */
> +void generic_fill_multigrain_cmtime(u32 request_mask,struct inode *inode,
> +					struct kstat *stat)
> +{
> +	atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
> +
> +	/* If neither time was requested, then just don't report it */
> +	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
> +		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
> +		return;
> +	}
> +
> +	stat->mtime = inode->i_mtime;
> +	stat->ctime.tv_sec = inode->i_ctime.tv_sec;
> +	/*
> +	 * Atomically set the QUERIED flag and fetch the new value with
> +	 * the flag masked off.
> +	 */
> +	stat->ctime.tv_nsec = atomic_long_fetch_or(I_CTIME_QUERIED, pnsec) &
> +					~I_CTIME_QUERIED;
> +}
> +EXPORT_SYMBOL(generic_fill_multigrain_cmtime);

Hmmm - why not just have a generic_fill_cmtime() function that hides
multigrain behaviour from all the statx callers?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
