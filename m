Return-Path: <linux-fsdevel+bounces-7163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ACA8229D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 10:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517BAB22C4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4918632;
	Wed,  3 Jan 2024 09:02:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1318624;
	Wed,  3 Jan 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E5E768B05; Wed,  3 Jan 2024 10:02:05 +0100 (CET)
Date: Wed, 3 Jan 2024 10:02:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 06/19] block, fs: Propagate write hints to the block
 device inode
Message-ID: <20240103090204.GA1851@lst.de>
References: <20231219000815.2739120-1-bvanassche@acm.org> <20231219000815.2739120-7-bvanassche@acm.org> <20231228071206.GA13770@lst.de> <00cf8ffa-8ad5-45e4-bf7c-28b07ab4de21@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00cf8ffa-8ad5-45e4-bf7c-28b07ab4de21@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 28, 2023 at 02:41:59PM -0800, Bart Van Assche wrote:
> On 12/27/23 23:12, Christoph Hellwig wrote:
>> On Mon, Dec 18, 2023 at 04:07:39PM -0800, Bart Van Assche wrote:
>>> Write hints applied with F_SET_RW_HINT on a block device affect the
>>> shmem inode only. Propagate these hints to the block device inode
>>> because that is the inode used when writing back dirty pages.
>>
>> What shmem inode?
>
> The inode associated with the /dev file, e.g. /dev/sda. That is another
> inode than the inode associated with the struct block_device instance.
> Without this patch, when opening /dev/sda and calling fcntl(), the shmem
> inode is modified but the struct block_device inode not. I think that
> the code path for allocation of the shmem inode is as follows:

So the block device node.  That can sit on any file system (or at least
any Unix-y file system that supports device nodes).

>>> @@ -317,6 +318,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
>>>     	inode_lock(inode);
>>>   	inode->i_write_hint = hint;
>>> +	apply_whint = inode->i_fop->apply_whint;
>>> +	if (apply_whint)
>>> +		apply_whint(file, hint);
>>
>> Setting the hint in file->f_mapping->inode is the right thing here,
>> not adding a method.
>
> Is my understanding correct that the only way to reach the struct
> block_device instance from the shmem code is by dereferencing
> file->private_data?

No.  See blkdev_open:

	filp->f_mapping = handle->bdev->bd_inode->i_mapping;

So you can use file->f_mapping->inode as I said in my previous mail.


