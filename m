Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6193B6EB2C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjDUUOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDUUON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:14:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022092717;
        Fri, 21 Apr 2023 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A2XozTJws4toh13zEJ4n565nKKguH3N7JeE3lhWnoDE=; b=KazI3OChQ8xi0cwyBWWi2wSA+d
        Dv6s5by1QWGWvpAlTZWGesKNdytZlLSAOalemBEZO5rELZUMfVeAY1yZ3qclyF0geINsWblz8o9JL
        KrCp/O0cKi2DLEYQQN08eZ21fTIZ0L+F8tqLSxzO0hmvR/ttXJr3rOL0pEgRfoaFXGQvs5IVHOHZZ
        zxTc3G+5goFSv5y1kllt2rSeIkt+cwOtNK+S+HhWtGPacqN3frlkpTebwCYWwbszRhF/mRefjwcIe
        CuzZGi/qjzq6oLG6SAyyoiOIgXbRDVTOGZtPQOQ5R3M4zoPS5TI38FfuJsg7RWNB05tynED3yvDp7
        IUu5SVig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ppx8q-00FZlw-Dy; Fri, 21 Apr 2023 20:14:00 +0000
Date:   Fri, 21 Apr 2023 21:14:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, hch@infradead.org,
        djwong@kernel.org, minchan@kernel.org, senozhatsky@chromium.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        hare@suse.de, p.raghav@samsung.com, da.gomez@samsung.com,
        kbusch@kernel.org
Subject: Re: [PATCH 3/5] iomap: simplify iomap_init() with PAGE_SECTORS
Message-ID: <ZELuiBNNHTk4EdxH@casper.infradead.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
 <20230421195807.2804512-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421195807.2804512-4-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 12:58:05PM -0700, Luis Chamberlain wrote:
> Just use the PAGE_SECTORS generic define. This produces no functional
> changes. While at it use left shift to simplify this even further.

How is FOO << 2 simpler than FOO * 4?

> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> +	return bioset_init(&iomap_ioend_bioset, PAGE_SECTORS << 2,

