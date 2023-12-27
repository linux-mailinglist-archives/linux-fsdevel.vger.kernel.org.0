Return-Path: <linux-fsdevel+bounces-6943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5681EC2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 05:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DEB2836E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 04:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900D4440A;
	Wed, 27 Dec 2023 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA9HuoFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7953C24;
	Wed, 27 Dec 2023 04:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE51C433C9;
	Wed, 27 Dec 2023 04:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703652426;
	bh=Bya6H8l4ZYjrp08ewGs9e/R44BsH5FpR2joYGBAIj2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lA9HuoFzlqbivy/PM58EG3aEtqKIuHa65hFvtoODtMxrOA7U/bkz0MX46x0REde94
	 lmwKoFVFN4WIi1Hvd6EHfbOgX7RmY9rfh/oIVfsrwrcN3tHqyO419OfZEBq3zPLQAN
	 E068JGv+6TDeSJKkdyQ8eLt53+ATJ1InaASpgNnvJjL24pCITGFXJzJhfx77epL4go
	 s7LDN854oVq3Fd+U3KTq0k5aefS7py+p1AbzDzneUBiIqtD5m0lA7Bq0flRYsegAX0
	 ncXHI4pvnfKOs8ICKq5/utgWQWyt0q4zsU1AORTAgBySeWbyyycB3SXHLjq4qtcE4v
	 8ItCUp6ZUPrug==
Date: Tue, 26 Dec 2023 22:47:01 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] f2fs: move release of block devices to after
 kill_block_super()
Message-ID: <20231227044701.GC4240@quark.localdomain>
References: <20231213040018.73803-1-ebiggers@kernel.org>
 <20231213040018.73803-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213040018.73803-3-ebiggers@kernel.org>

On Tue, Dec 12, 2023 at 08:00:17PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Call destroy_device_list() and free the f2fs_sb_info from
> kill_f2fs_super(), after the call to kill_block_super().  This is
> necessary to order it after the call to fscrypt_destroy_keyring() once
> generic_shutdown_super() starts calling fscrypt_destroy_keyring() just
> after calling ->put_super.  This is because fscrypt_destroy_keyring()
> may call into f2fs_get_devices() via the fscrypt_operations.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/f2fs/super.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Jaegeuk and Chao, when you have a chance can you review or ack this?  I'm
thinking of taking patches 2-3 of this series through the fscrypt tree for 6.8.

- Eric

