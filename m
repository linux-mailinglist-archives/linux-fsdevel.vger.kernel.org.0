Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10C3B33C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFXQWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 12:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFXQWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:22:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95693C061574;
        Thu, 24 Jun 2021 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uh3vgdb1Js3vfZajWdBPiGBpNjG65EW1C8MzQFof+dE=; b=Van2fFqSnECFap8RB8ZgiYbX+Q
        uuctjHg08u+iXh8IQ1nUK2WuqzaFljlIcQx+CpzzsGJ+/avEips/5xj2yJBLnzHggVDyaBK7UClw9
        etcwNowymIVh3YfkGgvi9rwDeai2s5jF3eeSIywYkQBqEMaL6sdX+D+jqHzpfuqlBaamkVO3FR9c9
        8vePVfTaFmVCz8fIBm6pQuAZjVilH3aMoQikqk8LHC4IlEpG4Vxxgbm2fjvDWskCj8ileSG/y0A5p
        UJ8dqfqpuNDy4Fzcn2IW5kfan49rAbR0OkmG6edAjIZuowt2I6nSKmu86Ld86d6qYKqeJ+5Cq4wsX
        U5pwjumw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwS53-00GlUG-S9; Thu, 24 Jun 2021 16:19:56 +0000
Date:   Thu, 24 Jun 2021 17:19:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v2 12/46] mm/memcg: Use the node id in
 mem_cgroup_update_tree()
Message-ID: <YNSwqfX1EwJccIeu@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-13-willy@infradead.org>
 <YNLs+CXPpULk8Y/3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLs+CXPpULk8Y/3@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:12:40AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:17PM +0100, Matthew Wilcox (Oracle) wrote:
> >  static struct mem_cgroup_per_node *
> > -mem_cgroup_page_nodeinfo(struct mem_cgroup *memcg, struct page *page)
> > +mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
> >  {
> > -	int nid = page_to_nid(page);
> > -
> >  	return memcg->nodeinfo[nid];
> >  }
> 
> I'd just kill this function entirely and open code it into the only
> caller

Done.

> > -	mctz = soft_limit_tree_from_page(page);
> > +	mctz = soft_limit_tree_node(nid);
> 
> And while were at it, soft_limit_tree_node seems like a completely
> pointless helper that does nothing but obsfucating the code.  While
> you touch this area it might be worth to spin another patch to just
> remove it as well.

I'm scared that if I touch this file too much, people will start to
think I know something about memcgs.  Happy to add it on; cc'ing
maintainers.
