Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9973B1581
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWIPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFWIPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:15:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622CBC061574;
        Wed, 23 Jun 2021 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MiB3zDfNv10kGNhwlVcglsJXNkF5Cte0DqzDu9o1lWg=; b=k89hJxRVtVmQCl2cF86fRzSzLf
        hP0kR4H6lEpYEd9+f+WHyE8k/Zqc6veYgSpnX57mWfgrRrrMBumOAqTDRMXZf4kjpm8qzGt/WfdZt
        ljII0gqzuFmwvf+q0FxhxqFthmh3reaFN7wmibROejgPbqrwKySMa7YNCSCcPNLMGG0myE3q/HIBo
        POXCsJ11IH3PdGr/P+a0S0VFUIGtFmTGSiayxaxzz15JVQ/XrAxPqF50cySxs/+Z9IdoB4Yr6RhGZ
        LRzMAk6fWBJN2hQ+OLbNEe2K5mIYDyJUAI74wZRDLmD591pzpeMTUOSzEABK1LbQXjn3T+iH9ucLJ
        Ft6kE5fA==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvy01-00FCEY-Nu; Wed, 23 Jun 2021 08:12:52 +0000
Date:   Wed, 23 Jun 2021 10:12:40 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/46] mm/memcg: Use the node id in
 mem_cgroup_update_tree()
Message-ID: <YNLs+CXPpULk8Y/3@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-13-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:17PM +0100, Matthew Wilcox (Oracle) wrote:
>  static struct mem_cgroup_per_node *
> -mem_cgroup_page_nodeinfo(struct mem_cgroup *memcg, struct page *page)
> +mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
>  {
> -	int nid = page_to_nid(page);
> -
>  	return memcg->nodeinfo[nid];
>  }

I'd just kill this function entirely and open code it into the only
caller

> -	mctz = soft_limit_tree_from_page(page);
> +	mctz = soft_limit_tree_node(nid);

And while were at it, soft_limit_tree_node seems like a completely
pointless helper that does nothing but obsfucating the code.  While
you touch this area it might be worth to spin another patch to just
remove it as well.
