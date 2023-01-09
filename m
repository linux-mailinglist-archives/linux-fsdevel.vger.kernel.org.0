Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BA662A22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbjAIPeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjAIPcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:32:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED05614F;
        Mon,  9 Jan 2023 07:32:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B58761181;
        Mon,  9 Jan 2023 15:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D13C433EF;
        Mon,  9 Jan 2023 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673278320;
        bh=wyx956OzqLIeQmTguifCY6ZQa55tJ2T+BHNa66v0lTo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kVxekE8HdoHM3Vvt/+wjCSSi/dCg4ktXN9VaO+zUHY3UHbjUL8qqbxWz/GZqFAux4
         aLVBQopjXGS2p9yngGl9jcjiwkwcmpiGbD0IdmnVsxhGiMWrxD164Y0GokiABk/ct1
         lk8sZCl2KwTKINGxGTBadhj6CiRrQwOpYlD5aHwVIpyDA2TG1XqrQ7I9IgdpT+quID
         o67zLZCtWK5udyM6k0U8sot089oDMQ9h1i8G4MuQbG95fZ73yC+SExzg0mBi29lP2+
         iyZZv+HaY9OThJvU6e0Mql0AQ5qJdSM0nDKHXHVXCXHI32oBwRy9y7mr/RaNIxMz0o
         8wqwtkA76YFBw==
Message-ID: <f3169d8271751094ed9e7e3393b0433d3ef80e83.camel@kernel.org>
Subject: Re: [PATCH 00/11] Remove AS_EIO and AS_ENOSPC
From:   Jeff Layton <jlayton@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date:   Mon, 09 Jan 2023 10:31:58 -0500
In-Reply-To: <20230109051823.480289-1-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> Finish the work of converting every user to the "new" wb_err
> infrastructure.  This will clash with Christoph's patch series to remove
> folio_write_one(), so I'll redo this after that patch series goes in.
>=20
> Matthew Wilcox (Oracle) (11):
>   memory-failure: Remove comment referencing AS_EIO
>   filemap: Remove filemap_check_and_keep_errors()
>   f2fs: Convert f2fs_wait_on_node_pages_writeback() to errseq
>   fuse: Convert fuse_flush() to use file_check_and_advance_wb_err()
>   page-writeback: Convert folio_write_one() to use an errseq
>   filemap: Convert filemap_write_and_wait_range() to use errseq
>   filemap: Convert filemap_fdatawait_range() to errseq
>   cifs: Remove call to filemap_check_wb_err()
>   mm: Remove AS_EIO and AS_ENOSPC
>   mm: Remove filemap_fdatawait_range_keep_errors()

>   mm: Remove filemap_fdatawait_keep_errors()
>=20
>  block/bdev.c            |   8 +--
>  fs/btrfs/extent_io.c    |   6 +--
>  fs/cifs/file.c          |   8 ++-
>  fs/f2fs/data.c          |   2 +-
>  fs/f2fs/node.c          |   4 +-
>  fs/fs-writeback.c       |   7 +--
>  fs/fuse/file.c          |   3 +-
>  fs/jbd2/commit.c        |  12 ++---
>  fs/xfs/scrub/bmap.c     |   2 +-
>  include/linux/pagemap.h |  23 ++------
>  mm/filemap.c            | 113 +++++++---------------------------------
>  mm/memory-failure.c     |  28 ----------
>  mm/page-writeback.c     |  17 +++---
>  13 files changed, 51 insertions(+), 182 deletions(-)
>=20

Now that I got my understanding straight about unseen errors, I think
this looks good. I think it'd be best to avoid advancing f_wb_err in
->flush operations but the rest of this looks fine.

You can add this to all but #4 (and that one should be easily fixable).

Reviewed-by: Jeff Layton <jlayton@kernel.org>
