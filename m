Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F1D336E4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 09:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhCKIyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 03:54:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:37956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhCKIxg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:53:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615452814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iMdDHdKQUwFUd6NvEWE8XF/SFceIsCZgywYTHi2Bsgo=;
        b=Mb2OWgKtA5moO/qXD2QpF0bvDUKXZ2yZfJKd07VICB6jBiVP7wLhht1TgkDfmZ7X3B/R+5
        nDaI2S9Gz29aEQkTqFPHPbBgpgnjhG1GFHb+HfDIzm35kE93x6bhBwmNCO5yCi2Ujh0rp6
        0F71Kkr+B0dCPdhiJLkUALRLwYgqKiI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60A98AB8C;
        Thu, 11 Mar 2021 08:53:34 +0000 (UTC)
Date:   Thu, 11 Mar 2021 09:53:33 +0100
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
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [External] Re: [PATCH v18 1/9] mm: memory_hotplug: factor out
 bootmem core functions to bootmem_info.c
Message-ID: <YEnajfqDEjEMTYXE@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-2-songmuchun@bytedance.com>
 <YEjUYOIJb2kYoQIA@dhcp22.suse.cz>
 <CAMZfGtUj9vcVrSjT8Tk12jfkVE127Vkdkx6Js1JXzL+=rmu7Qw@mail.gmail.com>
 <CAMZfGtX37yBkKJjmBBSBeDeVAM6XywAJuEXjTSm7apOmQ-FOxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtX37yBkKJjmBBSBeDeVAM6XywAJuEXjTSm7apOmQ-FOxA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-03-21 16:45:51, Muchun Song wrote:
> On Thu, Mar 11, 2021 at 10:58 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Wed, Mar 10, 2021 at 10:14 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > [I am sorry for a late review]
> >
> > Thanks for your review.
> >
> > >
> > > On Mon 08-03-21 18:27:59, Muchun Song wrote:
> > > > Move bootmem info registration common API to individual bootmem_info.c.
> > > > And we will use {get,put}_page_bootmem() to initialize the page for the
> > > > vmemmap pages or free the vmemmap pages to buddy in the later patch.
> > > > So move them out of CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code
> > > > movement without any functional change.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > > > Tested-by: Chen Huang <chenhuang5@huawei.com>
> > > > Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> > >
> > > Separation from memory_hotplug.c is definitely a right step. I am
> > > wondering about the config dependency though
> > > [...]
> > > > diff --git a/mm/Makefile b/mm/Makefile
> > > > index 72227b24a616..daabf86d7da8 100644
> > > > --- a/mm/Makefile
> > > > +++ b/mm/Makefile
> > > > @@ -83,6 +83,7 @@ obj-$(CONFIG_SLUB) += slub.o
> > > >  obj-$(CONFIG_KASAN)  += kasan/
> > > >  obj-$(CONFIG_KFENCE) += kfence/
> > > >  obj-$(CONFIG_FAILSLAB) += failslab.o
> > > > +obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
> > >
> > > I would have expected this would depend on CONFIG_SPARSE.
> > > BOOTMEM_INFO_NODE is really an odd thing to depend on here. There is
> > > some functionality which requires the node info but that can be gated
> > > specifically. Or what is the thinking behind?
> 
> I have tried this. And I find that it is better to depend on
> BOOTMEM_INFO_NODE instead of SPARSEMEM.
> 
> If we enable SPARSEMEM but disable HAVE_BOOTMEM_INFO_NODE,
> the bootmem_info.c also is compiled. Actually, we do not
> need those functions on other architectures. And these
> functions are also related to bootmem info. So it may be
> more reasonable to depend on BOOTMEM_INFO_NODE.
> Just my thoughts.

If BOOTMEM_INFO_NODE is disbabled then bootmem_info.c would be
effectivelly only {get,put}_page_bootmem, no?

-- 
Michal Hocko
SUSE Labs
