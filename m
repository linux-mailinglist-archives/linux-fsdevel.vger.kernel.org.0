Return-Path: <linux-fsdevel+bounces-27509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73641961D55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463FD283EEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D77145FFF;
	Wed, 28 Aug 2024 04:07:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F7140E2E;
	Wed, 28 Aug 2024 04:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818025; cv=none; b=DFRTYX5/8sPYpnnNx260BK/TM1+6pKuDkokCqRtQTK32jzqtQsnSFoLfJrMWWLAWiuBvnlKRqC5RevKnFqgZ0Ehn0p5A0Fj3QtNWGK1LAvvPe7/GYofIPhaTkq/j5N698kBgk6EoCh2DZiEhsqa89uZKrgZbUrSH4nRjvQ0txQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818025; c=relaxed/simple;
	bh=IBQOeDh7MqdOxXvyDAGW4G23uanV4ycx38DxbKNzWnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnluvaGpiI549TqI80Jgz8HTyXrjYn/LJlaou1sybYmgAEgGMON7dDHnadMoahSPcJK11ArP+EcBkMdBkOEpAXpBjXze4orK/9RbbXFP3XXiVMR7Xa06i0bR3nQoTFUVKGYHNTyUN3ikUAkgA0DCXMdXJPrl2gMIo04o4gJgl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF574227A88; Wed, 28 Aug 2024 06:07:00 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:07:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: refactor xfs_file_fallocate
Message-ID: <20240828040700.GD30409@lst.de>
References: <20240827065123.1762168-1-hch@lst.de> <20240827065123.1762168-7-hch@lst.de> <20240827160703.GU865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827160703.GU865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 09:07:03AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 27, 2024 at 08:50:50AM +0200, Christoph Hellwig wrote:
> > Refactor xfs_file_fallocate into separate helpers for each mode,
> > two factors for i_size handling and a single switch statement over the
> > supported modes.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Much less complicated now! :)

A little more LOC, though.  But I think that's worth the tradeoff.


