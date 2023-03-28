Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BDA6CC701
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 17:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjC1Pqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjC1PqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:46:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B619ED1;
        Tue, 28 Mar 2023 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7jIC3gUNOauWM9ga6qXOHTM4KQPWT4lzVzZrBrJLp1Q=; b=XadBAjmkszBzYAYmWzy+vOYwHs
        ftTrcROsJGhhCEJ89uRLqL8UhmQDaIyhwHvsbgRh2YbCi4ZYT3KPsH4oxDQEjOZmA6cKENmxbdAg7
        GxHB6Edvr6p+gHZUevYIvZ9mNMfCNiMZgHhs6fMpH3POoJu0jPXiInPzYnO8jxD6i/K6fRtbpTQ+z
        ivq6WYO+cQcr9UsJkZV32U6KFPJo9V6+aGzx4NIWMU7jEUaiVP3pCpSWgotH7EObCZReh4FVFIVk1
        oTua5IDwBughpq02F3BjBNr1mfvIr6+oRrcclQEoNcmZOKuPmFZEtRpb86AlN3ulPF+x7zdgOPbla
        UqqBJ+fw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phBWE-008YGZ-Or; Tue, 28 Mar 2023 15:45:54 +0000
Date:   Tue, 28 Mar 2023 16:45:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] mm: Hold the RCU read lock over calls to
 ->map_pages
Message-ID: <ZCMLsm7Cfd6FqXgn@casper.infradead.org>
References: <20230327174515.1811532-1-willy@infradead.org>
 <20230327174515.1811532-4-willy@infradead.org>
 <20230327230206.GB3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327230206.GB3223426@dread.disaster.area>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:02:06AM +1100, Dave Chinner wrote:
> On Mon, Mar 27, 2023 at 06:45:15PM +0100, Matthew Wilcox (Oracle) wrote:
> > Prevent filesystems from doing things which sleep in their map_pages
> > method.  This is in preparation for a pagefault path protected only
> > by RCU.
> > +	rcu_read_lock();
> > +	ret = vmf->vma->vm_ops->map_pages(vmf,
> > +			vmf->pgoff + from_pte - pte_off,
> > +			vmf->pgoff + to_pte - pte_off);
> > +	rcu_read_unlock();
> > +
> > +	return ret;
> 
> Doesn't this mean that the rcu_read_lock/unlock can be removed from
> filemap_map_pages()? i.e. all callers are now already under
> rcu_read_lock(). Maybe WARN_ON_ONCE(!rcu_read_lock_held()) could
> be put in filemap_map_pages() if you are worried about callers not
> holding it...

Yes, it could now be removed.  I wasn't too bothered because it's so
cheap (either a noop, or an inc/dec of a CPU-local variable).  I don't
think we need the WARN becaause there's one embedded in the XArray
code (must be holding the spinlock or the RCU read lock to iterate
the XArray).
