Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94AA30B2AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 23:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBAWS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 17:18:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhBAWS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612217819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmN+agXqiROkkYz5Om/OjbH0Pxuwyb0SEcLP3k/Y+SI=;
        b=VsqAu0sSesPxo2FxXRQMunX7YJeMcbKX4Ozqk1gGog6dbYXqYZvg6K+oLFWh7RwL2UCkQl
        fxCR9zt7nZqi28ADR9Orawz2z7ScziRtKyE5RhrqDxUI4vXOmZfjvrsuzdkChCuxIbsqj4
        Iw69Nmqc/rC9sFi9uwKBkbsqnkERUBk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-ecR_2NJoNdmiqL5NGe-P7Q-1; Mon, 01 Feb 2021 17:16:58 -0500
X-MC-Unique: ecR_2NJoNdmiqL5NGe-P7Q-1
Received: by mail-qt1-f198.google.com with SMTP id k90so11658273qte.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 14:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xmN+agXqiROkkYz5Om/OjbH0Pxuwyb0SEcLP3k/Y+SI=;
        b=TR2Gs4Dls3u04KW0bC3+LY/7/HN78nI6yQUc9KQHFUWBiQlRpjqsunca5VRCvxVs45
         RhVYLOGHF627rTjp0W9xfsBhf71n3ee7WER6XtflIRqy4idTYtS3yz3Y3BlmmFBHkDXf
         dAEP/hQDuSUEXYQ5v8lkMaXW2AeIt4xPlrd7vKwr3nC6AkIujQKH7fF3MGZgrFs/fCP1
         K4gXQVbEnL68lyym8dWJZO2QuTwVPotlHMOwAdQTh7thp6k9LU6pRd0iv2UwrMv5XVOu
         zF2/XVe9dvvmoLGPeVJPi6A7smSGF3JR8xk5hHiB6q1DDqb/cajPmqskXYGz/JHJJWM+
         JfPQ==
X-Gm-Message-State: AOAM530TYDrNEaUTPHfYa5mqTMzRrJeevJmBQUbjybMP7QEQ/q94YOHR
        vYwT/8hO45fOz9QBIB7VD2j53EgT3zcRyIXZ/uwqumWMSHJjqX6r1h8BIsMEmE6lwTMw1slhWMT
        UGEs+8NpjAgSOu0TfhdPVuedL2A==
X-Received: by 2002:a37:8fc3:: with SMTP id r186mr18916811qkd.253.1612217817875;
        Mon, 01 Feb 2021 14:16:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycp08TqePZIDEQY1l41O7S1IZiWlSToWvexBdN5xDvx00e6QmbaZ+OIJcb0uui1HUWN1gXZA==
X-Received: by 2002:a37:8fc3:: with SMTP id r186mr18916780qkd.253.1612217817592;
        Mon, 01 Feb 2021 14:16:57 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id m202sm2009463qke.24.2021.02.01.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:16:56 -0800 (PST)
Date:   Mon, 1 Feb 2021 17:16:54 -0500
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
Subject: Re: [PATCH v4 1/9] hugetlb: Pass vma into huge_pte_alloc()
Message-ID: <20210201221654.GJ260413@xz-x1>
References: <20210128224819.2651899-2-axelrasmussen@google.com>
 <20210128234242.2677079-1-axelrasmussen@google.com>
 <67fc15f3-3182-206b-451b-1622f6657092@oracle.com>
 <f1afa616-c4f5-daaa-6865-8bbc3c93b71a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1afa616-c4f5-daaa-6865-8bbc3c93b71a@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 01, 2021 at 01:53:14PM -0800, Mike Kravetz wrote:
> On 2/1/21 1:38 PM, Mike Kravetz wrote:
> > On 1/28/21 3:42 PM, Axel Rasmussen wrote:
> >> From: Peter Xu <peterx@redhat.com>
> >>
> >> It is a preparation work to be able to behave differently in the per
> >> architecture huge_pte_alloc() according to different VMA attributes.
> >>
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> [axelrasmussen@google.com: fixed typo in arch/mips/mm/hugetlbpage.c]
> >> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> >> ---
> >>  arch/arm64/mm/hugetlbpage.c   | 2 +-
> >>  arch/ia64/mm/hugetlbpage.c    | 3 ++-
> >>  arch/mips/mm/hugetlbpage.c    | 4 ++--
> >>  arch/parisc/mm/hugetlbpage.c  | 2 +-
> >>  arch/powerpc/mm/hugetlbpage.c | 3 ++-
> >>  arch/s390/mm/hugetlbpage.c    | 2 +-
> >>  arch/sh/mm/hugetlbpage.c      | 2 +-
> >>  arch/sparc/mm/hugetlbpage.c   | 2 +-
> >>  include/linux/hugetlb.h       | 2 +-
> >>  mm/hugetlb.c                  | 6 +++---
> >>  mm/userfaultfd.c              | 2 +-
> >>  11 files changed, 16 insertions(+), 14 deletions(-)
> > 
> > Sorry for the delay in reviewing.
> > 
> > huge_pmd_share() will do a find_vma() to get the vma.  So, it would be
> > 'possible' to not add an extra argument to huge_pmd_alloc() and simply
> > do the uffd_disable_huge_pmd_share() check inside vma_shareable.  This
> > would reduce the amount of modified code, but would not be as efficient.
> > I prefer passing the vma argument as is done here.
> > 
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> 
> Another thought.
> 
> We should pass the vma to huge_pmd_share to avoid the find_vma.

Agreed.  Seems not relevant to this series, but should be a very nice add-on
after this patch can land.  Thanks,

-- 
Peter Xu

