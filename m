Return-Path: <linux-fsdevel+bounces-4028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769367FBC00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 14:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326002828A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7416F59B65;
	Tue, 28 Nov 2023 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F58D1;
	Tue, 28 Nov 2023 05:56:25 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6897227A87; Tue, 28 Nov 2023 14:56:19 +0100 (CET)
Date: Tue, 28 Nov 2023 14:56:19 +0100
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
Message-ID: <20231128135619.GA12202@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-18-john.g.garry@oracle.com> <20231109152615.GB1521@lst.de> <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com> <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 28, 2023 at 08:56:37AM +0000, John Garry wrote:
> Are you suggesting some sort of hybrid between the atomic write series you 
> had a few years ago and this solution?

Very roughly, yes.

> To me that would be continuing with the following:
> - per-IO RWF_ATOMIC (and not O_ATOMIC semantics of nothing is written until 
> some data sync)

Yes.

> - writes must be a power-of-two and at a naturally-aligned offset

Where offset is offset in the file?  It would not require it.  You
probably want to do it for optimal performance, but requiring it
feeels rather limited.

> - relying on atomic write HW support always

And I think that's where we have different opinions.  I think the hw
offload is a nice optimization and we should use it wherever we can.
But building the entire userspace API around it feels like a mistake.

> BTW, we also have rtvol support which does not use forcealign as it already 
> can guarantee alignment, but still does rely on the same principle of 
> requiring alignment - would you want CoW support there also?

Upstream doesn't have out of place write support for the RT subvolume
yet.  But Darrick has a series for it and we're actively working on
upstreaming it.

