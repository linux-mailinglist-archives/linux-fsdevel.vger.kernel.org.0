Return-Path: <linux-fsdevel+bounces-22225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38FC91446D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 10:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999C8283D75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87549655;
	Mon, 24 Jun 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0CqxiHv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E084965C;
	Mon, 24 Jun 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217043; cv=none; b=V3p5cOxb+CyZft9Hto55jFH1A8JOdicnkMEiS85y7SaUQa7OWBiU6+kipS+Ih2KU9ZlVSNjqjOyiXegLOvXQtUM//C/BXMOmSl+VCtyL6yR47oBfMU97F4Sg9jfcv0CCxbGqd4VTHd65mRDb1htBtB5hCcf8k/doxXN9v8uSrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217043; c=relaxed/simple;
	bh=zlxB2LL39UkXj/WY6DoZ05vbz2yJfbl6Uuo+hzij+Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ44u9FXyXierICzy+WvA0Ev2B5aRLEMJSxz/cQc46BMP80EnWbgajNTueoxquX60tRyVo/NI6dgMWc6Uqj6PV+iBLaxShMnhbLNHJ+nVGS7kgkHzX++ETgYhRFlsTazrChUH1dZqbCwqqU6G8lLb3YkewppHs4acRTrMh2/Gr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0CqxiHv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso7120872a12.1;
        Mon, 24 Jun 2024 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719217040; x=1719821840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQqbHSkqEg8UIT4DFzvDECtddkt78IAjLyY6LQO60XA=;
        b=d0CqxiHv5IX7xS+/PfOROO5eN+NqGRIfjxHseq+xfohfK5e/SCHfjXs+hxCLj/cXN8
         d2ZNaAbc+IdRQEMMwqYepKA7TsK6o+rQ6SuHli5vgafyx3RyAbH6wlU26PN9bowrUZtz
         BnZmAS/JlChxZZl4gXnvLnNq7+LA1j6ikaQ4ZvT7Ur9hQiF1DziwAEuOMi2WHCIpw/sX
         dBbbs6x669gOaE3OODJNpkCI9/iSLbNn5ewZWR+fz0N928IyLG+c5aBMt+dcWIJI7vcO
         esvq7AZLdH5wmS9u53XWBmlnVTkLO/iukX8o7FEleUR5BzYBw06Vtn0OZc3EXK8ODLQH
         NW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217040; x=1719821840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQqbHSkqEg8UIT4DFzvDECtddkt78IAjLyY6LQO60XA=;
        b=d8q8Kpk0Wlf0dkiSZU/6GS/dYGMmyCsFMZ7Pbs8dW9aSGBxbEc3LwXs9o+E6hiMtB/
         o/J/O3mZs4WA80z+lx25sR+lZRHL14yrKRmqRoNLOxa7UwchcKJQUy5IuvpccYwraNpk
         rOk+zc6Nwushkzw1Q3fEByYC1usutP3LVh2RgacDdDVewpMsP3N+bZz1Hqbw45AQSr7S
         fJhLGM9wjD179UuQ78ana0GM68LyGk1PH/TaTCB/Th9Cnz1OwJ6nDVBXna9vPjjTh2JG
         Ky+PdrucD5jBZ4F/j2HWv3cQZccBhiQkM1ntwZLC7KaGHkH/xwTHjpecUIL4bkFFQNLs
         nWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWshQzOlVT8g0JYvrKZ/FUN46DQfd/xyUTsvHR7qt1uH+QCMYRfImsSaa4QuWhSUfXsMpNWdQhkXic5sEdPzeny1IsEfJDSL7wuAwzPZy4r2NodWl/uRgPbyv8mFQmJx8JrfsEa8bSLlOHl9w==
X-Gm-Message-State: AOJu0YwfYw6NQFo5WTSuMUeytRXhUu6sdEbWvzbGGw+qHdX3gh1ALXGR
	DnC4nze5riNqLBcg66xzJJE/eu+Ep77lX9Ve6QyskgUDJWodEHbH
X-Google-Smtp-Source: AGHT+IEgDXbhNOqfnHDw/RFFKZaSiw6LDw+WjOtm/3URZplVmEWC705lBJRJnwjprOQFPpv/eurX5g==
X-Received: by 2002:a50:8d58:0:b0:57c:70b4:7ac with SMTP id 4fb4d7f45d1cf-57d44c41970mr3855799a12.15.1719217039737;
        Mon, 24 Jun 2024 01:17:19 -0700 (PDT)
