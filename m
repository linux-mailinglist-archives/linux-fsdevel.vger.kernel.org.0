Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646E845CF28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 22:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbhKXVkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 16:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbhKXVkU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:40:20 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF15C061746
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 13:37:09 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id i9so5255894qki.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 13:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PDpAUClRISPaqjyDiS/RNBX5RTYaG7TkRPK4Gm1mZss=;
        b=QQKmwN1f0b9ElZBMcGD2e9/nw9t7oiH/45g3kCuEtZBepxzZJSaw19OVhZPnTERfRy
         /5/53O7yHTWTGZQZ+5vtN+ZWtVwWdqewSt9wTHT2SfYgUJk6PPllXk/ewdIXQbux3S2B
         hZtOu2GppXGlkqPJ2RimaihvTaY5/R+x/SptktA2MgEtAm6DUIeE1S60XIIZ9zhboisN
         DYKalBnpKt52CUxfiLXXt1ukvSCUuQ9LsrWqVujGljLIvW8GRNYC2Lr3BDEVehAMey17
         dTOmyJ8GELC5DhOO8bwy7A92mvbiHMGhwjZg6J+O0a3T6YLWY6Y44NC9ZiDEvWqrax+E
         LKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDpAUClRISPaqjyDiS/RNBX5RTYaG7TkRPK4Gm1mZss=;
        b=c7s/RO2sVfKDafwJ+wzPgyVqcTR+fKHNy/qmww9eJ2F7xXY5FSJ5zCLhDPRcnHEiLQ
         uAyOwbilf7JlavCPhafldKhaNkGNaQHOkrsNbYd0i8HKTiwan9f8sV8rDf+u3s786jOJ
         g+13jBarvN5yyk0o/BkwW0FYhnN6RgIFIX6WdeYpTsJqt7ku0bT6fb+8DUveSFukjwum
         wBJo0Smr711kSJYyVxJDuh4TPI2miPJAPiLeDcF2iDvkEpMrVfARm7PoA71BEFW2zkiM
         sgNl+++gpvVSMLWR6MDa/1msW5wqsMbbGZeQ4SlsNcddD2cA+iiflYr8errfUae6I9dr
         vayg==
X-Gm-Message-State: AOAM531rzP7MQYIeWJEQtR6utox3C+LGYmTJQ4ZrWjKuh+Gh+CaAbstv
        f9WGr8fXu5pysksE7PNxxP7ahCLFYP+40w==
X-Google-Smtp-Source: ABdhPJyqU1t6Y63xsf9kE/jd2e91PtTUftZ8PGSVRmaOXDKXaYwtE70W7SZPZu2R6gq+UJWAJpbz6w==
X-Received: by 2002:a37:8945:: with SMTP id l66mr1620277qkd.776.1637789828853;
        Wed, 24 Nov 2021 13:37:08 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id e20sm544451qty.14.2021.11.24.13.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 13:37:08 -0800 (PST)
Date:   Wed, 24 Nov 2021 16:37:07 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        dave.hansen@linux.intel.com, vbabka@suse.cz,
        mgorman@techsingularity.net, corbet@lwn.net, yi.zhang@huawei.com,
        xi.fengfei@h3c.com, rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] sysctl: change watermark_scale_factor max limit to
 30%
Message-ID: <YZ6wg9A5p5WUy7+k@cmpxchg.org>
References: <20211124193604.2758863-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124193604.2758863-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 11:36:04AM -0800, Suren Baghdasaryan wrote:
> For embedded systems with low total memory, having to run applications
> with relatively large memory requirements, 10% max limitation for
> watermark_scale_factor poses an issue of triggering direct reclaim
> every time such application is started. This results in slow application
> startup times and bad end-user experience.
> By increasing watermark_scale_factor max limit we allow vendors more
> flexibility to choose the right level of kswapd aggressiveness for
> their device and workload requirements.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

No objection from me as this limit was always totally arbitrary. But I
have to say I'm a bit surprised: The current maximum setting will wake
kswapd when free memory drops below 10% and have it reclaim until
20%. This seems like quite a lot? Are there applications that really
want kswapd to wake at 30% and target 60% of memory free?
