Return-Path: <linux-fsdevel+bounces-7762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B882A59E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 02:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A591C230A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 01:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FCFEBF;
	Thu, 11 Jan 2024 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfDXvP+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF19650;
	Thu, 11 Jan 2024 01:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D61C433F1;
	Thu, 11 Jan 2024 01:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704937257;
	bh=u51yyq5q6reKn5H0CqnJR7jUYlsGmLnDJKKy8teJDRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfDXvP+m7491pQR0YUCkm0mTB2aBegWGodHoLZFFG4xnm1HYzXRQuH2gS9jmS4sxK
	 4a1YcSnAQwsufJxQwNnVNUv8zlTNrN2c8FDL4SvgoPYxlV5HCtl48g/zf8dKFEZFKy
	 s2oFPeyW0anIBYuwCbKWlfg0iILlMck90/uZ6HjK3pEsmr6x3ggHxQYlbGaZ+LM+u9
	 Cdp1Me8dqv2fMqivWwzjoUve3j+IWy/LLnsB6hnY7qN7e4nycBAq9OtxqrOqUVgXsd
	 pNUpTm723vIzDa8WcFdKrRTfElEbLc8gQRM3fqF3Cypry45w0MWn8V/GMykrc5s3y6
	 6wFr/xhlj/0lw==
Date: Wed, 10 Jan 2024 17:40:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>,
	John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com, bvanassche@acm.org,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240111014056.GL722975@frogsfrogsfrogs>
References: <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231219051456.GB3964019@frogsfrogsfrogs>
 <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
 <ZZ3Q4GPrKYo91NQ0@dread.disaster.area>
 <20240110091929.GA31003@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110091929.GA31003@lst.de>

On Wed, Jan 10, 2024 at 10:19:29AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 10, 2024 at 10:04:00AM +1100, Dave Chinner wrote:
> > Hence history teaches us that we should be designing the API around
> > the generic filesystem function required (hard alignment of physical
> > extent allocation), not the specific use case that requires that
> > functionality.
> 
> I disagree.  The alignment requirement is an artefact of how you
> implement atomic writes.  As the fs user I care that I can do atomic
> writes on a file and need to query how big the writes can be and
> what alignment is required.
> 
> The forcealign feature is a sensible fs side implementation of that
> if using hardware based atomic writes with alignment requirements,
> but it is a really lousy userspace API.
> 
> So with John's API proposal for XFS with hardware alignment based atomic
> writes we could still use force align.
> 
> Requesting atomic writes for an inode will set the forcealign flag
> and the extent size hint, and after that it'll report atomic write
> capabilities.  Roughly the same implementation, but not an API
> tied to an implementation detail.

Sounds good to me!  So to summarize, this is approximately what
userspace programs would have to do something like this:

struct statx statx;
struct fsxattr fsxattr;
int fd = open('/foofile', O_RDWR | O_DIRECT);

ioctl(fd, FS_IOC_GETXATTR, &fsxattr);

fsxattr.fsx_xflags |= FS_XFLAG_FORCEALIGN | FS_XFLAG_WRITE_ATOMIC;
fsxattr.fsx_extsize = 16384; /* only for hardware no-tears writes */

ioctl(fd, FS_IOC_SETXATTR, &fsxattr);

statx(fd, "", AT_EMPTY_PATH, STATX_ALL | STATX_WRITE_ATOMIC, &statx);

if (statx.stx_atomic_write_unit_max >= 16384) {
	pwrite(fd, &iov, 1, 0, RWF_SYNC | RWF_ATOMIC);
	printf("HAPPY DANCE\n");
}

(Assume we bail out on errors.)

--D

