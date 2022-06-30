Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D0561E94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 17:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiF3O7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiF3O73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:59:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC341EC42;
        Thu, 30 Jun 2022 07:59:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w1-20020a17090a6b8100b001ef26ab992bso3170230pjj.0;
        Thu, 30 Jun 2022 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDdC8MWrQ6wZJiRG/CDlxCW2oNQMtGgdO4bcX2PBWTo=;
        b=hUkLdRk5Sl/4Klb0oO55UMPf9zmWbX29THlfRNeOGCiw929jeEGHVT+X8rkl2+0b0W
         AxVBSV73eAn41PobV29GVgABmsQZcvrWWziySDPM9LeV5+fJlQVX1EA7l3wuQ0gGvpuX
         KHKqvN9vj+dZorzYnrPQCQ45MagiZJExnu34wMpGveMtM4vXX5axppP5X7A5LPus3Jke
         72z4ETDKKHjxz+b6saIKbniCZvDz6ujimO4EBBMX3iWNrnnQIjb7u8t9VYwxONIj5o/x
         j8acEPrL8LBSs5WiRVRwLLQBrXWc1Fl34zfA10r7Bc3xWAOlSPVKmwFqxxP5horzQppO
         aRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDdC8MWrQ6wZJiRG/CDlxCW2oNQMtGgdO4bcX2PBWTo=;
        b=L/jmuibqAxAXgzUKiuSOFZLXU/A6fUEFsdJIf8XzjLhrxRvlted8+u/B4nqidjS0uR
         YftCcRSdyd3u0dQVNp+URg0TNHvkN4mwQHp0XCBjpb8C3sPKD76BFIZuuHdjh3AegTgq
         bQHHBpmbwMK5w+6CdegmSeRbl4tIRs0ac1t6dj4DqEZXUvhjaEhrWKAZz2LJW0TEGJDf
         3y1hbTZplwQL45Y3ax0+Pt8Kwv1StNa0bsUFdFNFpe0etrT6T+F1YUneLUWTIrHNKPlc
         KdfSezfYpa5AKGLp16ISOIaGYPTWWjaIOvnoQciz5+KKx+7e4c20uEWmTVtWLPZ0ZUGg
         HN9g==
X-Gm-Message-State: AJIora8Q4KAYSC8jk+kWPY1pv57BvpCOaRqniLyxHKZR5Y4W2ayvJQH1
        J0DTRDNN59/Y/QZhrsD6XwK50NrIyuDyrkchkhs=
X-Google-Smtp-Source: AGRyM1shSTsxwuCBHUACAQlZ5+ZkkdgCKu271yMVqtcvNSFnvG1kqiGCJylg52i/qOqhou6yjlR/94Q8T+U7Nqxk2kQ=
X-Received: by 2002:a17:90b:38cc:b0:1ed:474a:a675 with SMTP id
 nn12-20020a17090b38cc00b001ed474aa675mr11080856pjb.149.1656601168472; Thu, 30
 Jun 2022 07:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656531090.git.khalid.aziz@oracle.com> <e7606a8ea6360c253b32d14a2dbde9f7818b7eaf.1656531090.git.khalid.aziz@oracle.com>
In-Reply-To: <e7606a8ea6360c253b32d14a2dbde9f7818b7eaf.1656531090.git.khalid.aziz@oracle.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Thu, 30 Jun 2022 15:59:17 +0100
Message-ID: <CANe_+Uh--cJvG=N4KEkg63AF2FTtYz9e-Z8N=uwWpuTHMNtwLw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] mm/mshare: Add vm flag for shared PTE
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        Kees Cook <keescook@chromium.org>, kirill@shutemov.name,
        kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        luto@kernel.org, pcc@google.com, rppt@kernel.org,
        sieberf@amazon.com, sjpark@amazon.de,
        Suren Baghdasaryan <surenb@google.com>, tst@schoebel-theuer.de,
        yzaikin@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 Jun 2022 at 23:54, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
> a function to determine if a vma shares PTE by checking this flag.
> This is to be used to find the shared page table entries on page fault
> for vmas sharing PTE.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h             | 8 ++++++++
>  include/trace/events/mmflags.h | 3 ++-
>  mm/internal.h                  | 5 +++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bc8f326be0ce..0ddc3057f73b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -310,11 +310,13 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_HIGH_ARCH_BIT_2     34      /* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_3     35      /* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_4     36      /* bit only usable on 64-bit architectures */
> +#define VM_HIGH_ARCH_BIT_5     37      /* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_0 BIT(VM_HIGH_ARCH_BIT_0)
>  #define VM_HIGH_ARCH_1 BIT(VM_HIGH_ARCH_BIT_1)
>  #define VM_HIGH_ARCH_2 BIT(VM_HIGH_ARCH_BIT_2)
>  #define VM_HIGH_ARCH_3 BIT(VM_HIGH_ARCH_BIT_3)
>  #define VM_HIGH_ARCH_4 BIT(VM_HIGH_ARCH_BIT_4)
> +#define VM_HIGH_ARCH_5 BIT(VM_HIGH_ARCH_BIT_5)
>  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>
>  #ifdef CONFIG_ARCH_HAS_PKEYS
> @@ -356,6 +358,12 @@ extern unsigned int kobjsize(const void *objp);
>  # define VM_MTE_ALLOWED        VM_NONE
>  #endif
>
> +#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
> +#define VM_SHARED_PT   VM_HIGH_ARCH_5
> +#else
> +#define VM_SHARED_PT   0
> +#endif
> +

I'm not clear why mshare is using high-vma flags for VM_SHARED_PT.
CONFIG_ARCH_USES_HIGH_VMA_FLAGS might not be defined, making mshare
unsupported (or, rather, broken).
Is this being done as there is a shortage of non-high flags?
0x00000800 is available, although it appears to be the last one (quick
check).
(When using the last 'normal' flag bit, good idea to highlight this in
the cover letter.)

>  #ifndef VM_GROWSUP
>  # define VM_GROWSUP    VM_NONE
>  #endif
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index e87cb2b80ed3..30e56cbac99b 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -194,7 +194,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,  "softdirty"     )               \
>         {VM_MIXEDMAP,                   "mixedmap"      },              \
>         {VM_HUGEPAGE,                   "hugepage"      },              \
>         {VM_NOHUGEPAGE,                 "nohugepage"    },              \
> -       {VM_MERGEABLE,                  "mergeable"     }               \
> +       {VM_MERGEABLE,                  "mergeable"     },              \
> +       {VM_SHARED_PT,                  "sharedpt"      }               \
>
>  #define show_vma_flags(flags)                                          \
>         (flags) ? __print_flags(flags, "|",                             \
> diff --git a/mm/internal.h b/mm/internal.h
> index c0f8fbe0445b..3f2790aea918 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -861,4 +861,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>
>  DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>
> +static inline bool vma_is_shared(const struct vm_area_struct *vma)
> +{
> +       return vma->vm_flags & VM_SHARED_PT;
> +}
> +
>  #endif /* __MM_INTERNAL_H */
> --
> 2.32.0
>
