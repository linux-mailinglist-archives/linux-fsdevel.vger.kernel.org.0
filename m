Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05F331A82B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 00:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhBLXDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 18:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231946AbhBLXDI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613170901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KrxNhkpJSkLcCNjs8YiuV+FXOAKe3IRMAr5lF3Khj2o=;
        b=Glh/4JYfzTWlZrJrHlO1UjDMlkTr2c35HppcdUgWQjYBqyg1Yeg1R37tzQxoXF1/JnZl0B
        OdAie1SLcZCe3VRJI9SPwDUCsgcgSGCFdaXaM0OL1oidcujg/POz0/774kdGZRYyrfzH++
        lLkTuW/SBE/jehlTbOgXKWDWPuqOxas=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-v7miAmo5Ot2VUv2DEZWdJA-1; Fri, 12 Feb 2021 18:01:40 -0500
X-MC-Unique: v7miAmo5Ot2VUv2DEZWdJA-1
Received: by mail-qk1-f199.google.com with SMTP id 124so839228qkg.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 15:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrxNhkpJSkLcCNjs8YiuV+FXOAKe3IRMAr5lF3Khj2o=;
        b=nwj6Ov3KAuHV5dFEj9MhhacbOV0zzaPBFLY76Nl2HU5tJzqMjnZ1tA68T0X2DJvzH5
         H9ShassvjFoLgPDNev0itOjZ9NyKUqXcmFYjIwpRtM54Osiyaq9bSb3ERr4xYd31euD7
         qALH/YUlhN95F1A9wiNqpjrbSuQy9BTtJnmyUMG0GLNhNjsB7GXOKgjvEUOUOK+XKin6
         XPXKqSJLDO/azzmzCmWlhWdvdmZyHq71hbXHJ7j9HC8kn7XCyC/dw97VPiZo3u2aLy60
         AzcvzccBTQVtJ15QCxcBseSyU7yRwzsVgha9neXX2JvTL/vh8s6+fo7k8TUtOLcE22Q5
         QDFg==
X-Gm-Message-State: AOAM533uT5SsacZnL1tVzFgGF4XnqN9NSbMFqoAUKiwByIFsLZXgTPdE
        RX/Sp/9PlJAP17n+inyqHIRuvQB4GnWwOhSqGNEmhXtogRiUl+DkMjDAhrpxdT7FF/NSC88zEZy
        48BWeNTSVcqUEstTKvdZmIPWuvg==
X-Received: by 2002:a37:b2c4:: with SMTP id b187mr4905954qkf.153.1613170899918;
        Fri, 12 Feb 2021 15:01:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdr8KiYQo4/t+/dJmGbq34GKsvGbDSKjWg6u+rkPUHgRLm4huopjrCOovHivyHFM/is1qJtg==
X-Received: by 2002:a37:b2c4:: with SMTP id b187mr4905922qkf.153.1613170899689;
        Fri, 12 Feb 2021 15:01:39 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id f188sm7242711qkj.110.2021.02.12.15.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 15:01:39 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:01:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 05/10] userfaultfd: add minor fault registration mode
Message-ID: <20210212230136.GG3171@xz-x1>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-6-axelrasmussen@google.com>
 <CAJHvVch8jmqu=Hi9=1CHzPHJfZCRvSb6g7xngSBDQ_nDfSj-gA@mail.gmail.com>
 <20210212222145.GB2858050@casper.infradead.org>
 <20210212224405.GF3171@xz-x1>
 <CAJHvVcgiD5OwFVK0Mgy-XDxM2PGCLkOJSCLLSF2Z8bYrf5BTJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcgiD5OwFVK0Mgy-XDxM2PGCLkOJSCLLSF2Z8bYrf5BTJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:51:17PM -0800, Axel Rasmussen wrote:
> On Fri, Feb 12, 2021 at 2:44 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Feb 12, 2021 at 10:21:45PM +0000, Matthew Wilcox wrote:
> > > On Thu, Feb 11, 2021 at 11:28:09AM -0800, Axel Rasmussen wrote:
> > > > Ah, I had added this just after VM_UFFD_WP, without noticing that this
> > > > would be sharing a bit with VM_LOCKED. That seems like not such a
> > > > great idea.
> > > >
> > > > I don't see another unused bit, and I don't see some other obvious
> > > > candidate to share with. So, the solution that comes to mind is
> > >
> > > it'd be even better if you didn't use the last unused bit for UFFD_WP.
> > > not sure how feasible that is, but you can see we're really short on
> > > bits here.
> >
> > UFFD_WP is used now for anonymouse already.. And the support for hugetlbfs and
> > shmem is in rfc stage on the list.
> >
> > Is it possible to use CONFIG_ARCH_USES_HIGH_VMA_FLAGS here?  So far uffd-wp is
> > only working for 64 bit x86 too due to enlarged pte space.  Maybe we can also
> > let minor mode to only support 64 bit hosts.
> 
> At least for my / Google's purposes, I don't care about 32-bit support
> for this feature. I do care about both x86_64 and arm64, though. So
> it's a possibility.
> 
> Alternatively, the "it's an API feature not a registration mode"
> approach I sent in my v6 also works for me, although it has some
> drawbacks.

Per-vma has finer granularity and logically more flexible.  If it's low hanging
fruit, let's think about it more before giving up so quickly.

Sorry I commented late for this - I got diverged a bit in the past days.  While
you worked on it so fast (which in many cases still a good thing :).

> 
> Another option is, would it be terrible to add an extra u16 or u32 for
> UFFD flags to vm_area_struct (say within vm_userfaultfd_ctx)?
> Historically we've already added a pointer, so maybe an extra say 16
> bits isn't so bad? This would avoid using *any* VM_* flags for UFFD,
> even VM_UFFD_MISSING could be in this new flag field.

For 64bit hosts there're still places for vm_flags.  It's just 32bit, while
there's option to make it 64bit-only.  Even if we'd add a new field, those bits
were still unused on 64bit hosts.  IMHO we should try to use them before adding
new field which will actually impact all hosts.

Thanks,

-- 
Peter Xu

