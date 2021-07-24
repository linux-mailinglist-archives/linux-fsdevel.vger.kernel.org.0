Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB4D3D4915
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhGXRdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhGXRdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 13:33:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC88EC061575;
        Sat, 24 Jul 2021 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w8yKGTD/K4w2fC7pZFl5Bs3NRSbkCF/Y0TLmM7Sde20=; b=l3twtMHxEoCrMzv/WZ2WQYxlgE
        fFExxVJhEit1ghlINmX1ue8wIBc8CaCq7YziFHUe1MKap/XZje8Ujcu9UDuSkwSLPdirHlV/NYxGE
        i0m7iM8fyMOt6/+Hvc0qquHlEWDf0lUGtavMG2C2+piXlkftDYnEM0CcstMNz4AU1m0MrFq5YTcXP
        YBFh2cfXasMuHxQVznQyudJdMs19qOIIxR6E9LwWo9ZT6aPP/laK8BB+01sIUGzOFsz1qX2cxUrEu
        fMJIKVYr/+CD7S1eLHXVYGY+j+Iv2zEgjSMvORafDqSjhr++LlwuTg+th23/0nX3Bp7PzEEQKkXPn
        3L7E02ww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7MAA-00CSBO-B0; Sat, 24 Jul 2021 18:14:15 +0000
Date:   Sat, 24 Jul 2021 19:14:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andres Freund <andres@anarazel.de>,
        Michael Larabel <Michael@michaellarabel.com>
Subject: Re: Folios give an 80% performance win
Message-ID: <YPxYdhEirWL0XExY@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <YPxNkRYMuWmuRnA5@casper.infradead.org>
 <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 11:09:02AM -0700, James Bottomley wrote:
> On Sat, 2021-07-24 at 18:27 +0100, Matthew Wilcox wrote:
> > What blows me away is the 80% performance improvement for PostgreSQL.
> > I know they use the page cache extensively, so it's plausibly real.
> > I'm a bit surprised that it has such good locality, and the size of
> > the win far exceeds my expectations.  We should probably dive into it
> > and figure out exactly what's going on.
> 
> Since none of the other tested databases showed more than a 3%
> improvement, this looks like an anomalous result specific to something
> in postgres ... although the next biggest db: mariadb wasn't part of
> the tests so I'm not sure that's definitive.  Perhaps the next step
> should be to test mariadb?  Since they're fairly similar in domain
> (both full SQL) if mariadb shows this type of improvement, you can
> safely assume it's something in the way SQL databases handle paging and
> if it doesn't, it's likely fixing a postgres inefficiency.

I think the thing that's specific to PostgreSQL is that it's a heavy
user of the page cache.  My understanding is that most databases use
direct IO and manage their own page cache, while PostgreSQL trusts
the kernel to get it right.

Regardless of whether postgres is "doing something wrong" or not,
do you not think that an 80% performance win would exert a certain
amount of pressure on distros to do the backport?
