Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FE847339B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 19:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbhLMSIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 13:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbhLMSIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:08:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA73C061574;
        Mon, 13 Dec 2021 10:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8oozV1IRwA/A2R6zNk07Fx/Spsm9jrjC4UBxcDZXjf8=; b=a6vpnrKVMF7x9NRBbcUvJJkaGU
        RWh+pCMAqyR7ZiLSPPNcT98z7kIFfBf76Sqay4RnDh6+ugjgoWZ5sIX7XG5eFA2Cwip4P3s6Ntze9
        Fja3JFi7V/R7KbQBODnprlW9WRKXx+Oxsbx8Mv5I9kTgeNAI0Js8pmN/ghN4SkLbov4UbrEOJSZNC
        IFDopsbq4RMY821Yuh1RERU4vC8BEeyCfXb9ds/0vI7FfqyfgT6X7azS5w03GEKJVeul/XXOrczsb
        z42C93gofmG/ain5V80l4WRqk/RvlQnREstO2qSp1Ycd3SvyvM8FMoH9apeXSCFxsB/uD+wrJiIHd
        9CEqXj+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwpkl-00D2OR-QG; Mon, 13 Dec 2021 18:08:47 +0000
Date:   Mon, 13 Dec 2021 18:08:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 19/28] iomap: Convert __iomap_zero_iter to use a folio
Message-ID: <YbeML8UdqwsooSPb@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-20-willy@infradead.org>
 <YbJ3O1qf+9p/HWka@casper.infradead.org>
 <YbN+KqqCG0032NMG@casper.infradead.org>
 <Ybb3nmf0hPXhlnOu@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybb3nmf0hPXhlnOu@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 12, 2021 at 11:34:54PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 10, 2021 at 04:19:54PM +0000, Matthew Wilcox wrote:
> > After attempting the merge with Christoph's ill-timed refactoring,
> 
> I did give you a headsup before..

I thought that was going in via Darrick's tree.  I had no idea Dan was
going to take it.

> > I decided that eliding the use of 'bytes' here was the wrong approach,
> > because it very much needs to be put back in for the merge.
> 
> Is there any good reason to not just delay the iomp_zero_iter folio
> conversion for now?

It would hold up about half of the iomap folio conversion (~10 patches).
I don't understand what the benefit is of your patch series.  Moving
filesystems away from being bdev based just doesn't seem interesting
to me.  Having DAX as an optional feature that some bdevs have seems
like a far superior option.
