Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311181E0C8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbgEYLLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 07:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390008AbgEYLLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 07:11:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A8C061A0E;
        Mon, 25 May 2020 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HscQaMTsmGaw8uP157lqSogJyf9qiIsG1ero+QB+uhw=; b=JGQkXYmalfLiyF7ZGxs/DOYWNB
        fMfEQZL0wrP+ttc9Bq1Pcdyy6HHD+ejFrPaerxzsaZbdcGsei6ZrRVlBP4Tc2p6ElRB9MHK5LPW4P
        ZKr3yYLEdrwKuPYIiGn9/1/oer/Y8L5N+Aokmw1GYcCwmXml2QO/5sNlXEqKeZcco4KkiGZdyInIN
        tC+r1CKIg6D7EQJVBpcN+d0VHPBet9GDAnJx3uTBmVWo6Y7eAB2maoIdWcZbqL3L5y4YX+WYFj5id
        V/wYmFDaWNTHOAj48j5D/U6XJZg7d8HEr7uq+dy70s3aVaURAqYPTT17UNBqL8kC21wFUqlTK/Hpb
        1uRYrmeQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdB0k-0005Ls-FQ; Mon, 25 May 2020 11:11:14 +0000
Date:   Mon, 25 May 2020 04:11:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] radix-tree: Use local_lock for protection
Message-ID: <20200525111114.GB17206@bombadil.infradead.org>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-3-bigeasy@linutronix.de>
 <20200525062954.GA3180782@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525062954.GA3180782@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 25, 2020 at 08:29:54AM +0200, Ingo Molnar wrote:
> > +void radix_tree_preload_end(void)
> > +{
> > +	local_unlock(&radix_tree_preloads.lock);
> > +}
> > +EXPORT_SYMBOL(radix_tree_preload_end);
> 
> Since upstream we are still mapping the local_lock primitives to
> preempt_disable()/preempt_enable(), I believe these uninlining changes should not be done
> in this patch, i.e. idr_preload_end() and radix_tree_preload_end() should stay inline.

But radix_tree_preloads is static, and I wouldn't be terribly happy to
see that exported to modules.
