Return-Path: <linux-fsdevel+bounces-47545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D988A9FD0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 00:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAFD170278
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 22:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80062211A11;
	Mon, 28 Apr 2025 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQRs8mqz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC4D15687D
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745879560; cv=none; b=nwPIRhO/0Jie22sie//9xeiN81daZIAf3kqsbcXDiCYSbVGuGM6Z9yKjxrvbZ2L6iEXk+Ic+bM5cpn8eMttm1LevXsRaWBLMhrjeOPJST+X6zmC0QvaO0Ux7I5BB+fm/RwwRr6V4qX3F5oo+FQMe5bLsUgnDyUGHO1IzR+XEA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745879560; c=relaxed/simple;
	bh=9qTnesBJ1x9pJGR5DoNyNyK46lrwv4v/BXjoFGJHypw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5zRTwKOUOvQoyYWlZ6w9I/Y9R9TbzqmwiMYsE8WS3rvnyx4ySPie2Tmt4ZDxwkBlVCvfSwa4pacR4Dxq7Hx4iNlShaxdDzj+24SAIfpMWBDdDrgDvf83+ohOCc24ujoGlvB2lMSNWM6jQdLC1aMUl6xQ8NvITY8+G3u/2+VooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQRs8mqz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2264c9d0295so13555ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745879559; x=1746484359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyV8p9+7U3mrNHllqv/HYRzTu27JVC6zq9eByWVVIn4=;
        b=gQRs8mqzfw5G0BJuyzQDXS5uAPDDnWj2wyGeZXYGYWYMKR+dcrkbUUardbC1Vnuh/4
         cVtNQToY2MVBURX1GmyHC18QnXc8Ua+v4VM35elns35Mm/mV7c49d3RjGUh1kMQr0M7Y
         6lhwBqYdgdFnYEmSuIDAOhszaX1n631UMUI70Rl0EH/EbCTJIzOAItW5iiYjUOYerpy3
         5h42eQHkJtRWeCMHF/81ptf8lP9rKHksxPk32pJQ/FMyHKwH8D3VHTVYHjIOjybiNdzP
         7SPvSb9TGuR8Q6A+EBwjfokDESRQN4EaTowNYpx1Smas+1sJ+DP70UbGGGGBEO0/rJao
         oFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745879559; x=1746484359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyV8p9+7U3mrNHllqv/HYRzTu27JVC6zq9eByWVVIn4=;
        b=n4a4WooOmDXhojlbjmPL1FHBTuPnOXFZQVXQRF86y6t8H27NeiszwefR/yZ0YciC6h
         mMpc+JjiHZAgg37sqnuji1PF/x9+3CMvh3cEA0oGW/aS1AO8cH5kUehOnq+2R+Ix0Q4+
         PtfsS0NpGDKveu92BYMNEZTrp4HWmbk+6dBPfvaohUHrV2KFGDG97+JcClufofMNJWjj
         Ent3rL/Mhefk4a3I5GWs7DEpEIQljevLv9y+XNRES9WPH9K6NFi9iXJrNEEro5ikn1jC
         ruw6juwdEy8PUgepTbA+7S5dL5fLmEvr/qgEFKzG4+xw1jsSxtoDthkrsbBfz8PukklY
         PuQw==
X-Forwarded-Encrypted: i=1; AJvYcCXaIjSzeHeiGOLVlkETzp6nmpgSGMp2fyUQrZQJesjFez8Zg637QQG7nxMNlFyijR+5qzQ6DzHYznFXQO8p@vger.kernel.org
X-Gm-Message-State: AOJu0YxMEiiIIu+afNxEQjYq7REYE0NKzUZX1PCkWJK9aUnGDV80unbW
	CGayJ+dh5ycMUmFfW9VmNQKhPv1ebEsvWs4y/f/NIR9Rp8jmkAiut7gDucbNLA==
X-Gm-Gg: ASbGncsnLDobqPIK0QXiQ3SroUzTLdRrUcUGN8w9R8J/G7lqcAb3VnlvT+eLBAnFCxC
	uK3Q+ER6q29G8PS5x1hA4TsfA1h4jua6lw6D4bnyILoZW8E082yxHN7HFBBgIyIDi5fo+vaeOm7
	+eu0mB8MqfAqWMBYcmlmoJabXGytxjT84i7TuRxkiZHD9bfr5yXKNGNQMaHTl07k5GVNaZA/pqz
	X0C741rxC1fAGVPXiKDH49KKg84qNwm55x7+DNMU3mTVlvRwBte7S10TbjNxDgxU+4Pr/+xLskX
	WY3dhSu+epUT2evDT81nEOgy6Ji30NHB6dfPm/gL4CofwpUOu7oDe6rtwwJQit3Fwa0I9DWKs7C
	9
X-Google-Smtp-Source: AGHT+IGsmsHhSlt1m1Ge4MM29yK31OrlTG/5dxumFFtIkx9IfHhDaVXh/V5pz3CbgEiWW4EBbU6FYQ==
X-Received: by 2002:a17:902:e945:b0:223:7f8f:439b with SMTP id d9443c01a7336-22de8628a21mr481695ad.29.1745879558384;
        Mon, 28 Apr 2025 15:32:38 -0700 (PDT)
Received: from google.com (152.33.83.34.bc.googleusercontent.com. [34.83.33.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25912ae0sm8596242b3a.1.2025.04.28.15.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:32:36 -0700 (PDT)
Date: Mon, 28 Apr 2025 22:32:31 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Joe Damato <jdamato@fastly.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in
 the future
Message-ID: <aBAB_4gQ6O_haAjp@google.com>
References: <20250416185826.26375-1-jdamato@fastly.com>
 <20250426-haben-redeverbot-0b58878ac722@brauner>
 <ernjemvwu6ro2ca3xlra5t752opxif6pkxpjuegt24komexsr6@47sjqcygzako>
 <aA-xutxtw3jd00Bz@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA-xutxtw3jd00Bz@LQ3V64L9R2>

On Mon, Apr 28, 2025 at 09:50:02AM -0700, Joe Damato wrote:
> Thank you for spotting that and sorry for the trouble.

This was also flagged by our Android's epoll_pwait2 tests here:
https://android.googlesource.com/platform/bionic/+/refs/heads/main/tests/sys_epoll_test.cpp
They would all timeout, so the hang reported by Christian fits.


> Christian / Jan what would be the correct way for me to deal with
> this? Would it be to post a v3 (re-submitting the patch in its
> entirety) or to post a new patch that fixes the original and lists
> the commit sha from vfs.fixes with a Fixes tag ?

The original commit has landed in mainline already, so it needs to be
new patch at this point. If if helps, here is the tag:
Fixes: 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the future")

> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 4bc264b854c4..1a5d1147f082 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2111,7 +2111,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
> 
>                 write_unlock_irq(&ep->lock);
> 
> -               if (!eavail && ep_schedule_timeout(to))
> +               if (!ep_schedule_timeout(to))
> +                       timed_out = 1;
> +               else if (!eavail)
>                         timed_out = !schedule_hrtimeout_range(to, slack,
>                                                               HRTIMER_MODE_ABS);
>                 __set_current_state(TASK_RUNNING);

I've ran your change through our internal CI and I confirm it fixes the
hangs seen on our end. If you send the fix feel free to add:

Tested-by: Carlos Llamas <cmllamas@google.com>

Cheers,
Carlos Llamas

