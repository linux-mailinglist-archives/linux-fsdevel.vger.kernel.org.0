Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C34132CB5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 05:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhCDE1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 23:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhCDE1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:27:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43075C061574;
        Wed,  3 Mar 2021 20:26:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e9so5981600pjj.0;
        Wed, 03 Mar 2021 20:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=saz39NphErLN6qEzH04XuHlAVGZp77aIU1VH6z80Tzk=;
        b=Z4iudz7Pmo3VFvkA3EmxhLycHE8GJcTuKp6QcrMJPTdtjFOdsUusPNdSsAF0WJ7tgk
         ZtQwYExcL5TEeIjJjvLqJO4L1DTyfT7+T5ZVt/TpJKNeLjE07hLlERg9da//BPEoZDME
         WIIOt9yZ4lmMJfm4gMm11gwdEu2WiCsBioo1cbf4OM0rfyhltVSgsJUO3kaMYfnAzTyd
         KnRRQ5wsWE81nLOf/MysScoy4RQB6uCjWkjpxnxrk6G7WgfsCkK3XZ7WPctUmAs1BDhd
         +Z+deMeTyBz+R9xT7kbdDG1Sy+CDnNL9o2mySctfM82CBLg9Rp0Boak1vy09t1yUWoa+
         loTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=saz39NphErLN6qEzH04XuHlAVGZp77aIU1VH6z80Tzk=;
        b=gYHnJw1g2fCWxRMA748lzmlpL5gHLmP4wYwNvazif+tFRUr6TiWLdcxRnqOAYhMIJB
         NomeRBKccGAitaIdDIQnEfwDVbnIq0ihAhyn+yTaplxG0bH8udrkF6CRAzVLQy5CKujC
         3tQmmHU5F1P/nvaW51jrvG5I73xCUBZcxgngeMTT9v8gRKRvnuofxQWuulfxBkwNbYVe
         fF/HOlcK70oeDgVz68Yjz7BDm2mTlDWECoX1T+jYSCWwLYrh4Fymhc8JHfAWD9B+2755
         PBLlIoDCmQneXUgNdgJzhSa3LBMjIhZVrGa0EKC4qin8EQrje8HjKU23eKiCosMGp6sV
         H2eQ==
X-Gm-Message-State: AOAM5335U2NBy/VuznXcewyR/keH7C2Zxj7sxJwKFaipVx8IlVYqzOiX
        fcwNgOh21jahJOwE0ml5pVE=
X-Google-Smtp-Source: ABdhPJyLnxLyD+UXIVjZU6qH/FZP1EZUYxl/7aYzM8K1hx8bHoZ7IDGmGnxXuZgh3qZCJmY10X5Enw==
X-Received: by 2002:a17:90a:7f84:: with SMTP id m4mr2467688pjl.76.1614831981749;
        Wed, 03 Mar 2021 20:26:21 -0800 (PST)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id u66sm28533366pfc.72.2021.03.03.20.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 20:26:20 -0800 (PST)
Date:   Thu, 4 Mar 2021 15:26:17 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v17 1/9] mm: memory_hotplug: factor out bootmem core
 functions to bootmem_info.c
Message-ID: <20210304042617.GB1223287@balbir-desktop>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-2-songmuchun@bytedance.com>
 <baa8e9af-69f5-c301-6735-f8eedc1929c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa8e9af-69f5-c301-6735-f8eedc1929c7@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 03, 2021 at 01:45:00PM +1100, Singh, Balbir wrote:
> On 26/2/21 12:21 am, Muchun Song wrote:
> > Move bootmem info registration common API to individual bootmem_info.c.
> > And we will use {get,put}_page_bootmem() to initialize the page for the
> > vmemmap pages or free the vmemmap pages to buddy in the later patch.
> > So move them out of CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code
> > movement without any functional change.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ...
> 
> > diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> > new file mode 100644
> > index 000000000000..fcab5a3f8cc0
> > --- /dev/null
> > +++ b/mm/bootmem_info.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *  linux/mm/bootmem_info.c
> > + *
> > + *  Copyright (C)
> 
> Looks like incomplete
>
Not that my comment was, I should have said

The copyright looks very incomplete

Balbir Singh.
