Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD178879F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244864AbjHYMi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244097AbjHYMic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:38:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EE0D3;
        Fri, 25 Aug 2023 05:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F8E56146E;
        Fri, 25 Aug 2023 12:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F439C433C7;
        Fri, 25 Aug 2023 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692967109;
        bh=/m/q93O+RZk94Txc55L/z2yUTL323juf3iKhEmAW51k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxXaARchmCL14k6to12P0jOrec4x95HcQojmyggsID9TCoConLMWMr8i0JUr6sIIp
         IZG9PqUimjuJRzQ9fduBAZgOkxXJ41E4MeGt4yYIhJ8GMIR2KB+x5/Hl5eVN73/Ngz
         3aeHMAoy4bBu87Zxlz3LAYreXwbE6qPZsMwRHIAVyYCCfezmhJuLUcb9APZN4+tM9i
         MinbFUcBlq1LjlfAHGh6Xo5EuRZkKA3bC8RrMSYbb5fQmif8CaBrp7Q6+5zuBsUVS8
         j9s1huncCuR7AxRasad/eXZYGhzArxdxEsVi+aUkjAWu0FIFfQ2maA8dQy1TXmSGb8
         Iz1xbYLAnJIQg==
Date:   Fri, 25 Aug 2023 14:38:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 28/29] xfs: Convert to bdev_open_by_path()
Message-ID: <20230825-seemeilen-planktont-16b588f7edff@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-28-jack@suse.cz>
 <ZOaEHrkx1xS9bgk9@dread.disaster.area>
 <20230824102837.credhh3fsco6vf7p@quack3>
 <20230824202910.wkzkvx6hbgdz6wuh@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824202910.wkzkvx6hbgdz6wuh@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 24, 2023 at 10:29:10PM +0200, Jan Kara wrote:
> On Thu 24-08-23 12:28:37, Jan Kara wrote:
> > On Thu 24-08-23 08:11:42, Dave Chinner wrote:
> > > On Wed, Aug 23, 2023 at 12:48:39PM +0200, Jan Kara wrote:
> > > > Convert xfs to use bdev_open_by_path() and pass the handle around.
> > > ....
> > > 
> > > > @@ -426,15 +427,15 @@ xfs_shutdown_devices(
> > > >  	 * race, everyone loses.
> > > >  	 */
> > > >  	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
> > > > -		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev);
> > > > -		invalidate_bdev(mp->m_logdev_targp->bt_bdev);
> > > > +		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev_handle->bdev);
> > > > +		invalidate_bdev(mp->m_logdev_targp->bt_bdev_handle->bdev);
> > > >  	}
> > > >  	if (mp->m_rtdev_targp) {
> > > > -		blkdev_issue_flush(mp->m_rtdev_targp->bt_bdev);
> > > > -		invalidate_bdev(mp->m_rtdev_targp->bt_bdev);
> > > > +		blkdev_issue_flush(mp->m_rtdev_targp->bt_bdev_handle->bdev);
> > > > +		invalidate_bdev(mp->m_rtdev_targp->bt_bdev_handle->bdev);
> > > >  	}
> > > > -	blkdev_issue_flush(mp->m_ddev_targp->bt_bdev);
> > > > -	invalidate_bdev(mp->m_ddev_targp->bt_bdev);
> > > > +	blkdev_issue_flush(mp->m_ddev_targp->bt_bdev_handle->bdev);
> > > > +	invalidate_bdev(mp->m_ddev_targp->bt_bdev_handle->bdev);
> > > >  }
> > > 
> > > Why do these need to be converted to run through bt_bdev_handle?  If
> > > the buftarg is present and we've assigned targp->bt_bdev_handle
> > > during the call to xfs_alloc_buftarg(), then we've assigned
> > > targp->bt_bdev from the handle at the same time, yes?
> > 
> > Good point, these conversions are pointless now so I've removed them. They
> > are leftover from a previous version based on a kernel where xfs was
> > dropping bdev references in a different place. Thanks for noticing.
> 
> FWIW attached is a new version of the patch I have currently in my tree.

The appended patch looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
