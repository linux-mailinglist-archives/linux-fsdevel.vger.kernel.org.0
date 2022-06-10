Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6586B546F56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 23:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350668AbiFJVji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347712AbiFJVjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:39:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A1156777;
        Fri, 10 Jun 2022 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=99zlQwcPvvmzVYoPFUX+YY7MW7h9pMosRlHEuBShaHg=; b=j0pcJcUhoFLL9W42AkDebG5dD1
        Prv1wLGsIwWJgH71ajx6VId4jx7IrdQtW2vr0q57TuyzgiXxShmbblNvNiTZOMukFvau8Jt7ZUsRN
        5LlRuRPlSwOTOF5zDw2oDmt23MlfaDnFgTilQ0LTdT73c8UtOO1vGH5P5dI6QpxwzaxziL05N3+JJ
        rCEppRaP6+tLzPGhywT8N3BaN2Wltw3My2+/sYSR86cIODQIKi/bkO/DmY4W0dk6nF4ASJ2wnYqlv
        SoliIuV3rf4ctktpIGt6bssq8OBf3twjCFii4UAcVbKPgSwrxqSSBb2+gIf1jPBEBDF0iMLaoNXJE
        8cwF9pGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzmLt-00Elvy-9o; Fri, 10 Jun 2022 21:39:33 +0000
Date:   Fri, 10 Jun 2022 22:39:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Folio fixes for 5.19
Message-ID: <YqO6FaO0/I9Ateze@casper.infradead.org>
References: <YqOZ3v68HrM9LI//@casper.infradead.org>
 <CAHk-=wiyexxiFw5N+TtE5kUk4iF4LaNoY3Pzj7aZcj6Msp+tOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiyexxiFw5N+TtE5kUk4iF4LaNoY3Pzj7aZcj6Msp+tOg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:56:48PM -0700, Linus Torvalds wrote:
> On Fri, Jun 10, 2022 at 12:22 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> >  - Don't release a folio while it's still locked
> 
> Ugh.
> 
> I *hate* this patch. It's just incredibly broken.
> 
> Yes, I've pulled this, but I have looked at that readahead_folio()
> function before, and I have despised it before, but this patch really
> drove home how incredibly broken that function is.
> 
> Honestly, readahead_folio() returns a folio *AFTER* it has dropped the
> ref to that folio.

OK, you caught me.

I realised (a little too late) that the rules around refcounts in
->readpage and ->readahead are different, and that creates pain for
people writing filesystems.  For ->readahead, I stuck with the refcount
model that was in ->readpages (there is an extra refcount on the folio
and the filesystem must put it before it returns).

But I don't want to change the refcounting rules on a method without
changing something else about the method, because trying to find a
missing refcount change is misery.  Anyway, my cunning thought was
that if I bundle the change to the refcount rule with the change
from readahead_page() to readahead_folio(), once all filesystems
are converted to readahead_folio(), I can pull the refcount game out
of readahead_folio() and do it in the caller where it belongs, all
transparent to the filesystems.

I think it's worth doing, because it's two fewer atomic ops per folio
that we read from a file.  But I didn't think through the transition
process clearly enough, and right now it's a mess.  How would you like
me to proceed?

(I don't think the erofs code has a bug because it doesn't remove
the folio from the pagecache while holding the lock -- the folio lock
prevents anyone _else_ from removing the folio from the pagecache,
so there must be a reference on the folio up until erofs calls
folio_unlock()).
