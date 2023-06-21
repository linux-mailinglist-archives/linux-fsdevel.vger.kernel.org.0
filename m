Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C28B737E6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjFUJC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjFUJBy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:01:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8633C1BC6
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:01:28 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-763a2e46992so267589785a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687338087; x=1689930087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GggaCXOFg4z+F5xlvFzI/hjEnVVezaR8FCxhsY4X+4k=;
        b=YAkAPnxt6pZOgcUU5gErX3sbI43Adc76e+9dsxfRuvvo+hzThnkDKhy0joF+qo8LKM
         HkRf3+n40noWJYMgW83bd7IvUDZ/poWHNY3Jx1Z0KKe+uvulO3QyNs4xo6HTDMH2hPXm
         mEyTVrzeHNyELzHfZu0pENPirl89gRQWJHsWmtgLETtVwCs3WFG3VOYxDKL6+/p0L57u
         Ed6oukufenkRQxhbsbLj97fBL8/GHe0TLHzpbnHYFmrrtWgSp8ZZC8fJiJiVaSIZwngJ
         fGzr6DoZWgbSFyEfbfo7ZEqzCzJckfia6djl5Sxaxenl3VRUwlMPCMrLTnNH2Z7mADxU
         oCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687338087; x=1689930087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GggaCXOFg4z+F5xlvFzI/hjEnVVezaR8FCxhsY4X+4k=;
        b=GulE//sfVvC7FrDDZZSZ/PMqqsiRlYVbXhFLszDzKALp6VJSbKX1KB2Ec3wkUe7Z0R
         a+FpxPjnNCqD2VKJi48eVUf4vFA+lmushRXtbo64sDlirtahV6H790valJBPWouY2Q6/
         MmutSwvNYP4JUFwmzlOlOC+jtupj/2ENOCcsrP+MtZ3EN4xeeCLl7NXhEdb9EIxP6iRE
         aTOOVsxo9LbEVhpqPmdoxhdA2CggtTqz+VJN8dQPtWgBR4ncaVyAwpxAM6GOt5C2lp89
         45t3kWUJDj+FnKQP97bGzCnqFk4Y79ATlz7dL3fQhF8OobObHHVYDshC0gystmWuCGUI
         ZlMQ==
X-Gm-Message-State: AC+VfDxI3YlI174mNKnCxqjhU2TW8XbISRiPB8Xp2x7jI/7fcDqsWXfl
        U0NVd4YLe2oPSkWLf7T3zJCllAQPxlXp9RNxJ7aKSA==
X-Google-Smtp-Source: ACHHUZ67nqRlyPSAmJAdYAQRecAssNEK0bXaPkvdoVklsOrLI7I63am8sKR0bbgFoaWyaJf4gLP9WVi33cBGzMyYMr0=
X-Received: by 2002:a05:6214:1c87:b0:628:8185:bd6e with SMTP id
 ib7-20020a0562141c8700b006288185bd6emr6847558qvb.5.1687338087414; Wed, 21 Jun
 2023 02:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com> <20230616182815.GA7371@monkey>
In-Reply-To: <20230616182815.GA7371@monkey>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Wed, 21 Jun 2023 02:01:16 -0700
Message-ID: <CAGtprH9OJpj_iUbgjVSjCnqqpWt3XiMT6Xg5PtywEf9b-iF-1A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] hugetlb support for KVM guest_mem
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Ackerley Tng <ackerleytng@google.com>, akpm@linux-foundation.org,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org, brauner@kernel.org,
        chao.p.peng@linux.intel.com, coltonlewis@google.com,
        david@redhat.com, dhildenb@redhat.com, dmatlack@google.com,
        erdemaktas@google.com, hughd@google.com, isaku.yamahata@gmail.com,
        jarkko@kernel.org, jmattson@google.com, joro@8bytes.org,
        jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vbabka@suse.cz,
        vipinsh@google.com, vkuznets@redhat.com, wei.w.wang@intel.com,
        yu.c.zhang@linux.intel.com, kvm@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:28=E2=80=AFAM Mike Kravetz <mike.kravetz@oracle.=
com> wrote:
>
> On 06/06/23 19:03, Ackerley Tng wrote:
> > Hello,
> >
> > This patchset builds upon a soon-to-be-published WIP patchset that Sean
> > published at https://github.com/sean-jc/linux/tree/x86/kvm_gmem_solo, m=
entioned
> > at [1].
> >
> > The tree can be found at:
> > https://github.com/googleprodkernel/linux-cc/tree/gmem-hugetlb-rfc-v1
> >
> > In this patchset, hugetlb support for KVM's guest_mem (aka gmem) is int=
roduced,
> > allowing VM private memory (for confidential computing) to be backed by=
 hugetlb
> > pages.
> >
> > guest_mem provides userspace with a handle, with which userspace can al=
locate
> > and deallocate memory for confidential VMs without mapping the memory i=
nto
> > userspace.
>
> Hello Ackerley,
>
> I am not sure if you are aware or, have been following the hugetlb HGM
> discussion in this thread:
> https://lore.kernel.org/linux-mm/20230306191944.GA15773@monkey/
>
> There we are trying to decide if HGM should be added to hugetlb, or if
> perhaps a new filesystem/driver/allocator should be created.  The concern
> is added complexity to hugetlb as well as core mm special casing.  Note
> that HGM is addressing issues faced by existing hugetlb users.
>
> Your proposal here suggests modifying hugetlb so that it can be used in
> a new way (use case) by KVM's guest_mem.  As such it really seems like
> something that should be done in a separate filesystem/driver/allocator.
> You will likely not get much support for modifying hugetlb.
>
> --
> Mike Kravetz
>

IIUC mm/hugetlb.c implements memory manager for Hugetlb pages and
fd/hugetlbfs/inode.c implements the filesystem logic for hugetlbfs.

This series implements a new filesystem with limited operations
parallel to hugetlbfs filesystem but tries to reuse hugetlb memory
manager. The effort here is to not add any new feature to hugetlb
memory manager but clean it up so that it can be used by a new
filesystem.

guest_mem warrants a new filesystem since it supports limited
operations on the underlying files but there is no additional
restriction on underlying memory management. Though one could argue
that memory management for guest_mem files can be a very simple one
that goes inline with limited operations on the files.

If this series were to go a separate way of implementing a new memory
manager, one immediate requirement that might spring up, would be to
convert memory from hugetlb managed memory to be managed by this newly
introduced memory manager and vice a versa at runtime since there
could be a mix of VMs on the same platform using guest_mem and
hugetlb.
Maybe this can be satisfied by having a separate global pool for
reservation that's consumed by both, which would need more changes in
my understanding.

Using guest_mem for all the VMs by default would be a future work
contingent on all existing usecases/requirements being satisfied.

Regards,
Vishal
