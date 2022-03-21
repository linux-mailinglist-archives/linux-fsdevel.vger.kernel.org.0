Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4618A4E2AEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 15:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349542AbiCUOfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349544AbiCUOe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:34:59 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84A5E76E
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 07:33:22 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id kk12so121838qvb.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=us46s+4EPzPx/x4i+BKRoQL7SxJrfbc5izH2Jmo2exM=;
        b=DIuqnBQJ+D8uHwQ7rRY5uyiULjBVtGxEIduobDz0t0FBX5mpZcJsO2XEa7VcfdYkTV
         Id4JSNKheF4QVSr29xg2y4dpXKa+mNZ2kUnP5A3CPEDMxNUr4EWymy9l4Vn/3RxTAMbI
         5lTmrOiCAUkcw9k+dUBjP1pCVh5tgyhxuqknjM25vCB2aVtaav/IDcqyxrW7OWFOMHT8
         bYMlSIU0PtnhAcyoLIXRIBv0xnx6zpiWOJNkCu5n+1hFtDdOBF6/ex9VAFmP3vHQTLif
         pbOlH6lxjYZilIi5w3jrbWEPu0N5CQvdlTVbazta9mjupWBYWjNxrn9mm96PMVaICDk7
         iucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=us46s+4EPzPx/x4i+BKRoQL7SxJrfbc5izH2Jmo2exM=;
        b=GpA7honr+cxfr0krpmG5W9EIyGvi0Yj68vnr2pRNo3ZQmhdVR6B1RlaO+jf65zvo2H
         1RAnSbTUyyE1usS1APa6q9c8QpJsfNqqfJW+lr15EwoHubqPJr0+vIWjzj1pFcPwWgJ4
         RPT+liP2wG5YPU9LzPGvwRPns0fKLjj9DeQNQa6mjHRdnIFTX9/w1kUUlDS07dvONqM/
         hBWpqmzu6Wfv/1qQc/yKiKEiX9mf916gYSz4zEjiW78A4uhvbTskLTrX4Zmsp0TteB9L
         IwkrT11y1XnO/kJQMmLXrlgFnoFuRudop1EaF1zfAyoMnYPKjL0jh60kCmC5BW4rE1Hq
         w0tQ==
X-Gm-Message-State: AOAM530vVrGRLBYgcEMxytJKe3CHNXTJnxTFgQ4wPWmSM7bxvLWRMXWz
        086dTaH3S6RnV3U5oFdq9j+Hjg==
X-Google-Smtp-Source: ABdhPJzuIjrelcElq9DwcPDy1CDAqt1nawinhreHQoL5wDrjqG6A6BI3rtIwaguRYBMUW2VDRm2ACA==
X-Received: by 2002:ad4:5f8e:0:b0:441:3dbf:15d5 with SMTP id jp14-20020ad45f8e000000b004413dbf15d5mr801181qvb.108.1647873202008;
        Mon, 21 Mar 2022 07:33:22 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id j11-20020a05622a038b00b002e1f0bc2e8csm9636047qtx.81.2022.03.21.07.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:33:21 -0700 (PDT)
Date:   Mon, 21 Mar 2022 10:33:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     cgel.zte@gmail.com
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Message-ID: <YjiMsGoXoDU+FwsS@cmpxchg.org>
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:39:28AM +0000, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> psi tracks the time spent on submitting the IO of refaulting file pages
> and anonymous pages[1]. But after we tracks refaulting anonymous pages
> in swap_readpage[2][3], there is no need to track refaulting anonymous
> pages in submit_bio.
> 
> So this patch can reduce redundant calling of psi_memstall_enter. And
> make it easier to track refaulting file pages and anonymous pages
> separately.

I don't think this is an improvement.

psi_memstall_enter() will check current->in_memstall once, detect the
nested call, and bail. Your patch checks PageSwapBacked for every page
being added. It's more branches for less robust code.
