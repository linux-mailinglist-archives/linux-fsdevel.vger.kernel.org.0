Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85D66EC5C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjDXF5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjDXF5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:57:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7535D3A99;
        Sun, 23 Apr 2023 22:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=edf2YE6tOjy5o639pmoNCDDnqNTZQ8NPmup4HBvbC60=; b=qBKmlBP0RbumDgdRWERGFEVbSD
        kDf8Kr5lk5aB2+nWak9xt17TfHD2PupAuPb1mUJmwaPm/dURvhYPVWSPaaOFCU9vr679O7rjTbCXX
        FY14jwJ6foFME5jmhn6hiaV5cvLy3w+4wiA9HOCqY9FKPUwzVOJnoZoumJfKXe+j3dCSf+I4DhyyN
        meS9IcfszZYuw8bakpryb8WeNnXvLqGFAShnlXlum+ZdAx1uWAgWfJ88JFAJBehhF7KCT0OC/pGsx
        saWH2fGCCZFbpsAwVDoLKGMeyxz9Qo8euhIsqOiC8WZE42QMSALorud5SvHI394LQ9T2HdWzjtMUM
        uj/muRvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqpAv-00FPys-1e;
        Mon, 24 Apr 2023 05:55:45 +0000
Date:   Sun, 23 Apr 2023 22:55:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        hch@infradead.org, djwong@kernel.org, minchan@kernel.org,
        senozhatsky@chromium.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
        da.gomez@samsung.com, kbusch@kernel.org
Subject: Re: [PATCH 3/5] iomap: simplify iomap_init() with PAGE_SECTORS
Message-ID: <ZEYZ4ScVDXviFJ/J@infradead.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
 <20230421195807.2804512-4-mcgrof@kernel.org>
 <ZELuiBNNHTk4EdxH@casper.infradead.org>
 <ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
 <20230421223420.GH3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421223420.GH3223426@dread.disaster.area>
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

On Sat, Apr 22, 2023 at 08:34:20AM +1000, Dave Chinner wrote:
> > 
> > -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> > +	return bioset_init(&iomap_ioend_bioset, 4 * PAGE_SECTORS,
> 
> Yes, please.
> 
> > The shift just seemed optimal if we're just going to change it.
> 
> Nope, it's just premature optimisation at the expense of
> maintainability. The compiler will optimise the multiplication into
> shifts if that is the fastest way to do it for the given
> architecture the code is being compiled to.

We still had cases of the compiler not doing obvious
multiplication/division to shift conversion lately.  That being said:

 1) this is an initialization path, no one actually cares
 2) we're dealing with constants here, and compilers are really good
    at constant folding

so yes, this should be using the much more readable version.

