Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713C32FA88D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405486AbhARSSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 13:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407489AbhARSR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:17:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE7C061574;
        Mon, 18 Jan 2021 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gm34TJmCQ31NroqaLmcF5ZbW1NPncCdbRKlX6Y+9LRo=; b=AMjXAOOqP2xrOd4R5eeHaKp4UV
        c5GbqMGdqXEWbXmif0QIowNSLlHV5j96egwK3d9AQ7wEySPHGGHTG194rrL03E3mPJCunZXUvuKFm
        WtVYPWrVcSIjADLfhcCsStSa10bxcM1uuBBYT8JaZxPy3V9dkTkr/+zGTI7lz9Hs37n9Q/VgYMfG7
        T8d4KWxy6CQAFrsnl+8NaweRFX0hZdzwJ9fgvZ0rMYClxAhFnsE/Q2p6nngFZHHT5HSULjXUIfB8v
        LleZMto5oY1XtBbwee4nGmo5OHrPuZrt/rC9iCOBhqhaoGR65acSVj43MCS6Ck3EoKIc9lAgp52vF
        Abih3VXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Z5U-00DCoE-30; Mon, 18 Jan 2021 18:17:14 +0000
Date:   Mon, 18 Jan 2021 18:17:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, 'Jens Axboe ' <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add bio_limit
Message-ID: <20210118181712.GC2260413@casper.infradead.org>
References: <20210114194706.1905866-1-willy@infradead.org>
 <20210118181338.GA11002@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118181338.GA11002@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 07:13:38PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 14, 2021 at 07:47:06PM +0000, Matthew Wilcox (Oracle) wrote:
> > It's often inconvenient to use BIO_MAX_PAGES due to min() requiring the
> > sign to be the same.  Introduce bio_limit() and change BIO_MAX_PAGES to
> > be unsigned to make it easier for the users.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I like the helper, but I'm not too happy with the naming.  Why not
> something like bio_guess_nr_segs() or similar?

This feels like it's a comment on an entirely different patch, like this one:

https://git.infradead.org/users/willy/pagecache.git/commitdiff/fe9841debe24e15100359acadd0b561bbb2dceb1

bio_limit() doesn't guess anything, it just clamps the argument to
BIO_MAX_PAGES (which is itself misnamed; it's BIO_MAX_SEGS now)
