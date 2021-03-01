Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B823292F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 21:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbhCAU4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 15:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbhCAUxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:53:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E31C06178C;
        Mon,  1 Mar 2021 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uqB/lbaaLgQzJnd/xNlRk3JHGcmAZuZF6sI1GH3WF0w=; b=Fjg+GFsvcVHtRUxJaKVFf5Crd0
        fOj02pIWZmeNpSxqTFFHtAAg5r3nkVd5fPhTabrYvbKqVHcsOeuRXPw0PxGOq0IB81T+IaC79sSUb
        8wHIHxEQKGcPBaDiq3ir7nDb7RScUUsqgk1+y//Xok4gIDNynygBIR86Yp9drTbAPQlfeLiUEtK3F
        rcJfIqpNLbfboVsiXqQ3lrjDLel3NCaU5WoqAFUmRO6ihe8PM6+bZd7BbdymMY8Bu66hsucJ+Gb2O
        aopqonQv+7OYfn6gLEiEQVM0zMpMeK3lMABpftwvV8sI7Z00mlkmE52enFwX0cMZwF+wGe6LiYdJW
        gVfiMUQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGpXO-00GDLD-QR; Mon, 01 Mar 2021 20:53:07 +0000
Date:   Mon, 1 Mar 2021 20:53:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 01/25] mm: Introduce struct folio
Message-ID: <20210301205306.GU2723601@casper.infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-2-willy@infradead.org>
 <68723D50-AFD1-4F25-8F10-81EC11045BE5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68723D50-AFD1-4F25-8F10-81EC11045BE5@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 03:26:11PM -0500, Zi Yan wrote:
> > +static inline struct folio *next_folio(struct folio *folio)
> > +{
> > +	return folio + folio_nr_pages(folio);
> 
> Are you planning to make hugetlb use folio too?

Eventually, probably.  It's not my focus.

> If yes, this might not work if we have CONFIG_SPARSEMEM && !CONFIG_SPARSEMEM_VMEMMAP
> with a hugetlb folio > MAX_ORDER, because struct page might not be virtually contiguous.
> See the experiment I did in [1].
> 
> [1] https://lore.kernel.org/linux-mm/16F7C58B-4D79-41C5-9B64-A1A1628F4AF2@nvidia.com/

I thought we were going to forbid that configuration?  ie no pages
larger than MAX_ORDER with (SPARSEMEM && !SPARSEMEM_VMEMMAP)

https://lore.kernel.org/linux-mm/312AECBD-CA6D-4E93-A6C1-1DF87BABD92D@nvidia.com/

is somewhere else we were discussing this.

