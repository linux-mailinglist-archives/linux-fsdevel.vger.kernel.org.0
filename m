Return-Path: <linux-fsdevel+bounces-58741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A8B30D37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 06:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7AD5E8CA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 04:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D0274B32;
	Fri, 22 Aug 2025 04:04:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E957C9F;
	Fri, 22 Aug 2025 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835447; cv=none; b=Ul/nPeX6Ew2Xums+s7cP4SNEP5hC0HNo6IQ8/FJtsRosmWyXZmf3z9enZyZjAR0UZ4mWwV84QGiSsA6xknV+1CaQ51U+s6GW3UeLokGNXj8z8DI48ZVMcxfOvdxUinx1boXjHT353KGfmn0B7BkIEjSuB3qfFcN/J36NX9FJDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835447; c=relaxed/simple;
	bh=H3gxW7YmnjIPD6JXPWUWwYW03Mq53VKP8bsqinIGGAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A5enPI8j0fMjI3m9R6IVPn95qoFbF5nxkIK+sZfvKx/v95IgWF4kK7g/drhGCmsP6Eh/yz/qIj9ExCMYDMJFJE7IjmG7YLGGCLDsCHMFLXEu5mdZGYhrBbggibPMVZ44zIidBM3IP/+Hl0wOBKFfUhhxf4wI7op9bWeX7jwH4oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c7RK46Yvkz2CgGc;
	Fri, 22 Aug 2025 11:59:36 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 740E71400DA;
	Fri, 22 Aug 2025 12:04:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 22 Aug
 2025 12:03:59 +0800
Message-ID: <b5e588cf-1408-4b67-b21f-04ff94314936@huawei.com>
Date: Fri, 22 Aug 2025 12:03:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tmpfs: preserve SB_I_VERSION on remount
Content-Language: en-GB
To: Hugh Dickins <hughd@google.com>
CC: Jeff Layton <jlayton@kernel.org>, <libaokun@huaweicloud.com>,
	<linux-mm@kvack.org>, <baolin.wang@linux.alibaba.com>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20250819061803.1496443-1-libaokun@huaweicloud.com>
 <0a5c4b7deb443ac5f62d00b0bd0e1dd649bef8fe.camel@kernel.org>
 <848440d1-72d9-e9ce-5da6-3e67490f0197@google.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <848440d1-72d9-e9ce-5da6-3e67490f0197@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-08-22 10:49, Hugh Dickins wrote:
> On Tue, 19 Aug 2025, Jeff Layton wrote:
>> On Tue, 2025-08-19 at 14:18 +0800, libaokun@huaweicloud.com wrote:
>>> From: Baokun Li <libaokun1@huawei.com>
>>>
>>> Now tmpfs enables i_version by default and tmpfs does not modify it. But
>>> SB_I_VERSION can also be modified via sb_flags, and reconfigure_super()
>>> always overwrites the existing flags with the latest ones. This means that
>>> if tmpfs is remounted without specifying iversion, the default i_version
>>> will be unexpectedly disabled.
> Wow, what a surprise! Thank you so much for finding and fixing this.
>
>>> To ensure iversion remains enabled, SB_I_VERSION is now always set for
>>> fc->sb_flags in shmem_init_fs_context(), instead of for sb->s_flags in
>>> shmem_fill_super().
> I have to say that your patch looks to me like a hacky workaround. But 
> after spending ages trying to work out how this came about, have concluded
> that it's an artifact of "iversion" and/or "noiversion" being or having
> been a mount option in some filesystems, with MS_I_VERSION in MS_RMT_MASK
> getting propagated to sb_flags_mask, implying that the remounter is
> changing the option when they have no such intention. 
Exactly!
>  And any attempt
> to fix this in a better way would be too likely to cause more trouble
> than it's worth - unless other filesystems are also still surprised.
Other filesystems supporting i_version (ext4, xfs, btrfs) have encountered
similar issues. The solution adopted was either resetting SB_I_VERSION
during remount operations or setting SB_I_VERSION in init_fs_context().

Given that the overhead of iversion is now minimal, all supported
filesystems in the kernel enable it by default. I previously considered
converting SB_I_VERSION to FS_I_VERSION and setting it in
file_system_type->fs_flags, but since XFS only supports iversion in v5,
this idea was ultimately abandoned. Alternatively, removing MS_I_VERSION
from MS_RMT_MASK might also be a viable approach.
> I had to worry, does the same weird disappearance-on-remount happen to
> tmpfs's SB_POSIXACL too?  But it looks like not, because MS_POSIXACL is
> not in MS_RMT_MASK - a relic of history why one in but not the other.
Yes.
> But I've added linux-fsdevel to the Ccs, mainly as a protest at this
> unexpected interface (though no work for Christian to do: Andrew has
> already taken the patch, thanks).
Okay.
>
>>> Fixes: 36f05cab0a2c ("tmpfs: add support for an i_version counter")
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> ---
>>>  mm/shmem.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index e2c76a30802b..eebe12ff5bc6 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -5081,7 +5081,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>>>  		sb->s_flags |= SB_NOUSER;
>>>  	}
>>>  	sb->s_export_op = &shmem_export_ops;
>>> -	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
>>> +	sb->s_flags |= SB_NOSEC;
>>>  
>>>  #if IS_ENABLED(CONFIG_UNICODE)
>>>  	if (!ctx->encoding && ctx->strict_encoding) {
>>> @@ -5385,6 +5385,9 @@ int shmem_init_fs_context(struct fs_context *fc)
>>>  
>>>  	fc->fs_private = ctx;
>>>  	fc->ops = &shmem_fs_context_ops;
>>> +#ifdef CONFIG_TMPFS
> Ah, you're being very punctilious with that #ifdef: yes, the original
> code happened not to set it in the #ifndef CONFIG_TMPFS case (when the
> i_version would be invisible anyway).  But I bet that if we had done it
> this way originally, we would have preferred not to clutter the source
> with #ifdef and #else here.  Oh well, perhaps they will vanish in the
> night sometime, it's a nit not worth you resending.
Yes, I kept this macro to maintain consistency with shmem_fill_super().
If i_version is not supported but SB_I_VERSION is set, it may cause
confusion for IMA or NFS.
>
>>> +	fc->sb_flags |= SB_I_VERSION;
>>> +#endif
>>>  	return 0;
>>>  }
>>>  
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Hugh Dickins <hughd@google.com>
>
Thanks,
Baokun


