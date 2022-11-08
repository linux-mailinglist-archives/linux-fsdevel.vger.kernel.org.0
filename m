Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96DF621C63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 19:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiKHSr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 13:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKHSrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:47:25 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8269959FD2
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 10:45:45 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k2so41013511ejr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Nov 2022 10:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34xmTXahX9JOxAWp+niqcaXhO5EjSMmbu9kacIdY9GA=;
        b=Q7EEEYcV7XltPOfTeY+7k0wa4jo3dxm2gU1pfbspEfsVW158MhXaCQ2w7LENlv2KFN
         gbETXxIpwN02DzJ3Dmrp5CaxshdelWH/bKAo2om0M9pxffzXRe+udF/qr5Gbuy8Ut7zW
         y1aCjGRCgHWuU/JLiaKbIcpaAY6ZoCC703xNcA5l5GhztkTg/WRD22wVzrtpr3R9+SJy
         hEz5KtX/mhLD38qg/RPQITzxPITBH5tTUAgNObi+6TpUyjh0HGiT54mAXQ1X7/od6THg
         CeCrxGEiqgEzHBC6z8Sh9TDpLwOXI7kbUTgVTVSeYreXRsyw/ELOmlUegRQBCPB5RCio
         E/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34xmTXahX9JOxAWp+niqcaXhO5EjSMmbu9kacIdY9GA=;
        b=pSWz6i/cpLRqAnmXyCQpX2jJ1gEMQ0k+324S5yyWfHFi+YyOAF4BxS7jYWRQNpiS9/
         Hp7I8t8GZHsvboPdKx+jNywLq/N8wEhwWDkLd/Lzt/QfqwIMISlEwDUkmHivXcZlmXF9
         yZ10IrQKoqh0TdJTcxGpY9X4qbuAjfulPToix4H8FHtZF8fIqttLTr6zNdNvs/vfT8Yz
         Ez28FRWq8D7NxXc/GDy1RpkXFGfFG5XOkV4WuaJGQ66wUPH0m5cIvZiyb9RStoKQJBvF
         7sgry3iib1spNH0+69eTuDjLKVUvfnSPQC8GW4B3YQmIEhvLEb8RYpxn0EhNZDd+qJYy
         /0Jw==
X-Gm-Message-State: ACrzQf1eDEGkQVhmhFV8m++4lqx0LYQc3NmbAwQwnyLj5saMH8mlXa6G
        GOYvZHsBOT5Oa/c41W3ivBdrdncxeEqTAHVD/zEtUw==
X-Google-Smtp-Source: AMsMyM7Tlc8spRalg0u2yiOeDWCAOkwjTndgzLLthoZ/7CAUKa/Ts8f5EjNK5MHh7Os/q7EA89e+nwpl5t2NZIebdhw=
X-Received: by 2002:a17:907:761b:b0:7a3:86dd:d330 with SMTP id
 jx27-20020a170907761b00b007a386ddd330mr53730091ejc.34.1667933135949; Tue, 08
 Nov 2022 10:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20221107184715.3950621-1-pasha.tatashin@soleen.com> <e94ac231-7137-010c-2f2b-6a309c941759@redhat.com>
In-Reply-To: <e94ac231-7137-010c-2f2b-6a309c941759@redhat.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 8 Nov 2022 13:44:58 -0500
Message-ID: <CA+CK2bAbKMj8-crNCtmQ=DB5uRvQBJtFTLf5TH9=RWRGjfOGew@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

Thank you for taking a look at this change:

On Tue, Nov 8, 2022 at 12:56 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 07.11.22 19:47, Pasha Tatashin wrote:
> > Since: commit 9a10064f5625 ("mm: add a field to store names for private
> > anonymous memory"), name for private anonymous memory, but not shared
> > anonymous, can be set. However, naming shared anonymous memory just as
>
>                                                                   ^ is
>

OK

> > useful for tracking purposes.
> >
> > Extend the functionality to be able to set names for shared anon.
> >
> > Sample output:
> >    /* Create shared anonymous segmenet */
>
> s/segmenet/segment/

Ok

>
> >    anon_shmem = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> >                      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> >    /* Name the segment: "MY-NAME" */
> >    rv = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME,
> >               anon_shmem, SIZE, "MY-NAME");
> >
> > cat /proc/<pid>/maps (and smaps):
> > 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024 [anon_shmem:MY-NAME]
>
> What would it have looked like before? Just no additional information?

Before:

7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024 /dev/zero (deleted)

Pasha

>
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
>
>
> [...]
>
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 8bbcccbc5565..06b6fb3277ab 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -699,8 +699,10 @@ static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
> >    * paths in userfault.
> >    */
> >   bool vma_is_shmem(struct vm_area_struct *vma);
> > +bool vma_is_anon_shmem(struct vm_area_struct *vma);
> >   #else
> >   static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
> > +static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false; }
> >   #endif
> >
> >   int vma_is_stack_for_current(struct vm_area_struct *vma);
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 500e536796ca..08d8b973fb60 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -461,21 +461,11 @@ struct vm_area_struct {
> >        * For areas with an address space and backing store,
> >        * linkage into the address_space->i_mmap interval tree.
> >        *
> > -      * For private anonymous mappings, a pointer to a null terminated string
> > -      * containing the name given to the vma, or NULL if unnamed.
> >        */
> > -
> > -     union {
> > -             struct {
> > -                     struct rb_node rb;
> > -                     unsigned long rb_subtree_last;
> > -             } shared;
> > -             /*
> > -              * Serialized by mmap_sem. Never use directly because it is
> > -              * valid only when vm_file is NULL. Use anon_vma_name instead.
> > -              */
> > -             struct anon_vma_name *anon_name;
> > -     };
> > +     struct {
> > +             struct rb_node rb;
> > +             unsigned long rb_subtree_last;
> > +     } shared;
> >
>
> So that effectively grows the size of vm_area_struct. Hm. I'd really
> prefer to keep this specific to actual anonymous memory, not extending
> it to anonymous files.

It grows only when CONFIG_ANON_VMA_NAME=y, otherwise it stays the same
as before. Are you suggesting adding another config specifically for
shared memory? I wonder if we could add a union for some other part of
vm_area_struct where anon and file cannot be used together.

> Do we have any *actual* users where we don't have an alternative? I
> doubt that this is really required.
>
> The simplest approach seems to be to use memfd instead of MAP_SHARED |
> MAP_ANONYMOUS. __NR_memfd_create can be passed a name and you get what
> you propose here effectively already. Or does anything speak against it?

For our use case the above does not work. We are working on highly
paravirtualized virtual machines. The VMM maps VM memory as anonymous
shared memory (not private because VMM is sandboxed and drivers are
running in their own processes). However, the VM tells back to the VMM
how parts of the memory are actually used by the guest, how each of
the segments should be backed (i.e. 4K pages, 2M pages), and some
other information about the segments. The naming allows us to monitor
the effective memory footprint for each of these segments from the
host without looking inside the guest.

Pasha
