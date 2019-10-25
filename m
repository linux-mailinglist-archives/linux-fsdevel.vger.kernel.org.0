Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF0E56F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2019 01:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfJYXKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 19:10:11 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37790 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfJYXKL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:10:11 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iO8iV-0001Q4-U7; Fri, 25 Oct 2019 17:10:01 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-6-logang@deltatee.com> <20191010123406.GC28921@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <247eca47-c3bc-6452-fb19-f7aa27b05a60@deltatee.com>
Date:   Fri, 25 Oct 2019 17:09:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010123406.GC28921@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v9 05/12]
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey,

Ok, I've got much of the work in progress: anything I haven't mentioned
below I should be able to get done for the next version of the patchset.

However, I have some remaining comments on the following feedback:

On 2019-10-10 6:34 a.m., Christoph Hellwig wrote:
>> +	/* don't support host memory buffer */
>> +	id->hmpre = 0;
>> +	id->hmmin = 0;
> 
> What about CMB/PMR?

The CMB and PMR are not specified in the identify structure. They are
specified in PCI registers so there's no need to override anything here.
I don't think it makes any sense to try to pass these through fabrics.

>> +	/*
>> +	 * When passsthru controller is setup using nvme-loop transport it will
>> +	 * export the passthru ctrl subsysnqn (PCIe NVMe ctrl) and will fail in
>> +	 * the nvme/host/core.c in the nvme_init_subsystem()->nvme_active_ctrl()
>> +	 * code path with duplicate ctr subsynqn. In order to prevent that we
>> +	 * mask the passthru-ctrl subsysnqn with the target ctrl subsysnqn.
>> +	 */
>> +	memcpy(id->subnqn, ctrl->subsysnqn, sizeof(id->subnqn));
> 
> I don't think this is a good idea.  It will break multipathing when you
> export two ports of the original controller.  The whole idea of
> overwriting ctrlid and subsysnqn will also lead to huge problems with
> persistent reservations.  I think we need to pass through the subnqn
> and cntlid unmodified.

I think trying to clone the cntlid will cause bigger problems with
multipath... I'll inflict some ascii art on you to try and explain.

The fabrics code creates a new controller for every connection, so if
they all had the cntlid of the passed through controller then we'd have
to restrict each passed through controller to only have a single
connection which means we can't have multi-path over the fabrics side
because we'd end up with something like this:

 +-----------------+      +-----------------+      +----------------+
 |Host A Subsys A  |      |Target Subsys A  |      |Host B Subsys A |
 | +--------------+|      |        +------+ | tcp  |        +------+|
 | | PCI Device   ||  -------------+ Ctrl +-----------------+ Ctrl ||
 | |      +------+||  |   |        |   0  | |      |        |   0  ||
 | |      | Ctrl +----+   |        +------+ |      |        +------+|
 | |      |   0  |||  |   |        +------+ | rdma |        +------+|
 | |      +------+||  +------------+ Ctrl +-----------------+ Ctrl ||
 | |      +------+||  |   |        |   0  | |      |        |   0  ||
 | |      | Ctrl |||  |   |        +------+ |      |        +------+|
 | |      |   1  |||  |   |        +------+ | loop |                |
 | |      +------+||  +------------+ Ctrl +----+   |                |
 | +--------------+|      |        |   0  | |  |   |                |
 |                 |      |        +------+ |  |   |                |
 |                 |      +-----------------+  |   +----------------+
 |                 |                           |
 |     ----------------------------------------+
 |    |            |
 |    |   +------+ |
 |    +---+ Ctrl | |
 |        |   0  | |
 |        +------+ |
 +-----------------+

Multipath doesn't work on Host B because all the controllers have the
same cntlid and it doesn't work on Host A for the loop back interface
because the cntlid conflicts with the cntlid of the original device. If
we allow the target to assign cntlid's from the IDA, per usual, I think
we have a much better situation:

+-----------------+      +-----------------+      +----------------+
 |Host A Subsys A  |      |Target Subsys A  |      |Host B Subsys A |
 | +--------------+|      |        +------+ | tcp  |        +------+|
 | | PCI Device   ||  -------------+ Ctrl +-----------------+ Ctrl ||
 | |      +------+||  |   |        |   0  | |      |        |   0  ||
 | |      | Ctrl +----+   |        +------+ |      |        +------+|
 | |      |   0  |||  |   |        +------+ | rdma |        +------+|
 | |      +------+||  +------------+ Ctrl +-----------------+ Ctrl ||
 | |      +------+||  |   |        |   1  | |      |        |   1  ||
 | |      | Ctrl |||  |   |        +------+ |      |        +------+|
 | |      |   1  |||  |   |        +------+ | loop |                |
 | |      +------+||  +------------+ Ctrl +----+   |                |
 | +--------------+|      |        |   2  | |  |   |                |
 |                 |      |        +------+ |  |   |                |
 |                 |      +-----------------+  |   +----------------+
 |                 |                           |
 |     ----------------------------------------+
 |    |            |
 |    |   +------+ |
 |    +---+ Ctrl | |
 |        |   2  | |
 |        +------+ |
 +-----------------+

