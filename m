Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE6136531C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 09:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhDTHVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 03:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhDTHVX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:21:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAC9860C40;
        Tue, 20 Apr 2021 07:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618903252;
        bh=Ciqp0HqfGZibJ89pF/L2lKK2JBtAZcO03tptwL0YyAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZsQW3+Qm5LDVOpORw7z9UfDvMeJX1isMcl3sFgRXUSbDjLVZNniqkwH5+f5dsI1q
         LYfLhR1QyH6E+SIlzEDS5Q6+l1ccISlQ32/NcssVRZpoiHcFlJonoqWMfXuy2xYeVE
         v2gMsTtZHxpnK3A4vyIyx2+PKOo/Vx31Y/rALlPrzYVumKOUUb8HmPEJF63f2uB4E1
         JVuMvvGp/guaaRRvG9vfxDN5C54CmcI8UoaRlUeTDtbQCT7Rpn4AF0aQgcE04pJVEH
         dWkd09ghtV6zXu5Exf9UBe+fDUks1vRvM3LpuuLUiBec4qWWR0bVMiTgvERaRXSLbu
         hufBhTUWwNMjw==
Date:   Tue, 20 Apr 2021 10:20:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Peter.Enderborg@sony.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sumit.semwal@linaro.org,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        neilb@suse.de, samitolvanen@google.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, willy@infradead.org
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <YH6Ayy1fWGGWMU+q@kernel.org>
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <YH10s/7MjxBBsjVL@dhcp22.suse.cz>
 <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
 <YH2a9YfRBlfNnF+u@dhcp22.suse.cz>
 <23aa041b-0e7c-6f82-5655-836899973d66@sony.com>
 <d70efba0-c63d-b55a-c234-eb6d82ae813f@amd.com>
 <YH2ru642wYfqK5ne@dhcp22.suse.cz>
 <07ed1421-89f8-8845-b254-21730207c185@amd.com>
 <YH59E15ztpTTUKqS@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YH59E15ztpTTUKqS@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 09:04:51AM +0200, Michal Hocko wrote:
> On Mon 19-04-21 18:37:13, Christian König wrote:
> > Am 19.04.21 um 18:11 schrieb Michal Hocko:
> [...]
> > > The question is not whether it is NUMA aware but whether it is useful to
> > > know per-numa data for the purpose the counter is supposed to serve.
> > 
> > No, not at all. The pages of a single DMA-buf could even be from different
> > NUMA nodes if the exporting driver decides that this is somehow useful.
> 
> As the use of the counter hasn't been explained yet I can only
> speculate. One thing that I can imagine to be useful is to fill gaps in
> our accounting. It is quite often that the memroy accounted in
> /proc/meminfo (or oom report) doesn't add up to the overall memory
> usage. In some workloads the workload can be huge! In many cases there
> are other means to find out additional memory by a subsystem specific
> interfaces (e.g. networking buffers). I do assume that dma-buf is just
> one of those and the counter can fill the said gap at least partially
> for some workloads. That is definitely useful.

A bit off-topic.

Michal, I think it would have been nice to have an explanation like above
in Documentation/proc/meminfo, what do you say?
 
> What I am trying to bring up with NUMA side is that the same problem can
> happen on per-node basis. Let's say that some user consumes unexpectedly
> large amount of dma-buf on a certain node. This can lead to observable
> performance impact on anybody on allocating from that node and even
> worse cause an OOM for node bound consumers. How do I find out that it
> was dma-buf that has caused the problem?
> 
> See where I am heading?

-- 
Sincerely yours,
Mike.
