Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE78636D00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 23:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKWWTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 17:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKWWTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:19:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72629114B87;
        Wed, 23 Nov 2022 14:19:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B8C7B82543;
        Wed, 23 Nov 2022 22:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EDFC433D6;
        Wed, 23 Nov 2022 22:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669241970;
        bh=ZZiwh5s9GrphvhQmAD0il03WldxNsbh9fhgz97VZw4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfWEMTHSzfV7pNdYK4NSlbwYxT08YbQL83lw1ZZe2T2w9m6gFY0Z33+VuOEcLDz0L
         4DLMAlY7uhO1W/eb3OvFQ2l34uind+Oyc+zx56bOJHbzr5lkF7GWd+z9V7FAa6Hiti
         8h+AS0qKCRGcg8cFz+nGlgLWx1hcWOaZDWKe/Bok/8kgFiwiWwIHMpWva7Eaurf0yc
         inxjU41zPrNJLB8SOv58ttgUH4Wrfc9aTH0xSfVsdL+yeGs2dcPwn6LaaiDtdcKsk8
         XAKo1Nvn9KtnhNAIv4HS6U/I9dWxpozPYWEc1JH+9LD9VTDhNWY+aZjLRkMczKQUqW
         obOmJADBUyqfQ==
Date:   Wed, 23 Nov 2022 22:19:29 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] fsverity: stop using PG_error to track error status
Message-ID: <Y36ccbZq9gsnbmWw@gmail.com>
References: <20221028175807.55495-1-ebiggers@kernel.org>
 <Y2y0cspSZG5dt6c+@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2y0cspSZG5dt6c+@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 12:21:06AM -0800, Eric Biggers wrote:
> On Fri, Oct 28, 2022 at 10:58:07AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > As a step towards freeing the PG_error flag for other uses, change ext4
> > and f2fs to stop using PG_error to track verity errors.  Instead, if a
> > verity error occurs, just mark the whole bio as failed.  The coarser
> > granularity isn't really a problem since it isn't any worse than what
> > the block layer provides, and errors from a multi-page readahead aren't
> > reported to applications unless a single-page read fails too.
> > 
> > f2fs supports compression, which makes the f2fs changes a bit more
> > complicated than desired, but the basic premise still works.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> > 
> > In v3, I made a small simplification to the f2fs changes.  I'm also only
> > sending the fsverity patch now, since the fscrypt one is now upstream.  
> > 
> >  fs/ext4/readpage.c |  8 ++----
> >  fs/f2fs/compress.c | 64 ++++++++++++++++++++++------------------------
> >  fs/f2fs/data.c     | 48 +++++++++++++++++++---------------
> >  fs/verity/verify.c | 12 ++++-----
> >  4 files changed, 67 insertions(+), 65 deletions(-)
> 
> I've applied this to the fsverity tree for 6.2.
> 
> Reviews would be greatly appreciated, of course.
> 

Jaegeuk and Chao, can I get a review or ack from one of you?

- Eric
