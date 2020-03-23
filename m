Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DDA18F59D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 14:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgCWNUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 09:20:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgCWNUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zm6MaYapSofqY5SMqbMn2kCplA4o5fk7zrK2qonKiD8=; b=OoppGSO4356dsGXrfkr+lkz6Q5
        5Hmf8xyifRyXiV8+7/l5/Z15/LDfHlz+Jh9RB/u2acmHQAiBfZ+fxqEjp6oaP9zvsJC5Zu63AjMuB
        v4ISIcI1ojlfCxS6B/FNQGONMxQzIHH8QIcUUoxFUOZvjCEH0Fd+ryzVhemu2F5Pfxy9tby3pIHR7
        TarIYLBnoe0mNGTr0lzaH353FwN+3rYs8YEITk37LAyDBEk8oNbelS+XJN/ubCy653/28GAZMxqI7
        bMWJHblmhaJJTTnXxVb3XF9tVRoRG0qUQjMF65xusoyC+fYta3uSLsDX7JDKaKMqhQ+KfDIJi8Qir
        mWKYzwow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGN0e-0004JU-Ta; Mon, 23 Mar 2020 13:20:52 +0000
Date:   Mon, 23 Mar 2020 06:20:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Do not use GFP_NORETRY to allocate BIOs
Message-ID: <20200323132052.GA7683@infradead.org>
References: <20200323131244.29435-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323131244.29435-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 06:12:44AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> If we use GFP_NORETRY, we have to be able to handle failures, and it's
> tricky to handle failure here.  Other implementations of ->readpages
> do not attempt to handle BIO allocation failures, so this is no worse.

do_mpage_readpage tries to use it, I guess that is wher I copied it
from..

But I don't think it is a bad idea, so the patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

It probably wants a fixes tag, though:

Fixes: 72b4daa24129 ("iomap: add an iomap-based readpage and readpages implementation")

