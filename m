Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14AF7AD24C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjIYHsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjIYHst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:48:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8CAD3;
        Mon, 25 Sep 2023 00:48:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F173068D05; Mon, 25 Sep 2023 09:48:38 +0200 (CEST)
Date:   Mon, 25 Sep 2023 09:48:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
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
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 07/17] nbd: call blk_mark_disk_dead in
 nbd_clear_sock_ioctl
Message-ID: <20230925074838.GA28522@lst.de>
References: <20230811100828.1897174-1-hch@lst.de> <20230811100828.1897174-8-hch@lst.de> <79af9398-167f-440e-a493-390dc4ccbd85@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79af9398-167f-440e-a493-390dc4ccbd85@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 03:41:11PM -0500, Samuel Holland wrote:
> [   14.619101] Buffer I/O error on dev nbd0, logical block 0, async page read
> 
> [   14.630490]  nbd0: unable to read partition table
> 
> I wonder if disk_force_media_change() is the right thing to call here instead.

So what are the semantics of clearing the socket?

The <= 6.5 behavior of invalidating fs caches, but not actually marking
the fs shutdown is pretty broken, especially if this expects to resurrect
the device and thus the file system later on.
