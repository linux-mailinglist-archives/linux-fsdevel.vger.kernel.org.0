Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4333870E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 02:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfGWAwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 20:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbfGWAwc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:52:32 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D7B2199C;
        Tue, 23 Jul 2019 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563843151;
        bh=QoDXFktQWBBjpdyHJklib+lJgS4BW2A6BFE+HFerPWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qldAgseHrPTRQybgwoDYuxEyG8jbKlaOwXXZCKp00RlNMoCOAGqSm4bAf+McROJz/
         mfL6Is692vmHZ+Bag8epiebNzp9yZjUrQw5ExCZEV6QC2Eng/d11n0S42hba7gjy8G
         myaupLK4kQRgZBzodyvJKQEr/bHTIZpHrw5upEQ0=
Date:   Mon, 22 Jul 2019 17:52:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] mm/filemap: don't initiate writeback if mapping has
 no dirty pages
Message-Id: <20190722175230.d357d52c3e86dc87efbd4243@linux-foundation.org>
In-Reply-To: <156378816804.1087.8607636317907921438.stgit@buzz>
References: <156378816804.1087.8607636317907921438.stgit@buzz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


(cc linux-fsdevel and Jan)

On Mon, 22 Jul 2019 12:36:08 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> Functions like filemap_write_and_wait_range() should do nothing if inode
> has no dirty pages or pages currently under writeback. But they anyway
> construct struct writeback_control and this does some atomic operations
> if CONFIG_CGROUP_WRITEBACK=y - on fast path it locks inode->i_lock and
> updates state of writeback ownership, on slow path might be more work.
> Current this path is safely avoided only when inode mapping has no pages.
> 
> For example generic_file_read_iter() calls filemap_write_and_wait_range()
> at each O_DIRECT read - pretty hot path.
> 
> This patch skips starting new writeback if mapping has no dirty tags set.
> If writeback is already in progress filemap_write_and_wait_range() will
> wait for it.
> 
> ...
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -408,7 +408,8 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>  		.range_end = end,
>  	};
>  
> -	if (!mapping_cap_writeback_dirty(mapping))
> +	if (!mapping_cap_writeback_dirty(mapping) ||
> +	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
>  		return 0;
>  
>  	wbc_attach_fdatawrite_inode(&wbc, mapping->host);

How does this play with tagged_writepages?  We assume that no tagging
has been performed by any __filemap_fdatawrite_range() caller?

