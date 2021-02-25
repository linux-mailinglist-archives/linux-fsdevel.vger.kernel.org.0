Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36794325821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 21:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhBYUzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 15:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234676AbhBYUwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614286270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJgpcpz8JbWE9yNjQ8U8bqTTI3MQeUxSjU+A+WBNGno=;
        b=aVrpMO9MZfiSiNqOg6RcwIWEEhjG28i4cE499QQo2pVvM334yo7dt0CeZTFus1ImAP2Kzu
        mzSaPpjKdQe4u167q/QMGnXw6/ncKEFlr7MNeOKXI4m0iSiODgP2L2mC38PBmU2Dv4GwTs
        9HoB51OCiYSZxp52RtnrXNSzgLjBmaU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-w-o-yC3OObyD752jwnEm4A-1; Thu, 25 Feb 2021 15:51:09 -0500
X-MC-Unique: w-o-yC3OObyD752jwnEm4A-1
Received: by mail-qv1-f69.google.com with SMTP id m1so5233410qvp.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 12:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sJgpcpz8JbWE9yNjQ8U8bqTTI3MQeUxSjU+A+WBNGno=;
        b=W1x1oyJm0YAcpAfRDkBUmv72p1zybQocwoO/wP1dENLwT8P/GfMZcB59gUAxeBi2tH
         6B+9xodQI4kFr11tI/pfkKtvFWKoW09fikNa1JDqu+63l6OtoGIv+ywWBz3H46SCxr4/
         ZM2iGdYmOpZa9OCePztMpnm6QzwKhVYrjCxV+OIdjswPredLr0sdJqgT1GDEO+AxMJ5v
         cSDOW5BNebWWCWLt0yw1E14FcZt3tZW2dGU1GE7yoxOFtZ3CfIWdhEHySQPZCmo1yoEK
         hqnAOzvUnPiAB5yc686B68/PySQjIyjyf0D8Sbb6rL8r9b1EJ2QCg74d1kSA9vKYvPOS
         J0Dw==
X-Gm-Message-State: AOAM531Qp5LEE4EjTqFhEOElAslOR8RT+EPfq3Iyw/whSgzWmGCGmQ96
        gXhNcnRf6Wtv5JZR6gURSHvc9eoH51LtJx/Upgg3s+/ymNGCjM3cGY/9PjOl2FvBkHmn60Kr/p1
        AjiW20+Tk1Oo09jRBPfaAt1i8ZQ==
X-Received: by 2002:a37:d247:: with SMTP id f68mr4676746qkj.187.1614286267785;
        Thu, 25 Feb 2021 12:51:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5LhdlJsUL0iIi4gSlu38o06OrkQM2ycT5KFnq+Wy5d0l/uDMC6+YahAOSzJOTlEUPreVofA==
X-Received: by 2002:a37:d247:: with SMTP id f68mr4676721qkj.187.1614286267533;
        Thu, 25 Feb 2021 12:51:07 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id 18sm3820035qkr.77.2021.02.25.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:51:07 -0800 (PST)
Date:   Thu, 25 Feb 2021 15:51:04 -0500
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
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v8 4/6] userfaultfd: add UFFDIO_CONTINUE ioctl
Message-ID: <20210225205104.GA261488@xz-x1>
References: <20210225002658.2021807-1-axelrasmussen@google.com>
 <20210225002658.2021807-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225002658.2021807-5-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 04:26:56PM -0800, Axel Rasmussen wrote:
> This ioctl is how userspace ought to resolve "minor" userfaults. The
> idea is, userspace is notified that a minor fault has occurred. It might
> change the contents of the page using its second non-UFFD mapping, or
> not. Then, it calls UFFDIO_CONTINUE to tell the kernel "I have ensured
> the page contents are correct, carry on setting up the mapping".
> 
> Note that it doesn't make much sense to use UFFDIO_{COPY,ZEROPAGE} for
> MINOR registered VMAs. ZEROPAGE maps the VMA to the zero page; but in
> the minor fault case, we already have some pre-existing underlying page.
> Likewise, UFFDIO_COPY isn't useful if we have a second non-UFFD mapping.
> We'd just use memcpy() or similar instead.
> 
> It turns out hugetlb_mcopy_atomic_pte() already does very close to what
> we want, if an existing page is provided via `struct page **pagep`. We
> already special-case the behavior a bit for the UFFDIO_ZEROPAGE case, so
> just extend that design: add an enum for the three modes of operation,
> and make the small adjustments needed for the MCOPY_ATOMIC_CONTINUE
> case. (Basically, look up the existing page, and avoid adding the
> existing page to the page cache or calling set_page_huge_active() on
> it.)
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

