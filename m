Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5585D457B9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 06:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhKTFEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Nov 2021 00:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhKTFEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Nov 2021 00:04:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990C2C06173E;
        Fri, 19 Nov 2021 21:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fON0lxkCCP3L75Wlm+2KB5r1mpxAWywMnz/1PRTo2iM=; b=cyiAIP+nN8cwtnO8uxOeds523R
        f8WPqgcHmubx387ec5SOjSZENwDl3h5TXBUCRayzgpMEG+nLpiiOmP62Dk52G5DK+JGBpV6Wsl6CG
        wkWyUd6CFeBWXymjRkzj1MUPEQVWCjc8i7fwmQ8M+ttsYdI77dcpDemYghZ8Vpf/OhJ9yy0f83Hj6
        0Enz1uButE8EqMn+02rZJTRB1waVikL+pC4uikfLYvC8Pi/IM7xxHCNeLGWB1qs24suLITEZnkhLb
        3MCeG7nRIlV9ODi20SiIpQAWoiYfU15MSdzTM71S0BLS4nQR+BrS6oD0XZWitLFrhdTHLYpalprYU
        z6lzyMhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1moIV5-00AEt9-Cv; Sat, 20 Nov 2021 05:01:19 +0000
Date:   Sat, 20 Nov 2021 05:01:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <guro@fb.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 0/4] Deterministic charging of shared memory
Message-ID: <YZiBH6GxlkFFuyqa@casper.infradead.org>
References: <20211120045011.3074840-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120045011.3074840-1-almasrymina@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 08:50:06PM -0800, Mina Almasry wrote:
> 1. One complication to address is the behavior when the target memcg
> hits its memory.max limit because of remote charging. In this case the
> oom-killer will be invoked, but the oom-killer may not find anything
> to kill in the target memcg being charged. Thera are a number of considerations
> in this case:
> 
> 1. It's not great to kill the allocating process since the allocating process
>    is not running in the memcg under oom, and killing it will not free memory
>    in the memcg under oom.
> 2. Pagefaults may hit the memcg limit, and we need to handle the pagefault
>    somehow. If not, the process will forever loop the pagefault in the upstream
>    kernel.
> 
> In this case, I propose simply failing the remote charge and returning an ENOSPC
> to the caller. This will cause will cause the process executing the remote
> charge to get an ENOSPC in non-pagefault paths, and get a SIGBUS on the pagefault
> path.  This will be documented behavior of remote charging, and this feature is
> opt-in. Users can:
> - Not opt-into the feature if they want.
> - Opt-into the feature and accept the risk of received ENOSPC or SIGBUS and
>   abort if they desire.
> - Gracefully handle any resulting ENOSPC or SIGBUS errors and continue their
>   operation without executing the remote charge if possible.

Why is ENOSPC the right error instead of ENOMEM?
