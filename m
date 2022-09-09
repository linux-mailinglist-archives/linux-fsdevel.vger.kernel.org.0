Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177D85B4022
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 21:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiIITrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 15:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiIITrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:47:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005B22BB3E;
        Fri,  9 Sep 2022 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=PEeVwIo7409WEJkloETqqjFRsCULu9arzy1LvgXiyKI=; b=Q1WhaVDuCHAj8dH6b5oYBWKmg3
        9aJ4m21t5CjQs7q5t5fyrL02UZ8d4/Ch6G2MJY5vGWgcrVxKK22YLlnBkajzl40uVQkHEZ0CCtOh+
        PJIspLldhv2/8xzTPohFSPBDNFEqFB7tyFgPa3pr7055gDl2n4NjlM6epF7CvbprdzYhs9H+qw9wF
        mbBd4dlki+QGXVKVbKyBx8xE2184OxbsFtevq8X1HzpXYImjnfayEfC/DVEvVpb50KpdOxFmJTfqw
        KJiAojRfVuBqOyftKoHUaQtbNI4LMU+Zk1/OVvf+FGC/D/hbVcpf/nenaiWxP+1w/+LtkwyP68ZCm
        oE+rGYWA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWjvc-0028Gm-Cy; Fri, 09 Sep 2022 19:44:40 +0000
Date:   Fri, 9 Sep 2022 12:44:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sched: Move numa_balancing sysctls to its own file
Message-ID: <YxuXqF63RIMstdEN@bombadil.infradead.org>
References: <20220908072531.87916-1-wangkefeng.wang@huawei.com>
 <YxqDa+WALRr8L7Q8@bombadil.infradead.org>
 <679d8f0c-f8cc-d43e-5467-c32a78bcb850@huawei.com>
 <d99630ed-0753-da9e-ab03-848b66bc3c63@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d99630ed-0753-da9e-ab03-848b66bc3c63@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 11:37:41AM +0800, Kefeng Wang wrote:
> 
> On 2022/9/9 9:46, Kefeng Wang wrote:
> > 
> > On 2022/9/9 8:06, Luis Chamberlain wrote:
> > > On Thu, Sep 08, 2022 at 03:25:31PM +0800, Kefeng Wang wrote:
> > > > The sysctl_numa_balancing_promote_rate_limit and sysctl_numa_balancing
> > > > are part of sched, move them to its own file.
> > > > 
> > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > There is quite a bit of random cleanup on each kernel release
> > > for sysctls to do things like what you just did. Because of this it
> > > has its
> > > own tree to help avoid conflicts. Can you base your patches on the
> > > sysctl-testing branch here and re-submit:
> > 
> > Found this when reading memory tiering code，sure to re-submit based
> > your branch,
> > 
> > thanks.
> > 
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing
> > > 
> Hi Luis，the numa_balancing_promote_rate_limit_MBps from commit 1db91dd846e0
> “memory tiering: rate limit NUMA migration throughput”only on
> linux-next（from mm repo），
> 
> 1）only send sysctl_numa_balancing changes based on your branch
> or
> 
> 2）queued this patch from mm repo if no objection， Cc'ed Andrew
> 
> Which one do your like, or other options, thanks.

2) as that would give more testing to the new code as well. We can deal
with merge conflicts on my tree later.

  Luis
