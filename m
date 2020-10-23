Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8EA297128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750417AbgJWOQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750414AbgJWOQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:16:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6EC0613CE;
        Fri, 23 Oct 2020 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GVPYMjFqChMjoGfaKLO2uGqLmrcgLH9W7OOdDABUMfg=; b=WDuQx2OmH186JLLCT/V49+cHuG
        mvx3za9SySicasNgXKx5tLAGyLzzjMdStqRY5+gjhxGKEuIITG+UZILbK9cBxat+a10uw+lowMHgU
        A4XPvkubtIHPHZyepjYJtQzcRv+/NgS84fDmbjT3ffVSakzeJL/2clY9r2Aw1R+GJNBloYvsS8VlH
        rS3VhA77U5Ki78fsi0dokXGR1DF0mXSHs1jeElg3ld72bwPIscdEHnUWgCc6qd//dojfah5sbnF4f
        FA32w4nZVYBUke2t5rabYYM/cRMBDRJV6qjDaaaWY1XXsyx96exYVzQxYNvAH/xg57vNzc1lLniXd
        zPwjKFvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVxrf-0000gL-Pn; Fri, 23 Oct 2020 14:16:19 +0000
Date:   Fri, 23 Oct 2020 15:16:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michel Lespinasse <walken@google.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Qian Cai <cai@lca.pw>, linux-xfs@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 04/65] mm: Extract might_alloc() debug check
Message-ID: <20201023141619.GC20115@casper.infradead.org>
References: <20201021163242.1458885-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-4-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023122216.2373294-4-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 23, 2020 at 02:21:15PM +0200, Daniel Vetter wrote:
> Note that unlike fs_reclaim_acquire/release gfpflags_allow_blocking
> does not consult the PF_MEMALLOC flags. But there is no flag
> equivalent for GFP_NOWAIT, hence this check can't go wrong due to
> memalloc_no*_save/restore contexts.

I have a patch series that adds memalloc_nowait_save/restore.

https://lore.kernel.org/linux-mm/20200625113122.7540-7-willy@infradead.org/
