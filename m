Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF96E1DE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDNIP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjDNIPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:15:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4ED7D83;
        Fri, 14 Apr 2023 01:15:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B20A219B9;
        Fri, 14 Apr 2023 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681460119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wnpYQ2ZfTwZ2ZAV4qraqjHueaXahHtXmI+0HNNBvkbA=;
        b=i5+0f/xelZd/5CNWzW8EFPbGnINdzmH9KpJPCXRtV258U3pnnwxI0Ojd6XA35ry3MYF053
        40aLkf5ThYFCgXSsjgdvWcMq6bzHVWqdzFEgNF9/CKsG8S1u89T/3aZ2akxuqK9jLQAvdz
        wqHG3GLL/oIQlLDE4B1N6aYs02BynjQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 166E1139FC;
        Fri, 14 Apr 2023 08:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CvQjA5cLOWSZYgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 14 Apr 2023 08:15:19 +0000
Date:   Fri, 14 Apr 2023 10:15:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 1/3] mm: vmscan: ignore non-LRU-based reclaim in memcg
 reclaim
Message-ID: <ZDkLkeTR0gYl5sv6@dhcp22.suse.cz>
References: <20230413104034.1086717-1-yosryahmed@google.com>
 <20230413104034.1086717-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413104034.1086717-2-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-04-23 10:40:32, Yosry Ahmed wrote:
> We keep track of different types of reclaimed pages through
> reclaim_state->reclaimed_slab, and we add them to the reported number
> of reclaimed pages.  For non-memcg reclaim, this makes sense. For memcg
> reclaim, we have no clue if those pages are charged to the memcg under
> reclaim.
> 
> Slab pages are shared by different memcgs, so a freed slab page may have
> only been partially charged to the memcg under reclaim.  The same goes for
> clean file pages from pruned inodes (on highmem systems) or xfs buffer
> pages, there is no simple way to currently link them to the memcg under
> reclaim.
> 
> Stop reporting those freed pages as reclaimed pages during memcg reclaim.
> This should make the return value of writing to memory.reclaim, and may
> help reduce unnecessary reclaim retries during memcg charging.  Writing to
> memory.reclaim on the root memcg is considered as cgroup_reclaim(), but
> for this case we want to include any freed pages, so use the
> global_reclaim() check instead of !cgroup_reclaim().
> 
> Generally, this should make the return value of
> try_to_free_mem_cgroup_pages() more accurate. In some limited cases (e.g.
> freed a slab page that was mostly charged to the memcg under reclaim),
> the return value of try_to_free_mem_cgroup_pages() can be underestimated,
> but this should be fine. The freed pages will be uncharged anyway, and we
> can charge the memcg the next time around as we usually do memcg reclaim
> in a retry loop.
> 
> Fixes: f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> instead of pages")
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
