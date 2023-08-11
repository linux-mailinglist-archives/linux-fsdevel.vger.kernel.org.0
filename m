Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E8A778EA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 14:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjHKMDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 08:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHKMDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A36122;
        Fri, 11 Aug 2023 05:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFCB767129;
        Fri, 11 Aug 2023 12:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93494C433C8;
        Fri, 11 Aug 2023 12:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691755421;
        bh=lM5wpFoUmoxeDu6pSUFHwH1iHV1lNKjVf68vocn24vA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOdfkaMh8w4TUFBJ/9QxFqbDbEBhGBgP7iGa/N4E2fwrnTlVejC3QBLW1BX0q/AHo
         m7eDytL/hWZQMrfuv6gopu+NapwTc7wwOrBmux1G39wYcd24rVJOG2VnNlgck9aQO3
         bT+xZELZUX8IVb5SgOtYg+ZZpO4VwGhRBYsqgHC5vsTf2cge5+ioWqskLkTZfL4Pvy
         YxVWeWxperp/gZ0ihcOQsTBxp3xcxpIA//XO7vPLbT3wP0hHTRyyMrgdQvq/rr0BMa
         2lXZ1jiTmXXjLfztJhh4bxlJUeQIccBpDUSPvO/OxHpys6QVkkvo3+Hh26raaIAMIm
         vKXMJcSabiwBQ==
Date:   Fri, 11 Aug 2023 14:03:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/17] btrfs: call btrfs_close_devices from ->kill_sb
Message-ID: <20230811-randlage-kreis-288a41a139fb@brauner>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-4-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:14PM +0200, Christoph Hellwig wrote:
> blkdev_put must not be called under sb->s_umount to avoid a lock order
> reversal with disk->open_mutex once call backs from block devices to
> the file system using the holder ops are supported.  Move the call
> to btrfs_close_devices into btrfs_free_fs_info so that it is closed
> from ->kill_sb (which is also called from the mount failure handling
> path unlike ->put_super) as well as when an fs_info is freed because
> an existing superblock already exists.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
