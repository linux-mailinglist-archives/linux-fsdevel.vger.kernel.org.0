Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0526270FB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgISRDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 13:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgISRDQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 13:03:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504CC0613CE;
        Sat, 19 Sep 2020 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7K524fAR5E8RPb4YZ8gfAgOST1hNthb7Q6TYSOdLEWM=; b=I9SyxsBjIuKE8VjClV7wfiwGKx
        ukpIt2y5GhZy6hrkvXdcxniXSXe/eiESVdjiQwZ9kQXujauA22qL7/t0q6vOUQSRLnpcfSOAw399N
        x2NBhUFY+qsB+UTiAy7FaUIKiK2tUu2QFV8aIlMf1fphsAKUsYqEPjtHaxkEW5g6hja1X4AAO55Dx
        LkL+NxxBvwWJWMVO5ncqXYrcH0Q2k7hVdbr1hQJ1HCjyzbTN3KQ10H8fa+uz0WQWwCPsS966Z0DrR
        an66n1b/pd3J3j69L1/XkQiQR5F0m4Zcol4jym/GfdqOSh6oRcQDhu+CNki4PJqxH79Oblfbm1MDJ
        odWchhNw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJgGY-0006GI-RP; Sat, 19 Sep 2020 17:03:14 +0000
Date:   Sat, 19 Sep 2020 18:03:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 16/13] iomap: Make readpage synchronous
Message-ID: <20200919170314.GO32101@casper.infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917225647.26481-1-willy@infradead.org>
 <20200917225647.26481-3-willy@infradead.org>
 <20200919063908.GH13501@infradead.org>
 <20200919064308.GA16257@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919064308.GA16257@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 19, 2020 at 07:43:08AM +0100, Christoph Hellwig wrote:
> On Sat, Sep 19, 2020 at 07:39:08AM +0100, Christoph Hellwig wrote:
> > I think just adding the completion and status to struct
> > iomap_readpage_ctx would be a lot easier to follow, at the cost
> > of bloating the structure a bit for the readahead case.  If we
> > are realy concerned about that, the completion could be directly
> > on the iomap_readpage stack and we'd pass a pointer.
> 
> Anbother option would be to chain the bios and use submit_bio_wait.
> That would take care of the completion and the status propagation
> withour extra fields and extra code in iomap.

But it wouldn't let us mark some blocks on the page as Uptodate, would it?
As I read the code, chaining two BIOs together will call the parent's
bi_end_io only once both the child and the parent BIOs have completed,
but at the point the parent's bi_end_io is called, the child bio has
already been put and we can't iterate over its bio_vec.

Maybe I misread the code; bio chaining does not seem to be well
documented.
