Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073F37049AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjEPJtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjEPJt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 05:49:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8679F30DA
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 02:49:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso14024850e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684230563; x=1686822563;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU/9Bd1F4v4AQI4XYwGvMKtVUVhP+Ta/KlDV/Ofhgvw=;
        b=DLO9Sp+4W+z5eLJ4OplpY56KL7dsXPxPyKzZN31e24ZgWla/8bs4IkvAtRU1sNrr4d
         M/zIAUZjhZlW4P2rkk7T+6W0UVsyD90WG+YdGYFrH/Glii/KUDZq0IpUmntg707CdF5n
         i37UB3Tbbcas87bL0/efYfe6w3ZnC5XyG3qMqn02SGpfBU+8hNkNlrN1nhw2lKAkzq5B
         CRMAVzp4RUPFc/3/QZ675+4TlLXQLlc1iMNrOb5F/K4RaFPvTUMi9nJBxjhqICMZPBab
         XEfOKIgxNn+kxSFXUOWAg+ZiVcGCmn7Ho0MHbSwpND8R8HARcto93DQrGrEkUYhsomoF
         2BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684230563; x=1686822563;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZU/9Bd1F4v4AQI4XYwGvMKtVUVhP+Ta/KlDV/Ofhgvw=;
        b=j/NTZZGmhFETroVvgCyxWT6IOHLzy8faVRi+FCr7kKUOHH9gmdUwykIYFk3+U/TLgb
         Br8+jOt0lserQH2heDWQTEBTmHRx4vPUgIvOMT/ZO3lIrDnQWbEpU5J4aTyl2CgF5ruG
         KVlk0OTBLv1g9L1tq1qSwi9mhhw5wMfLHjSmnAgTcM7uc/4J8Mjo8rRz+GTaSMTpuokx
         ZHeKNadRTmsYIN/uoqLd/Dy1ICrv4ATtJSUZhet/TsJ/mVF9WAS7KJcovx6bXnWi0qsY
         MfHU3YEL/JeGdfGmZBHz2iUCmDIITTwas1E9Sr9kuhjBRCvblfuWh0NvJMlavTK52yyM
         6Zfg==
X-Gm-Message-State: AC+VfDwvp0pvUUGAWoAGkBQ/SJbBQ7KeROG0YZhMSsohzODmdZUxk4L2
        lO7riyGEszsfcWODgBnFEvAEKQ==
X-Google-Smtp-Source: ACHHUZ4l3TyALRDEaGcVcIkdK7q9mH/ov5OVGGAezktN7u9QG834/IDjSuCD7zTf56ZU9ouww0Hd6Q==
X-Received: by 2002:a05:6512:2181:b0:4e8:4a21:9c92 with SMTP id b1-20020a056512218100b004e84a219c92mr7419897lft.4.1684230562687;
        Tue, 16 May 2023 02:49:22 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id w11-20020a19c50b000000b004f251cf3d31sm2908003lfe.153.2023.05.16.02.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:49:21 -0700 (PDT)
Date:   Tue, 16 May 2023 11:49:19 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v5 3/6] mm/gup: remove vmas parameter from
 get_user_pages_remote()
Message-ID: <20230516094919.GA411@mutt>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <afe323639b7bda066ee5c7a6cca906f5ad8df940.1684097002.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afe323639b7bda066ee5c7a6cca906f5ad8df940.1684097002.git.lstoakes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-05-14 22:26, Lorenzo Stoakes wrote:
> The only instances of get_user_pages_remote() invocations which used the
> vmas parameter were for a single page which can instead simply look up the
> VMA directly. In particular:-
> 
> - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
>   remove it.
> 
> - __access_remote_vm() was already using vma_lookup() when the original
>   lookup failed so by doing the lookup directly this also de-duplicates the
>   code.
> 
> We are able to perform these VMA operations as we already hold the
> mmap_lock in order to be able to call get_user_pages_remote().
> 
> As part of this work we add get_user_page_vma_remote() which abstracts the
> VMA lookup, error handling and decrementing the page reference count should
> the VMA lookup fail.
> 
> This forms part of a broader set of patches intended to eliminate the vmas
> parameter altogether.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com> (for arm64)
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com> (for s390)
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  arch/arm64/kernel/mte.c   | 17 +++++++++--------
>  arch/s390/kvm/interrupt.c |  2 +-
>  fs/exec.c                 |  2 +-
>  include/linux/mm.h        | 34 +++++++++++++++++++++++++++++++---
>  kernel/events/uprobes.c   | 13 +++++--------
>  mm/gup.c                  | 12 ++++--------
>  mm/memory.c               | 14 +++++++-------
>  mm/rmap.c                 |  2 +-
>  security/tomoyo/domain.c  |  2 +-
>  virt/kvm/async_pf.c       |  3 +--
>  10 files changed, 61 insertions(+), 40 deletions(-)
> 

[...]

> diff --git a/mm/memory.c b/mm/memory.c
> index 146bb94764f8..63632a5eafc1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5590,7 +5590,6 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
>  int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
>  		       int len, unsigned int gup_flags)
>  {
> -	struct vm_area_struct *vma;
>  	void *old_buf = buf;
>  	int write = gup_flags & FOLL_WRITE;
>  
> @@ -5599,13 +5598,15 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
>  
>  	/* ignore errors, just check how much was successfully transferred */
>  	while (len) {
> -		int bytes, ret, offset;
> +		int bytes, offset;
>  		void *maddr;
> -		struct page *page = NULL;
> +		struct vm_area_struct *vma;
> +		struct page *page = get_user_page_vma_remote(mm, addr,
> +							     gup_flags, &vma);
> +
> +		if (IS_ERR_OR_NULL(page)) {
> +			int ret = 0;

I see the warning below when building without CONFIG_HAVE_IOREMAP_PROT set.

make --silent --keep-going --jobs=32 \
O=/home/anders/.cache/tuxmake/builds/1244/build ARCH=arm \
CROSS_COMPILE=arm-linux-gnueabihf- /home/anders/src/kernel/next/mm/memory.c: In function '__access_remote_vm':
/home/anders/src/kernel/next/mm/memory.c:5608:29: warning: unused variable 'ret' [-Wunused-variable]
 5608 |                         int ret = 0;
      |                             ^~~


>  
> -		ret = get_user_pages_remote(mm, addr, 1,
> -				gup_flags, &page, &vma, NULL);
> -		if (ret <= 0) {
>  #ifndef CONFIG_HAVE_IOREMAP_PROT
>  			break;
>  #else
> @@ -5613,7 +5614,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
>  			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
>  			 * we can access using slightly different code.
>  			 */
> -			vma = vma_lookup(mm, addr);
>  			if (!vma)
>  				break;
>  			if (vma->vm_ops && vma->vm_ops->access)

Cheers,
Anders