Received: from f (cst-prg-81-171.cust.vodafone.cz. [46.135.81.171])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30427f8fsm4471791a12.34.2024.06.24.01.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:17:19 -0700 (PDT)
Date: Mon, 24 Jun 2024 10:17:12 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: linux-mm@kvack.org
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: wrap CONFIG_READ_ONLY_THP_FOR_FS-related code
 with an ifdef
Message-ID: <zjoqxuejv3irj7taola5kgrla6mvns4o2tckep4oi4cvdk26im@fkq762sitjzm>
References: <20240624074135.486845-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624074135.486845-1-mjguzik@gmail.com>

On Mon, Jun 24, 2024 at 09:41:34AM +0200, Mateusz Guzik wrote:
> On kernels compiled without this option (which is currently the default
> state) filemap_nr_thps expands to 0.
> 
> do_dentry_open has a big chunk dependent on it, most of which gets
> optimized away, except for a branch and a full fence:
> 
> if (f->f_mode & FMODE_WRITE) {
> [snip]
>         smp_mb();
>         if (filemap_nr_thps(inode->i_mapping)) {
> [snip]
> 	}
> }
> 
> While the branch is pretty minor the fence really does not need to be
> there.
> 

[the To: recipient bounces, thus got dropped]

Now that I sent this I remembered that some of the atomic ops in Linux
provide a full fence regardless of an architecture.

get_write_access uses atomic_inc_unless_negative which qualifies?

  1551 static __always_inline bool
  1552 atomic_inc_unless_negative(atomic_t *v)
  1553 {
  1554 │       kcsan_mb();
  1555 │       instrument_atomic_read_write(v, sizeof(*v));
  1556 │       return raw_atomic_inc_unless_negative(v);
  1557 }

If so, the ifdefed-out smp_mb can be eliminated altogether if I got my
fences right.

On top of that mnt_get_write_access injects another smp_mb() anyway.

> This is a bare-minimum patch which takes care of it until someone(tm)
> cleans this up. Notably it does not conditionally compile other spots
> which issue the matching fence.
> 
> I did not bother benchmarking it, not issuing a spurious full fence in
> the fast path does not warrant justification from perf standpoint.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> I am not particularly familiar with any of this, the smp_mb in the open
> for write path was sticking out like a sore thumb on code read so I
> figured there may be One Weird Trick to whack it.
> 
> If the stock code is correct as is, then the ifdef as above is fine.
> 
> The ifdefed chunk is big enough that it should probably be its own
> routine. I don't want to bikeshed so I did not go for it.
> 
> For a moment I considered adding filemap_nr_thps_mb which would expand
> to 0 or issue the fence + do the read, but then I figured a routine
> claiming to post a fence and only conditionally do it is misleading at
> best.
> 
> As per the commit message fences in collapse_file remain compiled in.
> It is unclear to me if the code following them is doing anything useful
> on kernels !CONFIG_READ_ONLY_THP_FOR_FS.
> 
> All that said, if there is cosmetic touch ups you want done here, I can
> do them.
> 
> However, a nice full patch would take care of all of the above and I
> have neither the information needed to do it nor the interest to get it,
> so should someone insinst on a full version I'm going to suggest they
> write it themselves. I repeat this is merely a damage control until
> someone sorts thigs out.
> 
>  fs/open.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 28f2fcbebb1b..654c300b3c33 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -980,6 +980,7 @@ static int do_dentry_open(struct file *f,
>  	if ((f->f_flags & O_DIRECT) && !(f->f_mode & FMODE_CAN_ODIRECT))
>  		return -EINVAL;
>  
> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
>  	/*
>  	 * XXX: Huge page cache doesn't support writing yet. Drop all page
>  	 * cache for this file before processing writes.
> @@ -1007,6 +1008,7 @@ static int do_dentry_open(struct file *f,
>  			filemap_invalidate_unlock(inode->i_mapping);
>  		}
>  	}
> +#endif
>  
>  	return 0;
>  
> -- 
> 2.43.0
> 

