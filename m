Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C47D2C00DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 08:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgKWHsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 02:48:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:48750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgKWHsH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:48:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606117686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RLanaZ3gdZrUteNju7bn/RRU6/80UHAv7PtZAR9FPJ4=;
        b=gaTq90nMzNoR1FE66WTd8Ne8c6vy7QD+gg4sRQA/e/SNnVhXjseBBt3BN5OehN1NN8Qfn/
        JJBACR5wqMJkn4kEJONCuIm6WyBzkYbYIDqs6oz8IopEmVjXAGcK1xOuGqvTiHuDj3Uai7
        cq5E3rb3xQtdgqx80bF+NsBNR35gLjM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37E63ABCE;
        Mon, 23 Nov 2020 07:48:06 +0000 (UTC)
Date:   Mon, 23 Nov 2020 08:48:04 +0100
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v5 13/21] mm/hugetlb: Use PG_slab to
 indicate split pmd
Message-ID: <20201123074804.GC27488@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-14-songmuchun@bytedance.com>
 <20201120081638.GD3200@dhcp22.suse.cz>
 <CAMZfGtX3DUJggAzz_06Z2atHPknkCir6a49a983TsWOHt5ZQUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtX3DUJggAzz_06Z2atHPknkCir6a49a983TsWOHt5ZQUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 17:30:27, Muchun Song wrote:
> On Fri, Nov 20, 2020 at 4:16 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 20-11-20 14:43:17, Muchun Song wrote:
> > > When we allocate hugetlb page from buddy, we may need split huge pmd
> > > to pte. When we free the hugetlb page, we can merge pte to pmd. So
> > > we need to distinguish whether the previous pmd has been split. The
> > > page table is not allocated from slab. So we can reuse the PG_slab
> > > to indicate that the pmd has been split.
> >
> > PageSlab is used outside of the slab allocator proper and that code
> > might get confused by this AFAICS.
> 
> I got your concerns. Maybe we can use PG_private instead of the
> PG_slab.

Reusing a page flag arbitrarily is not that easy. Hugetlb pages have a
lot of spare room in struct page so I would rather use something else.
-- 
Michal Hocko
SUSE Labs
