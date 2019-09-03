Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C347A68F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 14:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfICMvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 08:51:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbfICMvw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:51:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1AB5B07D;
        Tue,  3 Sep 2019 12:51:50 +0000 (UTC)
Date:   Tue, 3 Sep 2019 14:51:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH v5 2/2] mm,thp: Add experimental config option
 RO_EXEC_FILEMAP_HUGE_FAULT_THP
Message-ID: <20190903125150.GW14028@dhcp22.suse.cz>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-3-william.kucharski@oracle.com>
 <20190903121424.GT14028@dhcp22.suse.cz>
 <20190903122208.GE29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903122208.GE29434@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-09-19 05:22:08, Matthew Wilcox wrote:
> On Tue, Sep 03, 2019 at 02:14:24PM +0200, Michal Hocko wrote:
> > On Mon 02-09-19 03:23:41, William Kucharski wrote:
> > > Add filemap_huge_fault() to attempt to satisfy page
> > > faults on memory-mapped read-only text pages using THP when possible.
> > 
> > This deserves much more description of how the thing is implemented and
> > expected to work. For one thing it is not really clear to me why you
> > need CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP at all. You need a support
> > from the filesystem anyway. So who is going to enable/disable this
> > config?
> 
> There are definitely situations in which enabling this code will crash
> the kernel.  But we want to get filesystems to a point where they can
> start working on their support for large pages.  So our workaround is
> to try to get the core pieces merged under a CONFIG_I_KNOW_WHAT_IM_DOING
> flag and let people play with it.  Then continue to work on the core
> to eliminate those places that are broken.

I am not sure I understand. Each fs has to opt in to the feature
anyway. If it doesn't then there should be no risk of regression, right?
I do not expect any fs would rush an implementation in while not being
sure about the correctness. So how exactly does a config option help
here.
 
> > I cannot really comment on fs specific parts but filemap_huge_fault
> > sounds convoluted so much I cannot wrap my head around it. One thing
> > stand out though. The generic filemap_huge_fault depends on ->readpage
> > doing the right thing which sounds quite questionable to me. If nothing
> > else  I would expect ->readpages to do the job.
> 
> Ah, that's because you're not a filesystem person ;-)  ->readpages is
> really ->readahead.  It's a crappy interface and should be completely
> redesigned.

OK, the interface looked like the right fit for this purpose. Thanks for
clarifying.
-- 
Michal Hocko
SUSE Labs
