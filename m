Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C8675ADC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 14:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjGTMG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 08:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjGTMG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:06:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7751711;
        Thu, 20 Jul 2023 05:06:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DDB576732D; Thu, 20 Jul 2023 14:06:50 +0200 (CEST)
Date:   Thu, 20 Jul 2023 14:06:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/17] block: use iomap for writes to block devices
Message-ID: <20230720120650.GA13266@lst.de>
References: <20230424054926.26927-1-hch@lst.de> <20230424054926.26927-17-hch@lst.de> <b96b397e-2f5e-7910-3bb3-7405d0e293a7@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96b397e-2f5e-7910-3bb3-7405d0e293a7@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 04:22:01PM +0200, Hannes Reinecke wrote:
> I'm hitting this during booting:
> [    5.016324]  <TASK>
> [    5.030256]  iomap_iter+0x11a/0x350
> [    5.030264]  iomap_readahead+0x1eb/0x2c0
> [    5.030272]  read_pages+0x5d/0x220
> [    5.030279]  page_cache_ra_unbounded+0x131/0x180
> [    5.030284]  filemap_get_pages+0xff/0x5a0
> [    5.030292]  filemap_read+0xca/0x320
> [    5.030296]  ? aa_file_perm+0x126/0x500
> [    5.040216]  ? touch_atime+0xc8/0x150
> [    5.040224]  blkdev_read_iter+0xb0/0x150
> [    5.040228]  vfs_read+0x226/0x2d0
> [    5.040234]  ksys_read+0xa5/0xe0
> [    5.040238]  do_syscall_64+0x5b/0x80
>
> Maybe we should consider this patch:

As willy said this should be taken care of by the i_size check.
Did you run with just this patch set or some of the large block
size experiments on top which might change the variables?

I'll repost the series today without any chances in the area, and
if you can reproduce it with just that series we need to root
cause it, so please send your kernel and VM config along for the
next report.
