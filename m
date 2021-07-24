Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F05C3D4926
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 20:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhGXRm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 13:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGXRm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 13:42:56 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBF2C061575;
        Sat, 24 Jul 2021 11:23:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5670212804B8;
        Sat, 24 Jul 2021 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1627151007;
        bh=fbGrVZPpfO8ojqmcjNkXJzHQko3i7pa0hWwlLZqllMc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YEEPxFlAmgXca92ncaVcjFkyPKS01sYb+gMbVo7x3mbWicxMdAhchlx6CBixALUKD
         KnYKz1LqGLUFhci2nJleUkzImqNvH9FTMRnwv5+F3nJlMHkllbfT/pgsYVdiawbqOC
         3x4HLMbzZDTugEWFjRPDwZBz6RbFvgxdod9wbjW4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uixCSrnBnUCL; Sat, 24 Jul 2021 11:23:27 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B3AC212804A3;
        Sat, 24 Jul 2021 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1627151007;
        bh=fbGrVZPpfO8ojqmcjNkXJzHQko3i7pa0hWwlLZqllMc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YEEPxFlAmgXca92ncaVcjFkyPKS01sYb+gMbVo7x3mbWicxMdAhchlx6CBixALUKD
         KnYKz1LqGLUFhci2nJleUkzImqNvH9FTMRnwv5+F3nJlMHkllbfT/pgsYVdiawbqOC
         3x4HLMbzZDTugEWFjRPDwZBz6RbFvgxdod9wbjW4=
Message-ID: <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
Subject: Re: Folios give an 80% performance win
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andres Freund <andres@anarazel.de>,
        Michael Larabel <Michael@michaellarabel.com>
Date:   Sat, 24 Jul 2021 11:23:25 -0700
In-Reply-To: <YPxYdhEirWL0XExY@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
         <YPxNkRYMuWmuRnA5@casper.infradead.org>
         <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
         <YPxYdhEirWL0XExY@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-07-24 at 19:14 +0100, Matthew Wilcox wrote:
> On Sat, Jul 24, 2021 at 11:09:02AM -0700, James Bottomley wrote:
> > On Sat, 2021-07-24 at 18:27 +0100, Matthew Wilcox wrote:
> > > What blows me away is the 80% performance improvement for
> > > PostgreSQL. I know they use the page cache extensively, so it's
> > > plausibly real. I'm a bit surprised that it has such good
> > > locality, and the size of the win far exceeds my
> > > expectations.  We should probably dive into it and figure out
> > > exactly what's going on.
> > 
> > Since none of the other tested databases showed more than a 3%
> > improvement, this looks like an anomalous result specific to
> > something in postgres ... although the next biggest db: mariadb
> > wasn't part of the tests so I'm not sure that's
> > definitive.  Perhaps the next step should be to t
> > est mariadb?  Since they're fairly similar in domain (both full
> > SQL) if mariadb shows this type of improvement, you can
> > safely assume it's something in the way SQL databases handle paging
> > and if it doesn't, it's likely fixing a postgres inefficiency.
> 
> I think the thing that's specific to PostgreSQL is that it's a heavy
> user of the page cache.  My understanding is that most databases use
> direct IO and manage their own page cache, while PostgreSQL trusts
> the kernel to get it right.

That's testable with mariadb, at least for the innodb engine since the
flush_method is settable. 

> Regardless of whether postgres is "doing something wrong" or not,
> do you not think that an 80% performance win would exert a certain
> amount of pressure on distros to do the backport?

Well, I cut the previous question deliberately, but if you're going to
force me to answer, my experience with storage tells me that one test
being 10x different from all the others usually indicates a problem
with the benchmark test itself rather than a baseline improvement, so
I'd wait for more data.

James


