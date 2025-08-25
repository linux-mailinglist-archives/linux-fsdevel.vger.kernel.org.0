Return-Path: <linux-fsdevel+bounces-59005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E6DB33DF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10600188961B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1902E7F2F;
	Mon, 25 Aug 2025 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0Fsyomn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94023D7D0;
	Mon, 25 Aug 2025 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121232; cv=none; b=s4JyFuVkmBy4sj1yPO+V++0KlD9aOo0KxokP5WPuGZmutjAG5sKNI2wqb0vRjfphdKc/4SB+ipJ1sy7ZdB3HTNPyIK0iRvuXNdcz/h4cBXpUFG/IEb+uU1mII/89/IVuTf7WH85kYf/YfPbDGPCDbpLU5C6w4yN+JSBxfkP4a6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121232; c=relaxed/simple;
	bh=/VtQ7ETa3CypWKOMyl6DvJVpl8M0zdkqzmkAvgEGI40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/R9xzMFzFuWscuRlQP1Lh32gz0h4tIa/1mYf5IWhow7AGu0MVZf7zfC5zXb3f+qvcSiCPYWTQ1MBLiYWzjOV0mxeIwptKWz6I5mQjBBaBfueq7Ad4ZYKNcRAjyQrnBVoE+7zg1j5gUZSIsSu3tZN2oAiusPGSryz2g92x2BzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0Fsyomn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D8CC4CEED;
	Mon, 25 Aug 2025 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756121232;
	bh=/VtQ7ETa3CypWKOMyl6DvJVpl8M0zdkqzmkAvgEGI40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0Fsyomn82ghlSsqg8Oeb/Vqp3ixfboIEzu8pQCjTAqy7tuf6qVbA2Ko/WDki6ENE
	 eb9NUnAFmBtPAH0zyEpGo1GfTb1y49D9+iei929rvDIlpoVI9xbQcLUGGPw047aBf0
	 YalgYicNkXcErkSGNQTYPMgYE26I3sdoMVAWTDUGZrMsnAmthmXmFi/ulkhWsWKUjB
	 YBNRAoBN+mjqSXB9G4FyMW4kgDzjLJCGM3pUkJNznRHF13GCHFu0DGTAqjQ4hhg1UC
	 v2uid0lra6GaImbbzyPpx3nnYYCnyQ+KUnScX7AodHz1SN4tnt9aKlicOJvh1TiRDh
	 pV5Yc9pArd9ng==
Date: Mon, 25 Aug 2025 13:27:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 23/50] fs: update find_inode_*rcu to check the i_count
 count
Message-ID: <20250825-ameisen-reaktion-4898c02dd545@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <73ac2ba542806f2d43ee4fa444e3032294c9a931.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73ac2ba542806f2d43ee4fa444e3032294c9a931.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:34PM -0400, Josef Bacik wrote:
> These two helpers are always used under the RCU and don't appear to mind
> if the inode state changes in between time of check and time of use.
> Update them to use the i_count refcount instead of I_WILL_FREE or
> I_FREEING.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 893ac902268b..63ccd32fa221 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1839,7 +1839,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
>  
>  	hlist_for_each_entry_rcu(inode, head, i_hash) {
>  		if (inode->i_sb == sb &&
> -		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
> +		    refcount_read(&inode->i_count) > 0 &&

No direct i_count access, otherwise another nice change. Not having to
look at these terribly named flags anymore is wonderful.

>  		    test(inode, data))
>  			return inode;
>  	}
> @@ -1878,8 +1878,8 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
>  	hlist_for_each_entry_rcu(inode, head, i_hash) {
>  		if (inode->i_ino == ino &&
>  		    inode->i_sb == sb &&
> -		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
> -		    return inode;
> +		    refcount_read(&inode->i_count) > 0)
> +			return inode;
>  	}
>  	return NULL;
>  }
> -- 
> 2.49.0
> 

