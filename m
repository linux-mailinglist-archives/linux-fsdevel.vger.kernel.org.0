Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7457B48F7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Oct 2023 19:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjJARvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 13:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJARvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 13:51:09 -0400
X-Greylist: delayed 2374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 01 Oct 2023 10:51:04 PDT
Received: from lounge.grep.be (lounge.grep.be [IPv6:2a01:4f8:200:91e8::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04007DA;
        Sun,  1 Oct 2023 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
        s=2021.lounge; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=N1C8OuXGq/Bdvr1xe7dP3su2WBfI6fQiXd6UfybheFE=; b=bSGFLGPJKNt5kRJKMGm/90sESH
        DMZEixE+Cund10XKRDJ8kZjhG9SJfku+c0pPyP9a8SvRp7s5laXYIIUs6vCP8ISDb1JRTK7eQZi+u
        FZhyyCStjYgdW0gxgPf6oVGPJvQQf0xT6sbQj5penqJAgXw88iemrZeqxH0gAlZxTeQ1hvc+G2B7V
        G2oVofVAaOjElA/771b9qCecBsQNOJjvOodJTs0Q70kSXGyNB302BVVbkm3YdmrDyjxREX2yXzIMn
        AdRb/K4OjWQELyk7/5Zxmq6ELmicipBUYTkFa3pm26ozLNrh3dB6JVomx3OFbJGbbL7l2tqcVCF30
        WQnnmWxQ==;
Received: from [102.39.158.142] (helo=pc220518)
        by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <w@uter.be>)
        id 1qmzyK-008WyJ-2V;
        Sun, 01 Oct 2023 19:11:12 +0200
Received: from wouter by pc220518 with local (Exim 4.97-RC0)
        (envelope-from <w@uter.be>)
        id 1qmzy1-00000001YPq-0d7j;
        Sun, 01 Oct 2023 19:10:53 +0200
Date:   Sun, 1 Oct 2023 19:10:53 +0200
From:   Wouter Verhelst <w@uter.be>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
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
Message-ID: <ZRmoHaSojk6ra5OU@pc220518.home.grep.be>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-8-hch@lst.de>
 <79af9398-167f-440e-a493-390dc4ccbd85@sifive.com>
 <20230925074838.GA28522@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925074838.GA28522@lst.de>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 09:48:38AM +0200, Christoph Hellwig wrote:
> On Wed, Sep 20, 2023 at 03:41:11PM -0500, Samuel Holland wrote:
> > [   14.619101] Buffer I/O error on dev nbd0, logical block 0, async page read
> > 
> > [   14.630490]  nbd0: unable to read partition table
> > 
> > I wonder if disk_force_media_change() is the right thing to call here instead.
> 
> So what are the semantics of clearing the socket?
> 
> The <= 6.5 behavior of invalidating fs caches, but not actually marking
> the fs shutdown is pretty broken, especially if this expects to resurrect
> the device and thus the file system later on.

nbd-client -d calls

ioctl(nbd, NBD_DISCONNECT);
ioctl(nbd, NBD_CLEAR_SOCK);

(error handling removed for clarity)

where "nbd" is the file handle to the nbd device. This expects that the
device is cleared and that then the device can be reused for a different
connection, much like "losetup -d". Expecting that the next connection
would talk to the same file system is wrong.

In netlink mode, it obviously doesn't use the ioctl()s, but instead
sends an NBD_CMD_DISCONNECT command, without any NBD_CLEAR_SOCK, for
which no equivalent message exists. At this point, obviously the same
result is expected in userspace, i.e., the device should now be
available for the next connection that may or may not be the same one.

nbd-client also has "-persist" option that used to work. This does
expect to resurrect the device and file system. It depends on semantics
where the kernel would block IO to the device until the nbd-client
process that initiated the connection exits, thus allowing it to
re-establish the connection if possible. When doing this, we don't issue
a DISCONNECT or CLEAR_SOCK message and obviously the client is expected
to re-establish a connection to the same device, thus some state should
be retained.

These semantics have however been broken at some point over the past decade
or so, but I didn't notice that at the time, so I didn't complain, and
it's therefore probably not relevant anymore. We should perhaps rethink
whether this is still a good idea given the way the netlink mode does
not have a client waiting for a return of the ioctl() call, and if so
how to implement a replacement.

Kind regards,

-- 
     w@uter.{be,co.za}
wouter@{grep.be,fosdem.org,debian.org}

I will have a Tin-Actinium-Potassium mixture, thanks.
