Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9967866CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 06:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbjHXEiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 00:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbjHXEil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:38:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ABA10E4
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 21:38:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf7423ef3eso29522175ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 21:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692851919; x=1693456719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjmeAFSbeYSQx6eaOnaJcOZMrGEAlfmPS+XdM6xijgo=;
        b=nF4G3zvj/oRdJns1E23Jmn7/GrxQ9Fafwn2zCgySY2cvwA/rLmLxsUV4Ec2pIQhrzD
         WInH1gjFuY8wyYGMwl8wQfgZMnbuI7XGZNyVlH5h5qBvmYkCFS2T11wmvKG6t5uLIJa9
         EfXJrMif/6WO6N5S+LI98aJro9TK68e8JG0Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692851919; x=1693456719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjmeAFSbeYSQx6eaOnaJcOZMrGEAlfmPS+XdM6xijgo=;
        b=D1uDnLID2T+ghUk3iM6SliolmgkLd2NPvN6zZRu854cCb0T1z8bCriEtZiaJuv4+dd
         hhIwbVe1p1SjuWoArodHZQqo2jCttXd2NX6qb2iLF5/lWwQ46mrpv80+xqNnPamd+Dfg
         StHv41io00Au476Cmd743zKi+Vij66utYhH8smKsAq7RWbUxCALZmFIf6r0/XQv/eMEW
         j63XsYFeczQqHKUQ/WPfsm6MI+YtIg4UocmMKafbtLQNv75XXHMbbicyXgpX4si0q2BJ
         l5KqxU3rbyZ1lhRyc2ENWzdNi3Bv3RtRa0UvHzFaPszyyUql6WL4d3DeFYAa10LwHyLR
         lqlA==
X-Gm-Message-State: AOJu0Yyw3oBhuqJcynhJQjud5vicX202aWzCTWNT8i0g7/oIzLmHNJLu
        tQRu1pse3IorHTLlf1/i9P9G7w==
X-Google-Smtp-Source: AGHT+IFLfR5iGhFORMLjIVK/dQhQFkboVCHuAZnpxgVO0XlCNNG37enCJL3sXb4VGRzResYRe1oNvg==
X-Received: by 2002:a17:903:41cc:b0:1af:aafb:64c8 with SMTP id u12-20020a17090341cc00b001afaafb64c8mr12782247ple.21.1692851919061;
        Wed, 23 Aug 2023 21:38:39 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1ece:b679:4a91:d1e])
        by smtp.gmail.com with ESMTPSA id ij30-20020a170902ab5e00b001b881a8251bsm11919322plb.106.2023.08.23.21.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 21:38:38 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:38:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v5 37/45] zsmalloc: dynamically allocate the mm-zspool
 shrinker
Message-ID: <20230824043832.GC610023@google.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
 <20230824034304.37411-38-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824034304.37411-38-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (23/08/24 11:42), Qi Zheng wrote:
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the mm-zspool shrinker, so that it can be freed
> asynchronously via RCU. Then it doesn't need to wait for RCU read-side
> critical section when releasing the struct zs_pool.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: Minchan Kim <minchan@kernel.org>
> CC: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
