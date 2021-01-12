Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB842F25D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbhALBvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 20:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbhALBvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610416181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7I3t60OzDuClLBrgXB9TFcroHckA8JyuUi8Px53LWc=;
        b=QHPRh3cC6A0JB/s3xBAAcz1O0mWUwzNmH8f2DKV3CFg25rdeRBX+XC9LT9g3ipcHJQtNF1
        XW31MpHzqAgkqRLWVYDZ2wrWJbO7sTTDKIOZFxcWnnNP/r9NkKhYPizzFy03V6WLA8tMkA
        sMfYONcE+ZWzlo58X5LKCgzND2LfLrA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-BGguTxnjOnC5A4jRnWAqTA-1; Mon, 11 Jan 2021 20:49:39 -0500
X-MC-Unique: BGguTxnjOnC5A4jRnWAqTA-1
Received: by mail-io1-f71.google.com with SMTP id w26so510282iox.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 17:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X7I3t60OzDuClLBrgXB9TFcroHckA8JyuUi8Px53LWc=;
        b=Ny2qa7Xq6d8rY8hxW0zAsO4NFnlG8S2rokbNgU/f4ZKhmE6G+00ReOyKob3KLzyyu8
         1wjirz2cLMzNDiZqNUN/gzMNUIhFTXtKq0ZtGU+L1btNyyZjRaoKhNzkLERGe2rwnDQJ
         8FJvLkvtAATLAHtkAHHSRol4IK4eA8wCp/OdYnEd0gHK6RGA2bLQrZRmlK6/4sZ0fugm
         gB+12n57HyjK62mZgy1t1elWNSGbSrUb9okIToyM/n/hMErpgokHorZ1u8M8RM9winlx
         9N0luLp7bwqPZlFKMklt4XoFohwOX1uMV16VHzQYIp2OcEhxEXJcvWViK40a0q+qRld+
         2i4A==
X-Gm-Message-State: AOAM530+leegxnBl32QXn9aQDV1vFTEMcKk63cWMV0iU4GFw0FnAG8wd
        wsUBB80E4xcK8i1lAF1iQzPomzJAh8LZdM8sftZItICjqYBge7Td78ELUnl6r+n78tI6X6d3JF4
        5hcUib0dRAvv7A+XYIf+iz/Geuw==
X-Received: by 2002:a92:bbc1:: with SMTP id x62mr1769152ilk.73.1610416178316;
        Mon, 11 Jan 2021 17:49:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzec8+pABMEvXdhqkPqUGOWTzGirXjybA6kOBRXBjFiE6no2H02vg1btC7WPO4Dy7RifLB+Sw==
X-Received: by 2002:a92:bbc1:: with SMTP id x62mr1769133ilk.73.1610416178036;
        Mon, 11 Jan 2021 17:49:38 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id y13sm858351iop.14.2021.01.11.17.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 17:49:37 -0800 (PST)
Date:   Mon, 11 Jan 2021 20:49:34 -0500
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
Message-ID: <20210112014934.GB588752@xz-x1>
References: <20210107190453.3051110-1-axelrasmussen@google.com>
 <48f4f43f-eadd-f37d-bd8f-bddba03a7d39@oracle.com>
 <20210111230848.GA588752@xz-x1>
 <2b31c1ad-2b61-32e7-e3e5-63a3041eabfd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b31c1ad-2b61-32e7-e3e5-63a3041eabfd@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:13:41PM -0800, Mike Kravetz wrote:
