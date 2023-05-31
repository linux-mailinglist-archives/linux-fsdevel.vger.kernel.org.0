Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66FA71897B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjEaSk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjEaSk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 14:40:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95861B2;
        Wed, 31 May 2023 11:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28F6B63805;
        Wed, 31 May 2023 18:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37C8C4339B;
        Wed, 31 May 2023 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685558456;
        bh=jXLhgEASQyAknkS65fQC98zs5uvzjshg6q1Wuk42knc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m6hRFYjGE73M78kuem2RzITeOJ+vVJaQ+eGXVGnw9DnBr1ZAaN23Fsyr3fR/qZ+3m
         kgGPyGKAU6HrIJM0a6r5q6xmqDSdgkbZoyUlh35O1eBTZITmXambbpOZx5KGmZsw9B
         W08wSSNe4uwX7HYDuAu6Qfulxg8VbZZlYto+Ni8I=
Date:   Wed, 31 May 2023 11:40:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     tkhai@ya.ru, roman.gushchin@linux.dev, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        hughd@google.com, paulmck@kernel.org, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 0/8] make unregistration of super_block shrinker more
 faster
Message-Id: <20230531114054.bf077db642aa9c58c0831687@linux-foundation.org>
In-Reply-To: <20230531095742.2480623-1-qi.zheng@linux.dev>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 May 2023 09:57:34 +0000 Qi Zheng <qi.zheng@linux.dev> wrote:

> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Hi all,
> 
> This patch series aims to make unregistration of super_block shrinker more
> faster.
> 
> 1. Background
> =============
> 
> The kernel test robot noticed a -88.8% regression of stress-ng.ramfs.ops_per_sec
> on commit f95bdb700bc6 ("mm: vmscan: make global slab shrink lockless"). More
> details can be seen from the link[1] below.
> 
> [1]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
> 
> We can just use the following command to reproduce the result:
> 
> stress-ng --timeout 60 --times --verify --metrics-brief --ramfs 9 &
> 
> 1) before commit f95bdb700bc6b:
> 
> stress-ng: info:  [11023] dispatching hogs: 9 ramfs
> stress-ng: info:  [11023] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
> stress-ng: info:  [11023]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
> stress-ng: info:  [11023] ramfs            774966     60.00     10.18    169.45     12915.89        4314.26
> stress-ng: info:  [11023] for a 60.00s run time:
> stress-ng: info:  [11023]    1920.11s available CPU time
> stress-ng: info:  [11023]      10.18s user time   (  0.53%)
> stress-ng: info:  [11023]     169.44s system time (  8.82%)
> stress-ng: info:  [11023]     179.62s total time  (  9.35%)
> stress-ng: info:  [11023] load average: 8.99 2.69 0.93
> stress-ng: info:  [11023] successful run completed in 60.00s (1 min, 0.00 secs)
> 
> 2) after commit f95bdb700bc6b:
> 
> stress-ng: info:  [37676] dispatching hogs: 9 ramfs
> stress-ng: info:  [37676] stressor       bogo ops real time  usrtime  sys time   bogo ops/s     bogo ops/s
> stress-ng: info:  [37676]                           (secs)    (secs)   (secs)   (real time) (usr+sys time)
> stress-ng: info:  [37676] ramfs            168673     60.00     1.61    39.66      2811.08        4087.47
> stress-ng: info:  [37676] for a 60.10s run time:
> stress-ng: info:  [37676]    1923.36s available CPU time
> stress-ng: info:  [37676]       1.60s user time   (  0.08%)
> stress-ng: info:  [37676]      39.66s system time (  2.06%)
> stress-ng: info:  [37676]      41.26s total time  (  2.15%)
> stress-ng: info:  [37676] load average: 7.69 3.63 2.36
> stress-ng: info:  [37676] successful run completed in 60.10s (1 min, 0.10 secs)

Is this comparison reversed?  It appears to demonstrate that
f95bdb700bc6b made the operation faster.

