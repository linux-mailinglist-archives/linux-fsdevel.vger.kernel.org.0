Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096342E6A4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 20:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgL1TNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 14:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgL1TNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:13:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C9C061793
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 11:12:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t30so12320778wrb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 11:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m/Wglbh+lTgBxyPrtUFRzs3rkWrSwjCdxL8lF/PAxdg=;
        b=KHzYIWd41lKdXti3O/ypHc8S0tMeIsfWLC/Bj7B0SzjA8vucJTYN7bHDQbPOIgg+4F
         fZD18Yty8GCok3qJf1fO63aT/4yXv5IpQqs4zCHs6V8c/hTJ3jaQBAZgI1nNOXy4naTF
         ahJeKtRt8Pj9o4utY+Oij4Ku95ArtGy+QiPl1IdezaUwqXgj7zMzTDihrmBFRPhv697s
         bXngRr1a7rkXrFhKxJYOOgbczrc3pA2FODIFky5l5upMPG9SMmchnVyAwlPmjBKrztxo
         RaTE0yITbMFc9Tl43W6lAhyGoZZ8DqUbKdkwj5EfXs0er0oc6+0O81LxacbGaxM/kkSZ
         KMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m/Wglbh+lTgBxyPrtUFRzs3rkWrSwjCdxL8lF/PAxdg=;
        b=uexBJrPcWxOGsVTRmQMTjm28K6mCmWuycg+/F6uWpeV+BZaEYftlj/vwX7pGoPQxPS
         p3jIAS8KhMfZm16+QI1X4g7bVTt0RHrfo7oC76+AZj96JcMzPV8BzSLVeVf6NQ1+3jTK
         qJMdxWp8YvnKem6RM1HXD3z+I+6F/TIuLH7EFSraOCtPI9rk6ECJS3FSOw8i17UAgfxF
         1fiMGh42egq2irRhBZQSotesvqZ1MeVcxfe68OH2sdyEWKBj1pFKrLnstjcgLSP1ujRE
         EQ9abyLlZrxMmFsVw55lmaUEl9LYyODW9R8QEjRW4rprIOvW72YKRuTp9XDJnyoR0Xlx
         RVXg==
X-Gm-Message-State: AOAM531V0+gfVrZP8JPeFxfPcqTOunCK92N6fOUMk4sMteLBjbr3U9Al
        KUa5i+GXJiMHBy+vemTbOaKX8uNJgLH53YNy
X-Google-Smtp-Source: ABdhPJycPpZJYBqt0uJlm0KWY71lSYtZiAXnw+4FraPx9JOFiEU8hSeGhYPk8VZsjmDtrrKszFFOcA==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr50075979wrt.324.1609182744412;
        Mon, 28 Dec 2020 11:12:24 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id s3sm258209wmc.44.2020.12.28.11.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 11:12:23 -0800 (PST)
Subject: Re: [PATCH 2/6] mm/mremap: For MREMAP_DONTUNMAP check
 security_vm_enough_memory_mm()
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
 <20201013013416.390574-3-dima@arista.com>
 <CADyq12y4WAjT7O3_4E3FmBv4dr5fY6utQZod1UN0Xv8PhOAnQA@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <d25ad10c-6f67-8c11-18c3-0193b8ea14c4@arista.com>
Date:   Mon, 28 Dec 2020 19:12:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CADyq12y4WAjT7O3_4E3FmBv4dr5fY6utQZod1UN0Xv8PhOAnQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/28/20 6:21 PM, Brian Geffon wrote:
> This looks good to me with a small comment.
> 
>>         if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
>>                 /* OOM: unable to split vma, just get accounts right */
>> -               if (vm_flags & VM_ACCOUNT)
>> +               if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
>>                         vm_acct_memory(new_len >> PAGE_SHIFT);
> 
> Checking MREMAP_DONTUNMAP in the do_munmap path is unnecessary as
> MREMAP_DONTUNMAP will have already returned by this point.

In this code it is also used as err-path. In case move_page_tables()
fails to move all page tables or .mremap() callback fails, the new VMA
is unmapped.

IOW, MREMAP_DONTUNMAP returns under:
:	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {

-- 
          Dima
