Return-Path: <linux-fsdevel+bounces-45404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7541AA77240
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 03:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3202116B48B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 01:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380441519A1;
	Tue,  1 Apr 2025 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vEZCj0z3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050013B298
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743469871; cv=none; b=Pp+GL2WM0c+Gd4+tPQz+LXoHUK9lcbOdEGKoltpKQbhws5hxr+9dTRTyOZjtzxvevDKjW1k4ToZW7a1kWKNu5bE+nFk37qg/9MqbeP9DYIFbnrFWRntiCCeV8Qi0BzYq0lQIR4dQ4Huff3ywTQ8HktSq/0n4CHwPHqz7RTv5JB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743469871; c=relaxed/simple;
	bh=c4VRjFgdPHYVEXSgwVTJK9NOPjH1pvGIrhY1YvoLmpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeP2Gx9MM8XnQs+OMdrm7yZnWtfqq8xuK8SCvzhrMz0ZYYlPS1O3BDStV03ZVycaYQCnO4iHFI0M3Fd9Ewwv9N3JxK0dse4gA58pLYvkh1UxrFO8tQF19TXc8riodHgBtvnOdjNMkgQ4ypvgs/9r9+IAu6ePTIQc3BLVxnlBVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vEZCj0z3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22622ddcc35so18857265ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 18:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743469868; x=1744074668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSOCXG/bLgDc7ME6ApTEkqOXZXXVJMqkGl0AyQAQOxU=;
        b=vEZCj0z3Tjcqz6RBOsS5Whdq4AUiNMkctqwkdVKEg9yxZRxzC9Fg6Fv8JMfs9r8UZd
         ACKrNII4bULPCYXSEzFsSaJVb4w/HQdFnBCnU7tkDkjQAzVebmotcu57DI3ERsmlFIK8
         zPZmEPznvvXHGU/lXDLh+yXxyiXZ3CDvxz7iu0C0VkVlAd4dNCAKoxAK2DOSJF+uUThh
         lfFgJSpUENtqATDkE0sSFfAD8R6QceelfQk4Gbtz1RHDpebBHJcO8kTPOcU97Kqo9QBo
         +E6FLFqi/PZdguLMv0Kqa81aNLkAZmqFwkoxGWe820fP5ZN99ld60s+eFFx0lkZO7pVY
         HU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743469868; x=1744074668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSOCXG/bLgDc7ME6ApTEkqOXZXXVJMqkGl0AyQAQOxU=;
        b=a5eSC0MbLhs1DwAqhVR5ug7EoGY62s3g7tc+tYGQQCaNF4+0Ckv8KksqJQ+JLIwa00
         duhZwIiJW3LlE6wFUR81N9eBZkmgT0lJDXJjrQPws5g7xqt/8kjAFP3snWWXOimIU+mm
         ElAarWZw92w6OgeQ4fZCr29tjRfTYwoIpa4fbAdOoV/PxmUEHp1ooLNyW74dkeeKiCNk
         3oj1dZEQABA4MAfGYzWoNRPOTfcuCwTItp+RXNFQti2SYFydq+qF/dvU30CsL+J4XIaL
         gVu6tgGEpQIWZpUFWwWLBus66LPqpfbW3soR2GiRQNgRZam8M9g6aKjNy92EAC0aQ9H1
         DT1Q==
X-Gm-Message-State: AOJu0YyP23sQ4eebILSVAJbTvvzSgBPqqqAxvVNqve8mvpsKTB82hhuJ
	/7hCHEhWP25yJMWgVheTVtASVP/9v8bnQ45BQxIPeb8z7PMNXyzxdqCyUYAJqZU=
