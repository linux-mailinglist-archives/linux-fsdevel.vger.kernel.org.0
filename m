Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EF570561B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjEPSha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 14:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEPSh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 14:37:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA910FA;
        Tue, 16 May 2023 11:37:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso73260385e9.2;
        Tue, 16 May 2023 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684262246; x=1686854246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaslgZEeUfyG0dbWvN9RhS0f93vIcfVbTpmBHRl31SQ=;
        b=ByOFPTS8wX1VocazZm5K+Z/cV+JAF1+/AEe+abUpe++GbuDmB2pEMIzzMc0Yrg+AFo
         t1/2xGnROfijw9CNIHJfrhJA18laHF/O37aX7TWS9v+ye8bw/8ieT5MZvJk47O1k0LmC
         xH609mx8Ukcznx13GNlVzb/lPR1B4vT6iO2oGCLO0KwZIPwOfdIgV9f7Zx75dp/vMUiU
         6Hw7fZokzaskSvKzuW4yn9td7ihuacbj74EfwAguGShiogskn6VrXoSU3Zelpiodam6z
         xOV/YzPM4V5atP0720m3Ct7bzaJ/CcfJqKIhq5QoFK0DuXoaX9z60S2NujzYokH04xie
         IKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684262246; x=1686854246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaslgZEeUfyG0dbWvN9RhS0f93vIcfVbTpmBHRl31SQ=;
        b=ObEA1K6mPD4RvKLoXDV36XS2ppzJJnjUeZHXPWILXUh+XV4M+lLCgeG9TmMvcErPHp
         xp/loH2LdtAh3CR1dTK5jZ7SeUTiF/t2roogHlcBe1R30nsmPmmXctBSC5RvF6CyjAjo
         FSfGq4paBB/2HdiZSyh0ueKff/X4ffuKNuq3w9qtzTH3kO61UR/CblIxipqNj/UVIuMz
         fmhj6djSqX0upMcLKqhHdT+xfsihEx7PNIjn4n466wkxDyxuoKbl6ufMf4e3KfGgTQfr
         9Kw+otEfE4rjX6fh87QVA79AsbFvH8GVm1ScKz0Rc/lg4OQALl+uRNcXXlE7r7/Qu4pU
         Gn4Q==
X-Gm-Message-State: AC+VfDyjFnZuAyvQGkIj5ULIzNMA4K0OPptiUSHjzs11bqhkUfqkXvq5
        kwqdLjmmklEriPiYEgZMAJs=
X-Google-Smtp-Source: ACHHUZ5FbzA2y39DLkphw8Nq0JUTk+Jyh31cY6z+5LmeNOVBA5+4d41LJGOyvlXiibxy7NLJ7ZRP9A==
X-Received: by 2002:a5d:4d44:0:b0:306:484e:e568 with SMTP id a4-20020a5d4d44000000b00306484ee568mr28717336wru.40.1684262245393;
        Tue, 16 May 2023 11:37:25 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d6509000000b00304b5b2f5ffsm212309wru.53.2023.05.16.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:37:24 -0700 (PDT)
Date:   Tue, 16 May 2023 19:37:23 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>
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
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
Message-ID: <0db8b45d-8f7d-46bc-8739-c167c086bcfc@lucifer.local>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <afe323639b7bda066ee5c7a6cca906f5ad8df940.1684097002.git.lstoakes@gmail.com>
 <20230516094919.GA411@mutt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516094919.GA411@mutt>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 11:49:19AM +0200, Anders Roxell wrote:
