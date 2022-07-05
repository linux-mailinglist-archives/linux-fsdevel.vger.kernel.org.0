Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FAF5676A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 20:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiGESjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiGESi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:38:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED213F5B
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jul 2022 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6RPq7cN/EKPxe41EPw79+WsV/zNfqmD092l1jJM25F4=; b=inTN5klWhRzdX57bjJ0M6fqTJG
        UwFMhsGIXvA4PiGKclQSUO3FyHzu8AldeXcbOs8OOOmrJNa2CgvUV56NMRlME0jmkeSQbX9Rm6Wjz
        fkMTcac7wNX9psxKqgCSlTST1ho6AJsdfgW1IFCuMaaCi9i0Vrf6Jk+PBsEEWOuvG0+ydR7yRh/X6
        uwKfZMznNYM6xnM4BlMBK2B+gBY1KNqGGF/cjJVyFWuKdX6iC2Sue1vvrSIONEq672fgnTE1/e0Gu
        nVpPKsUeFjP/CASv0+FiB63iy6/6i0UkOyfs/nlqYdPoi1EvtwTzviEUQFHOksIl9OoiJSpECD5qZ
        gcUkKxRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8nRl-000p83-Im; Tue, 05 Jul 2022 18:38:53 +0000
Date:   Tue, 5 Jul 2022 19:38:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: XArray multiple marks support
Message-ID: <YsSFPXR4SYlHiQaI@casper.infradead.org>
References: <Yr3Fum4Gb9sxkrB3@zen>
 <YsNqmIQP7LTs/vXB@casper.infradead.org>
 <YsR8h34aNzHiS3EY@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsR8h34aNzHiS3EY@zen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 11:01:43AM -0700, Boris Burkov wrote:
> > Unfortunately, I don't think doing this will work out really well for
> > you.  The bits really are independent of each other, and the power of
> > the search marks lies in their ability to skip over vast swathes of
> > the array when they're not marked.  But to do what you want, we'd end up
> > doing something like this:
> > 
> > leaf array 1:
> >   entry 0 is in category 1
> >   entry 1 is in category 2
> >   entry 2 is in category 5
> > 
> > and now we have to set all three bits in the parent of leaf array 1,
> > so any search will have to traverse all of leaf array 1 in order to find
> > out whether there are any entries in the category we're looking for.
> 
> Thank you for the explanation. To check my understanding, does this
> point also imply that currently the worst case for marked search is if
> every leaf array has an entry with each mark set?

Yes.  Each leaf array is 64 entries, and the tags are stored at the end
of the node.  A mark search consists of scanning one of the three
bitmaps.  Which means we have to load two cachelines (both the header
and the mark array) out of each node which has a mark set.  We can
avoid accessing six or seven of the nine cachelines if only one
bit is set, but with the amount of prefetching CPUs do these days,
I don't know how effective that is.

I keep meaning to try moving the mark array from the end of the
node to the header, but I worry it'll hurt non-marked lookups.
