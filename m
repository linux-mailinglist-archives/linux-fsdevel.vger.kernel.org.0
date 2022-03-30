Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77ED4EC8DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 17:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348448AbiC3P4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348446AbiC3Pz6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:55:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD311DB4;
        Wed, 30 Mar 2022 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zgJahthblrjKbqaY7f2PuA88vk8rig69ldhivBAreas=; b=4GNWGeDvRNOgUTWNDjnzWyeY/C
        YwODcIN5h+qUhp1m4jVbN8ySsDErdMwols/Kz38AjysIcoNHH+/UCxxURTetyyS3dI8dv2Q2XMugV
        ylkqjMnWWFUK4H9FGxm4v3Ov4ff9qL6E+adAPbh1Pp+vtAsq30tRUizl0xvcqjzs66+fiEh65mqSS
        1YFP8u/dF/MYgtTi3H865KS5PxSAhh4860vBW3u9vGXLB3Bj9m/wh52kbzEeUdDFCKIsvMB1JeyhI
        g05xaMJ1h8ZQwFoEFMsMp1JMp5pcETAY/14w3iokNjK9Fx/muRe6T93w8zcxB/LAKvOkwfyqjLR5a
        6rwBWldQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZae9-00GgSX-PK; Wed, 30 Mar 2022 15:54:09 +0000
Date:   Wed, 30 Mar 2022 08:54:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Christoph Hellwig <hch@infradead.org>, CGEL <cgel.zte@gmail.com>,
        axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Message-ID: <YkR9IW1scr2EDBpa@infradead.org>
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
 <YjiMsGoXoDU+FwsS@cmpxchg.org>
 <623938d1.1c69fb81.52716.030f@mx.google.com>
 <YjnO3p6vvAjeMCFC@cmpxchg.org>
 <20220323061058.GA2343452@cgel.zte@gmail.com>
 <62441603.1c69fb81.4b06b.5a29@mx.google.com>
 <YkRUfuT3jGcqSw1Q@cmpxchg.org>
 <YkRVSIG6QKfDK/ES@infradead.org>
 <YkR7NPFIQ9h2AK9h@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkR7NPFIQ9h2AK9h@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:45:56AM -0400, Johannes Weiner wrote:
> > FYI, I started redoing that version and I think with all the cleanups
> > to filemap.c and the readahead code this can be done fairly nicely now:
> > 
> > http://git.infradead.org/users/hch/block.git/commitdiff/666abb29c6db870d3941acc5ac19e83fbc72cfd4
> 
> Yes, it's definitely much nicer now with the MM instantiating the
> pages for ->readpage(s).
> 
> But AFAICS this breaks compressed btrfs (and erofs?) because those
> still do additional add_to_page_cache_lru() and bio submissions.

In btrfs, add_ra_bio_pages only passed freshly allocated pages to
add_to_page_cache_lru.  These can't really have PageWorkingSet set,
can they?  In erofs they can also come from a local page pool, but
I think otherwise the same applies.
