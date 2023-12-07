Return-Path: <linux-fsdevel+bounces-5276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B21809609
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3522A1C20BEF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962EF57313
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tppyVkt+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1372840D1;
	Thu,  7 Dec 2023 22:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD55C433C8;
	Thu,  7 Dec 2023 22:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701987063;
	bh=owo6bnnED6QeAF4jCGD0GhdYal2c3YorYom6gpqHC54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tppyVkt+uSUWNz1yM9m3lBkynKdULc6QiEocxVGKnIK7zwihFGEkUoLDjdJa5nRgz
	 POQeoPnDYEktP9O3/4K2LmOrSRxqO58RxgkNlIdFIAEPUULM2MJ5belh8pzTJrXimu
	 n8DjYLo1VLChkpGLPYzJF0k3/BZLFRS9ZuHytzNYmtEGg505s+37dirWq04AtYyobl
	 Zwlyr+mCJB1y8XBtTSe8RIfjY1gDZ5om5FUvt+F2D+sZ8umTWMk5UzLqlGs+BPdK61
	 Vb2IZui2whpRNVdZuJrv/cT4D2Wq+q3NmYAEdEwmxOTcuD4LJ/Il85oVC0bOeWlVYR
	 bUHqEAMr7Wbwg==
Date: Thu, 7 Dec 2023 14:11:01 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/3] block: Rework bio_for_each_folio_all(), add
 bio_for_each_folio()
Message-ID: <20231207221101.GA1160@sol.localdomain>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
 <20231122232818.178256-2-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122232818.178256-2-kent.overstreet@linux.dev>

On Wed, Nov 22, 2023 at 06:28:14PM -0500, Kent Overstreet wrote:
> This reimplements bio_for_each_folio_all() on top of the newly-reworked
> bvec_iter_all, and adds a new common helper biovec_to_foliovec() for
> both bio_for_each_folio_all() and bio_for_each_folio().
> 
> This allows bcachefs's private bio_for_each_folio() to be dropped.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  drivers/md/dm-crypt.c        | 13 +++---
>  drivers/md/dm-flakey.c       |  7 +--
>  fs/bcachefs/fs-io-buffered.c | 38 ++++++++-------
>  fs/bcachefs/fs-io.h          | 43 -----------------
>  fs/crypto/bio.c              |  9 ++--
>  fs/ext4/page-io.c            | 11 +++--
>  fs/ext4/readpage.c           |  7 +--
>  fs/iomap/buffered-io.c       | 14 +++---
>  fs/mpage.c                   | 22 +++++----
>  fs/verity/verify.c           |  7 +--
>  include/linux/bio.h          | 91 ++++++++++++++++++------------------
>  include/linux/bvec.h         | 15 ++++--
>  12 files changed, 127 insertions(+), 150 deletions(-)

Acked-by: Eric Biggers <ebiggers@google.com>

- Eric

