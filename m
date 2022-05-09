Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFB51FA25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 12:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiEIKpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiEIKpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 06:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192662108A5
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 03:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 127C560FC5
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 10:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3149AC385A8;
        Mon,  9 May 2022 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652092471;
        bh=bzuTesn3PmpGtqbVQab+tlY9w912860d8aPePlNeo+4=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=iBDiFFLmZVSuCtGmgl3KkUPzW6S6rl94oCWVd3t022ml7dTnlyNTLyvwlRM7JcLG7
         K26uWdZvmuj5sTXdKNcQ4Uf8Jl2qH6prNMCGvOf2V2rcJek/JNXfy6zuOYwwoZWgtD
         0SUmrCPjZkDF1T/QU208Qh9PszuHP0OJpvZ36VgkHxcjDYiDnl7hKXmdWGsVG0HUaA
         DvzFyQzhiOebPGYF0xI+AmwCqZvdrt2apttNxi7w0RTOnC27xn9ivxuAWy3wtbftSx
         OmNtn4yGTKELwDu5HuJQox5pMJSsGtvouZl2Tox7hHBaeSaiYAnAdKIhGgGEPmT6/r
         UwIFzmEVkXPKg==
Message-ID: <f353fa449afe158e7fac54b61021b0f2fcd57ef4.camel@kernel.org>
Subject: Re: [PATCH 00/26] Convert aops->releasepage to aops->release_folio
From:   Jeff Layton <jlayton@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 09 May 2022 06:34:29 -0400
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
         <20220508203247.668791-1-willy@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2022-05-08 at 21:32 +0100, Matthew Wilcox (Oracle) wrote:
> Convert all filesystems.  The last five patches are further cleanups
> that are enabled by this change.
> 
> Matthew Wilcox (Oracle) (26):
>   fs: Add aops->release_folio
>   iomap: Convert to release_folio
>   9p: Convert to release_folio
>   afs: Convert to release_folio
>   btrfs: Convert to release_folio
>   ceph: Convert to release_folio
>   cifs: Convert to release_folio
>   erofs: Convert to release_folio
>   ext4: Convert to release_folio
>   f2fs: Convert to release_folio
>   gfs2: Convert to release_folio
>   hfs: Convert to release_folio
>   hfsplus: Convert to release_folio
>   jfs: Convert to release_folio
>   nfs: Convert to release_folio
>   nilfs2: Remove comment about releasepage
>   ocfs2: Convert to release_folio
>   orangefs: Convert to release_folio
>   reiserfs: Convert to release_folio
>   ubifs: Convert to release_folio
>   fs: Remove last vestiges of releasepage
>   reiserfs: Convert release_buffer_page() to use a folio
>   jbd2: Convert jbd2_journal_try_to_free_buffers to take a folio
>   jbd2: Convert release_buffer_page() to use a folio
>   fs: Change try_to_free_buffers() to take a folio
>   fs: Convert drop_buffers() to use a folio
> 
>  .../filesystems/caching/netfs-api.rst         |  4 +-
>  Documentation/filesystems/locking.rst         | 14 ++---
>  Documentation/filesystems/vfs.rst             | 45 ++++++++--------
>  fs/9p/vfs_addr.c                              | 17 +++---
>  fs/afs/dir.c                                  |  7 ++-
>  fs/afs/file.c                                 | 11 ++--
>  fs/afs/internal.h                             |  2 +-
>  fs/btrfs/disk-io.c                            | 12 ++---
>  fs/btrfs/extent_io.c                          | 14 ++---
>  fs/btrfs/file.c                               |  2 +-
>  fs/btrfs/inode.c                              | 24 ++++-----
>  fs/buffer.c                                   | 54 +++++++++----------
>  fs/ceph/addr.c                                | 24 ++++-----
>  fs/cifs/file.c                                | 14 ++---
>  fs/erofs/super.c                              | 16 +++---
>  fs/ext4/inode.c                               | 20 +++----
>  fs/f2fs/checkpoint.c                          |  2 +-
>  fs/f2fs/compress.c                            |  2 +-
>  fs/f2fs/data.c                                | 32 +++++------
>  fs/f2fs/f2fs.h                                |  2 +-
>  fs/f2fs/node.c                                |  2 +-
>  fs/gfs2/aops.c                                | 44 +++++++--------
>  fs/gfs2/inode.h                               |  2 +-
>  fs/gfs2/meta_io.c                             |  4 +-
>  fs/hfs/inode.c                                | 23 ++++----
>  fs/hfsplus/inode.c                            | 23 ++++----
>  fs/iomap/buffered-io.c                        | 22 ++++----
>  fs/iomap/trace.h                              |  2 +-
>  fs/jbd2/commit.c                              | 14 ++---
>  fs/jbd2/transaction.c                         | 14 ++---
>  fs/jfs/jfs_metapage.c                         | 16 +++---
>  fs/mpage.c                                    |  2 +-
>  fs/nfs/file.c                                 | 22 ++++----
>  fs/nfs/fscache.h                              | 14 ++---
>  fs/nilfs2/inode.c                             |  1 -
>  fs/ocfs2/aops.c                               | 10 ++--
>  fs/orangefs/inode.c                           |  6 +--
>  fs/reiserfs/inode.c                           | 20 +++----
>  fs/reiserfs/journal.c                         | 14 ++---
>  fs/ubifs/file.c                               | 18 +++----
>  fs/xfs/xfs_aops.c                             |  2 +-
>  fs/zonefs/super.c                             |  2 +-
>  include/linux/buffer_head.h                   |  4 +-
>  include/linux/fs.h                            |  2 +-
>  include/linux/iomap.h                         |  2 +-
>  include/linux/jbd2.h                          |  2 +-
>  include/linux/page-flags.h                    |  2 +-
>  include/linux/pagemap.h                       |  4 --
>  mm/filemap.c                                  |  6 +--
>  mm/migrate.c                                  |  2 +-
>  mm/vmscan.c                                   |  2 +-
>  51 files changed, 309 insertions(+), 312 deletions(-)
> 

Looks like a mechanical change overall, and I like the conversion to
bool return instead of int. You can add this to the pile:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
