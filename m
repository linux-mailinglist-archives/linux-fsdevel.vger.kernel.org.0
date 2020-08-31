Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07444257380
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 08:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHaGHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 02:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHaGHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:07:06 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115D0C061575
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 23:07:05 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so63014oij.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 23:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ztuJ7lCE7kvEopSezi/ervbTmQwS2BBYgYbiSUHWDXw=;
        b=cmF2xLSOc0U8iPN/z0M/2KlwqgwRrp6zq9MwpiRV27UnbWuS7mGffAS2K5qX6wGZDA
         vKV3JN+iiDvuhHUrUpKdss5ebLyYtzRN8/X6y16byabkAS2Nyq0e/ZjqlVt+h7dHjzAS
         2+/a8PNuK2ZUVeGks4uD5ObjruiD14v/ThBq/Mb2pru7WMFg0ZkunMkPWRsdWw+d9xwh
         RLNt+mr1jdeBPF6KYi/e1cYn/Gbn+24t9EoWZgX7LTiPH8ccaSYYeTkNq0kAVW5A7TSN
         pz91sXm5kCQ8WCklfAXzQHteSKQsJjFIR3w7sUTaXaVWPcqay+RgSPuaiDr1sa+X689+
         uXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ztuJ7lCE7kvEopSezi/ervbTmQwS2BBYgYbiSUHWDXw=;
        b=Q6pj8ajKOoBt0bIq5j0/Lt6ornaybMw1CynA935N+o2zFK3DU9odFiyezFChTD97WE
         mFArjcfJFUceBvLJegrwQwYoKwCxfAbykHFVG5kz33JZCW5sqJgZFfSjyu5Dicik7T+i
         lAqRfMV2fef2eMYWcUu8v6d/x7e0nZHK1K4R7KIAhwg5CDCvR66Cvfw5yKG6lGkJ3r/8
         4K66tAWKQLGqQpMNm4+uAkOGd7VczUqDmQdSgCn81jSt0jpiR/3Z+AQHU2owldYAINYT
         HNv7bwuE+mp1YdBe56AMMrpdFl38i8frCCN74O1zmr/PFe+XcsYSU7yZblGeJcESyGLw
         Yosw==
X-Gm-Message-State: AOAM5309Wcj7hYmVkh79eGgRVHJfec5Arr8lGvnzodjmoCs7Y2xSev+r
        Zly8o+BTIwobTRFgikcRKgj9vw==
X-Google-Smtp-Source: ABdhPJz/zU/QKQdg3JGY2l0l+MAtlTVJhSk3I1VuspUkRP/wEWRSujcUG5/U0enSatTYPzam6ne/kQ==
X-Received: by 2002:aca:cd93:: with SMTP id d141mr14485oig.33.1598854024866;
        Sun, 30 Aug 2020 23:07:04 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 126sm597160oof.28.2020.08.30.23.07.02
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2020 23:07:03 -0700 (PDT)
Date:   Sun, 30 Aug 2020 23:06:47 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jann Horn <jannh@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 7/7] mm: Remove the now-unnecessary mmget_still_valid()
 hack
In-Reply-To: <20200827114932.3572699-8-jannh@google.com>
Message-ID: <alpine.LSU.2.11.2008302225510.1934@eggly.anvils>
References: <20200827114932.3572699-1-jannh@google.com> <20200827114932.3572699-8-jannh@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Aug 2020, Jann Horn wrote:

> The preceding patches have ensured that core dumping properly takes the
> mmap_lock. Thanks to that, we can now remove mmget_still_valid() and all
> its users.

Hi Jann, while the only tears to be shed over losing mmget_still_valid()
will be tears of joy, I think you need to explain why you believe it's
safe to remove the instance in mm/khugepaged.c: which you'll have found
I moved just recently, to cover an extra case (sorry for not Cc'ing you).

> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -431,7 +431,7 @@ static void insert_to_mm_slots_hash(struct mm_struct *mm,
>  
>  static inline int khugepaged_test_exit(struct mm_struct *mm)
>  {
> -	return atomic_read(&mm->mm_users) == 0 || !mmget_still_valid(mm);
> +	return atomic_read(&mm->mm_users) == 0;
>  }
>  
>  static bool hugepage_vma_check(struct vm_area_struct *vma,

The movement (which you have correctly followed) was in
bbe98f9cadff ("khugepaged: khugepaged_test_exit() check mmget_still_valid()")
but the "pmd .. physical page 0" issue is explained better in its parent
18e77600f7a1 ("khugepaged: retract_page_tables() remember to test exit")

I think your core dumping is still reading the page tables without
holding mmap_lock, so still vulnerable to that extra issue.  It won't
be as satisfying as removing all traces of mmget_still_valid(), but
right now I think you should add an mm->core_state check there instead.

(I do have a better solution in use, but it's a much larger patch, that
will take a lot more effort to get in: checks in pte_offset_map_lock(),
perhaps returning NULL when pmd is transitioning, requiring retry.)

Or maybe it's me who has missed what you're doing instead.

Hugh
