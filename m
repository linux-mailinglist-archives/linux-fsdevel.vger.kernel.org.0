Return-Path: <linux-fsdevel+bounces-2585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF07E6DF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFC628123C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDCF208D0;
	Thu,  9 Nov 2023 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27434208AA;
	Thu,  9 Nov 2023 15:46:27 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957EF4EF2;
	Thu,  9 Nov 2023 07:46:26 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB3BF68AA6; Thu,  9 Nov 2023 16:46:19 +0100 (CET)
Date: Thu, 9 Nov 2023 16:46:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <20231109154619.GA3491@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-22-john.g.garry@oracle.com> <20231109153603.GA2188@lst.de> <ZUz98KriiLsM8oQd@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUz98KriiLsM8oQd@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 09, 2023 at 03:42:40PM +0000, Matthew Wilcox wrote:
> That wasn't the model we had in mind.  In our thinking, it was fine to
> send a write that crossed the atomic write limit, but the drive wouldn't
> guarantee that it was atomic except at the atomic write boundary.
> Eg with an AWUN of 16kB, you could send five 16kB writes, combine them
> into a single 80kB write, and if the power failed midway through, the
> drive would guarantee that it had written 0, 16kB, 32kB, 48kB, 64kB or
> all 80kB.  Not necessarily in order; it might have written bytes 16-32kB,
> 64-80kB and not the other three.

I can see some use for that, but I'm really worried that debugging
problems in the I/O merging and splitting will be absolute hell.

