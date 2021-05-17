Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BAC383BBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 19:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbhEQR4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhEQR4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 13:56:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD0C061573;
        Mon, 17 May 2021 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=llr2rFXUC4HipaZi+CjQK2ZxikULlWbDjkjYGp4sZlQ=; b=ctfjWNS6UWv53k8ml2O7N4aGBz
        ta7r7ptilv88ysLe6ftKPb6zmGV9+6bbmu/0TPg7jGLPIDQmiRtHbhgnpEOHi2iXnQn0DMYby7Qoq
        nIfVxai2u8RfUZGnxlQnCVP5JnmFs6rnRbHnzAxNmEfzTpHlronz81OKJK2/5j8WcHQmOJazC/CJv
        ne2+lwo1NIwZHcM8FYI+LLATiwJQfpIatGuR1DRUh9Q5qVpKev+twx29caNkaxd23jEei6Ehwatj8
        ANsZD0Cq3aNYtr6xNTDtVLCRH2+iUh9uGW7oL8fuCSBTpyWb91kW785jk734E1ql3Li86K2BqVBrx
        6GIXD7zg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lihRq-00DFty-3n; Mon, 17 May 2021 17:54:39 +0000
Date:   Mon, 17 May 2021 18:54:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iomap: resched ioend completion when in
 non-atomic context
Message-ID: <YKKt2isZwu0qJK/C@casper.infradead.org>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-2-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517171722.1266878-2-bfoster@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 01:17:20PM -0400, Brian Foster wrote:
> @@ -1084,9 +1084,12 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  			next = bio->bi_private;
>  
>  		/* walk each page on bio, ending page IO on them */
> -		bio_for_each_segment_all(bv, bio, iter_all)
> +		bio_for_each_segment_all(bv, bio, iter_all) {
>  			iomap_finish_page_writeback(inode, bv->bv_page, error,
>  					bv->bv_len);
> +			if (!atomic)
> +				cond_resched();
> +		}

I don't know that it makes sense to check after _every_ page.  I might
go for every segment.  Some users check after every thousand pages.

