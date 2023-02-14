Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2546970A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 23:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjBNWVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 17:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBNWVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:21:10 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5123C3A
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 14:21:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so211924pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0bFIu73fTVvR9PL7MVdOQ0zbyp7cdAUZDJOn+qJPyo=;
        b=KSwZF1TjnlMTwL3m/4kspmK7z89JCyD76z6bkIxgZuLon2AvuGmdVM9lmns/zYcnEr
         5b23wZyCzced3e/ydwe0Pwq9C6ffOi4KN+jSTpSmJyFEBqtX4EZp7FcPgrCGx6VysHZB
         GLIxysHwjAr8SSLqfGQB5Nkt25HFKpudWDI+PrD9mzLXP7CMuD17Zbp7bg2QistHinsR
         fxOES75krFrWmyI5zBtFFpqW9tBFbmwWSul3OP9IHb7eunJUHBHCVOpjndVUwHp3baGA
         8LKTJCdwmXMolsVBBjbBFwO+lD00Nu4tY9HTSilRloo9sb4qC4sgQ/z0jZuKdQhnO3EP
         AihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0bFIu73fTVvR9PL7MVdOQ0zbyp7cdAUZDJOn+qJPyo=;
        b=57iEBaxCyC7aHP1ArRUE6CJrSkS8wQBqeXE3qH3vDtnIQJmm0QBOVLeb9Y7N1govol
         Jjvn9ZqgNGPqVxsJvHtoKLEVQg94WYOEXepy4W05KyEU/2okEyHqpFRHaQHZCFYy6fzH
         pQeFIbX94v59x0u+LEjhPlkb+j1vQAQI0yryTpC/sPspAdvfII0echwdr6SuAUKh+3JT
         zmpPdj8Y8RimUqGWD1f6bzfZr9r7MlVVpZw05Fj3mSldzCYFHQM4w9yHKU2AskxymMAW
         h/SxeoRF3HGtPNp5jsrnOWStKJ94kXLpjEVbO4qR7fa4ETO59AOVpCRpHCWenjov8i35
         h9gA==
X-Gm-Message-State: AO0yUKXUzuocP1jazOgXYx3C0ivBMKDsFGshMVGJ/Cl79AMHSOH3uPB+
        Ldlrz5YGQVFfdL2ZyTpzyX7+CA==
X-Google-Smtp-Source: AK7set8KEd4xTYXFCatTliojpLWv3pNWakQRBOxdble+7NUx01Mw71QL1kYwzMGeS19YWgF3WrHN9A==
X-Received: by 2002:a05:6a20:8f0a:b0:bf:73d:485e with SMTP id b10-20020a056a208f0a00b000bf073d485emr4909371pzk.54.1676413268158;
        Tue, 14 Feb 2023 14:21:08 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78d53000000b0056b4c5dde61sm10527918pfe.98.2023.02.14.14.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:21:07 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pS3fd-00FMs4-3D; Wed, 15 Feb 2023 09:21:05 +1100
Date:   Wed, 15 Feb 2023 09:21:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: report block map corruption errors to the
 health tracking system
Message-ID: <20230214222105.GM360264@dread.disaster.area>
References: <20230214055114.4141947-1-david@fromorbit.com>
 <20230214055114.4141947-2-david@fromorbit.com>
 <Y+tARjFLhxzK6Vt0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+tARjFLhxzK6Vt0@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:03:18AM -0800, Christoph Hellwig wrote:
> On Tue, Feb 14, 2023 at 04:51:12PM +1100, Dave Chinner wrote:
> > From: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > Whenever we encounter a corrupt block mapping, we should report that to
> > the health monitoring system for later reporting.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > [dgc: open coded xfs_metadata_is_sick() macro]
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> 
> Just curious:  this is probably from a bigger series, which one is
> that?

[14/2/23 10:36] <djwong> branch @ https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=corruption-health-reports

-Dave.
-- 
Dave Chinner
david@fromorbit.com
