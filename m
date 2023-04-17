Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4257E6E49A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDQNO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDQNO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:14:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16C57ECB;
        Mon, 17 Apr 2023 06:14:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n43-20020a05600c502b00b003f17466a9c1so1173417wmr.2;
        Mon, 17 Apr 2023 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681737221; x=1684329221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPGY+l1CBUT18TsP0BCzWYtqqLAzY/UJAkAM6GBikAI=;
        b=aqrejtYqZ72eMGnohVkxxmF9AebULGxw+hxnhS8EOT+S+J4ULyjYh3dTiJj1BsgFnN
         A0l5ZaQnNqMIGES5L9Io723MF9vX3cetSoAgl+C5N5nsyEClwkqeWilkdC1kLKEVP8vp
         1A0kUxov/HK+x8ZaJjMPp0PoJE3t3gBJxiE9Ir0uTfnv2aJyxaUGUkgLebIUkw84fYf8
         NP5jQNKqMOqIcALr9n6P3ej4FaMTbJzg0MDyZOFXfDjfTO4BEQibN4NigX4muHB/5E4Y
         Vx+rprvun5jPO2AehmFLakX+R+N0DjJyizknFVS+k4rv4n0BOkWFamgmPpItpM5mboQj
         l4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681737221; x=1684329221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPGY+l1CBUT18TsP0BCzWYtqqLAzY/UJAkAM6GBikAI=;
        b=P/F+F6YGuqmXVK+g9hRuMGfdN2okxZRSUHoDm8qi5POpNEVzVeT6BS0EX8ISyMjuvX
         VsGl5ep4bTumzbg9TZB4REiT8U06C1UTAQ1R3QGvwsEJtIpedpACKa+HmvHTlwsDwUtU
         vdPaIvszC9VhboZC2RCKqAt7+8lAxt5784FF0AwXfTulM30aKIPpp5OS/zBJVzti+k4C
         5hocbbFS76KJvs2HC7W6gp0E3zbtZPV3xXnAWMHn1ZecyUgfwglwDWpKGU1vWPJf3mWy
         u/iHclQJiTEryV+XbEaU8LAKtpQNcw483QPnT02nvMwXXZxb1bmApGS0s0CV/NLOADkS
         PH8g==
X-Gm-Message-State: AAQBX9ecLVzsbcJBWtDhHX6wNs/VMaFsKsMs98Ud3xscBL864wKa7oww
        EP8xDnA41PVrFFL0CMYHhXnRRpN3AACBHg==
X-Google-Smtp-Source: AKy350YpxgIqhPqBTW2ZP9bBA/59bVyp5FATSus2VQX+XLtFyrwX7wxzZ/PbJ44wrYd2UB6TkPWruA==
X-Received: by 2002:a05:600c:20d:b0:3f0:9cc6:daf0 with SMTP id 13-20020a05600c020d00b003f09cc6daf0mr11002739wmi.27.1681737220790;
        Mon, 17 Apr 2023 06:13:40 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id hn3-20020a05600ca38300b003f16ebdc93esm6117802wmb.24.2023.04.17.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:13:40 -0700 (PDT)
Date:   Mon, 17 Apr 2023 14:13:39 +0100
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
Message-ID: <9be77e7e-4531-4e1c-9e0d-4edbb5ad3bd5@lucifer.local>
References: <cover.1681508038.git.lstoakes@gmail.com>
 <5a4cf1ebf1c6cdfabbf2f5209facb0180dd20006.1681508038.git.lstoakes@gmail.com>
 <ZD1FECftWekha6Do@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD1FECftWekha6Do@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:09:36AM -0300, Jason Gunthorpe wrote:
> On Sat, Apr 15, 2023 at 12:27:31AM +0100, Lorenzo Stoakes wrote:
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
> > This forms part of a broader set of patches intended to eliminate the vmas
> > parameter altogether.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  arch/arm64/kernel/mte.c   |  5 +++--
> >  arch/s390/kvm/interrupt.c |  2 +-
> >  fs/exec.c                 |  2 +-
> >  include/linux/mm.h        |  2 +-
> >  kernel/events/uprobes.c   | 10 +++++-----
> >  mm/gup.c                  | 12 ++++--------
> >  mm/memory.c               |  9 +++++----
> >  mm/rmap.c                 |  2 +-
> >  security/tomoyo/domain.c  |  2 +-
> >  virt/kvm/async_pf.c       |  3 +--
> >  10 files changed, 23 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index f5bcb0dc6267..74d8d4007dec 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -437,8 +437,9 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
> >  		struct page *page = NULL;
> >
> >  		ret = get_user_pages_remote(mm, addr, 1, gup_flags, &page,
> > -					    &vma, NULL);
> > -		if (ret <= 0)
> > +					    NULL);
> > +		vma = vma_lookup(mm, addr);
> > +		if (ret <= 0 || !vma)
> >  			break;
>
> Given the slightly tricky error handling, it would make sense to turn
> this pattern into a helper function:
>
> page = get_single_user_page_locked(mm, addr, gup_flags, &vma);
> if (IS_ERR(page))
>   [..]
>
> static inline struct page *get_single_user_page_locked(struct mm_struct *mm,
>    unsigned long addr, int gup_flags, struct vm_area_struct **vma)
> {
> 	struct page *page;
> 	int ret;
>
> 	ret = get_user_pages_remote(*mm, addr, 1, gup_flags, &page, NULL, NULL);
> 	if (ret < 0)
> 	   return ERR_PTR(ret);
> 	if (WARN_ON(ret == 0))
> 	   return ERR_PTR(-EINVAL);
>         *vma = vma_lookup(mm, addr);
> 	if (WARN_ON(!*vma) {
> 	   put_user_page(page);
> 	   return ERR_PTR(-EINVAL);
>         }
> 	return page;
> }
>
> It could be its own patch so this change was just a mechanical removal
> of NULL
>
> Jason
>

Agreed, I think this would work better as a follow up patch however so as
not to distract too much from the core change. I feel like there are quite
a few things we can follow up on including assessing whether we might be
able to use _fast() paths in places (I haven't assessed this yet).
