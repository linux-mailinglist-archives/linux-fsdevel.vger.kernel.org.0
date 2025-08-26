Return-Path: <linux-fsdevel+bounces-59149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A973B35051
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 02:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741191A86BDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 00:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F3260580;
	Tue, 26 Aug 2025 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxQAAgz8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6920C00C;
	Tue, 26 Aug 2025 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168629; cv=none; b=FZwEnSidsNEfwb6u9Ye8iYc3VD/S7RlkNSkKvxlQyz6fb/dfflOh9fNCo6urmQGcwU1K7UfJdDRg0sXKHcQuBvAI74ZmmI7qrtdCzdJdSSlW8Y4K6ZG9lp8x07ZZX5Crs3ejXZ90LD3sJpiIiLuXjxtHQr6RMibgns/aNkSCICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168629; c=relaxed/simple;
	bh=FDd/4IXM62tcCicaUYpTLH9BI9rXkvWPbCfhpSgPpyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY9+wgL8L3s9KoIORTVJehrxnnMMthDDJUhZbRkhbmCtOjzYDspT5YcCISVHmPddv0V+9JG6zDdUKo0zM/DdYCUVoPuRPCb8odKRwgK3NTk37Ed5QzfL+R1heQPkNqFU3yEZtkHOLZvE1IBM2N5twBxqzlMbElCKceaWPImWdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxQAAgz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB0AC4CEED;
	Tue, 26 Aug 2025 00:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756168628;
	bh=FDd/4IXM62tcCicaUYpTLH9BI9rXkvWPbCfhpSgPpyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxQAAgz8f33ttHUUkyezbXJfTzNL5GhIZA5vjIq/TfABocnOF6i1WnNvp/ULXH+OT
	 lF2RzXstJ1Flcr/oJ2WwW3wYUXWJfwvj/1rvezR4tO0EFm+YSSlNS+jdO68WKGILr1
	 jwpSfD0UGKxMAruTgzCYihmIoFgTt42+V6A/8d7MLAJe4MuUEm47YH0DJM//O36pxX
	 kprYgatQTjx1PE5QAdMc8bRoeFVquev/o1Vv9O4+OPPYAkjzDPcrv/IMmJhxvWY2/w
	 vIyu/VQT1DoiHnRkLYVNcW1YgeXNZ58LMTcC5tzx7dxaRRJyGKQT5kdHXaVKEO9aGL
	 Q2SC2Mzp0XXKQ==
Date: Mon, 25 Aug 2025 18:37:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCHv3 3/8] block: align the bio after building it
Message-ID: <aK0Bsf6AKL8a0wFy@kbusch-mbp>
References: <20250819164922.640964-1-kbusch@meta.com>
 <20250819164922.640964-4-kbusch@meta.com>
 <20250825074744.GF20853@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825074744.GF20853@lst.de>

On Mon, Aug 25, 2025 at 09:47:44AM +0200, Christoph Hellwig wrote:
> Also with this we should be able to drop the iov_iter_alignment check
> for always COW inodes in xfs_file_dio_write.  If you don't feel like
> doing that yourself I can add it to my todo list.

I'm unsure about the commit that introduced that behavior, so I think
you should remove it if you know its okay. :)

Specifically, we have this in the comments and commit message:

  check the alignment of each individual iovec segment, as they could
  end up with different I/Os due to the way bio_iov_iter_get_pages works 

bio_iov_iter_get_pages() might submit the segments as separate IO's
anyway for other reasons. I am not sure why the alignment conditions are
handled specifically here.

