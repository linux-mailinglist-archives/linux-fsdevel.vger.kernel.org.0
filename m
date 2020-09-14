Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400162682AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 04:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgINCiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Sep 2020 22:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgINCiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Sep 2020 22:38:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772ACC06174A;
        Sun, 13 Sep 2020 19:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=foSJHlpBe6gcd61pKLNqX/2sWS5bAE8KyXL2HUr7NBY=; b=naM+zThM+ntIzPZxZ+yJTXCbZn
        7clu56ollaZqSIgDUCOFbFG8oHooyJHXFeP18rlh+tjJDWM68AN5D1IXCRGdLGH3SL3Mkr2NFXfls
        qH1wGdUR4eUapYD/w/OMZr9s5144nyfbfxIOHk1dQchZXOrBiAQ4yVy3H3RdRC0P0QngOKkZnQ8BG
        yfqqdcF/rvvbXeUP5zJxbK0Yzl0AJmHf19vykRBL0p1hBN8hJL1QeWX47QzTak4/gmkYxq6YcxTuS
        g2cyxc69wqqWsVKzO+/2xbPTD+oqBUGUmltDvSHmxHjzO4/Zb7Gywhfc9LjkzLgj9qWVCL9CjYIUT
        KVuPy0YA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHeOD-0008QM-Rb; Mon, 14 Sep 2020 02:38:46 +0000
Date:   Mon, 14 Sep 2020 03:38:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, rdunlap@infradead.org, mark@harmstone.com,
        nborisov@suse.com
Subject: Re: [PATCH v5 03/10] fs/ntfs3: Add bitmap
Message-ID: <20200914023845.GJ6583@casper.infradead.org>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-4-almaz.alexandrovich@paragon-software.com>
 <d1dc86f2792d3e64d1281fc2b5fddaca5fa17b5a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1dc86f2792d3e64d1281fc2b5fddaca5fa17b5a.camel@perches.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 13, 2020 at 11:43:50AM -0700, Joe Perches wrote:
> On Fri, 2020-09-11 at 17:10 +0300, Konstantin Komarov wrote:
> > This adds bitmap
> 
> $ make fs/ntfs3/
>   SYNC    include/config/auto.conf.cmd
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CC      fs/ntfs3/bitfunc.o
>   CC      fs/ntfs3/bitmap.o
> fs/ntfs3/bitmap.c: In function ‘wnd_rescan’:
> fs/ntfs3/bitmap.c:556:4: error: implicit declaration of function ‘page_cache_readahead_unbounded’; did you mean ‘page_cache_ra_unbounded’? [-Werror=implicit-function-declaration]
>   556 |    page_cache_readahead_unbounded(
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |    page_cache_ra_unbounded
> cc1: some warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:283: fs/ntfs3/bitmap.o] Error 1
> make[1]: *** [scripts/Makefile.build:500: fs/ntfs3] Error 2
> make: *** [Makefile:1792: fs] Error 2

That was only just renamed.  More concerningly, the documentation is
quite unambiguous:

 * This function is for filesystems to call when they want to start
 * readahead beyond a file's stated i_size.  This is almost certainly
 * not the function you want to call.  Use page_cache_async_readahead()
 * or page_cache_sync_readahead() instead.

