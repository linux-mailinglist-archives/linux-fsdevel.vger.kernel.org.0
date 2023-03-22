Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80CD6C488A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 12:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCVLGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCVLGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:06:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4647403;
        Wed, 22 Mar 2023 04:06:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l12so16570100wrm.10;
        Wed, 22 Mar 2023 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679483176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtfuFWofT6zWs9wizodfMqROAedt5NIA2iASaJ8aIFA=;
        b=Xhi37l1CUKKylXAxNFEF0ItUK/OoMdH4RfIpyIabWD0a4ZcN6E04FZ2ZpQBHlhPFv2
         JAeqFKXy1Q6iQ5P6JDql0qdzM7c4YSdcrImzHFbPn/5Vfc7N5PsYevGG6EqV1YPjCP32
         bCZCuI14sD2xLjmz+hexrv5KzHyjoDLukO+7iK4VlFLYuxvZFNP+ilKgYs+c7XIWmRh/
         nz+zqMGYXrv/dRsMfudfmrL0c1wwR0SYsDHXwme3dC5ynIJ5HT4W3GrvZicEhtd1wI07
         Buu31VCWxztVEbmiwwF3WRA/YmxskzgnbzaZy58Tz0ynv5qw3VdqVXH1pyUN42IJu3W5
         cYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679483176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtfuFWofT6zWs9wizodfMqROAedt5NIA2iASaJ8aIFA=;
        b=8Q2fAi7/TW6xGMJ3cynahfRnESHhQEZdYr+9eJYA6bhANC19mg6iGjhZZ4sgwSmYAd
         oLOcu23bsqYeeD2qWvah71PHBJ4KjktOfhbv9xOjqWzc27udWDI8sx2rLndGSBEntbvf
         ve05MTRNYT2d3jwW6Oy1x4WlKUJ52VY2ndoiKd8CWome1kBTSEqF0ByB+0vXFviwEYsJ
         785AFsMYXNfX2+bnmaTqKsEa/E+u2uls8TyM95Yb6gzG1iZg6wmZKfS09pcWFgU1p5ea
         9LgrR9KCpHtn3AIr5b9X7i2hXA9Lh7wPf36r3dWd3+UNtMm65ggafwHnFIAitOqNXkX3
         0j+Q==
X-Gm-Message-State: AO0yUKVJICeDyaejBQK1Gl3J+V+oZ+7GzrqPTFsdfhLEaKgbGVfsZ0i1
        GcWxw5Hcla06mbc/2EMOFLE=
X-Google-Smtp-Source: AK7set9YJMroCXiENaXXrpyy1UCHF5W2WJbwT4Jgfv9ktjhLsV+ZfC2/POI2lqauld3RPwtSLeB1UQ==
X-Received: by 2002:a5d:5221:0:b0:2cd:e089:398d with SMTP id i1-20020a5d5221000000b002cde089398dmr1286694wra.5.1679483176335;
        Wed, 22 Mar 2023 04:06:16 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id m9-20020adffa09000000b002c70d97af78sm13647255wrr.85.2023.03.22.04.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:06:15 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:06:14 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 3/4] iov_iter: add copy_page_to_iter_atomic()
Message-ID: <a9e62a20-13eb-464b-9452-9d7bb2566e85@lucifer.local>
References: <cover.1679431886.git.lstoakes@gmail.com>
 <31482908634cbb68adafedb65f0b21888c194a1b.1679431886.git.lstoakes@gmail.com>
 <ZBrVtcqATRybF/hW@MiWiFi-R3L-srv>
 <a961ab9c-1ced-4db4-a76f-d886bd01c715@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a961ab9c-1ced-4db4-a76f-d886bd01c715@lucifer.local>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 10:32:47AM +0000, Lorenzo Stoakes wrote:
> > I am a little confused about the name of this new function. In its
> > conterpart, copy_page_from_iter_atomic(), kmap_atomic()/kunmpa_atomic()
> > are used. With them, if CONFIG_HIGHMEM=n, it's like below:
>
> The reason for this is that:-
>
> 1. kmap_atomic() explicitly states that it is now deprecated and must no longer
>    be used, and kmap_local_page() should be used instead:-
>
>  * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
>
>  * Do not use in new code. Use kmap_local_page() instead.
>
> 2. kmap_local_page() explicitly states that it can be used in any context:-
>
>  * Can be invoked from any context, including interrupts.
>
> I wanted follow this advice as strictly as I could, hence the change. However,
> we do need preemption/pagefaults explicitly disabled in this context (we are
> happy to fail if the faulted in pages are unmapped in meantime), and I didn't
> check the internals to make sure.
>
> So I think for safety it is better to use k[un]map_atomic() here, I'll respin
> and put that back in, good catch!
>

Actually, given we have preemption disabled due to the held spinlock, I think
it'd be better to add a copy_page_to_iter_nofault() that uses
copy_to_user_nofault() which will disable pagefaults thus have exactly the
equivalent behaviour, more explicitly and without the use of a deprecated
function.

Thanks for raising this!!

> >
> > static inline void *kmap_atomic(struct page *page)
> > {
> >         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >                 migrate_disable();
> >         else
> >                 preempt_disable();
> >         pagefault_disable();
> >         return page_address(page);
> > }
> >
> > But kmap_local_page() is only having page_address(), the code block
> > between kmap_local_page() and kunmap_local() is also atomic, it's a
> > little messy in my mind.
> >
> > static inline void *kmap_local_page(struct page *page)
> > {
> >         return page_address(page);
> > }
> >
> > > +	char *p = kaddr + offset;
> > > +	size_t copied = 0;
> > > +
> > > +	if (!page_copy_sane(page, offset, bytes) ||
> > > +	    WARN_ON_ONCE(i->data_source))
> > > +		goto out;
> > > +
> > > +	if (unlikely(iov_iter_is_pipe(i))) {
> > > +		copied = copy_page_to_iter_pipe(page, offset, bytes, i);
> > > +		goto out;
> > > +	}
> > > +
> > > +	iterate_and_advance(i, bytes, base, len, off,
> > > +		copyout(base, p + off, len),
> > > +		memcpy(base, p + off, len)
> > > +	)
> > > +	copied = bytes;
> > > +
> > > +out:
> > > +	kunmap_local(kaddr);
> > > +	return copied;
> > > +}
> > > +EXPORT_SYMBOL(copy_page_to_iter_atomic);
> > > +
> > >  static void pipe_advance(struct iov_iter *i, size_t size)
> > >  {
> > >  	struct pipe_inode_info *pipe = i->pipe;
> > > --
> > > 2.39.2
> > >
> >
