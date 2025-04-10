Return-Path: <linux-fsdevel+bounces-46167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8947BA83A85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 09:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82C91B82978
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C620B1F4;
	Thu, 10 Apr 2025 07:14:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC1207A28;
	Thu, 10 Apr 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269250; cv=none; b=g6btYPAlhJZrC/EpW4QSHNhPlSRFOnoC+ExXJJsn0paRxYyTmTybpJUz6yIUfZCh/qg9H1tTFWhaEIVG85JSJkiECJgu6EZb+JWsfC3ewDhk7gWZssOZG6tN6s6Q6StrdSV00hEPKltLU1kWUNJt7glgXIG+deNdVaJCngAl2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269250; c=relaxed/simple;
	bh=aykbDz+EBV9MqHd1tGX6R6S9oFQyda8E3u4WyjfFlOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my7n9jMkg3Ypm6P7VIBSpy/vT47I4JB/LcS43H5JmiJepuBTYQ8G2AHu8j+XQAiyGc3limk0YdtCcYFWxXeBOIKeD4LmtSbsy4hZgQ5tTXP2hNpRUqbjbhIlTwNAuvtZKaokcNrlYRAx3KgyvZP79Jkrf5PV12bs6eQqQXrhT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E89F68B05; Thu, 10 Apr 2025 09:14:02 +0200 (CEST)
Date: Thu, 10 Apr 2025 09:14:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alistair Popple <apopple@nvidia.com>
Cc: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Asahi Lina <lina@asahilina.net>, Balbir Singh <balbirs@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	linmiaohe <linmiaohe@huawei.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Matthew Wilcow <willy@infradead.org>,
	Michael Camp Drill Sergeant Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ted Ts'o <tytso@mit.edu>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vivek Goyal <vgoyal@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [linus:master] [fs/dax]  bde708f1a6:
 WARNING:at_mm/truncate.c:#truncate_folio_batch_exceptionals
Message-ID: <20250410071402.GA32356@lst.de>
References: <202504101036.390f29a5-lkp@intel.com> <v66t3szdfsfwyl4lw6ns2ykmxrfqecba2nb5wa64l5qqq2kfpb@x7zxzuijty7d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v66t3szdfsfwyl4lw6ns2ykmxrfqecba2nb5wa64l5qqq2kfpb@x7zxzuijty7d>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 05:01:26PM +1000, Alistair Popple wrote:
> However I note that this is ext2. Commit 0e2f80afcfa6 doesn't actually update
> ext2 so the warning will persist. The fix should basically be the same as for
> ext4:

Are there any actual users of fsdax for ext2, and can't these users to
switch to ext4 in ext2 mode?  It would be nice to be able to drop the
barely maintained ext2 dax support.


