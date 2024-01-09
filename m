Return-Path: <linux-fsdevel+bounces-7629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF982898F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 17:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A375B1C24691
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0543A1B6;
	Tue,  9 Jan 2024 16:02:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F6638DC1;
	Tue,  9 Jan 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97BB368B05; Tue,  9 Jan 2024 17:02:23 +0100 (CET)
Date: Tue, 9 Jan 2024 17:02:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, bvanassche@acm.org, ojaswin@linux.ibm.com
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240109160223.GA7737@lst.de>
References: <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com> <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com> <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 09, 2024 at 09:55:24AM +0000, John Garry wrote:
> So a user can issue:
>
> >xfs_io -c "atomic-writes 64K" mnt/file
> >xfs_io -c "atomic-writes" mnt/file
> [65536] mnt/file

Let me try to decipher that:

 - the first call sets a 64k fsx_atomicwrites_size size
 - the secon call queries fsx_atomicwrites_size?

> The user will still have to issue statx to get the actual atomic write 
> limit for a file, as 'xfs_io -c "atomic-writes"' does not take into account 
> any HW/linux block layer atomic write limits.

So will the set side never fail?

> Is this the sort of userspace API which you would like to see?

What I had in mind (and that's doesn't mean it's right..) was that
the user just sets a binary flag, and the fs reports the best it
could.  But there might be reasons to do it differently.


