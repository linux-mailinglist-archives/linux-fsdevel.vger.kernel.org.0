Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0576F474487
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 15:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhLNOJx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 09:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhLNOJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:09:52 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C480C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 06:09:51 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id s9so17265608qvk.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 06:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e/FTEzYorakqcCqN0foNPkMgFogJ8h7Uad16SL0Kod8=;
        b=fiM4FWee3dul+2cfhZ6ic8ErBUv5+rkcAB8xBrNiE8/yU0VqkMKWUerZTWAglEdzdh
         W6MJBZtSejf4gmfD42WSu62rv/jtlZnPptrfWvHKHYRp3yGdN/DseeN2LBRTj4+ECtd8
         3mO5fl3fKCMNsVpWvdmBd7po3Bj4ugGiq9GghUy/aj2PGYjfX1EycYqSEDu6BdkEnAbx
         9LbLh76pnG1R2zCG1pVaRNy/+TBgkJXcj2HZ8xXnbH32oEMIs1jrXRDNy0GmyW5QZuS7
         FD/8lebSWnO/lhHAYtAk+tb49nMxdVn5qOEZtQWT4LL/tcnIOUVn4fRLYX8hzKZrQtu+
         xuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/FTEzYorakqcCqN0foNPkMgFogJ8h7Uad16SL0Kod8=;
        b=hJAL7cUmnvO7eIxYsoVjJ1w/igPkSgCcdrzqvuRAhJMu7hx8TRObZya4HycDODCU/u
         +qGbytL4Hckgenw2dFpDYBEfFnEWizAL/UuzcT6ftu8C0jXjihcS1FcZ7fEHE1RKe7sP
         VVr6ghGZyyC3U7TDRRfZW7Fha4UsJvmVisPgcuZvvW9SMkGQF37zQW4V4XCcgGmPqigR
         v4VNZBWNd1r4iJR0jgLZAEoBRpc0iRrI+6X5ce65necDyPgfWiuMko7a5IKVwpjpFbTD
         /lqW7leb5Xu6goxB1pxzoE+WllNja1552T8zL9UEby7B2UDvGPX83dzBdJggaAvAS34n
         7r4w==
X-Gm-Message-State: AOAM531mHBYwjzpQdJo15LbFvj5jYqRbPiazmRQ3btUaTwZnYBQitr/u
        71sCFlGZ0F1LT+V4vlBPlrxLRA==
X-Google-Smtp-Source: ABdhPJxD4XJX7z+NX4zxsgKTvBDdRu6CMymo1161/eZjp2r4yhFzTcY1TXXuJLhI8Hjhn6i4vHaVgQ==
X-Received: by 2002:a05:6214:20e4:: with SMTP id 4mr5743250qvk.95.1639490989223;
        Tue, 14 Dec 2021 06:09:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e1e4])
        by smtp.gmail.com with ESMTPSA id v12sm12189863qtx.80.2021.12.14.06.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 06:09:48 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:09:46 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com, guro@fb.com,
        shy828301@gmail.com, alexs@kernel.org, richard.weiyang@gmail.com,
        david@fromorbit.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, jaegeuk@kernel.org, chao@kernel.org,
        kari.argillander@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com
Subject: Re: [PATCH v4 09/17] mm: workingset: use xas_set_lru() to pass
 shadow_nodes
Message-ID: <YbilqnwnuTiQ2FEB@cmpxchg.org>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
 <20211213165342.74704-10-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213165342.74704-10-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 14, 2021 at 12:53:34AM +0800, Muchun Song wrote:
> The workingset will add the xa_node to shadow_nodes, so we should use
> xas_set_lru() to pass the list_lru which we want to insert xa_node
> into to set up the xa_node reclaim context correctly.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Ah, you can't instantiate the list on-demand in list_lru_add() because
that's happening in an atomic context. So you need the lru available
in the broader xa update context and group the lru setup in with the
other pre-atomic node allocation bits. Fair enough. I think it would
be a bit easier to read if this patch and the previous one were
squashed (workingset is the only user of xa_lru anyway) and you added
that explanation. But other than that, the changes make sense to me;
to a combined patch, please add:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
