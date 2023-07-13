Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4CE75272F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 17:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjGMPeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjGMPdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:33:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6981FD4;
        Thu, 13 Jul 2023 08:33:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C41522185;
        Thu, 13 Jul 2023 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689262430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnsbM2wbDJKZoJO63kCqa7skAvyrvbFpqW+OFngO6J0=;
        b=sV1pgtAi27tWlGMws6tV7hf/GEtyL/tfm4WbvICemOjJMuus/p2+X17CiUlFl/l1j+rjgD
        xKsKyh+PUXOM5Mtqqoc/ExfUrXx6RAHwtZ6Lb7OFEryuzF6O5kA/QwwDb0pnIavlwHUUdU
        pG3UxM2hej8IJ+lTSLLmhqbB30xUz/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689262430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnsbM2wbDJKZoJO63kCqa7skAvyrvbFpqW+OFngO6J0=;
        b=9pXKKiCXJGy/exWne0PvxfT2nb5/QqIeeq771ADv8xv5NQVJ9/i551YInR/xTA9frjX5m8
        AoqlkLi8oC3II5Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42C8613489;
        Thu, 13 Jul 2023 15:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e3taEF4ZsGTsGAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 13 Jul 2023 15:33:50 +0000
Date:   Thu, 13 Jul 2023 17:34:55 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
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
Message-ID: <ZLAZn_SBmoIFG5F5@yuki>
References: <202307132107.2ce4ea2f-oliver.sang@intel.com>
 <20230713150923.GA28246@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713150923.GA28246@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> I can't reproduce this on current mainline.  Is this a robust failure
> or flapping test?  Especiall as the FAIL conditions look rather
> unrelated.

Actually the test is spot on, the difference is that previously the
error was returned form the iomap_file_buffered_write() only if we
failed with the first buffer from the iov, now we always return the
error and we do not advance the offset.

The change that broke it:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77f4..550525a525c4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -864,16 +864,19 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
                .len            = iov_iter_count(i),
                .flags          = IOMAP_WRITE,
        };
-       int ret;
+       ssize_t ret;

        if (iocb->ki_flags & IOCB_NOWAIT)
                iter.flags |= IOMAP_NOWAIT;

        while ((ret = iomap_iter(&iter, ops)) > 0)
                iter.processed = iomap_write_iter(&iter, i);
-       if (iter.pos == iocb->ki_pos)
+
+       if (unlikely(ret < 0))
                return ret;
-       return iter.pos - iocb->ki_pos;
+       ret = iter.pos - iocb->ki_pos;
+       iocb->ki_pos += ret;
+       return ret;
 }

I suppose that we shoudl fix is with something as:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index adb92cdb24b0..bfb39f7bc303 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -872,11 +872,12 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
        while ((ret = iomap_iter(&iter, ops)) > 0)
                iter.processed = iomap_write_iter(&iter, i);

+       iocb->ki_pos += iter.pos - iocb->ki_pos;
+
        if (unlikely(ret < 0))
                return ret;
-       ret = iter.pos - iocb->ki_pos;
-       iocb->ki_pos += ret;
-       return ret;
+
+       return iter.pos - iocb->ki_pos;
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);


-- 
Cyril Hrubis
chrubis@suse.cz
