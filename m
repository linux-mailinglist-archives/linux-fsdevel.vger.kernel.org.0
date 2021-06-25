Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03653B3E2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFYIH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 04:07:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59804 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhFYIH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:07:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 073A81FE4B;
        Fri, 25 Jun 2021 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624608337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zcKRugiQvtyy62Ukgu1W5M8aUXyIgtq7LR6SD9mke1g=;
        b=XtVADPq0THcmtBiqyCLp58Xj8c1uHH3YCFEiYP7MRwbd4BP++b68Cj95158F+4ZlVsuX8L
        ETJoDakF1T7ntRNQrNIs08+qqanBR6SleRr7CTXpExPvUV88U7IDJh704Khsw+G5pJOV10
        JnJxNb+Gcx5LlcnV0uB97EbjEb5LD+Q=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C0CA2A3BEB;
        Fri, 25 Jun 2021 08:05:36 +0000 (UTC)
Date:   Fri, 25 Jun 2021 10:05:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v2 12/46] mm/memcg: Use the node id in
 mem_cgroup_update_tree()
Message-ID: <YNWOT2iAyo6xtR17@dhcp22.suse.cz>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-13-willy@infradead.org>
 <YNLs+CXPpULk8Y/3@infradead.org>
 <YNSwqfX1EwJccIeu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSwqfX1EwJccIeu@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-06-21 17:19:53, Matthew Wilcox wrote:
> On Wed, Jun 23, 2021 at 10:12:40AM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 22, 2021 at 01:15:17PM +0100, Matthew Wilcox (Oracle) wrote:
> > >  static struct mem_cgroup_per_node *
> > > -mem_cgroup_page_nodeinfo(struct mem_cgroup *memcg, struct page *page)
> > > +mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
> > >  {
> > > -	int nid = page_to_nid(page);
> > > -
> > >  	return memcg->nodeinfo[nid];
> > >  }
> > 
> > I'd just kill this function entirely and open code it into the only
> > caller
> 
> Done.

This makes sense.

> > > -	mctz = soft_limit_tree_from_page(page);
> > > +	mctz = soft_limit_tree_node(nid);
> > 
> > And while were at it, soft_limit_tree_node seems like a completely
> > pointless helper that does nothing but obsfucating the code.  While
> > you touch this area it might be worth to spin another patch to just
> > remove it as well.

Yeah, the whole soft limit reclaim code is kinda pain to even look at.
Opencoding those two will certainly not make it worse so fine with me.

> I'm scared that if I touch this file too much, people will start to
> think I know something about memcgs.  Happy to add it on; cc'ing
> maintainers.

get_maintainers will surely notice ;)

-- 
Michal Hocko
SUSE Labs
