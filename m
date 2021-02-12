Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAC31A761
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 23:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBLWPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 17:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhBLWPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613168049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NM6XT65mv4VcavdfmwjtH1q2UKP+BPnEnoXWk6zcyFs=;
        b=fjDL4pBJmagNRv3l29WRE0SMOyeH5hM9v9ijuuZv3a0EyJodeRtPtJ2ZD++OJ6dtNH1FD+
        6bVSCR2HmkNaxNOLVIsbf9eDVgCKLssbgjS+r4VSplbURuhah9ISqKx4xadnbcXc36CVoh
        HqJ5aHAbLaCcwFbWuexaEleE7Dd75Tc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-vnPBqCfgOlOkjlT2idF7Rw-1; Fri, 12 Feb 2021 17:14:07 -0500
X-MC-Unique: vnPBqCfgOlOkjlT2idF7Rw-1
Received: by mail-qk1-f197.google.com with SMTP id z19so759822qki.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 14:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NM6XT65mv4VcavdfmwjtH1q2UKP+BPnEnoXWk6zcyFs=;
        b=pf2FboC/thNnsEDNSUkBHD747b4VEAipT9JrDzuZgdnItp2sw6/HUHOYCMuHUC0Dss
         JZpzQDCbokmsmTwNon8di8+ptJNKBAjgRx/LEZVxRGy0sMAoYMS6fZlZA0cjPdwSp0FV
         d61o9/TkzBoE0EJtAoU6hgLhDkTI+T8Sa8ht+i1nTxVyD4NYXYkOw5DqMy+UHU/2ELvn
         gIxIWbi3G3lQMO8h+AlR5xj5E6/lncZpw0nFNo1maMIrBsTIF/VpRJ6EF/xr6RLdkx9u
         +xGRXoo0iPIMznV23nq0KLxx7lQ2mc6kFuFFlxNNsQqyZFeIUrSOVBWkZttYujKBpHnV
         +8Hg==
X-Gm-Message-State: AOAM532wskReHwqc9lPzAlPZ4+rBUWIkMmwuE9GbCDnUlfnS7JIlZvee
        +VdMOQYF2dtIx0bAWnA+LNEgykDiqHVMU2VFm0H6MpiE0Lt4xyCixUYtpbfN9fgKh2UMjpD8KGN
        m257VXgnMt2tseqm8C7jRcfF0eQ==
X-Received: by 2002:a05:620a:6d0:: with SMTP id 16mr4645210qky.335.1613168047024;
        Fri, 12 Feb 2021 14:14:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybRSOjiYGjU1WMov5+xWuEznSoVTMv4b/Sz5l/l/d/2YmGS2gMcMRRnE4elHcSTnBXvTjm4A==
X-Received: by 2002:a05:620a:6d0:: with SMTP id 16mr4645162qky.335.1613168046774;
        Fri, 12 Feb 2021 14:14:06 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id p16sm6558793qtq.24.2021.02.12.14.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 14:14:06 -0800 (PST)
Date:   Fri, 12 Feb 2021 17:14:04 -0500
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
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 04/10] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
Message-ID: <20210212221404.GE3171@xz-x1>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-5-axelrasmussen@google.com>
 <517f3477-cb80-6dc9-bda0-b147dea68f95@oracle.com>
 <20210212211856.GD3171@xz-x1>
 <a32b5427-0560-fa24-450c-376c427dd166@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a32b5427-0560-fa24-450c-376c427dd166@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 01:34:03PM -0800, Mike Kravetz wrote:
> I'm good with the new MMU_NOTIFY_HUGETLB_UNSHARE and agree with your reasoning
> for adding it.  I really did not know enough about usage which caused me to
> question.

It actually is a good question..  Because after a 2nd thought I cannot think of
any mmu notifier usage to explicitly listen to huge pmd unshare event - it
could be just a too internal impl detail of hugetlbfs.  I think any new flag
should justify itself when introduced.  Before I could justify it, I think
MMU_NOTIFIER_CLEAR is indeed more suitable.

Thanks,

-- 
Peter Xu

