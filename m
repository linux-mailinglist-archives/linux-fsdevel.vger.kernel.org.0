Return-Path: <linux-fsdevel+bounces-2531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5412C7E6D16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8406D1C208BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1720311;
	Thu,  9 Nov 2023 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1F200C8;
	Thu,  9 Nov 2023 15:15:39 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB851735;
	Thu,  9 Nov 2023 07:15:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FC6967373; Thu,  9 Nov 2023 16:15:32 +0100 (CET)
Date: Thu, 9 Nov 2023 16:15:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Message-ID: <20231109151531.GC32432@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-4-john.g.garry@oracle.com> <20230929224922.GB11839@google.com> <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org> <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com> <2c929105-7c7f-43c5-a105-42d1813d0e29@acm.org> <yq1r0mctv2d.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1r0mctv2d.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 02, 2023 at 08:28:04PM -0400, Martin K. Petersen wrote:
> 
> Bart,
> 
> > Neither the SCSI SBC standard nor the NVMe standard defines a "minimum
> > atomic write unit". So why to introduce something in the Linux kernel
> > that is not defined in common storage standards?
> 
> >From SBC-5:
> 
> "The ATOMIC TRANSFER LENGTH GRANULARITY field indicates the minimum
> transfer length for an atomic write command."

I would suggest that we don't try to claim any atomic write capability
if this is not a logical block as such devices are completely useless.
In fact I'd add a big warning to the kernel log if a device claims this,
as this breaks all the implicit assumptions that a single logical
block write is atomic.


