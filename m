Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94E629394
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiKOIt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiKOItx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:49:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA71820BDC;
        Tue, 15 Nov 2022 00:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4quw7IrL2ggicq6nUaiGX0HorT2jnQfuo1Q0QObcp9w=; b=cq1qxJs11zncnmQr9v2MlE2FwS
        liIPj8dsbQ0q41SDtO4Kk5HcjPvuEDkr41JNzT9apIW1SRVFnYfbwwjHYrJvu/XzsoSffy1K6I0ld
        aahQylZzKOKCzwT0V9gjtzBIQ4jBmdlYddTNgReYaHMvZmxShyxq44uoHZOtPv5OHqITNVx1qmhqL
        K789YCQ92yAkrpQpQHhX1yPca2qm6P3Xb6n/f5O61vMhPuHzc6FErIaS+p3x2vkmMZZk2698bUdAi
        fEbVhP7OX3E+UsTA9jI9ZeyEf+DJtC6NvSdFssj2re8ZvXJWPPpydTGLUjk3XO3CFkqAb2BL03cst
        McLZUchw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourdd-0092o2-A2; Tue, 15 Nov 2022 08:49:49 +0000
Date:   Tue, 15 Nov 2022 00:49:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 8/9] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <Y3NSrSxq/nC4u8ws@infradead.org>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-9-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115013043.360610-9-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:30:42PM +1100, Dave Chinner wrote:
> +/*
> + * Check that the iomap passed to us is still valid for the given offset and
> + * length.
> + */
> +static bool
> +xfs_iomap_valid(
> +	struct inode		*inode,
> +	const struct iomap	*iomap)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	u64			cookie = 0;
> +
> +	if (iomap->flags & IOMAP_F_XATTR) {
> +		cookie = READ_ONCE(ip->i_af.if_seq);
> +	} else {
> +		if ((iomap->flags & IOMAP_F_SHARED) && ip->i_cowfp)
> +			cookie = (u64)READ_ONCE(ip->i_cowfp->if_seq) << 32;
> +		cookie |= READ_ONCE(ip->i_df.if_seq);
> +	}
> +	return cookie == iomap->validity_cookie;

How can this be called with IOMAP_F_XATTR set?

Also the code seems to duplicate xfs_iomap_inode_sequence, so
we just call that:

	return cookie == xfs_iomap_inode_sequence(XFS_I(inode), iomap->flags);

