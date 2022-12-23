Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F766551EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 16:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiLWPKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 10:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiLWPKj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:10:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3478826ADF;
        Fri, 23 Dec 2022 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2bi42ObmzJhIVRGH9DaM47E730Lbb8ApGNNgjPXCVUQ=; b=brAgZQKgy5qoSpkVGCvPi67iOZ
        UCsPe+FtDBr/XQU2ezYTH683mETwF8yEEGux2C8f1jTbdW9JLvIfTe8QdXcvyiaL7aQd4Z7ImtZVX
        G4m4iPP3bCAlUVW1XhIy8Wq1s6eKdLiOBB/oXOHYE648aPig1BkqJKxEtpG4gZz1G18bRZ+Q39B/x
        7wze59tMR/upOtUZjGLkIEri4YdbcDe4TEzRIwy4CeMmyW2XT2CvTEaSgxEpv3YedkQWPeMFiBzxA
        PAwfaeeM11Vq00a3r/PBz9rTZEWxraVnxb/Duhy6dacos5vN3z6q1lA8ZhBlGkl3xCQxpB3/OD6ka
        Ythqya2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8jgw-009FFs-Ll; Fri, 23 Dec 2022 15:10:34 +0000
Date:   Fri, 23 Dec 2022 07:10:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v3 6/7] iomap/xfs: Eliminate the iomap_valid handler
Message-ID: <Y6XE6jLIax/+xcjF@infradead.org>
References: <20221216150626.670312-1-agruenba@redhat.com>
 <20221216150626.670312-7-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216150626.670312-7-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:06:25PM +0100, Andreas Gruenbacher wrote:
> Eliminate the ->iomap_valid() handler by switching to a ->page_prepare()
> handler and validating the mapping there.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 24 ++++--------------------
>  fs/xfs/xfs_iomap.c     | 38 +++++++++++++++++++++++++++-----------
>  include/linux/iomap.h  | 17 -----------------
>  3 files changed, 31 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6b7c1a10b8ec..b73ff317da21 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -623,7 +623,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct folio *folio;
> -	int status = 0;
> +	int status;
>  
>  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
>  	if (srcmap != &iter->iomap)
> @@ -642,27 +642,11 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	if (IS_ERR_OR_NULL(folio)) {
>  		if (!folio)
>  			return (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
> +		if (folio == ERR_PTR(-ESTALE)) {
>  			iter->iomap.flags |= IOMAP_F_STALE;
> +			return 0;
>  		}
> +		return PTR_ERR(folio);
>  	}
>  
>  	if (pos + len > folio_pos(folio) + folio_size(folio))
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 669c1bc5c3a7..2248ce7be2e3 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -62,29 +62,45 @@ xfs_iomap_inode_sequence(
>  	return cookie | READ_ONCE(ip->i_df.if_seq);
>  }
>  
> -/*
> - * Check that the iomap passed to us is still valid for the given offset and
> - * length.
> - */
> -static bool
> -xfs_iomap_valid(
> -	struct inode		*inode,
> -	const struct iomap	*iomap)
> +static struct folio *
> +xfs_page_prepare(
> +	struct iomap_iter	*iter,
> +	loff_t			pos,
> +	unsigned		len)
>  {
> +	struct inode		*inode = iter->inode;
> +	struct iomap		*iomap = &iter->iomap;
>  	struct xfs_inode	*ip = XFS_I(inode);
> +	struct folio *folio;

Please tab align this like the other variable declarations above.

> -	/*
> -	 * Check that the cached iomap still maps correctly to the filesystem's
> -	 * internal extent map. FS internal extent maps can change while iomap
> -	 * is iterating a cached iomap, so this hook allows iomap to detect that
> -	 * the iomap needs to be refreshed during a long running write
> -	 * operation.
> -	 *
> -	 * The filesystem can store internal state (e.g. a sequence number) in
> -	 * iomap->validity_cookie when the iomap is first mapped to be able to
> -	 * detect changes between mapping time and whenever .iomap_valid() is
> -	 * called.
> -	 *
> -	 * This is called with the folio over the specified file position held
> -	 * locked by the iomap code.
> -	 */

We'll still need to capture this information somewhere.  I'd suggest
to move it to the prepare/get method and reword it so that this is
mentioned as an additional use case / requirement.
