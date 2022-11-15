Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E78629367
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiKOImW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKOImW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:42:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73956140A7;
        Tue, 15 Nov 2022 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P1xELF4xsapCUJIfwA5KRWCPKuR/FLELoB8phxNz8eM=; b=eeVwgwI7+cXAd0wwyFZWo/ZbUO
        7Z8s8cHLVS4SbkBOeUB0P3F4aRGV+jpOM9o2k9D7rrGHgR156yhqRazsomugA7YacZL0HfKl1vKfM
        f9HVEEqdeDwU1JvmVuFP0iR0zwDmTACHjSjY6fxZn2z6omzk0AhrfxwW45Lr3qv+bt7AvZLP6R0CB
        a+DuxZ9Y5duALMMcRC5jcbSHN/F0nthMeEecNbv2ErulfUhwc9XCLDLcDSnNBVRzEUWWHjVG8pH+j
        qrxK6Hg7zeqv23eQRLyyzgGHZxRFVce8Uo8Z2uYMGKrWGbdp1kQGV4UGEpB7162qPSqadlhZryh8s
        By/+bDWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourWP-008zrk-5c; Tue, 15 Nov 2022 08:42:21 +0000
Date:   Tue, 15 Nov 2022 00:42:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/9] xfs: use byte ranges for write cleanup ranges
Message-ID: <Y3NQ7VEnDLErzPzS@infradead.org>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115013043.360610-5-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:30:38PM +1100, Dave Chinner wrote:
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

What is the reason to not switch xfs_bmap_punch_delalloc_range to
just take the byte range as discussed last round?