X-Gm-Gg: ASbGncuWnsuEZtwkUb2N51IOtHsbd2X68AqERqopREB+Hlgy4UUeAW157Sxcxeq1OMQ
	2lCh0MELDxBdIpvIcwXJYgAQuzQ1H5kTnmMp04WIHoWuKRgqCsQGVYMCbj9gN3lxdm+YMesibuK
	9WaTGjaldxG6KJtdQcP9N3yUAFUW6FMLq/nVEQIPz+v3CAtgNTh1xn2rcx76NL/bm6bLzEy9ttg
	8mcr/ODWHOzEYh6cQL6FUxw1+C5GS7f5R54hw8gLXB3KfT+xn+HeF5AFQdZaKQMF10WHLBmhyEm
	Gra4wViwTbpnm6rCXRtegOKk2UO/HgcObnWGMNo+0Tgo765W00RESsKoshk9TyxlFr847XC4dkD
	psTFNqaLUnQZ0k0JUQPYuyOhpwK0J
X-Google-Smtp-Source: AGHT+IFLfpDROybDyATP4hEqXJeYrPhcFQxWBwYKhCahugcasGxplhhifiK5A1Cetc20wuxbo6MSnA==
X-Received: by 2002:a17:902:9689:b0:224:584:6f04 with SMTP id d9443c01a7336-2292f95d89bmr122418275ad.18.1743469868573;
        Mon, 31 Mar 2025 18:11:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73971063d24sm7614688b3a.86.2025.03.31.18.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 18:11:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tzQ9g-00000002u8k-2xKY;
	Tue, 01 Apr 2025 12:11:04 +1100
Date: Tue, 1 Apr 2025 12:11:04 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org, hch@infradead.org, rafael@kernel.org,
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] xfs: replace kthread freezing with auto fs freezing
Message-ID: <Z-s9KG-URzB9DwUb@dread.disaster.area>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <20250401-work-freeze-v1-3-d000611d4ab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-work-freeze-v1-3-d000611d4ab0@kernel.org>

On Tue, Apr 01, 2025 at 02:32:48AM +0200, Christian Brauner wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> The kernel power management now supports allowing the VFS
> to handle filesystem freezing freezes and thawing. Take advantage
> of that and remove the kthread freezing. This is needed so that we
> properly really stop IO in flight without races after userspace
> has been frozen. Without this we rely on kthread freezing and
> its semantics are loose and error prone.
> 
> The filesystem therefore is in charge of properly dealing with
> quiescing of the filesystem through its callbacks if it thinks
> it knows better than how the VFS handles it.
> 
.....

> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 0fcb1828e598..ad8183db0780 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -636,7 +636,6 @@ xfsaild(
>  	unsigned int	noreclaim_flag;
>  
>  	noreclaim_flag = memalloc_noreclaim_save();
> -	set_freezable();
>  
>  	while (1) {
>  		/*
> @@ -695,8 +694,6 @@ xfsaild(
>  
>  		__set_current_state(TASK_RUNNING);
>  
> -		try_to_freeze();
> -
>  		tout = xfsaild_push(ailp);
>  	}
>  

So what about the TASK_FREEZABLE flag that is set in this code
before sleeping?

i.e. this code before we schedule():

                if (tout && tout <= 20)
                        set_current_state(TASK_KILLABLE|TASK_FREEZABLE);
                else
                        set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);

Shouldn't TASK_FREEZABLE go away, too?

> diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
> index c5136ea9bb1d..1875b6551ab0 100644
> --- a/fs/xfs/xfs_zone_gc.c
> +++ b/fs/xfs/xfs_zone_gc.c
> @@ -993,7 +993,6 @@ xfs_zone_gc_handle_work(
>  	}
>  
>  	__set_current_state(TASK_RUNNING);
> -	try_to_freeze();
>  
>  	if (reset_list)
>  		xfs_zone_gc_reset_zones(data, reset_list);
> @@ -1041,7 +1040,6 @@ xfs_zoned_gcd(
>  	unsigned int		nofs_flag;
>  
>  	nofs_flag = memalloc_nofs_save();
> -	set_freezable();
>  
>  	for (;;) {
>  		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);

Same question here for this newly merged code, too...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

