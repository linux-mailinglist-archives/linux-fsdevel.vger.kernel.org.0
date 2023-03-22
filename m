Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5CE6C548B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 20:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCVTKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 15:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCVTKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:10:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F558B67;
        Wed, 22 Mar 2023 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zT4Z2FZu+6Ql6/R+LRqO3MtZ3q6XuLAuf5XIiRjZ61Q=; b=m6Drqk5niIKGUNGVcTAFXs/Lgh
        MqxegHXmu8VXR13ByAoNnd/K6Aa4o+zE6CtCkoxUN8JbAsqBkv8zpJ0jN7SxuPz5yfll+636mVTEw
        lIyvB9aQMc37vJ1RvfipcZ3jwG8LTIBEu2zTJrnkvWVKjaDD933JGA4mCYPBh2F71e/GtmBmDMi+D
        oXbk+n6zvMkTf70nRnb4U+NdZEpA3unSz3aRHW/VvAqhl30Betp4MrCvCRwH7YtoBHwQY0gdKTaHI
        rlYtf4rZ0Kq9MYPv4tkLMkRDNCZVaVtrXrkIk677QYlbS+u90jMM3rek8xsarrZc+DsBUsD5Yjakx
        AtvvFqKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pf3qE-003GWB-Fr; Wed, 22 Mar 2023 19:09:46 +0000
Date:   Wed, 22 Mar 2023 19:09:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        brauner@kernel.org, akpm@linux-foundation.org, minchan@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com, mcgrof@kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC v2 0/5] remove page_endio()
Message-ID: <ZBtSevjWLybE6S07@casper.infradead.org>
References: <CGME20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c@eucas1p2.samsung.com>
 <20230322135013.197076-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322135013.197076-1-p.raghav@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:50:08PM +0100, Pankaj Raghav wrote:
> It was decided to remove the page_endio() as per the previous RFC
> discussion[1] of this series and move that functionality into the caller
> itself. One of the side benefit of doing that is the callers have been
> modified to directly work on folios as page_endio() already worked on
> folios.
> 
> mpage changes were tested with a simple boot testing. zram and orangefs is
> only build tested. No functional changes were introduced as a part of
> this AFAIK.
> 
> Open questions:
> - Willy pointed out that the calls to folio_set_error() and
>   folio_clear_uptodate() are not needed anymore in the read path when an
>   error happens[2]. I still don't understand 100% why they aren't needed
>   anymore as I see those functions are still called in iomap. It will be
>   good to put that rationale as a part of the commit message.

page_endio() was generic.  It needed to handle a lot of cases.  When it's
being inlined into various completion routines, we know which cases we
need to handle and can omit all the cases which we don't.

We know the uptodate flag is clear.  If the uptodate flag is set,
we don't call the filesystem's read path.  Since we know it's clear,
we don't need to clear it.

We don't need to set the error flag.  Only some filesystems still use
the error flag, and orangefs isn't one of them.  I'd like to get rid
of the error flag altogether, and I've sent patches in the past which
get us a lot closer to that desired outcome.  Not sure we're there yet.
Regardless, generic code doesn't check the error flag.
