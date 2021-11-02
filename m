Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA13443018
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 15:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhKBOTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 10:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKBOTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:19:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97D4C061714;
        Tue,  2 Nov 2021 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Frpr96sflPeeQPJcNwVDoz7On83K64HxlUkHEJTrzvk=; b=dzP+N8YEsV5NKFfEHD4ddUohAc
        dANaLgnKRkAy3iIPJpjjFVP2o+c1WUllO471Y0Pp37vrPm5RqJmZzzWAo00q44fMMvoYOsYf4yxxR
        KwUZRxhYlYEg2GcxAxgCu7dd7+Eq+q/mIpvdArPTO+pEJI6uSG0mNx8X9OQJqUoN+lvMUFh97uu9X
        P+f5rO0VBpOii7AeA36S+CtTe/D8FtPNzlYk4i2Xih83VzaJ49SnqpKZgT50lEHcXJSjONvtlVl4p
        vLmqp1bKS8FBqvAu63U0mxGPEwGL+ypD7kK7JiP2TaManjgx/cO+sLscyEfFAtVWBLiLpldNwlzTl
        aQ9gDDXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhuZS-004Xf5-VB; Tue, 02 Nov 2021 14:15:37 +0000
Date:   Tue, 2 Nov 2021 14:15:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/21] block: Add bio_add_folio()
Message-ID: <YYFH/k8oo1r4fl9p@casper.infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-3-willy@infradead.org>
 <0384e51b-0938-dccb-8c70-caa1f2b35d34@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0384e51b-0938-dccb-8c70-caa1f2b35d34@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 02:51:37PM -0600, Jens Axboe wrote:
> On 11/1/21 2:39 PM, Matthew Wilcox (Oracle) wrote:
> > This is a thin wrapper around bio_add_page().  The main advantage here
> > is the documentation that stupidly large folios are not supported.
> > It's not currently possible to allocate stupidly large folios, but if
> > it ever becomes possible, this function will fail gracefully instead of
> > doing I/O to the wrong bytes.
> 
> Might be better with UINT_MAX instead of stupidly here, because then
> it immediately makes sense. Can you make a change to that effect?

I'll make it "that folios larger than 2GiB are not supported.  It's not
currently possible to allocate folios that large,"

> With that:
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> 
> -- 
> Jens Axboe
> 
