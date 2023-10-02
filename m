Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD737B4B67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 08:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjJBGWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 02:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjJBGWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:22:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF639B;
        Sun,  1 Oct 2023 23:22:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 91BE168D07; Mon,  2 Oct 2023 08:21:59 +0200 (CEST)
Date:   Mon, 2 Oct 2023 08:21:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wouter Verhelst <w@uter.be>
Cc:     Christoph Hellwig <hch@lst.de>,
        Samuel Holland <samuel.holland@sifive.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20231002062159.GB1140@lst.de>
References: <20230811100828.1897174-1-hch@lst.de> <20230811100828.1897174-8-hch@lst.de> <79af9398-167f-440e-a493-390dc4ccbd85@sifive.com> <20230925074838.GA28522@lst.de> <ZRmoHaSojk6ra5OU@pc220518.home.grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRmoHaSojk6ra5OU@pc220518.home.grep.be>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 01, 2023 at 07:10:53PM +0200, Wouter Verhelst wrote:
> > So what are the semantics of clearing the socket?
> > 
> > The <= 6.5 behavior of invalidating fs caches, but not actually marking
> > the fs shutdown is pretty broken, especially if this expects to resurrect
> > the device and thus the file system later on.
> 
> nbd-client -d calls
> 
> ioctl(nbd, NBD_DISCONNECT);
> ioctl(nbd, NBD_CLEAR_SOCK);
> 
> (error handling removed for clarity)
> 
> where "nbd" is the file handle to the nbd device. This expects that the
> device is cleared and that then the device can be reused for a different
> connection, much like "losetup -d". Expecting that the next connection
> would talk to the same file system is wrong.

So a fs shutdown seems like a the right thing.  So I'm a little confused
on what actualy broke here.
