Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2831BF5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 17:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhBOQbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 11:31:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:55964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhBOQ3D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:29:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613406486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Q+3IiJjmuWzfa/qecjdtsb7dEeDToXeQr2Gb7tp0C4=;
        b=Ypy5+9fpmsn7EJqcuGyF11X0OJre82so/tKaqZ3QiXv+AfSk0jDw2JJ2hxBc/OGI9Coard
        pPqxkacy6cwLK5R3wslEMud4Mb1p0e+/hSf54vq4AFwqiGPWVLIhpXH2wPLS1jMEiqAhe1
        mUKhP3gj5Jm2H60Bf/nDk5e9tkHtpTc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F4B6AE71;
        Mon, 15 Feb 2021 16:28:05 +0000 (UTC)
Date:   Mon, 15 Feb 2021 17:27:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
Message-ID: <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
References: <20210208085013.89436-5-songmuchun@bytedance.com>
 <YCafit5ruRJ+SL8I@dhcp22.suse.cz>
 <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz>
 <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
 <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
 <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-02-21 23:36:49, Muchun Song wrote:
[...]
> > There shouldn't be any real reason why the memory allocation for
> > vmemmaps, or handling vmemmap in general, has to be done from within the
> > hugetlb lock and therefore requiring a non-sleeping semantic. All that
> > can be deferred to a more relaxed context. If you want to make a
> 
> Yeah, you are right. We can put the freeing hugetlb routine to a
> workqueue. Just like I do in the previous version (before v13) patch.
> I will pick up these patches.

I haven't seen your v13 and I will unlikely have time to revisit that
version. I just wanted to point out that the actual allocation doesn't
have to happen from under the spinlock. There are multiple ways to go
around that. Dropping the lock would be one of them. Preallocation
before the spin lock is taken is another. WQ is certainly an option but
I would take it as the last resort when other paths are not feasible.

-- 
Michal Hocko
SUSE Labs
