Return-Path: <linux-fsdevel+bounces-57222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65314B1F95F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B12176A28
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7276623F294;
	Sun, 10 Aug 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtooPbxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440C2033A;
	Sun, 10 Aug 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754815657; cv=none; b=K606PxHadPl6okRmmYSEL63xICywx4CJ4BcigF2P/seJIBgyrS0pqJcPjPJ8NsQZTuWVLCd/J41AOtgEoEU9qP7dFRQf5m1Kd/bKG0pH9AgJRl2d4u4F3WHUQeXXsho1sDG3Sol0R21T3ufu6yUZOJm/9UkV37SGAbCWMWrwZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754815657; c=relaxed/simple;
	bh=q8SgtBm3Um6/IA3ICdzyzAhRe18cnxg4v20POkcefXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp8ec+R7UoUkXhbU3mmPTr51avxDjzxNs781ji7BdDIIK51WNdlVTefpjVUkvKRKuOkRgFmLWN1CJZV5nOihfzV/mBK1lgyHN8gkUezKoXy0BijnuNf169XShseCV6DcqR30+b3PcZxBaM0bkKu7jSxetkmLOapCUQ6M/dvwhpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtooPbxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CF8C4CEEB;
	Sun, 10 Aug 2025 08:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754815657;
	bh=q8SgtBm3Um6/IA3ICdzyzAhRe18cnxg4v20POkcefXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtooPbxvpMTQCvH7Y/f3jq8mtZ+j/O3aDgP+3ZDwN0u32EsCmn8yc0AKE1k/H2Z1k
	 PQcymiASqiWiA16/vCx1gQQcg7YHewbgB1Wc/5K7oo75w46ZkF91d1ycyvskavJO3D
	 tTpZsbR+PitArv7r2tRUUUeejD0YwLa6Fn1dABbPofZOU+eDQdZQoCUATiN+hpG58A
	 0xvnOYtqG67M2OJnB5cZipmABNVmRvYs5TIUnVYKQR+fkIAQjUtb7DtnWFi4aymBzu
	 Iuy8JCz+4B0EdnQsu2lU/uW4tHrpSpqnCISu7mnnhxzEGd2p7NGr1cq7nEuvnDpShT
	 eax2bwRzxDaDQ==
Date: Sun, 10 Aug 2025 10:47:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v5 00/13] Move fscrypt and fsverity info out of struct
 inode
Message-ID: <20250810-tortur-gerammt-8d9ffd00da19@brauner>
References: <20250810075706.172910-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250810075706.172910-1-ebiggers@kernel.org>

On Sun, Aug 10, 2025 at 12:56:53AM -0700, Eric Biggers wrote:
> This is a cleaned-up implementation of moving the i_crypt_info and
> i_verity_info pointers out of 'struct inode' and into the fs-specific
> part of the inode, as proposed previously by Christian at
> https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/
> 
> The high-level concept is still the same: fs/crypto/ and fs/verity/
> locate the pointer by adding an offset to the address of struct inode.
> The offset is retrieved from fscrypt_operations or fsverity_operations.
> 
> I've cleaned up a lot of the details, including:
> - Grouped changes into patches differently
> - Rewrote commit messages and comments to be clearer
> - Adjusted code formatting to be consistent with existing code
> - Removed unneeded #ifdefs
> - Improved choice and location of VFS_WARN_ON_ONCE() statements
> - Added missing kerneldoc for ubifs_inode::i_crypt_info
> - Moved field initialization to init_once functions when they exist
> - Improved ceph offset calculation and removed unneeded static_asserts
> - fsverity_get_info() now checks IS_VERITY() instead of v_ops
> - fscrypt_put_encryption_info() no longer checks IS_ENCRYPTED(), since I
>   no longer think it's actually correct there.
> - verity_data_blocks() now keeps doing a raw dereference
> - Dropped fscrypt_set_inode_info() 
> - Renamed some functions
> - Do offset calculation using int, so we don't rely on unsigned overflow
> - And more.
> 
> For v4 and earlier, see
> https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/
> 
> I'd like to take this series through the fscrypt tree for 6.18.
> (fsverity normally has a separate tree, but by choosing just one tree
> for this, we'll avoid conflicts in some places.)

Woh woh. First, I had a cleaned up version ready for v6.18 so if you
plan on taking over someone's series and resend then maybe ask the
author first whether that's ok or not. I haven't seen you do that. You
just caused duplicated work for no reason.

And second general infrastructure changes that touch multiple fses and
generic fs infrastructure I very much want to go through VFS trees.
We'll simply use a shared tree.

