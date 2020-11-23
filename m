Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52DC2C081B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 14:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbgKWMpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 07:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbgKWMps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:45:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35831C0613CF;
        Mon, 23 Nov 2020 04:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D/+uQXuYCHVJTryMNhtIQ0wirxLovQ10MM/7dftfXjA=; b=eeEoYa3psy1tQ0tTz+3MV500iq
        llvX2Sq8XRxLgLc4WkoFbfknD5IuMj5jxeQbAoExJ8GueJ5c7jbEdBYzy4ZAv5TgoNvzjoYcaAJE2
        NY3ZUBdJMTt+QbgdfbWC0Blm/oZq+tJsp7r6NZhWe6bK11IlKbXjWJCKokcbLb6f0r0ZWuw98vK33
        /NgveDC9KrZI+yM1PMYnsRCLpwGDyj5/6DHqZ7Skbu8j1mhFfbLHoFlwy5JPoK7PbBKu1/LoDzr5h
        M35LHR3GTV8EJpVz41HDlLhuiX/y/RVJPHyPje9sA5X1J9Nwv4d+N89FUyEUsROJ6Ktf+W7q8/u/m
        6jp0E+bQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khBDV-0000hM-8q; Mon, 23 Nov 2020 12:45:13 +0000
Date:   Mon, 23 Nov 2020 12:45:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v5 00/21] Free some vmemmap pages of
 hugetlb page
Message-ID: <20201123124513.GI4327@casper.infradead.org>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz>
 <CAMZfGtWJXni21J=Yn55gksKy9KZnDScCjKmMasNz5XUwx3OcKw@mail.gmail.com>
 <20201120131129.GO3200@dhcp22.suse.cz>
 <CAMZfGtWNDJWWTtpUDtngtgNiOoSd6sJpdAB6MnJW8KH0gePfYA@mail.gmail.com>
 <20201123074046.GB27488@dhcp22.suse.cz>
 <CAMZfGtV9WBu0OVi0fw4ab=t4zzY-uVn3amsa5ZHQhZBy88exFw@mail.gmail.com>
 <20201123094344.GG27488@dhcp22.suse.cz>
 <CAMZfGtUjsAKuQ_2NijKGPZYX7OBO_himtBDMKNkYb_0_o5CJGA@mail.gmail.com>
 <20201123104258.GJ27488@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123104258.GJ27488@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 11:42:58AM +0100, Michal Hocko wrote:
> On Mon 23-11-20 18:36:33, Muchun Song wrote:
> > > No I really mean that pfn_to_page will give you a struct page pointer
> > > from pages which you release from the vmemmap page tables. Those pages
> > > might get reused as soon sa they are freed to the page allocator.
> > 
> > We will remap vmemmap pages 2-7 (virtual addresses) to page
> > frame 1. And then we free page frame 2-7 to the buddy allocator.
> 
> And this doesn't really happen in an atomic fashion from the pfn walker
> POV, right? So it is very well possible that 
> 
> struct page *page = pfn_to_page();
> // remapping happens here
> // page content is no longer valid because its backing memory can be
> // reused for whatever purpose.

pfn_to_page() returns you a virtual address.  That virtual address
remains a valid pointer to exactly the same contents, it's just that
the page tables change to point to a different struct page which has
the same compound_head().
