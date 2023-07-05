Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3674890D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjGEQQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjGEQQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CDC1703
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688573726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41PfzToKq/ZuIyZbmkk75ijXjF0S6iwGioZqQv3YYas=;
        b=WvPEzUC3lj1tQOlUj9N/wJLicQhC5OzYowVlGfmvsnNbqIXFsF3WjhHi49t9lJkx822mxc
        QMoC4cYOM0aGYjQJEdO7X6FlywRjNuBQ5c/SnCzNp0TAGqr97T6zU+n6z7A/eD/6g9tU0r
        eRwJHE22oO0qTwQsQbPEoVehlC/RXP8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-3m9U53v4NEauPjj2VZYmNg-1; Wed, 05 Jul 2023 12:15:25 -0400
X-MC-Unique: 3m9U53v4NEauPjj2VZYmNg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-401e1fc831fso10145431cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 09:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688573725; x=1691165725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41PfzToKq/ZuIyZbmkk75ijXjF0S6iwGioZqQv3YYas=;
        b=K3blINyiMvlcUbCgLPfxX6aHsdsO8dvF5z/E+U4PUC++FW5enX8V5d/mJBdmYJKSIe
         aTEhPNuAbdP1k1cI/lkfrP++Gajm8uy2nFTP0OA42kc2U/sE6HJrlWg7KTf9onSdSu8W
         jsYcicyhN5FHtvByiF7vWB7bcvEmbCJnMGqMJplbdQ+wE7dqy5r2h2py6qFjRMN+DPxc
         e6xQ4r+vNWUD9VT4mZmSy7O4eKzCW5mBijjBeavACAiwPb/uwtV3xdywhxLD8r1OE6x/
         AbRWTG2mBWB3ghtHgZAIJwtlZOyENRXDuGrMdEMWjxslkwJdPTd7uwZoMQsOxVi2eNn2
         bFlQ==
X-Gm-Message-State: AC+VfDyPtwy7BZh6SetUlOixgaGOLe0XGE8k4dLJHxPoh4lpRZf/E+/S
        4I1w0Bh2/b41VrN1Ym1RUkxB8yWsee1BSVM67wMMvUeLBMJVO7+qY9jl4WLU7rpDJen9Wi1u5kG
        t6COKS7BGB6AILuLqEkhmsbQEJA==
X-Received: by 2002:a05:622a:1308:b0:403:28e3:8ab7 with SMTP id v8-20020a05622a130800b0040328e38ab7mr22343562qtk.5.1688573724888;
        Wed, 05 Jul 2023 09:15:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4yBoNCHR9da42kEmUepXtWH/uy0qhFWUMq3XZYbfp+4KgDzX7xEj2WTC/YgjKg5UtSOPzSvA==
X-Received: by 2002:a05:622a:1308:b0:403:28e3:8ab7 with SMTP id v8-20020a05622a130800b0040328e38ab7mr22343534qtk.5.1688573724597;
        Wed, 05 Jul 2023 09:15:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id e16-20020ac80110000000b0040346ce43a5sm6442576qtg.44.2023.07.05.09.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:15:24 -0700 (PDT)
Date:   Wed, 5 Jul 2023 12:15:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm: userfaultfd: add new UFFDIO_POISON ioctl
Message-ID: <ZKWXGnSKcOdnaeJw@x1n>
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <ZKSDLogLASaZgKCP@x1n>
 <CADrL8HXp-P44VxTXdJMkzSgPC8r_b0T21_cuPCTNy6Ub2PFBKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HXp-P44VxTXdJMkzSgPC8r_b0T21_cuPCTNy6Ub2PFBKA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 05, 2023 at 09:09:19AM -0700, James Houghton wrote:
> > > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > > index 4c932cb45e0b..8259fee32421 100644
> > > --- a/include/linux/swapops.h
> > > +++ b/include/linux/swapops.h
> > > @@ -394,7 +394,8 @@ typedef unsigned long pte_marker;
> > >
> > >  #define  PTE_MARKER_UFFD_WP                  BIT(0)
> > >  #define  PTE_MARKER_SWAPIN_ERROR             BIT(1)
> > > -#define  PTE_MARKER_MASK                     (BIT(2) - 1)
> > > +#define  PTE_MARKER_UFFD_POISON                      BIT(2)
> >
> > One more tab.
> >
> > Though I remembered the last time we discussed IIRC we plan to rename
> > SWAPIN_ERROR and reuse it, could you explain why a new bit is still needed?
> >
> > I think I commented this but I'll do it again: IIUC any existing host
> > swapin errors for guest pages should be reported as MCE too, afaict,
> > happened in kvm context.
> 
> I think swapin errors are treated differently than poison. Swapin
> errors get VM_FAULT_SIGBUS, and poison gets VM_FAULT_HWPOISON, so
> UFFDIO_POISON should also get VM_FAULT_HWPOISON (so that's what Axel
> has implemented). And I think that needs a separate PTE marker.

