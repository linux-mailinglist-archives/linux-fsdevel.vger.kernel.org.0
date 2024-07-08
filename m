Return-Path: <linux-fsdevel+bounces-23290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D906E92A5BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662A21F21DDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA7143863;
	Mon,  8 Jul 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaYcmikc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB91E536;
	Mon,  8 Jul 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452774; cv=none; b=BeiwqzHRb+OYWnqy47TT3/3b4xwO9c4GqiFvAXULVWAvtEjDbVjWDkQMl/wO2uHjUKm04IkUrGqXGQeTbn35ffNNV8/UjAFj4MczPzQpPM3XuEqhimqwdFMACMxBnIfMaZjmGzLtG7k5t9aqNllZmpbM7H58YVR5BU2Fj6mmL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452774; c=relaxed/simple;
	bh=YzjeFVbsd2JZ1GKiO3dAh1rMpxDB98RT3aamYMro1bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiwRY9pW+cVAm+mXnwOp0EmjH0UEzUA8gVM1RJ3cKNP28WboWXwL6nQpauJ2SakF90la4Q2IZiwmZuc7FJjeYFKMTOigMU8UztM9GVnpWIb3T6ZWkDgK2HzpK5Ke6i/qhDyvoOGBy3Vh4MEr/sxS0WsBNWAhGlTI78rBz4Twz2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaYcmikc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367a23462e6so2523916f8f.3;
        Mon, 08 Jul 2024 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720452771; x=1721057571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eoqxm3WBlZLbXq1Fam6qjOE3pul4YXsWbpF7pupskts=;
        b=MaYcmikcM28BRTbvAhl8Be4cMTbXdcPHRm/kIq9/Rd9kjtdWkfKTPStFoJFWoptlyU
         Y2aq600N/2veOv5Bu7EKgZNFNl8baEXQQrUV1Aka2fCnxRE9DhPioIJxFW+I/KO2rnci
         r4rfJyjh7dLdzlAxtcj3Q24kcuCHEwyyLU/Ccbu8BAU2QZwPtBVdRF/0iu6kpMCjiHnk
         /i7oBzF+OGnea/i3Beuu02RLhGkLwE0gVR+xZfHwnKwszvz7NIrEuPbv8MyOdmeeGZ6x
         qCsAzpQJZ2K+sFHHie+FmHCOT7YXrQwgBP/delM2ksMSrIghXdwVDlYf1t/Tn4ZLklFe
         mSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720452771; x=1721057571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoqxm3WBlZLbXq1Fam6qjOE3pul4YXsWbpF7pupskts=;
        b=j66NzFCwFfLNmEAPjNRBdhM/QDuWYL5vdTJOprFwFRh6pVADFSSsxxUsbTF2waAsda
         UdUigp/BoP8psfObUDqV5Lz0bUWEyj5OdJDSMHlxf+ke3JMxgC/Vc9ph4YF7FMiB9ldq
         A0v9Zj7TTPZT2ln5qtfdBhtt5KGIqZTH11ujltbgrXbYFN9Sd+Ztbz5OKKqfNGa8PPBr
         Z6GX4fWB2AR+WfeOWPUVO9HMQRqT7EF9P1SG1L8ffJuVBb/s4Of+K8411Kl7BwWLRiaK
         jpqSFlCswQKURUl8IBoiPU3FC+NSaa+jLvoxOf8SveBrp1Ur3Bk32zVa/TRX47L1xSoU
         6bDA==
X-Forwarded-Encrypted: i=1; AJvYcCU3NpsOensf9XtnsyhYSEwZo1cLyN68ymtX6L4zMR7mlFEwBWGsuZQr0n0VV5S5Xhjip2jOwOzj4WxILJdXTweR3wISPJxjTVdjB4LXRNvhHv8nriCzWRJUEsAh3/MCS0dOHucd8YzSB7YVSac44cj4jxfJMYYUwacNYD1iwPZns8cIUku2WfB813yLjGfVVncjcwryim63bm3tGV+BbO/PNNNvPest8WLH+v1qkAb3/Ywa8RZ6LCAG0AQXiGgKWjofpERaztWPlrnBpNQU0+VRithvRBIYV3E4U+++oo4lVvHgHWuFZX+mpUTshws82TIPyAFMg0oUbhofhZ7tlZVw0Nbo3LsgV9WXmX+dM9GIWnFa4sPtYnK+5Q==
X-Gm-Message-State: AOJu0Yxsro8qmMLNUb0zDGA9Ls5xQZrsCmjDtCCCrJ8L4XrqPmVlGX0t
	wnQ0tMTGYcYp5w1uaz++5u9wrs4LtkmTq33Fb5/ZRCJJgjL20CDu
