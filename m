Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40B31C2B54
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgECK1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 06:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgECK1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 06:27:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B28C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2020 03:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PXJzVi9DcMYw4QW4HlkLJ29fvHY2Er138s9UOXtJXhI=; b=omO7ng7XHyZIz9nFubKc9pYiQZ
        S05SCrB8t64Kja5yHvpT7qP4l6LEu/fv0VYEs2RyUt8VdknYDX8ch77ILZ4E8mUk5JX1cjLHPQqza
        UbY60DWOH6HOlMghoqQsJ2AGOO+Xf8TLjZIZrqPijIRQhDfQkiyppFPpFW8MXNqE59liu9aWhbEuL
        6ureWb7UC21n1UE/SjwwrmaC4cOirA4BxsuqJ3KQHuh/VZbHJMTPnmwj04vEvrAsqh5ybOozBAXFE
        ZX0H4fx9/kK7hVEBtxYUMXm/MdnRAIqaDv4eVTmULYAlfbOLUQeDRMq6BAotbGDCrs97Kl4IOJExW
        +aKx0+qA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVBqY-0004UZ-68; Sun, 03 May 2020 10:27:42 +0000
Date:   Sun, 3 May 2020 03:27:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [fuse-devel] fuse: trying to steal weird page
Message-ID: <20200503102742.GF29705@bombadil.infradead.org>
References: <87a72qtaqk.fsf@vostro.rath.org>
 <877dxut8q7.fsf@vostro.rath.org>
 <20200503032613.GE29705@bombadil.infradead.org>
 <87368hz9vm.fsf@vostro.rath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87368hz9vm.fsf@vostro.rath.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 03, 2020 at 09:43:41AM +0100, Nikolaus Rath wrote:
> Here's what I got:
> 
> [  221.277260] page:ffffec4bbd639880 refcount:1 mapcount:0 mapping:0000000000000000 index:0xd9
> [  221.277265] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|lru)
> [  221.277269] raw: 0017ffffc0000097 ffffec4bbd62f048 ffffec4bbd619308 0000000000000000
> [  221.277271] raw: 00000000000000d9 0000000000000000 00000001ffffffff ffff9aec11beb000
> [  221.277272] page dumped because: fuse: trying to steal weird page
> [  221.277273] page->mem_cgroup:ffff9aec11beb000

Great!  Here's the condition:

        if (page_mapcount(page) ||
            page->mapping != NULL ||
            page_count(page) != 1 ||
            (page->flags & PAGE_FLAGS_CHECK_AT_PREP &
             ~(1 << PG_locked |
               1 << PG_referenced |
               1 << PG_uptodate |
               1 << PG_lru |
               1 << PG_active |
               1 << PG_reclaim))) {

mapcount is 0, mapping is NULL, refcount is 1, so that's all fine.
flags has 'waiters' set, which is not in the allowed list.  I don't
know the internals of FUSE, so I don't know why that is.

Also, page_count() is unstable.  Unless there has been an RCU grace period
between when the page was freed and now, a speculative reference may exist
from the page cache.  So I would say this is a bad thing to check for.

Thanks for the swift provision of the debugging data!