> On 2023-05-14 22:26, Lorenzo Stoakes wrote:
> > The only instances of get_user_pages_remote() invocations which used the
> > vmas parameter were for a single page which can instead simply look up the
> > VMA directly. In particular:-
> >
> > - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
> >   remove it.
> >
> > - __access_remote_vm() was already using vma_lookup() when the original
> >   lookup failed so by doing the lookup directly this also de-duplicates the
> >   code.
> >
> > We are able to perform these VMA operations as we already hold the
> > mmap_lock in order to be able to call get_user_pages_remote().
> >
> > As part of this work we add get_user_page_vma_remote() which abstracts the
> > VMA lookup, error handling and decrementing the page reference count should
> > the VMA lookup fail.
> >
> > This forms part of a broader set of patches intended to eliminate the vmas
> > parameter altogether.
> >
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com> (for arm64)
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Janosch Frank <frankja@linux.ibm.com> (for s390)
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  arch/arm64/kernel/mte.c   | 17 +++++++++--------
> >  arch/s390/kvm/interrupt.c |  2 +-
> >  fs/exec.c                 |  2 +-
> >  include/linux/mm.h        | 34 +++++++++++++++++++++++++++++++---
> >  kernel/events/uprobes.c   | 13 +++++--------
> >  mm/gup.c                  | 12 ++++--------
> >  mm/memory.c               | 14 +++++++-------
> >  mm/rmap.c                 |  2 +-
> >  security/tomoyo/domain.c  |  2 +-
> >  virt/kvm/async_pf.c       |  3 +--
> >  10 files changed, 61 insertions(+), 40 deletions(-)
> >
>
> [...]
>
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 146bb94764f8..63632a5eafc1 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5590,7 +5590,6 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
> >  int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
> >  		       int len, unsigned int gup_flags)
> >  {
> > -	struct vm_area_struct *vma;
> >  	void *old_buf = buf;
> >  	int write = gup_flags & FOLL_WRITE;
> >
> > @@ -5599,13 +5598,15 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
> >
> >  	/* ignore errors, just check how much was successfully transferred */
> >  	while (len) {
> > -		int bytes, ret, offset;
> > +		int bytes, offset;
> >  		void *maddr;
> > -		struct page *page = NULL;
> > +		struct vm_area_struct *vma;
> > +		struct page *page = get_user_page_vma_remote(mm, addr,
> > +							     gup_flags, &vma);
> > +
> > +		if (IS_ERR_OR_NULL(page)) {
> > +			int ret = 0;
>
> I see the warning below when building without CONFIG_HAVE_IOREMAP_PROT set.
>
> make --silent --keep-going --jobs=32 \
> O=/home/anders/.cache/tuxmake/builds/1244/build ARCH=arm \
> CROSS_COMPILE=arm-linux-gnueabihf- /home/anders/src/kernel/next/mm/memory.c: In function '__access_remote_vm':
> /home/anders/src/kernel/next/mm/memory.c:5608:29: warning: unused variable 'ret' [-Wunused-variable]
>  5608 |                         int ret = 0;
>       |                             ^~~
>

Ah damn, nice spot thanks!

>
> >
> > -		ret = get_user_pages_remote(mm, addr, 1,
> > -				gup_flags, &page, &vma, NULL);
> > -		if (ret <= 0) {
> >  #ifndef CONFIG_HAVE_IOREMAP_PROT
> >  			break;
> >  #else
> > @@ -5613,7 +5614,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
> >  			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
> >  			 * we can access using slightly different code.
> >  			 */
> > -			vma = vma_lookup(mm, addr);
> >  			if (!vma)
> >  				break;
> >  			if (vma->vm_ops && vma->vm_ops->access)
>
> Cheers,
> Anders

I enclose a -fix patch for this below:-

----8<----
From 6a4bb033a1ec60920e4945e7e063443f91489d06 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Tue, 16 May 2023 19:16:22 +0100
Subject: [PATCH] mm/gup: remove vmas parameter from get_user_pages_remote()

Fix unused variable warning as reported by Anders Roxell.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 63632a5eafc1..b1b25e61294a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5605,11 +5605,11 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 							     gup_flags, &vma);

 		if (IS_ERR_OR_NULL(page)) {
-			int ret = 0;
-
 #ifndef CONFIG_HAVE_IOREMAP_PROT
 			break;
 #else
+			int ret = 0;
+
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
--
2.40.1
