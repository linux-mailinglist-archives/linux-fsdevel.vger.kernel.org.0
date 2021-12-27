Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC547FF86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 16:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhL0PiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 10:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbhL0Pgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:36:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C75EC061A08;
        Mon, 27 Dec 2021 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KlY3YEK6X0uARULPz6Pxb8wpNr9w7Alv1AW3+GE6wi0=; b=NTwFV35Ds0212Hy14VKCVxtteg
        tiwTvimcAs9C+0EGaNbW2nia5scWc6yhNXSQbWefr7tqq+Go984HsodIUOA1ksMQTnl/FiGlUnE4p
        f+36AxQsKEcOt/cq9yvb6DEX9JCc1KD0mk2sWl/yN3vXo+7b5vVpsWb7Hsi0osh4kUDqQNUHBojqP
        w4KCzd7W+CvKb/k/+SN+a9AlkXqLDlklQmE4WBAtTI7LQ2AGXWSSABN788LqTHEZFgi6WnIBS9HEc
        /R8dw6gW/qs1MhBwIT6FWgO86OvfTRl1WdqRPhIzyswUP5J0kklCXEqIW590Qqw8vC9J1LBfpNH3f
        BvW90qtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n1s37-007V8t-4r; Mon, 27 Dec 2021 15:36:33 +0000
Date:   Mon, 27 Dec 2021 15:36:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand
 read
Message-ID: <YcndgcpQQWY8MJBD@casper.infradead.org>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-20-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227125444.21187-20-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 27, 2021 at 08:54:40PM +0800, Jeffle Xu wrote:
> +	spin_lock(&cache->reqs_lock);
> +	ret = idr_alloc(&cache->reqs, req, 0, 0, GFP_KERNEL);

GFP_KERNEL while holding a spinlock?

You should be using an XArray instead of an IDR in new code anyway.

