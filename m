Return-Path: <linux-fsdevel+bounces-46849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F126FA957A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 22:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FA63A543C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69B1F12EF;
	Mon, 21 Apr 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxNlWAm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A38BEA;
	Mon, 21 Apr 2025 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269032; cv=none; b=QTCozUQiP1b3mzSibQ5bm9SiD+ZNGjVbKmZmpBPeIK/0LFAw25F+i8+2lxwXNMcCKgeTKu6UHordF2RV+FeIkSczV+eS6JW3a52fDRl3NYfevb6a5ekKqaveFRTdbfDEZTjM+F0SAXfdcF5saY0qZ4pVykj0zqRY/mX3Oi51N4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269032; c=relaxed/simple;
	bh=1h/sz4swhabWhNj9c1KGcXz8lkZ11rJwJ0vuy/TXhEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLx+b1NFs1SYzSmQMyHzF2qEMnvLIyEUHZMzOUGTc6WulFyu7z2/efuQ57OPgb86p9ifHOhQyY/4e0y+RrqXvmmvGXoLYGXHKxM0IEKg5TgprA3n1WhLeOjSIFQXaIbkmI7wAznunPOOAMrrvhhRHl8g2IH7/hG0KJZM3FNB8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxNlWAm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662EEC4CEEA;
	Mon, 21 Apr 2025 20:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745269031;
	bh=1h/sz4swhabWhNj9c1KGcXz8lkZ11rJwJ0vuy/TXhEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxNlWAm4KfhCYgQCgaFKB4UEliHE7UzjvRJMaJjkLnuxAS1L88gX7bPolkX8xQIaB
	 UCx2P7/y8lWPiukToZP8fezB2u33LRk9NdTIZHrJAzhX15pHBj49g5kW+MFMPv/ioM
	 Gd+Lg1FN440qnWNg4YO9TAKv0l1gFSxtwfut6ihiu7fQyrtiLnWe7yRudfI1q0xSSe
	 pKEuw9QXEBQ1VhtOMyEG0HpEMOhcDZLRYfc9PHpVOq3Zu2NF+04Vi9JiZ1vbS9wIyY
	 FoCD3G7Q2oznq1+wqnKWEYfUAYjhwAqOOYUElLfnTtscnH9xqwyBBmKa0HVungcMFf
	 ++TUiRvYqlYVA==
Date: Mon, 21 Apr 2025 13:57:09 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, axboe@kernel.dk, hch@lst.de,
	shinichiro.kawasaki@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	willy@infradead.org, hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCHSET V2] block/xfs: bdev page cache bug fixes for 6.15
Message-ID: <aAaxJXTPkI3yRJOG@bombadil.infradead.org>
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>

On Mon, Apr 21, 2025 at 10:18:45AM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
> between set_blocksize and block device pagecache manipulation; the rest
> removes XFS' usage of set_blocksize since it's unnecessary.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> With a bit of luck, this should all go splendidly.
> Comments and questions are, as always, welcome.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

