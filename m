Return-Path: <linux-fsdevel+bounces-5722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C6680F2C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71EC1C20EDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5B78E81;
	Tue, 12 Dec 2023 16:32:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723FBA8;
	Tue, 12 Dec 2023 08:32:54 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6ACA68C4E; Tue, 12 Dec 2023 17:32:46 +0100 (CET)
Date: Tue, 12 Dec 2023 17:32:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231212163246.GA24594@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 12, 2023 at 11:08:28AM +0000, John Garry wrote:
> Two new fields are added to struct statx - atomic_write_unit_min and
> atomic_write_unit_max. For each atomic individual write, the total length
> of a write must be a between atomic_write_unit_min and
> atomic_write_unit_max, inclusive, and a power-of-2. The write must also be
> at a natural offset in the file wrt the write length.
> 
> SCSI sd.c and scsi_debug and NVMe kernel support is added.
> 
> Some open questions:
> - How to make API extensible for when we have no HW support? In that case,
>   we would prob not have to follow rule of power-of-2 length et al.
>   As a possible solution, maybe we can say that atomic writes are
>   supported for the file via statx, but not set unit_min and max values,
>   and this means that writes need to be just FS block aligned there.

I don't think the power of two length is much of a problem to be
honest, and if we every want to lift it we can still do that easily
by adding a new flag or limit.

What I'm a lot more worried about is how to tell the file system that
allocations are done right for these requirement.  There is no way
a user can know that allocations in an existing file are properly
aligned, so atomic writes will just fail on existing files.

I suspect we need an on-disk flag that forces allocations to be
aligned to the atomic write limit, in some ways similar how the
XFS rt flag works.  You'd need to set it on an empty file, and all
allocations after that are guaranteed to be properly aligned.

> - For block layer, should atomic_write_unit_max be limited by
>   max_sectors_kb? Currently it is not.

Well.  It must be limited to max_hw_sectors to actually work.
max_sectors is a software limit below that, which with modern hardware
is actually pretty silly and a real performance issue with todays
workloads when people don't tweak it..

> - How to improve requirement that iovecs are PAGE-aligned.
>   There are 2x issues:
>   a. We impose this rule to not split BIOs due to virt boundary for
>      NVMe, but there virt boundary is 4K (and not PAGE size, so broken for
>      16K/64K pages). Easy solution is to impose requirement that iovecs
>      are 4K-aligned.
>   b. We don't enforce this rule for virt boundary == 0, i.e. SCSI

.. we require any device that wants to support atomic writes to not
have that silly limit.  For NVMe that would require SGL support
(and some driver changes I've been wanting to make for long where
we always use SGLs for transfers larger than a single PRP if supported)


> - Since debugging torn-writes due to unwanted kernel BIO splitting/merging
>   would be horrible, should we add some kernel storage stack software
>   integrity checks?

Yes, I think we'll need asserts in the drivers.  At least for NVMe I
will insist on them.  For SCSI I think the device actually checks
because the atomic writes are a different command anyway, or am I
misunderstanding how SCSI works here?


