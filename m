Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C05B615CE1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 08:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKBHUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 03:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKBHUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:20:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3112D3F;
        Wed,  2 Nov 2022 00:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O55uX9Nx5xWkP6n2z2VqB0x4a81iJB+5TNTmOj73MaA=; b=wDvqJiu0gyZICzuZxCgyidWmRm
        xayYve3IBt7MX9Wy3Ho9Y55kiCl134YpuLV+tgCP4XUaL6JtwVOjj9U1dKDNwwRIX1XmEsjMvlMRG
        r/R/N4iXlWd2vDsg1O2xuvFlJQyUP5dFVodqnKVli33uWu0XI8seO3BPIHD5x+9dreP6j6Hu45JDv
        Isu3HxQ59sw6CvIEqSzwCTdU7dpFGLo2MWFEuIax2DthgM4uBIMd+yB4b126TAhtQxLxkYpvPODvy
        /kV0ygD2r1qo9QpJMBZ+cSaixk2xVg0OXq6LaQiwOZU+k2/tIAEAKt3fGel3cU+cXb9G5AVNPZReD
        s8O44WAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq836-008bwX-CT; Wed, 02 Nov 2022 07:20:32 +0000
Date:   Wed, 2 Nov 2022 00:20:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] xfs: use byte ranges for write cleanup ranges
Message-ID: <Y2IaQOFg7rkegNLk@infradead.org>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101003412.3842572-4-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static int
> +xfs_buffered_write_delalloc_punch(
> +	struct inode		*inode,
> +	loff_t			start_byte,
> +	loff_t			end_byte)
> +{
> +	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
> +	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
> +
> +	return xfs_bmap_punch_delalloc_range(XFS_I(inode), start_fsb,
> +				end_fsb - start_fsb);
> +}

The othe two callers of xfs_bmap_punch_delalloc_range would actually
prefer a byte range as well, so it might make sense to just switch
it to taking bytes instad of adding a wrapper.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
