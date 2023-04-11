Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695FE6DD0F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 06:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDKEbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 00:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjDKEbc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E2010E;
        Mon, 10 Apr 2023 21:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7483061A4E;
        Tue, 11 Apr 2023 04:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E83C433EF;
        Tue, 11 Apr 2023 04:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681187490;
        bh=UMffUmwIMqiyU5UEzuN4976TTEXDP9TPdjyhgMkWT4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PHuqvFNEJrcTTZehVURel6pvMxSQSQP3xjWTrs9QuevRX0eQSR5KeWtJ56mF0OcW0
         aEqUniHL+M0Z+UE/BhmzAsukPR7zLQ2h7TCbR/Cho5BwOVlM5CSgxD3SGrI0WCheLT
         cgdWifzhlzscoDKTVx7FVWzN9ACF8QplOnsiDWW8=
Date:   Mon, 10 Apr 2023 21:31:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <yang.yang29@zte.com.cn>
Cc:     <bsingharora@gmail.com>, <mingo@redhat.com>, <corbet@lwn.net>,
        <juri.lelli@redhat.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH =?ISO-8859-1?Q?linux-next]=A0delayacct:?= track delays
 from IRQ/SOFTIRQ
Message-Id: <20230410213129.1d11261892767a61eacaefba@linux-foundation.org>
In-Reply-To: <202304081728353557233@zte.com.cn>
References: <202304081728353557233@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 8 Apr 2023 17:28:35 +0800 (CST) <yang.yang29@zte.com.cn> wrote:

> From: Yang Yang <yang.yang19@zte.com.cn>
> 
> Delay accounting does not track the delay of IRQ/SOFTIRQ.  While
> IRQ/SOFTIRQ could have obvious impact on some workloads productivity,
> such as when workloads are running on system which is busy handling
> network IRQ/SOFTIRQ.
> 
> Get the delay of IRQ/SOFTIRQ could help users to reduce such delay.
> Such as setting interrupt affinity or task affinity, using kernel thread for
> NAPI etc. This is inspired by "sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
> pressure"[1]. Also fix some code indent problems of older code.
> 
> And update tools/accounting/getdelays.c:
>     / # ./getdelays -p 156 -di
>     print delayacct stats ON
>     printing IO accounting
>     PID     156
> 
>     CPU             count     real total  virtual total    delay total  delay average
>                        15       15836008       16218149      275700790         18.380ms
>     IO              count    delay total  delay average
>                         0              0          0.000ms
>     SWAP            count    delay total  delay average
>                         0              0          0.000ms
>     RECLAIM         count    delay total  delay average
>                         0              0          0.000ms
>     THRASHING       count    delay total  delay average
>                         0              0          0.000ms
>     COMPACT         count    delay total  delay average
>                         0              0          0.000ms
>     WPCOPY          count    delay total  delay average
>                        36        7586118          0.211ms
>     IRQ             count    delay total  delay average
>                        42         929161          0.022ms

Seems sensible.  I'm not sure who's the best person to review/ack this
nowadays.

We're somewhat double-accounting.  Delays due to, for example, IO will
already include delays from IRQ activity.  But it's presumably a minor
thing and I don't see why anyone would care.

