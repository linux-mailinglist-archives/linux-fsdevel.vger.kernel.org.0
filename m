Return-Path: <linux-fsdevel+bounces-8677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4F583A15C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 06:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A29F28A781
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 05:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF73E55E;
	Wed, 24 Jan 2024 05:34:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6444D308;
	Wed, 24 Jan 2024 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074461; cv=none; b=daVx6UpXMdUzxUXlSsNkgayAsXiOtGpZIxWS0A3aiqVMNFJgvD5mRz09QQNoAxRyAKrf0ckQSjrDG0TuNVbDRKVRbGD8tWdbVqWyZj2e/57nLRDYJ855UzbXIbejsvMX2k0SMOBpL9GeuWqpI8xonF/KL8lcY7fIFShjr4cK+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074461; c=relaxed/simple;
	bh=bA8gU32GX2EdWE4MVJDofY5hHrI7nCvmdzsxVc9noWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REE7TbN2AvE6swXbUvaIBsKqTGhblffXQa5fHC22WkG+3SILHw6ADDpdxrLB0537ZcW7qGI4HQwMcaafu4voDBOD7nf7KTRDPo15IB8C0FhEvRH3rq7Hg+tI1ahXSmJr+PN8ifhpy7WBGlQn1lh8E0fyZ0lEpRKfAjnZD+4rWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W.Errgs_1706074452;
Received: from 30.97.48.250(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.Errgs_1706074452)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 13:34:13 +0800
Message-ID: <d59e2285-25bb-4aa4-a507-3ef420c5caf7@linux.alibaba.com>
Date: Wed, 24 Jan 2024 13:34:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 19/19] tarfs: introduce tar fs
To: Matthew Wilcox <willy@infradead.org>,
 Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Wedson Almeida Filho <walmeida@microsoft.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-20-wedsonaf@gmail.com>
 <ZbCap4F41vKC1PcE@casper.infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZbCap4F41vKC1PcE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/1/24 13:05, Matthew Wilcox wrote:
> On Wed, Oct 18, 2023 at 09:25:18AM -0300, Wedson Almeida Filho wrote:
>> +config TARFS_FS
>> +	tristate "TAR file system support"
>> +	depends on RUST && BLOCK
>> +	select BUFFER_HEAD
> 
> I didn't spot anywhere in this that actually uses buffer_heads.  Why
> did you add this select?

Side node: I think sb.read() relies on
"[RFC PATCH 15/19] rust: fs: add basic support for fs buffer heads"

More background:

Although I'm unintended to join a new language interface
discussion, which I'm pretty neutral. But I might need to add some
backgrounds about the "tarfs" itself since I'm indirectly joined
some discussion.

The TarFS use cases has been discussed many times in
"confidential containers" for almost a year in their community
meeting to passthrough OCI images to guests but without an
agreement.

And this "TarFS" once had a C version which was archived at
https://github.com/kata-containers/tardev-snapshotter/blob/main/tarfs/tarfs.c

and the discussion was directly in a Kata container PR:
https://github.com/kata-containers/kata-containers/pull/7106#issuecomment-1592192981

IMHO, this "tarfs" implementation have no relationship with the
real tar on-disk format since it defines a new customized index
format rather than just parse tar in kernel.

IOWs, "tarfs" mode can be directly supported by using EROFS since
Linux v6.3 by using 512-byte block size addressing, see
https://git.kernel.org/torvalds/c/61d325dcbc05

And I think any local fs which supports 512-byte block size can
have a "tarfs" mode without any compatibility issue.

BTW, in addition to incompatiable with on-disk tar format, this
tarfs does not seem to support tar xattrs too.

Thanks,
Gao Xiang

> 

