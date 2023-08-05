Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618CD770EC2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 10:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjHEIcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHEIco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:32:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64F53A9B;
        Sat,  5 Aug 2023 01:32:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A2E2A68AA6; Sat,  5 Aug 2023 10:32:39 +0200 (CEST)
Date:   Sat, 5 Aug 2023 10:32:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 11/12] xfs: drop s_umount over opening the log and RT
 devices
Message-ID: <20230805083239.GA29780@lst.de>
References: <20230802154131.2221419-1-hch@lst.de> <20230802154131.2221419-12-hch@lst.de> <20230802163219.GW11352@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802163219.GW11352@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 09:32:19AM -0700, Darrick J. Wong wrote:
> > +	/* see get_tree_bdev why this is needed and safe */
> 
> Which part of get_tree_bdev?  Is it this?
> 
> 		/*
> 		 * s_umount nests inside open_mutex during
> 		 * __invalidate_device().  blkdev_put() acquires
> 		 * open_mutex and can't be called under s_umount.  Drop
> 		 * s_umount temporarily.  This is safe as we're
> 		 * holding an active reference.
> 		 */
> 		up_write(&s->s_umount);
> 		blkdev_put(bdev, fc->fs_type);
> 		down_write(&s->s_umount);

Yes.  With the refactoring earlier in the series get_tree_bdev should
be trivial enough to not need a more specific reference.  If you
think there's a better way to refer to it I can update the comment,
though.

> >  		mp->m_logdev_targp = mp->m_ddev_targp;
> >  	}
> >  
> > -	return 0;
> > +	error = 0;
> > +out_unlock:
> > +	down_write(&sb->s_umount);
> 
> Isn't down_write taking s_umount?  I think the label should be
> out_relock or something less misleading.

Agreed.  Christian, can you just change this in your branch, or should
I send an incremental patch?

