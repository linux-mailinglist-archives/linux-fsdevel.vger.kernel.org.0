Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0C2F2433
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405511AbhALAZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403810AbhAKXKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610406536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZDeRCQYJoezv5keDk7+o32vhu8r74OG0tRv9cLa8Bs=;
        b=JVx7WjusI+in290KoptublzLF6olRuvf8ROzDF1b8KQjtwn1fep6By8H/OwZGMrKvXWyQX
        0HM0B/ce3NpHo1cRTrbvLBq9JgeDeC8loWqdkoSHBhRCvXMPnxBm68dUEOzDHBBj1TZYVh
        DSo6FBXxerfswEKcT8YWy5IecRZf2Ds=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-A1EKZwmvPsuH_AxAFiWMuQ-1; Mon, 11 Jan 2021 18:08:53 -0500
X-MC-Unique: A1EKZwmvPsuH_AxAFiWMuQ-1
Received: by mail-il1-f198.google.com with SMTP id e10so774050ils.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 15:08:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XZDeRCQYJoezv5keDk7+o32vhu8r74OG0tRv9cLa8Bs=;
        b=DLBYNHf3YGudGWso6SS6AJHXGKQWw02B9FkuQbHOwu4UIoTT6jn2ObrsqK34ayWCmz
         1pX6x8IGCRHNLqsuMzIwpeaPohlGBgIjuvgF5zuOkejABkx1WYGDNR42BPyeEqP5i7HI
         pPrdkOao/aqdXhVNvWP2o9HmOaqdKTeCJU35UPZwde0rsPiVJFC1BIku4BeP87AB7+an
         3NOOGp2/1N1Q0sc9fRNhIZjZpM3QIuc8VVOjBQVNR3A3TvKWSlbRApyGjsPtvcKeMuPo
         vZRcrT76hMoPi7qQUtYcx6cqA7brlLo0mRmMN5DmEwNgaiijlOg5pWuPKgFZAAjFWexP
         UIGg==
X-Gm-Message-State: AOAM5318IyVAy/o3cN6PmJOVDY94CGYt3HIBKH6/2s5EnnqQ7+Rz7uTg
        gDa8ru8TxnxO3eyNVjsFbCf1TKuXzddwFqmAVlJTFFPdtKFw82zMQ26Zekt3t6RbdrRMKcPXR4o
        mXthM7vBwu8Luq/xay5e82wa6TQ==
X-Received: by 2002:a92:6f07:: with SMTP id k7mr1342454ilc.18.1610406532566;
        Mon, 11 Jan 2021 15:08:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzi58bzqh6TdOv13kET/jPoSNAHx1PfMuqHIzilGW0nnoTifMrHyGHUJjjT4/c/z4CZPFG8BQ==
X-Received: by 2002:a92:6f07:: with SMTP id k7mr1342424ilc.18.1610406532311;
        Mon, 11 Jan 2021 15:08:52 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id l20sm669280ioh.49.2021.01.11.15.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 15:08:51 -0800 (PST)
Date:   Mon, 11 Jan 2021 18:08:48 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [RFC PATCH 0/2] userfaultfd: handle minor faults, add
 UFFDIO_CONTINUE
Message-ID: <20210111230848.GA588752@xz-x1>
References: <20210107190453.3051110-1-axelrasmussen@google.com>
 <48f4f43f-eadd-f37d-bd8f-bddba03a7d39@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48f4f43f-eadd-f37d-bd8f-bddba03a7d39@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 02:42:48PM -0800, Mike Kravetz wrote:
> On 1/7/21 11:04 AM, Axel Rasmussen wrote:
> > Overview
> > ========
> > 
> > This series adds a new userfaultfd registration mode,
> > UFFDIO_REGISTER_MODE_MINOR. This allows userspace to intercept "minor" faults.
> > By "minor" fault, I mean the following situation:
> > 
> > Let there exist two mappings (i.e., VMAs) to the same page(s) (shared memory).
> > One of the mappings is registered with userfaultfd (in minor mode), and the
> > other is not. Via the non-UFFD mapping, the underlying pages have already been
> > allocated & filled with some contents. The UFFD mapping has not yet been
> > faulted in; when it is touched for the first time, this results in what I'm
> > calling a "minor" fault. As a concrete example, when working with hugetlbfs, we
> > have huge_pte_none(), but find_lock_page() finds an existing page.
> > 
> > We also add a new ioctl to resolve such faults: UFFDIO_CONTINUE. The idea is,
> > userspace resolves the fault by either a) doing nothing if the contents are
> > already correct, or b) updating the underlying contents using the second,
> > non-UFFD mapping (via memcpy/memset or similar, or something fancier like RDMA,
> > or etc...). In either case, userspace issues UFFDIO_CONTINUE to tell the kernel
> > "I have ensured the page contents are correct, carry on setting up the mapping".
> > 
> 
> One quick thought.
> 
> This is not going to work as expected with hugetlbfs pmd sharing.  If you
> are not familiar with hugetlbfs pmd sharing, you are not alone. :)
> 
> pmd sharing is enabled for x86 and arm64 architectures.  If there are multiple
> shared mappings of the same underlying hugetlbfs file or shared memory segment
> that are 'suitably aligned', then the PMD pages associated with those regions
> are shared by all the mappings.  Suitably aligned means 'on a 1GB boundary'
> and 1GB in size.
> 
> When pmds are shared, your mappings will never see a 'minor fault'.  This
> is because the PMD (page table entries) is shared.

Thanks for raising this, Mike.

I've got a few patches that plan to disable huge pmd sharing for uffd in
general, e.g.:

https://github.com/xzpeter/linux/commit/f9123e803d9bdd91bf6ef23b028087676bed1540
https://github.com/xzpeter/linux/commit/aa9aeb5c4222a2fdb48793cdbc22902288454a31

I believe we don't want that for missing mode too, but it's just not extremely
important for missing mode yet, because in missing mode we normally monitor all
the processes that will be using the registered mm range.  For example, in QEMU
postcopy migration with vhost-user hugetlbfs files as backends, we'll monitor
both the QEMU process and the DPDK program, so that either of the programs will
trigger a missing fault even if pmd shared between them.  However again I think
it's not ideal since uffd (even if missing mode) is pgtable-based, so sharing
could always be too tricky.

They're not yet posted to public yet since that's part of uffd-wp support for
hugetlbfs (along with shmem).  So just raise this up to avoid potential
duplicated work before I post the patchset.

(Will read into details soon; probably too many things piled up...)

Thanks,

-- 
Peter Xu

