Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613D22FF813
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 23:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbhAUWim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 17:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbhAUWik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611268630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9F4FJm6CxPIzCDPXLeRl1F1UfXVZJLDgPR0BedATtNQ=;
        b=WvI0jJGWbDR71kyxqxL2An+ohd+4t40Vi0PjaNr354TaDAWAB0V2xB2jniEbQxNJ9ZzQzF
        kqSjSqYaOsQBRFVo2aeQSsjDgL6yNtF4nbrClbucHj5nK8zkdRGKfTNNvuee+4qCaAnqTa
        vNFarP7XQ6CQgOAJOEcjRJ5XJnVjTMw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-04Bu4nzbNMa1MjU6DqsTrQ-1; Thu, 21 Jan 2021 17:37:07 -0500
X-MC-Unique: 04Bu4nzbNMa1MjU6DqsTrQ-1
Received: by mail-qv1-f70.google.com with SMTP id dj13so1495154qvb.20
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 14:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9F4FJm6CxPIzCDPXLeRl1F1UfXVZJLDgPR0BedATtNQ=;
        b=cABEHyppjXWYxtdRcwT7c3waBNC2On4OmbrImpivOhx8T7GGitO67/dMbrgsfdnQvY
         X7rxcooCGZY7MSXfrp3Y/qoc8tNJ6keOg43KUBNdldFWkdIJ7H7PoZKsJtOvWg8ARLz+
         FgXOFg5+F+iEK7bsSc0TNMZCdWkxtJ7/vE75QAqVs2qci8BLBRZ0lzqi6Ie+eXVtiG39
         3GKktgu4PAZnblwUAek6GjKzM2XG0N/Q2IbGbhi9PMAyF3WTkeP6uzaw6Ry6xQ56B7AB
         vM4duCM11Wyn+Gdu9TaOT4EEu8aAFjqij3Y8pOzAaIafxFNJUcPPo4nUKCPjbb1e61HR
         iH7g==
X-Gm-Message-State: AOAM533PdUtjiR5OP7cAOM+FTSYpkdrRzbbrYN/QRc7OOBeZwGB+iWOA
        6FgKbul4OMsh0tmwcr1qe9mXiU6ivBrdDaG9O9vR92qRfA+i+rve/MqRqo3P7EtO3nTYHqcX3sx
        aUlaqxHP3ZmyOM5d9TvEtFicKjQ==
X-Received: by 2002:ac8:7a82:: with SMTP id x2mr1902822qtr.20.1611268626717;
        Thu, 21 Jan 2021 14:37:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzF3+w++uI/FnvKRDlQcHOvwzcsjyp5Q8slh4ec0gAIH6IQXOf+SKAUhSC7Vg50ypEzJuOuDQ==
X-Received: by 2002:ac8:7a82:: with SMTP id x2mr1902784qtr.20.1611268626438;
        Thu, 21 Jan 2021 14:37:06 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id 203sm4955384qkd.81.2021.01.21.14.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 14:37:05 -0800 (PST)
Date:   Thu, 21 Jan 2021 17:37:03 -0500
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
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 0/9] userfaultfd: add minor fault handling
Message-ID: <20210121223703.GH260413@xz-x1>
References: <20210115190451.3135416-1-axelrasmussen@google.com>
 <20210121191241.GG260413@xz-x1>
 <CAJHvVch3iK_UcwpwL5p3LWQAZo_iyLMVxsMTf_GCAStqoQxmTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVch3iK_UcwpwL5p3LWQAZo_iyLMVxsMTf_GCAStqoQxmTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:13:50PM -0800, Axel Rasmussen wrote:
> When I wrote this, my thinking was that users of this feature would
> have two mappings, one of which is not UFFD registered at all. So, to
> replace the existing page contents, userspace would just write to the
> non-UFFD mapping (with memcpy() or whatever else, or we could get
> fancy and imagine using some RDMA technology to copy the page over the
> network from the live migration source directly in place). After
> performing the write, we just UFFDIO_CONTINUE.
> 
> I believe FALLOC_FL_PUNCH_HOLE / MADV_REMOVE doesn't work with
> hugetlbfs? Once shmem support is implemented, I would expect
> FALLOC_FL_PUNCH_HOLE + UFFDIO_COPY to work, but I wonder if such an
> operation would be more expensive than just copying using the other
> side of the shared mapping?

IIUC hugetlb supports that (hugetlbfs_punch_hole()).  But I agree with you on
what you said should be good enough.  Thanks,

-- 
Peter Xu

