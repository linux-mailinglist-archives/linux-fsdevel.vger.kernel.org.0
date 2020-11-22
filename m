Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A62BC85A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgKVTBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 14:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgKVTBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 14:01:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34539C0613CF;
        Sun, 22 Nov 2020 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fGB9UccTdY0+D9VrR+d9ZW2mq8OJlKvYmZDecnPFxFs=; b=AbOOghMsKGuO/MimYt9TzwXc4y
        D23Vjq5RKRH7z0hC2d0YiVo4+BtOyeafryfipLTaUSInSm0xQpwA+pupmeVKDRHWf2qAnx91ujj5B
        V7QZBceXHD6YFltefPvOlHokjWTpFNz/n3LHoCAprVzHCcL7m6ZoNEddAfsSYodQ6D+B3PUAnBO2e
        WAhzAxVjN8yWBek4xAdssdfNAhpIswRu7waHRguasAtXt8sp0DlYZmbpfCv67aOrd51KtCrCja35v
        RIdncxCIelYPqPGJ450JC3Zpnm3AO6Xoh7FCo5ikHh9guWBFbGvz7t79sGBVgSLe95XxBPlQlYOpG
        OL4wnXLg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kguag-0005a7-KD; Sun, 22 Nov 2020 19:00:02 +0000
Date:   Sun, 22 Nov 2020 19:00:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, osalvador@suse.de,
        song.bao.hua@hisilicon.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 21/21] mm/hugetlb: Disable freeing vmemmap if struct
 page size is not power of two
Message-ID: <20201122190002.GH4327@casper.infradead.org>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-22-songmuchun@bytedance.com>
 <20201120082552.GI3200@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120082552.GI3200@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:25:52AM +0100, Michal Hocko wrote:
> On Fri 20-11-20 14:43:25, Muchun Song wrote:
> > We only can free the unused vmemmap to the buddy system when the
> > size of struct page is a power of two.
> 
> Can we actually have !power_of_2 struct pages?

Yes.  On x86-64, if you don't enable MEMCG, it's 56 bytes.  On SPARC64,
if you do enable MEMCG, it's 72 bytes.  On 32-bit systems, it's
anything from 32-44 bytes, depending on MEMCG, WANT_PAGE_VIRTUAL and
LAST_CPUPID_NOT_IN_PAGE_FLAGS.

