Return-Path: <linux-fsdevel+bounces-12522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D63C86054C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 23:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F351C25016
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 22:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B759137919;
	Thu, 22 Feb 2024 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fm/twIxk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5E12D1F8;
	Thu, 22 Feb 2024 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639192; cv=none; b=h9oTd42lchuQTk40J9jxULSEXXqMWBV7Yn6fGFTkMyA+WyLzKwOBkaE4qS/dvskpzEjp1SxRfyVhnn8Le2NsvqCweDp6FebyGcMJyDw5IL2mY7x3zAXi/qkzTFGchtVqoju4VIkbuXN/NLwwpCMzzEdnIdgH0+bVBP/jAfdOaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639192; c=relaxed/simple;
	bh=1x+Bqaxaykfznlyo9yGS74P6CmhQYmfn9H/hXcPVVOg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MJxwY2zKqBU66HmTuwn/5/yj/jB0dHfHb6Cezu1lZWs1Cz6USON0704bnjmpcuVfkVF88YdIqO0ETSFw6auBX3JJ1oIR5v94cYiNoTC+OOQ5Ju4mGT5zw7mK37en5mpNwpWm/x/tD44vTgVzccxBaV0e+4gkR3yEJt3zJwumq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fm/twIxk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Kh7etTWBnizty3utnv9wERJ2i8f07gzHlZck1w7FtLY=; b=Fm/twIxknGlVLiYGrsTX9mply2
	bOCDrzxN3mCOQcXH5BKNfXYoVHa7asG+SrtTyt7iQSdj3EsgCKZpESJU++kblnDLcmM09bJFqHWRZ
	niA1lGhaYpfGXgS8dRs0dqYU22BNfUlMMIalU/DsO/CHj4AF4KpfwgWiOjG8AvL6KTHGiliNo6dQ6
	qxH6zbu2yATzyADzz+OcT+gbWzqGxVe8bTxira//UABuUSOli6afgy+tDGHcqJ3VkNBfRLLv9Idfk
	VHOYDWakREF1/Ksq5Pk6t/DoIR7ABxToKtMGy+NNkqjI2gHhMUCNxdwPD4s3r7bqH4DUTSJOTueBq
	wZf4rZgg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdH6K-00000006l65-1NGG;
	Thu, 22 Feb 2024 21:59:33 +0000
Date: Thu, 22 Feb 2024 13:59:32 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: lsf-pc@lists.linux-foundation.org, John Garry <john.g.garry@oracle.com>,
	Tso Ted <tytso@mit.edu>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	"kbus >> Keith Busch" <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Dave Chinner <david@fromorbit.com>, hch@lst.de, mcgrof@kernel.org
Cc: djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, chandan.babu@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: [LSF/MM/BPF TOPIC] no tears atomics & LBS
Message-ID: <ZdfDxN26VOFaT_Tv@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>

At last year's LSFMM we learned through Ted Ts'o about the interest by
cloud providers in large atomics [0]. It is a good example where cloud
providers innovated in an area perhaps before storage vendors were
providing hardware support for such features. An example use case was
databases. In short, with large atomics databases can disable their own version
of journaling so to increase TPS. Large atomics lets you  disabling things like
MySQL innodb_doublewrite. The feature to allow you to disable this and use
large atomcis is known as torn write prevention [1]. At least for MySQL the
default page size for the database (used for columns) is 16k, and so enabling
for example a 16k atomic can allow you to take advantage of this. It was also
mentioned how PostgreSQL only supports buffered-IO and so it would be desirable
for a solution to support buffered-IO with large atomics as well. The way
cloud providers enable torn write protection, is by using direct IO.

John Garry has been working on adding an API for atomic writes, it would
seem some folks refer to this as the no-tears atomic API. It consists of
two parts, one for the block layer [2] and another set of changes for
XFS [3]. It enables Direct IO support with large atomics.  It includes
a userspace API which lets you peg a FS_XFLAG_ATOMICWRITES flag onto a
file, and you then create an XFS filesystem using the XFS realtime
subvolume with with an extent alignment. The current users of this API
seems to be SCSI, but obviously this can grow to support others. A neat
feature of this effort is you can have two separate directories with
separate aligment requirements. There is no generic filesystem solution
yet.

