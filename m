Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9210B77411
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 00:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfGZWhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 18:37:35 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40494 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfGZWhf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:37:35 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hr8q5-0001Wp-HP; Fri, 26 Jul 2019 16:37:26 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
 <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
 <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
Date:   Fri, 26 Jul 2019 16:37:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hare@suse.de, sagi@grimberg.me
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



On 2019-07-26 4:21 p.m., Sagi Grimberg wrote:
>> I don't think it necessarily makes sense for the target subsynqn and the
>> target's device nqn to be the same. It would be weird for a user to want
>> to use the same device and a passed through device (through a loop) as
>> part of the same subsystem. That being said, it's possible for the user
>> to use the subsysnqn from the passed through device for the name of the
>> subsys of the target. I tried this and it works except for the fact that
>> the device I'm passing through doesn't set id->cmic.
> 
> I don't see why should the subsystem nqn should be the same name. Its
> just like any other nvmet subsystem, just happens to have a nvme
> controller in the backend (which it knows about). No reason to have
> the same name IMO.

Agreed.

>>> Similarly: how do you propose to handle multipath devices?
>>> Any NVMe with several paths will be enabling NVMe multipathing
>>> automatically, presenting you with a single multipathed namespace.
>>> How will these devices be treated?
>>
>> Well passthru works on the controller level not on the namespace level.
>> So it can't make use of the multipath handling on the target system.
> 
> Why? if nvmet is capable, why shouldn't we support it?

I'm saying that passthru is exporting a specific controller and submits
commands (both admin and IO) straight to the nvme_ctrl's queues. It's
not exporting an nvme_subsys and I think it would be troublesome to do
so; for example, if the target receives an admin command which ctrl of
the subsystem should it send it to? There's also no userspace handle for
a given subsystem we'd maybe have to use the subsysnqn.

>> The one case that I think makes sense to me, but I don't know how if we
>> can handle, is if the user had a couple multipath enabled controllers
>> with the same subsynqn
> 
> That is usually the case, there is no multipathing defined across NVM
> subsystems (at least for now).
> 
>> and wanted to passthru all of them to another
>> system and use multipath on the host with both controllers. This would
>> require having multiple target subsystems with the same name which I
>> don't think will work too well.
> 
> Don't understand why this is the case?
> 
> AFAICT, all nvmet needs to do is:
> 1. override cimc
> 2. allow allocating multiple controllers to the pt ctrl as long as the
> hostnqn match.
> 3. answer all the ana stuff.

But with this scheme the host will only see one controller and then the
target would have to make decisions on which ctrl to send any commands
to. Maybe it could be done for I/O but I don't see how it could be done
correctly for admin commands.

And from the hosts perspective, having cimc set doesn't help anything
because we've limited the passthru code to only accept one connection
from one host so the host can only actually have one route to this
controller.

Logan
