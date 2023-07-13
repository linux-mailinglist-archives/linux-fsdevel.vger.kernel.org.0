Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8899C7527D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjGMP4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 11:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjGMP4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:56:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8294C26AE;
        Thu, 13 Jul 2023 08:56:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC4A86732D; Thu, 13 Jul 2023 17:56:31 +0200 (CEST)
Date:   Thu, 13 Jul 2023 17:56:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        ltp@lists.linux.it, lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>, oe-lkp@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [LTP] [linus:master] [iomap]  219580eea1: ltp.writev07.fail
Message-ID: <20230713155631.GA29281@lst.de>
References: <202307132107.2ce4ea2f-oliver.sang@intel.com> <20230713150923.GA28246@lst.de> <ZLAZn_SBmoIFG5F5@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLAZn_SBmoIFG5F5@yuki>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 05:34:55PM +0200, Cyril Hrubis wrote:
>                 iter.processed = iomap_write_iter(&iter, i);
> 
> +       iocb->ki_pos += iter.pos - iocb->ki_pos;
> +
>         if (unlikely(ret < 0))
>                 return ret;
> -       ret = iter.pos - iocb->ki_pos;
> -       iocb->ki_pos += ret;
> -       return ret;
> +
> +       return iter.pos - iocb->ki_pos;

I don't think this works, as iocb->ki_pos has been updated above.
What you want is probably the version below.  But so far I can't
reproduce anything yet..

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index adb92cdb24b009..02aea0174ddbcf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -872,7 +872,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_write_iter(&iter, i);
 
-	if (unlikely(ret < 0))
+	if (iter.pos == iocb->ki_pos)
 		return ret;
 	ret = iter.pos - iocb->ki_pos;
 	iocb->ki_pos += ret;
