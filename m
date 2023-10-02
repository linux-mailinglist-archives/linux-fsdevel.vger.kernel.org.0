Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9007B4C62
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 09:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbjJBHMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjJBHMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:12:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3BCCD
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 00:12:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D1B9B68C7B; Mon,  2 Oct 2023 09:12:04 +0200 (CEST)
Date:   Mon, 2 Oct 2023 09:12:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] super: remove bd_fsfreeze_{mutex,sb}
Message-ID: <20231002071204.GF2068@lst.de>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org> <20230927-vfs-super-freeze-v1-5-ecc36d9ab4d9@kernel.org> <20230927151111.GE11414@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927151111.GE11414@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 08:11:11AM -0700, Darrick J. Wong wrote:
> > @@ -56,14 +56,11 @@ struct block_device {
> >  	void *			bd_holder;
> 
> Hmmm.  get_bdev_super from patch 3 now requires that bd_holder is a
> pointer to a struct super_block.  AFAICT it's only called in conjunction
> with fs_holder_ops, so I suggest that the declaration for that should
> grow a comment to that effect:
> 
> 	/*
> 	 * For filesystems, the @holder argument passed to blkdev_get_* and
> 	 * bd_prepare_to_claim must point to a super_block object.
> 	 */
> 	extern const struct blk_holder_ops fs_holder_ops;

Note that this is not strictly speaking true, it is only true for
file systems actually using fs_holder_ops, not file systems in general.
That being said a comment to that extent is indeed useful.

