Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6B6445862
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 18:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhKDRfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 13:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233848AbhKDRfO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:35:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51D5260EBC;
        Thu,  4 Nov 2021 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636047156;
        bh=olcBI4ItJW+ZApb9VTb2WM6OA4AiudQzwwdIT5YvDdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhMQy3W5g7qCDUiwWs1nl+6M7P3LZ/4qQP5Ud6eq5y4YMcR8asU5O10PEmPYFyRti
         CuUgL2xu0HPaFw3WxXNZfa5WIG7vg+uEeM2B1h1KbwOmhT7mIEqJxH6h7v2lhpbWq0
         RiifL7GcALWUnHkRw7tHI/3W9qe8aBXrPm/0+JsQYxzu8Xy/Ig6jVWcjI2BOxlOws1
         g3NsSD+5GqoyqUtHa6V4nP1fUEIpEo4zH0MbXJMvs6RLAn4czyFyAiQnw/pNPOu05Y
         3PBpu8mZnMCkX1JYlKwSlJal1ODYgR2TWQjnshLxbuvHIxcQtflrpl7shJIZO8Fw5y
         wwXGHnQF2e7+g==
Date:   Thu, 4 Nov 2021 10:32:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Message-ID: <20211104173235.GI2237511@magnolia>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104071439.GA21927@lst.de>
 <661bcadd-a030-4a72-81ae-ef15080f0241@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661bcadd-a030-4a72-81ae-ef15080f0241@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 04, 2021 at 09:27:50AM +0000, Chaitanya Kulkarni wrote:
> On 11/4/2021 12:14 AM, Christoph Hellwig wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > What is the actual use case here?
> > 
> 
> One of the immediate use-case is to use this interface with XFS 
> scrubbing infrastructure [1] (by replacing any SCSI calls e.g. sg_io() 
> with BLKVERIFY ioctl() calls corresponding to REQ_OP_VERIFY) and 
> eventually allow and extend other file systems to use it for scrubbing.

FWIW it /would/ be a win to have a general blkdev ioctl to do this,
rather than shoving SCSI commands through /dev/sg, which (obviously)
doesn't work when dm and friends are in use.  I hadn't bothered to wire
up xfs_scrub to NVME COMPARE because none of my devices support it and
tbh I was holding out for this kind of interface anyway. ;)

I also wonder if it would be useful (since we're already having a
discussion elsewhere about data integrity syscalls for pmem) to be able
to call this sort of thing against files?  In which case we'd want
another preadv2 flag or something, and then plumb all that through the
vfs/iomap as needed?

--D

> [1] man xfs_scrub :-
> -x     Read all file data extents to look for disk errors.
>                xfs_scrub will issue O_DIRECT reads to the block device
>                directly.  If the block device is a SCSI disk, it will
>                instead issue READ VERIFY commands directly to the disk.
>                If media errors are found, the error report will include
>                the disk offset, in bytes.  If the media errors affect a
>                file, the report will also include the inode number and
>                file offset, in bytes.  These actions will confirm that
>                all file data blocks can be read from storage.
> 
> 
