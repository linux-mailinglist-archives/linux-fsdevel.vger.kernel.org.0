Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39896BA64E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 05:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCOEk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 00:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCOEk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:40:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4665F59E6F;
        Tue, 14 Mar 2023 21:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XQn9K+UzLrDPyuo7ook5H7WpKOw9ZxwwCdJZVb5L5bI=; b=bOXTATtvTMVgkMtGn99pO6U6Fp
        tl+KKVNcUxqRyjy5Ksj1fNnzkk0cWk/in2soDZDKwIb1SwCo3t+aSmj2hlGAZJjqsdVhk9xZrndAg
        ealIn6kACDzAwDN9aCaw9penuSta6TodFASiTCU/ba+VP5EocNPKjJod5JMnsZAkF/l+qMbn6/up/
        sUdV5CH2rQFU0G9V6VIA510azfRt23Cs3u/MMuDbb5U+dPRYOr0RQ70m8q+0kRv9GAygWVZePeJLx
        q4hO9KYZXyxFMP1tEyJ/ypy3lQzugJfBiFqJc2PTwUcliTN95hMdGoiEp1jIVFiWUp+kqyxuJI6iV
        qfxXkHSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcIwR-00DWwO-L8; Wed, 15 Mar 2023 04:40:47 +0000
Date:   Wed, 15 Mar 2023 04:40:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/31] ext4: Convert ext4_block_write_begin() to take a
 folio
Message-ID: <ZBFMT6L0QqpDcWNm@casper.infradead.org>
References: <ZAWj4FHczOQwwEbK@casper.infradead.org>
 <87r0u129di.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0u129di.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 08:51:45PM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Mon, Mar 06, 2023 at 12:21:48PM +0530, Ritesh Harjani wrote:
> >> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
> >>
> >> > All the callers now have a folio, so pass that in and operate on folios.
> >> > Removes four calls to compound_head().
> >>
> >> Why do you say four? Isn't it 3 calls of PageUptodate(page) which
> >> removes calls to compound_head()? Which one did I miss?
> >>
> >> > -	BUG_ON(!PageLocked(page));
> >> > +	BUG_ON(!folio_test_locked(folio));
> >
> > That one ;-)
> 
> __PAGEFLAG(Locked, locked, PF_NO_TAIL)
> 
> #define __PAGEFLAG(uname, lname, policy)				\
> 	TESTPAGEFLAG(uname, lname, policy)				\
> 	__SETPAGEFLAG(uname, lname, policy)				\
> 	__CLEARPAGEFLAG(uname, lname, policy)
> 
> #define TESTPAGEFLAG(uname, lname, policy)				\
> static __always_inline bool folio_test_##lname(struct folio *folio)	\
> { return test_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
> static __always_inline int Page##uname(struct page *page)		\
> { return test_bit(PG_##lname, &policy(page, 0)->flags); }
> 
> How? PageLocked(page) doesn't do any compount_head() calls no?

You missed one piece of the definition ...

#define PF_NO_TAIL(page, enforce) ({                                    \
                VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);     \
                PF_POISONED_CHECK(compound_head(page)); })


