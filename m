Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89C4D74D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 12:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiCMK7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 06:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiCMK5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:57:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9F666204;
        Sun, 13 Mar 2022 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J3gKdDCi9YszE+1HblYa04HJOkpOFiAef+v0HQb6Was=; b=rKIU8Vj8J8Kwn+Qi4kuYN/CQ/W
        5rzaTb+Epy2vK7e6LPy2AXQVlDaWiiMkhUyBHvoCuYmkmc43HjdRgrjALbtF28O84FqF/HLnNt94L
        h6U9nI+y5JU/sPLBq3k7jSoECJHzjSPCHeilOiRWxezQG9kGfAeHPWsqXxnMEwQ+YYr5XAcuT33rn
        kRyPupV5CkrxVB0l/01+ZRTpdnKOTO7bKLmyyrUpeLdaCNUQ+KXCW0wh9HZ4EX2f9mCl3+cpfmvSg
        WUmpu/DvfnZcJCbvzyNLw94+N5gjlLBNA/0aEh29QY49tsdCNQoL++bYODS+QIQotFSRK2JMCwRID
        F7PORPhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTLsW-0039Vi-NW; Sun, 13 Mar 2022 10:55:12 +0000
Date:   Sun, 13 Mar 2022 10:55:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: Better read bio error granularity?
Message-ID: <Yi3NkBf0EUiG2Ys2@casper.infradead.org>
References: <88a5d138-68b0-da5f-8b08-5ddf02fff244@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a5d138-68b0-da5f-8b08-5ddf02fff244@gmx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 13, 2022 at 06:24:32PM +0800, Qu Wenruo wrote:
> Since if any of the split bio got an error, the whole bio will have
> bi_status set to some error number.
> 
> This is completely fine for write bio, but I'm wondering can we get a
> better granularity by introducing per-bvec bi_status or using page status?
> 
> 
> One situation is, for fs like btrfs or dm device like dm-verify, if a
> large bio is submitted, say a 128K one, and one of the page failed to
> pass checksum/hmac verification.
> 
> Then the whole 128K will be marked error, while in fact the rest 124K
> are completely fine.
> 
> 
> Can this be solved by something like per-vec bi_status, or using page
> error status to indicate where exactly the error is?

In general, I think we want to keep this simple; the BIO has an error.
If the user wants more fine granularity on the error, they can resubmit
a smaller I/O, or hopefully some day we get a better method of reporting
errors to the admin than "some random program got EIO".

Specifically for the page cache (which I hope is what you meant by
"page error status", because we definitely can't use that for DIO),
the intent is that ->readahead can just fail and not set any of the
pages Uptodate.  Then we come along later, notice there's a page in
the cache and call ->readpage on it and get the error for that one
page.  The other 31 pages should read successfully.

(There's an awkward queston to ask about large folios here, and what
we might be able to do around sub-folio or even sub-page or sub-block
reads that happen to not touch the bytes which are in an error region,
but let's keep the conversation about pages for now).

