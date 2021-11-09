Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401ED44AED3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 14:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhKINg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 08:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbhKINg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:36:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384DEC061764;
        Tue,  9 Nov 2021 05:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hcXG7WpnNKC7B/u2/jNn+dxmdvkmgHtmXNnfCl5Up9Y=; b=gAFZjZE05YPKbtCWU1voJ/yMIg
        wtNwGGYAq2s3DOJ+GL1sLVTjea2DqALkaFqjl2o8JK7gqpfYpA+l0mZkWfxG6I5M32UB4P/+Srpyn
        ds1StTFncrJG420UeQTi0/Hlng/f8sfoZvrHW8OjymiytcDbhBtSbNkEhP/+/RG6QGXiBNnNJFiLE
        WwM1cPchKaMlDkY6fWOP4nuPZ93BlyFtkNJ0StkgNhetAFb4UOUQBDmY/di15qSF+fmIPvfURbjWm
        C1yrCVooPt93oTP8A8QjhFCbL6sX/CRHEdtSYCiudPNK8nM94krI/XDV/gSKf4vp2+7+4KhLUb6I5
        ZC9c3I8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkRGK-0013rd-Ng; Tue, 09 Nov 2021 13:34:08 +0000
Date:   Tue, 9 Nov 2021 13:34:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        Hyeoncheol Lee <hyc.lee@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Hitting BUG_ON trap in read_pages() - : [PATCH v2] mm: Optimise
 put_pages_list()
Message-ID: <YYp40A2lNrxaZji8@casper.infradead.org>
References: <CAKYAXd8KvqTQ-RnmWPFChmMEKGw9zA37chPM0H=FSewfRqx1zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd8KvqTQ-RnmWPFChmMEKGw9zA37chPM0H=FSewfRqx1zA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 07:45:47PM +0900, Namjae Jeon wrote:
> Hi Matthew,
> 
> This patch is hitting BUG_ON trap in read_pages() when running
> xfstests for cifs.
> There seems to be a same issue with other filesystems using .readpages ?

The real fix, of course, is to migrate away from using ->readpages ;-)
I think both 9p and nfs are going away this cycle.  CIFS really needs
to move to using the netfs interfaces.

> Could you please take a look ?

Please try this patch:

While free_unref_page_list() puts pages onto the CPU local LRU list, it
does not remove them from the list they were passed in on.  That makes
the list_head appear to be non-empty, and would lead to various corruption
problems if we didn't have an assertion that the list was empty.

Reinitialise the list after calling free_unref_page_list() to avoid
this problem.

Fixes: 988c69f1bc23 ("mm: optimise put_pages_list()")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/mm/swap.c b/mm/swap.c
index 1841c24682f8..e8c9dc6d0377 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -156,6 +156,7 @@ void put_pages_list(struct list_head *pages)
 	}
 
 	free_unref_page_list(pages);
+	INIT_LIST_HEAD(pages);
 }
 EXPORT_SYMBOL(put_pages_list);
 
