Return-Path: <linux-fsdevel+bounces-55825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E400B0F291
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9171C83C5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD72E716E;
	Wed, 23 Jul 2025 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2DVNzbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1922E6D01;
	Wed, 23 Jul 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275093; cv=none; b=hQFpC/yXvBCXH2+972peuQh9DTCTX7VT5egLpwF/tTTBK+9cO/JJ8vFylS+5Oelw8l+OYPYWDHbSN3yklsvXwdC61e769DL4rHmitp+PC4gUu1LIyaY4ROeDQNy7XlrFv3eoqXHluXnzPmnKjU6qlIzNznhs+cxjJx1VHH/yu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275093; c=relaxed/simple;
	bh=3vsz1vnDsctpYDdgLRTI/E0dtYiDsUBLlhMOZ/S9IpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJYfZd9f5LWQ34ixk95WVmkmfmHg9GzpCftWqzTJ0YOv04zdxIFDfva8v4MLfSMLSt6jfD4ptW7dfT5PdfmMm86fvSbfS4f2yjVRnUPFBwGtVEKxLlErEBkPB7PbqwdYHV6+dZZno+H5z+XvKtnCtHWB6sAdAbsY9jC4UfHXoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2DVNzbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAABC4CEE7;
	Wed, 23 Jul 2025 12:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753275092;
	bh=3vsz1vnDsctpYDdgLRTI/E0dtYiDsUBLlhMOZ/S9IpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2DVNzbzGjiYmm1a3Gz8o9f01Nx+il70NK8MkWw8cywX5QSfxgxdGx0LyaiHhMMkV
	 aXkG1wvdoiS+SpeZuygJO4S4yoJDFCnERbJQds6O1x9WNEQEmY9qgIQZMUBwPWDBW+
	 kwhazX4FjnJ456sGVIqsgF7UZbG2rISIrXXQitQ7hJ3PPllac/jUKqOm9t5m1UJ3fY
	 TQbSHsuaZQLwbqnGB/5qcibIg8C1/5dc3T/3NnkcLkh68yc1Ixm/8PazU1jTcQgpCC
	 NPluosHH1I41xVKrQrE8q73ct9CXqsvgBAfFUkjcR1YcaxL9WpjAbyv8eQhN618bwn
	 GpUDVmdodTg1g==
Date: Wed, 23 Jul 2025 14:51:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zizhi Wo <wozizhi@huaweicloud.com>, kernel test robot <lkp@intel.com>, 
	viro@zeniv.linux.org.uk, jack@suse.com, axboe@kernel.dk, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] fs: Add additional checks for block devices during mount
Message-ID: <20250723-heizperiode-fotoreporter-2ada7fe78028@brauner>
References: <20250719024403.3452285-1-wozizhi@huawei.com>
 <202507192025.N75TF4Gp-lkp@intel.com>
 <b60e4ef2-0128-4e56-a15f-ea85194a3af0@huaweicloud.com>
 <20250721064712.GA28899@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721064712.GA28899@lst.de>

On Mon, Jul 21, 2025 at 08:47:12AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 21, 2025 at 09:20:27AM +0800, Zizhi Wo wrote:
> > Sorry, disk_live() is only declared but not defined when CONFIG_BLOCK is
> > not set...
> 
> You can just add a if (IS_ENABLED(CONFIG_BLOCK)) check around it.
> 
> 
> But the layering here feels wrong.  sget_dev and it's helper operate
> purely on the dev_t.  Anything actually dealing with a block device /
> gendisk should be in the helpers that otherwise use it.

Either we add a lookup_bdev_alive() variant that checks whether the
inode is still hashed when looking up the dev_t and we accept that this
deals with the obvious cases and accept that this is racy...

Or we add lookup_bdev_no_open() that returns the block device with the
reference bumped, paired with lookup_bdev_put_no_open(). Afaiu, that
would prevent deletion. We could even put this behind a
guard(bdev_no_open)(fc->source). The reference count bump shouldn't
matter there. Christoph?

