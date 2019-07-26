Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4028676F7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfGZRIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 13:08:04 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35658 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387437AbfGZRIE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:08:04 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hr3h5-0004NW-W6; Fri, 26 Jul 2019 11:07:48 -0600
To:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
Date:   Fri, 26 Jul 2019 11:07:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hare@suse.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v6 00/16] nvmet: add target passthru commands support
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-07-26 12:23 a.m., Hannes Reinecke wrote:
> How do you handle subsystem naming?
> If you enable the 'passthru' device, the (nvmet) subsystem (and its
> name) is already created. Yet the passthru device will have its own
> internal subsystem naming, so if you're not extra careful you'll end up
> with a nvmet subsystem which doesn't have any relationship with the
> passthru subsystem, making addressing etc ... tricky.
> Any thoughts about that?

Well I can't say I have a great understanding of how multipath works, but...

I don't think it necessarily makes sense for the target subsynqn and the
target's device nqn to be the same. It would be weird for a user to want
to use the same device and a passed through device (through a loop) as
part of the same subsystem. That being said, it's possible for the user
to use the subsysnqn from the passed through device for the name of the
subsys of the target. I tried this and it works except for the fact that
the device I'm passing through doesn't set id->cmic.

> Similarly: how do you propose to handle multipath devices?
> Any NVMe with several paths will be enabling NVMe multipathing
> automatically, presenting you with a single multipathed namespace.
> How will these devices be treated?

Well passthru works on the controller level not on the namespace level.
So it can't make use of the multipath handling on the target system.

The one case that I think makes sense to me, but I don't know how if we
can handle, is if the user had a couple multipath enabled controllers
with the same subsynqn and wanted to passthru all of them to another
system and use multipath on the host with both controllers. This would
require having multiple target subsystems with the same name which I
don't think will work too well.

> Will the multipathed namespace be used for passthru?

Nope.

Honestly, I think the answer is if someone wants to use multipathed
controllers they should use regular NVMe-of as it doesn't really mesh
well with the passthru approach.

Logan
