Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F309C722C52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjFEQQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 12:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjFEQQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:16:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8B4E6;
        Mon,  5 Jun 2023 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iB0H24zQ9afWpiMzWIwA6kDQKADXkA7aEQwZd0XdpsA=; b=m1O3EZaCKVFyHwnXGLY+agmDGy
        uLRg+gJBkoUMCaBPEWqnkoI8H0gdXoBfkXZRKoyMpiQS67KtZwDowayW/o7j1aNb77kgw2JW1IjdN
        kAwqOAbTNOdxFB5dNwXUNQG/iG+M3bPEDkDDom38C+jCReOe29+2GeQpBkMuZOKZBWCDUqrqXb+F3
        55o4w4UTsNbGMvuVdJLE4EDi1BFYfnDlMLyxIu6oFzhkff6keZwHy//GUxRJryauhBnw4Y+pBMwnD
        X356IEnJizGQOa7E11kKIo4aeYHwsjyy3whFG0xEqt3cK9OnJJMFfWd1aNOAyNZBqoXF5+JK1pUop
        UaZ4spnA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6Csq-00CBDa-6x; Mon, 05 Jun 2023 16:16:40 +0000
Date:   Mon, 5 Jun 2023 17:16:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: DIO hangs in 6.4.0-rc2
Message-ID: <ZH4KaEtLS1bdSl1c@casper.infradead.org>
References: <ZGN20Hp1ho/u4uPY@casper.infradead.org>
 <ZGP/H1UQgMYemYP1@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGP/H1UQgMYemYP1@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 08:09:35AM +1000, Dave Chinner wrote:
> On Tue, May 16, 2023 at 01:28:00PM +0100, Matthew Wilcox wrote:
> > Plain 6.4.0-rc2 with a relatively minor change to the futex code that
> > I cannot believe was in any way responsible for this.
> > 
> > kworkers blocked all over the place.  Some on XFS_ILOCK_EXCL.  Some on
> > xfs_buf_lock.  One in xfs_btree_split() calling wait_for_completion.
> > 
> > This was an overnight test run that is now dead, so I can't get any
> > more info from the locked up kernel.  I have the vmlinux if some
> > decoding of offsets is useful.
> 
> This is likely the same AGF try-lock bug that was discovered in this
> thread:
> 
> https://lore.kernel.org/linux-xfs/202305090905.aff4e0e6-oliver.sang@intel.com/
> 
> The fact that the try-lock was ignored means that out of order AGF
> locking can be attempted, and the try-lock prevents deadlocks from
> occurring.
> 
> Can you try the patch below - I was going to send it for review
> anyway this morning so it can't hurt to see if it also fixes this
> issue.

I still have this patch in my tree and it's not in rc5.  Was this
problem fixed some other way, or does it still need to land upstream?
I don't see any changes to XFS since May 11th's pull request.
