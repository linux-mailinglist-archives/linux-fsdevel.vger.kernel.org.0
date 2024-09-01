Return-Path: <linux-fsdevel+bounces-28145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D3E967560
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 09:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77BF1C2131C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 07:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618441411E9;
	Sun,  1 Sep 2024 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHwrnmYZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAC23AB;
	Sun,  1 Sep 2024 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725174067; cv=none; b=p4qzZK4M9bpb0fXqD5U3+Vn381y+IpH7xDk012KdpmDESQ5H4WXNZk8IN9aDYF1o1HXhs4y2zI50X14hWV0WMak9r5R1ifKANI6FNSeG9VC0I53bHDADANF2kb1Y1IHhNvxqL6erWwlJsCSsYQl9fYEqv9Zoq2wKW3xndh5Sq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725174067; c=relaxed/simple;
	bh=A/Aqg0idiR9dTPMDqDXHWk7lNlNc328DQSDoeUkSoqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdXI3fG/WKj07eCi+07ybYhIh3sfdMnFfGYaPRu+LMyR6kZqNO6msCiVmNILICzYJa0IMku3AZYvz8jLg6zhgXT3L5ndZJ1h+TZDjB2GHNnQh67ILFR4i5MrVwnskE0l8xTrY38SHY3/RLPSDjRgkelho76JAXTdYsemdW22Cdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHwrnmYZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-715cdc7a153so2280031b3a.0;
        Sun, 01 Sep 2024 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725174061; x=1725778861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOR3mKfIagEi6CTRnZb5FU+cHEbUu8vgBTPn6H57S0w=;
        b=IHwrnmYZ9Nzjh1G6OSTBehyPOkQUp2NlQcdi4AobZ5uasLDlTrN13it+ZmOqmLtEal
         ZEA4ayry2hnciGIgNNTOY/e/qIshjHUpKY0fQBokQKXFBpWUK3HirzFL8jnD0B2oJySv
         WupTvSp95gLnYmigHFQqXP2Akw+w360XyyqPivzeYRIrph1oRLQFHFw1o8n7TAqnPLVF
         LhjcdA+w79ZS+WckxfqsTcNVBNNis4LRmHyEorZa9kzYQLtOzhU5bCiatIkqgv04nF54
         k/VK2PdYsLPnrkZCKyeKTB+evhCpYP1mf+4uC1umz3VqsObLbqZ7H1AdbIS6fmhBuZ3X
         n4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725174061; x=1725778861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOR3mKfIagEi6CTRnZb5FU+cHEbUu8vgBTPn6H57S0w=;
        b=uX/wusUwHo3Ywb6qBAl8fYZyo2LfYvG7dFzZgrxnQTKLC/4jcS2AvquNt0xcB+k18l
         bHqmZaSIiQ5a5mLTWPlryabBBiT+KNGD3WW09QPQSoBitv701B1Ra1nZkTiWy1UEbVdb
         yQTy9vlOw/dkzhxhantYkG6aVQjN/v/2ehooMejmONXq3aE77Lf+OWllZfN5yuoPpEjG
         +C74EOvt6yHI9NYxTwMUsq4gYHkEIBAF2JdB49c26anGuPf6lSp222sgCuly+Sw5w+Cr
         xv6rot8ek1dzD4WnU4x7RBMIeMEJQndlY/L0TojU9bpMS2ijm4eSlFa3uqcz3ul81Q32
         raKg==
X-Forwarded-Encrypted: i=1; AJvYcCUqBX5eOKg8TjGAyu6RmCAy5Lt1apUdr0cgkWT+fojs8MoxAePdDoDvOyojpy6manIeBc+5LtTsxWlAF/L5@vger.kernel.org, AJvYcCV+mtNXQ1xjhJZqsChf1LMZRgQQgmgeVM2o+U5nTAseWI1gFb9CyZOfuHOg1Dd/T8zy3tdQWvjtcBtSf2iF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzly81dY1elNUutSvS0F/nnjdU7Vnj0J3MK20lt7MiCrQt5fXNJ
	g9sVS62eNJSHM1mqJC/xnaEHkrfYtZA1XhjRRCR9IvSReWONo9fD16G+2Q==
X-Google-Smtp-Source: AGHT+IHJTYwzbEkXY0gErCW2BEzpwy27lw/w9KBdaWJFALcVgx8vsd0l/xw1HxWwQSmYtj36c2I+2g==
X-Received: by 2002:a05:6a00:8d6:b0:714:228d:e9f2 with SMTP id d2e1a72fcca58-717000c75demr10668308b3a.3.1725174061057;
        Sun, 01 Sep 2024 00:01:01 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56e3f95sm5191660b3a.176.2024.09.01.00.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 00:01:00 -0700 (PDT)
Date: Sun, 1 Sep 2024 15:00:57 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: imandevel@gmail.com
Cc: jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inotify: set ret in inotify_read() to -EAGAIN only when
 O_NONBLOCK is set
Message-ID: <ZtQRKfuawk6borTL@visitorckw-System-Product-Name>
References: <20240901030150.76054-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901030150.76054-1-ImanDevel@gmail.com>

On Sat, Aug 31, 2024 at 11:01:50PM -0400, imandevel@gmail.com wrote:
> From: Iman Seyed <ImanDevel@gmail.com>
> 
> Avoid setting ret to -EAGAIN unnecessarily. Only set
> it when O_NONBLOCK is specified; otherwise, leave ret
> unchanged and proceed to set it to -ERESTARTSYS.
>

Hi Iman,

Have you checked the code generated by gcc before and after applying
this patch? My intuition suggests that the compiler optimization might
result in the same code being produced.

Regards,
Kuan-Wei

> Signed-off-by: Iman Seyed <ImanDevel@gmail.com>
> ---
>  fs/notify/inotify/inotify_user.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 4ffc30606e0b..d5d4b306a33d 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -279,9 +279,11 @@ static ssize_t inotify_read(struct file *file, char __user *buf,
>  			continue;
>  		}
>  
> -		ret = -EAGAIN;
> -		if (file->f_flags & O_NONBLOCK)
> +		if (file->f_flags & O_NONBLOCK) {
> +			ret = -EAGAIN;
>  			break;
> +		}
> +
>  		ret = -ERESTARTSYS;
>  		if (signal_pending(current))
>  			break;
> -- 
> 2.46.0
> 

