Return-Path: <linux-fsdevel+bounces-27712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA5963712
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 02:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BB61C21C5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D1134D1;
	Thu, 29 Aug 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sljmU6lD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6179F3
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893003; cv=none; b=uyhH0+sQnGr5OEmrHWlqSMWQziLwfnAVuXg60CR31BPW+N5wESdaZMyjSDTkPcVU0RkFk1LzjMDVv9PWXKd/ujFmbiSEvuf2foUtQLs28KuSPCG4akPiRa7FVLMsdwLeiWuuijeDLv1SzXvGdVqcueH5Hrb/qKZtYV4p8nCFTzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893003; c=relaxed/simple;
	bh=MXeOs15ju727f7Ha/UIWqUZetEdF+gkjc4dgBnSvUx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHva/QKW0e3wGkLhH+YHcVW88JT+nO9GdpuCNjssLPMjNUI7XuXTYAtPeqdPC5X35mun7AzBHazy6UknrCOSHK57ETvhW+z5mHIx7d8PeQtLmwnulEgwgT1Xhj+Q7l1hbeJ+G9qeta+K3nTJ/Ur5Nmy3Jqs2L8KPfoP8ykHCtkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sljmU6lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802DFC4CEC0;
	Thu, 29 Aug 2024 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893003;
	bh=MXeOs15ju727f7Ha/UIWqUZetEdF+gkjc4dgBnSvUx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sljmU6lDjX2pmzZERb7cR9GV5uugU5ttCgVSvTX6ZJ31uE7S8atjRBwREwyAEHqvd
	 TYG/tdrxeEqu0oaKRNMk1SXdVO/77kyYDEQ4442SRpgWPTKjCi/tPuHLuo4ok4pdDm
	 qyByIOdUUHCVJiVArSgftyUtB3rhoyKsl95tLbyf9O0BA6zfbQdTNdHsB7UKs2H+mh
	 5iipF4OwvXSUwzTVUWjiIa0IjX574AC9IZHk3BeEMfxLyolNmevDInOO2tU+ju57OT
	 /kJ1rp6I+/clUrxaQ5J7J7FXIpKX94JIDZK7XjmBCI2uVDpEWM6it3ACJNA3paosFq
	 7qLQvPBjoyBrg==
Message-ID: <abcb7207-8b8d-4a29-9d0d-665da2c91443@kernel.org>
Date: Thu, 29 Aug 2024 09:56:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] zonefs: obtain fs magic from superblock
To: Hongbo Li <lihongbo22@huawei.com>, naohiro.aota@wdc.com, jth@kernel.org
Cc: linux-fsdevel@vger.kernel.org
References: <20240828120152.3695626-1-lihongbo22@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240828120152.3695626-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 21:01, Hongbo Li wrote:
> The sb->s_magic holds the file system magic, we can use
> this to avoid use file system magic macro directly.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/zonefs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index faf1eb87895d..1ecbf19ccc58 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -444,7 +444,7 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  	enum zonefs_ztype t;
>  
> -	buf->f_type = ZONEFS_MAGIC;
> +	buf->f_type = sb->s_magic;

I fail to see the benefits of this change. "we can do it differently" is not
really an argument in itself without clear benefits. And in this case, that
function will have an additional sb pointer dereference, so be slower (not that
it matters though since this is not the hot path).

See other file systems (e.g. xfs_fs_statfs), many do the same thing and use
their MAGIC macro for this field.

>  	buf->f_bsize = sb->s_blocksize;
>  	buf->f_namelen = ZONEFS_NAME_MAX;
>  

-- 
Damien Le Moal
Western Digital Research


