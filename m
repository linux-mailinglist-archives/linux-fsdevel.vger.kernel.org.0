Return-Path: <linux-fsdevel+bounces-59433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43105B38A28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 21:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728591BA834A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991502E2283;
	Wed, 27 Aug 2025 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTzCbjET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28FFEEBB;
	Wed, 27 Aug 2025 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322460; cv=none; b=oXNcqPyGBzcJ+DFTarQzULPhgK6v7EU6EC2Lpq9kH+r4IHEbsSZOnl5l354HQ8wdFe3u/x8MXBu5p5x7WCLqonFcleb82XOmnzFzQfxCwZlDKwFAdhrwK5/CqHHHoovlkyy49Mxl+X6oL7O9hcWBREX76DgYuD2uYPjCBw2FN9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322460; c=relaxed/simple;
	bh=HqoUEwPRZUgZWft08BFGL1tvczLn9C8wVr1nlcGbbqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In0oduI06FD8oS2qT4LAWzT3oozAReHFaD5moHGIgkp2KjAJzMKmNuXmZ0temvx9J/ET7juBgLl/4wwqy5BrW6mq1Du8o1sEN2otXIEhcDLSjfS3wte5ApWspSTEzjD1pJJ0vmFm1khodI424FC/A0OrMRFwD6EZes7uqDFbTZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTzCbjET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985A8C4CEF4;
	Wed, 27 Aug 2025 19:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756322459;
	bh=HqoUEwPRZUgZWft08BFGL1tvczLn9C8wVr1nlcGbbqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTzCbjET+YqwvhhB5C+6ern478N8Fibdl9q7wolppv5cftBwlgzBm6myWn7ltnANh
	 OHPic8rFMMKMbNylLc/tVvZ341T8jg6ppyhqYMzLCtU4P2piSoCpeZbWOoleOyA3D+
	 wZEyBQbLEpxyHdMubNoAi5SxCAVGHgBxPC1WP3R/TSOMFfxdZRFn7g8QEnXoYfKDcH
	 x/9y+gPeaEFzWB3BC5J/1R1hFp9MCwZubZe7AzUrofL/3yORfP/jFc/oFl7soPkyAy
	 xBCf6arWTCssp0Eo+Bwfn1JDUxeBDIImlLoUUDQK8J8xsPdMOZTtS2izg+4ojzx8CY
	 RrMsoQlKMEydg==
Date: Wed, 27 Aug 2025 13:20:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com,
	djwong@kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, Jan Kara <jack@suse.com>,
	Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
Message-ID: <aK9amCpLYsxIweMk@kbusch-mbp>
References: <20250819164922.640964-1-kbusch@meta.com>
 <87a53ra3mb.fsf@gmail.com>
 <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq>
 <aKx485EMthHfBWef@kbusch-mbp>
 <87cy8ir835.fsf@gmail.com>
 <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>

On Wed, Aug 27, 2025 at 05:20:53PM +0200, Jan Kara wrote:
> Now both the old and new behavior make some sense so I won't argue that the
> new iomap_iter() behavior is wrong. But I think we should change ext4 back
> to the old behavior of failing unaligned dio writes instead of them falling
> back to buffered IO. I think something like the attached patch should do
> the trick - it makes unaligned dio writes fail again while writes to holes
> of indirect-block mapped files still correctly fall back to buffered IO.
> Once fstests run completes, I'll do a proper submission...

Your suggestion looks all well and good, but I have a general question
about fstests. I've written up some to test this series, and I have
filesystem specific expectations for what should error or succeed. If
you modify ext4 to fail direct-io as described, my test will have to be
kernel version specific too. Is there a best practice in fstests for
handling such scenarios?

