Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1847E2C09E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 14:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbgKWNNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 08:13:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:41246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388568AbgKWNNo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:13:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606137221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rv9w9/llZazFt1Z6bqz4fjM+bsJ8PYyhjd+2a7iwKww=;
        b=BovGW7DoOC8krOpDGxMAvISB+An1UZdqsVUv0y+mOwCm8gQma8GRfSmZfwYSeLpHtd4a0/
        tL9UdmdQTm1PU6J92WQP00NeFdV6eO8Y3Y0lZDPaeByUGaMvOUAdiycCP9E47AAgaodsRu
        q3uicdbuKCt6m7LZUTwpc+6v7wB2XDg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78EB1AC2E;
        Mon, 23 Nov 2020 13:13:41 +0000 (UTC)
Date:   Mon, 23 Nov 2020 14:13:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20201123131339.GO27488@dhcp22.suse.cz>
References: <20201120084202.GJ3200@dhcp22.suse.cz>
 <CAMZfGtWJXni21J=Yn55gksKy9KZnDScCjKmMasNz5XUwx3OcKw@mail.gmail.com>
 <20201120131129.GO3200@dhcp22.suse.cz>
 <CAMZfGtWNDJWWTtpUDtngtgNiOoSd6sJpdAB6MnJW8KH0gePfYA@mail.gmail.com>
 <20201123074046.GB27488@dhcp22.suse.cz>
 <CAMZfGtV9WBu0OVi0fw4ab=t4zzY-uVn3amsa5ZHQhZBy88exFw@mail.gmail.com>
 <20201123094344.GG27488@dhcp22.suse.cz>
 <CAMZfGtUjsAKuQ_2NijKGPZYX7OBO_himtBDMKNkYb_0_o5CJGA@mail.gmail.com>
 <20201123104258.GJ27488@dhcp22.suse.cz>
 <20201123124513.GI4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123124513.GI4327@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 23-11-20 12:45:13, Matthew Wilcox wrote:
> On Mon, Nov 23, 2020 at 11:42:58AM +0100, Michal Hocko wrote:
> > On Mon 23-11-20 18:36:33, Muchun Song wrote:
> > > > No I really mean that pfn_to_page will give you a struct page pointer
> > > > from pages which you release from the vmemmap page tables. Those pages
> > > > might get reused as soon sa they are freed to the page allocator.
> > > 
> > > We will remap vmemmap pages 2-7 (virtual addresses) to page
> > > frame 1. And then we free page frame 2-7 to the buddy allocator.
> > 
> > And this doesn't really happen in an atomic fashion from the pfn walker
> > POV, right? So it is very well possible that 
> > 
> > struct page *page = pfn_to_page();
> > // remapping happens here
> > // page content is no longer valid because its backing memory can be
> > // reused for whatever purpose.
> 
> pfn_to_page() returns you a virtual address.  That virtual address
> remains a valid pointer to exactly the same contents, it's just that
> the page tables change to point to a different struct page which has
> the same compound_head().

You are right. I have managed to completely confuse myself. Sorry about
the noise!

-- 
Michal Hocko
SUSE Labs