> On 1/11/21 3:08 PM, Peter Xu wrote:
> > On Mon, Jan 11, 2021 at 02:42:48PM -0800, Mike Kravetz wrote:
> >> On 1/7/21 11:04 AM, Axel Rasmussen wrote:
> >>> Overview
> >>> ========
> >>>
> >>> This series adds a new userfaultfd registration mode,
> >>> UFFDIO_REGISTER_MODE_MINOR. This allows userspace to intercept "minor" faults.
> >>> By "minor" fault, I mean the following situation:
> >>>
> >>> Let there exist two mappings (i.e., VMAs) to the same page(s) (shared memory).
> >>> One of the mappings is registered with userfaultfd (in minor mode), and the
> >>> other is not. Via the non-UFFD mapping, the underlying pages have already been
> >>> allocated & filled with some contents. The UFFD mapping has not yet been
> >>> faulted in; when it is touched for the first time, this results in what I'm
> >>> calling a "minor" fault. As a concrete example, when working with hugetlbfs, we
> >>> have huge_pte_none(), but find_lock_page() finds an existing page.
> >>>
> >>> We also add a new ioctl to resolve such faults: UFFDIO_CONTINUE. The idea is,
> >>> userspace resolves the fault by either a) doing nothing if the contents are
> >>> already correct, or b) updating the underlying contents using the second,
> >>> non-UFFD mapping (via memcpy/memset or similar, or something fancier like RDMA,
> >>> or etc...). In either case, userspace issues UFFDIO_CONTINUE to tell the kernel
> >>> "I have ensured the page contents are correct, carry on setting up the mapping".
> >>>
> >>
> >> One quick thought.
> >>
> >> This is not going to work as expected with hugetlbfs pmd sharing.  If you
> >> are not familiar with hugetlbfs pmd sharing, you are not alone. :)
> >>
> >> pmd sharing is enabled for x86 and arm64 architectures.  If there are multiple
> >> shared mappings of the same underlying hugetlbfs file or shared memory segment
> >> that are 'suitably aligned', then the PMD pages associated with those regions
> >> are shared by all the mappings.  Suitably aligned means 'on a 1GB boundary'
> >> and 1GB in size.
> >>
> >> When pmds are shared, your mappings will never see a 'minor fault'.  This
> >> is because the PMD (page table entries) is shared.
> > 
> > Thanks for raising this, Mike.
> > 
> > I've got a few patches that plan to disable huge pmd sharing for uffd in
> > general, e.g.:
> > 
> > https://github.com/xzpeter/linux/commit/f9123e803d9bdd91bf6ef23b028087676bed1540
> > https://github.com/xzpeter/linux/commit/aa9aeb5c4222a2fdb48793cdbc22902288454a31
> > 
> > I believe we don't want that for missing mode too, but it's just not extremely
> > important for missing mode yet, because in missing mode we normally monitor all
> > the processes that will be using the registered mm range.  For example, in QEMU
> > postcopy migration with vhost-user hugetlbfs files as backends, we'll monitor
> > both the QEMU process and the DPDK program, so that either of the programs will
> > trigger a missing fault even if pmd shared between them.  However again I think
> > it's not ideal since uffd (even if missing mode) is pgtable-based, so sharing
> > could always be too tricky.
> > 
> > They're not yet posted to public yet since that's part of uffd-wp support for
> > hugetlbfs (along with shmem).  So just raise this up to avoid potential
> > duplicated work before I post the patchset.
> > 
> > (Will read into details soon; probably too many things piled up...)
> 
> Thanks for the heads up about this Peter.
> 
> I know Oracle DB really wants shared pmds -and- UFFD.  I need to get details
> of their exact usage model.  I know they primarily use SIGBUS, but use
> MISSING_HUGETLBFS as well.  We may need to be more selective in when to
> disable.

After a second thought, indeed it's possible to use it that way with pmd
sharing.  Actually we don't need to generate the fault for every page, if what
we want to do is simply "initializing the pages using some data" on the
registered ranges.  Should also be the case even for qemu+dpdk, because if
e.g. qemu faulted in a page, then it'll be nicer if dpdk can avoid faulting in
again (so when huge pmd sharing enabled we can even avoid the PF irq to install
the pte if at last page cache existed).  It should be similarly beneficial if
the other process is not faulting in but proactively filling the holes using
UFFDIO_COPY either for the current process or for itself; sounds like a valid
scenario for Google too when VM migrates.

I've modified my local tree to only disable pmd sharing for uffd-wp but keep
missing mode as-is [1].  A new helper uffd_disable_huge_pmd_share() is
introduced in patch "hugetlb/userfaultfd: Forbid huge pmd sharing when uffd
enabled", so should be easier if we would like to add minor mode too.

Thanks!

[1] https://github.com/xzpeter/linux/commits/uffd-wp-shmem-hugetlbfs

-- 
Peter Xu

