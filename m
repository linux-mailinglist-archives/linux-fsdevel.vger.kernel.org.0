Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F576BD27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 21:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjHATAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 15:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjHAS7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:59:48 -0400
Received: from out-68.mta0.migadu.com (out-68.mta0.migadu.com [91.218.175.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081BA115
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 11:59:46 -0700 (PDT)
Date:   Tue, 1 Aug 2023 14:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690916384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IC+hkFzsraORVL28A/kjM0OytUDIOrQlr7SfFeohqy8=;
        b=c2RD5mZRt+9NuyWas53Mgwnpp+VIhPCcbfY6GEax8AgF9MRqweC6dyjeiGAS2hUNb+xO4L
        MfR1rncIoVyDfLJQ5ojrCE4x+JmyTPldISLsk+X4ubRnesBhI4kWaFJBbT6Og+bsefSjDH
        LkvBWXPu05W12WWSRhtXe4/Y9bePJOY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 04/20] block: Add some exports for bcachefs
Message-ID: <20230801185940.b4vsd62fjxwzv7ft@moria.home.lan>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-5-kent.overstreet@linux.dev>
 <ZL61WIpYp/tJ6XH1@infradead.org>
 <20230725030037.minycb3oxubajuqw@moria.home.lan>
 <ZMEdqvzAUbQPs0io@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMEdqvzAUbQPs0io@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:20:42AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 24, 2023 at 11:00:37PM -0400, Kent Overstreet wrote:
> > In short, iomap is heavily callback based, the bcachefs io paths are
> > not - we pass around data structures instead. I discussed this with
> > people when iomap was first being written, but iomap ended up being a
> > much more conservative approach, more in line with the old buffer heads
> > code where the generic code calls into the filesystem to obtain
> > mappings.
> > 
> > I'm gradually convincing people of the merits of the bcachefs approach -
> > in particular reducing indirect function calls is getting more attention
> > these days.
> 
> FYI, Matthew has had patches that convert iomap to be an iterator,
> and I've massage the first half of them and actuall got them in
> before.  I'd much rather finish off that work (even if only for
> direct I/O initially) than adding another direct I/O code.  But
> even with out that we should be able to easily pass more private
> data, in fact btrfs makes pretty heavy use of that.

That's wonderful, but getting iomap up to the level of what bcachefs
needs is still going to be a pretty big project and it's not going to be
my highest priority.

bcachefs also hangs more state off of the pagecache, in bcachefs's
equivvalent of iomap_page - we store reservations for dirty data there
and a few other things, which means the buffered IO paths don't have to
walk any other data structures.

I think that's another idea you guys will want to steal, but a higher
priority for me is getting a proper FUSE port done - and making bcachefs
more tightly weddded to VFS library code is not likely to make that
process any easier.

Once a proper fuse port is done and we know what that looks like will be
a better time for some consolidation.
