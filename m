Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DCC351AA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 20:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhDASC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbhDAR5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:57:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A95C031174;
        Thu,  1 Apr 2021 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iCMEzATsTfKSllJ0qHxWkotIZ1LmTIaj9wA1MfQzBRo=; b=mN+K+tNl7VN1Zh9vGb6RBIGpcG
        URsI4ncd1qpZarWtFWlRAuRNMmA4vxy7ER+6UfyJh91G4FWy3JDQJovHDoLobLdF++cwQE3ixv75u
        /IpLjAFNZj+qdihlzk21Vt0dXA1rLWBj8S+3sH6KGWY4VF85iEnryKOjm9UL/vAdQqynMq6Q5kEox
        eNkMRVdwDGqWKaMrPiuEfzUa1aVuZMfSIqyuMRB/tpt0JhwrSc7aukHcJSUTbkxFVJ2Adz5qMYZAG
        Luv5Z3aHjdby3V6GOV7WPfj/gHcPy8wStsVn0PMG7jk8TY3zmwKa1amIZvDRJodtacJLlETBSOCxU
        dQkiQCAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lS0lr-006OYt-NL; Thu, 01 Apr 2021 17:06:17 +0000
Date:   Thu, 1 Apr 2021 18:06:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
Message-ID: <20210401170615.GH351017@casper.infradead.org>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils>
 <20210331024913.GS351017@casper.infradead.org>
 <alpine.LSU.2.11.2103311413560.1201@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103311413560.1201@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 02:58:12PM -0700, Hugh Dickins wrote:
> I suspect there's a bug in the XArray handling in collapse_file(),
> which sometimes leaves empty nodes behind.

Urp, yes, that can easily happen.

        /* This will be less messy when we use multi-index entries */
        do {
                xas_lock_irq(&xas);
                xas_create_range(&xas);
                if (!xas_error(&xas))
                        break;
                if (!xas_nomem(&xas, GFP_KERNEL)) {
                        result = SCAN_FAIL;
                        goto out;
                }

xas_create_range() can absolutely create nodes with zero entries.
So if we create m/n nodes and then it runs out of memory (or cgroup
denies it), we can leave nodes in the tree with zero entries.

There are three options for fixing it ...
 - Switch to using multi-index entries.  We need to do this anyway, but
   I don't yet have a handle on the bugs that you found last time I
   pushed this into linux-next.  At -rc5 seems like a late stage to be
   trying this solution.
 - Add an xas_prune_range() that gets called on failure.  Should be
   straightforward to write, but will be obsolete as soon as we do the
   above and it's a pain for the callers.
 - Change how xas_create_range() works to merely preallocate the xa_nodes
   and not insert them into the tree until we're trying to insert data into
   them.  I favour this option, and this scenario is amenable to writing
   a test that will simulate failure halfway through.

I'm going to start on option 3 now.
