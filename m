Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995A331C726
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 09:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBPINW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 03:13:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhBPINV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:13:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613463155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5QsXYyE8z2VKQ4MnO2HFDm3PsxDTFu4+x9dngf5//g=;
        b=mJfaUIShUOf+vrFTpdnPwvAuDqNv1KtPX3BaoOmFuXkS+wZj09kth9CArqbSxZvT9AogNw
        MvQJgMClfgtFYZhducrOa4KfrOmAxqf6WuJMHfMEYJpgZM8HkPg6EZmLwbJ+kbVWGo76JW
        nNV3NPQrh8KNR7WMyyNZbrHt6V3OlQs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F986B027;
        Tue, 16 Feb 2021 08:12:35 +0000 (UTC)
Date:   Tue, 16 Feb 2021 09:12:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, felipe.franciosi@nutanix.com
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Message-ID: <YCt+cVvWPbWvt2rG@dhcp22.suse.cz>
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-02-21 03:07:13, Eiichi Tsukata wrote:
> Hugepages can be preallocated to avoid unpredictable allocation latency.
> If we run into 4k page shortage, the kernel can trigger OOM even though
> there were free hugepages. When OOM is triggered by user address page
> fault handler, we can use oom notifier to free hugepages in user space
> but if it's triggered by memory allocation for kernel, there is no way
> to synchronously handle it in user space.

Can you expand some more on what kind of problem do you see?
Hugetlb pages are, by definition, a preallocated, unreclaimable and
admin controlled pool of pages. Under those conditions it is expected
and required that the sizing would be done very carefully. Why is that a
problem in your particular setup/scenario?

If the sizing is really done properly and then a random process can
trigger OOM then this can lead to malfunctioning of those workloads
which do depend on hugetlb pool, right? So isn't this a kinda DoS
scenario?

> This patch introduces a new sysctl vm.sacrifice_hugepage_on_oom. If
> enabled, it first tries to free a hugepage if available before invoking
> the oom-killer. The default value is disabled not to change the current
> behavior.

Why is this interface not hugepage size aware? It is quite different to
release a GB huge page or 2MB one. Or is it expected to release the
smallest one? To the implementation...

[...]
> +static int sacrifice_hugepage(void)
> +{
> +	int ret;
> +
> +	spin_lock(&hugetlb_lock);
> +	ret = free_pool_huge_page(&default_hstate, &node_states[N_MEMORY], 0);

... no it is going to release the default huge page. This will be 2MB in
most cases but this is not given.

Unless I am mistaken this will free up also reserved hugetlb pages. This
would mean that a page fault would SIGBUS which is very likely not
something we want to do right? You also want to use oom nodemask rather
than a full one.

Overall, I am not really happy about this feature even when above is
fixed, but let's hear more the actual problem first.
-- 
Michal Hocko
SUSE Labs
