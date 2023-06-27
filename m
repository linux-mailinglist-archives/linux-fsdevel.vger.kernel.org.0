Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F05373F2A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 05:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjF0D2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 23:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjF0D2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:28:12 -0400
Received: from out-17.mta1.migadu.com (out-17.mta1.migadu.com [IPv6:2001:41d0:203:375::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD411FD6
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 20:22:12 -0700 (PDT)
Date:   Mon, 26 Jun 2023 23:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687836130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlefwmcwlBiIz1SL7AHM35ngFtI0vXcN9OG4RXXLfCk=;
        b=jynnjyA5Iv8xnjGJ5+Hf+1gDzVymjLivJnXkZoKFv8ofDXrG0JuqRs9iB3m2BIOOyQpG7D
        cN6reE4qZiX1Xb8EoMF1v8vqcw7S2rWDlkzpDxLUqJ0FF41ISIzXSxcv5T634Gq9HvYcR1
        QQ8yO2h2VOUZqAacCiV5yMypmN+Q5cs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230627032207.ix7zj6f7zb6owb3k@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627023337.dordpfdxaad56hdn@moria.home.lan>
 <784c3e6a-75bd-e6ca-535a-43b3e1daf643@kernel.dk>
 <ZJpVRbBGjU7bvKy4@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJpVRbBGjU7bvKy4@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:19:33AM +0100, Matthew Wilcox wrote:
> On Mon, Jun 26, 2023 at 08:59:44PM -0600, Jens Axboe wrote:
> > On 6/26/23 8:33?PM, Kent Overstreet wrote:
> > > On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
> > >> fs/bcachefs/alloc_background.c: In function ?bch2_check_alloc_info?:
> > >> fs/bcachefs/alloc_background.c:1526:1: warning: the frame size of 2640 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> > >>  1526 | }
> > >>       | ^
> > >> fs/bcachefs/reflink.c: In function ?bch2_remap_range?:
> > >> fs/bcachefs/reflink.c:388:1: warning: the frame size of 2352 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> > >>   388 | }
> > >>       | ^
> > > 
> > > What version of gcc are you using? I'm not seeing either of those
> > > warnings - I'm wondering if gcc recently got better about stack usage
> > > when inlining.
> > 
> > Using:
> > 
> > gcc (Debian 13.1.0-6) 13.1.0
> > 
> > and it's on arm64, fwiw.
> 
> OOI what PAGE_SIZE do you have configured?  Sometimes fs data structures
> are PAGE_SIZE dependent (haven't looked at this particular bcachefs data
> structure).  We've also had weirdness with various gcc versions on some
> architectures making different inlining decisions from x86.

There are very few references to PAGE_SIZE in bcachefs, I've killed off
as much of that as I can because all this code has to work in userspace
too and depending on PAGE_SIZE is sketchy there
