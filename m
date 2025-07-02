Return-Path: <linux-fsdevel+bounces-53716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B3AF61C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1DC165387
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039E2F7CEE;
	Wed,  2 Jul 2025 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTe3GXWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249F2F7CE0;
	Wed,  2 Jul 2025 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481880; cv=none; b=XifEW05IV7EoDI4gqK3nycWs9h/eav7RbIsAo+zz38ID4NeTmLPDuIsyKbGX+Sq9PgWCptDxvkE0SzwP9gWC97GFwnOT0jxQ/JGSc+LjVPjmyeo5vIcT2US8pfY7UnXHUmq7nNqaCS6jemk/DVKl+nvoEKpY/APjZwD7L14REHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481880; c=relaxed/simple;
	bh=/IZPd8KlF1Rfpn2HYXRQXoTSPYc958DcN74ujLHkxLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYnZHQG/9rkx3aPJEUN5D21kChn+1P2qXLmfFPdQ9nccaKBIAEgjM4jR36v/o4E/5cIcl3QRgiYKIGbslESu60b5y7Mjs+MV69idIMRirC68nss7WsiSyY1J4AXLyW+x0usMm7h74Zg/1os+r0qATPCDtQyhc7MMn16HuyhrA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTe3GXWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929F6C4CEE7;
	Wed,  2 Jul 2025 18:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751481879;
	bh=/IZPd8KlF1Rfpn2HYXRQXoTSPYc958DcN74ujLHkxLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTe3GXWS6Db++/57WYwVc3keMIXhJgZR4AR38dxLEyuCPmELgp+zbrl4ZBaRTSrU4
	 cgOdmtJoRoq6XVoUNDgzn32O8s8Ldv6Pbr/j0mTPm9x7Mxon1GryHW7d6k+VR1ijtU
	 t1OYIydDucFAbmJfRvfrYndlpUrRnTA9hd13CAMdlypcg68bIpUIWIAP/1m00NoYtA
	 8XFp30voETMfh7A6fJYAWNQhqcRn2jGAXGyHs8Od9eYjLFYQUhrApNqoCCQ6UzPGVE
	 oN+Nv/SqIH5Kf8azSfXJ3hTAd2J26JhN2KGNL0kDLqFTjs3ox+gZrC/ARaA6Wws7Jc
	 sGmv0XhJNxFIA==
Date: Wed, 2 Jul 2025 11:44:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kundan Kumar <kundanthebest@gmail.com>
Cc: Anuj gupta <anuj1072538@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	ritesh.list@gmail.com, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <20250702184439.GD9991@frogsfrogsfrogs>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com>
 <20250602141904.GA21996@lst.de>
 <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com>
 <20250603132434.GA10865@lst.de>
 <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
 <CALYkqXqVRYqq+5_5W4Sdeh07M8DyEYLvrsm3yqhhCQTY0pvU1g@mail.gmail.com>
 <20250611155144.GD6138@frogsfrogsfrogs>
 <CALYkqXpOBb1Ak2kEKWbO2Kc5NaGwb4XsX1q4eEaNWmO_4SQq9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALYkqXpOBb1Ak2kEKWbO2Kc5NaGwb4XsX1q4eEaNWmO_4SQq9w@mail.gmail.com>

