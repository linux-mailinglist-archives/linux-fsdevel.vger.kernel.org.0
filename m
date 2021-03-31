Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD3134F63C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 03:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhCaBbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 21:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCaBaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:30:52 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A612C061762
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 18:30:52 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i81so18452481oif.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 18:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=KQ4UhoRuOYIePIQ52r8+aVrhFWUe79SfbbimcSIL+Nc=;
        b=lQx2TYvo3z4/Y4K/aqMjcHcRs6Wma0Bb6oKkFH9AIxVw34/QBkIzCjYOs0bfDw9izS
         j1yelFrahfno18c3R6rrJk6pF/aghxdTt32ikGRWmoIeGuL1FnH3bw88C0HBHj3J2wvI
         TgIVA8/qZhNr9ivGIfA0FP4+jByBTuc+2bJFmHQXY3YO5ZJ3u4Lcob2X4H0T/y+BqOgg
         F7pFfydHBC4to4A5RcWZYzWCIelEUmAD45atU/J84syxq3vRvFaUZ4ydNwKEJMWxYA8M
         T9fIxBg84kK59o8yCDeArwA9HIijk+I9//OcqphHVpWlrHFh4StWLqFZScfmE86NpUVB
         +rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=KQ4UhoRuOYIePIQ52r8+aVrhFWUe79SfbbimcSIL+Nc=;
        b=EHOrnFJvnJshDb3kKt27Y9xRzGZLhRbTHDL60kx1ctX1Plk13/epvBvDkRu0axLGb4
         oFDY9d2u8xiHQpLkh4rUX5Eiqer7J80wnKKi/emFlDBkDMvH8SpRHlDxCpp9JGeL7Iks
         A/dpVht1BlFbHCnSryhZ7uhuvbyiZpX+MenUFbWBLQfuO2JNjm3V4BeQFSdmuxsa2d8z
         ZkvQyghK+9JuDUwzTiw5E8APV8ZIQdOx8ZbKo9XJjSvI6vg+gWoMjkHP1hp+tqmG1wXW
         HxkOGAO7Q2/ftoRwR7JIMj9t/dI0yre1gQaw1Gxd0TeR+v/XlkxvZKd/tEMcSqP2VRo4
         vZag==
X-Gm-Message-State: AOAM5337X9ydEq2ttC32xwlW0NXRmQdPmDPHLP1hwGcb40hQyuEAShBP
        EFab3/6QZFuQLvHKFZCK71U9zQ==
X-Google-Smtp-Source: ABdhPJzgATn5d/xGPP8lN0hUfrUaP2MzX9O5uWPP80RgZEGYBVqB4ER4X7Jo2RE+R3sVH8Ekz00hSQ==
X-Received: by 2002:a05:6808:5cb:: with SMTP id d11mr502740oij.169.1617154251409;
        Tue, 30 Mar 2021 18:30:51 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g11sm141653ots.34.2021.03.30.18.30.50
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 30 Mar 2021 18:30:51 -0700 (PDT)
Date:   Tue, 30 Mar 2021 18:30:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: BUG_ON(!mapping_empty(&inode->i_data))
Message-ID: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Running my usual tmpfs kernel builds swapping load, on Sunday's rc4-mm1
mmotm (I never got to try rc3-mm1 but presume it behaved the same way),
I hit clear_inode()'s BUG_ON(!mapping_empty(&inode->i_data)); on two
machines, within an hour or few, repeatably though not to order.

The stack backtrace has always been clear_inode < ext4_clear_inode <
ext4_evict_inode < evict < dispose_list < prune_icache_sb <
super_cache_scan < do_shrink_slab < shrink_slab_memcg < shrink_slab <
shrink_node_memgs < shrink_node < balance_pgdat < kswapd.

ext4 is the disk filesystem I read the source to build from, and also
the filesystem I use on a loop device on a tmpfs file: I have not tried
with other filesystems, nor checked whether perhaps it happens always on
the loop one or always on the disk one.  I have not seen it happen with
tmpfs - probably because its inodes cannot be evicted by the shrinker
anyway; I have not seen it happen when "rm -rf" evicts ext4 or tmpfs
inodes (but suspect that may be down to timing, or less pressure).
I doubt it's a matter of filesystem: think it's an XArray thing.

Whenever I've looked at the XArray nodes involved, the root node
(shift 6) contained one or three (adjacent) pointers to empty shift
0 nodes, which each had offset and parent and array correctly set.
Is there some way in which empty nodes can get left behind, and so
fail eviction's mapping_empty() check?

I did wonder whether some might get left behind if xas_alloc() fails
(though probably the tree here is too shallow to show that).  Printks
showed that occasionally xas_alloc() did fail while testing (maybe at
memcg limit), but there was no correlation with the BUG_ONs.

I did wonder whether this is a long-standing issue, which your new
BUG_ON is the first to detect: so tried 5.12-rc5 clear_inode() with
a BUG_ON(!xa_empty(&inode->i_data.i_pages)) after its nrpages and
nrexceptional BUG_ONs.  The result there surprised me: I expected
it to behave the same way, but it hits that BUG_ON in a minute or
so, instead of an hour or so.  Was there a fix you made somewhere,
to avoid the BUG_ON(!mapping_empty) most of the time? but needs
more work. I looked around a little, but didn't find any.

I had hoped to work this out myself, and save us both some writing:
but better hand over to you, in the hope that you'll quickly guess
what's up, then I can try patches. I do like the no-nrexceptionals
series, but there's something still to be fixed.

Hugh
