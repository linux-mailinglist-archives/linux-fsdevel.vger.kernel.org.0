Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD95D776C58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjHIWj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjHIWjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C55D2;
        Wed,  9 Aug 2023 15:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3080364B98;
        Wed,  9 Aug 2023 22:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7C7C433C7;
        Wed,  9 Aug 2023 22:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691620763;
        bh=CLgp0tXW3whDoLzghtguOCNYI43fpGW6om+fUAlt814=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wne7raqRTdWHu6mipSTlfZt/A5MQaxdCrkanOu7ANiFhyHyQkLuaGOLCKVoLY0Ns/
         vW7ZMOInmdN3+tgqvqPwGeXevfmE/aSOYNjH2bYVLFl1ryoYPPshT8AXUTx2sw5DDx
         P1TZOQPm/QoktPNMsc7G1in4S3wsN/b1NZ+UMOyWDXX5Ct0wkxALJfo1kJZXWItRu4
         FnUYb08nA42np4hxi9KaA9A6+vNL8Dcx9FbTt6E/Buk0jf4z4hzMcajKzid6MaTbaB
         QBwPYEd9Hbvbfwl3JUTs/cUGYes8/WoMmWE05RxKSJ/tT1EHcFAkKJ4de+Pt3WCBUR
         uxdkZwXvQ8Cdg==
Date:   Wed, 9 Aug 2023 15:39:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: document the invalidate_bdev call in
 invalidate_bdev
Message-ID: <20230809223923.GX11352@frogsfrogsfrogs>
References: <20230809220545.1308228-1-hch@lst.de>
 <20230809220545.1308228-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809220545.1308228-8-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:05:39PM -0700, Christoph Hellwig wrote:
> Copy and paste the commit message from Darrick into a comment to explain
> the seemly odd invalidate_bdev in xfs_shutdown_devices.

      ^ seemingly?
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_super.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 4ae3b01ed038c7..c169beb0d8cab3 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -399,6 +399,32 @@ STATIC void
>  xfs_shutdown_devices(
>  	struct xfs_mount	*mp)
>  {
> +	/*
> +	 * Udev is triggered whenever anyone closes a block device or unmounts
> +	 * a file systemm on a block device.
> +	 * The default udev rules invoke blkid to read the fs super and create
> +	 * symlinks to the bdev under /dev/disk.  For this, it uses buffered
> +	 * reads through the page cache.
> +	 *
> +	 * xfs_db also uses buffered reads to examine metadata.  There is no
> +	 * coordination between xfs_db and udev, which means that they can run
> +	 * concurrently.  Note there is no coordination between the kernel and
> +	 * blkid either.
> +	 *
> +	 * On a system with 64k pages, the page cache can cache the superblock
> +	 * and the root inode (and hence the root directory) with the same 64k
> +	 * page.  If udev spawns blkid after the mkfs and the system is busy
> +	 * enough that it is still running when xfs_db starts up, they'll both
> +	 * read from the same page in the pagecache.
> +	 *
> +	 * The unmount writes updated inode metadata to disk directly.  The XFS
> +	 * buffer cache does not use the bdev pagecache, nor does it invalidate
> +	 * the pagecache on umount.  If the above scenario occurs, the pagecache

This sentence reads a little strangely, since "nor does it invalidate"
would seem to conflict with the invalidate_bdev call below.  I suggest
changing the verb a bit:

"The XFS buffer cache does not use the bdev pagecache, so it needs to
invalidate that pagecache on unmount."

With those two things changed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +	 * no longer reflects what's on disk, xfs_db reads the stale metadata,
> +	 * and fails to find /a.  Most of the time this succeeds because closing
> +	 * a bdev invalidates the page cache, but when processes race, everyone
> +	 * loses.
> +	 */
>  	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
>  		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev);
>  		invalidate_bdev(mp->m_logdev_targp->bt_bdev);
> -- 
> 2.39.2
> 
