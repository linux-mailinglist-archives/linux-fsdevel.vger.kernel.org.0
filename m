Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0588262AF68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 00:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKOX05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 18:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiKOX03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:26:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4DF27908;
        Tue, 15 Nov 2022 15:26:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 778156179F;
        Tue, 15 Nov 2022 23:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F74C433C1;
        Tue, 15 Nov 2022 23:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668554787;
        bh=Enk5bunTj07I51D2X8M1XeCZB6Ho2p8Hm2FOFwdLteg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oArHTPfCV7nYcOXshByZFHpNiwEJ6lt/M1DZqqPz76NwaqJXLVPVKlkkbTnCa1J+z
         HqDisDQIapx9iIf67UaGfsrDXZsaqbadrwcftb6RixBDg8oBSO6gdmheAswqd1+G34
         2m3+UcDZlGr02FnSAs4FE0GBEp7lygcnPbutjGFMOe4oAMv7fjWWIY+o3I/NfiJLBI
         KlTnupyBBGOrAg0ezyX7kXRrhDeI2dt0viYcOSUn24eKpBtpkHwtbOW+EzZsFc4gLg
         D4JxRiuOAL0fRYhVkuFJ/on+eqdup4iJ0RVjrtvdGeP/LJjuW9kjjL5xy8EE6a+k4L
         lph6fQ8hFr/9Q==
Date:   Tue, 15 Nov 2022 15:26:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 8/9] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <Y3QgI9CM1oEKMEE/@magnolia>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-9-david@fromorbit.com>
 <Y3NSrSxq/nC4u8ws@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3NSrSxq/nC4u8ws@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:49:49AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 15, 2022 at 12:30:42PM +1100, Dave Chinner wrote:
> > +/*
> > + * Check that the iomap passed to us is still valid for the given offset and
> > + * length.
> > + */
> > +static bool
> > +xfs_iomap_valid(
> > +	struct inode		*inode,
> > +	const struct iomap	*iomap)
> > +{
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	u64			cookie = 0;
> > +
> > +	if (iomap->flags & IOMAP_F_XATTR) {
> > +		cookie = READ_ONCE(ip->i_af.if_seq);
> > +	} else {
> > +		if ((iomap->flags & IOMAP_F_SHARED) && ip->i_cowfp)
> > +			cookie = (u64)READ_ONCE(ip->i_cowfp->if_seq) << 32;
> > +		cookie |= READ_ONCE(ip->i_df.if_seq);
> > +	}
> > +	return cookie == iomap->validity_cookie;
> 
> How can this be called with IOMAP_F_XATTR set?

xfs_xattr_iomap_begin for FIEMAP, if I'm not mistaken.

> Also the code seems to duplicate xfs_iomap_inode_sequence, so
> we just call that:
> 
> 	return cookie == xfs_iomap_inode_sequence(XFS_I(inode), iomap->flags);

I was thinking that too.

--D
