Return-Path: <linux-fsdevel+bounces-27489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA364961C2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395C71F24AE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95EC4779F;
	Wed, 28 Aug 2024 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NLRH7WcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C863AC2B
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812574; cv=none; b=cEWQlJ8Xpb38HNd4nCUinHRCrXC6M6Ng0JPkmg53+oPb83ujHsDos7fsCiLtMAX/LCxMzWyvufgmkxkU3KzDW3q6RbbWpZdB/IAyeXyvOLWEEEPORcitOfV6bdccjihuJicMe44va+5SmqqM43WQPT/wcb7txba8WC9HWpLDlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812574; c=relaxed/simple;
	bh=wWLsgT/FQIv6sU5ymr/qnRCPMfA4zCNZFHWLSbkw2ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrMLsmva5zRhud0vLQb4Jq541nApeSKlOsY3i7lZteB75ySRtdcxgG12Er26fg5j4Wtl0e3Q1811e1tjgLEbt8FNNk/Oh1gU7IzfLdnpQ/NjzjiJ+agFMcSSGD4950YoqBNXR4JioEXIY5Iz7j4jDKs90/qScVsaU8BGXw7Skqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NLRH7WcS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201f7fb09f6so53406165ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 19:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724812571; x=1725417371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+TZHjkWTFzawcgL5c/YAk6Y9VsBIUN9NZV7T2LiEuc=;
        b=NLRH7WcSum1++oZJvezLp2F1/o6wIZmGTaGryO+zQRPLMNdJHhqIthJpyreBmNlUe3
         r8HbNVBSYNgWqPFBWUA+YHIT7g7g4Tam8bR6ZRzd5GaOGK2b05gVmm/gyhD0puPsvQPF
         UDTKoJJ8wVcPVoTKrq4Db94fG8rQO2LLmL5S+1g0KpwS58DN0O57aDO6ZldVW+JMSiwH
         NBY1SP6YLdyLmZCHaoe0DDDCPmYJeE+eJq0QxZ4Glic+3hFamSkr6+I2hTFUMOZS5g5y
         mHus5iDJ07whtgdarcUreYoc6HZDkxMc/QE1ZTcrV+i73Pd53ueWvNNfNVyr4QAHG0l/
         JCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724812571; x=1725417371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+TZHjkWTFzawcgL5c/YAk6Y9VsBIUN9NZV7T2LiEuc=;
        b=S093BurI8iMLrmmWelaPvAX7XmIwhad8kv3TE/Nuq6DNWmUyX4GHZFnt0YUCAv0EZr
         i4aIPzG0xGfPqkCRLSF4xgQm+m1G82R3EIP9s/sNEeNu4A/4iTwGxbtYA//7FP8tvTAK
         aaRsSkblFASwaWX4pc//wz6HiYzTl9m8ZnJKBWzIMEG3W1PGOXB8kbW0v8+8FAPj7Noi
         zWe8ULlW6jrokOk6dxIT4iMKohjGM9nIklKLL2R7XO7fkI2v+LdmT6JumtGzDfMECekw
         dVVZSS1wy/X/tHWGffL559C0grQSFblITVtKj95YBB/5qJPZIpEOOWKYCJstq7hdzSgi
         XZlA==
X-Gm-Message-State: AOJu0YwZdnPvIMdAoble+MukjKNRbcXdbg9sgJHgCE18z2alR7q4S0IS
	n6lVOV8Zs7oPyzmJHiyYAPqR7Hs8RmTZ+qaJGJjzCJv2exGQ7w3k0xYGJyuBDfDAyzU6YFlhLtb
	q
X-Google-Smtp-Source: AGHT+IEyqvxFYY+dbjkO31rmSGQ2hV432+7XnIJ/GMcJzG6x5EY6O/nt2F4jPCFthVWM+sD4+vmasA==
X-Received: by 2002:a17:903:40c6:b0:1fd:a264:9433 with SMTP id d9443c01a7336-2039e4ad2f5mr142880175ad.29.1724812571524;
        Tue, 27 Aug 2024 19:36:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557f04asm89600055ad.85.2024.08.27.19.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 19:36:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sj8XY-00FFBv-1n;
	Wed, 28 Aug 2024 12:36:08 +1000
