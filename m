Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F394335A840
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 23:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhDIVSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 17:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234377AbhDIVSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 17:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618003110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LfDPLi5E0po8MV65N/nBXOnSa/U1n1bpGd2B6Y5zrs=;
        b=NRUYHVmUtz8LtV/t20xv8pZinua3Qj27hbFHYz5ZX7bdHw47gkT2zk4hTd7J9nw7x2bQzU
        mlA820Wp7u17ys4+f4YU8IcljoU0yIRra8KbxoS5pJ2scFT4O3DSkZX8eBzKeg8H+H7H4j
        5IxJclONL+pDcpDQ4MxKuMvavfooo0g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-t8BIvbYqMuSzfmFvv8x3vw-1; Fri, 09 Apr 2021 17:18:28 -0400
X-MC-Unique: t8BIvbYqMuSzfmFvv8x3vw-1
Received: by mail-qk1-f199.google.com with SMTP id a1so4144735qkn.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 14:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6LfDPLi5E0po8MV65N/nBXOnSa/U1n1bpGd2B6Y5zrs=;
        b=BxOj5Rxb9zN6PMAv4FKZ+k1WaRyUensL7LgpDlWqk6bceWSLvZVs92rj2pfDEa16rX
         DaIrkiOZERFMgWcxyesjUQYlNBr61NBdD5wkmn3ImL/BOHQYuWw871P0BiANByfwcG5k
         +48+66rk/N+LD9k9ySqu85yG677jpUQk004AoTBQ/DdpzIUfpH1DpczUw3yY26+ZDxX1
         89FErps3M+kzUG4Y9eM9I+gQ3i7df2VAN2cFtCoHQQPdz1LiicbifabaZNYgCYAJxnGi
         MIypDVaqqsgshCedQdOxa0b3KEVUx0/LiC06T2TOsCpNntV/wJTGip2H8tGBOtbVCx2G
         ygcg==
X-Gm-Message-State: AOAM532rSeVjVokPgBlnXBWxyGMs8pKghfSeEElrh8XvgGSr9uWnjRMh
        gPX6+Ou7Z41liGqkU7KJ68MBWKNqQxoyWa9vzYFRcwNUVSGEb5U7e4Ug0XmF/ubPdSQQD9k0g6G
        fJyOK0SQfYLoqXz6tWTR4PbeOmA==
X-Received: by 2002:a05:620a:1369:: with SMTP id d9mr16206715qkl.378.1618003107917;
        Fri, 09 Apr 2021 14:18:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWcW26HNQ/4u/a9UUVswHcCgm4mQgj1l0Ik4tAPemu5I9vnvbu6buq/FCs5OPNi83I6zujbQ==
X-Received: by 2002:a05:620a:1369:: with SMTP id d9mr16206687qkl.378.1618003107587;
        Fri, 09 Apr 2021 14:18:27 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id d68sm2628359qkf.93.2021.04.09.14.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 14:18:26 -0700 (PDT)
Date:   Fri, 9 Apr 2021 17:18:24 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 0/9] userfaultfd: add minor fault handling for shmem
Message-ID: <20210409211824.GH792100@xz-x1>
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408220440.aab59f2f06beb840c22377b3@linux-foundation.org>
 <CAJHvVcj84fcuh0vXtHdEPoV+DrFDSXjUg1fO+oLFCOaxWBH13w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcj84fcuh0vXtHdEPoV+DrFDSXjUg1fO+oLFCOaxWBH13w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 10:03:53AM -0700, Axel Rasmussen wrote:
> On Thu, Apr 8, 2021 at 10:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu,  8 Apr 2021 16:43:18 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > > The idea is that it will apply cleanly to akpm's tree, *replacing* the following
> > > patches (i.e., drop these first, and then apply this series):
> > >
> > > userfaultfd-support-minor-fault-handling-for-shmem.patch
> > > userfaultfd-support-minor-fault-handling-for-shmem-fix.patch
> > > userfaultfd-support-minor-fault-handling-for-shmem-fix-2.patch
> > > userfaultfd-support-minor-fault-handling-for-shmem-fix-3.patch
> > > userfaultfd-support-minor-fault-handling-for-shmem-fix-4.patch
> > > userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
> > > userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
> > > userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
> > > userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch
> >
> > Well.  the problem is,
> >
> > > +     if (area_alias == MAP_FAILED)
> > > +             err("mmap of memfd alias failed");
> >
> > `err' doesn't exist until eleventy patches later, in Peter's
> > "userfaultfd/selftests: unify error handling".  I got tired of (and
> > lost confidence in) replacing "err(...)" with "fprintf(stderr, ...);
> > exit(1)" everywhere then fixing up the fallout when Peter's patch came
> > along.  Shudder.
> 
> Oof - sorry about that!
> 
> >
> > Sorry, all this material pretty clearly isn't going to make 5.12
> > (potentially nine days hence), so I shall drop all the userfaultfd
> > patches.  Let's take a fresh run at all of this after -rc1.
> 
> That's okay, my understanding was already that it certainly wouldn't
> be in the 5.12 release, but that we might be ready in time for 5.13.
> 
> >
> >
> > I have tentatively retained the first series:
> >
> > userfaultfd-add-minor-fault-registration-mode.patch
> > userfaultfd-add-minor-fault-registration-mode-fix.patch
> > userfaultfd-disable-huge-pmd-sharing-for-minor-registered-vmas.patch
> > userfaultfd-hugetlbfs-only-compile-uffd-helpers-if-config-enabled.patch
> > userfaultfd-add-uffdio_continue-ioctl.patch
> > userfaultfd-update-documentation-to-describe-minor-fault-handling.patch
> > userfaultfd-selftests-add-test-exercising-minor-fault-handling.patch
> >
> > but I don't believe they have had much testing standalone, without the
> > other userfaultfd patches present.  So I don't think it's smart to
> > upstream these in this cycle.  Or I could drop them so you and Peter
> > can have a clean shot at redoing the whole thing.  Please let me know.
> 
> From my perspective, both Peter's error handling and the hugetlbfs
> minor faulting patches are ready to go. (Peter's most importantly; we
> should establish that as a base, and put all the burden on resolving
> conflicts with it on us instead of you :).)
> 
> My memory was that Peter's patch was applied before my shmem series,
> but it seems I was mistaken. So, maybe the best thing to do is to have
> Peter send a version of it based on your tree, without the shmem
> series? And then I'll resolve any conflicts in my tree?
> 
> It's true that we haven't tested the hugetlbfs minor faults patch
> extensively *with the shmem one also applied*, but it has had more
> thorough review than the shmem one at this point (e.g. by Mike
> Kravetz), and they're rather separate code paths (I'd be surprised if
> one breaks the other).

Yes I think the hugetlb part should have got more review done.  IMHO it's a
matter of whether Mike would still like to do a more thorough review, or seems
okay to keep them.

I can repost the selftest series later if needed, as long as I figured which is
the suitable base commit.  Those selftest patches are definitely not urgent for
this release, so we can wait for the next release.

Thanks,

-- 
Peter Xu

