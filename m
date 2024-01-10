Return-Path: <linux-fsdevel+bounces-7688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5D1829627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A992858C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E703EA7D;
	Wed, 10 Jan 2024 09:19:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B740320E;
	Wed, 10 Jan 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 34B2368BFE; Wed, 10 Jan 2024 10:19:29 +0100 (CET)
Date: Wed, 10 Jan 2024 10:19:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>, axboe@kernel.dk,
	kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com, bvanassche@acm.org,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240110091929.GA31003@lst.de>
References: <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com> <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com> <ZZ3Q4GPrKYo91NQ0@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ3Q4GPrKYo91NQ0@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 10, 2024 at 10:04:00AM +1100, Dave Chinner wrote:
> Hence history teaches us that we should be designing the API around
> the generic filesystem function required (hard alignment of physical
> extent allocation), not the specific use case that requires that
> functionality.

I disagree.  The alignment requirement is an artefact of how you
implement atomic writes.  As the fs user I care that I can do atomic
writes on a file and need to query how big the writes can be and
what alignment is required.

The forcealign feature is a sensible fs side implementation of that
if using hardware based atomic writes with alignment requirements,
but it is a really lousy userspace API.

So with John's API proposal for XFS with hardware alignment based atomic
writes we could still use force align.

Requesting atomic writes for an inode will set the forcealign flag
and the extent size hint, and after that it'll report atomic write
capabilities.  Roughly the same implementation, but not an API
tied to an implementation detail.

