Return-Path: <linux-fsdevel+bounces-52574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8423AE45DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E2317C235
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953FE256C7C;
	Mon, 23 Jun 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ByyeTl2H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127C23AE7C;
	Mon, 23 Jun 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687066; cv=none; b=Cwx1oshvDQ+sqBC7i1F5SJLbkuT/zaI4zQ03G8VT/Za1MK8Odgn2ZUB3FGRUFZ93nLwm1t3AX/5vrhd44AIbMOPmyrxY82AdsND6MqgfIB270F/AN04Azh0emPhuHj1koZZDA+g7YWBekNbz93RkAgBRHmpovHv7k0QC4h+nML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687066; c=relaxed/simple;
	bh=X6l6rHnZjhgZ4F9ZAxMc1L7GLtVWlRLp6zjCRPKvQHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToSHf5QKJW56lUmJjzv5MEN2J3IFTJ9Nq2Uu2OEnLTPxFtCg5Oca6jrt5sRmtd2slOTMciHBlmUUkDFnsuqEvD2puO/AbfCyfHctLJxT7wWx/W2SduDDpIqeMGuRnwF4SklJlQbtsHIqPPpRH7tgeaZ/18Y8vvNGnSX539Vgi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ByyeTl2H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j1KXj6uYvxT8W68G8QL0tyZFcefa8P4zdZfm+ieGFKM=; b=ByyeTl2Hgyh7dB8ph9sToUzDCh
	vggv7yivvkxhd/+JRIIK6sFYPgltzkZmUH2aDkwMBT7VAxu/cWdNxlC9/6KwxJuSuTSccsBWC3Kpk
	kex4lrPRqPzOk5T2neZ2b5mFYgFByRi4y1dXPVbE+4xjQSalz/nh8MuiHf7pprIZTMQVSxCIST2fI
	96vO95i1MsNIARPgCavwoO3ar2sF6GXIv5hpq1peUh1hX0pY2rnM5CbCf7vVqdZh4AOYx7kKpESCi
	oatRjnz7O2GNeoUzwhdS7sbrEU1sJcYRvshCxGfsJ28a46M1P6MafXnTh6vQ+CJt9wVinODroS07P
	NXax3Ckw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThg8-00000002xHi-0QWy;
	Mon, 23 Jun 2025 13:57:44 +0000
Date: Mon, 23 Jun 2025 06:57:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <aFldWPte-CK2PKSM@infradead.org>
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-worte-idolisieren-75354608512a@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 23, 2025 at 12:56:28PM +0200, Christian Brauner wrote:
>         void (*shutdown)(struct super_block *sb);
> +       void (*drop_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
>  };
> 
> You might want to drop a block device independent of whether the device
> was somehow lost. So I find that a bit more flexible.

Drop is weird word for what is happening here, and if it wasn't for the
context in this thread I'd expect it to be about refcounting in Linux.

When the VFS/libfs does an upcall into the file system to notify it
that a device is gone that's pretty much a device loss.  I'm not married
to the exact name, but drop seems like a pretty bad choice.

