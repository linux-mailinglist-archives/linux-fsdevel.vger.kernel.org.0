Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1482E6C4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Dec 2020 00:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgL1Wzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgL1ToA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:44:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739BFC0613D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 11:43:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t16so12359064wra.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 11:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6xzAcIdXIo+2Bde93U26aSmZWXaCRi+QsS3WozQgGb0=;
        b=nkw+nGbKQWKPrOYGHK9BAjA42ze5HsZN6SKZlaOxdtmSyn6n+yB0xlk2LzHIda2Z7H
         L0Vu27mcZ0gdxTenKuRZh/h3eyf+g2+xsrjQhMKT/F8QKjYdjdYgQCL0gzTQCdYL5h6J
         Y/mLLftb4DOuAwwqyln10KAgbEKKEVEb6bHQb9zWFHI/j9L4C8BQ2ZNlkWniQEVTdIfY
         sRTlcq9nF/VUYbiiCEW77KYeV/JkNvTrI1A4bECvzlKSrkW71Pj2fO7tvy4jSCJgGs0F
         lsdo1I8CrVPXwXa6vmvi6gaE8oAGKgO4qVVGnS2tT0dbC09SgTs/IyaSIc4yrhdtQI3q
         saxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6xzAcIdXIo+2Bde93U26aSmZWXaCRi+QsS3WozQgGb0=;
        b=dUzmiSjKptCYDjBd8W+NWDrfp7xcBL0PH4XGZNSrNU6u49wujukQHVc5GSjsKWyeNR
         rr3bAsPXYl/XNXjmBUflmw471cHef7vbzqQ8wZ3TA6wh9VUQkS7Z6p2giBNVkr79012m
         7C+OZfdpXbIUvV/ufDsrJCZZa+CLJrBXuKfF51ZUDN25Lr7RLYcBwoadNRejO7crcYHV
         O9DnTcOGdMd9D0dfAoo4q14cw2m/gBI4b1R8ArafnQ9VVsydhz1gHvVp178zq8Sh5+Y4
         zMMXtINMK/qv3yZoU1CMZd+jGC0KJ3ifzVxHMBCfLn6jSjLD4GBLLQl8WkHnS4Ip+grD
         cpYA==
X-Gm-Message-State: AOAM531t0cFEFwoVmovchgyO3Sb5WAdCoF7cs3f4jNSxpdBm2a6325cI
        FQPNea+SvJCIwUTTmNWuM7QWpA==
X-Google-Smtp-Source: ABdhPJwb83Fu4ztPY35NAlxNDq3Sse0tFKe7OGO6soaKvmsY/wndPvptcOKr/BVCvNq+x6WTgo81qQ==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr52549183wrv.124.1609184599201;
        Mon, 28 Dec 2020 11:43:19 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id o125sm407062wmo.30.2020.12.28.11.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 11:43:18 -0800 (PST)
Subject: Re: [PATCH 3/6] mremap: Don't allow MREMAP_DONTUNMAP on
 special_mappings and aio
To:     Brian Geffon <bgeffon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <20201013013416.390574-1-dima@arista.com>
 <20201013013416.390574-4-dima@arista.com>
 <CADyq12ww2SB=x16pdH4LBZJJxMakOWgkR0qX-maUe-RzYZ491Q@mail.gmail.com>
 <d5d608ba-a25c-d3a2-b0f4-c97437a6dab1@arista.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <85e469ee-9986-30cf-09d2-832eb8a61291@arista.com>
Date:   Mon, 28 Dec 2020 19:43:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d5d608ba-a25c-d3a2-b0f4-c97437a6dab1@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/28/20 7:33 PM, Dmitry Safonov wrote:
> [I moved your reply to avoid top-posting]
> 
> On 12/28/20 6:03 PM, Brian Geffon wrote:
>> On Mon, Oct 12, 2020 at 6:34 PM Dmitry Safonov <dima@arista.com> wrote:
>>>
>>> As kernel expect to see only one of such mappings, any further
>>> operations on the VMA-copy may be unexpected by the kernel.
>>> Maybe it's being on the safe side, but there doesn't seem to be any
>>> expected use-case for this, so restrict it now.
>>>
>>> Fixes: commit e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
>>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>>
>> I don't think this situation can ever happen MREMAP_DONTUNMAP is
>> already restricted to anonymous mappings (defined as not having
>> vm_ops) and vma_to_resize checks that the mapping is anonymous before
>> move_vma is called.
> 
> I've looked again now, I think it is possible. One can call
> MREMAP_DONTUNMAP without MREMAP_FIXED and without resizing. So that the
> old VMA is copied at some free address.
> 
> The calltrace would be: mremap()=>move_vma()
> [under if (flags & MREMAP_MAYMOVE)].
> 
> On the other side I agree with you that the fix could have been better
> if I realized the semantics that MREMAP_DONTUNMAP should only work with
> anonymous mappings.
> 
> Probably, a better fix would be to move
> :       if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> :                       vma->vm_flags & VM_SHARED))
> :               return ERR_PTR(-EINVAL);
> 
> from vma_to_resize() into the mremap() syscall directly.
> What do you think?

Ok, I've misread the code now, it checks vma_to_resize() before.
I'll send a revert to this one.

Thanks for noticing,
          Dima
