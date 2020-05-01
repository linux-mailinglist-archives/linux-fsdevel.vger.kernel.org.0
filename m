Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFB31C2073
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 00:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEAWQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 18:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAWQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 18:16:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C11C061A0C;
        Fri,  1 May 2020 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cQpoyHNCKar6ZGfYw/JVeq7Gq/wjyHQEcHJjZyc70e0=; b=lwyWH8eUA9yp/PjFEZ0fOXMz32
        W+3BVOGRKPxbCZVFpFcKFZ/YxhVhWKlpaBnzQ28JUrmpYm+VEr/9CTnOSTiVVPdxDFWeXyVSfQH6e
        QoRe2erhHBOe4Qxt5tmP6xoRX48PSfw61DOGEX/2n5cqzekCtVJ0vLT7apga4kvNWxZwz0hG6qdxw
        UAyCSMKEg/xFrkznY8/Tr/B8+lMaO0Jr1S1NqI8zddcQNfMX3crNmRhs4lvMxiXZkY6s7lGmp1s8S
        l/n+eGhY40oSiw6AROzmD2WuUoF6ZqdshEkyUFSey/HZ2LxrDnJd+dW3S6vjXjD1jvxF8iNptuhMX
        aRWYV7qQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUdxK-0003xq-Cv; Fri, 01 May 2020 22:16:26 +0000
Date:   Fri, 1 May 2020 15:16:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com
Subject: Re: [RFC PATCH V2 0/9] Introduce attach/clear_page_private to
 cleanup code
Message-ID: <20200501221626.GC29705@bombadil.infradead.org>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:44:41PM +0200, Guoqing Jiang wrote:
>   include/linux/pagemap.h: introduce attach/clear_page_private
>   md: remove __clear_page_buffers and use attach/clear_page_private
>   btrfs: use attach/clear_page_private
>   fs/buffer.c: use attach/clear_page_private
>   f2fs: use attach/clear_page_private
>   iomap: use attach/clear_page_private
>   ntfs: replace attach_page_buffers with attach_page_private
>   orangefs: use attach/clear_page_private
>   buffer_head.h: remove attach_page_buffers

I think mm/migrate.c could also use this:

        ClearPagePrivate(page);
        set_page_private(newpage, page_private(page));
        set_page_private(page, 0);
        put_page(page);
        get_page(newpage);

