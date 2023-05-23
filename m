Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7265E70D03D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 03:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjEWBMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 21:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjEWBM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 21:12:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11308E;
        Mon, 22 May 2023 18:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65C5962D60;
        Tue, 23 May 2023 01:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4572C433EF;
        Tue, 23 May 2023 01:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684804346;
        bh=ZAzh2JNRCsiTX6v9YnyrLbWHKhYqrabrMaOhNbQDKt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XA9zKICML07FeJjfGnwZEsKdRfAesSdvaaHFlpSZu8WKwtPS/f0ia/t7cGRGTyNg8
         rT47MwwEolWaHM51ZumONutB3+Qf5F12m8Z1kVmc2gMNJAka7ZrHhQv+ohAfxmjULN
         /2aDsxU2KzjD+vNRj/AiuZQD9F5M3i7Ev7sTWBz1AKeTf5KddszyQ6/YCnwWe/h4U7
         jrL//iKf2/JOVhxfT/Blv1VumtTkmowtNzBwA7CUgcLjxweF6oJXfG2AyYi9pNXgqH
         jP3o/0cJLs+Dt54A0XsaAGrmEVutP7KfJXFX8dB/TIRPNdcNKc2IgCreYwgPmGaNnn
         TdjhaErmpweVA==
Date:   Mon, 22 May 2023 18:12:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: cleanup the filemap / direct I/O interaction
Message-ID: <20230523011226.GF11642@frogsfrogsfrogs>
References: <20230519093521.133226-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519093521.133226-1-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 11:35:08AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up some of the generic write helper calling
> conventions and the page cache writeback / invalidation for
> direct I/O.  This is a spinoff from the no-bufferhead kernel
> project, for while we'll want to an use iomap based buffered
> write path in the block layer.

Heh.

For patches 3 and 8, I wonder if you could just get rid of
current->backing_dev_info?

For patches 2, 4-6, and 10:
Acked-by: Darrick J. Wong <djwong@kernel.org>

For patches 1, 7, and 9:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

The fuse patches I have no idea about. :/

--D

> diffstat:
>  block/fops.c            |   18 ----
>  fs/ceph/file.c          |    6 -
>  fs/direct-io.c          |   10 --
>  fs/ext4/file.c          |   12 ---
>  fs/f2fs/file.c          |    3 
>  fs/fuse/file.c          |   47 ++----------
>  fs/gfs2/file.c          |    7 -
>  fs/iomap/buffered-io.c  |   12 ++-
>  fs/iomap/direct-io.c    |   88 ++++++++--------------
>  fs/libfs.c              |   36 +++++++++
>  fs/nfs/file.c           |    6 -
>  fs/xfs/xfs_file.c       |    7 -
>  fs/zonefs/file.c        |    4 -
>  include/linux/fs.h      |    7 -
>  include/linux/pagemap.h |    4 +
>  mm/filemap.c            |  184 +++++++++++++++++++++---------------------------
>  16 files changed, 190 insertions(+), 261 deletions(-)
