Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D73336E23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 09:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhCKIqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 03:46:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhCKIqN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:46:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615452371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WufQ3n/kwHjfZtEAjPC6dKTzReIW3D11ZqXq64CI764=;
        b=NPZL6lossPXcyKWueKyjDu+enqVqiYJGJSYU6wRfI5nseEMa6INY3gr/s9kR5xnKCsZI/Y
        LxFsfDER3lI9iNKUuKGiJvtfBZDAvmidD5WBhiTFhmTuJ+IP+cE1P6iimwGLV7XK4WhEQe
        t9iu5Xy2dt09xbzS70zlQquMtYsSzwk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2BB0CAB8C;
        Thu, 11 Mar 2021 08:46:11 +0000 (UTC)
Date:   Thu, 11 Mar 2021 09:46:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [External] Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
Message-ID: <YEnY0qXuBGYW6LHA@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com>
 <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
 <CAMZfGtVjLOF27VMVJ5fF8CDJRpZ0t7fWpmMHB9D-ipMK6b=POg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVjLOF27VMVJ5fF8CDJRpZ0t7fWpmMHB9D-ipMK6b=POg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-03-21 12:26:32, Muchun Song wrote:
> On Wed, Mar 10, 2021 at 11:19 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 08-03-21 18:28:02, Muchun Song wrote:
[...]
> > > @@ -1771,8 +1813,12 @@ int dissolve_free_huge_page(struct page *page)
> > >               h->free_huge_pages--;
> > >               h->free_huge_pages_node[nid]--;
> > >               h->max_huge_pages--;
> > > -             update_and_free_page(h, head);
> > > -             rc = 0;
> > > +             rc = update_and_free_page(h, head);
> > > +             if (rc) {
> > > +                     h->surplus_huge_pages--;
> > > +                     h->surplus_huge_pages_node[nid]--;
> > > +                     h->max_huge_pages++;
> >
> > This is quite ugly and confusing. update_and_free_page is careful to do
> > the proper counters accounting and now you just override it partially.
> > Why cannot we rely on update_and_free_page do the right thing?
> 
> Dissolving path is special here. Since update_and_free_page failed,
> the number of surplus pages was incremented.  Surplus pages are
> the number of pages greater than max_huge_pages.  Since we are
> incrementing max_huge_pages, we should decrement (undo) the
> addition to surplus_huge_pages and surplus_huge_pages_node[nid].

Can we make dissolve_free_huge_page less special or tell
update_and_free_page to not account against dissolve_free_huge_page?
-- 
Michal Hocko
SUSE Labs
