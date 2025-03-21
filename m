Return-Path: <linux-fsdevel+bounces-44733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F14A6C2D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 19:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067697A5B62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CA11EE7DF;
	Fri, 21 Mar 2025 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mciTbD0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF574B664;
	Fri, 21 Mar 2025 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583355; cv=none; b=uVVCPKgc1kmkZQrBshRyVl989Y/5RRGCsDKp4dM+tMh99/ApvmUEbpNsLRUGeTnZI/dtp97BywN5uMvEt2DWS3PjYHIkV0wtfvrZ2fw+WQrt/w/iHTb5juxVW1YDE3YrQ2eX3H5ubuoHVmU+/B5Yayg6nVM9XZ+Wz8IpLxYZQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583355; c=relaxed/simple;
	bh=w12rCUpRRlnFTNDJ/U+SOBnCtlzfICVSlsh9Ym7O+N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgCX2+206H9aW69C8ChVCRUWD2d2gQBWR2BXAan4OT+7V9XtyUXnmUnLhDF0bfZIIkqkRg1T3pksoJfYaXVOGO70WZWfRYr5gPItoxN+HiwUibMMA7Gf35BtVc5LJZ/KKIz6I4BTpSyQJt6gOSmbKEZAkaQzCi7O0eNkCsKdHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mciTbD0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2523EC4CEE3;
	Fri, 21 Mar 2025 18:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742583354;
	bh=w12rCUpRRlnFTNDJ/U+SOBnCtlzfICVSlsh9Ym7O+N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mciTbD0QQWuzPYUfOwXAUqDo8vvOxxP4h1FybYtQps1Ml6nc6+GuqlUuaq474IyCb
	 qPVXquzW/I8Lqh2hW1ldeU8dvn9TcssCJ3Z5EzFodUAdD8ZZVjTFvMKDb7PdJx4NfC
	 oN3Kq6g5leHeKGI41L4kjf/3RzKH+M4PqM/M1WfDS+tqTlVOrjEtCKqn7IF3z1PENf
	 q49KujEicQYs5UW5Pagu/nx2tJ4mbcovq0jbMskM/JRnmWEsGj8MCi+3lgvxwmBSeH
	 H463quHsqCTgSJNNDMrWLsaYihg9lfrjI29jYFMGiM8U7tL4LAXO1S5OWKSTQq+Ox1
	 q5tHryGzSQmZQ==
Date: Fri, 21 Mar 2025 12:55:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, david@fromorbit.com,
	leon@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, john.g.garry@oracle.com, p.raghav@samsung.com,
	gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <Z922NlB1Q9jv8KpB@kbusch-mbp>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <87o6xvsfp7.fsf@gmail.com>
 <20250320213034.GG2803730@frogsfrogsfrogs>
 <87jz8jrv0q.fsf@gmail.com>
 <Z92WBePJ620r5-13@kbusch-mbp>
 <87frj6s3ix.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frj6s3ix.fsf@gmail.com>

On Fri, Mar 21, 2025 at 10:51:42PM +0530, Ritesh Harjani wrote:
> Keith Busch <kbusch@kernel.org> writes:
> 
> > On Fri, Mar 21, 2025 at 07:43:09AM +0530, Ritesh Harjani wrote:
> >> i.e. w/o large folios in block devices one could do direct-io &
> >> buffered-io in parallel even just next to each other (assuming 4k pagesize). 
> >> 
> >>            |4k-direct-io | 4k-buffered-io | 
> >> 
> >> 
> >> However with large folios now supported in buffered-io path for block
> >> devices, the application cannot submit such direct-io + buffered-io
> >> pattern in parallel. Since direct-io can end up invalidating the folio
> >> spanning over it's 4k range, on which buffered-io is in progress.
> >
> > Why would buffered io span more than the 4k range here? You're talking
> > to the raw block device in both cases, so they have the exact same
> > logical block size alignment. Why is buffered io allocating beyond
> > the logical size granularity?
> 
> This can happen in following 2 cases - 
> 1. System's page size is 64k. Then even though the logical block size
> granularity for buffered-io is set to 4k (blockdev --setbsz 4k
> /dev/sdc), it still will instantiate a 64k page in the page cache.

But that already happens without large folio support, so I wasn't
considering that here.
 
> 2. Second is the recent case where (correct me if I am wrong) we now
> have large folio support for block devices. So here again we can
> instantiate a large folio in the page cache where buffered-io is in
> progress correct? (say a previous read causes a readahead and installs a
> large folio in that region). Or even iomap_write_iter() these days tries
> to first allocate a chunk of size mapping_max_folio_size().
 
Okay, I am also not sure on what happens for this part on speculative
allocations.

