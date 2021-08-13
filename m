Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE013EBC4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhHMS6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 14:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhHMS6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:58:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBF9C061756;
        Fri, 13 Aug 2021 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n0UYFCDfn/6EPWQxCxZcMRZGDBC1ig7t4FOClsfmIzs=; b=rW+90qbnrmWgb2k22pBJY1LrTl
        jzfGsbj5b5h/mRwDC/MoMZR4VlwW/j4l/xA93697kYfOtilnQbg1A8oCNMl+DwNUoE+f2S8ilfDTM
        c+4Vf9+pKxgClznbZg+rZbIkuzaSiE1umQI9mL4cSmVXdQCtDCkni9eJ+DPUBDqa4nq73fmFfPMM4
        n3TzbOD58Env3CuCXuPttnqaJwk9CfAtEtCz5/sT7Q1FIkfQh7LanDbrgSqLd1n7cGzkdDXNxtE/4
        fqZmvsDdp05jgrn3NawXLYWDrECWlHpXwuIJsGA8FZi9srrakhVtLo80NVIr1ZytvbJn2H6LdH3cJ
        3sNjNXHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEcMG-00Fz7Y-L1; Fri, 13 Aug 2021 18:56:51 +0000
Date:   Fri, 13 Aug 2021 19:56:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 035/138] mm/memcg: Use the node id in
 mem_cgroup_update_tree()
Message-ID: <YRbAbHraZjY1dwSG@casper.infradead.org>
References: <20210715033704.692967-36-willy@infradead.org>
 <20210715033704.692967-1-willy@infradead.org>
 <1809568.1628626012@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1809568.1628626012@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 09:06:52PM +0100, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > By using the node id in mem_cgroup_update_tree(), we can delete
> > soft_limit_tree_from_page() and mem_cgroup_page_nodeinfo().  Saves 42
> > bytes of kernel text on my config.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: David Howells <dhowells@redhat.com>
> 
> Though I wonder if:
> 
> > -		mz = mem_cgroup_page_nodeinfo(memcg, page);
> > +		mz = memcg->nodeinfo[nid];
> 
> should still have some sort of wrapper function.

I was asked to remove the wrapper function as it didn't provide enough
utility to warrant the indirection.
