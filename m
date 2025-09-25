Return-Path: <linux-fsdevel+bounces-62787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A077BA0D43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 19:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E316C0EAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 17:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE930DD06;
	Thu, 25 Sep 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpwD4ftG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A734217704
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821170; cv=none; b=PeO6i9GXU2IkHK8HqTrWXuRY6MJdfgI3UrMlDlw2hNrq71tvZZesf5e59Rg4tG9oum9kuNoMpNX8ZRj3QPG+kddxDGpr1qw0hLCb8ev9gGW+tgma0H3u3b43UwclWo+LstK2TWxTLjDkvY9kMHcmtuYgs6K37PC6LYVbkqMKhao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821170; c=relaxed/simple;
	bh=H67Sb6S85F7sQKs6V/VU5yfv0XnrQx+pr9y3JRLPiEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLpyRyR4hhZoeHV4NCPQHUyUxSW1yq0wiSIMTXprixG7wpQW4a3o5QoDce5L/X8EIMjGUAfFD37lMbb6xLKSzVQDB3j2sy4z73DocOsSkrhpR2dKVzMJzy83Zqa3XxTuezUVBHhRVMSGWffUBRuKXAw27TiWriLENqz55m8Xghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpwD4ftG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso9202205e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758821167; x=1759425967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXSdRU5DiYVwLdzAHJkuUpk0QScKJI6kmuRehqav+00=;
        b=IpwD4ftGIdlScVSLTUPVvI2EZcLljt3+u97RnelkKEQ2Tx0QpRro8FCjgOZIqvWFzE
         uIbckAjoSYa2szMGfwptcwaV65kd2/113ZVULIPQfEMoPvMpGyyLQJHJGu60pDYv9o9F
         L6eNYPZgAEO51HfgunbOoRd1U6cZjtA/CXgIlbW8f+NT4FdfZwbB4ZN2ApsRyTk9sQc+
         rF7GZ54Fl9znGdNQ5kepFLTdc5M4bgqWwk4wS3fbS/f1h6xREBvYCvC8ZIlEbXmO9zao
         FwF7dmu7dHZX/Ti41M7dWYc9LnVaCrYkys1lD81DcnPLaqOwY9q6xwEyVOFcsPpb5s1J
         fm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821167; x=1759425967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXSdRU5DiYVwLdzAHJkuUpk0QScKJI6kmuRehqav+00=;
        b=jJhqAhFJn0mIJOlIJcJyPLPxDysPaTKaecqtDh5iKMMlcGVmJ+3MVvh5D0MAsvEonG
         EcesR856U27vB0EHM7aH+FLgcqoiNMNeL6dPCS5NjKeRBkTZr4SviMlKiuXXBvx9Al5o
         57FdS+hedxJl8up6CwcZ2ySupZnMiDNcU/alB1IrmUXy/fboier7dn/tyvDwMFMKvRy8
         kKOYtYIJ8lgKM0izjp0ryA9NtSysxpg7n3QKt+diu/pWpo4pZjEaIUGZmGrLXVFj/UWq
         k2LCfv6dp+5QJWe5aytkjrMy9V6btklWYbjBojUkl6dMcIEIUUkOmEmfrVIJ9muausOp
         8jog==
X-Gm-Message-State: AOJu0Yz16zsJ3RE27vdBv1uR1+2exH39rMHLCyvLxfoFOeBmKQ0FNkyK
	8trib8TaVH9HqUyTmTQDotEQUBEj2Ddqc5vkMePbTVBja+EnFP3AbXCreFSi9Q==
X-Gm-Gg: ASbGncurn0XC255IOmXJTnwXZdUnu6hjPBgtN3lFX/a1BJ36sF4Pop9C6XvFXkFURu/
	Bk+4vj/uA1r55yfKGXzHJDisYsKVbol/AmxP/AVlCU6zhvy1ubUpsZ3c83UH3ZmEc8Ki02U0z6d
	VWF0JZJFU6wjJRx2ScPA8bv24k2VDK05F28PLZmt6W5GWsfPRpzSS6Bnqcx3LUlyj5KMlRkvO/d
	DEzTKQ88XzGG5WX3DdEom7SMivPpipCX+J1+HMJmXITgi74wShjIO5JAcv9m1BOt7Jv1Mr9YHu/
	6QuguTVf7BQJ2JfeNxXRinXHvpGTZYa6iMvvGLTFPTf8XM3rpI4DtjsVUDBIF5PI1yyzRB4nLMK
	KdqEmDHuMXdoS7YaYUawkvmaOrDI4bMamw8bjoAUCaNF9pnxc4m8BpiJLRuQEgP1qzOg=
