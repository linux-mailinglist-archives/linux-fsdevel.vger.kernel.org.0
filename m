Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F019194522
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 18:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCZRLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 13:11:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZRLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2p5zEqza+tyT0bEi0zEnFS6alNElrx9c6VPcWf/n/I8=; b=Gm4S+LjYEf8c1BKLXNVRrNSjRt
        Ah1vBdm7UVeQPtFfAhVo8aZzOpKb4RM/6zrxjtmmM+x7cQMowzZkxje+LutajHMeIhW+2z4GITIeF
        +XYoG9N9xzApFcG25Hu4r762u1FD0Sp71Cv8ozKuMR1BeLSj9Vi5ePAMdIXmwUz8nv5om+UNYmLtn
        ++BL7TETwkuUs95HKFVkMBDfcCYIZl2i1m7dkpVQpH3PpNCBFhKM8oXJ0Hvyej8r/J4VaC/yg1eul
        d7pdZFQNuTuF+QvSt6MRSwexHaexLFeXQHf8lRyZPvUCHlHEH7OXb3bH0nkkqQbuqveDd9s4LkEn/
        FEqhvQvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHW2E-00034A-VK; Thu, 26 Mar 2020 17:11:14 +0000
Date:   Thu, 26 Mar 2020 10:11:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Use clear_bit_unlock_is_negative_byte for
 PageWriteback
Message-ID: <20200326171114.GA6566@infradead.org>
References: <20200326122429.20710-1-willy@infradead.org>
 <20200326122429.20710-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326122429.20710-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 26, 2020 at 05:24:29AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By moving PG_writeback down into the low bits of the page flags, we can
> use clear_bit_unlock_is_negative_byte() for writeback as well as the
> lock bit.  wake_up_page() then has no more callers.  Given the other
> code being executed between the clear and the test, this is not going
> to be as dramatic a win as it was for PageLocked, but symmetry between
> the two is nice and lets us remove some code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/page-flags.h |  6 +++---
>  mm/filemap.c               | 19 ++++++-------------
>  mm/page-writeback.c        | 37 ++++++++++++++++++++-----------------
>  3 files changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 222f6f7b2bb3..96c7d220c8cf 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -103,13 +103,14 @@
>   */
>  enum pageflags {
>  	PG_locked,		/* Page is locked. Don't touch. */
> +	PG_writeback,		/* Page is under writeback */

Do we need a comment why these need to be in the low bits?
