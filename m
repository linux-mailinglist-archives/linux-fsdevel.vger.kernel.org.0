Return-Path: <linux-fsdevel+bounces-59486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 176B9B39CCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0F41C82842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B9311583;
	Thu, 28 Aug 2025 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9otNUpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3330FC26;
	Thu, 28 Aug 2025 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383351; cv=none; b=F7jGlg2CSxXjI2RqyFUKw2An0hCJo0zKbAHgZjukwjCYJt/vJSSVK3BI7XkVWie13sXDoNM3KQXtrZK7lptPPL6z4l0/QS43NM3SVTTCSC1MbRFkiNcdLwyt6K0HoEE7XBSVMzF58X9J1XIYnW42A6kJy2C8NhdsFC9bX7zPMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383351; c=relaxed/simple;
	bh=XMAiSBm/OrGkCiR+hY7KGy2L0OCNniF2L3bQJM0tWC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riKS8VG56dteKnsEG/wz3dcH3Cz/WWSURg2SdpznG/oKvB1IKSlI5jQPi7R3omLRIe0TpX7x7A8o9mOZ14SEZSNopKlomAbuY1edEHyCpjhHqIksrwIp9sQ5XG+p2XnEjyOSGJlTy3EC5ywhE5932IM8X+mg0Le05HbvIEY6PyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9otNUpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2196BC4CEEB;
	Thu, 28 Aug 2025 12:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756383351;
	bh=XMAiSBm/OrGkCiR+hY7KGy2L0OCNniF2L3bQJM0tWC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9otNUpvzAzO4Bk3NAqZxqOTdkKeJwMnhRQHm1nfCgJWTvo0UPgObV2mNMoZ6Tei3
	 wm3ZkQ7nqbf35MYKG5jkb03cUqkWrDs89WejorzqR8bfl48KjkbW3tztXw7pZjdXkI
	 lvx/nJ5AkWXRpJBalZoXx0qpy6fgo7XIMfaWdNwIgbL30DM0zGsuIXTkRkKD2uHp+n
	 X59Mb5kYSYCWsEKVBhixL67iskZK3Y2o2hgIhFjPIwhtkPkiouRiG1q6d20kHtpQZ1
	 YXXx2rEjefRVfBqNdyw1NR0tWUmopToteZlq9iU1dfy0TWrKjgnK0ifkalFhoMG/Lq
	 mHSGoBgR0zxqg==
Date: Thu, 28 Aug 2025 14:15:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 26/54] fs: use igrab in insert_inode_locked
Message-ID: <20250828-wohngebiet-pfahl-a6f23062f6e1@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <8e31ead748e11697fff9e4dba0ffe29f082c7c7b.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e31ead748e11697fff9e4dba0ffe29f082c7c7b.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:26AM -0400, Josef Bacik wrote:
> Follow the same pattern in find_inode*. Instead of checking for
> I_WILL_FREE|I_FREEING simply call igrab() and if it succeeds we're done.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 8ae9ed9605ef..d34da95a3295 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1883,11 +1883,8 @@ int insert_inode_locked(struct inode *inode)
>  				continue;
>  			if (old->i_sb != sb)
>  				continue;
> -			spin_lock(&old->i_lock);
> -			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
> -				spin_unlock(&old->i_lock);
> +			if (!igrab(old))
>  				continue;
> -			}
>  			break;
>  		}
>  		if (likely(!old)) {
> @@ -1899,12 +1896,13 @@ int insert_inode_locked(struct inode *inode)
>  			spin_unlock(&inode_hash_lock);
>  			return 0;
>  		}
> +		spin_lock(&old->i_lock);
>  		if (unlikely(old->i_state & I_CREATING)) {
>  			spin_unlock(&old->i_lock);
>  			spin_unlock(&inode_hash_lock);
> +			iput(old);
>  			return -EBUSY;
>  		}
> -		__iget(old);
>  		spin_unlock(&old->i_lock);
>  		spin_unlock(&inode_hash_lock);
>  		wait_on_inode(old);
> -- 
> 2.49.0
> 

So looking at the function in full context:

int insert_inode_locked(struct inode *inode)
{
	struct super_block *sb = inode->i_sb;
	ino_t ino = inode->i_ino;
	struct hlist_head *head = inode_hashtable + hash(sb, ino);

	while (1) {
		struct inode *old = NULL;
		spin_lock(&inode_hash_lock);
		hlist_for_each_entry(old, head, i_hash) {
			if (old->i_ino != ino)
				continue;
			if (old->i_sb != sb)
				continue;
			if (!igrab(old))
				continue;
			break;
		}
		if (likely(!old)) {
			spin_lock(&inode->i_lock);
			iobj_get(inode);

Sorry, this is probably me being confused.
Say we allocated a new inode then we've definitely went through
inode_init_always() and so i_obj_count == i_count == 1.
Then we insert it into the hash table. For that we only take an
i_obj_count but no i_count bringing it to 2.

So for the hashlist we only deal with i_obj_count.

Is that documented somewhere? I probably just read over it.

