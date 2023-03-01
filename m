Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9F6A6737
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 06:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCAFBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 00:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCAFBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 00:01:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045A138B66;
        Tue, 28 Feb 2023 21:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wWYaIDhPfuYqJ2OXFt7mummGj+i8spnErr9hehQauOo=; b=BN3hiqzTsKGSSMlkXXJ9+ZT8dT
        2aXKT3je9AZw91y+nvcZ9DMd1wZTQ3UzdrqEKtpHoKKXfySjmC+z0tNmVprKqjr7V0Du8vXrrcq14
        vQsEk3WmsjFGsEl42b90Ml/xjlnG2DR/2f653kgbIt6Zo1H5YLbSiasn4tr4AUT2UxihTutKqNW6W
        Q51JdkxSz9xUp7TSdZYWxnhwLpcnBAv4qoMQsMHEoHzipXV1/xRD3XDl+yIX0lwvNwlJtZhX+g1nO
        QjtkDX1rWmfijAT78RNbbE6Qx6oDUa39HhDqiUrcJw7j3IfDyIiG9byElrcMfoMaAKh9QiVtX3hD8
        XHA+YHNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXEaz-001OG7-GD; Wed, 01 Mar 2023 05:01:41 +0000
Date:   Wed, 1 Mar 2023 05:01:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <Y/7cNU2TRIVl/I85@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <Y/7WJMNLjrQ+/+Vs@casper.infradead.org>
 <c6612406-11c7-2158-5186-ebee72c9b698@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6612406-11c7-2158-5186-ebee72c9b698@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:49:10PM +0800, Gao Xiang wrote:
> > The only problem is that the readahead code doesn't tell the filesystem
> > whether the request is sync or async.  This should be a simple matter
> > of adding a new 'bool async' to the readahead_control and then setting
> > REQ_RAHEAD based on that, rather than on whether the request came in
> > through readahead() or read_folio() (eg see mpage_readahead()).
> 
> Great!  In addition to that, just (somewhat) off topic, if we have a
> "bool async" now, I think it will immediately have some users (such as
> EROFS), since we'd like to do post-processing (such as decompression)
> immediately in the same context with sync readahead (due to missing
> pages) and leave it to another kworker for async readahead (I think
> it's almost same for decryption and verification).
> 
> So "bool async" is quite useful on my side if it could be possible
> passed to fs side.  I'd like to raise my hands to have it.

That's a really interesting use-case; thanks for bringing it up.

Ideally, we'd have the waiting task do the
decompression/decryption/verification for proper accounting of CPU.
Unfortunately, if the folio isn't uptodate, the task doesn't even hold
a reference to the folio while it waits, so there's no way to wake the
task and let it know that it has work to do.  At least not at the moment
... let me think about that a bit (and if you see a way to do it, feel
free to propose it)
