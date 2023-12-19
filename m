Return-Path: <linux-fsdevel+bounces-6474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6B48180F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 06:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7641C23067
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 05:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384A8832;
	Tue, 19 Dec 2023 05:21:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50138472;
	Tue, 19 Dec 2023 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A84268AFE; Tue, 19 Dec 2023 06:21:21 +0100 (CET)
Date: Tue, 19 Dec 2023 06:21:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231219052121.GA338@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212163246.GA24594@lst.de> <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com> <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com> <20231219051456.GB3964019@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219051456.GB3964019@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 09:14:56PM -0800, Darrick J. Wong wrote:
> /me stumbles back in with plenty of covidbrain to go around.
> 
> So ... Christoph, you're asking for a common API for
> sysadmins/applications to signal to the filesystem that they want all
> data allocations aligned to a given value, right?
> 
> e.g. if a nvme device advertises a capability for untorn writes between
> $lbasize and 64k, then we need a way to set up each untorn-file with
> some alignment between $lbasize and 64k?
> 
> or if cxl storage becomes not ung-dly expensive, then we'd want a way to
> set up files with an alignment of 2M (x86) or 512M (arm64lol) to take
> advantage of PMD mmap mappings?

The most important point is to not mix these up.

If we want to use a file for atomic writes I should tell the fs about
it, and preferably in a way that does not require me to know about weird
internal implementation details of every file system.  I really just
want to use atomic writes.  Preferably I'd just start using them after
asking for the limits.  But that's obviously not going to work for
file systems that use the hardware offload and don't otherwise align
to the limit (which would suck for very small files anyway :))

So as a compromise I tell the file system before writing or otherwise
adding any data [1] to file that I want to use atomic writes so that
the fs can take the right decisions.

[1] reflinking data into a such marked file will be ... interesting.


