Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B2B6C2BC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 08:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCUH4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 03:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCUH4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:56:35 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2C417165;
        Tue, 21 Mar 2023 00:56:33 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id 49067E0360; Tue, 21 Mar 2023 07:56:32 +0000 (UTC)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     yujie.liu@intel.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        iamjoonsoo.kim@lge.com
Cc:     bagasdotme@gmail.com, feng.tang@intel.com, fengwei.yin@intel.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lkp@intel.com, oe-lkp@lists.linux.dev,
        ran.xiaokai@zte.com.cn, willy@infradead.org,
        yang.yang29@zte.com.cn, ying.huang@intel.com,
        zhengjun.xing@linux.intel.com
Subject: [linus:master] [swap_state] 5649d113ff: vm-scalability.throughput -33.1% regression
Date:   Tue, 21 Mar 2023 07:56:32 +0000
Message-Id: <20230321075632.28775-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320124100.25297-1-yang.yang29@zte.com.cn>
References: <20230320124100.25297-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,
        HEADER_FROM_DIFFERENT_DOMAINS,HELO_NO_DOMAIN,NO_DNS_FOR_FROM,
        RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL_NO_RDNS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> commit: 
>  04bac040bc ("mm/hugetlb: convert get_hwpoison_huge_page() to folios")
>  5649d113ff ("swap_state: update shadow_nodes for anonymous page")
> 04bac040bc71b4b3 5649d113ffce9f532a9ecc5ab96 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>  10026093 ±  3%     -33.1%    6702748 ±  2%  vm-scalability.throughput

> 04bac040bc71b4b3 5649d113ffce9f532a9ecc5ab96 
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \  
>    553378           -11.1%     492012 ±  2%  vm-scalability.median

I see the two results are much different, one is -33.1%, another is -11.1%.
So I tried more times to reproduce on my machine, and see a 8% of regression
of vm-scalability.throughput.

As this test add/delete/clear swap cache frequently, the impact of commit
5649d113ff might be magnified ?

Commit 5649d113ff tried to fix the problem that if swap space is huge and
apps are using many shadow entries, shadow nodes may waste much space in
memory. So the shadow nodes should be reclaimed when it's number is huge while
memory is in tense.

I reviewed commit 5649d113ff carefully, and didn't found any obviously
problem. If we want to correctly update shadow_nodes for anonymous page,
we have to update them when add/delete/clear swap cache.

Thanks.
