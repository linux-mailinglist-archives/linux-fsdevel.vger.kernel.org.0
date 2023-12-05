Return-Path: <linux-fsdevel+bounces-4824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5259180450C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 03:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4285B20A29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 02:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF4BD26A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kywcOgmT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8917F1;
	Tue,  5 Dec 2023 01:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727DCC433C7;
	Tue,  5 Dec 2023 01:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701741482;
	bh=qwiREi+YS3J4E2QqOV9bu2zXvJ/DrcstmLQtGv4stHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kywcOgmTnPOVujrSjXUc7g9dA1u1YNrvd1MksKxyw8k1jFZHSSe1cnM+v3RYQQx4f
	 Q9ef6C9MpShnQdjWCswK28JJUYS5cu9VEkbPU4tJBxJc2ynCDMwlTEyXOiwvvNX32l
	 0iknAFKZLlH1hA+YVRDSrKb6c63JANW4O/YDdCrH+egzk8LRdQ1/hxUG2mNMsf8I1j
	 VunNxJXZPs5ZuNhSQsQ9K4acub51wWFkxI5wG944nRiZJyh39fOMXBFxVvWRsf1Dfv
	 oXvRVsObrC7rAM4fm4mbGC7N9fPnJNGZ3M2Fkr7PDDPrnH5cZex9GnHT34PvSGuzNV
	 AWOTWi4oISeyQ==
Date: Mon, 4 Dec 2023 17:58:00 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/46] fs: move fscrypt keyring destruction to after
 ->put_super
Message-ID: <20231205015800.GC1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <122a3db06dbf6ac1ece5660895a69039fe45f50d.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122a3db06dbf6ac1ece5660895a69039fe45f50d.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:10:58PM -0500, Josef Bacik wrote:
> btrfs has a variety of asynchronous things we do with inodes that can
> potentially last until ->put_super, when we shut everything down and
> clean up all of our async work.  Due to this we need to move
> fscrypt_destroy_keyring() to after ->put_super, otherwise we get
> warnings about still having active references on the master key.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/super.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 076392396e72..faf7d248145d 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -681,12 +681,6 @@ void generic_shutdown_super(struct super_block *sb)
>  		fsnotify_sb_delete(sb);
>  		security_sb_delete(sb);
>  
> -		/*
> -		 * Now that all potentially-encrypted inodes have been evicted,
> -		 * the fscrypt keyring can be destroyed.
> -		 */
> -		fscrypt_destroy_keyring(sb);
> -
>  		if (sb->s_dio_done_wq) {
>  			destroy_workqueue(sb->s_dio_done_wq);
>  			sb->s_dio_done_wq = NULL;
> @@ -695,6 +689,12 @@ void generic_shutdown_super(struct super_block *sb)
>  		if (sop->put_super)
>  			sop->put_super(sb);
>  
> +		/*
> +		 * Now that all potentially-encrypted inodes have been evicted,
> +		 * the fscrypt keyring can be destroyed.
> +		 */
> +		fscrypt_destroy_keyring(sb);
> +

This patch will cause a NULL dereference on f2fs, since f2fs_put_super() frees
->s_fs_info, and then fscrypt_destroy_keyring() can call f2fs_get_devices() (via
fscrypt_operations::get_devices) which dereferences it.  (ext4 also frees
->s_fs_info in its ->put_super, but ext4 doesn't implement ->get_devices.)

I think we need to move the fscrypt keyring destruction into ->put_super for
each filesystem.

- Eric

