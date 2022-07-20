Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3916B57B0C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 08:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiGTGEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 02:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbiGTGEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:04:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ABC65D7A;
        Tue, 19 Jul 2022 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=opw3pkg9MKPmz9HBHhoEOSCX/4fVSd9GJbKVFnBB1bQ=; b=009wHgCqWpQKNwVR2UBJag0ovx
        4wvkFS9R+0dytc8DHeTt2ztFC+qO4DpdY3U9uOVt0nZknhJCInJxtvKLwWEHPGaZrGNbO22CqUpGK
        Xx71Je8WNSViMlYX0rPxlSePYOhvYlaIsz43DEs59fyOHs1CEpW1/93j3julJislhwRmvNjUa0eEg
        Oj0XnpLjCg/sDSJ7qSGEfIkgDOPMWUcAZ/q7pzSlZrPXiecgjQoGOKcgj9/BqYnmaJHwiO6fk1WI/
        MKQC5SpI7WzmODclNMFFw4zIuLgKy0A2j3cSILNNy+dSkcwni8pT4o1lwvNa0yL8j7nswsgE1tvXv
        PPrREAGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE2p2-000u6T-VI; Wed, 20 Jul 2022 06:04:36 +0000
Date:   Tue, 19 Jul 2022 23:04:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        hughd@google.com, akpm@linux-foundation.org, hch@infradead.org,
        hsiangkao@linux.alibaba.com, yang.yang29@zte.com.cn,
        axboe@kernel.dk, yangerkun@huawei.com, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] fs: drop_caches: skip dropping pagecache which is always
 dirty
Message-ID: <Ytea9M3D/CuzQ1se@infradead.org>
References: <20220720022118.1495752-1-yang.yang29@zte.com.cn>
 <YtdwULpWfSR3JI/u@casper.infradead.org>
 <62d79a79.1c69fb81.e4cba.37f5@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d79a79.1c69fb81.e4cba.37f5@mx.google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 06:02:32AM +0000, CGEL wrote:
> For example, some systems will create a lot of pagecache when boot up
> while reading bzImage, ramdisk, docker images etc. Most of this pagecache
> is useless after boot up. It may has a longterm negative effects for the
> workload when trigger page reclaim. It is especially harmful when trigger
> direct_reclaim or we need allocate pages in atomic context. So users may
> chose to drop_caches after boot up.

It is purely a debug interface.  If you want to drop specific page cache
that needs to be done through madvise.
