Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A406F445081
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 09:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKDInW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 04:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhKDInW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:43:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77918C061714;
        Thu,  4 Nov 2021 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kM6GrF6SJ88sCE1yx7wY0xKWNFrPLecWgtod0L4NR4w=; b=eZrGZ78iepNkbX/hRBtrDBUFnH
        rXQkIGGEGfraz7hIhy7RLwcpD8gu2De7+5PfCRciTMwUL2r7eO9TyeAIqNE/D83YWypHcea3htyJG
        xIne7L7Tri87hyXmfHcCwImnkWM2Wdtot7bOkWVVfFaz6UqbJwBmL8vbNWAaLTJp0oJJ+76L/zVSv
        6Py7hRAL3exjBIcT+ZKebQ/r6DSzB6sF3QrWwLxwuUu3hzk2K+E9HBC3/ejfcoN0ZV012ZX8LgWqN
        nyyuLF1/OMIYdI2Dyj4PHXsL1gD+dgstDOjtCTdUKgZ0nOYVnlUff7pYGPIosNHQVVOIakh30bCQg
        uw9d2l1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miYIb-008LJP-VR; Thu, 04 Nov 2021 08:40:41 +0000
Date:   Thu, 4 Nov 2021 01:40:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 18/21] iomap: Convert iomap_add_to_ioend to take a folio
Message-ID: <YYOciWjJJe6L4cyZ@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-19-willy@infradead.org>
 <YYDoMltwjNKtJaWR@infradead.org>
 <YYGfUuItAyTNax5V@casper.infradead.org>
 <YYKwyudsHOmPthUP@infradead.org>
 <YYNUoONKjuo6Izfz@casper.infradead.org>
 <YYOcGK43XbnumvHi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYOcGK43XbnumvHi@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 04, 2021 at 01:38:48AM -0700, Christoph Hellwig wrote:
> > I _think_ we restrict the maximum file size to 2^63 - 1 to avoid i_size
> > ever being negative.  But that means that end_pos might be 2^63 (ie
> > LONG_MIN), so we need to subtract one from it to get the right answer.
> > Maybe worth a comment?
> 
> Yes, please.

Or we should stick to the u64 type that the existing code uses to side
step that whole issue..
