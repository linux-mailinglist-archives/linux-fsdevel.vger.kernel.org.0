Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB81F7605FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 04:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGYCrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 22:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjGYCr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:47:28 -0400
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [IPv6:2001:41d0:203:375::3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFF51BF8
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 19:46:58 -0700 (PDT)
Date:   Mon, 24 Jul 2023 22:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690253155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Q5Rm2EJwkfZWw4mhZH3UHuciUZSLvBqW2m7BkgfTEc=;
        b=sXRcF5tmB3R6utQ6CUm2HRp5Jrx4VPiF0MbsP3FfuRIH7th61+n2XjQ4zqsQQ2uYtXBISR
        6PIi+C0vw8jA1YAxunLrK4NUXFmBJsJHHcd5k9PsCnz3mLf6M3vfZUFpiIbbOnl+M1FlAd
        kswumCdmWwrXLDVYd8fafP8ZORJDt8Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/20] block: Bring back zero_fill_bio_iter
Message-ID: <20230725024553.bqwoyz4ywqx6fypb@moria.home.lan>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-7-kent.overstreet@linux.dev>
 <ZL62cVmeI6t7o+G9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL62cVmeI6t7o+G9@infradead.org>
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

On Mon, Jul 24, 2023 at 10:35:45AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 05:11:01PM -0400, Kent Overstreet wrote:
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> > 
> > This reverts 6f822e1b5d9dda3d20e87365de138046e3baa03a - this helper is
> > used by bcachefs.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: linux-block@vger.kernel.org
> > ---
> >  block/bio.c         | 6 +++---
> >  include/linux/bio.h | 7 ++++++-
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> I really don't see any point in offering this in the block layer.  By
> the lack of any other caller it obviously isn't such a generic and
> always used helper, but more importantly it literally is three lines
> of code to implement it.

And yet, we've had a subtle bug introduced in that code that took quite
awhile to be fixed - I'm not pro code duplication in general and I don't
think this is a good place to start.
