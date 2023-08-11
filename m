Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81820778FC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 14:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjHKMo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 08:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKMo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB52726A0;
        Fri, 11 Aug 2023 05:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ABAB66F42;
        Fri, 11 Aug 2023 12:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F6CC433C8;
        Fri, 11 Aug 2023 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691757896;
        bh=kOskk37y8nZjyvPH/Qy4aWj3xKWEsFGaCCRYUsKR8BI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgpozOqGErBs+RHwvCOez2p6Wj0ytNS+EC+N+9BSLV60ICVcCocDxl0z+wJPAvD0X
         7XmgSNieHweTiVgqDM9iZbdpBMexB9nColFt3UOQJediExKvVTtFzpmI0RBAuHEo3z
         KJB5gOYHcUYuwQDeI9hBTOkee+ItGCYPBYO7XBAOScSLaRYwwWpGxbNChdAb7iwddY
         f9iRHRC02rm98JA4ckHaIdKgKspwFFd/2mKsLBUZcy2fTt1JB/ilRJQAiQFnmedc4V
         M/nsoNhkzuVCxhlK5fWhbPubKKc1KrMrnbF9rP7I5mgvUf+QrP8KklG6WMZdc9NdUd
         amqoqor2FXzGA==
Date:   Fri, 11 Aug 2023 14:44:50 +0200
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
Subject: Re: [PATCH 05/17] btrfs: open block devices after superblock creation
Message-ID: <20230811-wildpark-bronzen-5e30a56de1a1@brauner>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-6-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:16PM +0200, Christoph Hellwig wrote:
> Currently btrfs_mount_root opens the block devices before committing to
> allocating a super block. That creates problems for restricting the
> number of writers to a device, and also leads to a unusual and not very
> helpful holder (the fs_type).
> 
> Reorganize the code to first check whether the superblock for a
> particular fsid does already exist and open the block devices only if it
> doesn't, mirroring the recent changes to the VFS mount helpers.  To do
> this the increment of the in_use counter moves out of btrfs_open_devices
> and into the only caller in btrfs_mount_root so that it happens before
> dropping uuid_mutex around the call to sget.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

And ofc, would be great to get btrfs reviews.
