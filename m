Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449C16F636E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 05:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjEDDfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 23:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjEDDe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 23:34:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82121FC4
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mz0YLkaibC9xkIIe98ohSDA5vQbMYX3dZKJBmm58wZ0=; b=W04K2AsoWItAG81hDqViEaNTHn
        9Rq5Ydz+4xLb6Qfm7vLahXXqjFEtJneALeRz+l9sBCqic/NrvFAKqj6MKMOH9x2g3Ieeo8ez63a+1
        vcEuchRCcFwcFkk3udNI66AVcW59tl/s0x4I99Tr2a5tZIxW9rN/lxcKK54RKsw0lIPhKt0w/0guZ
        M71cz43V69G0gP1e0XeJcEHbKYUPqmufs0w2gSEV1HEz1srRjE2AMc0tvQ8Cm+RFhHNJ/Edoud0OL
        8TD7JKqAZZAB2w0anc+BbmnVemjUi3HsHmzP/fJGbQ5+nZZrQbHDmOlBzHtipv1P2ntKAW0mYbPp8
        l2a1kTYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puPjv-00ACvb-Rz; Thu, 04 May 2023 03:34:43 +0000
Date:   Thu, 4 May 2023 04:34:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] filemap: fix the conditional folio_put in
 filemap_fault
Message-ID: <ZFMn0zGC58KtQw6N@casper.infradead.org>
References: <20230503154526.1223095-1-hch@lst.de>
 <ZFKCRPRgoKWaWhQW@casper.infradead.org>
 <20230503154936.GA31522@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503154936.GA31522@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 05:49:36PM +0200, Christoph Hellwig wrote:
> On Wed, May 03, 2023 at 04:48:20PM +0100, Matthew Wilcox wrote:
> > > -		folio_put(folio);
> > 
> > Why not simply:
> > 
> > -	if (folio)
> > +	if (!IS_ERR_OR_NULL(folio))
> 
> no need for the OR_NULL.

Right.  I didn't read the whole function.

> But I find the extra label way easier to
> reason about, and it's exactly the same amount of code.

If it were easy to reason about, it would have a less ugly name.
