Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD27122D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 11:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbjEZJA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 05:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242378AbjEZJA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 05:00:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63F8119;
        Fri, 26 May 2023 02:00:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30ab87a1897so245417f8f.1;
        Fri, 26 May 2023 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685091624; x=1687683624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qss+zxEtzgocrouex16BhRqrU2936RxdIAYJmgdoCvo=;
        b=MbStjYhHUzFc8ILRIy/UykQjsaI3qWMrTCSLE4yyRrdoWKoyQHKS18s+UxIXuXz0ob
         1+tBeGkdZzgxM0fnFYmZo8klcndWIROQO8qqQnuSJYjvMYGO7jZreoeWx7uylUqKgEEp
         8ZnZIXPXpM3/P0CryvcxTY1dk7JK/h0qAf6KRgES785Fj2V/aul/qY2OQmqLHtBTTiXR
         6egji2GEcafG7yYfFUZfPwmiGiHaOZCetl1jjVVH0eN1lZYxVG/em58qiy1wHY8qbb9o
         XWTtKi17FDMgoPMHhgYEaeFYHXdmmGQaQVjEy43D/xZNZHFj8mTyQ6mnAMNKxJDJSPk3
         UafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685091624; x=1687683624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qss+zxEtzgocrouex16BhRqrU2936RxdIAYJmgdoCvo=;
        b=KLjxMNdFiRVhITsdfxIXqZlHrH6qpoWPwp5VIboRVCpRswyS02r3ca8o4JwPwnKGAr
         yugZYOabypEniLevsRDK4n0MHqhPBXiPS9VN8Q9ZpmU41KTCpN57HAvViJVp/2HwrQcl
         odo34klLBSj0nf95ia3ry7/UdA/wHowgrC5YpPVHefQQGLXZiOjqoGJHTBtCepXgHuyg
         JhsKk2zCBN118pm/NiIBYwWvT/KDVoCmc9DJhtmOD2oSDGsfWf1ajUa43qcoDGndGGvZ
         VbEDQageq9yODyecNqtKTV/+WIl3u1wdIlZM2MiQLiSjc8svUrTHKzIA2m31aWDK83n5
         7lsw==
X-Gm-Message-State: AC+VfDy/heRQ8BlT+oxyZTWESaqh9iue+ic9aWaQxXLzwNTuRirUuCL+
        h9ZsYaNc3xwX5u8eIHq4B44=
X-Google-Smtp-Source: ACHHUZ5EkZrkFXdnKG+OsSeolqc727IKNW5Swk1R+LzKGKOjvK629ibzmcfNdrXmo0Z/6uqU4u/JlQ==
X-Received: by 2002:adf:dfcc:0:b0:30a:dd15:bb69 with SMTP id q12-20020adfdfcc000000b0030add15bb69mr75933wrn.18.1685091623852;
        Fri, 26 May 2023 02:00:23 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b003062b2c5255sm4448182wrm.40.2023.05.26.02.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 02:00:23 -0700 (PDT)
Date:   Fri, 26 May 2023 09:58:12 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Message-ID: <4f479af6-2865-4bb3-98b9-78bba9d2065f@lucifer.local>
References: <89c7f535-8fc5-4480-845f-de94f335d332@lucifer.local>
 <20230525223953.225496-1-dhowells@redhat.com>
 <20230525223953.225496-2-dhowells@redhat.com>
 <520730.1685090615@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520730.1685090615@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 09:43:35AM +0100, David Howells wrote:
> Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> > I guess we're not quite as concerned about FOLL_GET because FOLL_GET should
> > be ephemeral and FOLL_PIN (horrifically) adds GUP_PIN_COUNTING_BIAS each
> > time?
>
> It's not that - it's that iov_iter_get_pages*() is a lot more commonly used at
> the moment, and we'd have to find *all* the places that things using that hand
> refs around.
>
> iov_iter_extract_pages(), on the other hand, is only used in two places with
> these patches and the pins are always released with unpin_user_page*() so it's
> a lot easier to audit.

Thanks for the clarification. I guess these are the cases where you're likely to
see zero page usage, but since this is changing all PUP*() callers don't you
need to audit all of those too?

>
> I could modify put_page(), folio_put(), etc. to ignore the zero pages, but
> that might have a larger performance impact.
>
> > > +		if (is_zero_page(page))
> > > +			return page_folio(page);
> > > +
> >
> > This will capture huge page cases too which have folio->_pincount and thus
> > don't suffer the GUP_PIN_COUNTING_BIAS issue, however it is equally logical
> > to simply skip these when pinning.
>
> I'm not sure I understand.  The zero page(s) is/are single-page folios?

I'm actually a little unsure of how huge zero pages are handled (not an area I'm
hugely familiar with) so this might just be mistaken, I mean the point was more
so that hugetlb calls into this, but seems then not an issue.

>
> > This does make me think that we should just skip pinning for FOLL_GET cases
> > too - there's literally no sane reason we should be pinning zero pages in
> > any case (unless I'm missing something!)
>
> As mentioned above, there's a code auditing issue and a potential performance
> issue, depending on how it's done.

Ack, makes sense. It'd be good to have this documented somewhere though in
commit msg or docs so this trade-off is clear.

>
> > Another nitty thing that I noticed is, in is_longterm_pinnable_page():-
> >
> > 	/* The zero page may always be pinned */
> > 	if (is_zero_pfn(page_to_pfn(page)))
> > 		return true;
> >
> > Which, strictly speaking I suppose we are 'pinning' it or rather allowing
> > the pin to succeed without actually pinning, but to be super pedantic
> > perhaps it's worth updating this comment too.
>
> Yeah.  It is "pinnable" but no pin will actually be added.

The comment striks me as misleading, previously it literally meant that you
could pin the zero page. Now it means that we just don't. I do think for the
sake of avoiding confusion this should be tweaked.

Obviously something of a nit, however!

I did dig into this change a fair bit and kept adding then deleting comments
since you cover all the bases well, so overall this is nice + I can but nit it
:) Nice to see further improvements to GUP which is crying out for that.

>
> David
>
>
