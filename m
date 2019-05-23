Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60CCC28606
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfEWShQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 14:37:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbfEWShQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 14:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mcI32xfmsEoQcujsoa3t+R8aU7MbjBpf8zoUWNfm5Mc=; b=WTfyIvoKVJm2DtUE/xPqWyYm+
        Z0YNQ6XiR2MOOAu+0LvMWrNrpmIaQYlAXhcb1EkVK0yf4yZmSN3JFep+4miWgbPzPJyVVR1w1Ox3h
        auWVTq8Zue8S7pfTCV0sfCU3vS0Qj5jPsbsPCGHr3NmFY5ZATleXTeHZWt4MyNOdf8vSBkIPYxJLK
        wO6b+VxTYrkEOI2zTm0LvCjqyMZBGtB81IhsgJZT/Auj/8FA/F7FPWMtVr+s7sYDSF08ckTEKytJq
        +gsKFxg7ihVs8pvvq5JBdorV8+zoiycyDywe9Jjg40fmAAS2NrzkIVDXt2RQY16w8LqMQvAGnDAng
        4QH435N1Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTsaX-0005kv-P8; Thu, 23 May 2019 18:37:13 +0000
Date:   Thu, 23 May 2019 11:37:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190523183713.GA14517@bombadil.infradead.org>
References: <20190523174349.GA10939@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523174349.GA10939@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 01:43:49PM -0400, Johannes Weiner wrote:
> I noticed that recent upstream kernels don't account the xarray nodes
> of the page cache to the allocating cgroup, like we used to do for the
> radix tree nodes.
> 
> This results in broken isolation for cgrouped apps, allowing them to
> escape their containment and harm other cgroups and the system with an
> excessive build-up of nonresident information.
> 
> It also breaks thrashing/refault detection because the page cache
> lives in a different domain than the xarray nodes, and so the shadow
> shrinker can reclaim nonresident information way too early when there
> isn't much cache in the root cgroup.
>
> I'm not quite sure how to fix this, since the xarray code doesn't seem
> to have per-tree gfp flags anymore like the radix tree did. We cannot
> add SLAB_ACCOUNT to the radix_tree_node_cachep slab cache. And the
> xarray api doesn't seem to really support gfp flags, either (xas_nomem
> does, but the optimistic internal allocations have fixed gfp flags).

Would it be a problem to always add __GFP_ACCOUNT to the fixed flags?
I don't really understand cgroups.
