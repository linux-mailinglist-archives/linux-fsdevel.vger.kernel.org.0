Return-Path: <linux-fsdevel+bounces-27508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FEA961D4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A47B1C21E61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0362145A18;
	Wed, 28 Aug 2024 04:06:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937764A;
	Wed, 28 Aug 2024 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817999; cv=none; b=BzYBYK9OlmYqgnt5hXlgrPd+wLA7VpMQKu3o2ZIBv6hxD1GSDM3r4P0NVTVnzlVb1owWB7nCvSVKcT9DDCVx9/VdfAF3CCCu6rmczyW9f0fszCQ0LpFIOgVo2+TeZjZmIROVFYdRJz4ne33h3iVH1gIk7YTaqxrzAJJEQEAB2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817999; c=relaxed/simple;
	bh=sCAvIbr54ICkdbyZ5cMqsophKWn1U5ISIMo8P5HOWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZST2C7KiPLg968lgmXaRQ51Bn1hFJdrI58+qHyHT3XsLrpnFaa3xocbwbQDlf9NXn2zri/LbxGSlid4rsg67GmrpV7KrUVZ7U2zk/ZfR5Lq3W+xQyPHjlcLaXvWC7MTWFyELDA8cqmTQ28BUr9i8eEDC3HP59AY16DbhE0kzm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DB1B227A88; Wed, 28 Aug 2024 06:06:34 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:06:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/6] xfs: call xfs_flush_unmap_range from
 xfs_free_file_space
Message-ID: <20240828040633.GC30409@lst.de>
References: <20240827065123.1762168-1-hch@lst.de> <20240827065123.1762168-5-hch@lst.de> <20240827160323.GS865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827160323.GS865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 09:03:23AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 27, 2024 at 08:50:48AM +0200, Christoph Hellwig wrote:
> > Call xfs_flush_unmap_range from xfs_free_file_space so that
> > xfs_file_fallocate doesn't have to predict which mode will call it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Hmm.  I /think/ it's ok to shift the xfs_flush_unmap_range after the
> file_modified and some of the other EINVAL bailouts that can happen
> before xfs_free_file_space gets called.  Effectively that means that we
> can fail faster now? :)

Yes, failing faster has always been my personal benchmark :)


