Return-Path: <linux-fsdevel+bounces-52471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A1AE34A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 07:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA91891729
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 05:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA061C7015;
	Mon, 23 Jun 2025 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iau/0aIR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778F79CD;
	Mon, 23 Jun 2025 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750655721; cv=none; b=FWvCFG4oOtwMJGlIkeJwv1adb+aMJKEfW9dpUyneex0dzEiI9ioPz5SIATtC1ku2hp1hT5MS4CIkCiC6h9YqWDVo4xzmlRJuQWDJ04EsruQxRilXBJngY4eiU83vKkjLCAGkMHEG4HZvk6zIq2hLyYlf68eIV/kHQq70YYYskG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750655721; c=relaxed/simple;
	bh=6XIekcVZDc4Qi2rplfnqyF1aQ7UN02ejriQjfT3LZo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwR+PqaEPiEmcRYufG1yItzqNROAbkSza6QhxTYP999GeYn4dLbvyaRsU07jyLwXP/NTB1JJORW5q6MQTTB/liTxobybggzGrne91z3jjBteBe7DCr/cP22sgnkz+4MICfxX63lUBEbiHmWQkHWCGJDt6l/+AOb3G/a6TkCI0Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iau/0aIR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yOW1YcPYoq70hrO8NccVHVA7OSBmpuILYqcfTjgdc9k=; b=iau/0aIRAsRYza8VqT1L8YbepC
	ETCMtZmq0JaxEZZUChk0a+cW4E90Z4UQB98SYVFjKSV/oMa7BuHcah7LfZ542hYhfc/MglPWRBibW
	jpWnX7yDR0p57wODFc8BTH2kX1ejAqt+Ow7V1A11y9I2H31K5NRR6XYEcZd6wao8NrIUroBrFuQrI
	MkJlpwzeUva64cYCl7WG+3BIw7FyIqpaP387XqtM+O+t272r/jxKqw+4wbDF+ORVSgjwJi8NOioHI
	5w5PF3Hq38a6UcYN6a7ySUcgznjPxBomcEklXL3P9LLW0EuV2WNYXVFjydhJ+r1bm8sfyL0GRMxDL
	3qdUdKvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZWZ-00000001b5q-1u7b;
	Mon, 23 Jun 2025 05:15:19 +0000
Date: Sun, 22 Jun 2025 22:15:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <aFji5yfAvEeuwvXF@infradead.org>
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 20, 2025 at 05:36:52PM +0200, Jan Kara wrote:
> On Fri 20-06-25 15:17:28, Qu Wenruo wrote:
> > Currently we already have the super_operations::shutdown() callback,
> > which is called when the block device of a filesystem is marked dead.
> > 
> > However this is mostly for single(ish) block device filesystems.
> > 
> > For multi-device filesystems, they may afford a missing device, thus may
> > continue work without fully shutdown the filesystem.
> > 
> > So add a new super_operation::shutdown_bdev() callback, for mutli-device
> > filesystems like btrfs and bcachefs.
> > 
> > For now the only user is fs_holder_ops::mark_dead(), which will call
> > shutdown_bdev() if supported.
> > If not supported then fallback to the original shutdown() callback.
> > 
> > Btrfs is going to add the usage of shutdown_bdev() soon.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks for the patch. I think that we could actually add 'bdev' that
> triggered shutdown among arguments ->shutdown takes instead of introducing
> a new handler.

I don't really think that's a good idea as-is.  The current ->shutdown
callback is called ->shutdown because it is expected to shut the file
system down.  That's why I suggested to Qu to add a new devloss callback,
to describe that a device is lost.  In a file system with built-in
redundancy that is not a shutdown.  So Qu, please add a devloss
callback.  And maybe if we have no other good use for the shutdown
callback we can remove it in favor of the devloss one.  But having
something named shutdown take the block device and not always shutting
the file system down is highly confusing.


