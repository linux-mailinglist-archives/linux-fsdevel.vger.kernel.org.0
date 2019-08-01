Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A73657D706
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 10:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfHAIQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 04:16:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbfHAIQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K+R31uQAYJxVzLY0NV2lfQguJWjRp7kXscTfedazeQE=; b=C1DulZkKdXZyhRXjAkV96vjDd
        k4fzHk6RD6Vq2mgb1I/HdfGKnnUP/1Bb20dVqsxjZpx2LkuN3GUqikSuzxznPdrdGUj3WzVGIn7wv
        hVxKkmbIDTIZcD6IYvbOsOkS5uO9/xbJXAlLkJBQsJxEUkv4ZP2sYREiYdK27fuujk6b8cza33Hci
        HJsVwY7lM87oOGPucyyFWLk0ZyO160eqTvURjI7PwB7fA1yJ/hvLVB1SAuS9PiGeGl5gpmOgDe7Xp
        WHT8/6DDs7s1nY4aQ7Bvx1ORWYBl4/mU3ZdDFJesinhVaidQKyy1wMGkxbqR8Xg5CLbDSSF7lgyTo
        a6yhXve7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1ht6Fn-0006B9-Qg; Thu, 01 Aug 2019 08:16:03 +0000
Date:   Thu, 1 Aug 2019 01:16:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/24] xfs:: account for memory freed from metadata
 buffers
Message-ID: <20190801081603.GA10600@infradead.org>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-12-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-12-david@fromorbit.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +
> +		/*
> +		 * Account for the buffer memory freed here so memory reclaim
> +		 * sees this and not just the xfs_buf slab entry being freed.
> +		 */
> +		if (current->reclaim_state)
> +			current->reclaim_state->reclaimed_pages += bp->b_page_count;
> +

I think this wants a mm-layer helper ala:

static inline void shrinker_mark_pages_reclaimed(unsigned long nr_pages)
{
	if (current->reclaim_state)
		current->reclaim_state->reclaimed_pages += nr_pages;
}

plus good documentation on when to use it.
