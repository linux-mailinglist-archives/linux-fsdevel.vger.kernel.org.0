Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61C06169DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKBQ6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKBQ6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECD6CE16;
        Wed,  2 Nov 2022 09:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82FB361AB2;
        Wed,  2 Nov 2022 16:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAABC433D6;
        Wed,  2 Nov 2022 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667408314;
        bh=e3EOFuvGLdIK1C3uY89W1+naYJXk+HSL64/GuIUs8fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VytdZ5zdipuiKhhmqpo0SIOunISustwjhE40DN/AH8rG2YYaq6eBeQYhd3GtiQsYk
         4SINMdIFbQ4a0FG8XKGtwMrUvUwdOV7Qt2RmZxhELDmPk2lXFh/yuQ5TaKvNfP9yn9
         avZj2zJ6BiaSL5iGZV8JK/eFAN8/M+PJTOsjU0NBUGshreByK+AJVNxjgsp1USzE3Z
         ucOeozKu/v1u+veyWHlJkbV4Fn86kgW84lnxXlTK3K6Y69GabRISdjTOIFF/qDDorU
         A0JQyku0YWlnudqNGtxi/0S+OOWu8ERuHu+EvDmJ1MGucVvkaQcbX6CDrY9Ypc/5IV
         e/8d6xIX2aFuA==
Date:   Wed, 2 Nov 2022 09:58:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] iomap: write iomap validity checks
Message-ID: <Y2KhurifaYbxkyNX@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-6-david@fromorbit.com>
 <Y2IsGbU6bbbAvksP@infradead.org>
 <Y2KeSU6w1kMi6Aer@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2KeSU6w1kMi6Aer@magnolia>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:43:53AM -0700, Darrick J. Wong wrote:
> On Wed, Nov 02, 2022 at 01:36:41AM -0700, Christoph Hellwig wrote:
> > On Tue, Nov 01, 2022 at 11:34:10AM +1100, Dave Chinner wrote:
> > > +	/*
> > > +	 * Now we have a locked folio, before we do anything with it we need to
> > > +	 * check that the iomap we have cached is not stale. The inode extent
> > > +	 * mapping can change due to concurrent IO in flight (e.g.
> > > +	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
> > > +	 * reclaimed a previously partially written page at this index after IO
> > > +	 * completion before this write reaches this file offset) and hence we
> > > +	 * could do the wrong thing here (zero a page range incorrectly or fail
> > > +	 * to zero) and corrupt data.
> > > +	 */
> > > +	if (ops->iomap_valid) {
> > > +		bool iomap_valid = ops->iomap_valid(iter->inode, &iter->iomap);
> > > +
> > > +		if (!iomap_valid) {
> > > +			iter->iomap.flags |= IOMAP_F_STALE;
> > > +			status = 0;
> > > +			goto out_unlock;
> > > +		}
> > > +	}
> > 
> > So the design so far has been that everything that applies at a page (or
> > now folio) level goes into iomap_page_ops, not iomap_ops which is just
> > the generic iteration, and I think we should probably do it that way.
> 
> I disagree here -- IMHO the sequence number is an attribute of the
> iomapping, not the folio.

OFC now that I've reread iomap.h I realize that iomap_page_ops are
passed back via struct iomap, so I withdraw this comment.

--D

> > I'm a little disappointed that we need two callout almost next to each
> > other, but given that we need to validate with the folio locked, and
> > gfs2 wants the callback with the folio unlocked I think we have to do
> > it that.
> 
> <nod>
> 
> --D
