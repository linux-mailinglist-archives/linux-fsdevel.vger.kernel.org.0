Return-Path: <linux-fsdevel+bounces-32456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7BF9A5DB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 09:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93196281A3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE81E0E15;
	Mon, 21 Oct 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jMqWE15B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857D1DFE22;
	Mon, 21 Oct 2024 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497265; cv=none; b=Ya+dDFbKwjISRb+fg64k5WnbeGPP0DfZ/vDRQrGkiRMXGYCLdADombNkXVmw/0WdnMijeq70O/VZ32+SgTpmLyj6Ax5JxPbRgfR/5VkHzum83I8yCDvbZndrsSYvfEaazR0LpvSY7OG+jTknNa+6U2hVryWk1y7RFflwJz0GZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497265; c=relaxed/simple;
	bh=gDYHLfdoCtStAMCGUx3Ay1RPR+kNQscBH8of2jY0cfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svYLUZtIH3V+BThKv/5VA+hHGDarLaps/9AC1tVs70qaImdUkNHoQjbNJ5o/S88djlPGjr4LsTZMfZqLqyBXeJOHaI+asqMOWN0zjb6rcpSsaV/hNaJv4SMx9bsIGBiYI0s7G7i9frC54UIdTuG7UCllqKa70IpfUAV67Fi7x5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jMqWE15B; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729497255; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JJokq+lp+EynznNIydiE+AjMIqmPGCXE2TWW4BFGqdU=;
	b=jMqWE15BaEv0HaFZXCqqOqwg/R5UgEsILlvhkgYmo+IYnWCjX5/FcCkJpdcPmoULzdAYpSJJb9Y2LTIDT+YVw3nnzUufwJTRm9xqUYvZzYcImDdYeDZdLDattJXBmYqTgHulE3ps7uyg9A3XUVCqNCkGmySLieKVNALAy+VvJuw=
Received: from 30.221.130.170(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHYCPSr_1729497253 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Oct 2024 15:54:14 +0800
Message-ID: <ab1a99aa-4732-4df6-97c0-e06cca2527e3@linux.alibaba.com>
Date: Mon, 21 Oct 2024 15:54:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
To: Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241010-bauordnung-keramik-eb5d35f6eb28@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241010-bauordnung-keramik-eb5d35f6eb28@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2024/10/10 17:48, Christian Brauner wrote:
> On Wed, 09 Oct 2024 11:31:50 +0800, Gao Xiang wrote:
>> As Allison reported [1], currently get_tree_bdev() will store
>> "Can't lookup blockdev" error message.  Although it makes sense for
>> pure bdev-based fses, this message may mislead users who try to use
>> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
>> then.
>>
>> Add get_tree_bdev_flags() to specify extensible flags [2] and
>> GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
>> since it's misleading to EROFS file-backed mounts now.
>>
>> [...]
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
> 
> [1/2] fs/super.c: introduce get_tree_bdev_flags()
>        https://git.kernel.org/vfs/vfs/c/f54acb32dff2
> [2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
>        https://git.kernel.org/vfs/vfs/c/83e6e973d9c9

Anyway, I'm not sure what's your thoughts about this, so I try to
write an email again.

As Allison suggested in the email [1], "..so probably it should get
fixed before the final release.".  Although I'm pretty fine to leave
it in "vfs.misc" for the next merge window (6.13) instead, it could
cause an unnecessary backport to the stable kernel.

Or if there is some other potential concern about these two patches?
Also I hope my previous reply about a redundant blank line removal
in the first patch might be useful too [2].

[1] https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
[2] https://lore.kernel.org/r/8ec1896f-93da-4eca-ab69-8ae9d1645181@linux.alibaba.com

Thanks,
Gao Xiang

