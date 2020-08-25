Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C42A250CE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 02:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHYAW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 20:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgHYAWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:22:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0BFC061574;
        Mon, 24 Aug 2020 17:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ocdvple/oAl8JiYXsLS1fSxRCYZy5ArHDZ1pVwX0Pes=; b=LyTZV8+tXrOESAyilTthffk4xE
        LofZU3dPW7vG+qsKdlHZFJTMq+FV7VgX33/L7fGz5bPdCMwrUSgzkvvfSpEH/oyBqOdpF7V+vSUha
        fu34jWEPjBeRQ36+kTPx38qQGGiVPEOCq2VLeSfGr3JLjSEcN46SOZCcx95+Bi0jbLPKThm6cgOlY
        N+6OvCpPXtOYDyFqnhPQIqlcPo772tdExSn2PHfWkUDnqzH5nhUw9a+BUdUdGDrvlX6an66aKVpeA
        tkySVcAbuXWtbl1nd3pPU4TRiyoJ6u1LlaYLK3U3pXA7lW7qkr7/8zFsOYVPg8pVNYnUWyAXAa2Jn
        f+yg40Pg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAMjB-0005WV-ID; Tue, 25 Aug 2020 00:22:18 +0000
Date:   Tue, 25 Aug 2020 01:22:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200825002217.GI17456@casper.infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-6-willy@infradead.org>
 <20200824235918.GF12131@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824235918.GF12131@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:59:18AM +1000, Dave Chinner wrote:
> On Mon, Aug 24, 2020 at 03:55:06PM +0100, Matthew Wilcox (Oracle) wrote:
> >  static inline struct iomap_page *to_iomap_page(struct page *page)
> >  {
> > +	VM_BUG_ON_PGFLAGS(PageTail(page), page);
> >  	if (page_has_private(page))
> >  		return (struct iomap_page *)page_private(page);
> >  	return NULL;
> 
> Just to confirm: this vm bug check is to needed becuse we only
> attach the iomap_page to the head page of a compound page?
> 
> Assuming that I've understood the above correctly:

That's correct.  If we get a tail page in this path, something's gone
wrong somewhere upstream of us, and the stack trace should tell us where.
It's PGFLAGS so it's usually compiled out by distro kernels (you need to
enable CONFIG_DEBUG_VM_PGFLAGS for it to be active).

It was definitely useful in development; probably not so useful for
a distro kernel to assert.
