Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75A06DA1BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 21:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbjDFTmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237708AbjDFTmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:42:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90984A253;
        Thu,  6 Apr 2023 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tmB9ef+i/tR2RuBXG/MztGedwZCTfoIM0/9hlfY16FE=; b=WS2ep4RielBa//Iw2N2zKAwJpB
        qCW3YjQTQSwAfLWsSVsoutV7+iFjBH0DhQtPhkG887UABmFOFnrdWoBFNHbNrBDGCbea+U+ZLElHR
        jpnGTSqsWJWh0+w3U9mnzIHezeB6zdA0kAhtzl4zo5p3DWPnrqay+5ChonJviuxlPMDAQG8hMWorV
        2CC5n6nWzUM6tnRcyPe/cG3Kv4Sm0Ab2RHPfymfryGeBemgO975S3yOvUByubbHw2gtLGkrDa7AmR
        Wsm44B7yKULXBY79o00EeBYucQQJa/sJzME5G+YJ/eYZV9hsFkGFwuEa6k6mHoenQ1IYFk4Rdb8AG
        xKOLOPiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkVUg-0006hi-MQ; Thu, 06 Apr 2023 19:42:02 +0000
Date:   Thu, 6 Apr 2023 20:42:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 2/2] mm: vmscan: refactor reclaim_state helpers
Message-ID: <ZC8giqopXVj/KFIL@casper.infradead.org>
References: <20230405185427.1246289-1-yosryahmed@google.com>
 <20230405185427.1246289-3-yosryahmed@google.com>
 <7ce03e4323b95c1e8fd3faed32c9b285162fe5a8.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce03e4323b95c1e8fd3faed32c9b285162fe5a8.camel@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 10:31:53AM -0700, Tim Chen wrote:
> On Wed, 2023-04-05 at 18:54 +0000, Yosry Ahmed wrote:
> > +	 * For all of these cases, we have no way of finding out whether these
> > +	 * pages were related to the memcg under reclaim. For example, a freed
> > +	 * slab page could have had only a single object charged to the memcg
> 
> Minor nits:
> s/could have had/could have

No ... "could have had" is correct.  I'm a native English speaker, so I
have no idea what the rule here is, but I can ask my linguist wife later
if you want to know ;-)

Maybe it's something like this:
https://www.englishgrammar.org/have-had-and-had-had/

