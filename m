Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B097230412F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 15:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390955AbhAZO71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 09:59:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391635AbhAZO7J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:59:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FA2DAB9F;
        Tue, 26 Jan 2021 14:58:27 +0000 (UTC)
Date:   Tue, 26 Jan 2021 15:58:19 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, song.bao.hua@hisilicon.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 05/12] mm: hugetlb: allocate the vmemmap pages
 associated with each HugeTLB page
Message-ID: <20210126145819.GB16870@linux>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
 <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:36:21AM +0100, David Hildenbrand wrote:
> I think either keep it completely simple (only free vmemmap of hugetlb
> pages allocated early during boot - which is what's not sufficient for
> some use cases) or implement the full thing properly (meaning, solve
> most challenging issues to get the basics running).
> 
> I don't want to have some easy parts of complex features merged (e.g.,
> breaking other stuff as you indicate below), and later finding out "it's
> not that easy" again and being stuck with it forever.

Well, we could try to do an optimistic allocation, without tricky loopings.
If that fails, refuse to shrink the pool at that moment.

The user could always try to shrink it later via /proc/sys/vm/nr_hugepages
interface.

But I am just thinking out loud..

> > Of course, this means that e.g: memory-hotplug (hot-remove) will not fully work
> > when this in place, but well.
> 
> Can you elaborate? Are we're talking about having hugepages in
> ZONE_MOVABLE that are not migratable (and/or dissolvable) anymore? Than
> a clear NACK from my side.

Pretty much, yeah. 


-- 
Oscar Salvador
SUSE L3
