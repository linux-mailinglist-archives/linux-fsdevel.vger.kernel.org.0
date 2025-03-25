Return-Path: <linux-fsdevel+bounces-45022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F55BA70330
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 15:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C602E189AE6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64E32580E2;
	Tue, 25 Mar 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCbpXa1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87C257ACF;
	Tue, 25 Mar 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911201; cv=none; b=Sv0s4c+HY5f3LH++FT68VbjHacNdUfgbMrtBc/LqpNs1ey1dUxpLq2CjhNwSWhQJ99zVMxWDlPQVNXNtAa3kSAIZmGPUqu+2Kq0Eptl7OAjNxtFGVptouyl9fiWC6G4gdju+l2qRkFsb+F4XKLUtAPhCXqUWhJUGV/k2Q8wyKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911201; c=relaxed/simple;
	bh=lJZXYZiR4HQG5j87rd/oFQOmLKxt2PFOJshchMR61d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTSumjwZfX1qFBZBnQFfu/39w9EdbsEPdocjemp938ZIXdH/LkBT+O1xYJYJMTzsHcXHHd+ZUuGgBZ4pOPZwE9llHaqc/7HRj1TRzuModMflPv1ZSu1wIRmB3r9bMUMQ9aBAi1l22bJwY4al0BuGCl60MdmQYalpaUKeGa910M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCbpXa1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50340C4CEE4;
	Tue, 25 Mar 2025 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742911201;
	bh=lJZXYZiR4HQG5j87rd/oFQOmLKxt2PFOJshchMR61d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCbpXa1O8Yj6Hh7dKDkc8Sd9AwtQSDeaMt0akk69E/2XjE6QIoNLksf151kNbRUXz
	 6pDIkXF2b5BNqxfjvICdUArSS2ZOf3mAkhtWb6mA335ndmnX2vrIVHxQu9lXszI38w
	 Kmgt1d7NWx4g5n+8hwOr35ytAhrxx4goFNdTyJLV4bV8+Fkh/M73g49gB7ZsY8whyH
	 Tkx1lTbJHFtMMH42y9mGNCn5rUVbjSS8xb26MAFaSeqe7hOvfcvRpYi62R73P9VX/7
	 2Fxza532w5/qwzNATTHIIWndyOtg7ZEdThJ+jp9aMY3nVUBfD8B8aGOpE4Pt4khsSs
	 J1ZQ6b8bE42JQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	NeilBrown <neilb@suse.de>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev
Subject: Re: [PATCH] cachefiles: Fix oops in vfs_mkdir from cachefiles_get_directory
Date: Tue, 25 Mar 2025 14:59:55 +0100
Message-ID: <20250325-nirgendwo-zugang-8e179ba0ac57@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250325125905.395372-1-marc.dionne@auristor.com>
References: <20250325125905.395372-1-marc.dionne@auristor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=brauner@kernel.org; h=from:subject:message-id; bh=lJZXYZiR4HQG5j87rd/oFQOmLKxt2PFOJshchMR61d4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/2naveHJLeWzE38Vs2xXeRdRFv+Z81ttf12V+he35f mmu/uvRHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPh4WD4Hzm95epi/ktbOIW/ z5Ptldm/reVV2cEFWafO7y02/7T0zAVGhi1MiTY86h4TjpT/+z1foH1u4WXz28KLDjuHyH24c1R AmQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 25 Mar 2025 09:59:05 -0300, Marc Dionne wrote:
> Commit c54b386969a5 ("VFS: Change vfs_mkdir() to return the dentry.")
> changed cachefiles_get_directory, replacing "subdir" with a ERR_PTR
> from the result of cachefiles_inject_write_error, which is either 0
> or some error code.  This causes an oops when the resulting pointer
> is passed to vfs_mkdir.
> 
> Use a similar pattern to what is used earlier in the function; replace
> subdir with either the return value from vfs_mkdir, or the ERR_PTR
> of the cachefiles_inject_write_error() return value, but only if it
> is non zero.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] cachefiles: Fix oops in vfs_mkdir from cachefiles_get_directory
      https://git.kernel.org/vfs/vfs/c/406fad7698f5