My question was, should we also make SWAPIN_ERROR return VM_FAULT_HWPOISON
always?

Just to recap from what I already commented above - if a guest page got
error in swapin due to block sector failures, it should be treated as
VM_FAULT_HWPOISON too, IMHO.  IOW, I think current SWAPIN_ERROR is wrong
when in kvm context and we should fix it first.

> 
> >
> > > +#define  PTE_MARKER_MASK                     (BIT(3) - 1)
> > >
> > >  static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> > >  {
> > > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > > index ac7b0c96d351..ac8c6854097c 100644
> > > --- a/include/linux/userfaultfd_k.h
> > > +++ b/include/linux/userfaultfd_k.h
> > > @@ -46,6 +46,7 @@ enum mfill_atomic_mode {
> > >       MFILL_ATOMIC_COPY,
> > >       MFILL_ATOMIC_ZEROPAGE,
> > >       MFILL_ATOMIC_CONTINUE,
> > > +     MFILL_ATOMIC_POISON,
> > >       NR_MFILL_ATOMIC_MODES,
> > >  };
> > >
> > > @@ -83,6 +84,9 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
> > >  extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
> > >                                    unsigned long len, atomic_t *mmap_changing,
> > >                                    uffd_flags_t flags);
> > > +extern ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
> > > +                                unsigned long len, atomic_t *mmap_changing,
> > > +                                uffd_flags_t flags);
> > >  extern int mwriteprotect_range(struct mm_struct *dst_mm,
> > >                              unsigned long start, unsigned long len,
> > >                              bool enable_wp, atomic_t *mmap_changing);
> > > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> > > index 66dd4cd277bd..62151706c5a3 100644
> > > --- a/include/uapi/linux/userfaultfd.h
> > > +++ b/include/uapi/linux/userfaultfd.h
> > > @@ -39,7 +39,8 @@
> > >                          UFFD_FEATURE_MINOR_SHMEM |           \
> > >                          UFFD_FEATURE_EXACT_ADDRESS |         \
> > >                          UFFD_FEATURE_WP_HUGETLBFS_SHMEM |    \
> > > -                        UFFD_FEATURE_WP_UNPOPULATED)
> > > +                        UFFD_FEATURE_WP_UNPOPULATED |        \
> > > +                        UFFD_FEATURE_POISON)
> > >  #define UFFD_API_IOCTLS                              \
> > >       ((__u64)1 << _UFFDIO_REGISTER |         \
> > >        (__u64)1 << _UFFDIO_UNREGISTER |       \
> > > @@ -49,12 +50,14 @@
> > >        (__u64)1 << _UFFDIO_COPY |             \
> > >        (__u64)1 << _UFFDIO_ZEROPAGE |         \
> > >        (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> > > -      (__u64)1 << _UFFDIO_CONTINUE)
> > > +      (__u64)1 << _UFFDIO_CONTINUE |         \
> > > +      (__u64)1 << _UFFDIO_POISON)
> > >  #define UFFD_API_RANGE_IOCTLS_BASIC          \
> > >       ((__u64)1 << _UFFDIO_WAKE |             \
> > >        (__u64)1 << _UFFDIO_COPY |             \
> > > +      (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> > >        (__u64)1 << _UFFDIO_CONTINUE |         \
> > > -      (__u64)1 << _UFFDIO_WRITEPROTECT)
> > > +      (__u64)1 << _UFFDIO_POISON)
> >
> > May not be a large deal, but it's still better to declare the feature &
> > ioctls after all things implemented.  Maybe make these few lines
> > (UFFD_API*, and the new feature bit) as the last patch to enable the
> > feature?
> 
> I agree. Another option would be to have a separate feature for
> UFFDIO_POISON for hugetlb, but I don't think we should do that. :)

Yeah let's make the features "memory-type-free" if possible. :)

Thanks,

-- 
Peter Xu

