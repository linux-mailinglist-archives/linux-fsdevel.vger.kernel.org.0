Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE3551CFD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 05:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388829AbiEFDxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 23:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388836AbiEFDxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 23:53:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D71047566
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 20:49:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so6268213plg.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 May 2022 20:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PvjP2MRw0Dw6ZY/zpGMKnwLuj7dOcOZEGesdRaXXWlM=;
        b=JKvYbsJ+AkhZpveZOYrn5WyirVmeS7D9jjBj0wfU7CTCXr0itus+Xt5GGWzv9M5xuu
         jpMN0YAKhc86cJ2DehmJzEfLxD6W12kO74jb13DOJu7t62FoRhyV9wPHy0nCL9e475WF
         QyJcjXk2ZyPImfVseoLB6e3cWzFlUeXnPazRE7DXZhLe61lTwTBIQF90NsCEOvgLEzs1
         +XIu66NygfYiZ0WfqC6SdNVp+orFlVRSStAlV8CnF0y/L4Ex4vrYppzkw93+UAK5KSMm
         LOHVs/aEbAaB+LpBczSIbQKrMd3tC6ssANbcgknZOX0VQ2oUryB1a89zG73f12R+sRVC
         VlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PvjP2MRw0Dw6ZY/zpGMKnwLuj7dOcOZEGesdRaXXWlM=;
        b=1DDQ2BcTm5aa+qEN55n4Jr/yiE2sntXr3Vhome4zMEqSnMmgJss7RApnGXT02f4Hvj
         eQP67GvGxAvxl+yB+vQVp2XjPsVgbb0yf3+7ZTF+llvOkQlWr1DGPsIvllOU6iVg+OjM
         VbRqYVUsnPKjMP518CI/ggflPePhUy39LMqC8ebFP/qJyhmuF1x9R4PAi/u0LWFRldNY
         sZOpCXA0GoCj6ubPZeqokxwM/DaUXjO1IyBTn0eOmGJdeZaNSr8dKFuMEV60OZGYWJ/J
         M82L/ilJ5HseRRhH/0+/FMPol/dg/SU12V5XnKd2y58t3ZqN+Rrz2DFhoWHdYDaI4AzG
         E+sA==
X-Gm-Message-State: AOAM5300yz8r9EUyBm+ibhKXrXMklN9rPBJKgeRNy6QTL7gSQAhU6KQY
        m8vqdHLJjSaRN5m/ODEnl6Bt/Q==
X-Google-Smtp-Source: ABdhPJypnSDYSyLFyRBAZ1tOcaVfbJ/ICgOMzPQElRAS0ciDE3M5LKODV9ir1NEpsTxiHctV1XK2DQ==
X-Received: by 2002:a17:902:da85:b0:15e:8e05:6963 with SMTP id j5-20020a170902da8500b0015e8e056963mr1507812plx.94.1651808985563;
        Thu, 05 May 2022 20:49:45 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:7328:d8bd:6152:780a])
        by smtp.gmail.com with ESMTPSA id c24-20020a17090aa61800b001cd4989fec6sm6168911pjq.18.2022.05.05.20.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:49:44 -0700 (PDT)
Date:   Fri, 6 May 2022 13:49:33 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: do not allow setting FAN_RENAME on non-dir
Message-ID: <YnSazY4pE3NXJq5H@google.com>
References: <20220506014626.191619-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506014626.191619-1-amir73il@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 06, 2022 at 04:46:26AM +0300, Amir Goldstein wrote:
> The desired sematics of this action are not clear, so for now deny
> this action.  We may relax it when we decide on the semantics and
> implement them.
> 
> Fixes: 8cc3b1ccd930 ("fanotify: wire up FAN_RENAME event")
> Link: https://lore.kernel.org/linux-fsdevel/20220505133057.zm5t6vumc4xdcnsg@quack3.lan/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks for sending this patch through Amir, LGTM.

Feel free to add:

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> ---
>  fs/notify/fanotify/fanotify_user.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index edad67d674dc..ae0c27fac651 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1695,6 +1695,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	else
>  		mnt = path.mnt;
>  
> +	/* FAN_RENAME is not allowed on non-dir (for now) */
> +	ret = -EINVAL;
> +	if (inode && (mask & FAN_RENAME) && !S_ISDIR(inode->i_mode))
> +		goto path_put_and_out;
> +
>  	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
>  	if (mnt || !S_ISDIR(inode->i_mode)) {
>  		mask &= ~FAN_EVENT_ON_CHILD;
> -- 
> 2.25.1

/M
