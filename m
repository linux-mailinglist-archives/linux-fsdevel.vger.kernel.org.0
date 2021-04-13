Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C5335DF9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346065AbhDMM7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 08:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346018AbhDMM7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:59:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CA9C061574;
        Tue, 13 Apr 2021 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BuV1q5D8V6SIiglztXUsg48fr8choFZCNvloWOYq9/c=; b=teEZs3C6B3VrO8PzHFF111v+JU
        cfSq4JLamao5sBMlrt9N0logJX788lyTt/q1RyarNF5K7ueHWbjwjQGn2N2VuABF4lPUQS9VREbAx
        6ZRrKrNW9ipnu8WAzjWH0Kf/c38Ow2CZY5VHvYR+82QOYh7GEXzQVR9ue9AfybdKOnLgRx1HUgNJz
        T3XrYAJX57e+YSJKQi+0WHaeDXJpDkysu6VAffpyxO0m1vQzXuj7dcc/a+/J2QeUoRh9zdn8PlIhb
        WMnkdYKhLY2SwGRrBr1v2WGXvixkzll8zVXsOkrr6GlGVyf6G+6jx4Ii2XLdrTQDTFtjLP7QBpemM
        tty6oxQQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWIby-005kzA-LI; Tue, 13 Apr 2021 12:58:08 +0000
Date:   Tue, 13 Apr 2021 13:57:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] mm: Protect operations adding pages to page cache
 with i_mapping_lock
Message-ID: <20210413125746.GB1366579@infradead.org>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413112859.32249-2-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  	if (error == AOP_TRUNCATED_PAGE)
>  		put_page(page);
> +	up_read(&mapping->host->i_mapping_sem);
>  	return error;

Please add an unlock_mapping label above this up_read and consolidate
most of the other unlocks by jumping there (put_and_wait_on_page_locked
probablt can't use it).

>  truncated:
>  	unlock_page(page);
> @@ -2309,6 +2324,7 @@ static int filemap_update_page(struct kiocb *iocb,
>  	return AOP_TRUNCATED_PAGE;

The trunated case actually seems to miss the unlock.

Similarly I think filemap_fault would benefit from a common
unlock path.
