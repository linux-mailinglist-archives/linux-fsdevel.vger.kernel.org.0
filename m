Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6063A3DCA27
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Aug 2021 07:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhHAFiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Aug 2021 01:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhHAFiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Aug 2021 01:38:17 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29E4C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jul 2021 22:38:09 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 3so7405904qvd.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jul 2021 22:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=iGWJvQyFhYWArKOyYVxVLAiTfV4uzV67U+jmo+FAouk=;
        b=EMVItB+G7FfUUoNMnfQwOUjV3ArbnBTu1oFkd7HLTYn2tVC6AJEYtE4T+IsCywUSpg
         Gw4RUEMFPxQ3c9322Xw+RyDT87+g5/V4dM1xr6NBy3DpWF3Y02qrA72ey7xkFYZJd8of
         qvOv35ebfTG1e41XeO2QIcJBLmf4x0wzo4lWLjyI/uSpUUbEIQw1c6tXOakZLKmIU5vJ
         UR8u6931Pg3iNzH27zPBbSiikVRqrIuOAPnoELhiKdGJ5DZrHSq5Xgrf+zD2wDgtJvSs
         z16Y7Ke/ASDEDjgWOS8tZrDCCMqsa1ToXM08aiKAmUQOQkjWTt8QElX2iHgbpwCxCk0j
         zQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=iGWJvQyFhYWArKOyYVxVLAiTfV4uzV67U+jmo+FAouk=;
        b=Z+rt0a+wcnzwOdsA006j8daQxslJX+KNZyLcmRXjvNPUoZ83QP7ogiyHESpmYjSxgr
         8lRF0V+B2oSrUxNsLXvryvOyc8XPzCqEWaVEMzUNoa58StbmmiYF3pVlg3SKLMd2LzgU
         1E5rg2GIMtCeWXHh1qrVCoHSJfZLpS4RdWk1MaNfJhCb0gvb/tGdSLKyFo0nwBnoM56O
         YvGVv4PaDMkpH27h7VdmOSZM7y/N1ha4aNQQdyCt8ru032V3nA1Fw+qYsIvsDVtVBRQl
         6zmrKQF5jJ0jiWQqF2BdLGM22whZCvsZY4huYCUV5ckTkkGHRNjiFIstmjKRXa3VEkb4
         g4XA==
X-Gm-Message-State: AOAM531i2pdSnky1m58lQgpjWUoaaoi2UFKf0CzsBfHNSQ7zVbeZmvyi
        eDt4Hq0HZv3uM6O+dToIWMkqbQ==
X-Google-Smtp-Source: ABdhPJx99ZPzHnZXgS9SRq4nFquQqzs6nebhu/Lg9udhCOUcHRGzDhYlonCB3p+LX1OoydNRLgHVnw==
X-Received: by 2002:ad4:442e:: with SMTP id e14mr10587697qvt.43.1627796288923;
        Sat, 31 Jul 2021 22:38:08 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h10sm3613305qka.83.2021.07.31.22.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 22:38:08 -0700 (PDT)
Date:   Sat, 31 Jul 2021 22:37:55 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 06/16] huge tmpfs: shmem_is_huge(vma, inode, index)
In-Reply-To: <e7374d7e-4773-aba1-763-8fa2c953f917@google.com>
Message-ID: <ccb7e48b-b9ad-30bb-47df-14cc8298ef8e@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com> <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com> <e7374d7e-4773-aba1-763-8fa2c953f917@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 31 Jul 2021, Hugh Dickins wrote:
> On Fri, 30 Jul 2021, Yang Shi wrote:
> > On Fri, Jul 30, 2021 at 12:42 AM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > Extend shmem_huge_enabled(vma) to shmem_is_huge(vma, inode, index), so
> > > that a consistent set of checks can be applied, even when the inode is
> > > accessed through read/write syscalls (with NULL vma) instead of mmaps
> > > (the index argument is seldom of interest, but required by mount option
> > > "huge=within_size").  Clean up and rearrange the checks a little.
> > >
> > > This then replaces the checks which shmem_fault() and shmem_getpage_gfp()
> > > were making, and eliminates the SGP_HUGE and SGP_NOHUGE modes: while it's
> > > still true that khugepaged's collapse_file() at that point wants a small
> > > page, the race that might allocate it a huge page is too unlikely to be
> > > worth optimizing against (we are there *because* there was at least one
> > > small page in the way), and handled by a later PageTransCompound check.
> > 
> > Yes, it seems too unlikely. But if it happens the PageTransCompound
> > check may be not good enough since the page allocated by
> > shmem_getpage() may be charged to wrong memcg (root memcg). And it
> > won't be replaced by a newly allocated huge page so the wrong charge
> > can't be undone.
> 
> Good point on the memcg charge: I hadn't thought of that.  Of course
> it's not specific to SGP_CACHE versus SGP_NOHUGE (this patch), but I
> admit that a huge mischarge is hugely worse than a small mischarge.

Stupid me (and maybe I haven't given this enough consideration yet):
but, much better than SGP_NOHUGE, much better than SGP_CACHE, would be
SGP_READ there, wouldn't it?  Needs to beware of the NULL too, of course.

Hugh
