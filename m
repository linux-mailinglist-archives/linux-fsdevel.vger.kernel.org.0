Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35CD6E49D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 15:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDQNYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 09:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjDQNYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:24:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F549FF;
        Mon, 17 Apr 2023 06:23:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2f625d52275so1550487f8f.3;
        Mon, 17 Apr 2023 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681737835; x=1684329835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKAAc3ZsjOsQZpjk6XJI6NMJzVbDtqI98XsTFMuJ8w4=;
        b=oNOvCHGNkSBvUbh4ERh8j/DqJtUwbQoII2LGqZbVAhWFWfbbcnRnf+8UhdDzO/d1ET
         i21AXWRsFFh1RWrHvwHpOF6isEiP2D2zO1ON4sIutL4dtw2gJaEBVtjK+ZX1jqOwfXxe
         bVmx0wrpYw1yojVfAmWruLcF69lFlLHUEQKj/58zZKf6DmefiuCIzxxqH4DJID8yaXbt
         urENc2lY29lF4j2ZupatM9Uz2p8FmREaiqOOYw7xEoUPXmJhrPFMpD8ihomU3gxN+/no
         nX01agI2B5Q0NxrW9XatoyAzGuOV0xtn3Regsk8O0VTAdr+YKUHGHmxJzeZsjHXbaZ7u
         1r4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681737835; x=1684329835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKAAc3ZsjOsQZpjk6XJI6NMJzVbDtqI98XsTFMuJ8w4=;
        b=FSSFwy/LXp1yxMfUHZds9iHh9uVVd9SMbz4BvAJ6OylEtIyPLs/MI4HyaGarwz2Kel
         aJTg3iaMENh6AEZI4CSI9GfJ22EcVbHtZrYG8DjKbOJ99KlJtACG18g9RgBzUV43UtcN
         OVEDxHUtoWYbTbWrel4tlp/eJ10mS7c+YkWro7DPRA/amM28+xOxgUIQd8GC1/5ft84k
         0iUxiWDBdXFEhegYO3p1cLi31bclAYk6ZBGxotkKupqXT5UW3+J+AOArtlqJdwv6JGcv
         dhaNWDpC47kng0W4qUPGLDHHNxcjdtu7dSREooy6d0fqMTL+TgPZ4SJ3d8CalcYOsI3d
         iQow==
X-Gm-Message-State: AAQBX9cxtwIfd2bfg8RTtISqu9GkCF3uK2agGjGSGIfkdHRLLvOqOaTS
        /MkDroe32/oMe3mRyR3jXq4=
X-Google-Smtp-Source: AKy350ZgGhmNdbORfcWWT3+kEaLh1DjBGO2Qr9T2OkuqSkpU4KmNaszZ8mszkHwAUCbDgkdgFsooIQ==
X-Received: by 2002:adf:dd4b:0:b0:2ef:eb54:4dc0 with SMTP id u11-20020adfdd4b000000b002efeb544dc0mr6790292wrm.51.1681737834522;
        Mon, 17 Apr 2023 06:23:54 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d66ce000000b002f103ca90cdsm10571529wrw.101.2023.04.17.06.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:23:53 -0700 (PDT)
Date:   Mon, 17 Apr 2023 14:23:52 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
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
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/7] mm/gup: remove vmas parameter from
 get_user_pages_remote()
Message-ID: <241f0c22-f3d6-436e-a0d8-be04e281ed2f@lucifer.local>
References: <cover.1681508038.git.lstoakes@gmail.com>
 <5a4cf1ebf1c6cdfabbf2f5209facb0180dd20006.1681508038.git.lstoakes@gmail.com>
 <ZD1FECftWekha6Do@nvidia.com>
 <9be77e7e-4531-4e1c-9e0d-4edbb5ad3bd5@lucifer.local>
 <ZD1GrBezHrJTo6x2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD1GrBezHrJTo6x2@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:16:28AM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 17, 2023 at 02:13:39PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Apr 17, 2023 at 10:09:36AM -0300, Jason Gunthorpe wrote:
> > > On Sat, Apr 15, 2023 at 12:27:31AM +0100, Lorenzo Stoakes wrote:
> > > > The only instances of get_user_pages_remote() invocations which used the
> > > > vmas parameter were for a single page which can instead simply look up the
> > > > VMA directly. In particular:-
> > > >
> > > > - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
> > > >   remove it.
> > > >
> > > > - __access_remote_vm() was already using vma_lookup() when the original
> > > >   lookup failed so by doing the lookup directly this also de-duplicates the
> > > >   code.
> > > >
> > > > This forms part of a broader set of patches intended to eliminate the vmas
> > > > parameter altogether.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > > ---
> > > >  arch/arm64/kernel/mte.c   |  5 +++--
> > > >  arch/s390/kvm/interrupt.c |  2 +-
> > > >  fs/exec.c                 |  2 +-
> > > >  include/linux/mm.h        |  2 +-
> > > >  kernel/events/uprobes.c   | 10 +++++-----
> > > >  mm/gup.c                  | 12 ++++--------
> > > >  mm/memory.c               |  9 +++++----
> > > >  mm/rmap.c                 |  2 +-
> > > >  security/tomoyo/domain.c  |  2 +-
> > > >  virt/kvm/async_pf.c       |  3 +--
> > > >  10 files changed, 23 insertions(+), 26 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > > > index f5bcb0dc6267..74d8d4007dec 100644
> > > > --- a/arch/arm64/kernel/mte.c
> > > > +++ b/arch/arm64/kernel/mte.c
> > > > @@ -437,8 +437,9 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
> > > >  		struct page *page = NULL;
> > > >
> > > >  		ret = get_user_pages_remote(mm, addr, 1, gup_flags, &page,
> > > > -					    &vma, NULL);
> > > > -		if (ret <= 0)
> > > > +					    NULL);
> > > > +		vma = vma_lookup(mm, addr);
> > > > +		if (ret <= 0 || !vma)
> > > >  			break;
> > >
> > > Given the slightly tricky error handling, it would make sense to turn
> > > this pattern into a helper function:
> > >
> > > page = get_single_user_page_locked(mm, addr, gup_flags, &vma);
> > > if (IS_ERR(page))
> > >   [..]
> > >
> > > static inline struct page *get_single_user_page_locked(struct mm_struct *mm,
> > >    unsigned long addr, int gup_flags, struct vm_area_struct **vma)
> > > {
> > > 	struct page *page;
> > > 	int ret;
> > >
> > > 	ret = get_user_pages_remote(*mm, addr, 1, gup_flags, &page, NULL, NULL);
> > > 	if (ret < 0)
> > > 	   return ERR_PTR(ret);
> > > 	if (WARN_ON(ret == 0))
> > > 	   return ERR_PTR(-EINVAL);
> > >         *vma = vma_lookup(mm, addr);
> > > 	if (WARN_ON(!*vma) {
> > > 	   put_user_page(page);
> > > 	   return ERR_PTR(-EINVAL);
> > >         }
> > > 	return page;
> > > }
> > >
> > > It could be its own patch so this change was just a mechanical removal
> > > of NULL
> > >
> > > Jason
> > >
> >
> > Agreed, I think this would work better as a follow up patch however so as
> > not to distract too much from the core change.
>
> I don't think you should open code sketchy error handling in several
> places and then clean it up later. Just do it right from the start.
>

Intent was to do smallest change possible (though through review that grew
of course), but I see your point, in this instance this is fiddly stuff and
probably better to abstract it to enforce correct handling.

I'll respin + add something like this.

> Jason