On Tue, Jun 24, 2025 at 11:29:28AM +0530, Kundan Kumar wrote:
> On Wed, Jun 11, 2025 at 9:21 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Jun 04, 2025 at 02:52:34PM +0530, Kundan Kumar wrote:
> > > > > > For xfs used this command:
> > > > > > xfs_io -c "stat" /mnt/testfile
> > > > > > And for ext4 used this:
> > > > > > filefrag /mnt/testfile
> > > > >
> > > > > filefrag merges contiguous extents, and only counts up for discontiguous
> > > > > mappings, while fsxattr.nextents counts all extent even if they are
> > > > > contiguous.  So you probably want to use filefrag for both cases.
> > > >
> > > > Got it — thanks for the clarification. We'll switch to using filefrag
> > > > and will share updated extent count numbers accordingly.
> > >
> > > Using filefrag, we recorded extent counts on xfs and ext4 at three
> > > stages:
> > > a. Just after a 1G random write,
> > > b. After a 30-second wait,
> > > c. After unmounting and remounting the filesystem,
> > >
> > > xfs
> > > Base
> > > a. 6251   b. 2526  c. 2526
> > > Parallel writeback
> > > a. 6183   b. 2326  c. 2326
> >
> > Interesting that the mapping record count goes down...
> >
> > I wonder, you said the xfs filesystem has 4 AGs and 12 cores, so I guess
> > wb_ctx_arr[] is 12?  I wonder, do you see a knee point in writeback
> > throughput when the # of wb contexts exceeds the AG count?
> >
> > Though I guess for the (hopefully common) case of pure overwrites, we
> > don't have to do any metadata updates so we wouldn't really hit a
> > scaling limit due to ag count or log contention or whatever.  Does that
> > square with what you see?
> >
> 
> Hi Darrick,
> 
> We analyzed AG count vs. number of writeback contexts to identify any
> knee point. Earlier, wb_ctx_arr[] was fixed at 12; now we varied nr_wb_ctx
> and measured the impact.
> 
> We implemented a configurable number of writeback contexts to measure
> throughput more easily. This feature will be exposed in the next series.
> To configure, used: echo <nr_wb_ctx> > /sys/class/bdi/259:2/nwritebacks.
> 
> In our test, writing 1G across 12 directories showed improved bandwidth up
> to the number of allocation groups (AGs), mostly a knee point, but gains
> tapered off beyond that. Also, we see a good increase in bandwidth of about
> 16 times from base to nr_wb_ctx = 6.
> 
>     Base (single threaded)                :  9799KiB/s
>     Parallel Writeback (nr_wb_ctx = 1)    :  9727KiB/s
>     Parallel Writeback (nr_wb_ctx = 2)    :  18.1MiB/s
>     Parallel Writeback (nr_wb_ctx = 3)    :  46.4MiB/s
>     Parallel Writeback (nr_wb_ctx = 4)    :  135MiB/s
>     Parallel Writeback (nr_wb_ctx = 5)    :  160MiB/s
>     Parallel Writeback (nr_wb_ctx = 6)    :  163MiB/s

Heh, nice!

>     Parallel Writeback (nr_wb_ctx = 7)    :  162MiB/s
>     Parallel Writeback (nr_wb_ctx = 8)    :  154MiB/s
>     Parallel Writeback (nr_wb_ctx = 9)    :  152MiB/s
>     Parallel Writeback (nr_wb_ctx = 10)   :  145MiB/s
>     Parallel Writeback (nr_wb_ctx = 11)   :  145MiB/s
>     Parallel Writeback (nr_wb_ctx = 12)   :  138MiB/s
> 
> 
> System config
> ===========
> Number of CPUs = 12
> System RAM = 9G
> For XFS number of AGs = 4
> Used NVMe SSD of 3.84 TB (Enterprise SSD PM1733a)
> 
> Script
> =====
> mkfs.xfs -f /dev/nvme0n1
> mount /dev/nvme0n1 /mnt
> echo <num_wb_ctx> > /sys/class/bdi/259:2/nwritebacks
> sync
> echo 3 > /proc/sys/vm/drop_caches
> 
> for i in {1..12}; do
>   mkdir -p /mnt/dir$i
> done
> 
> fio job_nvme.fio
> 
> umount /mnt
> echo 3 > /proc/sys/vm/drop_caches
> sync
> 
> fio job
> =====
> [global]
> bs=4k
> iodepth=1
> rw=randwrite
> ioengine=io_uring
> nrfiles=12
> numjobs=1                # Each job writes to a different file
> size=1g
> direct=0                 # Buffered I/O to trigger writeback
> group_reporting=1
> create_on_open=1
> name=test
> 
> [job1]
> directory=/mnt/dir1
> 
> [job2]
> directory=/mnt/dir2
> ...
> ...
> [job12]
> directory=/mnt/dir1
> 
> > > ext4
> > > Base
> > > a. 7080   b. 7080    c. 11
> > > Parallel writeback
> > > a. 5961   b. 5961    c. 11
> >
> > Hum, that's particularly ... interesting.  I wonder what the mapping
> > count behaviors are when you turn off delayed allocation?
> >
> > --D
> >
> 
> I attempted to disable delayed allocation by setting allocsize=4096
> during mount (mount -o allocsize=4096 /dev/pmem0 /mnt), but still
> observed a reduction in file fragments after a delay. Is there something
> I'm overlooking?

Not that I know of.  Maybe we should just take the win. :)

--D

> -Kundan
> 

