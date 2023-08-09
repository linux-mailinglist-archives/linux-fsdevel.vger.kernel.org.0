Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05A87764DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 18:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjHIQRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHIQRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:17:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E97E19E;
        Wed,  9 Aug 2023 09:17:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A3F316732D; Wed,  9 Aug 2023 18:17:45 +0200 (CEST)
Date:   Wed, 9 Aug 2023 18:17:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/13] xfs: close the RT and log block devices in
 xfs_free_buftarg
Message-ID: <20230809161745.GB2346@lst.de>
References: <20230808161600.1099516-1-hch@lst.de> <20230808161600.1099516-7-hch@lst.de> <20230809154532.GT11352@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809154532.GT11352@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 08:45:32AM -0700, Darrick J. Wong wrote:
> >  	blkdev_issue_flush(btp->bt_bdev);
> >  	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
> > +	/* the main block device is closed by kill_block_super */
> > +	if (bdev != btp->bt_mount->m_super->s_bdev)
> > +		blkdev_put(bdev, btp->bt_mount->m_super);
> 
> Hmm... I feel like this would be cleaner if the data dev buftarg could
> get its own refcount separate from super_block.s_bdev, but I looked
> through the code and couldn't identify a simple way to do that. Soo...

blkdev_put doesn't really drop a refcount, it closes the device.
It just happens to be misnamed, but Jan is looking into a series that
will as a side effect end up with a better name for this functionality.

