Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F18A687F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 14:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfICMWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 08:22:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICMWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ccUGFVNxssVWDcbI4ftnmg58MbgKoeWD8Ifd/JsATGA=; b=sdAJgqyOjMVv5fGaTpFicA5RP
        0MALv5u8khHy2K9Yl7P37X5h9KAHJlerdtdvJhnb3lJKI4pzP9dQt487I46HmBIrgC7njktl3YgWa
        SQWOLRQhasxNetbiJq1YJk4ow8C0kTd+vCWMFmUZ6CEBLYUz/expOYSTwdf+ImbTf9OT3sMVRk3t6
        djywTV4fdBXWnWMXlOtU+Cat+AE2NfVI1wgF9MBF2jwWESybVK2yGLv3CBrmVVHgms+SvUPg8M7I3
        iEbvurEHnm0jQ2rV1vxDYUqKxI+1SX8YNQGuHQUesSirCQB4QGmdBwrzX3+BvYyxkIGXP6l3GDVH7
        QA3EPd7bg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i57p2-0006Fn-RW; Tue, 03 Sep 2019 12:22:08 +0000
Date:   Tue, 3 Sep 2019 05:22:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
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
Message-ID: <20190903122208.GE29434@bombadil.infradead.org>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-3-william.kucharski@oracle.com>
 <20190903121424.GT14028@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903121424.GT14028@dhcp22.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:14:24PM +0200, Michal Hocko wrote:
> On Mon 02-09-19 03:23:41, William Kucharski wrote:
> > Add filemap_huge_fault() to attempt to satisfy page
> > faults on memory-mapped read-only text pages using THP when possible.
> 
> This deserves much more description of how the thing is implemented and
> expected to work. For one thing it is not really clear to me why you
> need CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP at all. You need a support
> from the filesystem anyway. So who is going to enable/disable this
> config?

There are definitely situations in which enabling this code will crash
the kernel.  But we want to get filesystems to a point where they can
start working on their support for large pages.  So our workaround is
to try to get the core pieces merged under a CONFIG_I_KNOW_WHAT_IM_DOING
flag and let people play with it.  Then continue to work on the core
to eliminate those places that are broken.

> I cannot really comment on fs specific parts but filemap_huge_fault
> sounds convoluted so much I cannot wrap my head around it. One thing
> stand out though. The generic filemap_huge_fault depends on ->readpage
> doing the right thing which sounds quite questionable to me. If nothing
> else  I would expect ->readpages to do the job.

Ah, that's because you're not a filesystem person ;-)  ->readpages is
really ->readahead.  It's a crappy interface and should be completely
redesigned.

Thanks for looking!
