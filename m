Return-Path: <linux-fsdevel+bounces-25898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC95951814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 11:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417A41C213BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB4F19FA86;
	Wed, 14 Aug 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sIlQHpec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2613E8A5;
	Wed, 14 Aug 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629373; cv=none; b=E2QP9QoRSGtuLBJ90b1YX3AXbmfUVveK82EaoAC4rrQUFPsDx7n/2Rs1CcYpjsL5Khwsq7+rsnDaKxNcFcii6J5CWlg/wsMAlrvSGxRPkCy40Z6me3tjKEUZ595KSiZsal6HMh4OJNTAcsHPzf55cN1CxHq4Mln81knLnuZ29+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629373; c=relaxed/simple;
	bh=pgXrhGyXFiJp2u9xmhk5ZGF/2T7Qp2CzM2cvoE6iQMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhaC0W7XWEREZUDCxkhLAVwxwBv+ENPtHC/6vX/P/KVIPjsxevk3FgfUWPRsvzIlgJ9LF0DXSg3NGs4g5cFwVlbLbXLoSjtoPLOX8j0lL26pajyDPVdWDzq+4im8FWbl55wmyzLjM7JBudlYvDzrepUub/z91tykzxl+WWxcu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sIlQHpec; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723629368; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rZmzJsrFiA02elDROcrJ0lc8mmUbPT+8Svhl6m6pUbI=;
	b=sIlQHpecC/DmY07X8yJB4RnJL3Pz24+onUjgYE4v4c5mkptLkogOEFkhhmRywZI9pRWVotZdau67S0fGwpkRSkL8Gue7FHkK91oug2vyZnhdg6ujYuYRV9XOT5PAT+oODLxkMW0r5HIuAjMpV0Yg5KqzLsJPEhUA5Sqn+kc1lPs=
Received: from 30.221.146.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WCsVv0F_1723629367)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 17:56:08 +0800
Message-ID: <8e235c73-faac-4cb7-bc6a-e1eea5075cbe@linux.alibaba.com>
Date: Wed, 14 Aug 2024 17:56:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add fast path for fuse_range_is_writeback
To: yangyun <yangyun50@huawei.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 lixiaokeng@huawei.com
References: <20240814093600.216757-1-yangyun50@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240814093600.216757-1-yangyun50@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/24 5:36 PM, yangyun wrote:
> In some cases, the fi->writepages may be empty. And there is no need
> to check fi->writepages with spin_lock, which may have an impact on
> performance due to lock contention. For example, in scenarios where
> multiple readers read the same file without any writers, or where
> the page cache is not enabled.
> 
> Also remove the outdated comment since commit 6b2fb79963fb ("fuse:
> optimize writepages search") has optimize the situation by replacing
> list with rb-tree.
> 
> Signed-off-by: yangyun <yangyun50@huawei.com>
> ---
>  fs/fuse/file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f39456c65ed7..59c911b61000 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -448,9 +448,6 @@ static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
>  
>  /*
>   * Check if any page in a range is under writeback
> - *
> - * This is currently done by walking the list of writepage requests
> - * for the inode, which can be pretty inefficient.
>   */
>  static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
>  				   pgoff_t idx_to)
> @@ -458,6 +455,9 @@ static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	bool found;
>  
> +	if (RB_EMPTY_ROOT(&fi->writepages))
> +		return false;

fi->lock is held when inserting wpa into fi->writepages rbtree (see
fuse_writepage_add()).  I doubt if there is race condition when checking
if fi->writepages rbtree is empty without fi->lock held.


-- 
Thanks,
Jingbo

