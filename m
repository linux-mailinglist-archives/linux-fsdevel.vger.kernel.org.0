Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF70044563E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 16:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhKDPZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 11:25:10 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:33131 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhKDPZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:25:09 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 11:25:08 EDT
Received: from mp-mx11.ca.inter.net (mp-mx11.ca.inter.net [208.85.217.19])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 61BD72EA1BD;
        Thu,  4 Nov 2021 11:16:45 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by mp-mx11.ca.inter.net (mp-mx11.ca.inter.net [208.85.217.19]) (amavisd-new, port 10024)
        with ESMTP id eveuZKOwWI_I; Thu,  4 Nov 2021 11:16:44 -0400 (EDT)
Received: from [192.168.48.23] (host-45-58-208-241.dyn.295.ca [45.58.208.241])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 78D192EA1A2;
        Thu,  4 Nov 2021 11:16:42 -0400 (EDT)
Reply-To: dgilbert@interlog.com
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, dm-devel@redhat.com
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, djwong@kernel.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, javier@javigon.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
        idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
        ebiggers@google.com, jinpu.wang@cloud.ionos.com,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <7f734d14-c107-daa3-aaa8-0eda3c592add@interlog.com>
Date:   Thu, 4 Nov 2021 11:16:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104064634.4481-1-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-11-04 2:46 a.m., Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
> 
> Hi,
> 
> One of the responsibilities of the Operating System, along with managing
> resources, is to provide a unified interface to the user by creating
> hardware abstractions. In the Linux Kernel storage stack that
> abstraction is created by implementing the generic request operations
> such as REQ_OP_READ/REQ_OP_WRITE or REQ_OP_DISCARD/REQ_OP_WRITE_ZEROES,
> etc that are mapped to the specific low-level hardware protocol commands
> e.g. SCSI or NVMe.
> 
> With that in mind, this RFC patch-series implements a new block layer
> operation to offload the data verification on to the controller if
> supported or emulate the operation if not. The main advantage is to free
> up the CPU and reduce the host link traffic since, for some devices,
> their internal bandwidth is higher than the host link and offloading this
> operation can improve the performance of the proactive error detection
> applications such as file system level scrubbing.
> 
> * Background *
> -----------------------------------------------------------------------
> 
> NVMe Specification provides a controller level Verify command [1] which
> is similar to the ATA Verify [2] command where the controller is
> responsible for data verification without transferring the data to the
> host. (Offloading LBAs verification). This is designed to proactively
> discover any data corruption issues when the device is free so that
> applications can protect sensitive data and take corrective action
> instead of waiting for failure to occur.
> 
> The NVMe Verify command is added in order to provide low level media
> scrubbing and possibly moving the data to the right place in case it has
> correctable media degradation. Also, this provides a way to enhance
> file-system level scrubbing/checksum verification and optinally offload
> this task, which is CPU intensive, to the kernel (when emulated), over
> the fabric, and to the controller (when supported).
> 
> This is useful when the controller's internal bandwidth is higher than
> the host's bandwith showing a sharp increase in the performance due to
> _no host traffic or host CPU involvement_.
> 
> * Implementation *
> -----------------------------------------------------------------------
> 
> Right now there is no generic interface which can be used by the
> in-kernel components such as file-system or userspace application
> (except passthru commands or some combination of write/read/compare) to
> issue verify command with the central block layer API. This can lead to
> each userspace applications having protocol specific IOCTL which
> defeates the purpose of having the OS provide a H/W abstraction.
> 
> This patch series introduces a new block layer payloadless request
> operation REQ_OP_VERIFY that allows in-kernel components & userspace
> applications to verify the range of the LBAs by offloading checksum
> scrubbing/verification to the controller that is directly attached to
> the host. For direct attached devices this leads to decrease in the host
> DMA traffic and CPU usage and for the fabrics attached device over the
> network that leads to a decrease in the network traffic and CPU usage
> for both host & target.
> 
> * Scope *
> -----------------------------------------------------------------------
> 
> Please note this only covers the operating system level overhead.
> Analyzing controller verify command performance for common protocols
> (SCSI/NVMe) is out of scope for REQ_OP_VERIFY.
> 
> * Micro Benchmarks *
> -----------------------------------------------------------------------
> 
> When verifing 500GB of data on NVMeOF with nvme-loop and null_blk as a
> target backend block device results show almost a 80% performance
> increase :-
> 
> With Verify resulting in REQ_OP_VERIFY to null_blk :-
> 
> real	2m3.773s
> user	0m0.000s
> sys	0m59.553s
> 
> With Emulation resulting in REQ_OP_READ null_blk :-
> 
> real	12m18.964s
> user	0m0.002s
> sys	1m15.666s
> 
> 
> A detailed test log is included at the end of the cover letter.
> Each of the following was tested:
> 
> 1. Direct Attached REQ_OP_VERIFY.
> 2. Fabrics Attached REQ_OP_VERIFY.
> 3. Multi-device (md) REQ_OP_VERIFY.
> 
> * The complete picture *
> -----------------------------------------------------------------------
> 
>    For the completeness the whole kernel stack support is divided into
>    two phases :-
>   
>    Phase I :-
>   
>     Add and stabilize the support for the Block layer & low level drivers
>     such as SCSI, NVMe, MD, and NVMeOF, implement necessary emulations in
>     the block layer if needed and provide block level tools such as
>     _blkverify_. Also, add appropriate testcases for code-coverage.
> 
>    Phase II :-
>   
>     Add and stabilize the support for upper layer kernel components such
>     as file-systems and provide userspace tools such _fsverify_ to route
>     the request from file systems to block layer to Low level device
>     drivers.
> 
> 
> Please note that the interfaces for blk-lib.c REQ_OP_VERIFY emulation
> will change in future I put together for the scope of RFC.
> 
> Any comments are welcome.

Hi,
You may also want to consider higher level support for the NVME COMPARE
and SCSI VERIFY(BYTCHK=1) commands. Since PCIe and SAS transports are
full duplex, replacing two READs (plus a memcmp in host memory) with
one READ and one COMPARE may be a win on a bandwidth constrained
system. It is a safe to assume the data-in transfers on a storage transport
exceed (probably by a significant margin) the data-out transfers. An
offloaded COMPARE switches one of those data-in transfers to a data-out
transfer, so it should improve the bandwidth utilization.

I did some brief benchmarking on a NVME SSD's COMPARE command (its optional)
and the results were underwhelming. OTOH using my own dd variants (which
can do compare instead of copy) and a scsi_debug target (i.e. RAM) I have
seen compare times of > 15 GBps while a copy rarely exceeds 9 GBps.


BTW The SCSI VERIFY(BYTCHK=3) command compares one block sent from
the host with a sequence of logical blocks on the media. So, for example,
it would be a quick way of checking that a sequence of blocks contained
zero-ed data.

Doug Gilbert
