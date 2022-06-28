Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57C855CA9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbiF1Ke4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 06:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbiF1Kez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:34:55 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F5531394;
        Tue, 28 Jun 2022 03:34:54 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4LXLZL2bFCz9sbl;
        Tue, 28 Jun 2022 12:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1656412490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCsmhwxPKBHJ46dWmiVRWHiUT3ks2E1dAcyONJ6hmBo=;
        b=osKoUFpDaV9Xn6/YR52+bC3Tp28nCtNfV1JX5uc6mV+dvDRWGRuKf/MHczF+HeCF4rqvR7
        mezcwxwPkJRVbqBszbnVuriVCGDFFqb56FfwdDKZl6ybcE1cZhXjAEVbKEzu/c9i+avuJy
        lLhvsIRSB4qRpw7QlHM89oMr1xADNSThQcLNaR0vCS79jfevUDcDgd+uYUamRsUMkX+xHh
        T58dZSzAHkXHgmwp1SyMUhnYq7ZVj6wokc/STn8FlrgS1dFtokX/XxUiId1/ylmbG7yicV
        CTJOo7cvhVVQ+tSZZmZsMfvlZhAuTHjdcj6XiuHiWgfBRE7IdRMx6quP7QoJ/w==
Message-ID: <9d02d901-8015-dc02-250b-97ed1cfa16c2@mailbox.org>
Date:   Tue, 28 Jun 2022 12:34:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 09/14] drm/radeon: use drm_oom_badness
Content-Language: en-CA
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org
Cc:     mhocko@suse.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20220624080444.7619-1-christian.koenig@amd.com>
 <20220624080444.7619-10-christian.koenig@amd.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220624080444.7619-10-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cutc5b13i4ckkykp1cme1mpqiajc1ikh
X-MBO-RS-ID: dec7526ba758fff16cd
X-Rspamd-Queue-Id: 4LXLZL2bFCz9sbl
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-06-24 10:04, Christian König wrote:
> This allows the OOM killer to make a better decision which process to reap.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 956c72b5aa33..11d310cdd2e8 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -550,6 +550,7 @@ static const struct file_operations radeon_driver_kms_fops = {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl = radeon_kms_compat_ioctl,
>  #endif
> +	.file_rss = drm_file_rss,
>  };
>  
>  static const struct drm_ioctl_desc radeon_ioctls_kms[] = {

Shortlog should now say "use drm_file_rss", right?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
