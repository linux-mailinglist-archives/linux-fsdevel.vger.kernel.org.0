Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE571471F28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 02:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhLMBeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 20:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhLMBeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 20:34:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900DC06173F;
        Sun, 12 Dec 2021 17:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gou1UfwX7qMfAQ4nSqcGyhJ4okrKDZEARAtLXflaxQE=; b=lVz3vg7VeBfBoEi+/WP09m6s0D
        qmLvFhQA/W4WWiNLl9eNM1jyWrJvR0zcxu0x/8P8VfidMbD0CM/foeHQhxEv6rOr+j5Gn/P54ZWgK
        39AFiMt5bwXGO7ru9GuKY1QZBek5mn13MU8USCD5RZ9Wl+5RLLaWzM37RPMlvRzP4Ts7lqj5rFHzE
        ey0FKlTiXsbKVrJPXpOjF0R/0OeaJ+HWrDAeQHQyqIOKp0GB5BQZ4+ygsPPEzIBHzp5dkzFGKXvSk
        zg1hUOs0aOLogNObItyuKQdOl/lZKomHct/Y/EWYLyImP+KQh4W7jluu4JGzUibo6k5rwS7fDE+xr
        cRvMReAw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwaEI-00CLUa-Gn; Mon, 13 Dec 2021 01:34:14 +0000
Date:   Mon, 13 Dec 2021 01:34:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] vmcore: Convert copy_oldmem_page() to take an
 iov_iter
Message-ID: <YbajFsMwJvQ6MC7N@casper.infradead.org>
References: <20211213000636.2932569-1-willy@infradead.org>
 <20211213000636.2932569-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213000636.2932569-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:06:34AM +0000, Matthew Wilcox (Oracle) wrote:
> +++ b/arch/arm/kernel/crash_dump.c
> @@ -27,9 +27,8 @@
>   * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
>   * copied or negative error in case of failure.
>   */
> -ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> -			 size_t csize, unsigned long offset,
> -			 int userbuf)
> +ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
> +			 size_t csize, unsigned long offset)
>  {
>  	void *vaddr;
>  

I forgot to mention that I didn't adjust the kernel-doc.  I'm tempted to
remove it entirely, to be honest.  It's not included into the rst files,
and having the documentation repeated ten times across arch directories
isn't useful.
