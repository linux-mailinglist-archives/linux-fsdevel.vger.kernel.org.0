Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF78371F1A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhECSEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 14:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhECSED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 14:04:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E33C06174A;
        Mon,  3 May 2021 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+H0Hi3CVfZbTV4jOta7Vcr+f479yzjS5Q7k8m0i2cJI=; b=DlprNe8rI/W/NJfmwROlevasK5
        kH33B6c49vJh6YAiPwSBiiK7NAWG9E+KP6iMmuQREZoxZ2WDX5kL44hFwNos0l5+v9Ori23xK9DFV
        wnFcTUzojtoKj9wukLoGmTNCPXEJbARLXV4Yq+KcNEu2oxI+dsLR6vMtl8Vfzcz/t9dXPNbZK1f1c
        dYSMqbADdMEccfHvvLE++YUw99CbxwJhZOFr77LE04E7GwwNG88U6CXdK6hT0twvrhSs73mj3lcqP
        doPkW8NdO6HixUWEuJ+UrU5v4pzpjAjEPjhKoStfHz4GAMv5hCsEH1wTjzXkjSwU0ZXUoqtrF9rg5
        4sC/g+fw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ldctT-00FRdj-1X; Mon, 03 May 2021 18:02:18 +0000
Date:   Mon, 3 May 2021 19:02:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Laight <David.Laight@aculab.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eventfd: convert to using ->write_iter()
Message-ID: <20210503180207.GD1847222@casper.infradead.org>
References: <7b98e3c2-2d9f-002b-1da1-815d8522b594@kernel.dk>
 <de316af8f88947fabd1422b04df8a66e@AcuMS.aculab.com>
 <7caa3703-af14-2ff6-e409-77284da11e1f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7caa3703-af14-2ff6-e409-77284da11e1f@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 03, 2021 at 11:57:08AM -0600, Jens Axboe wrote:
> On 5/3/21 10:12 AM, David Laight wrote:
> > From: Jens Axboe
> >> Sent: 03 May 2021 15:58
> >>
> >> Had a report on writing to eventfd with io_uring is slower than it
> >> should be, and it's the usual case of if a file type doesn't support
> >> ->write_iter(), then io_uring cannot rely on IOCB_NOWAIT being honored
> >> alongside O_NONBLOCK for whether or not this is a non-blocking write
> >> attempt. That means io_uring will punt the operation to an io thread,
> >> which will slow us down unnecessarily.
> >>
> >> Convert eventfd to using fops->write_iter() instead of fops->write().
> > 
> > Won't this have a measurable performance degradation on normal
> > code that does write(event_fd, &one, 4);
> 
> If ->write_iter() or ->read_iter() is much slower than the non-iov
> versions, then I think we have generic issues that should be solved.

We do!

https://lore.kernel.org/linux-fsdevel/20210107151125.GB5270@casper.infradead.org/
is one thread on it.  There have been others.

> That should not be a consideration, since the non-iov ones are
> legacy and should not be adopted in new code.
> 
> -- 
> Jens Axboe
> 
