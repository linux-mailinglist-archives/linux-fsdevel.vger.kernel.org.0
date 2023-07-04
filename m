Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757C37475A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGDPxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGDPxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD88B10C1;
        Tue,  4 Jul 2023 08:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C47612AB;
        Tue,  4 Jul 2023 15:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1ADC433C8;
        Tue,  4 Jul 2023 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688485993;
        bh=05GUbZGWViHpYScwdOptQrC014VGB+3GnS/6jW/OyEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrA9/AYPXy775wyCVoOF2paSCBV6eVrM5jC/UewQsF9MRYIRqsIg5x3ylldYWDpOe
         qBl750WWFfgpsMJDuxRd28CAzwRwF41EwDAProhnJ9Uw4z4U6DRIH5ZlBLGzFXJQP3
         pikiFhhsML5lc9oF8noxYl0oDBOEfX3nLWq9gmj53x9AddpK+/b9W2E680xqaVSwN1
         zYb6RVU6Mi60rw70qAHcPxKHetS4bd0Nb6dXoNgYgeXz14Xy0py+qzmm77xXNol1CR
         cixUwxUyyXzg3F9sZXr7zm4wWQZ1vty861cJgG8AJI3cE5JW5iFBPyKyGZHGJEH3CK
         9EsL8hr8RDBZg==
Date:   Tue, 4 Jul 2023 08:53:13 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 3/6] xfs: Block writes to log device
Message-ID: <20230704155313.GO11441@frogsfrogsfrogs>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704125702.23180-3-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:56:51PM +0200, Jan Kara wrote:
> Ask block layer to not allow other writers to open block device used
> for xfs log.

"...for the xfs log and realtime devices."

With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/xfs/xfs_super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index b0fbf8ea7846..3808b4507552 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -396,8 +396,9 @@ xfs_blkdev_get(
>  {
>  	int			error = 0;
>  
> -	*handlep = blkdev_get_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
> -				      mp, &xfs_holder_ops);
> +	*handlep = blkdev_get_by_path(name,
> +			BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_BLOCK_WRITES,
> +			mp, &xfs_holder_ops);
>  	if (IS_ERR(*handlep)) {
>  		error = PTR_ERR(*handlep);
>  		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
> -- 
> 2.35.3
> 
