Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47E33A87DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhFORgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhFORf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:35:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7E4C0611BE;
        Tue, 15 Jun 2021 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=scxudT0Fgrjf5dg2kq1HoLcZSqo+IAeOJSwNAM+VhfI=; b=B9Wch8bEkIKY6dWxYd/dZu00w6
        LND/yDN+axubI22bh2wmeWj46Pwyy2+2jnlO7j2t1rx1zZGHy3RL22ZU/0CoZaCaoKk7bmQQ/9wKp
        i9yv/y5rT5KGQ+fwdLlDdRuqnlGy6Rv5DEMDptVb5wXhFHqSa3faYMrvjW/fYFcTQb7CO+A+35qQZ
        uq263anRm97B18VVYWIqTVc+amQQ0j9pkJPIRTQuzM5dZArRZ5TRDu+2fhMU5Sf2XYOJJh9NduuXC
        1MiBSwLHvPkFgkKDBp3UofDAM4bgv78VlxzNxQ08/VlmQObpEEBE/KciOa494kxdu2hKvlKpVE6iw
        6YmEC2cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltCvV-0074fj-Qg; Tue, 15 Jun 2021 17:32:40 +0000
Date:   Tue, 15 Jun 2021 18:32:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: Use __set_page_dirty_nobuffers
Message-ID: <YMjkNd0zapLcooNB@casper.infradead.org>
References: <20210615162342.1669332-1-willy@infradead.org>
 <20210615162342.1669332-4-willy@infradead.org>
 <YMjhP+Bk5PY5yqm7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMjhP+Bk5PY5yqm7@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:19:59PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 15, 2021 at 05:23:39PM +0100, Matthew Wilcox (Oracle) wrote:
> Using __ functions in structures in different modules feels odd to me.
> Why not just have iomap_set_page_dirty be a #define to this function now
> if you want to do this?
> 
> Or take the __ off of the function name?
> 
> Anyway, logic here is fine, but feels odd.

heh, that was how I did it the first time.  Then I thought that it was
better to follow Christoph's patch:

 static const struct address_space_operations adfs_aops = {
+       .set_page_dirty = __set_page_dirty_buffers,
(etc)
