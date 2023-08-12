Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3277A2AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 22:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjHLUnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHLUnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:43:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7684710F2;
        Sat, 12 Aug 2023 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aB77Wk/7coo4TD642I2PGM5/78kptrrLVMQdKyaKs4E=; b=Ym3jI/2h44grHdRLpzf7ao0YDF
        V6fqK+7zAEHEOs3DXnXGEbJJJvuJWTWRO5OKz6AWWz8YGHkW3M8nHFsaIbFOz23Ts1XJ2LpsXHoxg
        aBO8P3OGS3PvV3xKy6fRsxaZce++2iPGaMiKTPTTb0jzFpGBfnB8P3mrzs/HOo+5bzDOuFWQ9LF7b
        JDscWMwRwHURGpYgKWnLo258DoDb4bEd0zw2zwQfFCiWMQmV5xq26vag0sidhRqH6ZdIhKMP3Ddrq
        huMJiqhGXZSdYgxa2n7YNt9ISkbY5DAyxN82/Pvw/vLgdP7cbMuiW2Oifioez/gRxhS/I9JCAhjPF
        43tMMd0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUvSD-009TfJ-HK; Sat, 12 Aug 2023 20:43:21 +0000
Date:   Sat, 12 Aug 2023 21:43:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/17] block: consolidate __invalidate_device and
 fsync_bdev
Message-ID: <ZNfu6THHySvQWViA@casper.infradead.org>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-14-hch@lst.de>
 <20230812105133.GA11904@lst.de>
 <20230812170400.11613-A-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812170400.11613-A-hca@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 12, 2023 at 07:04:00PM +0200, Heiko Carstens wrote:
> On Sat, Aug 12, 2023 at 12:51:33PM +0200, Christoph Hellwig wrote:
> > The buildbot pointed out correctly (but rather late), that the special
> > s390/dasd export needs a _MODULE postfix, so this will have to be
> > folded in:
> > 
> > diff --git a/block/bdev.c b/block/bdev.c
> > index 2a035be7f3ee90..a20263fa27a462 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -967,7 +967,7 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
> >  
> >  	invalidate_bdev(bdev);
> >  }
> > -#ifdef CONFIG_DASD
> > +#ifdef CONFIG_DASD_MODULE
> 
> This needs to be
> 
> #if IS_ENABLED(CONFIG_DASD)
> 
> to cover both CONFIG_DASD=y and CONFIG_DASD=m.

Sure, but if DASD is built-in, the symbol doesn't need to be exported
