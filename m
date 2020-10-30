Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48872A02BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 11:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgJ3KZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 06:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgJ3KZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:25:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626AFC0613D4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 03:25:03 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f38so4830787pgm.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3BGkHyMUAcPWaiYElJuGkin/Ch6RoeIDSf/cjT/XKY=;
        b=lKwLLt4dLJrwYKz1isaaQyrg51qniG2bO9YO+gcQpxSKGHXbaqagOs5Xi28UmxmT8+
         y54t5hh34z1betgNgZdy7j5Qp9nHohzQ+5lIzDf0xKNl/sgbY5WfNgm5zFYRTVCGEoW+
         M5WK5W83RIkmiZrTrRXoooavnPTUqq2z6ThXPcQpe7LseuTflVuAIbIW+lk4lzU0fNpE
         eO7Pb82pw58h64VKr3dt+77B3cvRaU1A6fhTkoYUONfYYMOkk7fYfKVmLys/v6RKU983
         +8RODoyILxdxifNbcJRBHEuFgr9ZDWWbC0yvWPfVdHFsfjIfUtzUNaKT37paV15J7hrr
         UX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3BGkHyMUAcPWaiYElJuGkin/Ch6RoeIDSf/cjT/XKY=;
        b=KdLwulFL7fFxEnf/JWWVDAuWE067qHXYKOyXU6x4m/se88z2xCK/oNq9nUszCo5l2b
         blYHCixiyzJL6wKwaBwtgw7KiOjqlABD50ZVHhjqnVth+nPZBmUOSx6lNAWQaSK4wui3
         FcL1NIOCG4N0gV+OHLNXqiM7xNRU27eaSh4J83nvDDsZSmeFq0fuNhFZztWTEMGPHWEW
         lo8d1EYhHyd81Vy/DeQiM2J8pwMtpAtNbEexVBgfHk1mhB2+2ecSVnz2b91XnXxBSWLS
         T8/YKGY3vSZwRcTULwiQPJ6hoL+4t3X+BZxErLmM1/ZSfecVDMkg1uqQ/oKz0W+nD5ZC
         q75A==
X-Gm-Message-State: AOAM53221hZsQGmtmfbPoQ4KDDS5DdncvvaKKTYIPFJAt7rlC7T/lw0x
        pN8kf6WyIUajdNZYF+02DrbJQEB/FCAhLk4zoO7TYQ==
X-Google-Smtp-Source: ABdhPJwyjzUykhJBgO4xRIxz/zsV9eOTOu6Kknf9mk+qKBEDABpYQ3M+M9v2OBxghVmkxo89DPwXn0OjWqLJPuxH/hg=
X-Received: by 2002:a17:90b:198d:: with SMTP id mv13mr2031860pjb.13.1604053502754;
 Fri, 30 Oct 2020 03:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201026145114.59424-1-songmuchun@bytedance.com> <20201030091445.GF1478@dhcp22.suse.cz>
In-Reply-To: <20201030091445.GF1478@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Oct 2020 18:24:25 +0800
Message-ID: <CAMZfGtUoEeJTBYwxYjWJEreHefcO81WhhnvRO7vTb_k+zPCHrg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 00/19] Free some vmemmap pages of
 hugetlb page
To:     Michal Hocko <mhocko@suse.com>
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 5:14 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 26-10-20 22:50:55, Muchun Song wrote:
> > If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
> > substantial gain. On our server, run some SPDK/QEMU applications which
> > will use 1000GB hugetlbpage. With this feature enabled, we can save
> > ~16GB(1G hugepage)/~11GB(2MB hugepage) memory.
> [...]
> >  15 files changed, 1091 insertions(+), 165 deletions(-)
> >  create mode 100644 include/linux/bootmem_info.h
> >  create mode 100644 mm/bootmem_info.c
>
> This is a neat idea but the code footprint is really non trivial. To a
> very tricky code which hugetlb is unfortunately.
>
> Saving 1,6% of memory is definitely interesting especially for 1GB pages
> which tend to be more static and where the savings are more visible.
>
> Anyway, I haven't seen any runtime overhead analysis here. What is the
> price to modify the vmemmap page tables and make them pte rather than
> pmd based (especially for 2MB hugetlb). Also, how expensive is the
> vmemmap page tables reconstruction on the freeing path?

Yeah, I haven't tested the remapping overhead of reserving a hugetlb
page. I can do that. But the overhead is not on the allocation/freeing of
each hugetlb page, it is only once when we reserve some hugetlb pages
through /proc/sys/vm/nr_hugepages. Once the reservation is successful,
the subsequent allocation, freeing and using are the same as before
(not patched). So I think that the overhead is acceptable.

Thanks.

>
> Thanks!
> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
