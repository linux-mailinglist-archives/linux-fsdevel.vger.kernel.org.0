Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D942F58A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 04:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbhANCsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 21:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbhANCsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:48:22 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE21C061786
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 18:47:42 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2so2504829pfq.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 18:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bb9vztNKh5yOtZxuyb9LtKscOOsr5r79L3TCOP8Fxpw=;
        b=Wk++KEvZgXFQglTG6qkX5vApZwPahrumxGHE8eNv2CrTeJFuPxhxtOXMtfsNf1zQX0
         Wfrjth2PgAq46N8ehgJNMpslq7pfh80U7P7kKisKrHSeEZnm0FqsNg5UwJnkiXIGyzGc
         Gp1KcCZ4XiF0zPNuZoecIks4e2PHOLy1i2vnQ7j1hFbjVjbm4YbbFxtwC5eYrigiyWJQ
         4qZPAThDKIPGpxb01tmXNxQrWrwOxHdZB88eNyuAgDFktUCZW82VXqxmihXZ3kpBcIt5
         kt2HAslL91h9mlxwKEl06c0oooWMJZu/yEM8LDp94GxCtg4gfc7pb55RGnycJhyGqoz2
         Cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bb9vztNKh5yOtZxuyb9LtKscOOsr5r79L3TCOP8Fxpw=;
        b=ryI6Vb36HqlleBRJBer8pKzuYbS1EJlBfK19WIPHU+sFOfksDi326b8BL/iVrm7EIp
         P/+s46ifLGv7jTlW82DQ/JlE94UdMrE3AhxdhP+R8x9974ADMwi6x1LLlEI6cmzQj9+g
         yqpbJGYYWUZ1B85SohAuUHwWiOjcV3w3T1WK89+PoP2zadBIoYXCWCKrCqE2EjWM3RBv
         hy76oFiqeBIhLRhHPU7r64wqUfLSbWDMn2aGzM2ZJAPAK4l8Dc3ILrJMI0gg1yspDkk5
         GeakBO0mZN852XSTBuM0Ua4y4ZuyPkpt2ySYLR3cMZoVO/4yXHJDaMNn1CudbofkH6sb
         JQiQ==
X-Gm-Message-State: AOAM532m9fJqLhgQoX61d1LFQ+vKT2JW+TIKHPcqkclUHjJRjLF+mcAE
        lxNcMSvfzK69lIYriDLGhASba6uc714/rMhj6EN2yg==
X-Google-Smtp-Source: ABdhPJybZQMKqUQbok9qICM/zCjzBBjPXnnfJENEz8sj+4/RhLsx2i+9EOD9iTXswcQBmlv38NIlS/VowHGzLG5fPJ8=
X-Received: by 2002:a63:50a:: with SMTP id 10mr5142821pgf.273.1610592461638;
 Wed, 13 Jan 2021 18:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20210106141931.73931-1-songmuchun@bytedance.com>
 <20210106141931.73931-13-songmuchun@bytedance.com> <c4afa795-c679-420b-a228-d7f08cf49d02@oracle.com>
In-Reply-To: <c4afa795-c679-420b-a228-d7f08cf49d02@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 14 Jan 2021 10:47:04 +0800
Message-ID: <CAMZfGtWdd79PMRRPydmtsdDyOG1YzfzOK0PbYzESaXAHZVU9Bw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v12 12/13] mm/hugetlb: Gather discrete
 indexes of tail page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 8:18 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/6/21 6:19 AM, Muchun Song wrote:
> > For HugeTLB page, there are more metadata to save in the struct page.
> > But the head struct page cannot meet our needs, so we have to abuse
> > other tail struct page to store the metadata. In order to avoid
> > conflicts caused by subsequent use of more tail struct pages, we can
> > gather these discrete indexes of tail struct page. In this case, it
> > will be easier to add a new tail page index later.
> >
> > There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> > page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
> > so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > ---
> >  include/linux/hugetlb.h        | 14 ++++++++++++++
> >  include/linux/hugetlb_cgroup.h | 15 +++++++++------
> >  mm/hugetlb.c                   | 25 ++++++++++++-------------
> >  mm/hugetlb_vmemmap.c           |  8 ++++++++
> >  4 files changed, 43 insertions(+), 19 deletions(-)
>
> My apologies!  I did not get to this patch in previous versions of the
> series.  My "RFC create hugetlb flags to consolidate state" was done
> before I even noticed your efforts here.
>
> At least we agree the metadata could be better organized. :)
>
> IMO, using page.private of the head page to consolidate flags will be
> easier to manage.  So, I would like to use that.

Agree. Using page.private to manage the page flag is a good
choice. When your RFC patch is applied, I will rebase it and
rework this patch.

>
> The BUILD_BUG_ON in this patch makes sense.
> --
> Mike Kravetz
