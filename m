Return-Path: <linux-fsdevel+bounces-31934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD22C99DD5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 07:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63799B21BCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 05:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE23175D34;
	Tue, 15 Oct 2024 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XF9TDcO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA754409;
	Tue, 15 Oct 2024 05:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728968715; cv=none; b=HehRw+5265yuiiHz4TrFLDBKTbhBnvgS7yMM8LKrNyFDIM4LnfRN4IPUJ7CER3SHIHynQ0NwE09gDHbCzVAkK0YbpIV+dN6jgMkSQUYVmj8MWdFjMgNx4UVYK5dOJvIfCVczxmwfyQPVkyVQpxbn2+bXWZaegVF1G+6tQRVQXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728968715; c=relaxed/simple;
	bh=RbAhWTuItMFAIA6NkLv3EHzhAomLVnEWgdUI6fHnAPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj6wEMZ78TaCocs6YSyASegmA1PotN2OpK9VVb5+Zi5QnTz561tcKSClLUZI8ytLFCcz29mdDy7oS1T0mSNkjx/xwAelp6g1ys5hW9lrN9KFJ6qQ+H0LYgLRI7T9vNpzjWVKUDlboRAtO6VOdbh8xH2boeqBLF2GCMb2umGdtGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XF9TDcO6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DqxxBECG3Qf88WApnQ1vcQdv3I7w3KQjljwDOi/y3Xs=; b=XF9TDcO6Za8S1oiBOylCVyR5V5
	nHW+XZdzQdT7KB9UgNT5KET1gb9E7iQsbIXNCrjn49afBnB0BBshKoQ8JhGzffvuULJVxcljKU/RF
	Gvc8YnLkvG+wv4pyV5W9/NO0CbwGP7diZi3uRppbWYHAI46HMFbekx3bKFbakfbBWx2Cu2rKAtrj7
	z9BMulMkudBQnqDx5eOXp18jgKAy7cwW5LPN+avqj7cjiZfizZ6XdI5plCKZvG2hhZR26PWISFZOn
	9ZBGE1kP7wjfQu7LtS6BUafyJ544RPFVnIjL5068yRdndEjJ8NiNOHK4PZL9S3o3MWaASi7mHaVDz
	nvBCH+rw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Zk8-0000000752W-3q98;
	Tue, 15 Oct 2024 05:05:12 +0000
Date: Mon, 14 Oct 2024 22:05:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daeho43@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: introduce device aliasing file
Message-ID: <Zw34CMxJB-THlGW0@infradead.org>
References: <20241010192626.1597226-1-daeho43@gmail.com>
 <ZwyyiG0pqXoBFIW5@infradead.org>
 <CACOAw_yvb=jacbXVr76bSbCEcud=D1vw5rJVDO+TjZbMLYzdZQ@mail.gmail.com>
 <Zw1J30Fn48uYCwK7@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw1J30Fn48uYCwK7@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 14, 2024 at 04:42:07PM +0000, Jaegeuk Kim wrote:
> > 
> > Plz, refer to this patch and the description there.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=8cc4e257ec20bee207bb034d5ac406e1ab31eaea
> 
> Also, I added this in the description.
> 
> ---
>     For example,
>     "mkfs.f2fs -c /dev/block/test@test_alias /dev/block/main" gives
>     a file $root/test_alias which carves out /dev/block/test partition.

What partition?

So mkfs.f2fs adds additional devices based on the man page.

So the above creates a file system with two devices, but the second
device is not added to the general space pool, but mapped to a specific
file?  How does this file work.  I guess it can't be unlinked and
renamed.  It probably also can't be truncated and hole punched,
or use insert/collapse range.  How does the user find out about this
magic file?  What is the use case?  Are the exact semantics documented
somewhere?


