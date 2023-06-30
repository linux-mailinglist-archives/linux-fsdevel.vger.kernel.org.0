Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228BB743350
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 05:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjF3DsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 23:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF3DsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 23:48:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C2C2695;
        Thu, 29 Jun 2023 20:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mLErujKCxnHxWmPdMQxMq1pzJ9BcSmvolBjr/rkB8IM=; b=AOx50gsTTRZJfWObn1a4I7aZWQ
        HkKBvjPWlOhSroaATP4aCv6wxMtpJdnbQSc6uLkBNu/MEoe/nT/tG+qNUzuCbXb5Fi+hveuLMactT
        0bCvFBTK+1ghjbZJmoHEwYX4a/28B9HtXIHOUFP95UaIytwtahfkx+agHJdOjETACTWSXvCBEjyfW
        VO3zimcmN/g+byjx9HGVVwV5porjIlhNSfaSReqvm0qYN7qwnYiKBJF23MjLWf5g1fJF8+90pZkzo
        cew2yEm62L0UVKYC3iHk+vtoA7Z+RCpe0kWHbnQ5ryuKmcSrLvBElZkt0U1QHNzbxB0SPfe5G+WVe
        qTWDxpXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qF56N-005OmN-3m; Fri, 30 Jun 2023 03:47:19 +0000
Date:   Fri, 30 Jun 2023 04:47:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v6 4/6] mm: change folio_lock_or_retry to use vm_fault
 directly
Message-ID: <ZJ5QR5q2WtD2z1rd@casper.infradead.org>
References: <20230630020436.1066016-1-surenb@google.com>
 <20230630020436.1066016-5-surenb@google.com>
 <ZJ5NzJDY0XPt8ui1@casper.infradead.org>
 <CAJuCfpH7uBPS4v24MEh_4XTfJ1bz3oUhHGvtNY=XwoicXc8_XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH7uBPS4v24MEh_4XTfJ1bz3oUhHGvtNY=XwoicXc8_XA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 08:45:39PM -0700, Suren Baghdasaryan wrote:
> On Thu, Jun 29, 2023 at 8:36 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Jun 29, 2023 at 07:04:33PM -0700, Suren Baghdasaryan wrote:
> > > Change folio_lock_or_retry to accept vm_fault struct and return the
> > > vm_fault_t directly.
> >
> > I thought we decided to call this folio_lock_fault()?
> >
> > > +static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
> > > +                                          struct vm_fault *vmf)
> > >  {
> > >       might_sleep();
> > > -     return folio_trylock(folio) || __folio_lock_or_retry(folio, mm, flags);
> > > +     return folio_trylock(folio) ? 0 : __folio_lock_or_retry(folio, vmf);
> >
> > No, don't use the awful ternary operator.  The || form is used
> > everywhere else.
> 
> Ok, but folio_trylock() returns a boolean while folio_lock_or_retry
> should return vm_fault_t. How exactly do you suggest changing this?
> Something like this perhaps:
> 
> static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
>                                           struct vm_fault *vmf)
> {
>      might_sleep();
>      if (folio_trylock(folio))
>          return 0;
>      return __folio_lock_or_retry(folio, mm, flags);
> }
> 
> ?

I think the automatic casting would work, but I prefer what you've
written here.

> > >  /*
> > >   * Return values:
> > > - * true - folio is locked; mmap_lock is still held.
> > > - * false - folio is not locked.
> > > + * 0 - folio is locked.
> > > + * VM_FAULT_RETRY - folio is not locked.
> >
> > I don't think we want to be so prescriptive here.  It returns non-zero
> > if the folio is not locked.  The precise value is not something that
> > callers should depend on.
> 
> Ok, I'll change it to "non-zero" here.

Thanks!
