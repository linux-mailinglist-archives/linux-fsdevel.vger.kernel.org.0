Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A5A7755D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 02:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfG0AJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 20:09:41 -0400
Received: from ale.deltatee.com ([207.54.116.67]:41760 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfG0AJl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 20:09:41 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hrAHE-0003CB-OC; Fri, 26 Jul 2019 18:09:33 -0600
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
 <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
 <e166c392-1548-f0bb-02bc-ced3dd85f301@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1260e01c-6731-52f7-ae83-0b90e0345c68@deltatee.com>
Date:   Fri, 26 Jul 2019 18:09:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e166c392-1548-f0bb-02bc-ced3dd85f301@grimberg.me>
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



On 2019-07-26 5:13 p.m., Sagi Grimberg wrote:
> 
>>> Why? if nvmet is capable, why shouldn't we support it?
>>
>> I'm saying that passthru is exporting a specific controller and submits
>> commands (both admin and IO) straight to the nvme_ctrl's queues. It's
>> not exporting an nvme_subsys and I think it would be troublesome to do
>> so; for example, if the target receives an admin command which ctrl of
>> the subsystem should it send it to?
> 
> Its the same controller in the backend, what is the difference from
> which fabrics controller the admin command came from?

This is not my understanding. It's not really the same controller in the
back end and there are admin commands that operate on the controller
like the namespace attachment command which takes a list of cntlids
(though admittedly is not something I'm too familiar with because I
don't have any hardware to play around with). Though that command is
already a bit problematic for passthru because we have different cntlid
address spaces.

> I haven't thought this through so its very possible that I'm missing
> something, but why can't the host see multiple controllers if it has
> more than one path to the target?

Well a target controller is created for each connection. So if the host
wanted to see multiple controllers it would have to do multiple "nvme
connects" and some how need to address the individual controllers for
each connection. Right now a connect is based on subsysnqn which would
be the same for every multipath controller.

> What specific admin commands are you concerned about? What exactly
> would clash?

Namespace attach comes to mind.

> And I'm suggesting to allow more than a single controller given that all
> controller allocations match a single hostnqn. It wouldn't make sense to
> expose this controller to multiple hosts (although that might be doable
> but but definitely requires non-trivial infrastructure around it).

> Look, when it comes to fabrics, multipath is a fundamental piece of the
> puzzle. Not supporting multipathing significantly diminishes the value
> of this in my mind (assuming this answers a real-world use-case).

I'd agree with that. But it's the multipath through different ports that
seems important for fabrics. ie. If I have a host with a path through
RDMA and a path through TCP they should both work and allow fail over.
This is quite orthogonal to passthru and would be easily supported if we
dropped the multiple hosts restriction (I'm not sure what the objection
really is to that).

This is different from multipath on say a multi-controller PCI device
and trying to expose both those controllers through passthru. this is
where the problems we are discussing come up. Supporting this is what is
hard and I think the sensible answer is if users want to do something
like that, they use non-passthru NVME-of and the multipath code will
just work as designed.

Our real-world use case is to support our PCI device which has a bunch
of vendor unique commands and isn't likely to support multiple
controllers in the foreseeable future.

Logan
