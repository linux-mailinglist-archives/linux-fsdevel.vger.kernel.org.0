Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B095366647
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 09:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhDUHeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 03:34:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234038AbhDUHea (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:34:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D932AAFE6;
        Wed, 21 Apr 2021 07:33:56 +0000 (UTC)
Date:   Wed, 21 Apr 2021 09:33:52 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v20 8/9] mm: memory_hotplug: disable
 memmap_on_memory when hugetlb_free_vmemmap enabled
Message-ID: <20210421073346.GA22456@linux>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-9-songmuchun@bytedance.com>
 <YH6udU5rKmDcx5dY@localhost.localdomain>
 <CAMZfGtXmDhkCWateAR0q_EgRPDmGh_=D-6UuhMd+Si6=TDvghQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXmDhkCWateAR0q_EgRPDmGh_=D-6UuhMd+Si6=TDvghQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:41:24AM +0800, Muchun Song wrote:
> > Documentation/admin-guide/kernel-parameters.txt already provides an
> > explanation on memory_hotplug.memmap_on_memory parameter that states
> > that the feature cannot be enabled when using hugetlb-vmemmap
> > optimization.
> >
> > Users can always check whether the feature is enabled via
> > /sys/modules/memory_hotplug/parameters/memmap_on_memory.

Heh, I realized this is not completely true.
Users can check whether the feature is __enabled__ by checking the sys fs,
but although it is enabled, it might not be effective.

This might be due to a different number of reasons, vmemmap does not fully
span a PMD, the size we want to add spans more than a single memory block, etc.

That is what

"Note that even when enabled, there are a few cases where the feature is not
 effective."

is supposed to mean.

Anyway, I did not change my opionion on this.

Thanks

-- 
Oscar Salvador
SUSE L3
