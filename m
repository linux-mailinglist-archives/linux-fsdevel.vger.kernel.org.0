Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F66760620
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 05:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjGYDAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 23:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGYDAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:00:43 -0400
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [IPv6:2001:41d0:203:375::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE02F1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 20:00:41 -0700 (PDT)
Date:   Mon, 24 Jul 2023 23:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690254040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7+t6JGgjNA4srPAzMo98NzDSt2aKwb5Cbcib1WcjJM=;
        b=qOkfgLMsqd8UvX0fEhUXY2j3afh1S4GVEQM7LfgmYCfW4QzrKi0buH1nYnbQE9yCCnBoLN
        nw6UqzTjFUi37nyOeyJCqMmaNW2h6+Y9WuCrYYWKqaWqFKSNkvMgkI40DiH0ljCu1rL3lM
        D0JrzMwWir2854jKvwSTymA6T/f+AKM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 04/20] block: Add some exports for bcachefs
Message-ID: <20230725030037.minycb3oxubajuqw@moria.home.lan>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-5-kent.overstreet@linux.dev>
 <ZL61WIpYp/tJ6XH1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL61WIpYp/tJ6XH1@infradead.org>
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

On Mon, Jul 24, 2023 at 10:31:04AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 05:10:59PM -0400, Kent Overstreet wrote:
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> > 
> >  - bio_set_pages_dirty(), bio_check_pages_dirty() - dio path
> 
> Why?  We've so far have been able to get away without file systems
> reinventing their own DIO path.  I'd really like to keep it that way,
> so if you think the iomap dio code should be improved please explain
> why.  And please also cycle the fsdevel list in.

It's been discussed at length why bcachefs doesn't use iomap.

In short, iomap is heavily callback based, the bcachefs io paths are
not - we pass around data structures instead. I discussed this with
people when iomap was first being written, but iomap ended up being a
much more conservative approach, more in line with the old buffer heads
code where the generic code calls into the filesystem to obtain
mappings.

I'm gradually convincing people of the merits of the bcachefs approach -
in particular reducing indirect function calls is getting more attention
these days.
