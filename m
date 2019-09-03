Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C8A7372
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 21:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfICTPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 15:15:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfICTPb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:15:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 363C0AF10;
        Tue,  3 Sep 2019 19:15:30 +0000 (UTC)
Date:   Tue, 3 Sep 2019 21:15:28 +0200
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
Message-ID: <20190903191528.GC14028@dhcp22.suse.cz>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-3-william.kucharski@oracle.com>
 <20190903121424.GT14028@dhcp22.suse.cz>
 <20190903122208.GE29434@bombadil.infradead.org>
 <20190903125150.GW14028@dhcp22.suse.cz>
 <20190903151015.GF29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903151015.GF29434@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-09-19 08:10:15, Matthew Wilcox wrote:
> On Tue, Sep 03, 2019 at 02:51:50PM +0200, Michal Hocko wrote:
> > On Tue 03-09-19 05:22:08, Matthew Wilcox wrote:
> > > On Tue, Sep 03, 2019 at 02:14:24PM +0200, Michal Hocko wrote:
> > > > On Mon 02-09-19 03:23:41, William Kucharski wrote:
> > > > > Add filemap_huge_fault() to attempt to satisfy page
> > > > > faults on memory-mapped read-only text pages using THP when possible.
> > > > 
> > > > This deserves much more description of how the thing is implemented and
> > > > expected to work. For one thing it is not really clear to me why you
> > > > need CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP at all. You need a support
> > > > from the filesystem anyway. So who is going to enable/disable this
> > > > config?
> > > 
> > > There are definitely situations in which enabling this code will crash
> > > the kernel.  But we want to get filesystems to a point where they can
> > > start working on their support for large pages.  So our workaround is
> > > to try to get the core pieces merged under a CONFIG_I_KNOW_WHAT_IM_DOING
> > > flag and let people play with it.  Then continue to work on the core
> > > to eliminate those places that are broken.
> > 
> > I am not sure I understand. Each fs has to opt in to the feature
> > anyway. If it doesn't then there should be no risk of regression, right?
> > I do not expect any fs would rush an implementation in while not being
> > sure about the correctness. So how exactly does a config option help
> > here.
> 
> Filesystems won't see large pages unless they've opted into them.
> But there's a huge amount of page-cache work that needs to get done
> before this can be enabled by default.  For example, truncate() won't
> work properly.
> 
> Rather than try to do all the page cache work upfront, then wait for the
> filesystems to catch up, we want to get some basics merged.  Since we've
> been talking about this for so long without any movement in the kernel
> towards actual support, this felt like a good way to go.
> 
> We could, of course, develop the entire thing out of tree, but that's
> likely to lead to pain and anguish.

Then I would suggest mentioning all this in the changelog so that the
overall intention is clear. It is also up to you fs developers to find a
consensus on how to move forward. I have brought that up mostly because
I really hate seeing new config options added due to shortage of
confidence in the code. That really smells like working around standard
code quality inclusion process.

-- 
Michal Hocko
SUSE Labs