Meanwhile we're now at a v2 RFC for LBS support [4]. Although the LBS
effort originally was a completely orthogonal effort to large atomics, it
would seem there is a direct relationship here now worth discussing.
In short LBS enables buffered-IO large atomic support if the hardware
support its. We get both alignment constraints gauranteed and now ensure
we use contigous memory for the IOs for DMA too it is built on using large
folios. We expect NVMe drives which support support large atomics can
easily profit from this without any userspace modification other than
when you create the filesystem.

We reviewed the possible intersection of both efforts at our last LBS cabal
with LBS interested folks and Martin Peterson and John Garry. It is somewhat
unclear exactly how to follow up on some aspects of the no-tear API [5]
but there was agreement about the possible intersection of both efforts,
and that we should discuss this at LSFMM. The goal would be to try to reach
consensus on how no-tear API and how LBS could help with those
interested in leveraging large atomics.

Some things to evaluate or for us to discuss:

 * no-tear API:
   - allows directories to have separate alignment requirements
     - this might be useful for folks who want to use large IOs with
       large atomics for some workloads but smaller IOs for another
       directory on the same drive. It this a viable option to some
       users for large atomics with concerns of being forced to use
       only large writes with LBS?
   - statx is modified so to display new alignment considerations
   - atomics are power of 2
   - there seems to be some interest in supporting no-hardware-accel atomic
     solution, so a software implemented atomic solution, could someone
     clarify if that's accurate? How is the double write avoided? What are
     the use cases? Do databases use that today?
   - How do we generalize a solution per file? Would extending a min
     order per file be desirable? Is that even tenable?

  * LBS:
    - stat will return the block size set, so userspace applications
      using stat / statx will use the larger block size to ensure
      alignment
    - a drive with support for a large atomic but supporting smaller
      logical block sizes will still allow writes to the logical block
      size. If a block driver has a "preference" (in NVMe this would
      be the NPWG for the IU) to write above the logical block size,
      do we want the option to lift the logical block size? In
      retrospect I don't think this is needed given Jan Kara's patches
      to prevent allowing writes to to mounted devices [4], that should
      ensure that if a filesystem takes advantage of a larger physical
      block size and creates a filesystem with it as the sector size,
      userspace won't be mucking around with lower IOs to the drive
      while it is mounted. But, are there any applications which would
      get the block device logical block size instead for DIO?
    - LBS is transparent to to userspace applications
    - We've verified *most* IOs are aligned if you use a 16k block size
      but a smaller sector size, the lower IOs were verified to come
      from the XFS buffer cache. If your drive supports a large atomic
      you can avoid these as you can lift the sector size set as the
      physical block size will be larger than the logical block size.
      For NVMe today this is possible for drives with a large
      NPWG (the IU) and NAWUFP (the large atomic), for example.

Tooling:

  - Both efforts stand to gain from a shared verification set of tools
    for alignment and atomic use
  - We have a block layer eBPF alignent tool written by Daniel Gomez [6]
    however there is lack of interested parties to help review a simpler
    version of this tool this tool so we merge it [7], we can benefit from more
    eyeablls from experienced eBPF / block layer folks.
  - More advanced tools are typically not encouraged, and this leaves us
    wondering what a better home would be other than side forks
  - Other than preventing torn writes, do users of the no-tear API care
    about WAF? While we have one for NVMe for WAF [8] would
    collaborating on a generic tool be of interest ?

Any other things folks want to get out of this as a session, provided
there is interest?

[0] https://lwn.net/Articles/932900/
[1] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/storage-twp.html
[2] https://lore.kernel.org/linux-nvme/20240124113841.31824-1-john.g.garry@oracle.com/T/#m4ad28b480a8e12eb51467e17208d98ca50041ff2
[3] https://lore.kernel.org/all/20240124142645.9334-1-john.g.garry@oracle.com/
[4] https://lore.kernel.org/all/20240213093713.1753368-1-kernel@pankajraghav.com/T/#u
[5] https://lkml.kernel.org/r/20231101173542.23597-1-jack@suse.cz
[6] https://github.com/dagmcr/bcc/tree/blkalgn-dump
[7] https://github.com/iovisor/bcc/pull/4813
[8] https://github.com/dagmcr/bcc/tree/nvmeiuwaf

  Luis