X-Google-Smtp-Source: AGHT+IGQBGrTF35EEW/xQ1PexeeoQNFhzCOCpdTjPNtLc1NGsLj2W8QRya2mTBCB16JsOxFNp4rO/w==
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr42890265e9.0.1758821166311;
        Thu, 25 Sep 2025 10:26:06 -0700 (PDT)
Received: from f (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e330fbcc5sm21339405e9.4.2025.09.25.10.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 10:26:05 -0700 (PDT)
Date: Thu, 25 Sep 2025 19:25:57 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, peterz@infradead.org
Subject: Re: [PATCH] write-back: Wake up waiting tasks when finishing the
 writeback of a chunk.
Message-ID: <fylfqtj5wob72574qjkm7zizc7y4ieb2tanzqdexy4wcgtgov4@h25bh2fsklfn>
References: <20250925132239.2145036-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250925132239.2145036-1-sunjunchao@bytedance.com>

On Thu, Sep 25, 2025 at 09:22:39PM +0800, Julian Sun wrote:
> Writing back a large number of pages can take a lots of time.
> This issue is exacerbated when the underlying device is slow or
> subject to block layer rate limiting, which in turn triggers
> unexpected hung task warnings.
> 
> We can trigger a wake-up once a chunk has been written back and the
> waiting time for writeback exceeds half of
> sysctl_hung_task_timeout_secs.
> This action allows the hung task detector to be aware of the writeback
> progress, thereby eliminating these unexpected hung task warnings.
> 

If I'm reading correctly this is also messing with stats how long the
thread was stuck to begin with.

Perhaps it would be better to have a var in task_struct which would
serve as an indicator of progress being made (e.g., last time stamp of
said progress).

task_struct already has numerous holes so this would not have to grow it
above what it is now.


> This patch has passed the xfstests 'check -g quick' test based on ext4,
> with no additional failures introduced.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  fs/fs-writeback.c                | 13 +++++++++++--
>  include/linux/backing-dev-defs.h |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a07b8cf73ae2..475d52abfb3e 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -14,6 +14,7 @@
>   *		Additions for address_space-based writeback
>   */
>  
> +#include <linux/sched/sysctl.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
> @@ -174,9 +175,12 @@ static void finish_writeback_work(struct wb_writeback_work *work)
>  		kfree(work);
>  	if (done) {
>  		wait_queue_head_t *waitq = done->waitq;
> +		/* Report progress to inform the hung task detector of the progress. */
> +		bool force_wake = (jiffies - done->stamp) >
> +				   sysctl_hung_task_timeout_secs * HZ / 2;
>  
>  		/* @done can't be accessed after the following dec */
> -		if (atomic_dec_and_test(&done->cnt))
> +		if (atomic_dec_and_test(&done->cnt) || force_wake)
>  			wake_up_all(waitq);
>  	}
>  }
> @@ -213,7 +217,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  void wb_wait_for_completion(struct wb_completion *done)
>  {
>  	atomic_dec(&done->cnt);		/* put down the initial count */
> -	wait_event(*done->waitq, !atomic_read(&done->cnt));
> +	wait_event(*done->waitq, ({ done->stamp = jiffies; !atomic_read(&done->cnt); }));
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -1975,6 +1979,11 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 */
>  		__writeback_single_inode(inode, &wbc);
>  
> +		/* Report progress to inform the hung task detector of the progress. */
> +		if (work->done && (jiffies - work->done->stamp) >
> +		    HZ * sysctl_hung_task_timeout_secs / 2)
> +			wake_up_all(work->done->waitq);
> +
>  		wbc_detach_inode(&wbc);
>  		work->nr_pages -= write_chunk - wbc.nr_to_write;
>  		wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 2ad261082bba..c37c6bd5ef5c 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -63,6 +63,7 @@ enum wb_reason {
>  struct wb_completion {
>  	atomic_t		cnt;
>  	wait_queue_head_t	*waitq;
> +	unsigned long stamp;
>  };
>  
>  #define __WB_COMPLETION_INIT(_waitq)	\
> -- 
> 2.39.5
> 

