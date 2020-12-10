Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3432D5FDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391900AbgLJPgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 10:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391897AbgLJPgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:36:48 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1F8C0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:36:02 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so5945112wrt.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fpTNmQiIHEJLaTitKVv1oaaSRbT39VRnTw74fvsGI1c=;
        b=H3trLt4V1L33TGwM/yZD0JhEIXHblYks1nZFOtWoQlVLJbsN4Mz5l79tyImAywSIi/
         C8bIE40OmzGccXtTHB9uAPK+pfwT16fE4+WkMzVF9505mmbuAjrE2MTj80KZD/zCn8CT
         lHPuSJv9iYvdtlkhMD0Y1cF/n0mF1jce237ttDgDNPKFwvynr2QuVvCVr0P7Ep1bc2ni
         8L5A/xQr9LtZOrgHHwu1uHYsJDmsHA2nRpxaMyVej2blUUTv+IFGvVuFTjMj7zKMmjNa
         Qos2oXRMierk/L+O1eqGuYNoI7QNw4g2+7EQzyAspzxtKKxfJk9mG9V7gHqPDny5woOx
         G+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fpTNmQiIHEJLaTitKVv1oaaSRbT39VRnTw74fvsGI1c=;
        b=UyNxBHxRG4N5IrDgTSxm671lkAsrvFDVY2JMTCGWw4sV7tDTdxTSvOelPpnoHcF0gU
         vCCeRy9gt2uSqX9xJlvRz08qpaOzfchiQhViOzktvx1yXuhpc935DK31pO9VTIfxi9fl
         o6Tg3Z4l0Pdcaq8NNmZFnljK6CnTbuacl6k+ecLosa37ZYaxNsuDdBrRmGIK21TGm4z8
         l9w1DadVBAZZOcwXSQM7rFC32XHEuJmxGaB3qU4VeqwQFUn5VURh8qFT3mRH26b/ZEL1
         qXJumhyR6Rtyk1znIur7zjsBU/3gTv3AUWtgyLjFzRuOpfmMVCE8T4QnKudjr7f6f//Z
         JwTw==
X-Gm-Message-State: AOAM531ur2a8+OS4UQQBoNaPQ4NhKZQQPw4cdoT+wGIRvMB3/70nRMOv
        TFEwoGffWaU/8n6z59UM74R2Mw==
X-Google-Smtp-Source: ABdhPJzRsd4INrUHZ1w+FccKPJwW1ZyQU2s8jxT0sdxgFM9P2IbkcARs9CxNUGLQOzZ7aJF2x940Xw==
X-Received: by 2002:adf:fdcb:: with SMTP id i11mr8862811wrs.349.1607614561777;
        Thu, 10 Dec 2020 07:36:01 -0800 (PST)
Received: from localhost (p4fdabc80.dip0.t-ipconnect.de. [79.218.188.128])
        by smtp.gmail.com with ESMTPSA id z22sm9112468wml.1.2020.12.10.07.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 07:36:01 -0800 (PST)
Date:   Thu, 10 Dec 2020 16:33:56 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] mm: memcontrol: add per memcg shrinker nr_deferred
Message-ID: <20201210153356.GE264602@cmpxchg.org>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-6-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202182725.265020-6-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:27:21AM -0800, Yang Shi wrote:
> @@ -504,6 +577,34 @@ int memcg_expand_shrinker_maps(int new_id)
>  	return ret;
>  }
>  
> +int memcg_expand_shrinker_deferred(int new_id)
> +{
> +	int size, old_size, ret = 0;
> +	struct mem_cgroup *memcg;
> +
> +	size = (new_id + 1) * sizeof(atomic_long_t);
> +	old_size = memcg_shrinker_deferred_size;
> +	if (size <= old_size)
> +		return 0;
> +
> +	mutex_lock(&memcg_shrinker_mutex);

The locking is somewhat confusing. I was wondering why we first read
memcg_shrinker_deferred_size "locklessly", then change it while
holding the &memcg_shrinker_mutex.

memcg_shrinker_deferred_size only changes under shrinker_rwsem(write),
correct? This should be documented in a comment, IMO.

memcg_shrinker_mutex looks superfluous then. The memcg allocation path
is the read-side of memcg_shrinker_deferred_size, and so simply needs
to take shrinker_rwsem(read) to lock out shrinker (de)registration.

Also, isn't memcg_shrinker_deferred_size just shrinker_nr_max? And
memcg_expand_shrinker_deferred() is only called when size >= old_size
in the first place (because id >= shrinker_nr_max)?
