Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74991364163
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 14:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhDSMRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 08:17:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:59482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239056AbhDSMRX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:17:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618834612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QG3FZepALNOXbfOMZTZu4JoFLk2WHpD1FD7YNk9rFs=;
        b=RhyVY6F1oXXJJ0u02/my9iujY24PbMKXnhcPvKnsIWwqBhMALOOoQ7RunU7EpQkZkfxyBm
        lx6Qa712ew80FHgx4LWwEE0vXZvseFWiNf2aX/33YqJTRPqlJj6YSOwl3tET9DaVJ8jqnA
        NFsJCiCri0lP+QT64xWntvhNif6TALw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2094AF65;
        Mon, 19 Apr 2021 12:16:52 +0000 (UTC)
Date:   Mon, 19 Apr 2021 14:16:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, NeilBrown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <YH10s/7MjxBBsjVL@dhcp22.suse.cz>
References: <20210417104032.5521-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417104032.5521-1-peter.enderborg@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 17-04-21 12:40:32, Peter Enderborg wrote:
> This adds a total used dma-buf memory. Details
> can be found in debugfs, however it is not for everyone
> and not always available. dma-buf are indirect allocated by
> userspace. So with this value we can monitor and detect
> userspace applications that have problems.

The changelog would benefit from more background on why this is needed,
and who is the primary consumer of that value.

I cannot really comment on the dma-buf internals but I have two remarks.
Documentation/filesystems/proc.rst needs an update with the counter
explanation and secondly is this information useful for OOM situations
analysis? If yes then show_mem should dump the value as well.

From the implementation point of view, is there any reason why this
hasn't used the existing global_node_page_state infrastructure?
-- 
Michal Hocko
SUSE Labs
