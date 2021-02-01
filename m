Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524DF30B06C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 20:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBATfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 14:35:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229963AbhBATfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612208020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cts+A+BD4EzHAWhJKCdYjKO/m6gZhIEKA3PVKIyBlzc=;
        b=hM86VxNtbpmQCMWCDNVj+KSxstlQHG9B45uqRcqfvrs11JRz1pbhlTBDqW+RCYsoaHKMuI
        46Q2UnOvzvcb/b/fj+g02/vDgKhqbMTki/NJXWZjFsaRJ/AbUkbTnZ3Gdi+HPprKQaaJml
        jFi9pN9seRLdui8ht8l/OvuieXCiNCE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-EinWrvDuMveoJoZhY7Dzrg-1; Mon, 01 Feb 2021 14:33:38 -0500
X-MC-Unique: EinWrvDuMveoJoZhY7Dzrg-1
Received: by mail-qt1-f198.google.com with SMTP id z19so11382789qtv.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 11:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cts+A+BD4EzHAWhJKCdYjKO/m6gZhIEKA3PVKIyBlzc=;
        b=qWQiHAx63ZAcul4GFFNW73SFaVWQ03Ji3zFSZN/6L5vCQ3Pn3wIIFVONP3qSVJBBsx
         p7hmmUm7xSpXl4lg5+rdsHLRgLo832A9WjHdtVEIZubybVBEkMsCz8AgMDSs7M5ZIIDR
         RMzUQhVXqmBrn0AGTq+Kcdk9VVEtvxYE54DbqsVjFw+AHl38L8nnWlcUHq5r9BOg7L3a
         6Kd8L1/nNi3cuNSDaLW+F4PUP6pYl7oNe/VHHgcD1nqFf13AaT3SbutcmEykHRSiRPfB
         na0+0/KhuxIS0HDQZl+kInYrQGz6WFoazdgN14W0HfFDt+Z+cUYwGn4TOac94c/eLcTW
         IRaw==
X-Gm-Message-State: AOAM533VTVA7Q8T3zKH6rhOhB4u9TObtJS863sr5zqQQZp0Y5m/lpqIu
        4zYD7RwwQAX0DKic/q2PximpBHYq3wy4Zb+SA4QY8qi7ZCeR1t84hFYsh5Tnp6Uf83KKsGGR+0r
        6ltq0Kg2R5ITqOZPfYKZywPvZzQ==
X-Received: by 2002:ac8:12cd:: with SMTP id b13mr16210978qtj.359.1612208018160;
        Mon, 01 Feb 2021 11:33:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfTW58+3dbzuXbKBkuhRaH+LVveYkhpMgEMODvnwa7Cja8XS427D9KscJhY7tm0nNom/FFcA==
X-Received: by 2002:ac8:12cd:: with SMTP id b13mr16210946qtj.359.1612208017944;
        Mon, 01 Feb 2021 11:33:37 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d3sm12440243qkg.120.2021.02.01.11.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:33:37 -0800 (PST)
Date:   Mon, 1 Feb 2021 14:33:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
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
Subject: Re: [PATCH v3 9/9] userfaultfd/selftests: add test exercising minor
 fault handling
Message-ID: <20210201193334.GH260413@xz-x1>
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-10-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128224819.2651899-10-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 02:48:19PM -0800, Axel Rasmussen wrote:
> Fix a dormant bug in userfaultfd_events_test(), where we did
> `return faulting_process(0)` instead of `exit(faulting_process(0))`.
> This caused the forked process to keep running, trying to execute any
> further test cases after the events test in parallel with the "real"
> process.
> 
> Add a simple test case which exercises minor faults. In short, it does
> the following:
> 
> 1. "Sets up" an area (area_dst) and a second shared mapping to the same
>    underlying pages (area_dst_alias).
> 
> 2. Register one of these areas with userfaultfd, in minor fault mode.
> 
> 3. Start a second thread to handle any minor faults.
> 
> 4. Populate the underlying pages with the non-UFFD-registered side of
>    the mapping. Basically, memset() each page with some arbitrary
>    contents.
> 
> 5. Then, using the UFFD-registered mapping, read all of the page
>    contents, asserting that the contents match expectations (we expect
>    the minor fault handling thread can modify the page contents before
>    resolving the fault).
> 
> The minor fault handling thread, upon receiving an event, flips all the
> bits (~) in that page, just to prove that it can modify it in some
> arbitrary way. Then it issues a UFFDIO_CONTINUE ioctl, to setup the
> mapping and resolve the fault. The reading thread should wake up and see
> this modification.
> 
> Currently the minor fault test is only enabled in hugetlb_shared mode,
> as this is the only configuration the kernel feature supports.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

