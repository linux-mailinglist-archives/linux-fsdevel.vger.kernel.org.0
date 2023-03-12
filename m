Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384D36B6C85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 00:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCLXbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Mar 2023 19:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCLXbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:31:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D52916B
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Mar 2023 16:31:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y11so11083309plg.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Mar 2023 16:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1678663870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGsRfyWirO1vSkNZurgVxrSIuOQUCszDrkoyMT09sQs=;
        b=NboYJvQ0YuDQbYw2M1vU9JVEzDJsjSLEbY9WsRGsLeDGylvi9+jWzHvjyQsXInv/vh
         5dUJGO59oE44kzMCqDvvyK9i0mAI49aWsGk/ZzRr4oHwPjQEyOFnMSvHgALiQGhLiXTr
         JMikS88mniyswWrjBAkLMdqzfLSR8DccSOsu/MwTwTCb7kPiUlrs4CTmAffKJiqXcxuq
         gwVJ9E1bcqrT8qMzrAWeleGhPrt7/Zdr9E4DiOXQgyCY6+E+CZMhIIJcw+DDvxKI9NQF
         2wxmm4cljnXAien+Q36htyf30E7LxnGeEvszsGg5zaVw4uLiKB4Xr5qJiFuqmHC1KEBY
         H9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678663870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGsRfyWirO1vSkNZurgVxrSIuOQUCszDrkoyMT09sQs=;
        b=FqJhgZiULaKzDkE21CHheKh/NeKPz6oQQk6PB6LTXm0kXEdfQaoPgzFyHyedJkFB4D
         n5gwUljLiNH8CI3PpuEIkPD7w+ylt7ov260PLZhCCdcWZF448gRUjCv0AmEMQkZmSpNk
         AaRx6wRunR4ptyqa0mowQuOsoSQe9rihIDrUn+0mRGYExccV9vJM+3Mc9HeNm/T8feol
         /Mj9I4b8UgiF1EPb1oFvrwWrAismZE4h+ukKvCEWKou/gPaLrimmfQhyHQQEt4VCFE1W
         vfbDlWWEWt0qUaMVosvc3uD908Xfd1+qImTUvMa2pVvatyMZtpcMO7zJ2v8ik1Dn+0Ri
         5CBw==
X-Gm-Message-State: AO0yUKVzH/umzB3RyzmOS9dcu/RKD2dqDW/m5csltwfGyZMw1nr+7ulx
        5v3goEY+TfzeFW/cZelkh43IPg==
X-Google-Smtp-Source: AK7set8Fgsjo4bRIW0pN3fgU3x2K1goOzHfUWcYXBk2t7zY/FyA9xynwVPuBAWLpp35yhUEYeP8MOw==
X-Received: by 2002:a17:903:120b:b0:19e:82aa:dc8a with SMTP id l11-20020a170903120b00b0019e82aadc8amr37238346plh.22.1678663870328;
        Sun, 12 Mar 2023 16:31:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id bb12-20020a170902bc8c00b001933b4b1a49sm3311784plb.183.2023.03.12.16.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 16:31:09 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pbV9e-0083Cw-KQ; Mon, 13 Mar 2023 10:31:06 +1100
Date:   Mon, 13 Mar 2023 10:31:06 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        keescook@chromium.org, yzaikin@google.com, j.granados@samsung.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: simplify two-level sysctl registration for xfs_table
Message-ID: <20230312233106.GP360264@dread.disaster.area>
References: <20230310230219.3948819-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310230219.3948819-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:02:19PM -0800, Luis Chamberlain wrote:
> There is no need to declare two tables to just create directories,
> this can be easily be done with a prefix path with register_sysctl().
> 
> Simplify this registration.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> This is not clear to some so I've updated the docs for the sysctl
> registration here:
> 
> https://lore.kernel.org/all/20230310223947.3917711-1-mcgrof@kernel.org/T/#u     
> 
>  fs/xfs/xfs_sysctl.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
