Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB380468870
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Dec 2021 00:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhLEACe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 19:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhLDX5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:57:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615C2C061751;
        Sat,  4 Dec 2021 15:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lSqkhUtVhnqxYJBPgDIzRRfQncz5CKDcUotTy5RlLGA=; b=UfzUu3/z/m7s3v2ZPGOuzzWiP3
        3Gi9RX7+8QkRaQNOOXU77aZkmc4dTmMdFOd18VYhvZSA9aphHmIYGrF+Rz7A6PF7FuZYvWhaIOBhy
        oFAWcf/HKVy36QHwogU5eDvDifiIB//rAtG5qWblJxQpZhr58sT63yNLvTKgnVB4DhkTDhNgxe8g6
        wr3BMg244QAsGQztOte+qyts43Aw5XWWsJA+G5fD1wrCWv5u/J5ZIq2WXUO1D2pzxiGQnwPppz6Ae
        7gNKoA6oAxooiEjWD+Nfy9BLjLHqKr/8O0SDSJU2EdaI5Fb01DvD2UUeJF5YBEG79kz3JD/wrs8D3
        +ryIhIFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mteqM-00F8FV-GZ; Sat, 04 Dec 2021 23:53:26 +0000
Date:   Sat, 4 Dec 2021 23:53:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Colin Cross <ccross@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: split out anon_vma declarations to separate header
Message-ID: <Yav/dvIWxuZ59+d6@casper.infradead.org>
References: <20211204174417.1025328-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204174417.1025328-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 04, 2021 at 06:42:17PM +0100, Arnd Bergmann wrote:
> This should not really be part of linux/mm_types.h in the first
> place, as that header is meant to only contain structure defintions
> and need a minimum set of indirect includes itself. While the
> header clearly includes more than it should at this point, let's
> not make it worse by including string.h as well, which would
> pull in the expensive (compile-speed wise) fortify-string logic.
> 
> Move the new functions to a separate header that is only included
> where necessary to avoid bloating linux/mm_types.h further.

We already have an mm_inline.h.  Why do we need a new header file?
