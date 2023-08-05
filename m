Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C077107D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjHEQTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 12:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHEQTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:19:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1A910F8;
        Sat,  5 Aug 2023 09:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E366960C08;
        Sat,  5 Aug 2023 16:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F45DC433C8;
        Sat,  5 Aug 2023 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691252345;
        bh=eczxg65nAKdspBAZJjvsqnJ9aD9e1Cnh1ASqk/5x4Tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0h/IrNV9FDvUWv2eNzdGVI/pdKwMLXK4ephLjq8qasptg9QR42I18oxpmAO8umTF
         +jPDQ/hHlUXz8vlybFxoV5RemFk0DVSLbmOMRAK0CJqcO8LUXtppZEHOBIInbCw1Bp
         JTrajwX0bDnORyljOsGHdnXOxmx4UhQ4gFvfINhcXD8pnn5ERuxQv6rcgrEHwNJK1I
         cw8urElSBCWxmfql/5enH6QJ/LQEtkXgzdIYOACoSdLpWEdSHCXQJS6+TIJwCyfYu7
         hRiEBFxuNr7P2y5wMX51/z0/iaXoTcxnlDluglqILaNhlVU/0TaObzI32WdPQIaxv2
         RPO/N8LaaV66Q==
Date:   Sat, 5 Aug 2023 09:19:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20230805161904.GM11377@frogsfrogsfrogs>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-12-hch@lst.de>
 <20230802163219.GW11352@frogsfrogsfrogs>
 <20230805083239.GA29780@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805083239.GA29780@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 05, 2023 at 10:32:39AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 02, 2023 at 09:32:19AM -0700, Darrick J. Wong wrote:
> > > +	/* see get_tree_bdev why this is needed and safe */
> > 
> > Which part of get_tree_bdev?  Is it this?
> > 
> > 		/*
> > 		 * s_umount nests inside open_mutex during
> > 		 * __invalidate_device().  blkdev_put() acquires
> > 		 * open_mutex and can't be called under s_umount.  Drop
> > 		 * s_umount temporarily.  This is safe as we're
> > 		 * holding an active reference.
> > 		 */
> > 		up_write(&s->s_umount);
> > 		blkdev_put(bdev, fc->fs_type);
> > 		down_write(&s->s_umount);
> 
> Yes.  With the refactoring earlier in the series get_tree_bdev should
> be trivial enough to not need a more specific reference.  If you
> think there's a better way to refer to it I can update the comment,
> though.

How about:

	/*
	 * blkdev_put can't be called under s_umount, see the comment in
	 * get_tree_bdev for more details
	 */

with that and the label name change,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> > >  		mp->m_logdev_targp = mp->m_ddev_targp;
> > >  	}
> > >  
> > > -	return 0;
> > > +	error = 0;
> > > +out_unlock:
> > > +	down_write(&sb->s_umount);
> > 
> > Isn't down_write taking s_umount?  I think the label should be
> > out_relock or something less misleading.
> 
> Agreed.  Christian, can you just change this in your branch, or should
> I send an incremental patch?
> 
