Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49A777865D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 06:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjHKEJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 00:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjHKEJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 00:09:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1837E4F;
        Thu, 10 Aug 2023 21:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z8egCMDdCKN1EXCGPL4reMjRjk9xsFH++3pfyuruZfU=; b=MOTPjcIZLPn8WruQCRaT70LBFW
        Gxf/2nUHoKqaDmGMHP13PMdotlfYwDeUGaoFx3o72tAXtkZF8zGmUvDtlgT+U11pajT1+ZBZcYjxV
        9PHkKNJY2kpIJe9xNTTxgqyClyNdcWiS0IlxnuWBdLQXNaCMmmeRA+cCLCX8gqf1HsfKww/PKQUov
        1bpVTJ3ZnckLSrlUxE8VyKEZKSZo2CZa5l19Gp1k+JbJresJBrAurBlUaVPJJDTPikPUWOG7JVK55
        IXpD6mYSi7z3dI0uti6BJhIDlWi2+AhZlUedsg/SF8G+MgGeUO9cvS/1p9N6qrGcx5GKHfdy97/CW
        0cazM6bw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUJSK-00GYNf-GK; Fri, 11 Aug 2023 04:08:56 +0000
Date:   Fri, 11 Aug 2023 05:08:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hui Zhu <teawaterz@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, akpm@linux-foundation.org, jack@suse.cz,
        yi.zhang@huawei.com, hare@suse.de, p.raghav@samsung.com,
        ritesh.list@gmail.com, mpatocka@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, teawater@antgroup.com,
        teawater@gmail.com
Subject: Re: [PATCH] ext4_sb_breadahead_unmovable: Change to be no-blocking
Message-ID: <ZNW0WF/K8HS8AIu5@casper.infradead.org>
References: <20230811035705.3296-1-teawaterz@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811035705.3296-1-teawaterz@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:57:05AM +0000, Hui Zhu wrote:
> Encountered an issue where a large number of filesystem reads and writes
> occurred suddenly within a container.  At the same time, other tasks on
> the same host that were performing filesystem read and write operations
> became blocked.  It was observed that many of the blocked tasks were
> blocked on the ext4 journal lock. For example:
> PID: 171453 TASK: ffff926566c9440 CPU: 54 COMMAND: "Thread"
> 
> Meanwhile, it was observed that the task holding the ext4 journal lock
> was blocked for an extended period of time on "shrink_page_list" due to
> "ext4_sb_breadahead_unmovable".
> 
> The function "grow_dev_page" increased the gfp mask with "__GFP_NOFAIL",
> causing longer blocking times.
> 	/*
> 	 * XXX: __getblk_slow() can not really deal with failure and
> 	 * will endlessly loop on improvised global reclaim.  Prefer
> 	 * looping in the allocator rather than here, at least that
> 	 * code knows what it's doing.
> 	 */
> 	gfp_mask |= __GFP_NOFAIL;
> However, "ext4_sb_breadahead_unmovable" is a prefetch function and
> failures are acceptable.

That's a really good point.

> Therefore, this commit changes "ext4_sb_breadahead_unmovable" to be
> non-blocking, removing "__GFP_DIRECT_RECLAIM" from the gfp mask in the
> "grow_dev_page" function if caller is ext4_sb_breadahead_unmovable to
> alleviate memory-related blocking issues.

Uh, not like this though.  Fix the gfp flags in the callers instead of
working this new "bool" flag through the buffer head layers.

