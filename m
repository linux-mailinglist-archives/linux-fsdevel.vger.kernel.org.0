Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B687E6E4C8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 17:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjDQPOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 11:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDQPOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:14:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA40FB;
        Mon, 17 Apr 2023 08:14:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso44003695e9.0;
        Mon, 17 Apr 2023 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681744475; x=1684336475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e047zcn20dpW+BVxg6WrLYEA74ZTRhvYR9ivWfzVffI=;
        b=J6mNTdjJXRwthJ2zCT9NEY6Z9hezMuH8x4BK/1R4BCVgk7Ci/HPN+jrcwQsKcCuTkI
         I1UPqwJz5ABCTk7X5opTEZxdgNLtiV+gU4ZZA1u010mlWUCYGH/bChtn7BAwLYDZ3JHk
         RTI8uWQsSY0HbGSVWTcygeXA3TlQzhMwGYmt3V1Id6ozIaB9PWoHyCMpAq+wrBMf57z1
         SGYdFjrENk4shHH5MXl7JnDBNcBGd0m9BV/6PlyFsgA6iVj6APNfSGWyjUQ/JZLa59nc
         mSzqI9Ijxbahm/QxlPpW5/WVK0DYMNibbaiJENbR3l7PJJ/9luB7VdSEH8WgJVZjnIyE
         roWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681744475; x=1684336475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e047zcn20dpW+BVxg6WrLYEA74ZTRhvYR9ivWfzVffI=;
        b=WBcBkbbaQqQNO2EzqeDrWHWVJ212chCFO1VLfgN9SH6RSufnjrVHf6kiHrFPn0rV9K
         +tRHipe2oMx8fjZlW8fxbMn/dR5vEgfXYdHLbikX1/aYwG46hCF7I2qSQgbm+3qU4HyM
         2E9v5S7P/aMWBUGsJQJBE2ZzaOKO41pxOf37dAeVcIU9G4tsiMpHPNVhEZcFkEcMl6BW
         n70KqLWMoiq96NDGFZKo6ERrX0Ii8wyckT1OEIiDZoWYaBgEHc8kHgGc4i57suqip30T
         YMhzvnES5C+KEMpHZS3qI0fjRFVeQ3G+PxjiQQXD5JQJJWjR6f051VB+PCh5wc2hA9GB
         SF7A==
X-Gm-Message-State: AAQBX9ecJRV9oOfUDy+O+OB3DaT5DTrt2iQDK3qlyQMXCWlGHAyywTHR
        uLaJ/LOAR4cN9pQdIo0C+nE=
X-Google-Smtp-Source: AKy350YbK9Uk+W2I0O+WB4raZRtNy4HfgrcXDXV+XwhnLO6MAXE8TxKBQdwImQWHd3Rphf8UasdaGw==
X-Received: by 2002:adf:cf01:0:b0:2fa:abcd:59a2 with SMTP id o1-20020adfcf01000000b002faabcd59a2mr2273209wrj.30.1681744475252;
        Mon, 17 Apr 2023 08:14:35 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d55c4000000b002f74578f494sm8341442wrw.41.2023.04.17.08.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:14:34 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:14:33 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Message-ID: <d663673d-f9f7-444a-9cf8-b33d450e356a@lucifer.local>
References: <cover.1681508038.git.lstoakes@gmail.com>
 <5a4cf1ebf1c6cdfabbf2f5209facb0180dd20006.1681508038.git.lstoakes@gmail.com>
 <ZD1FECftWekha6Do@nvidia.com>
 <9be77e7e-4531-4e1c-9e0d-4edbb5ad3bd5@lucifer.local>
 <ZD1GrBezHrJTo6x2@nvidia.com>
 <241f0c22-f3d6-436e-a0d8-be04e281ed2f@lucifer.local>
 <87cz427diu.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz427diu.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:07:53AM -0500, Eric W. Biederman wrote:
