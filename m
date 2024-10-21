Return-Path: <linux-fsdevel+bounces-32475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3289A6896
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A188F1C22619
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA1B1F1302;
	Mon, 21 Oct 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T9mN8kIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE71F12F6;
	Mon, 21 Oct 2024 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514070; cv=none; b=PHU06KzEOZy5AeYcAYkiHenCiKn8FEQ1vUYTHO3a1OGYBs1owz0AdtJ2WQW0AsdIWXkWcrkM0SrKhi0RmcTcZk8zSdDsjuZd9ntnXfIySUqRR5I6GKt+a0RjjBhN3Zs9OQTjcvxIO4roH08weDUyL1qtz76zQa/brRw0ln+ooqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514070; c=relaxed/simple;
	bh=1sTlr9enxc6QVgxLvEwIz2p0y5y0iCf8L6YZHgKTY/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3P6LlPsYdz2IYPD9nvDVS3p/kLsMP6B/TI3Oueh7qAbjsZVkdK0GjyEt84wZHb7YV0fEcjkUhjZ0mcC/EF0EJl23Pz3e2HEsFu4Kug4KqcGs+5VzTbIJfz5/SM7ERVa4hMzndRj9Ki4PgPq8NNBHsHfAQl7Pir1w1+Tw36tMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T9mN8kIf; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729514060; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NHWtLqYnu4wS3OxvS4L5uLq3I4fKPJPFOowoi3G6bQo=;
	b=T9mN8kIfYjNrULNhOQrHgk6qDbiZmsbgiGAmpCtWDV8+11RjgYyXDEDiLRtz/J3EdKD8GZgL4uv/JN3VLyFtyAcvqfFaC759LUJVrwLF194oHDUJjmN8BLYc/32bzVQOPfdWL0i9/GI00KdvB6b5mOzhcWCAa80eW3mOQOtBIEU=
Received: from 172.20.10.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHcY2W5_1729514058 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Oct 2024 20:34:19 +0800
Message-ID: <f64a9dbb-caed-4764-b104-e418ba87ad29@linux.alibaba.com>
Date: Mon, 21 Oct 2024 20:34:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
To: Christian Brauner <brauner@kernel.org>
Cc: Gao Xiang <xiang@kernel.org>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241010-bauordnung-keramik-eb5d35f6eb28@brauner>
 <ab1a99aa-4732-4df6-97c0-e06cca2527e3@linux.alibaba.com>
 <20241021-geldverlust-rostig-adbb4182d669@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241021-geldverlust-rostig-adbb4182d669@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/21 20:27, Christian Brauner wrote:
> On Mon, Oct 21, 2024 at 03:54:12PM +0800, Gao Xiang wrote:
>> Hi Christian,
>>
>> On 2024/10/10 17:48, Christian Brauner wrote:
>>> On Wed, 09 Oct 2024 11:31:50 +0800, Gao Xiang wrote:
>>>> As Allison reported [1], currently get_tree_bdev() will store
>>>> "Can't lookup blockdev" error message.  Although it makes sense for
>>>> pure bdev-based fses, this message may mislead users who try to use
>>>> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
>>>> then.
>>>>
>>>> Add get_tree_bdev_flags() to specify extensible flags [2] and
>>>> GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
>>>> since it's misleading to EROFS file-backed mounts now.
>>>>
>>>> [...]
>>>
>>> Applied to the vfs.misc branch of the vfs/vfs.git tree.
>>> Patches in the vfs.misc branch should appear in linux-next soon.
>>>
>>> Please report any outstanding bugs that were missed during review in a
>>> new review to the original patch series allowing us to drop it.
>>>
>>> It's encouraged to provide Acked-bys and Reviewed-bys even though the
>>> patch has now been applied. If possible patch trailers will be updated.
>>>
>>> Note that commit hashes shown below are subject to change due to rebase,
>>> trailer updates or similar. If in doubt, please check the listed branch.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>>> branch: vfs.misc
>>>
>>> [1/2] fs/super.c: introduce get_tree_bdev_flags()
>>>         https://git.kernel.org/vfs/vfs/c/f54acb32dff2
>>> [2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
>>>         https://git.kernel.org/vfs/vfs/c/83e6e973d9c9
>>
>> Anyway, I'm not sure what's your thoughts about this, so I try to
>> write an email again.
>>
>> As Allison suggested in the email [1], "..so probably it should get
>> fixed before the final release.".  Although I'm pretty fine to leave
>> it in "vfs.misc" for the next merge window (6.13) instead, it could
>> cause an unnecessary backport to the stable kernel.
> 
> Oh, the file changes have been merged during the v6.12 merge window?
> Sorry, that wasn't clear.
> 
> Well, this is a bit annoying but yes, we can get that fixed upstream
> then. I'll move it to vfs.fixes...

Many thanks for the reply!

Yeah, the feature is already usable [1] and it will be used for
several use cases, yet the unexpected message might be confusing.
Anyway, both options are fine to me, but "vfs.fixes" may be better
to avoid unnecesary backporting.

[1] https://lwn.net/Articles/990750

Thanks,
Gao Xiang


