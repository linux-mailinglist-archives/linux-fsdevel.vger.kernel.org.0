Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06576EEA78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 01:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjDYXBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 19:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjDYXBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 19:01:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72A7AF24
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 16:01:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b92309d84c1so31328330276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 16:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682463666; x=1685055666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FCfgX459C+HvVh2FD7e7JZg40F1mOAMJVuhQWLHla/0=;
        b=C4AljZcb5zSEki65YN1EEhXpKoY2+BQjkZw0lA37fbXw5J94rINcczlcHQKioosXoz
         QYJO7B3PQHsCBBmLZHmB2bdJerRvszbD8Z0QkB4l66SvwAArYTtc7JH15w/nYT/SE5u5
         vwm/eMEJk1TY+eEPX82hBLbrKJ9kTJikXcAr57e2kixe1dolatDoyNrc44iwLTBRVolO
         bfADSu5kj9Pbljxty8CvVBHkrXGW31eBuRDxicojfWBD4NefEdirxSFfQsz+fSqmBEth
         Qzgwwtz8KWzAJnphFlQcihCJZ0/hpd4K50BVsMO7BpnBpVR4VQKe84Z8OdOHhFvQF7fh
         tpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682463666; x=1685055666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCfgX459C+HvVh2FD7e7JZg40F1mOAMJVuhQWLHla/0=;
        b=f/qFN+tCwWRrjtMmWr+idVVFPvRodj60OSOO+GQuH4bZmCZk/49XXlYBUa6u0jf9sO
         UE5jFj9bqX0le3UEn525CHW+RRFyHZqQVRImk/pIzkFZsGC93JL7P0coAQABtosVha8P
         9o8DSC+jdqgu7DyJ6kMo6nfMO91NIFzqRRVpE4SrZ36453Q1wenE9yLHNTrHWinqjIlM
         Y0IC30vnYE6IKRCMrqgshgG9N6OFTMpgXEppJqJEJOKYcY9z+CKlA6FIjQlvzpzoabaa
         EdCWNEWinrNZrcMtvbKDBPE6YWv9qAzuYSATquBfi2+Os+6QMEphMzBNtO5yWwKIy4KO
         okCA==
X-Gm-Message-State: AC+VfDwuOosZj+BC0Xh5icqDyPxRV5CE7OQNBDydjMSg+rgQpLnCgN4p
        1OuOqWIASUdZMkcjU3lS0xVSMZzRdhY=
X-Google-Smtp-Source: ACHHUZ7zn8PbJQ/UuE69mi5lwaIaGdUdtx9hP2cvpdZFHM9mCc7INsMunl92AGHkpHAOjQl1AWoM2QO/O/0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:986:b0:54c:15ad:11e4 with SMTP id
 ce6-20020a05690c098600b0054c15ad11e4mr342131ywb.0.1682463665939; Tue, 25 Apr
 2023 16:01:05 -0700 (PDT)
Date:   Tue, 25 Apr 2023 16:01:04 -0700
In-Reply-To: <diqz354w92x3.fsf@ackerleytng-cloudtop.c.googlers.com>
Mime-Version: 1.0
References: <ZDnAuGKrCO2wgjlG@google.com> <diqz354w92x3.fsf@ackerleytng-cloudtop.c.googlers.com>
Message-ID: <ZEhbsHqBapHtdrg7@google.com>
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     chao.p.peng@linux.intel.com, xiaoyao.li@intel.com,
        isaku.yamahata@gmail.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, pbonzini@redhat.com, corbet@lwn.net,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, arnd@arndb.de, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, x86@kernel.org, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, shuah@kernel.org, rppt@kernel.org,
        steven.price@arm.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        vannapurve@google.com, yu.c.zhang@linux.intel.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, mhocko@suse.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > I agree, a pure alignment check is too restrictive, and not really what I
