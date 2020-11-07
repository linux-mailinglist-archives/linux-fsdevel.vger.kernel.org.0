Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9E2AA6DB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 18:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgKGRUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Nov 2020 12:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgKGRUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Nov 2020 12:20:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E56C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2020 09:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wsqbZWpX+RE3jugUa643uHAaAtcUOG7w2keGcxmfdNc=; b=VCnsLuEs+ZsM8cYsagcJWvj1LG
        DgF9uVNC0l2NV7uG6Vp5K5o2hPnG+BTlVAqYkEX5/w08iVbCtvLFVXLtFpfPYeJm0ayJZk2XFQOam
        UWj/uWSid0MdShWnfgtQgINHBbvb0f8i6fRh6G5WKimYzPr/mbe1S1Or23Nlde5GkLFrWIwrpfcs1
        +qUwIWN+rp+2YnB7IaKSF2nXPRKyLPZtDrD9zCUfnZMnvq31PCJAZ20MpPCPU4vy/HZeT8fLrIJIc
        zk9uXG51oR22XVhkNwX/RNa4VwYaIcrMLA6ZXZNfCbfarwxB34I+WyFZbJL/jfwT6XldyzFm30thM
        v50qwLUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kbRtR-0007dI-15; Sat, 07 Nov 2020 17:20:49 +0000
Date:   Sat, 7 Nov 2020 17:20:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 1/4] pagevec: Allow pagevecs to be different sizes
Message-ID: <20201107172048.GW17076@casper.infradead.org>
References: <20201106080815.GC31585@lst.de>
 <20201106123040.28451-1-willy@infradead.org>
 <20201107170813.GD3365678@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107170813.GD3365678@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 07, 2020 at 12:08:13PM -0500, Kent Overstreet wrote:
> On Fri, Nov 06, 2020 at 12:30:37PM +0000, Matthew Wilcox (Oracle) wrote:
> >  struct pagevec {
> > -	unsigned char nr;
> > -	bool percpu_pvec_drained;
> > -	struct page *pages[PAGEVEC_SIZE];
> > +	union {
> > +		struct {
> > +			unsigned char sz;
> > +			unsigned char nr;
> > +			bool percpu_pvec_drained;
> This should probably be removed, it's only used by the swap code and I don't
> think it belongs in the generic data structure. That would mean nr and size (and
> let's please use more standard naming...) can be u32, not u8s.

Nevertheless, that's a very important user of pagevecs!  You and I have no
need for it in the fs code, but it doesn't hurt to leave it here.

I really don't think that increasing the size above 255 is worth anything.
See my earlir analysis of the effect of increasing the batch size.

> > +			struct page *pages[PAGEVEC_SIZE];
> > +		};
> > +		void *__p[PAGEVEC_SIZE + 1];
> 
> What's up with this union?

*blink*.  That was supposed to be 'struct page *pages[];'

And the reason to do it that way is to avoid overly-clever instrumentation
like kmsan from saying "Hey, nr is bigger than 16, this is a buffer
overrun".  Clearly I didn't build a kernel with the various sanitisers
enabled, but I'll do that now.

