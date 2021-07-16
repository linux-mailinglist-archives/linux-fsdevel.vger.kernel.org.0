Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C6D3CB0E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 04:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhGPCxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 22:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhGPCxB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:53:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE44C06175F;
        Thu, 15 Jul 2021 19:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gMlvBLObPJT3YmRhs9iQMwy3E2OqoakIoEKCEfOZcX0=; b=vgvSRBZIZXuXoEKicIy49w4iCn
        wSG58yq2P84KKKFtFY0/rJBrDjJXEJ/r1wBz0F75bdK/ezr9mVRkz5jXDQafYO44tdPl7F5TPcfMa
        avJEDz5F+SP1qVC4yDW7y79z5eDfliLvSRLuna82d9T75Gej7INWQO7oOsi9lstGyp0ZHtvTUxpAO
        iI67mJaorxloEa4843ZDLCAFsXc2Jjufz7HhWOdkdLGt+xDLR7g22+YnaZi3Kxjmz7KdkYKTxHqim
        4FnfHuKt5zD7+6N6pOFZk/54EZs99VuenWAuh4/uqCzzzijpz9hH31GIw8Q9syQZkQ0PTQgupw+6M
        MZ/J3tLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4Dut-00455o-4q; Fri, 16 Jul 2021 02:49:38 +0000
Date:   Fri, 16 Jul 2021 03:49:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 128/138] iomap: Support multi-page folios in
 invalidatepage
Message-ID: <YPDzu5Upm85z1tDN@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-129-willy@infradead.org>
 <20210715221018.GT22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715221018.GT22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 03:10:18PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 15, 2021 at 04:36:54AM +0100, Matthew Wilcox (Oracle) wrote:
> > If we're punching a hole in a multi-page folio, we need to remove the
> > per-page iomap data as the folio is about to be split and each page will
> > need its own.  This means that writepage can now come across a page with
> > no iop allocated, so remove the assertion that there is already one,
> > and just create one (with the uptodate bits set) if there isn't one.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Lol, Andreas already did the bottom half of the change for you.

Heh, yes, I copy-and-pasted it from this patch ;-)  Thanks for
merging it!
