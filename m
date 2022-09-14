Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD55B875A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 13:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiINLlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 07:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiINLlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:41:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFFB7AC3A
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 04:41:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id az6so11412776wmb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UQ6ki4yX5kQtVY1QftaIadGFPpTJFOi0It8Nz6sT1sA=;
        b=q/oyayVc8gtEqunNB1xJ3/FfxrAeboEzVVJSS32eCQHH7YkWiqGgc4DvqOkB0BmKB4
         EGBb59YfleXrHU3uhnARoWo1nkO+5gVkRg434+fP58rkbQ+KyzSzFEdZMFr+gIQUNJxq
         vNaGHKI6gzmX6l03osdo1ByMaXvFnCpGisqVbAa62a/tMQq7SKC2J88arzMPMDjYF36K
         5xDreZXRw+mz8OAlu6KXnu1yjwXtnaapCWAG0NQxDQmrAHbEmFBM9EVDoD7eLf/StPtW
         PVPtrMfMkfxUHkfJjD5j7HiSoRmkXQ3yJjff0qqwea5vgyNr/Dz+Fg3Y5dDOdpUikG5Q
         wIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UQ6ki4yX5kQtVY1QftaIadGFPpTJFOi0It8Nz6sT1sA=;
        b=kQXVvgM6J/0tYOHt5jQqv+dNDM5c9z51HS5nOfK/AUDqa+JiQpnto8DBusRZQzsVpZ
         UiXywuIJo4LFmOLkc7WWYF50wKk0FCgQe5Fv1lm0LMFfMs6Gs8nU238JRTZUdL+0JL4s
         dYYpWX/wy2kF7WvwGb+3ZsyR4LaAAVWALgbv3+6ylVNyeCTjRRjZg8TEmT6eoUh1vbPm
         GlGMkOHbvJ8x3hWkZS+NRiDz7hhaoPOU612ZBFTNbi08uorF39hDJYmC5+WtbdUp68+4
         pvMDvBL3EHXtrehqMiPdekaThomSEIA4gRkr26O2nBvhRvAc8Y+QpykXoPJlbVNOKrJo
         k5BA==
X-Gm-Message-State: ACgBeo0cv0gpkQgetS1Aw8rRvFWZKBIuIG696Ohpt4gg5M316evXSzZ3
        W7sw1dG8YOwSddMWMDIDSiETrw==
X-Google-Smtp-Source: AA6agR5iucBxgT+lWuCgOcqjgv1Qz0MJiMgw6JKNQ8nsLCUf51/5QiLnwph6LP3BZLcxpH7lhwgthg==
X-Received: by 2002:a7b:c457:0:b0:3b4:689d:b408 with SMTP id l23-20020a7bc457000000b003b4689db408mr2835029wmi.22.1663155702145;
        Wed, 14 Sep 2022 04:41:42 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5951000000b00228dc37ce2asm13229870wri.57.2022.09.14.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:41:41 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:41:40 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: add PSI accounting around ->read_folio and
 ->readahead calls
Message-ID: <YyG99D196Hj0/GgZ@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-2-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 10, 2022 at 08:50:54AM +0200, Christoph Hellwig wrote:
> PSI tries to account for the cost of bringing back in pages discarded by
> the MM LRU management.  Currently the prime place for that is hooked into
> the bio submission path, which is a rather bad place:
> 
>  - it does not actually account I/O for non-block file systems, of which
>    we have many
>  - it adds overhead and a layering violation to the block layer
> 
> Add the accounting into the two places in the core MM code that read
> pages into an address space by calling into ->read_folio and ->readahead
> so that the entire file system operations are covered, to broaden
> the coverage and allow removing the accounting in the block layer going
> forward.
> 
> As psi_memstall_enter can deal with nested calls this will not lead to
> double accounting even while the bio annotations are still present.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is much cleaner. With the fixlet Willy pointed out:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
