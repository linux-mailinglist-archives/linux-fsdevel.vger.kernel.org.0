Return-Path: <linux-fsdevel+bounces-53079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD4AE9C17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02554A605B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 11:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56623275108;
	Thu, 26 Jun 2025 11:02:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E573273D75;
	Thu, 26 Jun 2025 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935742; cv=none; b=QXi2h/2OqbXDdFqEde/OwpMX5omgM94mLVUh2PC9OUv/sLpksK0pKdK+pzymPjApmVbF+whHILEqH9H5mkcCfRYhP1pndnW0SeCGV9tr2kgou6CmTusPSsIBhaNmfCbb1n7xbITipYR3zbmTperJa9w5M+Rxmzxwk/1lsYPSoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935742; c=relaxed/simple;
	bh=L9a4s9ZdfWCle9GyYoCW8dHji4mRRsM7EbXtZ5LuQHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDkxEDecvrh8CQY3l2peLY6atylRCtQLiqnFG6iA0tLSbE4nH6lz88GmKPjwB02FdNj4Fm6lCCQVXmW2i/3Lh/XPZBotbfreUSnm8dWavP1myCy+X8trsdkNDXHRg2OisPRzMIQBqR+WxPONqWWNAQayOmah0fxjUmay/Rxu/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A357F227AAF; Thu, 26 Jun 2025 13:02:13 +0200 (CEST)
Date: Thu, 26 Jun 2025 13:02:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH 1/6] fs: add a new remove_bdev() super operations
 callback
Message-ID: <20250626110213.GA9693@lst.de>
References: <cover.1750895337.git.wqu@suse.com> <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com> <20250626-schildern-flutlicht-36fa57d43570@brauner> <20250626101443.GA6180@lst.de> <95a2ff19-0525-48ef-9949-c3e585e8ed1f@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a2ff19-0525-48ef-9949-c3e585e8ed1f@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 26, 2025 at 08:06:03PM +0930, Qu Wenruo wrote:
>
> If I understand the @surprise parameter correctly, it should allow the fs 
> to do read/write as usual if it's not a surprise removal.
>
> And btrfs will take the chance to fully writeback all the dirty pages (more 
> than the default shutdown behavior which only writebacks the current 
> transaction, no dirty data pages.).

That's already taken care of by the call to sync_filesystem in
fs_bdev_mark_dead.

> But in the real world, for test case like generic/730, the @surprise flag 
> is either not properly respected, I'm getting @surprise == false but the 
> block device is already gone.

It only works for drivers that call blk_mark_disk_dead or bdev_mark_dead
directly with the surprise flag.

> So I'm not sure what's the real expected behavior here, and the new flag is 
> only for future expansion for now.

Let's not add just in case arguments.


