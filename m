Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42862DB027
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 16:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgLOPeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 10:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgLOPeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:34:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E165AC06179C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 07:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nz7NzDIIg2r1P4LR1vEWau9+ned547lFKgT7VC4DOu8=; b=HWlVTFbGlvhwzOz/ce8IxIqNfE
        65BTwKWlSx5JQHX7z2avJwCfN29oHzmEblxmTe0kSEK9wTIYkIs94Q/X6HC22ytWr42qw4X0IlO+J
        LQo37C5wDGY9cLzhnRIlqW5/vjfdFFJaRtCiBy/u0s4B4U1U2ssqeYbocOu7GnJDH/c8gRiZ/YSVL
        9/iKwF8NDXDbF2VllpEkKwokTfO5LGNsb0izL+GOzChh+zbIN0Yr831OfXebrN7blKDP2708m1hRA
        Na3xk3YSkR5uYcyukg+F2VET1Me3UvxlUpFwOvvoD+4RE8tn3HDPk4tbymu4jrC5jTM3n8WIz/QDw
        778Xh0vA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpCKF-0007KD-HF; Tue, 15 Dec 2020 15:33:19 +0000
Date:   Tue, 15 Dec 2020 15:33:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
Message-ID: <20201215153319.GU2443@casper.infradead.org>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
 <20201215122447.GQ2443@casper.infradead.org>
 <75e7d845-2bd0-5916-ad45-fb84d9649546@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e7d845-2bd0-5916-ad45-fb84d9649546@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 08:29:40AM -0700, Jens Axboe wrote:
> On 12/15/20 5:24 AM, Matthew Wilcox wrote:
> > On Mon, Dec 14, 2020 at 12:13:22PM -0700, Jens Axboe wrote:
> >> +++ b/fs/namei.c
> >> @@ -686,6 +686,8 @@ static bool try_to_unlazy(struct nameidata *nd)
> >>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
> >>  
> >>  	nd->flags &= ~LOOKUP_RCU;
> >> +	if (nd->flags & LOOKUP_NONBLOCK)
> >> +		goto out1;
> > 
> > If we try a walk in a non-blocking context, it fails, then we punt to
> > a thread, do we want to prohibit that thread trying an RCU walk first?
> > I can see arguments both ways -- this may only be a temporary RCU walk
> > failure, or we may never be able to RCU walk this path.
> 
> In my opinion, it's not worth it trying to over complicate matters by
> handling the retry side differently. Better to just keep them the
> same. We'd need a lookup anyway to avoid aliasing.

but by clearing LOOKUP_RCU here, aren't you making the retry handle
things differently?  maybe i got lost.
