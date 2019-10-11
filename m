Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9265CD417F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 15:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfJKNjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 09:39:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42786 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfJKNjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fdMe6cL6Uk37LOFczS5vgqxs2TCG8T5VUGagwWOW2o0=; b=F4yA5MdUoG1tVIls/gBlimaPMp
        WtDnwEIL7aV4Nd12pNip8rGAfAJDN1beLlinen3KE/SkqeiCNceOUaJ5I3ztinH0qKzMxxqxjhG+t
        bba+/drYqY64YMPAutj20ik4URd3F5/bAMH9J29hbjYPUD7PB0RgexHUvxZdiqOLwYMvp82lz4GHq
        VMlU3CDcsJM6Gemsn0ySieH+pcnQLVr6XOVUZtM1n7Bdg6I0XXFwZjhB8/NMmLVD27mr3yCCyvElj
        OQPzT55mPghtUoLWJCR8IrsjIY/fp8xzGEsYnjdQkGfIPINLgF4w8d7do7AcQcBgDk85zAsbJxxxa
        VzbsrJQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIv8i-00089i-Q5; Fri, 11 Oct 2019 13:39:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 919BA301224;
        Fri, 11 Oct 2019 15:38:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 402A22023D649; Fri, 11 Oct 2019 15:39:26 +0200 (CEST)
Date:   Fri, 11 Oct 2019 15:39:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 25/26] xfs: rework unreferenced inode lookups
Message-ID: <20191011133926.GY2328@hirez.programming.kicks-ass.net>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-26-david@fromorbit.com>
 <20191011125522.GA13167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191011125522.GA13167@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 05:55:22AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 09, 2019 at 02:21:23PM +1100, Dave Chinner wrote:

> > @@ -131,6 +132,7 @@ xfs_inode_free(
> >  	 * free state. The ip->i_flags_lock provides the barrier against lookup
> >  	 * races.
> >  	 */
> > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> 
> This introduceѕ a non-owner unlock of an exclusively held rwsem.  As-is
> this will make lockdep very unhappy.  We have a non-owner unlock version
> of up_read, but not of up_write currently.  I'm also not sure if those
> are allowed from RCU callback, which IIRC can run from softirq context.
> 
> That being said this scheme of only unlocking the inode in the rcu free
> callback makes totaly sense to me, so I wish we can accomodate it
> somehow.

I'm thinking that, barring the little issue of not actually having the
function, up_write_non_owner() should work from RCU callback context.
That is, I don't see rwsem_wake() do anything not allowed there.
