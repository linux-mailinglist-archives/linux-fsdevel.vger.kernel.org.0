Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25FA628F64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 02:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiKOBgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 20:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiKOBgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:36:42 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DF814003
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:36:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 13so32734423ejn.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGEQys0q+vn6kmmzyVuQOW7GVEeqdKy9lN8OIJWvOQs=;
        b=PSrB/jmAglnUp28dEPhbOBEDVHtOyET03hzbsVCqEwMkZ54OJlNDXfWBCGnL86RVTW
         gfwfg54OIdAw8qy5SXee3IO1bQ2tBYPOE4X13S4R8eKXqwvTeMzddt8p3/rSyBVx6Fks
         a+4Q9XuWs3mL/JuLZKGdyZMYN38qX34Rk8UYLpFh/ox1Kxns5WRODVykYo6Iye4QVKYy
         XorRzqemDyQsEh+6YJ9/InCSyoknBRZ3egXW4380pxN5HZnUVzggu3nNxPtlV5FD5zed
         maf0oNgfFm4NREuJsoWujUue1x98cStxRmhb4jPVJrzgy+qpWewB3siMSOCHmom7MuwF
         a6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGEQys0q+vn6kmmzyVuQOW7GVEeqdKy9lN8OIJWvOQs=;
        b=eiMcc7HYaKmnKiYU2ORxaLfTscKBHNqjMb0idhTjtdlhLaAwk+7gw9UrgVH7yOdAjw
         NDFVlX+discUGbDb7JcPE7zsaC+saYSe+DcZon6iUCUEI+6bRkDBi7V6nbBB2gYeHxXl
         0oZoM2igHqggSeZI59lpYj/jeIzhGT7AedijZlhYmJ8PfMnETRC0HjAlb/Oy5+XqqfSa
         lrdOlxVlFHVonxOD11ab5RxAMMkMyE5nvQiz9vdzx2G1VJDkkSrq9dpQzI9XzGuFQQSt
         mrliAox1qalY2Q37s6zSGe1NQ6PU5jnKTos70oLH0mpciKQ1/3usPvDs1H6qXfHlS7t6
         fn3g==
X-Gm-Message-State: ANoB5pmNinuSm3MQw0B5iz6w76EH3AfEomOnGPhLi6H2iv1BvvlvXZaB
        B6QYPI+z1mh0A0dgufT96L1X4TpPuhz4ReWkD1acNQ==
X-Google-Smtp-Source: AA0mqf75DC8RdNO+mbVA7o32g73VCYLO9LhY3gD4QBJZqJA7NWCmXX2/B0rhkrxfFyJjRS5YAVI8c3ozjKH3IAVSkWg=
X-Received: by 2002:a17:906:b10d:b0:7a3:fbfa:32e5 with SMTP id
 u13-20020a170906b10d00b007a3fbfa32e5mr12420307ejy.7.1668476199923; Mon, 14
 Nov 2022 17:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20221107184715.3950621-1-pasha.tatashin@soleen.com>
 <e94ac231-7137-010c-2f2b-6a309c941759@redhat.com> <CA+CK2bAbKMj8-crNCtmQ=DB5uRvQBJtFTLf5TH9=RWRGjfOGew@mail.gmail.com>
 <70a8541b-6066-45ca-e2bc-3b7ecc0e7bb2@redhat.com>
