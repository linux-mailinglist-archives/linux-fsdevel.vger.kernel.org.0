Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39707B0719
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjI0Oi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjI0Oi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:38:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B90139
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 07:38:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD316C433C8;
        Wed, 27 Sep 2023 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695825506;
        bh=dP/cswB02t1c1ysntuHR7DQyjoL7Bo1IbU3sAncHAW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGAzW5EQaF7v7/jm1ooM82sjOytsvjLOtgwyUGvq/cjoztCqG5KQYZv0XJED/gM7P
         0Rio1lEDACq72zQaBizTCkoxFUkx7r4LlSk0Ciobk8VyxqVcXLsyQZcqWU54CieJWu
         nkabXPRhD26zBauSmTT07HDt3QfuM6DmvG3pnXXdTlPALlZPvMDXZ/B3kFcC9/EFTO
         GU+4UWRKED3Nw96g92xn+E+nF9NaRimzCKEAKvXroD8c6aKEV5PQQPjpMjtUYMgeOc
         Yozy1ndv2t8hnvIEu35yDRQrPxCJ2RVlKQjkQagaPBmkDm8dW0tkqYFB9Dxcc/MuAc
         cSsJsbrFPY2OA==
Date:   Wed, 27 Sep 2023 07:38:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/7] bdev: add freeze and thaw holder operations
Message-ID: <20230927143826.GB11414@frogsfrogsfrogs>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-2-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-2-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:21:15PM +0200, Christian Brauner wrote:
> Add block device freeze and thaw holder operations. Follow-up patches
> will implement block device freeze and thaw based on stuct

s/stuct/struct/

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> blk_holder_ops.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/blkdev.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bf25b63e13d5..f2ddccaaef4d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1468,6 +1468,16 @@ struct blk_holder_ops {
>  	 * Sync the file system mounted on the block device.
>  	 */
>  	void (*sync)(struct block_device *bdev);
> +
> +	/*
> +	 * Freeze the file system mounted on the block device.
> +	 */
> +	int (*freeze)(struct block_device *bdev);
> +
> +	/*
> +	 * Thaw the file system mounted on the block device.
> +	 */
> +	int (*thaw)(struct block_device *bdev);
>  };
>  
>  extern const struct blk_holder_ops fs_holder_ops;
> 
> -- 
> 2.34.1
> 
