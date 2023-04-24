Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545D26ED6D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjDXVhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjDXVhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:37:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9125E41;
        Mon, 24 Apr 2023 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6akZipOgCyOOOmc4me7AVkravhWsWCWWq0gvxN0yJCk=; b=BwNGtkc1It9/hiYefg9W7TUb9h
        VfrI4CpsywE7Cn23PP/H+pPg3bB4/+XqhDSzTzI10kylqbr0zUYrtfKH4fpF7jbXmzWPR8BKa9Qxe
        XKxCAxEZBB/y+uegoxqkP7ZVmyZEuO4MLF+cXj0OUyaT/6QvMFZsXhVhD0pvTwULWA5BBKEMhyFpE
        BTpcpzIdLWw5WK77ADuFBGsOP69VgFKamaSs8CInuYF6h37pmVVgHzuNh37CxixhnmfkAH4AYXga6
        fk8t7IeW+KYPfCqzANDRiQXYlLExFCV1eAmYFuyx79OSf0axdIfSK8XcySzi8tnI5++ujeiHIjSga
        xmHQOXWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pr3rl-000pf0-Kd; Mon, 24 Apr 2023 21:36:57 +0000
Date:   Mon, 24 Apr 2023 22:36:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, brauner@kernel.org, djwong@kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/8] shmem: convert to use folio_test_hwpoison()
Message-ID: <ZEb2eYX5btfLrUtQ@casper.infradead.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
 <20230421214400.2836131-3-mcgrof@kernel.org>
 <ZEMRbcHSQqyek8Ov@casper.infradead.org>
 <ZENO4vZzmN8lJocK@bombadil.infradead.org>
 <CAHbLzkoEAJhz8GG91MSM9+wCYVqseSFzBQdVAP78W5WPq26GHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkoEAJhz8GG91MSM9+wCYVqseSFzBQdVAP78W5WPq26GHQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 02:17:12PM -0700, Yang Shi wrote:
> On Fri, Apr 21, 2023 at 8:05 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Fri, Apr 21, 2023 at 11:42:53PM +0100, Matthew Wilcox wrote:
> > > On Fri, Apr 21, 2023 at 02:43:54PM -0700, Luis Chamberlain wrote:
> > > > The PageHWPoison() call can be converted over to the respective folio call
> > > > folio_test_hwpoison(). This introduces no functional changes.
> > >
> > > Um, no.  Nobody should use folio_test_hwpoison(), it's a nonsense.
> > >
> > > Individual pages are hwpoisoned.  You're only testing the head page
> > > if you use folio_test_hwpoison().  There's folio_has_hwpoisoned() to
> > > test if _any_ page in the folio is poisoned.  But blindly converting
> > > PageHWPoison to folio_test_hwpoison() is wrong.
> >
> > Thanks! I don't see folio_has_hwpoisoned() though.
> 
> We do have PageHasHWPoisoned(), which indicates at least one subpage
> is hwpoisoned in the huge page.
> 
> You may need to add a folio variant.

PAGEFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
        TESTSCFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)

That generates folio_has_hwpoisoned() along with
folio_set_has_hwpoisoned(), folio_clear_has_hwpoisoned(),
folio_test_set_has_hwpoisoned() and folio_test_clear_has_hwpoisoned().
