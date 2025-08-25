Return-Path: <linux-fsdevel+bounces-58980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD3AB33A28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1247A4FCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B52C0F64;
	Mon, 25 Aug 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taO2W+7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0B2C08C5;
	Mon, 25 Aug 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112881; cv=none; b=aQ/y/yqJXzNHvHYbxcKbo6v/S0Z4OpP2TitYGrzmnUAlpJMBpSagxEKn8EsCDvo95H6bmaOp0iQG8i0Bb8FbXf3pPiG7JF4shSXYsPCLlf6w2JlN/1d2fHDJ4079gkwdbEFp5Ioje+GWHH4snhdb2F9BrqySNzCvsgv+SntAKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112881; c=relaxed/simple;
	bh=WcGIexejQro4dJup18GJZHF4Y5xxKShoUkhmSJJdXKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFk4u9BideIMrWjR58uVm+YGXQZ4OgCnCXCEyxRI3AKft66tojhEDWj611KdItGLqxp3kEWKvOjictqDijE0V4hZZSS9dv0shU5obx5LNjTx4mnTNodRopjvx0HA7J44R6Uss+uqJQ+Si2XUvJ3msMPalj0CC7PfHKd8Kw3Ai8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taO2W+7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F02C4CEED;
	Mon, 25 Aug 2025 09:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756112881;
	bh=WcGIexejQro4dJup18GJZHF4Y5xxKShoUkhmSJJdXKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=taO2W+7jJohKF1oHfrS8W24AZXDZtFunSZkAUlqBPxAi5IuIxthDreYTMCML96ryV
	 JpYQz0KT5GXAoFRaiFNTI1n4GApimZ85BVrQMpga+/84hjT5LkXCsrzlI1zOEzYpMK
	 HtgOQNiEVwsiFNemunQwpFnkw5txFOVeRUE2P5vd5WKO0Irv9CpYFWglknEw33F9m+
	 M3rtnPC0ANjrY1CaFcxzSSAjPEyHrvzWFU6z3PJ53fpW5tXeO1Y/Fg5U4utLs/uCHu
	 K4fQWOCR+ulXSRW4oV2FaWmKyiYtG1vva859dQt6ydFPePttrImp7IGVFfmlV15tiw
	 xdV2EO05Rk7eA==
Date: Mon, 25 Aug 2025 11:07:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 16/50] fs: change evict_inodes to use iput instead of
 evict directly
Message-ID: <20250825-entbinden-kehle-2e1f8b67b190@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <1198cd4cd35c5875fbf95dc3dca68650bb176bb1.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1198cd4cd35c5875fbf95dc3dca68650bb176bb1.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:27PM -0400, Josef Bacik wrote:
> At evict_inodes() time, we no longer have SB_ACTIVE set, so we can
> easily go through the normal iput path to clear any inodes. Update

I'm a bit lost why SB_ACTIVE is used here as a justification to call
iput(). I think it's because iput_final() would somehow add it back to
the LRU if SB_ACTIVE was still set and the filesystem somehow would
indicate it wouldn't want to drop the inode.

I'm confused where that would even happen. IOW, which filesystem would
indicate "don't drop the inode" even though it's about to vanish. But
anyway, that's probably not important because...

> dispose_list() to check how we need to free the inode, and then grab a
> full reference to the inode while we're looping through the remaining
> inodes, and simply iput them at the end.
> 
> Since we're just calling iput we don't really care about the i_count on
> the inode at the current time.  Remove the i_count checks and just call
> iput on every inode we find.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 72981b890ec6..80ad327746a7 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -933,7 +933,7 @@ static void evict(struct inode *inode)
>   * Dispose-list gets a local list with local inodes in it, so it doesn't
>   * need to worry about list corruption and SMP locks.
>   */
> -static void dispose_list(struct list_head *head)
> +static void dispose_list(struct list_head *head, bool for_lru)
>  {
>  	while (!list_empty(head)) {
>  		struct inode *inode;
> @@ -941,8 +941,12 @@ static void dispose_list(struct list_head *head)
>  		inode = list_first_entry(head, struct inode, i_lru);
>  		list_del_init(&inode->i_lru);
>  
> -		evict(inode);
> -		iobj_put(inode);
> +		if (for_lru) {
> +			evict(inode);
> +			iobj_put(inode);
> +		} else {
> +			iput(inode);
> +		}

... Afaict, if we end up in dispose_list() we came from one of two
locations:

(1) prune_icache_sb()
    In which case inode_lru_isolate() will have only returned inodes
    that prior to your changes would have inode->i_count zero.

(2) evict_inodes()
    Similar story, this only hits inodes with inode->i_count zero.

With your change you're adding an increment from zero for (2) via
__iget() so that you always end up with a full refcount, and that is
backing your changes to dispose_list() later.

I don't see the same done for (1) though and so your later call to
iput() drops the reference below zero? It's accidently benign because
iiuc atomic_dec_and_test() will simply tell you that reference count
didn't go to zero and so iput() will back off. But still this should be
fixed if I'm right.

The conversion to iput() is introducing a lot of subtlety in the middle
of the series. If I'm right then the iput() is a always a nop because in
all cases it was an increment from zero. But it isn't really a nop
because we still do stuff like call ->drop_inode() again. Maybe it's
fine because no filesystem would have issues with this but I wouldn't
count on it and also it feels rather unclean to do it this way.

So, under the assumption, that after the increment from zero you did, we
really only have a blatant zombie inode on our hands and we only need to
get rid of the i_count we took make that explicit and do:

	if (for_lru) {
		evict(inode);
		iobj_put(inode);
	} else {
		/* This inode was always incremented from zero.
		 * Get rid of that reference without doing anything else.
		 */
		WARN_ON_ONCE(!atomic_dec_and_test(&inode->i_count));
	}

Btw, for the iobj_put() above, I assume that we're not guaranteed that
i_obj_count == 1?

