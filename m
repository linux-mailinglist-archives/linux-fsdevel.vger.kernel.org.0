Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340E31E37B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 07:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgE0FJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 01:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgE0FJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 01:09:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772FCC061A0F;
        Tue, 26 May 2020 22:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gHdtexCQGQRaatxx6IEb1gGC16jgjrLxhKEQOJ39uAQ=; b=kvM2IesnbKbAxu4uRnJqOjHn1U
        OkIhbK/PCHpdiGv/c7IzpFly3ueziTlwNiOXh/Y+3tpsSWg3LMrjVQ+LMnF+zEUZNmqNw6Kl5OnQC
        AFM8ATOv9heC9Nl0TZzyzRn1Cnh4gYHIngAMbimQN3Y4I0cpXIb2U3+NLOERIWMSbne/KPx/P0eB1
        uR6Bp59hrw2Fe+P1qymKKKRIW6o6dnreDzWkemnh2tSCnLr4wc7/wD9Y8oXYIwiecGkPqEyWeNGTw
        3dV84ae9v7pa1kHq0cQMpqc716FshZpviUGRx8aObBmHV3UBnQO0sia9QJcT5SegOXvISsfpGPctQ
        ZVrM3Gvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdoJe-0000Ci-Ev; Wed, 27 May 2020 05:09:22 +0000
Date:   Tue, 26 May 2020 22:09:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200527050922.GB31860@infradead.org>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
 <20200512132521.GA28700@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <20200512133545.GA26535@infradead.org>
 <20200526142803.GA1061@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526142803.GA1061@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 10:28:03AM -0400, Dan Schatzberg wrote:
> Will do - I'll split out the lock-use refactor into a separate
> patch. Do you have particular concerns about re-using the existing
> spinlock? Its existing use is not contended so I didn't see any harm
> in extending its use. I'll add this justification to the commit
> message as well, but I'm tempted to leave the re-use as is instead of
> creating a new lock.

Please don't share a lock for entirely separate critical sections that
are used from different contexts.
