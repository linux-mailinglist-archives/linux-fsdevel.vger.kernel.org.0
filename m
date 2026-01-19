Return-Path: <linux-fsdevel+bounces-74420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CCD3A2D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95A8D306E0EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A78A355059;
	Mon, 19 Jan 2026 09:22:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15621355039;
	Mon, 19 Jan 2026 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814546; cv=none; b=N+zdTjCvu7CwkW0zaoOey+9/5lWv9Q30miqg/nHxiAjzJ82GhPBOlv43tY/mWI2NGYkhASE5tbcRAb3negq35GlLl9XKknCGlLQ6Nl/bqtlx4EHxfZPH1mJ//5xo4oN4kKG0JFDsOwZAhh6+mBQ0dzIoMnNN6r3LGXaVaTzoBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814546; c=relaxed/simple;
	bh=gm9SNOlFI3fugreHZxci+vNCcUANnFLoT4H7mH5aQUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVdIZPNfISqIiOaLTtSH+isTRvWFyuq3zbHAyC1f2zr+D7xPyJ7BaqnngX/+/4uWIur25tVKdlOMGtpsALUQgra4+eFlfL8TraW87B3aehxNPSz/zzgohU8+fTDV59oczq2zdrYUvCOcpqHJs/SvYSBjfz5QXRNqwWaHofbrIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D93E8227A88; Mon, 19 Jan 2026 10:22:20 +0100 (CET)
Date: Mon, 19 Jan 2026 10:22:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260119092220.GA9140@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-6-lihongbo22@huawei.com> <20260116154623.GC21174@lst.de> <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com> <20260119072932.GB2562@lst.de> <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com> <20260119083251.GA5257@lst.de> <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 19, 2026 at 04:52:54PM +0800, Gao Xiang wrote:
>> To me this sounds pretty scary, as we have code in the kernel's trust
>> domain that heavily depends on arbitrary userspace policy decisions.
>
> For example, overlayfs metacopy can also points to
> arbitary files, what's the difference between them?
> https://docs.kernel.org/filesystems/overlayfs.html#metadata-only-copy-up
>
> By using metacopy, overlayfs can access arbitary files
> as long as the metacopy has the pointer, so it should
> be a priviledged stuff, which is similar to this feature.

Sounds scary too.  But overlayfs' job is to combine underlying files, so
it is expected.  I think it's the mix of erofs being a disk based file
system, and reaching out beyond the device(s) assigned to the file system
instance that makes me feel rather uneasy.

>>
>> Similarly the sharing of blocks between different file system
>> instances opens a lot of questions about trust boundaries and life
>> time rules.  I don't really have good answers, but writing up the
>
> Could you give more details about the these? Since you
> raised the questions but I have no idea what the threats
> really come from.

Right now by default we don't allow any unprivileged mounts.  Now
if people thing that say erofs is safe enough and opt into that,
it needs to be clear what the boundaries of that are.  For a file
system limited to a single block device that boundaries are
pretty clear.  For file systems reaching out to the entire system
(or some kind of domain), the scope is much wider.

> As for the lifetime: The blob itself are immutable files,
> what the lifetime rules means?

What happens if the blob gets removed, intentionally or accidentally?

> And how do you define trust boundaries?  You mean users
> have no right to access the data?
>
> I think it's similar: for blockdevice-based filesystems,
> you mount the filesystem with a given source, and it
> should have permission to the mounter.

Yes.

> For multiple-blob EROFS filesystems, you mount the
> filesystem with multiple data sources, and the blockdevices
> and/or backed files should have permission to the
> mounters too.

And what prevents other from modifying them, or sneaking
unexpected data including unexpected comparison blobs in?