X-Google-Smtp-Source: AGHT+IFqNOywEQFDFlwgeDlxRO3WNpYDJNbPVWHen6wjoWkGlzI+6QbrUFISNJr05cT0XnCgW6+Gvg==
X-Received: by 2002:adf:ce82:0:b0:367:9876:df84 with SMTP id ffacd0b85a97d-3679de74c00mr7414454f8f.71.1720452770274;
        Mon, 08 Jul 2024 08:32:50 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab748sm68991f8f.111.2024.07.08.08.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 08:32:49 -0700 (PDT)
Message-ID: <22a73439-4925-1a02-ba00-f84e9d28249b@gmail.com>
Date: Mon, 8 Jul 2024 17:32:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/9] fs: add infrastructure for multigrain timestamps
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>, kernel-team@fb.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
 <20240705-mgtime-v3-1-85b2daa9b335@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20240705-mgtime-v3-1-85b2daa9b335@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5. 07. 24 19:02, Jeff Layton wrote:
> The VFS has always used coarse-grained timestamps when updating the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away a lot metadata updates, down to around 1
> per jiffy, even when a file is under heavy writes.
> 
> Unfortunately, this has always been an issue when we're exporting via
> NFSv3, which relies on timestamps to validate caches. A lot of changes
> can happen in a jiffy, so timestamps aren't sufficient to help the
> client decide when to invalidate the cache. Even with NFSv4, a lot of
> exported filesystems don't properly support a change attribute and are
> subject to the same problems with timestamp granularity. Other
> applications have similar issues with timestamps (e.g backup
> applications).
> 
> If we were to always use fine-grained timestamps, that would improve the
> situation, but that becomes rather expensive, as the underlying
> filesystem would have to log a lot more metadata updates.
> 
> What we need is a way to only use fine-grained timestamps when they are
> being actively queried. Use the (unused) top bit in inode->i_ctime_nsec
> as a flag that indicates whether the current timestamps have been
> queried via stat() or the like. When it's set, we allow the kernel to
> use a fine-grained timestamp iff it's necessary to make the ctime show
> a different value.
> 
> This solves the problem of being able to distinguish the timestamp
> between updates, but introduces a new problem: it's now possible for a
> file being changed to get a fine-grained timestamp. A file that is
> altered just a bit later can then get a coarse-grained one that appears
> older than the earlier fine-grained time. This violates timestamp
> ordering guarantees.
> 
> To remedy this, keep a global monotonic ktime_t value that acts as a
> timestamp floor.  When we go to stamp a file, we first get the latter of
> the current floor value and the current coarse-grained time. If the
> inode ctime hasn't been queried then we just attempt to stamp it with
> that value.
> 
> If it has been queried, then first see whether the current coarse time
> is later than the existing ctime. If it is, then we accept that value.
> If it isn't, then we get a fine-grained time and try to swap that into
> the global floor. Whether that succeeds or fails, we take the resulting
> floor time, convert it to realtime and try to swap that into the ctime.
> 
> We take the result of the ctime swap whether it succeeds or fails, since
> either is just as valid.
> 
> Filesystems can opt into this by setting the FS_MGTIME fstype flag.
> Others should be unaffected (other than being subject to the same floor
> value as multigrain filesystems).
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/inode.c         | 172 ++++++++++++++++++++++++++++++++++++++++++++---------
>   fs/stat.c          |  36 ++++++++++-
>   include/linux/fs.h |  34 ++++++++---
>   3 files changed, 205 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index f356fe2ec2b6..844ff0750959 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -60,6 +60,12 @@ static unsigned int i_hash_shift __ro_after_init;
>   static struct hlist_head *inode_hashtable __ro_after_init;
>   static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
>   
> +/*
> + * This represents the latest time that we have handed out as a
> + * timestamp on the system. Tracked as a MONOTONIC value, and
> + * converted to the realtime clock on an as-needed basis.
> + */
> +static __cacheline_aligned_in_smp ktime_t ctime_floor;
>   /*
>    * Empty aops. Can be used for the cases where the user does not
>    * define any of the address_space operations.
> @@ -2127,19 +2133,72 @@ int file_remove_privs(struct file *file)
>   }
>   EXPORT_SYMBOL(file_remove_privs);
>   
> +/**
> + * coarse_ctime - return the current coarse-grained time
> + * @floor: current ctime_floor value
> + *
> + * Get the coarse-grained time, and then determine whether to
> + * return it or the current floor value. Returns the later of the
> + * floor and coarse grained timestamps, converted to realtime
> + * clock value.
> + */
> +static ktime_t coarse_ctime(ktime_t floor)
> +{
> +	ktime_t coarse = ktime_get_coarse();
> +
> +	/* If coarse time is already newer, return that */
> +	if (!ktime_after(floor, coarse))
> +		return ktime_mono_to_real(coarse);
> +	return ktime_mono_to_real(floor);
> +}
> +
> +/**
> + * current_time - Return FS time (possibly fine-grained)
> + * @inode: inode.
> + *
> + * Return the current time truncated to the time granularity supported by
> + * the fs, as suitable for a ctime/mtime change. If the ctime is flagged
> + * as having been QUERIED, get a fine-grained timestamp.
> + */
> +struct timespec64 current_time(struct inode *inode)
> +{
> +	ktime_t floor = smp_load_acquire(&ctime_floor);
> +	ktime_t now = coarse_ctime(floor);
> +	struct timespec64 now_ts = ktime_to_timespec64(now);
> +	u32 cns;
> +
> +	if (!is_mgtime(inode))
> +		goto out;
> +
> +	/* If nothing has queried it, then coarse time is fine */
> +	cns = smp_load_acquire(&inode->i_ctime_nsec);
> +	if (cns & I_CTIME_QUERIED) {
> +		/*
> +		 * If there is no apparent change, then
> +		 * get a fine-grained timestamp.
> +		 */
> +		if (now_ts.tv_nsec == (cns & ~I_CTIME_QUERIED))
> +			ktime_get_real_ts64(&now_ts);
> +	}
> +out:
> +	return timestamp_truncate(now_ts, inode);
> +}
> +EXPORT_SYMBOL(current_time);
> +
>   static int inode_needs_update_time(struct inode *inode)
>   {
> +	struct timespec64 now, ts;
>   	int sync_it = 0;
> -	struct timespec64 now = current_time(inode);
> -	struct timespec64 ts;
>   
>   	/* First try to exhaust all avenues to not sync */
>   	if (IS_NOCMTIME(inode))
>   		return 0;
>   
> +	now = current_time(inode);
> +
>   	ts = inode_get_mtime(inode);
>   	if (!timespec64_equal(&ts, &now))
> -		sync_it = S_MTIME;
> +		sync_it |= S_MTIME;
>   
>   	ts = inode_get_ctime(inode);
>   	if (!timespec64_equal(&ts, &now))
> @@ -2507,6 +2566,14 @@ void inode_nohighmem(struct inode *inode)
>   }
>   EXPORT_SYMBOL(inode_nohighmem);
>   
> +struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
> +{
> +	inode->i_ctime_sec = ts.tv_sec;
> +	inode->i_ctime_nsec = ts.tv_nsec & ~I_CTIME_QUERIED;
> +	return ts;
> +}
> +EXPORT_SYMBOL(inode_set_ctime_to_ts);
> +
>   /**
>    * timestamp_truncate - Truncate timespec to a granularity
>    * @t: Timespec
> @@ -2538,38 +2605,89 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
>   }
>   EXPORT_SYMBOL(timestamp_truncate);
>   
> -/**
> - * current_time - Return FS time
> - * @inode: inode.
> - *
> - * Return the current time truncated to the time granularity supported by
> - * the fs.
> - *
> - * Note that inode and inode->sb cannot be NULL.
> - * Otherwise, the function warns and returns time without truncation.
> - */
> -struct timespec64 current_time(struct inode *inode)
> -{
> -	struct timespec64 now;
> -
> -	ktime_get_coarse_real_ts64(&now);
> -	return timestamp_truncate(now, inode);
> -}
> -EXPORT_SYMBOL(current_time);
> -
>   /**
>    * inode_set_ctime_current - set the ctime to current_time
>    * @inode: inode
>    *
> - * Set the inode->i_ctime to the current value for the inode. Returns
> - * the current value that was assigned to i_ctime.
> + * Set the inode's ctime to the current value for the inode. Returns
> + * the current value that was assigned. If this is a not multigrain inode,
> + * then we just set it to whatever the coarse_ctime is.
> + *
> + * If it is multigrain, then we first see if the coarse-grained
> + * timestamp is distinct from what we have. If so, then we'll just use
> + * that. If we have to get a fine-grained timestamp, then do so, and
> + * try to swap it into the floor. We accept the new floor value
> + * regardless of the outcome of the cmpxchg. After that, we try to
> + * swap the new value into i_ctime_nsec. Again, we take the resulting
> + * ctime, regardless of the outcome of the swap.
>    */
>   struct timespec64 inode_set_ctime_current(struct inode *inode)
>   {
> -	struct timespec64 now = current_time(inode);
> +	ktime_t now, floor = smp_load_acquire(&ctime_floor);
> +	struct timespec64 now_ts;
> +	u32 cns, cur;
> +
> +	now = coarse_ctime(floor);
> +
> +	/* Just return that if this is not a multigrain fs */
> +	if (!is_mgtime(inode)) {
> +		now_ts = ktime_to_timespec64(now);
> +		inode_set_ctime_to_ts(inode, now_ts);
> +		goto out;
> +	}
>   
> -	inode_set_ctime_to_ts(inode, now);
> -	return now;
> +	/*
> +	 * We only need a fine-grained time if someone has queried it,
> +	 * and the current coarse grained time isn't later than what's
> +	 * already there.
> +	 */
> +	cns = smp_load_acquire(&inode->i_ctime_nsec);
> +	if (cns & I_CTIME_QUERIED) {
> +		ktime_t ctime = ktime_set(inode->i_ctime_sec, cns & ~I_CTIME_QUERIED);
> +
> +		if (!ktime_after(now, ctime)) {
> +			ktime_t old, fine;
> +
> +			/* Get a fine-grained time */
> +			fine = ktime_get();
> +
> +			/*
> +			 * If the cmpxchg works, we take the new floor value. If
> +			 * not, then that means that someone else changed it after we
> +			 * fetched it but before we got here. That value is just
> +			 * as good, so keep it.
> +			 */
> +			old = cmpxchg(&ctime_floor, floor, fine);
> +			if (old != floor)
> +				fine = old;

The above can be rewritten using try_cmpxchg() to produce slightly
better (and faster) code:

old = floor;
if (!try_cmpxchg(&ctime_floor, &old, fine)
   fine = old;

try_cmpxchg() updates old on failure.

> +			now = ktime_mono_to_real(fine);
> +		}
> +	}
> +	now_ts = ktime_to_timespec64(now);
> +retry:
> +	/* Try to swap the nsec value into place. */
> +	cur = cmpxchg(&inode->i_ctime_nsec, cns, now_ts.tv_nsec);
> +
> +	/* If swap occurred, then we're (mostly) done */
> +	if (cur == cns) {
> +		inode->i_ctime_sec = now_ts.tv_sec;
> +	} else {

The above can be rewritten to:

retry:
   /* Try to swap the nsec value into place. */
   cur = cns;
   if (try_cmpxchg(&inode->i_ctime_ns, &cur, now_ts.tv_nsec) {
     /* If swap occurred, then we're (mostly) done */
     inode->i_ctime_sec = now_ts.tv_sec;
   } else {
     ...

in the else arm, cur will have the return value from CMPXCHG 
instruction, as in the original source. Please note that try_cmpxchg() 
updates cur only on failure.

For x86 targets, the proposed form will avoid extra CMP instruction and
will use zero-flag result of the CMPXCHG instruction instead.

Best regards,
Uros.

> +		/*
> +		 * Was the change due to someone marking the old ctime QUERIED?
> +		 * If so then retry the swap. This can only happen once since
> +		 * the only way to clear I_CTIME_QUERIED is to stamp the inode
> +		 * with a new ctime.
> +		 */
> +		if (!(cns & I_CTIME_QUERIED) && (cns | I_CTIME_QUERIED) == cur) {
> +			cns = cur;
> +			goto retry;
> +		}
> +		/* Otherwise, keep the existing ctime */
> +		now_ts.tv_sec = inode->i_ctime_sec;
> +		now_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
> +	}
> +out:
> +	return timestamp_truncate(now_ts, inode);
>   }
>   EXPORT_SYMBOL(inode_set_ctime_current);
>   
> diff --git a/fs/stat.c b/fs/stat.c
> index 6f65b3456cad..df7fdd3afed9 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -26,6 +26,32 @@
>   #include "internal.h"
>   #include "mount.h"
>   
> +/**
> + * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
> + * @stat: where to store the resulting values
> + * @request_mask: STATX_* values requested
> + * @inode: inode from which to grab the c/mtime
> + *
> + * Given @inode, grab the ctime and mtime out if it and store the result
> + * in @stat. When fetching the value, flag it as queried so the next write
> + * will ensure a distinct timestamp.
> + */
> +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
> +{
> +	atomic_t *pcn = (atomic_t *)&inode->i_ctime_nsec;
> +
> +	/* If neither time was requested, then don't report them */
> +	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
> +		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
> +		return;
> +	}
> +
> +	stat->mtime = inode_get_mtime(inode);
> +	stat->ctime.tv_sec = inode->i_ctime_sec;
> +	stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn)) & ~I_CTIME_QUERIED;
> +}
> +EXPORT_SYMBOL(fill_mg_cmtime);
> +
>   /**
>    * generic_fillattr - Fill in the basic attributes from the inode struct
>    * @idmap:		idmap of the mount the inode was found from
> @@ -58,8 +84,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
>   	stat->rdev = inode->i_rdev;
>   	stat->size = i_size_read(inode);
>   	stat->atime = inode_get_atime(inode);
> -	stat->mtime = inode_get_mtime(inode);
> -	stat->ctime = inode_get_ctime(inode);
> +
> +	if (is_mgtime(inode)) {
> +		fill_mg_cmtime(stat, request_mask, inode);
> +	} else {
> +		stat->ctime = inode_get_ctime(inode);
> +		stat->mtime = inode_get_mtime(inode);
> +	}
> +
>   	stat->blksize = i_blocksize(inode);
>   	stat->blocks = inode->i_blocks;
>   
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dc9f9c4b2572..f873f6c58669 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1608,6 +1608,17 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
>   	return inode_set_mtime_to_ts(inode, ts);
>   }
>   
> +/*
> + * Multigrain timestamps
> + *
> + * Conditionally use fine-grained ctime and mtime timestamps when there
> + * are users actively observing them via getattr. The primary use-case
> + * for this is NFS clients that use the ctime to distinguish between
> + * different states of the file, and that are often fooled by multiple
> + * operations that occur in the same coarse-grained timer tick.
> + */
> +#define I_CTIME_QUERIED		((u32)BIT(31))
> +
>   static inline time64_t inode_get_ctime_sec(const struct inode *inode)
>   {
>   	return inode->i_ctime_sec;
> @@ -1615,7 +1626,7 @@ static inline time64_t inode_get_ctime_sec(const struct inode *inode)
>   
>   static inline long inode_get_ctime_nsec(const struct inode *inode)
>   {
> -	return inode->i_ctime_nsec;
> +	return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
>   }
>   
>   static inline struct timespec64 inode_get_ctime(const struct inode *inode)
> @@ -1626,13 +1637,7 @@ static inline struct timespec64 inode_get_ctime(const struct inode *inode)
>   	return ts;
>   }
>   
> -static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
> -						      struct timespec64 ts)
> -{
> -	inode->i_ctime_sec = ts.tv_sec;
> -	inode->i_ctime_nsec = ts.tv_nsec;
> -	return ts;
> -}
> +struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts);
>   
>   /**
>    * inode_set_ctime - set the ctime in the inode
> @@ -2490,6 +2495,7 @@ struct file_system_type {
>   #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
>   #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
>   #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
> +#define FS_MGTIME		64	/* FS uses multigrain timestamps */
>   #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>   	int (*init_fs_context)(struct fs_context *);
>   	const struct fs_parameter_spec *parameters;
> @@ -2513,6 +2519,17 @@ struct file_system_type {
>   
>   #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
>   
> +/**
> + * is_mgtime: is this inode using multigrain timestamps
> + * @inode: inode to test for multigrain timestamps
> + *
> + * Return true if the inode uses multigrain timestamps, false otherwise.
> + */
> +static inline bool is_mgtime(const struct inode *inode)
> +{
> +	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
> +}
> +
>   extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>   	int flags, const char *dev_name, void *data,
>   	int (*fill_super)(struct super_block *, void *, int));
> @@ -3252,6 +3269,7 @@ extern void page_put_link(void *);
>   extern int page_symlink(struct inode *inode, const char *symname, int len);
>   extern const struct inode_operations page_symlink_inode_operations;
>   extern void kfree_link(void *);
> +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode);
>   void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
>   void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
>   extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
> 

