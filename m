Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29C231C748
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 09:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPIWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 03:22:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:45514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhBPIVv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:21:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613463662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yxFwziSyZyOqU27QatYvWYrbroR4UnAqOg89qO7rMuM=;
        b=eYhfed6NW++hDwqLUPTACF6UbC/shda+lS/QxJlotWM16Wipv6jy5WmRh0cQc/dRvyIxn1
        ej82DijW+bwiWE8xN5YuvI0cL/vh4pQBm5opBLNybn59CV64dhCAs6bX7KzaRJl7Wzoetb
        brEJ3VJWFdkxM425lJ/yR6eCq3l9z6o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D7B1AD29;
        Tue, 16 Feb 2021 08:21:02 +0000 (UTC)
Date:   Tue, 16 Feb 2021 09:21:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
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
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
Message-ID: <YCuAbWJC751ROfTS@dhcp22.suse.cz>
References: <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
 <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
 <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
 <CAMZfGtW6n_YUbZOPFbivzn-HP4Q2yi0DrUoQ3JAjSYy5m17VWw@mail.gmail.com>
 <YCrFY4ODu/O9KSND@dhcp22.suse.cz>
 <4f8664fb-0d65-b7d6-39d6-2ce5fc86623a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8664fb-0d65-b7d6-39d6-2ce5fc86623a@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-02-21 09:13:09, David Hildenbrand wrote:
> On 15.02.21 20:02, Michal Hocko wrote:
> > Would it be feasible to reused parts of the freed page in
> > the worst case?
> 
> As already discussed, this is only possible when the huge page does not
> reside on ZONE_MOVABLE/CMA.

Right. But usually this is not the case so it would be at least
something.

> In addition, we can no longer form a huge page at that memory location ever.

Yes, that's why I am saying in the worst case. E.g. when dissolving is
really necessary like in hwpoison case.

Maybe we are really far from needing something like that. I just wanted
to mention this option and I was not aware this has been discussed
previously.
-- 
Michal Hocko
SUSE Labs
