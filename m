Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833E778FB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjHKMky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 08:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKMkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0530C1;
        Fri, 11 Aug 2023 05:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC1264C7F;
        Fri, 11 Aug 2023 12:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7FAC433C7;
        Fri, 11 Aug 2023 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691757652;
        bh=zy6yguugoUgSRaMd817bUoOIpAK3qiNWAX7KHUkxXvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqRC84LHdMiJo/qRRpOJUQXlSLc4kg2hhZDz1RNK5m4WfAI65m5IbSBi4KIau7nSO
         99AgLCrH4Dna3zh1NWyzlg64B1OLVt6vajSXTShcNMx3qvc64Yv05aysP7VdSK4BuU
         YleiIUg9pc6M/CLTf4Eof/tJfwGKqDsze4ENjpVg6Kwb6F11Oxoi+DgmaEn961rqpx
         MJ16B7fDiGR1yVZbfRPL9iyknvANzAgZBEMmyd8BGBob7KD/hUkY2hwbOQf/fNWBEY
         fR/hUKEkQp2NUmzi+q99Zs0UOa2LehixxwKiwLp0pVqTK13tiE88ngfv74bHQlQdcT
         QTYlxaNLA4/3g==
Date:   Fri, 11 Aug 2023 14:40:45 +0200
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
Subject: Re: [PATCH 04/17] btrfs: split btrfs_fs_devices.opened
Message-ID: <20230811-wildtier-fortbestand-f6ec45e09f4e@brauner>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-5-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:15PM +0200, Christoph Hellwig wrote:
> The btrfs_fs_devices.opened member mixes an in use counter for the
> fs_devices structure that prevents it from being garbage collected with
> a flag if the underlying devices were actually opened.  This not only
> makes the code hard to follow, but also prevents btrfs from switching
> to opening the block device only after super block creation.  Split it
> into an in_use counter and an is_open boolean flag instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

That looks like it will fix the issue we've seen with the first version.
So Acked-by: Christian Brauner <brauner@kernel.org>
but it'd be excellent to hear from btrfs maintainers.
