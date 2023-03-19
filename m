Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD966C0562
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 22:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCSVSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 17:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCSVSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:18:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A2113C3;
        Sun, 19 Mar 2023 14:18:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso6351334wmq.5;
        Sun, 19 Mar 2023 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679260710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnsyvP8JbNs+veqAm6StM8UbBoUAPhLOI3XAytwZeZo=;
        b=qVhoiiNy51oSxFQEw23uh1HQRMG+qJploZdK1vaziW+lejF1UsQqj7JzeNQSGMucoo
         8XPMnjHtu3XJNkHppDZc6Fo/OfJTmfVkMoy1dMicXzE7vPJamVY1sqJz6jnKoMr7R1ay
         tHqo7M7cQ372T/zX8ngHz0iCtP8ULEAIJbj1zSze80K6c7hihh2+9vfuEi1TMemZB3G6
         C6x++ua1/dDaj9pNMgCunWevzPYKKTUnKs7TGRf0gtRqrhne1NEHo4/95Jt3J7fOYKa+
         0E/D+SGMp0doyEV2wxEr56RRBIiNNzDdraA2CvJwm+ilyy84cXoDezGMUBE7pSngPGN+
         8neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679260710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnsyvP8JbNs+veqAm6StM8UbBoUAPhLOI3XAytwZeZo=;
        b=sR5noHL0PIQ1I+i1tES8w978wUxGSSsM/X8W7b+RmBj5orzvZQ3Ooogo5Nv58lgald
         X3JZfah2AS5t191Iqa+M8vFWSjDtF015JNujgc7EHUb356ncTdGrQAOna4jtPc/gF7CZ
         V509x/YpiIjJC/weNp0MGIXuJHAFOQL590VhmsgpTmg9aRFli3mZpczSvu5KlpSnQibM
         Hll4PEU0dbrRe96ou1hfa86RVkpk5ycVzllCPpcFWevhHC6kMVaZlMa+ZZOt2Ta1KCmG
         2TY83FkHq4/yuTC82dEdbaAC3+M281wXzDGXQ3UemkrCJBIMPt4Qv1LXKIG+KmrzP0LW
         89bw==
X-Gm-Message-State: AO0yUKXjSYuukDW0K4as/t5oqiTFiswpWUcp6nxmQTpSr43k72p79dmx
        PzNT8f9J9IH4lWQM5RUH2u8=
X-Google-Smtp-Source: AK7set/tW/8C0xY/SSAu8Z2l3XOOV0YeweYmNiztltrsp6dMlMz2iIEqWHop066JFj2JpYd1xAM+ng==
X-Received: by 2002:a05:600c:2185:b0:3ed:8780:f27b with SMTP id e5-20020a05600c218500b003ed8780f27bmr8062758wme.16.1679260709651;
        Sun, 19 Mar 2023 14:18:29 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003eddf20ed5bsm2477581wmq.18.2023.03.19.14.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 14:18:28 -0700 (PDT)
Date:   Sun, 19 Mar 2023 21:16:18 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <b4233383-2c87-422f-9f66-3815a6c77372@lucifer.local>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <20230319131047.174fa4e29cabe4371b298ed0@linux-foundation.org>
 <fadd8558-8917-4012-b5ea-c6376c835cc8@lucifer.local>
 <ZBd00i7fvwrMX/FY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBd00i7fvwrMX/FY@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 19, 2023 at 08:47:14PM +0000, Matthew Wilcox wrote:
> On Sun, Mar 19, 2023 at 08:29:16PM +0000, Lorenzo Stoakes wrote:
> > The basis for saying asynchronous was based on Documentation/filesystems/vfs.rst
> > describing read_iter() as 'possibly asynchronous read with iov_iter as
> > destination', and read_iter() is what is (now) invoked when accessing
> > /proc/kcore.
> >
> > However I agree this is vague and it is clearer to refer to the fact that we are
> > now directly writing to user memory and thus wish to avoid spinlocks as we may
> > need to fault in user memory in doing so.
> >
> > Would it be ok for you to go ahead and replace that final paragraph with the
> > below?:-
> >
> > The reason for making this change is to build a basis for vread() to write
> > to user memory directly via an iterator; as a result we may cause page
> > faults during which we must not hold a spinlock. Doing this eliminates the
> > need for a bounce buffer in read_kcore() and thus permits that to be
> > converted to also use an iterator, as a read_iter() handler.
>
> I'd say the purpose of the iterator is to abstract whether we're
> accessing user memory, kernel memory or a pipe, so I'd suggest:
>
>    The reason for making this change is to build a basis for vread() to
>    write to memory via an iterator; as a result we may cause page faults
>    during which we must not hold a spinlock. Doing this eliminates the
>    need for a bounce buffer in read_kcore() and thus permits that to be
>    converted to also use an iterator, as a read_iter() handler.
>

Thanks, sorry I missed the detail about iterators abstacting the three
different targets there, that is definitely better!

> I'm still undecided whether this change is really a good thing.  I
> think we have line-of-sight to making vmalloc (and thus kvmalloc)
> usable from interrupt context, and this destroys that possibility.
>
> I wonder if we can't do something like prefaulting the page before
> taking the spinlock, then use copy_page_to_iter_atomic()

There are a number of aspects of vmalloc that are not atomic-safe,
e.g. alloc_vmap_area() and vmap_range_noflush() are designated
might_sleep(), equally vfree().

So I feel that making it safe for atomic context requires a bit more of a
general rework. Given we would be able to revisit lock types at the point
we do that (something that would fit very solidly into the context of any
such change), and given that this patch series establishes that we use an
iterator, I think it is useful to keep this as-is as defer that change
until later.
