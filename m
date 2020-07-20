Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47737225AAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 11:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGTJBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 05:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTJBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:01:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA252C061794;
        Mon, 20 Jul 2020 02:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LZEFw1oLYgj4zsscQtdY4wJjNPA8ihmwOeaubjV41Pk=; b=oc0IUr21+u3R3HHyVc1+ohxgyl
        2z+5E1O/YRnEKTIQlTiPNRaYbA9cD+zV/YrdzOno4RV55SiABJACPM7N5pw4qV1fgUX76id9TMEVF
        zlLv6R4dbfd15db/jFUWEJjrDIfhxSBWh6Ppfrc/542neYLxXw5lVC0IK6Q8EIspILT+WikBiEMFm
        0snzsabiSnAyw2g0n3gT6UpKBvBc+w/09bOD0GIvfWR3Q3vOd2DG2VB+BevBiTQ3nVvn653RJjnps
        kpaxpkGT07Um/Fy19L2KrvtATLeo5rbgftQhXX3NnDWasECY0nmtJIF1oklga9nIuHvB+NcLQQz3M
        DKVkdjWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxRfI-0000Iv-3d; Mon, 20 Jul 2020 09:00:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A99F0300446;
        Mon, 20 Jul 2020 11:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91FED23646C08; Mon, 20 Jul 2020 11:00:50 +0200 (CEST)
Date:   Mon, 20 Jul 2020 11:00:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200720090050.GK10769@hirez.programming.kicks-ass.net>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
 <20200718052818.GF2183@sol.localdomain>
 <20200720020731.GQ5369@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720020731.GQ5369@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 12:07:31PM +1000, Dave Chinner wrote:
> The whole serialisation/atomic/ordering APIs have fallen badly off
> the macro cliff, to the point where finding out something as simple
> as the order of parameters passed to cmpxchg and what semantics it
> provides requires macro-spelunking 5 layers deep to find the generic
> implementation function that contains a comment describing what it
> does....
> 
> That's yet another barrier to understanding what all the different
> synchronisation primitives do.

Documentation/atomic_t.txt ?
