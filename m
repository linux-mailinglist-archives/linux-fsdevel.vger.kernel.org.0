Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E64C63829E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 04:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKYDJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 22:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYDJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:09:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E771B1E3F1;
        Thu, 24 Nov 2022 19:09:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76A636228D;
        Fri, 25 Nov 2022 03:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBBBC433D6;
        Fri, 25 Nov 2022 03:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669345755;
        bh=H/DoDAoZstm85hh94iXdPnMrqUx4pgXwtXv19BtPK44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwA1bHcu7ETyDaY9YL+Umz67/lYViuBUNUljj1QqwUThaAK1S6n3gKJSyUnXwnrag
         scUO4fn0TSr0zLF24aTV0Lmg61K8CsXFT+0iAvwTxdaqpULfy8KHz3QFdeFleXgeRN
         RZ+SFaxoQmjM9cwey2wmvqIpYXaR5xpEEzqu5Ht2Brf8KyuWzsHn1pbSFQ8EQ9dm9/
         GKlJQwR7+82WVo+7MgZq/LxkarWtSF76WWz4R2fGt+7hnwSUZ+QdKQebREwcxBja+w
         DFjbuYFiE0dTV5at7RO7tv6My6Owqrm2zBaL3m/OQHFxE2oCXoRYjBO03DNbDSLabd
         Znu1g2CWsbjgg==
Date:   Thu, 24 Nov 2022 19:09:13 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] fsverity: stop using PG_error to track error status
Message-ID: <Y4Ax2YqOY8wyhnE8@sol.localdomain>
References: <20221028175807.55495-1-ebiggers@kernel.org>
 <Y2y0cspSZG5dt6c+@sol.localdomain>
 <Y36ccbZq9gsnbmWw@gmail.com>
 <4b0a548a-5b04-24a6-944d-348d15605dd2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0a548a-5b04-24a6-944d-348d15605dd2@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:06:43AM +0800, Chao Yu wrote:
> On 2022/11/24 6:19, Eric Biggers wrote:
> > On Thu, Nov 10, 2022 at 12:21:06AM -0800, Eric Biggers wrote:
> > > On Fri, Oct 28, 2022 at 10:58:07AM -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > As a step towards freeing the PG_error flag for other uses, change ext4
> > > > and f2fs to stop using PG_error to track verity errors.  Instead, if a
> > > > verity error occurs, just mark the whole bio as failed.  The coarser
> > > > granularity isn't really a problem since it isn't any worse than what
> > > > the block layer provides, and errors from a multi-page readahead aren't
> > > > reported to applications unless a single-page read fails too.
> > > > 
> > > > f2fs supports compression, which makes the f2fs changes a bit more
> > > > complicated than desired, but the basic premise still works.
> > > > 
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > ---
> > > > 
> > > > In v3, I made a small simplification to the f2fs changes.  I'm also only
> > > > sending the fsverity patch now, since the fscrypt one is now upstream.
> > > > 
> > > >   fs/ext4/readpage.c |  8 ++----
> > > >   fs/f2fs/compress.c | 64 ++++++++++++++++++++++------------------------
> > > >   fs/f2fs/data.c     | 48 +++++++++++++++++++---------------
> 
> Hi Eric,
> 
> Result of "grep PageError fs/f2fs/* -n"
> 
> ...
> fs/f2fs/gc.c:1364:      ClearPageError(page);
> fs/f2fs/inline.c:177:   ClearPageError(page);
> fs/f2fs/node.c:1649:    ClearPageError(page);
> fs/f2fs/node.c:2078:            if (TestClearPageError(page))
> fs/f2fs/segment.c:3406: ClearPageError(page);
> 
> Any plan to remove above PG_error flag operations? Maybe in a separated patch?
> 

Those are all for writes, not reads.  So I didn't want to touch them in this
patch, which is only about reads.

- Eric
