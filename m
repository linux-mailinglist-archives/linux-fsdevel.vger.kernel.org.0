Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2AA17934A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 16:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCDPZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 10:25:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCDPZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NLR1W71Y/VoqRQTjf9FpHr9ctwEcNNeQYoWDLtxQNh4=; b=oA5QWTME9j08l8wVRW8JreB/id
        sTucpH7cYGXnG9ZWD13wHM+xZj331KRknVrTtl/8vBLeW0bbhYUCLyixdlYvOpsvTerk09jnasre1
        +N7LVR9DBGNl0e+d+N4wY4eHS+QBSiJYBua72tK6j18zHkSzvtFDyZim3UznxMlWrCD1S2Wn8ohep
        uvMFkd01bLEepBeoi97d//1z/NJNrZ/oa46EpP9WhHiya6GwIQgfWtWrjXNW6RYsILAguIxvKIkQ3
        WBsuW1wN7lHzxN0Aw8g4I6t5s2pxe8xG0SpWSJ+UWg64Fnpn9Dzxr0mfdonSDCWdFECjADvyz/fdZ
        zsvPJsUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9Vtb-0007G4-32; Wed, 04 Mar 2020 15:25:15 +0000
Date:   Wed, 4 Mar 2020 07:25:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] iomap: Fix writepage tracepoint pgoff
Message-ID: <20200304152515.GA23148@infradead.org>
References: <20200304142259.GF29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304142259.GF29971@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 06:22:59AM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> page_offset() confusingly returns the number of bytes from the
> beginning of the file and not the pgoff, which the tracepoint claims
> to be returning.  We're already returning the number of bytes from the
> beginning of the file in the 'offset' parameter, so correct the pgoff
> to be what was apparently intended.
> 
> Fixes: 0b1b213fcf3a ("xfs: event tracing support")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I wonder if tracing the byte offset and just changing the name
might be more useful.  But I agree that we should fix it one way or
another.
