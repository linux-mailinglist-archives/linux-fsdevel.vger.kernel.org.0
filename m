Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4078872A4C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 22:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjFIUgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 16:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjFIUgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:36:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53514D8;
        Fri,  9 Jun 2023 13:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1AR982kOtQF+PiURss59y7Vq08Tjvm44XyWZD10v/tk=; b=V6NWpN+AMDpXeJNkTRBv3dPtae
        Tzj/JkI2wQxxQB5+Mo6d7F5HHKLFxl8Q7BnvArDllM17cVvskCmCI7XSbvxQaMchNpQZZcOc3oy58
        eBShFLfHl9UU+HUOQ1HRZfMwOkUXe22ME3bo9w3jYLJ3eGxc3UYwngSs4mIkbxMujxNSQ+HiAso6/
        lR/cuWfFrhJHSUEBBaYC0VpyteCgKt8klipw4uzHaGy3QPOVek/hFuxD3lb/jNINC/oL1hG54bSdD
        n/xo/TMYdkUEFvQeR5sil5kuwpf2Z6Rq3v2SavvW4zy7/b7xVeWl8ZZy8J2bmiJvXKcRoeml8+BDb
        TFhJ6rPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7ipp-00H1l0-8n; Fri, 09 Jun 2023 20:35:49 +0000
Date:   Fri, 9 Jun 2023 21:35:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 2/6] mm: handle swap page faults under VMA lock if
 page is uncontended
Message-ID: <ZIONJQGuhYiDnFdg@casper.infradead.org>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-3-surenb@google.com>
 <ZIOKxoTlRzWQtQQR@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIOKxoTlRzWQtQQR@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 04:25:42PM -0400, Peter Xu wrote:
> >  bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
> >  			 unsigned int flags)
> >  {
> > +	/* Can't do this if not holding mmap_lock */
> > +	if (flags & FAULT_FLAG_VMA_LOCK)
> > +		return false;
> 
> If here what we need is the page lock, can we just conditionally release
> either mmap lock or vma lock depending on FAULT_FLAG_VMA_LOCK?

See patch 5 ...
