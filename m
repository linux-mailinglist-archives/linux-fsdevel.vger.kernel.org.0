Return-Path: <linux-fsdevel+bounces-4774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA379803701
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F951F212A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3412511F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B503BDF;
	Mon,  4 Dec 2023 05:45:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4613D68B05; Mon,  4 Dec 2023 14:45:10 +0100 (CET)
Date: Mon, 4 Dec 2023 14:45:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Message-ID: <20231204134509.GA25834@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-18-john.g.garry@oracle.com> <20231109152615.GB1521@lst.de> <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com> <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com> <20231128135619.GA12202@lst.de> <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 28, 2023 at 05:42:10PM +0000, John Garry wrote:
> ok, fine, it would not be required for XFS with CoW. Some concerns still:
> a. device atomic write boundary, if any
> b. other FSes which do not have CoW support. ext4 is already being used for 
> "atomic writes" in the field - see dubious amazon torn-write prevention.

What is the 'dubious amazon torn-write prevention'?

> About b., we could add the pow-of-2 and file offset alignment requirement 
> for other FSes, but then need to add some method to advertise that 
> restriction.

We really need a better way to communicate I/O limitations anyway.
Something like XFS_IOC_DIOINFO on steroids.

> Sure, but to me it is a concern that we have 2x paths to make robust a. 
> offload via hw, which may involve CoW b. no HW support, i.e. CoW always

Relying just on the hardware seems very limited, especially as there is
plenty of hardware that won't guarantee anything larger than 4k, and
plenty of NVMe hardware without has some other small limit like 32k
because it doesn't support multiple atomicy mode.

> And for no HW support, if we don't follow the O_ATOMIC model of committing 
> nothing until a SYNC is issued, would we allocate, write, and later free a 
> new extent for each write, right?

Yes. Then again if you do data journalling you do that anyway, and as
one little project I'm doing right now shows that data journling is
often the fastest thing we can do for very small writes.