> Lorenzo Stoakes <lstoakes@gmail.com> writes:
>
> > On Mon, Apr 17, 2023 at 10:16:28AM -0300, Jason Gunthorpe wrote:
> >> On Mon, Apr 17, 2023 at 02:13:39PM +0100, Lorenzo Stoakes wrote:
> >> > On Mon, Apr 17, 2023 at 10:09:36AM -0300, Jason Gunthorpe wrote:
> >> > > On Sat, Apr 15, 2023 at 12:27:31AM +0100, Lorenzo Stoakes wrote:
> >> > > > The only instances of get_user_pages_remote() invocations which used the
> >> > > > vmas parameter were for a single page which can instead simply look up the
> >> > > > VMA directly. In particular:-
> >> > > >
> >> > > > - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
> >> > > >   remove it.
> >> > > >
> >> > > > - __access_remote_vm() was already using vma_lookup() when the original
> >> > > >   lookup failed so by doing the lookup directly this also de-duplicates the
> >> > > >   code.
> >> > > >
> >> > > > This forms part of a broader set of patches intended to eliminate the vmas
> >> > > > parameter altogether.
> >> > > >
> >> > > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> >> > > > ---
> >> > > >  arch/arm64/kernel/mte.c   |  5 +++--
> >> > > >  arch/s390/kvm/interrupt.c |  2 +-
> >> > > >  fs/exec.c                 |  2 +-
> >> > > >  include/linux/mm.h        |  2 +-
> >> > > >  kernel/events/uprobes.c   | 10 +++++-----
> >> > > >  mm/gup.c                  | 12 ++++--------
> >> > > >  mm/memory.c               |  9 +++++----
> >> > > >  mm/rmap.c                 |  2 +-
> >> > > >  security/tomoyo/domain.c  |  2 +-
> >> > > >  virt/kvm/async_pf.c       |  3 +--
> >> > > >  10 files changed, 23 insertions(+), 26 deletions(-)
> >> > > >
> >> > > > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> >> > > > index f5bcb0dc6267..74d8d4007dec 100644
> >> > > > --- a/arch/arm64/kernel/mte.c
> >> > > > +++ b/arch/arm64/kernel/mte.c
> >> > > > @@ -437,8 +437,9 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
> >> > > >  		struct page *page = NULL;
> >> > > >
> >> > > >  		ret = get_user_pages_remote(mm, addr, 1, gup_flags, &page,
> >> > > > -					    &vma, NULL);
> >> > > > -		if (ret <= 0)
> >> > > > +					    NULL);
> >> > > > +		vma = vma_lookup(mm, addr);
> >> > > > +		if (ret <= 0 || !vma)
> >> > > >  			break;
> >> > >
> >> > > Given the slightly tricky error handling, it would make sense to turn
> >> > > this pattern into a helper function:
> >> > >
> >> > > page = get_single_user_page_locked(mm, addr, gup_flags, &vma);
> >> > > if (IS_ERR(page))
> >> > >   [..]
> >> > >
> >> > > static inline struct page *get_single_user_page_locked(struct mm_struct *mm,
> >> > >    unsigned long addr, int gup_flags, struct vm_area_struct **vma)
> >> > > {
> >> > > 	struct page *page;
> >> > > 	int ret;
> >> > >
> >> > > 	ret = get_user_pages_remote(*mm, addr, 1, gup_flags, &page, NULL, NULL);
> >> > > 	if (ret < 0)
> >> > > 	   return ERR_PTR(ret);
> >> > > 	if (WARN_ON(ret == 0))
> >> > > 	   return ERR_PTR(-EINVAL);
> >> > >         *vma = vma_lookup(mm, addr);
> >> > > 	if (WARN_ON(!*vma) {
> >> > > 	   put_user_page(page);
> >> > > 	   return ERR_PTR(-EINVAL);
> >> > >         }
> >> > > 	return page;
> >> > > }
> >> > >
> >> > > It could be its own patch so this change was just a mechanical removal
> >> > > of NULL
> >> > >
> >> > > Jason
> >> > >
> >> >
> >> > Agreed, I think this would work better as a follow up patch however so as
> >> > not to distract too much from the core change.
> >>
> >> I don't think you should open code sketchy error handling in several
> >> places and then clean it up later. Just do it right from the start.
> >>
> >
> > Intent was to do smallest change possible (though through review that grew
> > of course), but I see your point, in this instance this is fiddly stuff and
> > probably better to abstract it to enforce correct handling.
> >
> > I'll respin + add something like this.
>
> Could you include in your description why looking up the vma after
> getting the page does not introduce a race?
>
> I am probably silly and just looking at this quickly but it does not
> seem immediately obvious why the vma and the page should match.
>
> I would not be surprised if you hold the appropriate mutex over the
> entire operation but it just isn't apparent from the diff.
>
> I am concerned because it is an easy mistake to refactor something into
> two steps and then discover you have introduced a race.
>
> Eric
>

The mmap_lock is held so VMAs cannot be altered and no such race can
occur. get_user_pages_remote() requires that the user calls it under the
lock so it is implicitly assured that this cannot happen.

I'll update the description to make this clear on the next spin!

(side-note: here is another irritating issue with GUP, we don't suffix with
_locked() consistently)
