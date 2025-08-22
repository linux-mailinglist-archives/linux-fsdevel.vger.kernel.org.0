Return-Path: <linux-fsdevel+bounces-58789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3605B317AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90E0188FBB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA02FC026;
	Fri, 22 Aug 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlit8ZfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30F14A4DB;
	Fri, 22 Aug 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865263; cv=none; b=JaEgwo8cjHmV/iv8lv5T4Fw7shXpZhfJlWmHAeZhYB6APOuK3WXZRw5Ru15CNO3dxrb4FjEvdO3mOfh341/VOIW4A6RmhUIsCTeQhDhkQ65R0u1f6F+8EPuERuhX8fRFMEQi5Dwsi+ujjpLCLEgQq4Jt0qsbS4OLS0QWxmDCFoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865263; c=relaxed/simple;
	bh=Wvb9FGXp+svTFsvVbtKnyZ+CHAIJCOpOAE+YtdsGVMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryu/tIib0E6K8ir2/owQ8fq6YFVVcVjHK1sdTf3kfaR0bV9vIvISvW9PznBPBvL0pA7heOS9SzJeIteIU/xqz4mK6jn/N0Wl4TdNYUdzqrCdohGRbFPXCxCX1Qk41Z/P6MyhOjaiScePqYQysmNi7UKwSdfYcMNrIgBF2MJpDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlit8ZfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E79C4CEED;
	Fri, 22 Aug 2025 12:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755865263;
	bh=Wvb9FGXp+svTFsvVbtKnyZ+CHAIJCOpOAE+YtdsGVMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlit8ZfFhU4UrHoHAnONXjZbqlmFT8jA4Lntnb/myBfRWuuupoaZt1Nt0L9JLTJwd
	 vFZQ6JqcuG17gPNX23pbjgp+mkw2Ba0C4nkduBd4Efg+xy+YvAVxVIMCjQSDWKfshe
	 IFx+d3jwAD0uV34rlymQ7nmQ/eIA3Gn+FRCqKsVqHUkf2+B4HJ74WdjymWdsONvpob
	 P7zKyWUMN88Gi/J/jdIKg6RwBDyDo+Dx85k8B0BSAtkoP3VTK6UG/jiP6/pF+duI2+
	 L+Tt3RiJT8w7fPMzgwWPhD4xO8WeYuQ3xnzVu3YlnX1N5TXrodfIgwRXw2CMCdgM8f
	 u1RPPWTVbB2vg==
Date: Fri, 22 Aug 2025 14:20:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 06/50] fs: hold an i_obj_count reference in
 writeback_sb_inodes
Message-ID: <20250822-umarmen-mehltau-515d545eadd0@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <1a7d1025914b6840e9cc3f6e10c6e69af95452f5.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a7d1025914b6840e9cc3f6e10c6e69af95452f5.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:17PM -0400, Josef Bacik wrote:
> We drop the wb list_lock while writing back inodes, and we could
> manipulate the i_io_list while this is happening and drop our reference
> for the inode. Protect this by holding the i_obj_count reference during
> the writeback.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fs-writeback.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 24fccb299de4..2b0d26a58a5a 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1977,6 +1977,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  			trace_writeback_sb_inodes_requeue(inode);
>  			continue;
>  		}
> +		iobj_get(inode);
>  		spin_unlock(&wb->list_lock);
>  
>  		/*
> @@ -1987,6 +1988,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		if (inode->i_state & I_SYNC) {
>  			/* Wait for I_SYNC. This function drops i_lock... */
>  			inode_sleep_on_writeback(inode);
> +			iobj_put(inode);
>  			/* Inode may be gone, start again */
>  			spin_lock(&wb->list_lock);
>  			continue;
> @@ -2035,10 +2037,9 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		inode_sync_complete(inode);
>  		spin_unlock(&inode->i_lock);
>  
> -		if (unlikely(tmp_wb != wb)) {
> -			spin_unlock(&tmp_wb->list_lock);
> -			spin_lock(&wb->list_lock);
> -		}
> +		spin_unlock(&tmp_wb->list_lock);
> +		iobj_put(inode);
> +		spin_lock(&wb->list_lock);

So if tmp_wb == wb then you unlock and immediately relock dropping the
reference in between and if tmp_wb != wb then you unlock tmp_wb and the
context implies that @wb became unlocked and can be relocked again.
Seems sane, thanks. More contention on @wb->list_lock. I have no
intuition how bad that is and I know you mentioned it in your cover
letter. If it matters then I suspect the reference count would matter as
well. But let's not worry about it yet.

