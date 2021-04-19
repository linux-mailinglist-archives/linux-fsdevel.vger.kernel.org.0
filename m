Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA45364693
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 17:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbhDSPAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 11:00:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238029AbhDSPAh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:00:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618844406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wif7xFamvaZAIzcaSwXiFOKU2ayIr8fdot8BMxjAWOs=;
        b=hnWLD+YYgLB1hJLch8Q0Us+SAQdF9bY2lARPYc+xgthdBTMLWOnNXdT2PXqo+COy6sGSZV
        rpUvHzVpK2ULuoPAyKjkv01PqHD4Pj1QC6hDzyI5FoDNQsfvNNu2mVCa0Ke+SqqeCS/cbM
        kco/IXaDcfPFu/KOLOV6ruIiArhFYyI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0D86B301;
        Mon, 19 Apr 2021 15:00:05 +0000 (UTC)
Date:   Mon, 19 Apr 2021 17:00:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter.Enderborg@sony.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        neilb@suse.de, samitolvanen@google.com, rppt@kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, willy@infradead.org
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <YH2a9YfRBlfNnF+u@dhcp22.suse.cz>
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <YH10s/7MjxBBsjVL@dhcp22.suse.cz>
 <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 19-04-21 12:41:58, Peter.Enderborg@sony.com wrote:
> On 4/19/21 2:16 PM, Michal Hocko wrote:
> > On Sat 17-04-21 12:40:32, Peter Enderborg wrote:
> >> This adds a total used dma-buf memory. Details
> >> can be found in debugfs, however it is not for everyone
> >> and not always available. dma-buf are indirect allocated by
> >> userspace. So with this value we can monitor and detect
> >> userspace applications that have problems.
> > The changelog would benefit from more background on why this is needed,
> > and who is the primary consumer of that value.
> >
> > I cannot really comment on the dma-buf internals but I have two remarks.
> > Documentation/filesystems/proc.rst needs an update with the counter
> > explanation and secondly is this information useful for OOM situations
> > analysis? If yes then show_mem should dump the value as well.
> >
> > From the implementation point of view, is there any reason why this
> > hasn't used the existing global_node_page_state infrastructure?
> 
> I fix doc in next version.  Im not sure what you expect the commit message to include.

As I've said. Usual justification covers answers to following questions
	- Why do we need it?
	- Why the existing data is insuficient?
	- Who is supposed to use the data and for what?

I can see an answer for the first two questions (because this can be a
lot of memory and the existing infrastructure is not production suitable
- debugfs). But the changelog doesn't really explain who is going to use
the new data. Is this a monitoring to raise an early alarm when the
value grows? Is this for debugging misbehaving drivers? How is it
valuable for those?

> The function of the meminfo is: (From Documentation/filesystems/proc.rst)
> 
> "Provides information about distribution and utilization of memory."

True. Yet we do not export any random counters, do we?

> Im not the designed of dma-buf, I think  global_node_page_state as a kernel
> internal.

It provides a node specific and optimized counters. Is this a good fit
with your new counter? Or the NUMA locality is of no importance?

> dma-buf is a device driver that provides a function so I might be
> on the outside. However I also see that it might be relevant for a OOM.
> It is memory that can be freed by killing userspace processes.
> 
> The show_mem thing. Should it be a separate patch?

This is up to you but if you want to expose the counter then send it in
one series.

-- 
Michal Hocko
SUSE Labs
