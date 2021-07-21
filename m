Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31323D07C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 06:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhGUDvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 23:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhGUDu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 23:50:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64820C061574;
        Tue, 20 Jul 2021 21:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oXXmw0xRZx1duRhUChyatQyyj1O6vy9kc7fAFrgNi1c=; b=fIzsHCIxsD0PCsJQXquJXuNBaR
        4aCcmn3x3h8xgBXvng6sFzappeCZKsJXdZuOfFY5hRC5zYFElLBPBA05cwFrt1WqFloPNwX7w5ya7
        dQdasSz7A7RosEIr7rui5ggNaap7lNKfunb0p9DAwsLdgEeXlwlsv6uc5K45owvneghM4t0+vzzlJ
        rQgPX6OYp+o5pGeH7F/oxaYj6fuwMR9/T82xk3Elo0xOLlmCnT/sKYYFpOywp6M+kzlQ+mG3pZC/g
        onfQVrTlWcNciXXPkP49pMZajCIbAzTqmu40ZZ14eFcC2ydIw1qYzOc5rVZeEjJngkmzFcRiS2KpY
        gucM0dIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m63t6-008mw6-MF; Wed, 21 Jul 2021 04:31:21 +0000
Date:   Wed, 21 Jul 2021 05:31:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 16/17] iomap: Convert iomap_add_to_ioend to take a
 folio
Message-ID: <YPejFDYKUn6qtLo5@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-17-willy@infradead.org>
 <20210721001219.GR22357@magnolia>
 <YPeiRb8o+zh29Pag@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPeiRb8o+zh29Pag@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 05:27:49AM +0100, Christoph Hellwig wrote:
> On Tue, Jul 20, 2021 at 05:12:19PM -0700, Darrick J. Wong wrote:
> > I /am/ beginning to wonder, though -- seeing as Christoph and Matthew
> > both have very large patchsets changing things in fs/iomap/, how would
> > you like those landed?  Christoph's iterator refactoring looks like it
> > could be ready to go for 5.15.  Matthew's folio series looks like a
> > mostly straightforward conversion for iomap, except that it has 91
> > patches as a hard dependency.
> > 
> > Since most of the iomap changes for 5.15 aren't directly related to
> > folios, I think I prefer iomap-for-next to be based directly off -rcX
> > like usual, though I don't know where that leaves the iomap folio
> > conversion.  I suppose one could add them to a branch that itself is a
> > result of the folio and iomap branches, or leave them off for 5.16?
> 
> Maybe willy has a different opinion, but I thought the plan was to have
> the based folio enablement in 5.15, and then do things like the iomap
> conversion in the the next merge window.  If we have everything ready
> this window we could still add a branch that builds on top of both
> the iomap and folio trees, though.

Yes, my plan was to have the iomap conversion and the second half of the
page cache work hit 5.16.  If we're ready earlier, that's great!  Both
you and I want to see both the folio work and the iomap_iter work
get merged, so I don't anticipate any lack of will to get the work done.
