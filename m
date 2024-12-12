Return-Path: <linux-fsdevel+bounces-37175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8939EE97F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60632164E8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435C3215764;
	Thu, 12 Dec 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVmUShXC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3F2135AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015594; cv=none; b=VkurHxXMxFRT7p01dD8LnRun2fxfk4GNMVjVki59yIaF9TPDC0L9NACHxUmoABfd6AtOdO1X59nQk7r5ahavHFPXjK+Npe67bU15Fwj7L3Cu7UJ3GEF7K6qn1C1/aqXduNUSLh0xsAJNeI3MUZe9I36d5Py6e9fNX6x3njPCGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015594; c=relaxed/simple;
	bh=gj63/lgmCJ83d/T+E2tbXLD8bA62WmiZhc4ojJVHIcQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MNJJyZRSVnlRcu9Cv5Ku8UWMKrqL873J8TfN1UR927tfQtPrtDrnIVO/vSwApClg1f6F11lx5DqMe79yn7AfpP0EDxOd9p1o21aC16JhqoRZ2zECjGLiFve+v7Evv3k3916E0AXTsWKLeM8UfGOhkaBA/IfwortWcDKHi5/zvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVmUShXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3CCC4CECE;
	Thu, 12 Dec 2024 14:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734015594;
	bh=gj63/lgmCJ83d/T+E2tbXLD8bA62WmiZhc4ojJVHIcQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FVmUShXCl+1y4S7nYzHEA7dvN5ruEiA4tVA2RhmV9eriGPExbKDK8ATHcJHp9nl9W
	 vr+P3+b9yj5wdHJZhcaprWP5CpR9s7g/IaA7jFQP41BSM8z5bBOmk3n26fnQ3Pk0K4
	 qKykMIFqcKHdd/btnhJTr5gUX9d/Z+DT3CTe1fwB4gWvDL1BowfFk19lMxH1YW2O7b
	 TM2jcB8OyR3CvhvszSHOda1e+gCBD4m9VO6kImg8cIaTbvXyB+dkeTBlnb3VQxjNEK
	 zRFH9Hdandj1ag8CR+NgrsSktLBxOnRmd8F9yeQ6c/k6dI9X2nRvJ4KRjscMVLKT9G
	 RwuGX7Ex2blAg==
Message-ID: <ec2729cc-2846-49c2-b7ca-4c1efe004cd1@kernel.org>
Date: Thu, 12 Dec 2024 22:59:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: ensure that node info flags are always initialized
To: Dmitry Antipov <dmantipov@yandex.ru>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241204060934.697070-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <20241204060934.697070-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/12/4 14:09, Dmitry Antipov wrote:
> Syzbot has reported the following KMSAN splat:
> 
> BUG: KMSAN: uninit-value in f2fs_new_node_page+0x1494/0x1630
>   f2fs_new_node_page+0x1494/0x1630
>   f2fs_new_inode_page+0xb9/0x100
>   f2fs_init_inode_metadata+0x176/0x1e90
>   f2fs_add_inline_entry+0x723/0xc90
>   f2fs_do_add_link+0x48f/0xa70
>   f2fs_symlink+0x6af/0xfc0
>   vfs_symlink+0x1f1/0x470
>   do_symlinkat+0x471/0xbc0
>   __x64_sys_symlink+0xcf/0x140
>   x64_sys_call+0x2fcc/0x3d90
>   do_syscall_64+0xd9/0x1b0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Local variable new_ni created at:
>   f2fs_new_node_page+0x9d/0x1630
>   f2fs_new_inode_page+0xb9/0x100
> 
> So adjust 'f2fs_new_node_page()' to ensure that 'flag' field of on-stack
> 'struct node_info' is always zeroed just like if it was allocated within
> 'struct nat_entry' via 'f2fs_kmem_cache_alloc(..., GFP_F2FS_ZERO, ...)'
> in '__alloc_nat_entry()'.
> 
> Reported-by: syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5141f6db57a2f7614352
> Fixes: e05df3b115e7 ("f2fs: add node operations")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   fs/f2fs/node.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 0b900a7a48e5..5103cc0d95c4 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1314,7 +1314,7 @@ struct page *f2fs_new_inode_page(struct inode *inode)
>   struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> -	struct node_info new_ni;
> +	struct node_info new_ni = { .flag = 0 };

We can initialize new_ni.flag in f2fs_get_node_info() to cover
all similar cases?

Thanks,

>   	struct page *page;
>   	int err;
>   