In-Reply-To: <70a8541b-6066-45ca-e2bc-3b7ecc0e7bb2@redhat.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 14 Nov 2022 20:36:03 -0500
Message-ID: <CA+CK2bAcoimT74mpQE=sa8fw+eZ5VVrAEkvPsB6=4Z6PKhG5vQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: anonymous shared memory naming
To:     David Hildenbrand <david@redhat.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, hughd@google.com,
        hannes@cmpxchg.org, vincent.whitchurch@axis.com, seanjc@google.com,
        rppt@kernel.org, shy828301@gmail.com, paul.gortmaker@windriver.com,
        peterx@redhat.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        ccross@google.com, willy@infradead.org, arnd@arndb.de,
        cgel.zte@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        bagasdotme@gmail.com, kirill@shutemov.name
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 9, 2022 at 5:11 AM David Hildenbrand <david@redhat.com> wrote:
>
> >>
> >>>     anon_shmem = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> >>>                       MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> >>>     /* Name the segment: "MY-NAME" */
> >>>     rv = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME,
> >>>                anon_shmem, SIZE, "MY-NAME");
> >>>
> >>> cat /proc/<pid>/maps (and smaps):
> >>> 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024 [anon_shmem:MY-NAME]
> >>
> >> What would it have looked like before? Just no additional information?
> >
> > Before:
> >
> > 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024 /dev/zero (deleted)
>
> Can we add that to the patch description?
>
> >>
> >>>
> >>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >>> ---
> >>
> >>
> >> [...]
> >>
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index 8bbcccbc5565..06b6fb3277ab 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -699,8 +699,10 @@ static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
> >>>     * paths in userfault.
> >>>     */
> >>>    bool vma_is_shmem(struct vm_area_struct *vma);
> >>> +bool vma_is_anon_shmem(struct vm_area_struct *vma);
> >>>    #else
> >>>    static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
> >>> +static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false; }
> >>>    #endif
> >>>
> >>>    int vma_is_stack_for_current(struct vm_area_struct *vma);
> >>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> >>> index 500e536796ca..08d8b973fb60 100644
> >>> --- a/include/linux/mm_types.h
> >>> +++ b/include/linux/mm_types.h
> >>> @@ -461,21 +461,11 @@ struct vm_area_struct {
> >>>         * For areas with an address space and backing store,
> >>>         * linkage into the address_space->i_mmap interval tree.
> >>>         *
> >>> -      * For private anonymous mappings, a pointer to a null terminated string
> >>> -      * containing the name given to the vma, or NULL if unnamed.
> >>>         */
> >>> -
> >>> -     union {
> >>> -             struct {
> >>> -                     struct rb_node rb;
> >>> -                     unsigned long rb_subtree_last;
> >>> -             } shared;
> >>> -             /*
> >>> -              * Serialized by mmap_sem. Never use directly because it is
> >>> -              * valid only when vm_file is NULL. Use anon_vma_name instead.
> >>> -              */
> >>> -             struct anon_vma_name *anon_name;
> >>> -     };
> >>> +     struct {
> >>> +             struct rb_node rb;
> >>> +             unsigned long rb_subtree_last;
> >>> +     } shared;
> >>>
> >>
> >> So that effectively grows the size of vm_area_struct. Hm. I'd really
> >> prefer to keep this specific to actual anonymous memory, not extending
> >> it to anonymous files.
> >
> > It grows only when CONFIG_ANON_VMA_NAME=y, otherwise it stays the same
> > as before. Are you suggesting adding another config specifically for
> > shared memory? I wonder if we could add a union for some other part of
> > vm_area_struct where anon and file cannot be used together.
>
> In practice, all distributions will enable CONFIG_ANON_VMA_NAME in the
> long term I guess. So if we could avoid increasing the VMA size, that
> would be great.
>
> >
> >> Do we have any *actual* users where we don't have an alternative? I
> >> doubt that this is really required.
> >>
> >> The simplest approach seems to be to use memfd instead of MAP_SHARED |
> >> MAP_ANONYMOUS. __NR_memfd_create can be passed a name and you get what
> >> you propose here effectively already. Or does anything speak against it?
> >
> > For our use case the above does not work. We are working on highly
> > paravirtualized virtual machines. The VMM maps VM memory as anonymous
> > shared memory (not private because VMM is sandboxed and drivers are
> > running in their own processes). However, the VM tells back to the VMM
> > how parts of the memory are actually used by the guest, how each of
> > the segments should be backed (i.e. 4K pages, 2M pages), and some
> > other information about the segments. The naming allows us to monitor
> > the effective memory footprint for each of these segments from the
> > host without looking inside the guest.
>
> That's a reasonable use case, although naive me would worry about #VMA
> limits etc.
>
> Can you add some condensed use-case explanation to the patch
> description? (IOW, memfd cannot be used because parts of the memfd are
> required to receive distinct names)
>
> I'd appreciate if we could avoid increasing the VMA size; but in any case

I've explored ways not to increase VMA size, but there are no obvious
solutions here. Let's keep it as is for now, and in the future if
there we are going to be adding some fields that are only used by
anonymous memory, we can explore of adding a union for this field.

>
> Acked-by: David Hildenbrand <david@redhat.com>

Thank you. I will soon send a new version with support for memfd anon
memory as well.

Pasha
