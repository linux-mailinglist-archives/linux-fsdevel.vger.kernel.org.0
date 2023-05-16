Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB80705A5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 00:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjEPWCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 18:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjEPWCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 18:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A0CB4;
        Tue, 16 May 2023 15:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B587363CF5;
        Tue, 16 May 2023 22:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90F7C433EF;
        Tue, 16 May 2023 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684274540;
        bh=Xn5gFOegvDQoAs6fV+QPMtWJd/9gIN1gu+8PHj8jATQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I8HmcSl3RSMNgObVi4nyzA8Dn0pIVn3Hyd4M9+6+jiCnOIEHPDAD1katsykkWAiMa
         gn5fQMZJ0CFmK2NC9H7JKcNfD2tVhwbbUSeGJQe61+ttSYu+uB1762WRf9rvoaH/7u
         R2FZf07p1aiooDIDhn5t28F6IgINIJ5khA8X4Fo4=
Date:   Tue, 16 May 2023 15:02:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
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
Message-Id: <20230516150218.477c5e9d0a2d9ef8b057069c@linux-foundation.org>
In-Reply-To: <20230516094919.GA411@mutt>
References: <cover.1684097001.git.lstoakes@gmail.com>
        <afe323639b7bda066ee5c7a6cca906f5ad8df940.1684097002.git.lstoakes@gmail.com>
        <20230516094919.GA411@mutt>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 16 May 2023 11:49:19 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:

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

Thanks, I did the obvious.

Also s/ret/res/, as `ret' is kinda reserved for "this is what this
function will return".

--- a/mm/memory.c~mm-gup-remove-vmas-parameter-from-get_user_pages_remote-fix
+++ a/mm/memory.c
@@ -5605,11 +5605,11 @@ int __access_remote_vm(struct mm_struct
 							     gup_flags, &vma);
 
 		if (IS_ERR_OR_NULL(page)) {
-			int ret = 0;
-
 #ifndef CONFIG_HAVE_IOREMAP_PROT
 			break;
 #else
+			int res = 0;
+
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
@@ -5617,11 +5617,11 @@ int __access_remote_vm(struct mm_struct
 			if (!vma)
 				break;
 			if (vma->vm_ops && vma->vm_ops->access)
-				ret = vma->vm_ops->access(vma, addr, buf,
+				res = vma->vm_ops->access(vma, addr, buf,
 							  len, write);
-			if (ret <= 0)
+			if (res <= 0)
 				break;
-			bytes = ret;
+			bytes = res;
 #endif
 		} else {
 			bytes = len;
_

