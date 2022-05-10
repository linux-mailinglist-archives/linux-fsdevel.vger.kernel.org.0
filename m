Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C803522711
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiEJWpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 18:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiEJWpV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 18:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1E20D27B;
        Tue, 10 May 2022 15:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5895061879;
        Tue, 10 May 2022 22:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842DFC385CE;
        Tue, 10 May 2022 22:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652222719;
        bh=l1vmJ0NFpJhLqoL8ubbQwXu5GhzaUzteA5eQtuoCjZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rlDok8GeO8X7D2s4AQahhbSbp5+j7xQn3GIKrXsoo5bV94EUgsSI6+v2KYgijhbWq
         W88/OFU25lbZxW18Y4NFBXRsgqFEzNJNKJMNxigBjR5nhkwy1yTpawfkfwiIxTKuFP
         NNZ/3QoprUqTPXCOy/UcBBWGG/IsTkIJy85A2eOw=
Date:   Tue, 10 May 2022 15:45:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Two folio fixes for 5.18
Message-Id: <20220510154518.0410c1966c37cfa66cfeeab0@linux-foundation.org>
In-Reply-To: <YnrnaoCVjAZfqNvW@casper.infradead.org>
References: <YnRhFrLuRM5SY+hq@casper.infradead.org>
        <20220510151809.f06c7580af34221c16003264@linux-foundation.org>
        <YnrnaoCVjAZfqNvW@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 May 2022 23:30:02 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, May 10, 2022 at 03:18:09PM -0700, Andrew Morton wrote:
> > On Fri, 6 May 2022 00:43:18 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > >  - Fix readahead creating single-page folios instead of the intended
> > >    large folios when doing reads that are not a power of two in size.
> > 
> > I worry about the idea of using hugepages in readahead.  We're
> > increasing the load on the hugepage allocator, which is already
> > groaning under the load.
> 
> Well, hang on.  We're not using the hugepage allocator, we're using
> the page allocator.  We're also using variable order pages, not
> necessarily PMD_ORDER.

Ah, OK, misapprehended.  I guess there remains a fragmentation risk.

>  I was under the impression that we were
> using GFP_TRANSHUGE_LIGHT, but I now don't see that.  So that might
> be something that needs to be changed.
> 
> > The obvious risk is that handing out hugepages to a low-value consumer
> > (copying around pagecache which is only ever accessed via the direct
> > map) will deny their availability to high-value consumers (that
> > compute-intensive task against a large dataset).
> > 
> > Has testing and instrumentation been used to demonstrate that this is
> > not actually going to be a problem, or are we at risk of getting
> > unhappy reports?
> 
> It's hard to demonstrate that it's definitely not going to cause a
> problem.  But I actually believe it will help; by keeping page cache
> memory in larger chunks, we make it easier to defrag memory and create
> PMD-order pages when they're needed.

Obviously it'll be very workload-dependent.
