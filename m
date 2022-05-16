Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7705284BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbiEPMye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243671AbiEPMyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 08:54:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AF5393F0;
        Mon, 16 May 2022 05:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 97CA4CE1308;
        Mon, 16 May 2022 12:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72703C385AA;
        Mon, 16 May 2022 12:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652705621;
        bh=FeFCtcoIMmiZDS7K86j8dEgmeuPJ8nXufxixTXfHCko=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KOLYsx35/5Gy1jpzsbH6cQbYN6j+Pi1xMhpDNBbD0kHeRY0LG73xnv5dbusD3xyyW
         bTLztq78rZ64dMOBIhdgtsdTKKTcd03kqZaCdeHqmLY9Gnn91DZh7E0AfbWlL6+l2C
         LdfB3GxksNKJXRXxo9O9kryCcZKyqqz4cy/0PN5R0JROaaTDCp+tX4oG+F2mU/65DV
         WeC4c976LAliqcj3+eRJTIJrAbtHd1ez7EiG2TIrCsgkEfvbOUjRZONhZ4jXnpaQVG
         Cu0BiGtRRluR6wJMCUHhE+OiMtv1vUg2tHN3LMQn4jagXv+Cq98oLzCXoKHlTHPyMB
         B1qBTtYXb5zZA==
Message-ID: <eb3905425dfd44db3e035831c8cfd44305d3de65.camel@kernel.org>
Subject: Re: [PATCH] iomap: don't invalidate folios after writeback errors
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Date:   Mon, 16 May 2022 08:53:39 -0400
In-Reply-To: <YoHG5cMwvx8PSddI@magnolia>
References: <YoHG5cMwvx8PSddI@magnolia>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2022-05-15 at 20:37 -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>=20
> XFS has the unique behavior (as compared to the other Linux filesystems)
> that on writeback errors it will completely invalidate the affected
> folio and force the page cache to reread the contents from disk.  All
> other filesystems leave the page mapped and up to date.
>=20
> This is a rude awakening for user programs, since (in the case where
> write fails but reread doesn't) file contents will appear to revert to
> old disk contents with no notification other than an EIO on fsync.  This
> might have been annoying back in the days when iomap dealt with one page
> at a time, but with multipage folios, we can now throw away *megabytes*
> worth of data for a single write error.
>=20
> On *most* Linux filesystems, a program can respond to an EIO on write by
> redirtying the entire file and scheduling it for writeback.  This isn't
> foolproof, since the page that failed writeback is no longer dirty and
> could be evicted, but programs that want to recover properly *also*
> have to detect XFS and regenerate every write they've made to the file.
>=20
> When running xfs/314 on arm64, I noticed a UAF bug when xfs_discard_folio
> invalidates multipage folios that could be undergoing writeback.  If,
> say, we have a 256K folio caching a mix of written and unwritten
> extents, it's possible that we could start writeback of the first (say)
> 64K of the folio and then hit a writeback error on the next 64K.  We
> then free the iop attached to the folio, which is really bad because
> writeback completion on the first 64k will trip over the "blocks per
> folio > 1 && !iop" assertion.
>=20
> This can't be fixed by only invalidating the folio if writeback fails at
> the start of the folio, since the folio is marked !uptodate, which trips
> other assertions elsewhere.  Get rid of the whole behavior entirely.
>=20
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/buffered-io.c |    1 -
>  fs/xfs/xfs_aops.c      |    4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8fb9b2797fc5..94b53cbdefad 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1387,7 +1387,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc=
,
>  		if (wpc->ops->discard_folio)
>  			wpc->ops->discard_folio(folio, pos);
>  		if (!count) {
> -			folio_clear_uptodate(folio);
>  			folio_unlock(folio);
>  			goto done;
>  		}
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 90b7f4d127de..f6216d0fb0c2 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -464,7 +464,7 @@ xfs_discard_folio(
>  	int			error;
> =20
>  	if (xfs_is_shutdown(mp))
> -		goto out_invalidate;
> +		return;
> =20
>  	xfs_alert_ratelimited(mp,
>  		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
> @@ -474,8 +474,6 @@ xfs_discard_folio(
>  			i_blocks_per_folio(inode, folio) - pageoff_fsb);
>  	if (error && !xfs_is_shutdown(mp))
>  		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
> -out_invalidate:
> -	iomap_invalidate_folio(folio, offset, folio_size(folio) - offset);
>  }
> =20
>  static const struct iomap_writeback_ops xfs_writeback_ops =3D {

Nice to start bringing some consistency to this behavior across the
kernel!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
