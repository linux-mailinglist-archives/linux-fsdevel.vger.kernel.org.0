Return-Path: <linux-fsdevel+bounces-31661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E199999B30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 05:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2231F24830
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 03:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B139E1F4FB7;
	Fri, 11 Oct 2024 03:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZQvnnmkx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD6D2FB;
	Fri, 11 Oct 2024 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728617336; cv=none; b=bmvN1Q6NYlooLNirc5jeaww3R2OQyA6vAY324wIoL57GIH26Wqg0b0b35ms8/XtSpaVHJxXJBn5/tssCzcItorFQqZ1oMLv3UCrncyqb/kvAW+uhcrZq3Zl3vUfbqQqIvxI+Lop22LdNOCrUNZhkUvZQJjqN9/EMEr5SH3xzeHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728617336; c=relaxed/simple;
	bh=bbH4tgBEeWMgJJQ+U3QLcnUXcIaD6n/yfonjW8G2xoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+f0V5DR7NureJ1JJRigI0W5NmR4eORCTGzvWXlWjF/Opkkzng5RNiav8NxFMpG/kbsOcQaIqoPtZ0BIiWU7RnRGna6DQmGEeVr7+qhj0IX4m4fwtvpMFdJsq76AJluLNzKQkX5PCuRR1n8KlaYklaadv84txzk2yxOtFqQDTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZQvnnmkx; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728617324; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tI/wKSYLVS0XOUgR+ogbOhvoQ1BWdDppLAT+EsC2+hw=;
	b=ZQvnnmkx2Xb2+JkD0ywBfXQlh1bL9OajpDsewtgp5gxP8WzT0GFFd5gdSuBfoqjihW9T8yjwaSEGaAwnLt5IIJOCLamgrhNglIYqfp1PvNUug2LRfSBccDhHwwklBsaR/e6Tk82wyrvqC/Yp2cjZr8hWZ0QEJlt718o8WdFD24g=
Received: from 30.27.66.120(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGoPtng_1728617322 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 11:28:44 +0800
Message-ID: <381c349d-2eb7-419f-a2f8-a41ca6a9e9f0@linux.alibaba.com>
Date: Fri, 11 Oct 2024 11:28:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] iomap: Introduce read_inline() function hook
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.de>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <8147ae0a45b9851eacad4e8f5a71b7997c23bdd0.1728071257.git.rgoldwyn@suse.com>
 <ZwCk3eROTMDsZql1@casper.infradead.org>
 <20241007174758.GE21836@frogsfrogsfrogs>
 <kplkze6blu5pmojn6ikv65qdsccyuxg4yexgkrmldv5stn2mr4@w6zj7ug63f3f>
 <Zwh0rzp8hpCoF/or@dread.disaster.area>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Zwh0rzp8hpCoF/or@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dave,

On 2024/10/11 08:43, Dave Chinner wrote:
> On Thu, Oct 10, 2024 at 02:10:25PM -0400, Goldwyn Rodrigues wrote:

...

> 
> .... there is specific ordering needed.
> 
> For writes, the ordering is:
> 
> 	1. pre-write data compression - requires data copy
> 	2. pre-write data encryption - requires data copy
> 	3. pre-write data checksums - data read only
> 	4. write the data
> 	5. post-write metadata updates
> 
> We cannot usefully perform compression after encryption -
> random data doesn't compress - and the checksum must match what is
> written to disk, so it has to come after all other transformations
> have been done.
> 
> For reads, the order is:
> 
> 	1. read the data
> 	2. verify the data checksum
> 	3. decrypt the data - requires data copy
> 	4. decompress the data - requires data copy
> 	5. place the plain text data in the page cache

Just random stuffs for for reference, currently fsverity makes
markle tree for the plain text, but from the on-disk data
security/authentication and integrity perspective, I guess the
order you mentioned sounds more saner to me, or:

  	1. read the data
  	2. pre-verify the encoded data checksum (optional,
                                        dm-verity likewise way)
  	3. decrypt the data - requires data copy
  	4. decompress the data - requires data copy
	5. post-verify the decoded (plain) checksum (optional)
  	6. place the plain text data in the page cache

2,5 may apply to different use cases though.

> 

...

> 
> Compression is where using xattrs gets interesting - the xattrs can
> have a fixed "offset" they blong to, but can store variable sized
> data records for that offset.
> 
> If we say we have a 64kB compression block size, we can store the
> compressed data for a 64k block entirely in a remote xattr even if
> compression fails (i.e. we can store the raw data, not the expanded
> "compressed" data). The remote xattr can store any amount of smaller
> data, and we map the compressed data directly into the page cache at
> a high offset. Then decompression can run on the high offset pages
> with the destination being some other page cache offset....

but compressed data itself can also be multiple reference (reflink
likewise), so currently EROFS uses a seperate pseudo inode if it
decides with physical addresses as indexes.

> 
> On the write side, compression can be done directly into the high
> offset page cache range for that 64kb offset range, then we can
> map that to a remote xattr block and write the xattr. The xattr
> naturally handles variable size blocks.

Also different from plain text, each compression fses may keep
different encoded data forms (e.g. fses could add headers or
trailers to the on-disk compressed data or add more informations
to extent metadata) for their own needs.  So unlike the current
unique plain text process, an unique encoder/decoder may not sound
quite flexible though.

Thanks,
Gao Xiang