Date: Wed, 28 Aug 2024 12:36:08 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 03/10] mm: shrinker: Add new stats for .to_text()
Message-ID: <Zs6NGGWZrw6ddDum@dread.disaster.area>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
 <20240824191020.3170516-4-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824191020.3170516-4-kent.overstreet@linux.dev>

On Sat, Aug 24, 2024 at 03:10:10PM -0400, Kent Overstreet wrote:
> Add a few new shrinker stats.
> 
> number of objects requested to free, number of objects freed:
> 
> Shrinkers won't necessarily free all objects requested for a variety of
> reasons, but if the two counts are wildly different something is likely
> amiss.
> 
> .scan_objects runtime:
> 
> If one shrinker is taking an excessive amount of time to free
> objects that will block kswapd from running other shrinkers.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/shrinker.h |  6 ++++++
>  mm/shrinker.c            | 23 ++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 6193612617a1..106622ddac77 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -118,6 +118,12 @@ struct shrinker {
>  #endif
>  	/* objs pending delete, per node */
>  	atomic_long_t *nr_deferred;
> +
> +	atomic_long_t	objects_requested_to_free;
> +	atomic_long_t	objects_freed;
> +	unsigned long	last_freed;	/* timestamp, in jiffies */
> +	unsigned long	last_scanned;	/* timestamp, in jiffies */
> +	atomic64_t	ns_run;
>  };
>  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
>  
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index ad52c269bb48..feaa8122afc9 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -430,13 +430,24 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	       total_scan >= freeable) {
>  		unsigned long ret;
>  		unsigned long nr_to_scan = min(batch_size, total_scan);
> +		u64 start_time = ktime_get_ns();
> +
> +		atomic_long_add(nr_to_scan, &shrinker->objects_requested_to_free);
>  
>  		shrinkctl->nr_to_scan = nr_to_scan;
>  		shrinkctl->nr_scanned = nr_to_scan;
>  		ret = shrinker->scan_objects(shrinker, shrinkctl);
> +
> +		atomic64_add(ktime_get_ns() - start_time, &shrinker->ns_run);
>  		if (ret == SHRINK_STOP)
>  			break;
>  		freed += ret;
> +		unsigned long now = jiffies;
> +		if (ret) {
> +			atomic_long_add(ret, &shrinker->objects_freed);
> +			shrinker->last_freed = now;
> +		}
> +		shrinker->last_scanned = now;
>  
>  		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
>  		total_scan -= shrinkctl->nr_scanned;

Doing this inside the tight loop (adding 3 atomics and two calls to
ktime_get_ns()) is total overkill. Such fine grained accounting
doesn't given any extra insight into behaviour compared to
accounting the entire loop once.

e.g. the actual time the shrinker takes to run is the time the whole
loop takes to run, not only the individual shrinker->scan_objects
call.

The shrinker code already calculates the total objects scanned and
the total objects freed by the entire loop, so there is no reason to
be calculating this again using much more expensive atomic
operations.

And these are diagnostic stats - the do not need to be perfectly
correct and so atomics are unnecessary overhead the vast majority of
the time.  This code will have much lower impact on runtime overhead
written like this:

	start_time = ktime_get_ns();

	while (total_scan >= batch_size ||
               total_scan >= freeable) {
	.....
	}

	shrinker->objects_requested_to_free += scanned;
	shrinker->objects_freed += freed;

	end_time = ktime_get_ns();
	shrinker->ns_run += end_time - start_time;
	shrinker->last_scanned = end_time;
	if (freed)
		shrinker->last_freed = end_time;

And still give pretty much the exact same debug information without
any additional runtime overhead....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

