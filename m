Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8306D535A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 23:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjDCVUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 17:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjDCVUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:20:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E9E46B4;
        Mon,  3 Apr 2023 14:19:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id le6so29337176plb.12;
        Mon, 03 Apr 2023 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680556775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MIwuslKOv23RmObbF1opEGXBO5SntQiEEpUaiQ2xkw=;
        b=VCcYybWY8EXxG2djVLd2aJwEv3cQfYWsN6xic8+5BBdab6G7SK99uEilDzr2s5ecNm
         EUSnIt/fmVyLhdQ/v+j+mZH7wWt29jvd9IjTBPvaLo8Kp3I4XtcysEn8SChIyz+VOdiT
         fKK8ywgiCVhVQBHjW/qt5N4h1oQevA4ZhSw4Q6AI38O12K2HrGD702U57RLP/i6nlG/e
         KWe+Frfzxz1hsWj3xuiZMwARooukrDJNwK1NdHQcR3lrWQkWLLbfKXsKqinoM8iP8FtD
         WxUIintHLTELgXMfeWZqO/KwVems6bBzZ3EiqryVfucKxRFlHXBmeTwzQbcwjkbZYTuf
         4F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680556775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MIwuslKOv23RmObbF1opEGXBO5SntQiEEpUaiQ2xkw=;
        b=z9V5AdhgLUHYN2Wx9ZRc/lVHXfX7juOslEd22idAl+iXdrgRW9QQuVP5Wjc5zVRexj
         TQh15RIj2iZuL1s5fQsegwR5xqm2DIUXuojdvp+tnObHZgpl5E9DkbPrDTP8Mdzi+dbH
         QQ+LTNgldj1AVgld1qEQcI8UYZXUz1eehqvOxDqa7fCZpDSCKVWy4hUyvJvxsz9pR9Ba
         USBkZDo/j8wS5R/PhuMkdz+GQJzC4Br6lN2ksmCewQIGuYmlEF8E443VKiBfeo+lVgFo
         q3a5l+k3dlqCIVDzpqN7sdRwn9y98FpQx8AY6TGPlplom5TNLPoB1xvTHfJEF1ZcRzVt
         9SKw==
X-Gm-Message-State: AAQBX9douPvFNM3brl3hreLWk+fHayfFvs0ERzo0A4EAK7C/6DJCAuTx
        acV0GPAQxjWrdw8Nb1Fdu1fPr2Cd+oM=
X-Google-Smtp-Source: AKy350as6sEsccwjl6/R0AjaknzzuuYQpBo6CpKe/V5UwkgYSell9ckH3bWSIgb0ayPm7SwKy77zWA==
X-Received: by 2002:a17:90b:3b4f:b0:237:161e:33bc with SMTP id ot15-20020a17090b3b4f00b00237161e33bcmr316502pjb.16.1680556775321;
        Mon, 03 Apr 2023 14:19:35 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:da37:a7fa:157d:2446])
        by smtp.gmail.com with ESMTPSA id mr17-20020a17090b239100b002369a14d6b1sm10083835pjb.31.2023.04.03.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:19:34 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 3 Apr 2023 14:19:31 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, martin@omnibond.com, hubcap@omnibond.com,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        willy@infradead.org, hch@lst.de, devel@lists.orangefs.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] zram: always chain bio to the parent in
 read_from_bdev_async
Message-ID: <ZCtC4yhM5lZP7mEg@google.com>
References: <20230403132221.94921-1-p.raghav@samsung.com>
 <CGME20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f@eucas1p2.samsung.com>
 <20230403132221.94921-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403132221.94921-2-p.raghav@samsung.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 03, 2023 at 03:22:17PM +0200, Pankaj Raghav wrote:
> zram_bvec_read() is called with the bio set to NULL only in
> writeback_store() function. When a writeback is triggered,
> zram_bvec_read() is called only if ZRAM_WB flag is not set. That will
> result only calling zram_read_from_zspool() in __zram_bvec_read().
> 
> rw_page callback used to call read_from_bdev_async with a NULL parent
> bio but that has been removed since commit 3222d8c2a7f8
> ("block: remove ->rw_page").
> 
> We can now safely always call bio_chain() as read_from_bdev_async() will
> be called with a parent bio set. A WARN_ON_ONCE is added if this function
> is called with parent set to NULL.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.