Now multipath works for host B and will work with the loopback to Host
A, but *only* if the target assigns it a cntlid that doesn't conflict
with one that was in the original device (which is actually quite common
in the simple case of one device and one target). To deal with this
situation I contend it's better to replace the subsysnqn:

 +-----------------+      +-----------------+      +----------------+
 |Host A Subsys A  |      |Target Subsys B  |      | Host B Subsys B|
 | +--------------+|      |        +------+ | tcp  |        +------+|
 | | PCI Device   ||  -------------+ Ctrl +-----------------+ Ctrl ||
 | |      +------+||  |   |        |   2  | |      |        |   2  ||
 | |      | Ctrl +----+   |        +------+ |      |        +------+|
 | |      |   0  |||  |   |        +------+ | rdma |        +------+|
 | |      +------+||  +------------+ Ctrl +-----------------+ Ctrl ||
 | |      +------+||  |   |        |   1  | |      |        |   1  ||
 | |      | Ctrl |||  |   |        +------+ |      |        +------+|
 | |      |   1  |||  |   |        +------+ | loop |                |
 | |      +------+||  +------------- Ctrl +----+   |                |
 | +--------------+|      |        |   0  | |  |   |                |
 +-----------------+      |        +------+ |  |   |                |
 +-----------------+      +-----------------+  |   +----------------+
 |Host A Subsys B  |                           |
 |     ----------------------------------------+
 |    |            |

 |    |   +------+ |

 |    +---+ Ctrl | |

 |        |   0  | |

 |        +------+ |

 +-----------------+

This way loopback is always guaranteed to work, and multipath over
fabrics will still work as well because they are never exposed to the
original subsysnqn. Using a loopback device is really only useful for
testing so I don't think using it as a path in a multipath setup will
ever make any sense and thus we don't lose anything valuable by not
having the same subsysnqn for the looped back host.

The first problem with this is if someone wants to passthru two ports
of a multiport PCI device. If the cntlids and the subsysnqns were copied
we could theoretically do something like this:

 +-----------------+     +-----------------+       +-----------------+
 |Host A Subsys A  |     |Target Subsys A  |       |Host B Subsys A  |
 | +--------------+|     |        +------+ |       |        +------+ |
 | | PCI Device   ||  ------------+ Ctrl +------------------+ Ctrl | |
 | |      +------+||  |  |        |   0  | |       |        |   0  | |
 | |      | Ctrl +----+  |        +------+ |       |        +------+ |
 | |      |   0  |||     +-----------------+       |        +------+ |
 | |      +------+||     +-----------------+    ------------+ Ctrl | |
 | |      +------+||     | Target Subsys A |    |  |        |   1  | |
 | |      | Ctrl +----+  |        +------+ |    |  |        +------+ |
 | |      |   1  |||  |  |        | Ctrl | |    |  |                 |
 | |      +------+||  -----------+|   1  +------+  +-----------------+
 | +--------------+|     |        +------+ |
 +-----------------+     +-----------------+

But this is awkward because we now have two subsystems that will require
different nqns in configfs but will expose the same nqn as the original
device in the identify command. If we try to make it less awkward by
allowing a target subsystem to point to multiple ctrls (of the same
subsystem) then we end up having to deal with a bunch of multipath
complexity like implementing multipath for admin commands, etc. Not to
mention the current passthru code is pretty much bypassing all the core
multipath code so this would all have to be reworked significantly.

I would argue that if someone wants to create a target for a multi-port
PCI device and have multipath through both ports, then they should use
the regular block device target and not a passthru target -- then it
will all work using the existing multipath support in the core.

The second problem with substituting cntlids is that some admin commands
like the namespace attach command, take the cntlid as an input, so we'd
have to translate those some how if we want to pass them through. I
think this should be possible, however, I don't have any hardware that
implements this so it would be hard for me to test any solution for this
problem. So, for now, we've chosen just to reject such admin commands.

>> +	/* Support multipath connections with fabrics */
>> +	id->cmic |= 1 << 1;
> 
> I don't think we can just overwrite this, we need to use the original
> controllers values.

If we don't overwrite this, then none of the multi-path over fabric
scenarios, from above (that we do want to support) will work with any
device that doesn't advertise this bit. As long as we set the bit, then
multipath over the fabrics connection will work just fine.
>> +	/* 4. By default, blacklist all admin commands */
>> +	default:
>> +
>> +		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>> +		req->execute = NULL;
>> +		break;
>> +	}
> 
> That seems odd.  There is plenty of other useful admin commands.
> 
> Yes, we need to ignore the PCIe specific ones:
> 
>  - Create I/O Completion Queue
>  - Create I/O Submission Queue
>  - Delete I/O Completion Queue
>  - Delete I/O Submission Queue
>  - Doorbell Buffer Configuration
>  - Virtualization Management
> 
> but all others seem perfectly valid to pass through.

This was based on Sagi's feedback[1]. He contends that the format NVM
command is not safe in an environment where there might be multiple
hosts. For similar reasons, firmware commands and others might be
dangerous too. We also have to ignore NS attach commands for reasons
outlined above. So it certainly seems like there's more admin commands
than not that we need to at least be careful of. Starting with a black
list then adding the commands that are interesting to pass through (and
that we can properly reason won't break things) seems like a prudent
approach. For our use cases, we largely only care about identify
commands and vendor specific commands.

Logan


[1]
https://lore.kernel.org/linux-block/e4430207-7def-8776-0289-0d58689dc0cd@grimberg.me/
