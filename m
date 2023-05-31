Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718D4718EFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 01:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjEaXMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 19:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjEaXMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 19:12:40 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7A897
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 16:12:37 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53202149ae2so108219a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 16:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685574756; x=1688166756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NdrJ9MIJBRF6SJ1238zAPHjVfaouK03YhdkmBFLWYHU=;
        b=ID8921t0pn2fvFZSPX1ZCn10WYK0inJi+Xd18q6u9I2qj9Ua8QL/IeltWfVKU1549H
         6t+FxjDrPHAhQhSB9JUjWETqcJHxAf+v7YLxwCZGsAuIUxonZkkFq7XdK1EhZEmH5lAp
         qYAaH4CiK8x4svKHXlCp+v2jNkN4mWFjTzogGYkohIubyyxVVOxf3JLsLl9kzOJPg/7J
         xxINvt2pxEnRtAX/ARJyUgMTJORyZOEFcNCRW7fuDHrc0oUvVcU2wtsStCp4UpkvLpMr
         DSNeoqv+/XYJerWdG5jeUU5678yDxAHf9x68P+rXEC/Q/fIjVLu3koKY+XmRzyE7za4f
         4q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685574756; x=1688166756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdrJ9MIJBRF6SJ1238zAPHjVfaouK03YhdkmBFLWYHU=;
        b=T2LrzzR/ZTkt7CgAJU/tETsT6uB6E0GJG91zQgB40BoMoYY+xSOpAjsZ+vQgRXEsa7
         SkF2z57Ex/p0zYGesaxngUX3sx8XeofV/7SsddcpqG7YQ+t0p6hqeo1fkW6Ha1mu5FnJ
         JhvrWJF5ob+IbCmRSzFnT0FpRNGm5URniv9WtYCE9phIeZUt3CTJ9oPkMnc/l2Ya6LhY
         4I/O2gqIvgSv9OynI0UY/ijs6Ozh6gVD5VkmJMJ1huPHz9p7sGp4iUySvdga6E9qDOEl
         Bin2YlqUgfDpO9zL6RI3PdpBb5DCKULTIadplNOA2CInDO1lLmEy5I9fP5eiG9vkH7WL
         2n4A==
X-Gm-Message-State: AC+VfDw/jIzamEM1QcBxtIb2BmG5QFfD2pYp7qY1zqOUSKKMXRQjYvX0
        BVx2r4bxzBkkvgcOfc3npbAC5A==
X-Google-Smtp-Source: ACHHUZ6t82xplazJPqCDO0qJl0sdq89xmVCN5MjD9hEMlaWGG60n1KteElROnWc1nPytTu2S5dCmtw==
X-Received: by 2002:a05:6a20:914e:b0:10f:500b:18a2 with SMTP id x14-20020a056a20914e00b0010f500b18a2mr5804009pzc.48.1685574756329;
        Wed, 31 May 2023 16:12:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001b077301a58sm1965299plg.79.2023.05.31.16.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 16:12:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4UzZ-006HqL-0r;
        Thu, 01 Jun 2023 09:12:33 +1000
Date:   Thu, 1 Jun 2023 09:12:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 4/8] fs: shrink only (SB_ACTIVE|SB_BORN) superblocks in
 super_cache_scan()
Message-ID: <ZHfUYVgjihp/Hxfz@dread.disaster.area>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-5-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531095742.2480623-5-qi.zheng@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 09:57:38AM +0000, Qi Zheng wrote:
> From: Kirill Tkhai <tkhai@ya.ru>
> 
> This patch prepares superblock shrinker for delayed unregistering.
> It makes super_cache_scan() avoid shrinking of not active superblocks.
> SB_ACTIVE is used as such the indicator. In case of superblock is not
> active, super_cache_scan() just exits with SHRINK_STOP as result.
> 
> Note, that SB_ACTIVE is cleared in generic_shutdown_super() and this
> is made under the write lock of s_umount. Function super_cache_scan()
> also takes the read lock of s_umount, so it can't skip this flag cleared.
> 
> SB_BORN check is added to super_cache_scan() just for uniformity
> with super_cache_count(), while super_cache_count() received SB_ACTIVE
> check just for uniformity with super_cache_scan().
> 
> After this patch super_cache_scan() becomes to ignore unregistering
> superblocks, so this function is OK with splitting unregister_shrinker().
> Next patches prepare super_cache_count() to follow this way.
> 
> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  fs/super.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 2ce4c72720f3..2ce54561e82e 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -79,6 +79,11 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
>  	if (!trylock_super(sb))
>  		return SHRINK_STOP;
>  
> +	if ((sb->s_flags & (SB_BORN|SB_ACTIVE)) != (SB_BORN|SB_ACTIVE)) {
> +		freed = SHRINK_STOP;
> +		goto unlock;
> +	}

This should not be here - the check to determine if the shrinker
should run is done in the ->count method. If we removed the SB_ACTIVE
flag between ->count and ->scan, then the superblock should be
locked and the trylock_super() call above should fail....

Indeed, the unregister_shrinker() call in deactivate_locked_super()
is done with the sb->s_umount held exclusively, and this happens
before we clear SB_ACTIVE in the ->kill_sb() -> kill_block_super()
-> generic_shutdown_super() path after the shrinker is unregistered.

Hence we can't get to this check without SB_ACTIVE being set - the
trylock will fail and then the shrinker_unregister() call will do
it's thing to ensure the shrinker is never called again.

If the change to the shrinker code allows the shrinker to still be
actively running when we call ->kill_sb(), then that needs to be
fixed. THe superblock shrinker must be stopped completely and never
run again before we call ->kill_sb().

>  	if (sb->s_op->nr_cached_objects)
>  		fs_objects = sb->s_op->nr_cached_objects(sb, sc);
>  
> @@ -110,6 +115,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
>  		freed += sb->s_op->free_cached_objects(sb, sc);
>  	}
>  
> +unlock:
>  	up_read(&sb->s_umount);
>  	return freed;
>  }
> @@ -136,7 +142,7 @@ static unsigned long super_cache_count(struct shrinker *shrink,
>  	 * avoid this situation, so do the same here. The memory barrier is
>  	 * matched with the one in mount_fs() as we don't hold locks here.
>  	 */
> -	if (!(sb->s_flags & SB_BORN))
> +	if ((sb->s_flags & (SB_BORN|SB_ACTIVE)) != (SB_BORN|SB_ACTIVE))
>  		return 0;

This is fine because it's an unlocked check, but I don't think it's
actually necessary given the above. Indeed, if you are adding this,
you need to expand the comment above on why SB_ACTIVE needs
checking, and why the memory barrier doesn't actually apply to that
part of the check....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
