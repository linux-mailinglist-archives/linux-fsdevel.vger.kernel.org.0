Return-Path: <linux-fsdevel+bounces-7797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6865482B0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 15:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164AB28703F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B61E4B5B4;
	Thu, 11 Jan 2024 14:45:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92D3BB29;
	Thu, 11 Jan 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 783DE68CFE; Thu, 11 Jan 2024 15:45:38 +0100 (CET)
Date: Thu, 11 Jan 2024 15:45:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>, axboe@kernel.dk,
	kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com, bvanassche@acm.org,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240111144537.GA9295@lst.de>
References: <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com> <ZZ3Q4GPrKYo91NQ0@dread.disaster.area> <20240110091929.GA31003@lst.de> <20240111014056.GL722975@frogsfrogsfrogs> <20240111050257.GA4457@lst.de> <d5db2291-36b4-4b22-89f2-1d9e7d30f0f1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5db2291-36b4-4b22-89f2-1d9e7d30f0f1@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 11, 2024 at 09:55:36AM +0000, John Garry wrote:
> On 11/01/2024 05:02, Christoph Hellwig wrote:
>> On Wed, Jan 10, 2024 at 05:40:56PM -0800, Darrick J. Wong wrote:
>>> struct statx statx;
>>> struct fsxattr fsxattr;
>>> int fd = open('/foofile', O_RDWR | O_DIRECT);
>
> I'm assuming O_CREAT also.

Yes.

>> I think this still needs a check if the fs needs alignment for
>> atomic writes at all. i.e.
>>
>> struct statx statx;
>> struct fsxattr fsxattr;
>> int fd = open('/foofile', O_RDWR | O_DIRECT);
>>
>> ioctl(fd, FS_IOC_GETXATTR, &fsxattr);
>> statx(fd, "", AT_EMPTY_PATH, STATX_ALL | STATX_WRITE_ATOMIC, &statx);
>> if (statx.stx_atomic_write_unit_max < 16384) {
>> 	bailout();
>> }
>
> How could this value be >= 16384 initially? Would it be from pre-configured 
> FS alignment, like XFS RT extsize? Or is this from some special CoW-based 
> atomic write support? Or FS block size of 16384?

Sorry, this check should not be here at all, we should only check it
later.

> Incidentally, for consistency only setting FS_XFLAG_WRITE_ATOMIC will lead 
> to FMODE_CAN_ATOMIC_WRITE being set. So until FS_XFLAG_WRITE_ATOMIC is set 
> would it make sense to have statx return 0 for STATX_WRITE_ATOMIC. 

True.  We might need to report the limits even without that, though.


