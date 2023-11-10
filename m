Return-Path: <linux-fsdevel+bounces-2696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C797E7938
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 07:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7C22817E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 06:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADA263C0;
	Fri, 10 Nov 2023 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4863A3;
	Fri, 10 Nov 2023 06:23:32 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1618F6F81;
	Thu,  9 Nov 2023 22:23:31 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1E8068AA6; Fri, 10 Nov 2023 07:23:25 +0100 (CET)
Date: Fri, 10 Nov 2023 07:23:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 01/21] block: Add atomic write operations to
 request_queue limits
Message-ID: <20231110062325.GB26516@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-2-john.g.garry@oracle.com> <20231109151013.GA32432@lst.de> <b7f1b93a-08ea-07c8-d1da-5c2a31d1be80@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f1b93a-08ea-07c8-d1da-5c2a31d1be80@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 09, 2023 at 05:01:10PM +0000, John Garry wrote:
> Generally they come from the same device property. Then since 
> atomic_write_unit_max_bytes must be a power-of-2 (and 
> atomic_write_max_bytes may not be), they may be different.

How much do we care about supporting the additional slack over the
power of two version?  

> In addition, 
> atomic_write_unit_max_bytes is required to be limited by whatever is 
> guaranteed to be able to fit in a bio.

The limit what fits into a bio is UINT_MAX, not sure that matters :)

> atomic_write_max_bytes is really only relevant for merging writes. Maybe we 
> should not even expose via sysfs.

Or we need to have a good separate discussion on even supporting any
merges.  Willy chimed in that supporting merges was intentional,
but I'd really like to see numbers justifying it.


