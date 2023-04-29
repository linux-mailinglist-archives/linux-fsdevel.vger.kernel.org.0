Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2846F22F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 06:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjD2Eko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 00:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjD2Ekn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:40:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4A30D2;
        Fri, 28 Apr 2023 21:40:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9BE0268D13; Sat, 29 Apr 2023 06:40:38 +0200 (CEST)
Date:   Sat, 29 Apr 2023 06:40:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <20230429044038.GA7561@lst.de>
References: <ZEny7Izr8iOc/23B@casper.infradead.org> <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com> <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com> <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com> <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com> <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com> <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com> <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com> <ZEtd6qZOgRxYnNq9@mit.edu> <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 29, 2023 at 11:16:14AM +0800, Ming Lei wrote:
> OK, looks both Dave and you have same suggestion, and IMO, it isn't hard to
> add one interface for notifying FS, and it can be either one s_ops->shutdown()
> or shutdown_filesystem(struct super_block *sb).

It's not that simple.  You need to be able to do that for any device used
by a file system, not just s_bdev.  This means it needs go into ops
passed by the bdev owner, which is also needed to propagate this through
stackable devices.

I have some work on that, but the way how blkdev_get is called in the
generic mount helpers is a such a mess that I've not been happy with
the result yet.  Let me see if spending extra time with it will allow
me to come up with something that doesn't suck.

> But the main job should be how this interface is implemented in FS/VFS side,
> so it looks one more FS job, and block layer can call shutdown_filesystem()
> from del_gendisk() simply.

This needs to be called from blk_mark_disk_dead for drivers using that,
and from del_gendisk only if GD_DEAD isn't set yet.