> > intended despite past me literally saying that's what I wanted :-)  I think
> > I may have also inverted the "less alignment" statement, but luckily I
> > believe that ends up being a moot point.
> 
> > The goal is to avoid having to juggle scenarios where KVM wants to create a
> > hugepage, but restrictedmem can't provide one because of a misaligned file
> > offset.  I think the rule we want is that the offset must be aligned to the
> > largest page size allowed by the memslot _size_.  E.g. on x86, if the
> > memslot size is >=1GiB then the offset must be 1GiB or beter, ditto for
> > >=2MiB and >=4KiB (ignoring that 4KiB is already a requirement).
> 
> > We could loosen that to say the largest size allowed by the memslot, but I
> > don't think that's worth the effort unless it's trivially easy to implement
> > in code, e.g. KVM could technically allow a 4KiB aligned offset if the
> > memslot is 2MiB sized but only 4KiB aligned on the GPA.  I doubt there's a
> > real use case for such a memslot, so I want to disallow that unless it's
> > super easy to implement.
> 
> Checking my understanding here about why we need this alignment check:
> 
> When KVM requests a page from restrictedmem, KVM will provide an offset
> into the file in terms of 4K pages.
> 
> When shmem is configured to use hugepages, shmem_get_folio() will round
> the requested offset down to the nearest hugepage-aligned boundary in
> shmem_alloc_hugefolio().
> 
> Example of problematic configuration provided to
> KVM_SET_USER_MEMORY_REGION2:
> 
> + shmem configured to use 1GB pages
> + restrictedmem_offset provided to KVM_SET_USER_MEMORY_REGION2: 0x4000
> + memory_size provided in KVM_SET_USER_MEMORY_REGION2: 1GB
> + KVM requests offset (pgoff_t) 0x8, which translates to offset 0x8000
> 
> restrictedmem_get_page() and shmem_get_folio() returns the page for
> offset 0x0 in the file, since rounding down 0x8000 to the nearest 1GB is
> 0x0. This is allocating outside the range that KVM is supposed to use,
> since the parameters provided in KVM_SET_USER_MEMORY_REGION2 is only
> supposed to be offset 0x4000 to (0x4000 + 1GB = 0x40004000) in the file.
> 
> IIUC shmem will actually just round down (0x4000 rounded down to nearest
> 1GB will be 0x0) and allocate without checking bounds, so if offset 0x0
> to 0x4000 in the file were supposed to be used by something else, there
> might be issues.
> 
> Hence, this alignment check ensures that rounding down of any offsets
> provided by KVM (based on page size configured in the backing file
> provided) to restrictedmem_get_page() must not go below the offset
> provided to KVM_SET_USER_MEMORY_REGION2.
> 
> Enforcing alignment of restrictedmem_offset based on the currently-set
> page size in the backing file (i.e. shmem) may not be effective, since
> the size of the pages in the backing file can be adjusted to a larger
> size after KVM_SET_USER_MEMORY_REGION2 succeeds. With that, we may still
> end up allocating outside the range that KVM was provided with.
> 
> Hence, to be safe, we should check alignment to the max page size across
> all backing filesystems, so the constraint is
> 
>     rounding down restrictedmem_offset to
>     min(max page size across all backing filesystems,
>         max page size that fits in memory_size) == restrictedmem_offset
> 
> which is the same check as
> 
>     restrictedmem_offset must be aligned to min(max page size across all
>     backing filesystems, max page size that fits in memory_size)
> 
> which can safely reduce to
> 
>     restrictedmem_offset must be aligned to max page size that fits in
>     memory_size
> 
> since "max page size that fits in memory_size" is probably <= to "max
> page size across all backing filesystems", and if it's larger, it'll
> just be a tighter constraint.

Yes?  The alignment check isn't strictly required, KVM _could_ deal with the above
scenario, it's just a lot simpler and safer for KVM if the file offset needs to
be sanely aligned.

> If the above understanding is correct:
> 
> + We must enforce this in the KVM_SET_USER_MEMORY_REGION2 handler, since
>   IIUC shmem will just round down and allocate without checking bounds.
> 
>     + I think this is okay because holes in the restrictedmem file (in
>       terms of offset) made to accommodate this constraint don't cost us
>       anything anyway(?) Are they just arbitrary offsets in a file? In
>       our case, this file is usually a new and empty file.
> 
>     + In the case of migration of a restrictedmem file between two KVM
>       VMs, this constraint would cause a problem is if the largest
>       possible page size on the destination machine is larger than that
>       of the source machine. In that case, we might have to move the
>       data in the file to a different offset (a separate problem).

Hmm, I was thinking this would be a non-issue because the check would be tied to
the max page _possible_ page size irrespective of hardware support, but that would
be problematic if KVM ever supports 512GiB pages.  I'm not sure that speculatively
requiring super huge memslots to be 512GiB aligned is sensible.

Aha!  If we go with a KVM ioctl(), a clean way around this is tie the alignment
requirement to the memfd flags, e.g. if userspace requests the memfd to be backed
by PMD hugepages, then the memslot offset needs to be 2MiB aligned on x86.  That
will continue to work if (big if) KVM supports 512GiB pages because the "legacy"
memfd would still be capped at 2MiB pages.

Architectures that support variable hugepage sizes might need to do something
else, but I don't think that possibility affects what x86 can/can't do.

> + On this note, it seems like there is no check for when the range is
>   smaller than the allocated page? Like if the range provided is 4KB in
>   size, but shmem is then configured to use a 1GB page, will we end up
>   allocating past the end of the range?

No, KVM already gracefully handles situations like this.  Well, x86 does, I assume
other architectures do too :-)

As above, the intent of the extra restriction is so that KVM doen't need even more
weird code (read: math) to gracefully handle the new edge cases that would come with
fd-only memslots.
