Return-Path: <linux-fsdevel+bounces-5968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D08811838
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522091C2139F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAAE28E20;
	Wed, 13 Dec 2023 15:44:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B27A26AE;
	Wed, 13 Dec 2023 07:44:16 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3036768B05; Wed, 13 Dec 2023 16:44:09 +0100 (CET)
Date: Wed, 13 Dec 2023 16:44:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231213154409.GA7724@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212163246.GA24594@lst.de> <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 13, 2023 at 09:32:06AM +0000, John Garry wrote:
>>> - How to make API extensible for when we have no HW support? In that case,
>>>    we would prob not have to follow rule of power-of-2 length et al.
>>>    As a possible solution, maybe we can say that atomic writes are
>>>    supported for the file via statx, but not set unit_min and max values,
>>>    and this means that writes need to be just FS block aligned there.
>> I don't think the power of two length is much of a problem to be
>> honest, and if we every want to lift it we can still do that easily
>> by adding a new flag or limit.
>
> ok, but it would be nice to have some idea on what that flag or limit 
> change would be.

That would require a concrete use case.  The simples thing for a file
system that can or does log I/O it would simply be a flag waving all
the alignment and size requirements.

>> I suspect we need an on-disk flag that forces allocations to be
>> aligned to the atomic write limit, in some ways similar how the
>> XFS rt flag works.  You'd need to set it on an empty file, and all
>> allocations after that are guaranteed to be properly aligned.
>
> Hmmm... so how is this different to the XFS forcealign feature?

Maybe not much.  But that's not what it is about - we need a common
API for this and not some XFS internal flag.  So if this is something
we could support in ext4 as well that would be a good step.  And for
btrfs you'd probably want to support something like it in nocow mode
if people care enough, or always support atomics and write out of
place.

> For XFS, I thought that your idea was to always CoW new extents for 
> misaligned extents or writes which spanned multiple extents.

Well, that is useful for two things:

 - atomic writes on hardware that does not support it
 - atomic writes for bufferd I/O
 - supporting other sizes / alignments than the strict power of
   two above.

> Right, so we should limit atomic write queue limits to max_hw_sectors. But 
> people can still tweak max_sectors, and I am inclined to say that 
> atomic_write_unit_max et al should be (dynamically) limited to max_sectors 
> also.

Allowing people to tweak it seems to be asking for trouble.

>> have that silly limit.  For NVMe that would require SGL support
>> (and some driver changes I've been wanting to make for long where
>> we always use SGLs for transfers larger than a single PRP if supported)
>
> If we could avoid dealing with a virt boundary, then that would be nice.
>
> Are there any patches yet for the change to always use SGLs for transfers 
> larger than a single PRP?

No.

> On a related topic, I am not sure about how - or if we even should - 
> enforce iovec PAGE-alignment or length; rather, the user could just be 
> advised that iovecs must be PAGE-aligned and min PAGE length to achieve 
> atomic_write_unit_max.

Anything that just advices the user an it not clear cut and results in
an error is data loss waiting to happen.  Even more so if it differs
from device to device.

