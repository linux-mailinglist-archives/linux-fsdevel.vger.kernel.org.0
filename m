Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9B2A00F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 10:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJ3JPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 05:15:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:48598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgJ3JPA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:15:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604049299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EfN1LEPDQQrCoeNpouMKenj2gqt+0jwF5CDIrEYva5o=;
        b=q7TfBcI4eS1iDErBTa1jW+j0t/DPQOdxbihxnM0kHmI4wW08NtMFb7qJXO6QW/2t70oHUA
        3UBNWjnkVIC6C14TPAXzV1sNwqLK/l28bvD01lu9Cv8ataUtQSpwSk63wVflfWVvxzqxEi
        oBclMLQzKTnqLhHFCJ7y1Y3vpix+kOY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37793AD19;
        Fri, 30 Oct 2020 09:14:59 +0000 (UTC)
Date:   Fri, 30 Oct 2020 10:14:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/19] Free some vmemmap pages of hugetlb page
Message-ID: <20201030091445.GF1478@dhcp22.suse.cz>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-10-20 22:50:55, Muchun Song wrote:
> If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
> substantial gain. On our server, run some SPDK/QEMU applications which
> will use 1000GB hugetlbpage. With this feature enabled, we can save
> ~16GB(1G hugepage)/~11GB(2MB hugepage) memory.
[...]
>  15 files changed, 1091 insertions(+), 165 deletions(-)
>  create mode 100644 include/linux/bootmem_info.h
>  create mode 100644 mm/bootmem_info.c

This is a neat idea but the code footprint is really non trivial. To a
very tricky code which hugetlb is unfortunately.

Saving 1,6% of memory is definitely interesting especially for 1GB pages
which tend to be more static and where the savings are more visible.

Anyway, I haven't seen any runtime overhead analysis here. What is the
price to modify the vmemmap page tables and make them pte rather than
pmd based (especially for 2MB hugetlb). Also, how expensive is the
vmemmap page tables reconstruction on the freeing path?

Thanks!
-- 
Michal Hocko
SUSE Labs
