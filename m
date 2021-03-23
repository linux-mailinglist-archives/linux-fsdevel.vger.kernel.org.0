Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16B345DD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 13:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhCWMLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhCWMKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:10:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A487DC061574;
        Tue, 23 Mar 2021 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BAJ7H9rbaesVAJ52FIx5l8TQ8yNHJhsS0hvfEGYQUV4=; b=rHKtKL9yxzZPSkAIneHebW4nIP
        ZOiy94rb0j/Ky8FxvesX4ToERFzmw6+YgNRNUzB+D8HF2DpvxJO86VgjLRP6UBw/pDMsuyiNGugjh
        6Kpc2zuVdafeNiAmHJLcrZ+Rr5iacLl9rhK+350KfZ806UI+8l8zb08uxz8j+/l6v/PNi8/JfJGZM
        zRStGa0TfiB7Y1LIU8PEP80HUUEkNUItiSnEyO34wk+OlbixQ1Rpsv740JZxxd/4CSrIg3iggANAu
        Z9jErpLeIxoRWTvSj8TgPWC6LnyQ//RKnvCCD54+p7zYRjGs9++AwWnaWsGu3KUEOsMtxo4gwComd
        44lrbj2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOfpl-00A1WB-Ek; Tue, 23 Mar 2021 12:09:04 +0000
Date:   Tue, 23 Mar 2021 12:08:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] cachefiles, afs: mm wait fixes
Message-ID: <20210323120829.GC1719932@casper.infradead.org>
References: <161650040278.2445805.7652115256944270457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161650040278.2445805.7652115256944270457.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:53:22AM +0000, David Howells wrote:
> 
> Here are some patches to fix page waiting-related issues in cachefiles and
> afs[1]:
> 
>  (1) In cachefiles, remove the use of the wait_bit_key struct to access
>      something that's actually in wait_page_key format.  The proper struct
>      is now available in the header, so that should be used instead.
> 
>  (2) Add a proper wait function for waiting killably on the page writeback
>      flag.  This includes a recent bugfix here (presumably commit
>      c2407cf7d22d0c0d94cf20342b3b8f06f1d904e7).
> 
>  (3) In afs, use the function added in (2) rather than using
>      wait_on_page_bit_killable() which doesn't have the aforementioned
>      bugfix.
> 
>      Note that I modified this to work with the upstream code where the
>      page pointer isn't cached in a local variable.

Thanks, the minor modifications to the patches (changelogs, fixes to apply
to upstream) all look good to me.
