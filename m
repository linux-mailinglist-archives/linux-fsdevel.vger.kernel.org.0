Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6FE7BF3DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 09:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442404AbjJJHNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 03:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379430AbjJJHNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:13:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E34C1;
        Tue, 10 Oct 2023 00:13:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405505b07dfso37256135e9.0;
        Tue, 10 Oct 2023 00:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696921996; x=1697526796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nE9aiJrm4ted7Ukaf01MpJcnv2AYuYnqOGSiPXqLQr4=;
        b=RTMXS0YdpxPS4UBgZCXdVJ0V2ESreCQFdKS4TlnqSSHBf21kkElYx3AgONvcDSlL4M
         OCZC89iRPTQaGfLqnE5WksWX5CSS2x8SiGupw3rXHVjpLwzotZeVlQ1tlLSkb70ObWlT
         ECimAWbjva4orlEhl5moR5KtzRsZYywjeya1bj9uZwq7kpGCkzoa1kQ2SaUMTlvVJYrf
         fRreA+NyNpCESksrVw2e5TCSmiehAsvsjsjqmKUI0tkm+82GrhkHrjRoHfBi6gR7Zol4
         cI6nFlL62NV3S7Uy4P+G9AzGhrFo/+8tggR06ItLxmd38NXy6d5gooMBL12jqg/dfz21
         f8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696921996; x=1697526796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nE9aiJrm4ted7Ukaf01MpJcnv2AYuYnqOGSiPXqLQr4=;
        b=wh1zt/rD/bp32fabhm1GB9Tn/WKP6eNMrRNYj+WWwGNEJTN0rULkbzAEtWsetBjrmC
         xoE6YAkv8ddK2elnzxakcFmy+LNCljERdgYlpveFA6mhaND0WuKirz/LC9UhlR8NchjI
         wphYCrJnyB4LYGRF4b4EEs+nYwrdb+kMpluhnN9IXdhkMxT3M46U5033pURwCjm4XAie
         P7ynmsleBd31ik+3K41TDlZoCdTDSmUhRJJphrP9KBiNzLiRZQFs5xmIrHH6IfjQQxYm
         gDD7nu06Y0Mte7kYmx3R1GeQQllPF5IV/sP7qHCC3xex6rcs9jNf7WRR96UDmE1w68zp
         wGJA==
X-Gm-Message-State: AOJu0Yx6SVGX5YM5g6CFH+RF0MKTrDK4GP3vsbbui+7nPWOvl9Ppcpi4
        3qSTGr2PqAmJzdfl4mqSI+g=
X-Google-Smtp-Source: AGHT+IEMK3dnzqR0YMCMMhmlLJsFVCbOTmAUrW3SQ0SjhNBLlhMrVlrp2v8Men4b9e/+7Xlv5qD1Gg==
X-Received: by 2002:adf:edcb:0:b0:329:6b62:8d18 with SMTP id v11-20020adfedcb000000b003296b628d18mr9015111wro.0.1696921995549;
        Tue, 10 Oct 2023 00:13:15 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id q14-20020adfcb8e000000b003296b488961sm11146171wrh.31.2023.10.10.00.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:13:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Oct 2023 09:13:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Bin Lai <sclaibin@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, akpm@linux-foundation.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] sched: Remove wait bookmarks
Message-ID: <ZST5iCDLYMJespiy@gmail.com>
References: <20231010032833.398033-1-robinlai@tencent.com>
 <20231010035829.544242-1-willy@infradead.org>
 <20231010035829.544242-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010035829.544242-2-willy@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> There are no users of wait bookmarks left, so simplify the wait
> code by removing them.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
>  include/linux/wait.h |  9 +++----
>  kernel/sched/wait.c  | 60 ++++++++------------------------------------
>  2 files changed, 13 insertions(+), 56 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
